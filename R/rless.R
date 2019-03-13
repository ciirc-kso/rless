#' Parse LESS content to CSS
#'
#' paragraph
#'
#' description
#' description
#'
#' @param code text to be converted in LESS format
#' @examples
#' parse_less('.button { .red{ collor: red}}')
#' parse_less('@red: red; .red{ collor: @red}')
#' @return converted text to CSS
#'
#' @export
parse_less <- function(code) {
    get_v8_console()$call("rlessParse", code, "output")
    output
}


#' Converts content of file to CSS
#'
#' Passes content of file_name into V8 console and converts it using LESS function into
#' valid css. The css is returned
#'
#' @param base_path Base path to file to be converted
#' @param file_name Path relative to \code{base_path} leading to file to be converted
#' @param output_folder Output path where converted file should be placed.
#' Files is placed to \code{tempdir} by default

#' @return Path to create CSS file
#'
#' @examples
#' \dontrun{
#' convert_file('path/to/less', 'file.less')
#' convert_file('path/to/less', 'file.less', 'path/to/css')
#' }
#'
#' @export
convert_file <- function(base_path, file_name, output_folder = tempdir()) {
    full_path <- file.path(base_path, file_name)
    if (!file.exists(full_path)) {
        stop("Invalid file name")
    }
    
    if (!dir.exists(output_folder)) {
        stop("Output folder does not exist")
    }
    
    file_content <- readChar(full_path, file.info(full_path)$size)
    
    write_to_file(parse_less(file_content), gsub("\\..*$", ".css", file_name), 
        output_folder)
}

#' Converts files in folder to CSS files
#'
#'
#'
#' @param input_folder Path to files to be converted
#' @param output_folder Output path where converted files should be placed
#' Files are placed to \code{tempdir} by default
#' @param recursive Boolean value used when searching for filed to be converted
#' @param pattern Pattern which files need to match to be converted
#'
#' @return Paths to converted CSS files
#'
#' @examples
#' \dontrun{
#' convert_folder('path/to/less')
#' convert_folder('path/to/less', 'path/to/css')
#' convert_folder('path/to/less', recursive = TRUE)
#' convert_folder('path/to/less, pattern = '*.css$')
#'}
#' @export
convert_folder <- function(input_folder, output_folder = tempdir(), recursive = FALSE, 
    pattern = "*.less$") {
    
    if (!dir.exists(input_folder)) {
        stop("Input folder does not exist")
    }
    
    if (!dir.exists(output_folder)) {
        stop("Output folder does not exist")
    }
    
    # Load source LESS files
    sources <- list.files(input_folder, pattern = pattern, full.names = FALSE, 
        ignore.case = TRUE, recursive = recursive)
    
    # Convert less to css
    sapply(sources, function(name) {
        convert_file(input_folder, name, output_folder)
    })
}
