# Created by: Jonas Vaclavek
# Modified by: Jonas Vaclavek
# Modify date: 23.5.2019
# Description: function for converting single less file to css

#' Converts content of file to CSS
#'
#' Passes content of \emph{file_name} into V8 console and converts it using LESS
#' engine to CSS. The converted CSS is saved into \emph{output_folder} under
#' original name. Only the extension is switched to \emph{css}.
#'
#' @param base_path Base path to file to be converted
#' @param file_name Path relative to \code{base_path} leading to file to be converted
#' @param output_folder Output path where converted file should be placed.
#' File is placed to \code{tempdir} by default

#' @return Full path to created file with converted CSS file
#'
#' @examples
#' \dontrun{
#' convert_file('path/to/less', 'file.less')
#' convert_file('path/to/less', 'file.less', 'path/to/css')
#' }
#'
#' @export
convert_file <-
  function(base_path, file_name, output_folder = tempdir()) {

    full_path <- file.path(base_path, file_name)

    if (!file.exists(full_path)) {
      stop("Invalid file name")
    }

    if (!dir.exists(paths = output_folder)) {
      stop("Output folder does not exist")
    }

    file_content <- readChar(full_path, file.info(full_path)$size)

    write_to_file(parse_less(file_content),
                  gsub("\\..*$", ".css",    file_name),
                  output_folder)
  }
