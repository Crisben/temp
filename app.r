library(shiny)
library(xts)
library(dplyr)
library(highcharter)
load(url("https://raw.githubusercontent.com/Crisben/RC-MCCTH/master/buses1.rdata"))
# data$`Fecha de Ingreso` <- as.Date(as.character(data$`Fecha de Ingreso`))
# data$Servicio <- as.character(data$Servicio)
# 
# i <- grep("ublic",x =data$Servicio)
# data[i,c("Servicio")] <- "Publico"
# i <- grep("UBLIC",x =data$Servicio)
# data[i,c("Servicio")] <- "Publico"

# resumen <- group_by(data, `Fecha de Ingreso`) %>% summarize(Registros=n(), Cooperativa=length(unique(Cooperativa)))
# xts <- xts(resumen[, -1], order.by=as.POSIXct(resumen$"Fecha de Ingreso"))
# 
# highchart(type = "stock") %>%
#   hc_title(text = "Registros diarios") %>%
#   hc_subtitle(text = "Numero de registros y cooperativas") %>%
#   hc_add_series(xts$Registros, name = "Registros") %>%
#   hc_add_series_xts(xts$Cooperativa, name = "Cooperativas")

ui <- fluidPage(
  
  # Application title
  titlePanel("ANT"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("fecha", "Seleccine el periodo", 
                     start = min(data$`Fecha de Ingreso`),
                     end = max(data$`Fecha de Ingreso`),
                     min = min(data$`Fecha de Ingreso`),
                     max=max(data$`Fecha de Ingreso`)),
      selectInput("cat", "Seleccione la categoria", 
                  choices = unique(data$Marca)),
      actionButton("act", "Actualizar")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Grafico",
                 highchartOutput2("graf")
        ),
        tabPanel("Resumen",
                 dataTableOutput("resumen")
        ),
        tabPanel("Detalle",
                 dataTableOutput("tabla")
        )
      )
    )
  )
)
  
  # Define server logic required to draw a histogram
  server <- function(input, output) {
    
    data1 <- eventReactive(input$act,{
      data %>% filter(`Fecha de Ingreso`>input$fecha[1] & 
                        `Fecha de Ingreso`<input$fecha[2]) %>% 
        filter(Marca==input$cat)
    })
    
    output$tabla <- renderDataTable({
      data1()
    })
    
    output$resumen <- renderDataTable({
      data1() %>%  
        group_by(Servicio) %>% summarize(N=n())
    })
    
    output$graf <- renderHighchart2({
      resumen <- group_by(data1(), `Fecha de Ingreso`) %>% summarize(Registros=n(), Cooperativa=length(unique(Cooperativa)))
      xts <- xts(resumen[, -1], order.by=as.POSIXct(resumen$"Fecha de Ingreso"))
      
      # resumen <- group_by(data, `Fecha de Ingreso`) %>% summarize(Registros=n(), Cooperativa=length(unique(Cooperativa)))
      # xts <- xts(resumen[, -1], order.by=as.POSIXct(resumen$"Fecha de Ingreso"))
      # 
      
      highchart(type = "stock") %>%
        hc_title(text = "Registros diarios") %>%
        hc_subtitle(text = "Numero de registros y cooperativas") %>%
        hc_add_series(xts$Registros, name = "Registros") %>%
        hc_add_series_xts(xts$Cooperativa, name = "Cooperativas")    

    })
    
    
    
    
    
    
  }
  
  # Run the application 
  shinyApp(ui = ui, server = server)
  
  
