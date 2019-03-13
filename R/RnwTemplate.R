insertRnwTemplate <- function() {
  rstudioapi::setDocumentContents("",id=getSourceEditorContext()$id)
  x <- readLines(system.file('template/rnw_template',package = "a9ukey"))
  title_idx <- which(grepl("^\\\\title",x))[1]
  xx <- paste(x,collapse = "\n")
  rstudioapi::insertText( "\n" ,location = rstudioapi::document_position(0,0))
  rstudioapi::insertText( xx ,location = rstudioapi::document_position(0,0))
  if(!is.na(title_idx))
    #rstudioapi::insertText( "" ,location = rstudioapi::document_position(title_idx,7))
    rstudioapi::setCursorPosition( rstudioapi::document_position(title_idx,8))
}

# editor <-  getSourceEditorContext()
# editor.id <- editor$id
# editor.range <- editor$selection[[1]]$range
