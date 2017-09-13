observe({
  updateSelectInput(
    session,
    "dendlabels",
    choices=c("None", names(INF()))
  )
})

observe({
  updateSelectInput(
    session,
    "dendcolor",
    choices=c("None", names(INF()))
    )
})

observe({
  updateSelectInput(
    session,
    "dendshape",
    choices=c("None", colnames(INF()))
  )
})

#kclust <- reactive({
#  kmeans(selDat(), kCount())
#})

#output$ktable <- renderPrint({
#  kclust()
#})

branchesWidth <- reactive({input$brancheswidth})
labelSize <- reactive({input$labelsize})
leafSize <- reactive({input$leafsize})
kCount <- reactive({input$kcount})

dark2 = c("#1B9E77", "#D95F02", "#7570B3", "#E7298A", "#66A61E", "#E6AB02", "#A6761D", "#666666") 
kCol <- reactive({colorRampPalette(dark2)(input$kcount)})

INF6 <- reactive({
  features <- rownames(INF())
  if(input$rem) {
    features <- setdiff(features, input$toRm)
  }
  return(INF()[features, input$dendshape])
})
#isnt synced with reactivity##
inputShape2 <- reactive({as.numeric(INF6())})

INF4 <- reactive({
  features <- rownames(INF())
  if(input$rem) {
    features <- setdiff(features, input$toRm)
  }
  return(INF()[features, input$dendlabels])
})

INF5 <- reactive({
  features <- rownames(INF())
  if(input$rem) {
    features <- setdiff(features, input$toRm)
  }
  return(INF()[features, input$dendcolor])
})

dendcol <- reactive({as.numeric(INF5())})

legend_val <- reactive({levels(INF5())})

output$dend <- renderPlot({
  numb2 <- dendcol()
  numb <- length(unique(numb2))
  d <- dist(selDat(), method = input$distMethod)
  dend.hclust <- hclust(d, method = input$clustMethod)
  dend <- as.dendrogram(dend.hclust)
  ishap2 <- reactive({if (input$dendshape=="None") {c(15)} 
    else {inputShape2()[order.dendrogram(dend)]}})
  labels(dend) <- if (input$dendlabels=="None") {NULL} 
    else {paste(INF4()[order.dendrogram(dend)])}
  colors_to_use <-
    if (input$dendcolor=="None") {c("black")}
    else {rainbow_hcl(numb)[sort_levels_values(
      dendcol()[order.dendrogram(dend)]
    )]
    }
  
#  leg_type <- rep("FR02", length(rownames(MP)))
#  is_x <- grepl("FR03", MP$Feature)
#  leg_type[is_x] <- "FR03"
#  is_x <- grepl("FR05", MP$Feature)
#  leg_type[is_x] <- "FR05"
#  is_x <- grepl("FS02", MP$Feature)
#  leg_type[is_x] <- "FS02"
#  leg_type <- factor(leg_type)
#  n_leg_types <- length(unique(leg_type))
#  cols_4 <- rainbow_hcl(n_leg_types)[sort_levels_values(
#    dendcol()[order.dendrogram(dend)]
#  )]
#  cols_4 <- unique(cols_4)
#  col_leg_type <- cols_4[leg_type]
  
  output$lv <- renderPrint({colors_to_use})
  
  dend2 <- dend %>% 
    set("branches_lwd", branchesWidth()) %>%
    set("labels_cex", labelSize()) %>% 
    set("leaves_pch", ishap2()) %>% 
    set("leaves_cex", leafSize()) %>% 
    set("leaves_col", c(colors_to_use)) 
  dend2 %>% plot
  if(input$kbox) 
  # {dend2 %>% set("branches_k_color", k=input$kcount, c(kCol())) %>% plot}
  {dend2 %>% set("branches_k_color", k=input$kcount) %>% plot}
  if(input$horiz) {dend2 %>% plot(horiz = TRUE)}
  if(input$kbox && input$horiz) {dend2 %>% set("branches_k_color", k=input$kcount) %>% plot(horiz = TRUE)}
#  legend("topleft", legend = legend_val(), fill=unique(colors_to_use))
})
######################################################################
#################################################3
output$downdend <- downloadHandler(
  filename=function() {
    paste("CASS Dend",input$format,sep="")
  },
  content=function(file){
    if(input$format ==".png")
      png(file) #, width=980, height=980, units="px", pointsize = 12)
    else if(input$format ==".jpeg")
      jpeg(file, width=980, height=980, units="px", pointsize = 12, quality=100)
    else if(input$format ==".tiff")
      tiff(file, width=980, height=980, units="px", pointsize = 12, compression="lzw")
    else if(input$format ==".pdf")
      cairo_pdf(file)
    else (input$format ==".eps")
    cairo_ps(file)
    numb2 <- dendcol()
    numb <- length(unique(numb2))
    d <- dist(selDat(), method = input$distMethod)
    dend.hclust <- hclust(d, method = input$clustMethod)
    dend <- as.dendrogram(dend.hclust)
    ishap2 <- reactive({if (input$dendshape=="None") {c(15)} 
      else {inputShape2()[order.dendrogram(dend)]}})
    labels(dend) <- if (input$dendlabels=="None") {NULL} 
    else {paste(INF4()[order.dendrogram(dend)])}
    colors_to_use <-
      if (input$dendcolor=="None") {NULL}
    else {rainbow_hcl(numb)[sort_levels_values(
      dendcol()[order.dendrogram(dend)]
    )]
    }
    
    #  leg_type <- rep("FR02", length(rownames(MP)))
    #  is_x <- grepl("FR03", MP$Feature)
    #  leg_type[is_x] <- "FR03"
    #  is_x <- grepl("FR05", MP$Feature)
    #  leg_type[is_x] <- "FR05"
    #  is_x <- grepl("FS02", MP$Feature)
    #  leg_type[is_x] <- "FS02"
    #  leg_type <- factor(leg_type)
    #  n_leg_types <- length(unique(leg_type))
    #  cols_4 <- rainbow_hcl(n_leg_types)[sort_levels_values(
    #    dendcol()[order.dendrogram(dend)]
    #  )]
    #  cols_4 <- unique(cols_4)
    #  col_leg_type <- cols_4[leg_type]
    
    output$lv <- renderPrint({colors_to_use})
    
    dend2 <- dend %>% 
      set("branches_lwd", branchesWidth()) %>%
      set("labels_cex", labelSize()) %>% 
      set("leaves_pch", ishap2()) %>% 
      set("leaves_cex", leafSize()) %>% 
      set("leaves_col", c(colors_to_use)) 
    dend2 %>% plot
    if(input$kbox) 
    {dend2 %>% set("branches_k_color", k=input$kcount, c(kCol())) %>% plot}
    if(input$horiz) {dend2 %>% plot(horiz = TRUE)}
    if(input$kbox && input$horiz) {dend2 %>% set("branches_k_color", k=input$kcount, c(kCol())) %>% plot(horiz = TRUE)}
    #  legend("topleft", legend = legend_val(), fill=unique(colors_to_use))
    dev.off()
  })