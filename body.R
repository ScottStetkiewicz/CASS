## intro ----------------------------------------------------------------------
source('introduction/intro.R', local=TRUE)
start <- tabItem(
  tabName = "start",
  start.box
)
## upload ----------------------------------------------------------------------
source('fileUpload/fileUpload.ui.R', local=TRUE)
upload <- tabItem(
  tabName = "upload",
  upload.box
)
## selDat ---------------------------------------------------------------------
source('selDat/selDat.ui.R', local=TRUE)
selDat <- tabItem(
  tabName = "selDat",
  selDat.box
)
## dend ------------------------------------------------------------
source('dend/dend.ui.R', local=TRUE)
dend <- tabItem(
  tabName = "dend",
  dend.box
)
## pca ------------------------------------------------------------
source('pca/pca.ui.R', local=TRUE)
pca <- tabItem(
  tabName = "pca",
  pca.box
)
## BODY ------------------------------------------------------------------------
body <- dashboardBody(
  tabItems(
    start,
    upload,
    selDat,
    dend,
    pca
  )
)
