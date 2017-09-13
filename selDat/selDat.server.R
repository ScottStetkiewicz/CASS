selDat <- reactive({
  features <- rownames(INF())
  features2 <- colnames(INF())
  if(input$rem) {
    features <- setdiff(features, input$toRm)
  }
  if(input$rem2) {
    features2 <- setdiff(features2, input$toRm2)
  }
  return(INF()[features, features2])
})

# selDat<-reactiveValues(df_data = NULL)
# 
# observeEvent(input$file1, {
#   selDat$df_data <- read.csv(input$file1$datapath)
# })

# observeEvent(input$rem, {
#   temp <- selDat$df_data[-input$toRm, ]
#   selDat$df_data <- temp
# })

# observeEvent(input$rem2, {
#   temp2 <- selDat$df_data[, -input$toRm2]
#   selDat$df_data <- temp2
# })

# observe({
#   features<-rownames(selDat())
#   features2<-colnames(selDat())
#   if(input$rem) {features<-setdiff(features,input$toRm)}
#   if(input$rem2) {features2<-setdiff(features2,input$toRm2)}
#   return(selDat()[features,features2])
# })

output$selDat <- renderDataTable({
  selDat()
})

output$condPanel1 <- renderUI({
  conditionalPanel(
    condition = "input.rem == true",
    selectInput('toRm', NULL,
                choices=sort(rownames(INF())),
                multiple=TRUE)
  )
})

output$condPanel2 <- renderUI({
  conditionalPanel(
    condition = "input.rem == true",
    selectInput('toRm2', NULL,
                choices=sort(colnames(INF())),
                multiple=TRUE)
  )
})