## 错误处理
tryIE <- function(code, silent=F){
  tryCatch(code, error = function(c) '错误: 请仔细检查输入的参数是否合理。',
           warning = function(c) '错误: 请仔细检查输入的参数是否合理。',
           message = function(c) '错误: 请仔细检查输入的参数是否合理。')
  }
shinyServer(
  function(input, output) {    

    ################################################概率类指标###################################################    
    
    numlift_prop_test <- reactive({
      switch(input$lift_prop_test,"1%"=0.01,"5%" =0.05,
             "10%" = 0.10,"15%"=0.15,"20%"=0.20, "50%"=0.50, "100%"=1.00)
    })
    numsif_prop_test <- reactive({
      switch(input$sif_prop_test,"80%"=0.80,"85%" =0.85,
             "90%" = 0.90,"95%"=0.95)
    })
    
    texttime_unit_prop_test <- reactive({
      switch(input$time_unit_prop_test, "日"="每日","周"="每周",
             "月"="每月","年"="每年")
    })
    
    textperiod_prop_test <- reactive({
      switch(input$period_prop_test, "日"="日","周"="周",
             "月"="月","年"="年")
    })
    
    number_prop_test <- reactive({ceiling(power.prop.test(p1=input$avgRR_prop_test/100,
                                                          p2=input$avgRR_prop_test/100*(1+input$lift_prop_test/100),
                                                          sig.level=1-numsif_prop_test(), 
                                                          power=0.8)[[1]])
    })
    
    output$liftText_prop_test <- renderText({
      paste('如果实验组指标为', 
            as.character(input$avgRR_prop_test*(1+input$lift_prop_test/100)),'% 或更高的话，',
            '我们才可以观测到统计显著性结果。'
      )
    })
    
    output$resulttext1_prop_test <- renderText({ 
      "每组的样本量为 "
    })
    
    output$resultvalue1_prop_test<-renderText({
     
      tryIE(number_prop_test())
    })
    
    output$resulttext2_prop_test <- renderText({ 
      "总样本量为"
    })
    
    output$resultvalue2_prop_test <- renderText({

      tryIE(number_prop_test()*input$num_prop_test)
      
    })
    
    output$resulttext3_prop_test <- renderText({ 
      paste('需要得到总样本量的时间大约是', 
            as.character(tryIE(floor(number_prop_test()*input$num_prop_test/input$imps_prop_test))), 
            '到',
            as.character(tryIE(ceiling(number_prop_test()*input$num_prop_test/input$imps_prop_test))),
            as.character(textperiod_prop_test())
      )
    })

    output$resulttext4_prop_test <- renderText({ 
      paste('为了得到总样本量所需要的', 
            as.character(texttime_unit_prop_test()),
            '的流量为', 
            as.character(tryIE(ceiling(number_prop_test()*input$num_prop_test/input$time_prop_test)))
      )
    })
    


    ################################################均值类指标###################################################    
    

    numlift_t_test <- reactive({
      switch(input$lift_t_test,"1%"=0.01,"5%" =0.05,
             "10%" = 0.10,"15%"=0.15,"20%"=0.20, "50%"=0.50, "100%"=1.00)
    })
    numsif_t_test <- reactive({
      switch(input$sif_t_test,"80%"=0.80,"85%" =0.85,
             "90%" = 0.90,"95%"=0.95)
    })
    
    texttime_unit_t_test <- reactive({
      switch(input$time_unit_t_test, "日"="每日","周"="每周",
             "月"="每月","年"="每年")
    })
    
    textperiod_t_test <- reactive({
      switch(input$period_t_test, "日"="日","周"="周",
             "月"="月","年"="年")
    })
    
    
    number_t_test <- reactive({ceiling(power.t.test(delta=input$lift_t_test,
                                                    sd=input$sd_t_test,
                                                    sig.level=1-numsif_t_test(), 
                                                    power=0.8)[[1]])
    })
    
    output$liftText_t_test <- renderText({
      paste('如果两组指标的绝对差值为', 
            as.character(input$lift_t_test),'或者更大的话,',
            '我们才可以观测到统计显著性结果。'
      )
    })
    
    output$resulttext1_t_test <- renderText({ 
      "每组的样本量为 "
    })
    
    output$resultvalue1_t_test<-renderText({
      
      tryIE(number_t_test())
    })
    
    output$resulttext2_t_test <- renderText({ 
      "总样本量为"
    })
    
    output$resultvalue2_t_test <- renderText({
      
      tryIE(number_t_test()*input$num_t_test)
      
    })
    
    output$resulttext3_t_test <- renderText({ 
      paste('需要得到总样本量的时间大约是', 
            as.character(tryIE(floor(number_t_test()*input$num_t_test/input$imps_t_test))), 
            '到',
            as.character(tryIE(ceiling(number_t_test()*input$num_t_test/input$imps_t_test))),
            as.character(textperiod_t_test())
      )
    })
    
    output$resulttext4_t_test <- renderText({ 
      paste('为了得到总样本量所需要的', 
            as.character(texttime_unit_t_test()),
            '的流量为', 
            as.character(tryIE(ceiling(number_t_test()*input$num_t_test/input$time_t_test)))
      )
    })
    
    
  })
