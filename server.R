server <- function(input, output, session) {
  ## upload ---------------------------------------------------------
  source('fileUpload/fileUpload.server.R', local=TRUE)
  ## selDat ---------------------------------------------------------
  source('selDat/selDat.server.R', local=TRUE)
  ## dend -----------------------------------------------------------
  source('dend/dend.server.R', local=TRUE)
  ## pca ------------------------------------------------------------
  source('pca/pca.server.R', local=TRUE)
}