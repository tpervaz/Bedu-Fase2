#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Postwork Sesion 2 - Programación y manipulación de datos con R

# Equipo 23
# Francisco Ricardo Arredondo Almuina - frankk_arredondo@hotmail.com
# Tamara Ytanyu Pérez Vázquez - tamara.ytanyu@gmail.com
# Carlos Eduardo Vidal Villeda - charlie.lalo@hotmail.com
# Jesus Emanuel Serrano Molina - emanuel.serm@gmail.com


library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    pageWithSidebar(
        headerPanel("Postwork 8"),
        sidebarPanel(
            
            ## conditionalPanel() functions for selected tab
            conditionalPanel(condition="input.tabselected==1",
                             radioButtons("choice","Choose an option", 
                                          choices=c("Local" = 1, 
                                                    "Visitante" = 2)
                             )
            ),
            conditionalPanel(condition="input.tabselected==2",
                             radioButtons("choice2","Choose an option", 
                                          choices=c("P. Marginal Local" = 1, 
                                                    "P. Marginal Visitante" = 2,
                                                    "P. Conjunta Local y Visitante" = 3)
                             )
            ),
            conditionalPanel(condition="input.tabselected==4",
                             radioButtons("choice3","Choose an option", 
                                          choices=c("Max" = 1, 
                                                    "Min" = 2)
                             )
            )
        ),
        mainPanel(
            # recommend review the syntax for tabsetPanel() & tabPanel() for better understanding
            # id argument is important in the tabsetPanel()
            # value argument is important in the tabPanle()
            tabsetPanel(
                tabPanel("Goles de local y visitante",
                         value=1,
                         conditionalPanel(condition="input.choice==1", 
                                          plotOutput("plot")),
                         conditionalPanel(condition="input.choice==2",
                                          plotOutput("plot2"))
                         
                ),
                tabPanel("Imagenes graficas postwork 3", 
                         value=2, 
                         conditionalPanel(condition="input.choice2==1", 
                                          img( src = "Rplot.png", 
                                               height = 600, width = 900)),
                         conditionalPanel(condition="input.choice2==2", 
                                          img( src = "Rplot01.png", 
                                               height = 600, width = 900)),
                         conditionalPanel(condition="input.choice2==3", 
                                          img( src = "Rplot02.png", 
                                               height = 600, width = 900))
                ),
                
                tabPanel("Data Table",
                         value=3,
                         dataTableOutput("data_table")),
                
                tabPanel("Imagenes máximos y mínimos", 
                         value=4, 
                         conditionalPanel(condition="input.choice3==1", 
                                          img( src = "G1.png", 
                                               height = 600, width = 900)),
                         conditionalPanel(condition="input.choice3==2", 
                                          img( src = "G2.png", 
                                               height = 600, width = 900))
                ),
                
                id = "tabselected"
            )
        )
    )
    
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    library(ggplot2)
    frecFTAG<-readRDS("~/BEDU/Sesion 8. Dashboards con Shiny - Entorno GUI/Post/Postwork/data/frecFTAG.rds")
    frecFTHG<-readRDS("~/BEDU/Sesion 8. Dashboards con Shiny - Entorno GUI/Post/Postwork/data/frecFTHG.rds")
    matchdata<-readRDS("~/BEDU/Sesion 8. Dashboards con Shiny - Entorno GUI/Post/Postwork/data/matchdata.rds")
    output$plot <- renderPlot({
        ggplot(frecFTHG, aes(x=frecFTHG[,'No.Goles'],y=frecFTHG[,"Goles"], fill=frecFTHG[,'No.Goles'])) +
            geom_bar(stat = "identity") +
            xlab("No.Goles") +
            ylab("Goles")+
            ggtitle("Frecuencia de goles para equipo local")+
            # theme_bw()+
            theme(plot.title = element_text(hjust = 0.5))+
            labs(fill="No. Goles")
    })
    output$plot2 <- renderPlot({
        ggplot(frecFTAG, aes(x=frecFTAG[,'No.Goles'],y=frecFTAG[,"Goles"], fill=frecFTAG[,'No.Goles'])) +
            geom_bar(stat = "identity") +
            xlab("No.Goles") +
            ylab("Goles")+
            ggtitle("Frecuencia de goles para equipo visitante")+
            # theme_bw()+
            theme(plot.title = element_text(hjust = 0.5))+
            labs(fill="No. Goles") +
            facet_wrap("No.Goles")
    })
    
    
    output$data_table <- renderDataTable(matchdata, 
                                         options = list(aLengthMenu = c(5,25,50),
                                                        iDisplayLength = 5))
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
