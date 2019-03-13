get_v8_console <- function() {
    # Initiate V8 engine
    console <- V8::v8(global = "window")
    # Load LESS library into V8
    console$source(system.file("extdata", LESS_JS_FILENAME, package = PACKAGE_NAME))
    # Load RLESS JS into V8
    console$source(system.file("extdata", RLESS_JS_FILENAME, package = PACKAGE_NAME))
    
    console
}

# Takes text and writes it into temporary file in the output folder Full
# path to the file is returned
write_to_file <- function(content, file_path, output_folder) {
    base_name <- basename(file_path)
    dir.create(file.path(output_folder, gsub(base_name, "", file_path, fixed = TRUE)), 
        showWarnings = FALSE)
    output_file_name <- file.path(output_folder, file_path)
    write(content, output_file_name)
    
    output_file_name
}
