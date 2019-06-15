# Created by: Jonas Vaclavek
# Modified by: Jonas Vaclavek
# Modify date: 15.6.2019
# Description: function for converting a folder with less files to css files

#' Converts files in folder to CSS files
#'
#' Function goes through folder specified in \emph{input_folder} and finds files
#' matching the \emph{pattern}. If \emph{recursive} is set to TRUE, scanner
#' are also subdirectories of the \emph{input_folder}. Matching files are
#' converted using \code{\link{convert_file}} function.
#'
#' @param input_folder Path to files to be converted
#' @param output_folder Output path where converted files should be placed
#' Files are placed to \code{tempdir} by default
#' @param recursive Boolean value used when searching for filed to be converted
#' @param pattern Pattern which files need to match to be converted
#'
#' @return List of file paths to converted files is returned
#'
#' @examples
#' path_to_less_files <- system.file("extdata", package="rless")
#'
#' convert_folder(path_to_less_files)
#' convert_folder(path_to_less_files, tempdir())
#' convert_folder(path_to_less_files, recursive = TRUE)
#' convert_folder(path_to_less_files, pattern = '*.css$')
#'
#' @export
convert_folder <-
  function(input_folder,
           output_folder = tempdir(),
           recursive = FALSE,
           pattern = "*.less$") {

    if (!dir.exists(paths = input_folder)) {
      stop("Input folder does not exist")
    }

    if (!dir.exists(paths = output_folder)) {
      stop("Output folder does not exist")
    }

    # Load source LESS files
    sources <- list.files(path = input_folder,
                          pattern = pattern,
                          full.names = FALSE,
                          ignore.case = TRUE,
                          recursive = recursive)

    # Convert less to css
    sapply(sources,
           function(name) {
             convert_file(base_path = input_folder,
                          file_name = name,
                          output_folder = output_folder
             )
           })
  }
