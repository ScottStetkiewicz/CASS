INF <- reactive({
  inFile <- input$file1
  if (is.null(inFile)) {
    return(NULL)
  }
  dat <- read.csv(inFile$datapath, header=input$header, sep=input$sep, check.names=TRUE)
  rownames(dat) <- make.names(dat[,1], unique=TRUE)
  return(dat)
})

output$inputfile <- renderDataTable({
  INF()
})