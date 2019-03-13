context("test-rless")


test_out_path <- file.path("..", "test_out")
test_data_path <- file.path("..", "test_data")


after_test_cleanup <- function() {
    if (dir.exists(test_out_path)) {
        unlink(test_out_path, recursive = TRUE)
    }
}

before_test_init <- function() {
    unlink(test_out_path, recursive = TRUE)
    dir.create(test_out_path)
    
}

test_that("parse_less works", {
    expect_equal(parse_less(".button { .red{ collor: red}}"), ".button .red {\n  collor: red;\n}\n")
    expect_equal(parse_less("@red: red; .red{ collor: @red}"), ".red {\n  collor: red;\n}\n")
})

test_that("convert_file works - happy day scenario", {
    before_test_init()
    expect_false(file.exists(file.path(test_out_path, "test.css")))
    expect_silent(convert_file(test_data_path, "test.less", test_out_path))
    expect_true(file.exists(file.path(test_out_path, "test.css")))
    after_test_cleanup()
})

test_that("convert_file returns error", {
    before_test_init()
    expect_error(convert_file("", "non_existing_file_name"), "Invalid file name")
    expect_error(convert_file(test_data_path, "test.less", "invalid_folder_name"), 
        "Output folder does not exist")
    after_test_cleanup()
    
})

test_that("convert_folder works - happy day scenario", {
    before_test_init()
    expect_false(file.exists(file.path(test_out_path, "test.css")))
    convert_folder(test_data_path, test_out_path)
    expect_true(file.exists(file.path(test_out_path, "test.css")))
    after_test_cleanup()
})

test_that("convert_folder returns error", {
    before_test_init()
    expect_error(convert_folder("non_existing_input_folder", test_out_path), 
        "Input folder does not exist")
    expect_error(convert_folder(test_data_path, "non_existing_output_folder"), 
        "Output folder does not exist")
    after_test_cleanup()
    
})

test_that("convert_folder pattern works - happy day scenario", {
    before_test_init()
    expect_false(file.exists(file.path(test_out_path, "test.css")))
    convert_folder(test_data_path, test_out_path, pattern = ".css")
    expect_false(file.exists(file.path(test_out_path, "test.css")))
    after_test_cleanup()
})

test_that("convert_folder recursive works - happy day scenario", {
    before_test_init()
    expect_false(file.exists(file.path(test_out_path, "test.css")))
    convert_folder(file.path(test_data_path, ".."), test_out_path, recursive = TRUE)
    expect_true(file.exists(file.path(test_out_path, "test_data", "test.css")))
    after_test_cleanup()
})

