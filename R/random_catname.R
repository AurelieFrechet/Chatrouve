#' Random Cat Name
#' @importFrom rjson fromJSON
#' @param language two strings character for cats' language name 
#'
#' @return character size 1
#' @export
random_catname <- function(language = "EN"){
  filepath <- paste0("inst/extdata/catnames_", language,".json")
  if (file.exists(filepath)) {
    cats_names<- fromJSON(file = filepath)
    return(sample(x = cats_names, size = 1))
  } else {
    message(paste("Language", language, "doesn't exist yet."))
    return(NULL)
  }
  
}