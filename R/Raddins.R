insertRnwTemplate <- function() {
  library(rstudioapi)
  x <- readLines(system.file('template/rnw_template',package = "a9ukey"))
  title_idx <- which(grepl("^\\\\title",x))[1]
  xx <- paste(x,collapse = "\n")
  # clean document context
  setDocumentContents("",id=getSourceEditorContext()$id)

  # insert template
  insertText( "\n" ,location = document_position(0,0))
  insertText( xx ,location = document_position(0,0))

  # set cursor position
  if(!is.na(title_idx))
    setCursorPosition( document_position(title_idx,8))
}

insertSection.preamble <- function(){
  library(rstudioapi)
  text.preamble <- "
\\usepackage{color, soul, hyperref, geometry, fontspec, newtxtext}
\\usepackage{graphicx,enumitem}
\\usepackage[punct=kaiming, fontset=adobe, zihao=-4, scheme=plain, space=auto, linespread=1.3,]{ctex}

\\geometry{left=10mm,right=10mm, bottom=25mm}
\\hypersetup{colorlinks=true}

\\setlength\\parindent{0pt}

\\newcommand{\\hlchn}[1]{\\textcolor[rgb]{1,0.75,0}{#1}}
\\newcommand{\\hlarg}[1]{\\hlkwc{#1}}
\\newcommand{\\hlcst}[1]{\\hlkwa{#1}}
\\newcommand{\\hlvar}[1]{\\hlstd{#1}}
\\newcommand{\\hlfun}[1]{\\hlkwd{#1}}

\\title{faq tikz }
\\author{asepsiswu@gmail.com}
\\date{modified on \\today{} \\\\ created on {%s}}
"
  text.preamble <-  sprintf(text.preamble,date())

  # insert template at current postion
  insertText( text.preamble, id = getSourceEditorContext()$id)

  editor.content <- getSourceEditorContext()$contents

  # set cursor position to title
  title.idx <- which(grepl("^\\\\title",editor.content))[1]
  if(!is.na(title.idx)) setCursorPosition( document_position(title.idx,8))
}


insertSection.knitr <- function(){
  library(rstudioapi)
 text.knitr <- "
<<knitr_opts, include=FALSE>>=
  library(knitr)
  opts_chunk$set(echo = TRUE,warning = FALSE, message = FALSE, cache = TRUE)
  custom_inline = function(x) {
    if (is.numeric(x)) return(knitr:::format_sci(x, 'latex'))
    x <- highr:::hi_latex(x) ;
    x <- gsub(pattern='\\\\$', replacement='\\\\\\\\$', x)
  }
  knit_hooks$set(inline = custom_inline)
@
  "
 insertText( text.knitr, id = getSourceEditorContext()$id)
}

cleanSweaveTmp <- function(){
  suffix <- c(".log", ".pdf", ".synctex.gz", ".tex")
  files <- dir(pattern = "\\.[rR][nN][wW]$")
  files <- tools::file_path_sans_ext(files)
  files <- as.vector(outer(files,suffix,paste0))
  suppressWarnings(tmp <- file.remove(files))
}
