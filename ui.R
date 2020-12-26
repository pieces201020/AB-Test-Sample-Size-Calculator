
shinyUI(fluidPage(
  titlePanel(title=div(img(src="图标.png", height = '80px', width = '650px')),windowTitle = "A/B测试样本量计算器"),
  navbarPage("指标类型",
  ################################################概率类指标###################################################    
             tabPanel("概率类指标",
## 参数输入
  fluidRow(
    column(3, wellPanel(
      h4("为你的测试输入合适的参数:"),
      numericInput("avgRR_prop_test", label = "原始指标", value = 5,
                   min = 0, step=1),
      helpText("一般是对照组的指标（比如转化率，点击率等概率类指标），也就是没有变化时的指标，从历史数据中分析计算得出。"
      ),
      helpText("例如：如果原始指标为5%, 输入5。"
      ),
      hr(),
      numericInput("lift_prop_test", label = "最小可检测相对提升", value = 10,
                   min = 0, step=1),
      helpText("最小可检测相对提升指的是通过A/B测试可以检测到指标最小的相对提升,如果最小可检测相对提升为10%，输入10"
      ),
      helpText("例如：如果原始指标为5%，只有当实验组指标提升到6%时你才决定是实施A/B测试中的改变，那么此时的最小可检测相对提升就是20% ((6% - 5%) / 5%)。"
      ),
      helpText("最小可检测相对提升越高，需要的样本量就越小。"
      ),
      textOutput("liftText_prop_test"),
      hr()
    )),
    
##  分组数量板块      
    column(4, wellPanel(  
      numericInput("num_prop_test", label = "分组总数", value = 2),
      helpText("输入A/B测试中的分组总数, 包括对照组。"
      ),
      helpText("例如：如果A/B测试有1个对照组和1个实验组，输入2。（假设每组样本量相等）"
      ),
      hr()
    )),

##  置信水平板块      
    column(4,wellPanel(
      radioButtons("sif_prop_test", label = "置信水平",
                   choices = list("80%","85%","90%","95%"),
                   selected = "95%",inline=T),
      helpText("置信水平为1-α，例如：当α=5%时，置信水平=95%"
      ),
      helpText("推荐的置信水平: 95%."
      ),
      helpText("置信水平越高，需要的样本量也越大。"
      ),
      hr()
    )),

##  结果板块      
    mainPanel(
      tabsetPanel(
        tabPanel("结果",
                 br(),
                 textOutput("resulttext1_prop_test"),
                 verbatimTextOutput("resultvalue1_prop_test"),
                 textOutput("resulttext2_prop_test"),
                 verbatimTextOutput("resultvalue2_prop_test")
        ),
        tabPanel("测试时间 (测试流量固定)",
                 br(),
                 numericInput("imps_prop_test", label = "每个周期的流量", value=10000),
                 helpText("输入每个周期内可用于测试的流量"
                 ),
                 radioButtons("period_prop_test", label = "周期单位",
                              choices = list("日","周","月","年"),
                              selected ="周",inline=T),
                 helpText("请选择合适的周期单位"
                 ),
                 textOutput("resulttext3_prop_test")
                
        ),
        tabPanel("测试流量 (测试时间固定)",
                 br(),
                 numericInput("time_prop_test", label = "时间长度", value=7),
                 helpText("输入你有多长时间可以用来进行A/B测试"
                 ),
                 radioButtons("time_unit_prop_test", label = "时间单位",
                              choices = list("日","周","月","年"),
                              selected ="日",inline=T),
                 helpText("请选择合适的时间单位"
                 ),
                 textOutput("resulttext4_prop_test")
                 
        ),
        tabPanel("使用案例",
                 br(),
                 helpText("概率类指标案例"),
                 helpText("我们想要测试新的推送内容，旧推送内容有5%的点击率，对于这次测试，我们想要在95%的置信水平上至少获得10%的相对提升。"),
                 helpText("输入："),
                 helpText("原始转化率: 5%"),
                 helpText("分组总数: 2"),
                 helpText("最小可检测相对提升：10%"),
                 helpText("置信水平： 95%"),
                 helpText("输出："),
                 helpText("每组需要的样本量： 31234,
                           总样本量： 62468."),
                 br(),
                 uiOutput("tutorial_tab_prop_test")
                 )
      )
    )
    )),
  ################################################均值类指标###################################################    
  ## 参数输入
  tabPanel("均值类指标",
  fluidRow(
    column(3, wellPanel(
      h4("为你的测试输入合适的参数:"),
      numericInput("sd_t_test", label = "标准差", value = 10,
                   min = 0, step=0.1),
      helpText("指标的标准差，从历史数据中分析计算得出。"
      ),
      hr(),
      numericInput("lift_t_test", label = "最小可检测绝对提升", value = 0.5,
                   min = 0, step=0.1),
      helpText("最小可检测相对提升指的是通过A/B测试可以检测到指标最小的绝对提升"
      ),
      helpText("例如：如果对照组的指标均值为2，只有当实验组指标均值提升到2.5，那么此时最小可检测相对提升就为0.5（2.5-2）."
      ),
      helpText("最小可检测绝对提升越高，需要的样本量就越小。"
      ),
      textOutput("liftText_t_test"),
      hr()
    )),
    ## 分组数量板块
    column(4, wellPanel(  
      numericInput("num_t_test", label = "分组总数", value = 2),
      helpText("输入A/B测试中的分组总数, 包括对照组。"
      ),
      helpText("例如：如果A/B测试有1个对照组和1个实验组，输入2。（假设每组样本量相等）"
      ),
      hr()
      )),
    ## 置信水平板块
    column(4,wellPanel(
      radioButtons("sif_t_test", label = "置信水平",
                   choices = list("80%","85%","90%","95%"),
                   selected = "95%",inline=T),
      helpText("置信水平为1-α，例如：当α=5%时，置信水平=95%"
      ),
      helpText("推荐的置信水平: 95%."
      ),
      helpText("置信水平越高，需要的样本量也越大。"
      ),
      hr()
      )),
    ## 结果板块
    mainPanel(
      tabsetPanel(
        tabPanel("结果",
                 br(),
                 textOutput("resulttext1_t_test"),
                 verbatimTextOutput("resultvalue1_t_test"),
                 textOutput("resulttext2_t_test"),
                 verbatimTextOutput("resultvalue2_t_test")
        ),
        tabPanel("测试时间 (测试流量固定)",
                 br(),
                 numericInput("imps_t_test", label = "每个周期的流量", value=10000),
                 helpText("输入每个周期内可用于测试的流量"
                 ),
                 radioButtons("period_t_test", label = "周期单位",
                              choices = list("日","周","月","年"),
                              selected ="周",inline=T),
                 helpText("请选择合适的周期单位"
                 ),
                 textOutput("resulttext3_t_test")
                 
        ),
        tabPanel("测试流量 (测试时间固定)",
                 br(),
                 numericInput("time_t_test", label = "时间长度", value=7),
                 helpText("输入你有多长时间可以用来进行A/B测试"
                 ),
                 radioButtons("time_unit_t_test", label = "时间单位",
                              choices = list("日","周","月","年"),
                              selected ="日",inline=T),
                 helpText("请选择合适的时间单位"
                 ),
                 textOutput("resulttext4_t_test")
                 
        ),
        tabPanel("使用案例",
                 br(),
                 helpText("均值类指标案例"),
                 helpText("我们想要测试应用商店里新的游戏推荐算法对用户下载后一周的平均花费是否有提升，经计算指标的标准差为15，我们想要在95%的置信水平上至少获得0.5块钱的绝对提升。"),
                 helpText("输入："),
                 helpText("指标的标准差: 15"),
                 helpText("分组总数: 2"),
                 helpText("最小可检测绝对提升：0.5"),
                 helpText("置信水平：95%"),
                 helpText("输出："),
                 helpText("每组需要的样本量：14129,
                          总样本量：28258."),
                 br(),
                 uiOutput("tab_t_test")
                 )
        )
      )
      ))
))
)
