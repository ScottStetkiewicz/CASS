selDat.pca <-reactive({
  X = as.matrix(selDat())
  CEN = scale(X, center = T, scale = T)
  pca <- robpca(CEN)
  pca
})

  observe({
    updateSelectizeInput(
      session,
      "variables",
      choices=names(INF()))
  })
  
  observe({
    updateSelectInput(
      session,
      "labNames",
      choices=c("None", names(INF())))
  })
  
  observe({
    updateSelectInput(
      session,
      "colVar",
      choices=c("None", names(INF()))
    )
  })
  
  observe({
    updateSelectInput(
      session,
      "shapeVar",
      choices=c("None", names(INF())))
  })
  
  inflabels <- reactive({
    features <- rownames(INF())
    if(input$rem) {
      features <- setdiff(features, input$toRm)
    }
    return(INF()[features, ])
  })
  
  infcol <- reactive({
    features <- rownames(INF())
    if(input$rem) {
      features <- setdiff(features, input$toRm)
    }
    return(INF()[features, ])
  })
  
  infshape <- reactive({
    features <- rownames(INF())
    if(input$rem) {
      features <- setdiff(features, input$toRm)
    }
    return(INF()[features, ])
  })
  
  labNames <- reactive({
    if (input$labNames=="None") {rep(NA,nrow(inflabels()))} else {inflabels()[ ,input$labNames]}
  })
  
  colVar <- reactive({
    if (input$colVar=="None") {rep(NA,nrow(infcol()))} else {infcol()[ ,input$colVar]}
  })
  
  shapeVar <- reactive({
    if (input$shapeVar=="None") {rep(NA,nrow(infshape()))} else {infshape()[ ,input$shapeVar]}
  })
  
  #PCA diagnostic
  # output$text<-renderPrint({labNames()})
  
  # selectedData <- reactive({
  #   data.frame(selDat()[input$variables])
  # })
  
  eig <- reactive({

    eig <- selDat.pca()$eigenvalues
    variance <- eig*100/sum(eig)
    cumvar <- cumsum(variance)
    eig.pca <- data.frame(Eigenvalues = eig, Variance = variance,
                          Cum.Variance = cumvar)
    eig.pca$Variance<-round(eig.pca$Variance, digits = 2)
    eig.pca$Eigenvalues<-round(eig.pca$Eigenvalues, digits = 2)
    eig.pca$Cum.Variance<-round(eig.pca$Cum.Variance, digits = 2)
    df<-rownames_to_column(eig.pca, var = "PC")
    df
  })
    
  observe({
    updateSelectInput(
      session,
      "axis1",
      choices=c("PC1","PC2","PC3","PC4","PC5"), selected = "PC1")
  })
  
  observe({
    updateSelectInput(
      session,
      "axis2",
      choices=c("PC1","PC2","PC3","PC4","PC5"), selected = "PC2")
  })
  
  output$scree <- renderPlot({

    ggplot(eig(),aes(x=PC,y=Variance)) + 
      geom_bar(colour="black", fill=rainbow_hcl(length(unique(eig()$PC))), width=.8,stat = "identity") +
      geom_point() +
      geom_line(aes(y=Variance,group=1,stat = "identity")) +
      geom_label(aes(label=paste(Variance,"%")),
                 position=position_dodge(width=0.9), vjust=-.15) +
      theme_bw() +
      labs(x = "Principal Components", y = "% of Variance")
  })
  
  output$printout <- renderDataTable({
    eig()
  })
  
  svd_comp <- reactive({
    
    cc1<-data.frame(selDat.pca()$scores)
    cc2<-data.frame(selDat.pca()$loadings)
    cc3<-data.frame(selDat.pca()$eigenvalues)
    cc1
  })
  
  svd_comp2 <- reactive({
    
    cc1<-data.frame(selDat.pca()$scores)
    cc2<-data.frame(selDat.pca()$loadings)
    cc3<-data.frame(selDat.pca()$eigenvalues)
    cc4<-cbind(selDat(),cc1)
    cc4
  })
  
  vector_arrows <- reactive({
    
    cc1<-data.frame(selDat.pca()$scores)
    cc2<-data.frame(selDat.pca()$loadings)
    cc3<-data.frame(selDat.pca()$eigenvalues)
    
    var_cor_func <- function(var.loadings, comp.sdev){
      var.loadings*comp.sdev
    }
    
    loadings <- selDat.pca()$loadings
    sdev <- selDat.pca()$eigenvalues
    var.coord <- var.cor <- t(apply(loadings, 1, var_cor_func, sdev))
    
    varcoordz1 <- (var.coord[,input$axis1])
    varcoordz2 <- (var.coord[,input$axis2])
    
    points <- data.frame(x = cc1[,input$axis1],
                         y = cc1[,input$axis2],
                         names = labNames(),
                         color = colVar(),
                         lab = rep(NA,nrow(cc1)),
                         symbol = shapeVar(),
                         type = rep("point", nrow(cc1)))
    
    arrows <- data.frame(x = varcoordz1,
                         y = varcoordz2,
                         names = rep(NA,nrow(cc2)),
                         color = "",
                         lab = row.names(cc2),
                         symbol = rep(NA,nrow(cc2)),
                         type = rep("arrow", nrow(cc2)))
    
    data1 <- rbind(points, arrows)
    data1
  })
  
  clusters <- reactive({
    kmeans(svd_comp(), input$clusters)
  })
  
  output$points_selected <- renderText(if (input$reset_input==TRUE) {NULL} else {input$selected_point})
  
  output$scatterPlot <- renderScatterD3({

    cc1<-data.frame(selDat.pca()$scores)
    cc2<-data.frame(selDat.pca()$loadings)
    cc3<-data.frame(selDat.pca()$eigenvalues)
    
    # getPalette <- colorRampPalette(brewer.pal(12, "Paired"))
    getPalette <- colorRampPalette(brewer.pal(9, "Set1"))
    df <- svd_comp()
    df2 <- svd_comp2()
    dfarrow <- vector_arrows()
    if(input$do) {df$cluster <- as.factor(clusters()$cluster)}
    
    tooltips <- paste0("<b>", df2[,3], "</b><br>",
                       df2[,1], "<br>")
    
    tooltips2 <- paste0("<b>", dfarrow$color, "</b><br>",
                        dfarrow$names, "<br>")
    
    if (input$do) {
      scatterD3(x = df[,1], y = df[,2],
                fixed = if (input$fixed==TRUE) {TRUE} else {FALSE},
                xlab=paste(input$axis1, sprintf('(%0.1f%% explained var.)', 
                                                100 * cc3[input$axis1,]/sum(cc3))), 
                ylab=paste(input$axis2, sprintf('(%0.1f%% explained var.)', 
                                                100 * cc3[input$axis2,]/sum(cc3))),
                tooltip_text = tooltips,
                point_opacity = 0.75,
                lasso = TRUE,
                lab = labNames(),
                labels_size = 0,
                hover_size = 4,
                ellipses = if (input$ellipse==TRUE) {TRUE} else {FALSE},
                ellipses_level = .75,
                hover_opacity = 1,
                col_var = df$cluster,
                col_lab = "Cluster",
                symbol_var = shapeVar(),
                symbol_lab = input$shapeVar,
                lasso_callback = "function(sel) {
                Shiny.onInputChange(
                'selected_point', sel.data().map(function(d)
                {return d.lab}).join('\\n')
                )
    }"
                )
  } else {
    scatterD3(data= dfarrow, x = x, y = y,
              type_var = dfarrow$type,
              fixed = if (input$fixed==TRUE) {TRUE} else {FALSE},
              xlab=paste(input$axis1, sprintf('(%0.1f%% explained var.)', 
                                 100 * cc3[input$axis1,]/sum(cc3))), 
              ylab=paste(input$axis2, sprintf('(%0.1f%% explained var.)', 
                                 100 * cc3[input$axis2,]/sum(cc3))),
              tooltip_text = tooltips2,
              lasso = TRUE,
              lab = lab,
              ellipses = if (input$ellipse==TRUE) {TRUE} else {FALSE},
              ellipses_level = .75,
              key_var = names,
              hover_size = 4,
              hover_opacity = 1,
              col_var = color,
              col_lab = input$colVar,
              colors = 
                if (length(unique(colVar())) <= 8) {c(rainbow_hcl(length(unique(colVar()))),"#000000")} 
              else 
              {c(getPalette(length(unique(colVar()))),"#000000")},
              symbol_var = symbol,
              symbol_lab = input$shapeVar,
              lasso_callback = "function(sel) {
            Shiny.onInputChange(
              'selected_point', sel.data().map(function(d)
              {return d.key_var}).join('\\n')
                              )
                            }"
    )
  }
})
