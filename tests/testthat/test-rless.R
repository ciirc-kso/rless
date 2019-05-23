# Created by: Jonas Vaclavek
# Modified by: Jonas Vaclavek
# Modify date: 23.5.2019
# Description: tests of rless functions

context("test-rless")

# path to temp test output folder
test_out_path <- file.path("..", "test_out")
# path to test files
test_data_path <- file.path("..", "test_data")


# Function executed after each test
# Make cleanup after each tests as some tests may polute the testing environment
after_test_cleanup <-
  function() {
    if (dir.exists(paths = test_out_path)) {
      unlink(x = test_out_path, recursive = TRUE)
    }
  }

# Function executed before each test
# Prepares the testing environment
before_test_init <-
  function() {
    unlink(x = test_out_path, recursive = TRUE)
    dir.create(path = test_out_path)
  }

#
test_that("parse_less - simple less returns correct css", {
  before_test_init()

  expect_equal(object = parse_less(code = ".button { .red{ collor: red}}"),
               expected = ".button .red {\n  collor: red;\n}\n")

  expect_equal(object = parse_less(code = "@red: red; .red{ collor: @red}"),
               expected = ".red {\n  collor: red;\n}\n")

  after_test_cleanup()
})

test_that("convert_file - new file is created after function execution", {
  before_test_init()

  expect_false(object = file.exists(file.path(test_out_path, "test.css")))

  expect_silent(
    object = convert_file(
      base_path = test_data_path,
      file_name = "test.less",
      output_folder =  test_out_path
    )
  )

  expect_true(object = file.exists(file.path(test_out_path, "test.css")))

  after_test_cleanup()
})

test_that("convert_file - error is thrown when invalid file path is provided",
          {
            before_test_init()

            expect_error(
              object = convert_file(base_path = "",
                                    file_name = "non_existing_file_name"),
              regexp = "Invalid file name"
            )

            expect_error(
              object = convert_file(test_data_path,
                                    "test.less",
                                    "invalid_folder_name"),
              regexp = "Output folder does not exist"
            )

            after_test_cleanup()
          })

test_that("convert_folder -
          number of converted files matches number of files in source folder",
          {
            before_test_init()

            expect_false(object = file.exists(file.path(test_out_path,
                                                        "test.css")
                                              )
                         )

            convert_folder(
              input_folder = test_data_path,
              output_folder = test_out_path,
              recursive = FALSE
            )
            expect_true(object = file.exists(file.path(test_out_path,
                                                       "test.css")
                                             )
                        )

            # R dir returns also names of folders in non recursive mode
            input_folder_paths <- dir(path = test_data_path)
            output_folder_paths <- dir(path = test_out_path)

            # therefore folders are excluded
            input_only_files <-
              rownames(x = input_folder_paths)[file_test(op = "-f",
                                                         x =  input_folder_paths)]
            output_only_files <-
              rownames(x = output_folder_paths)[file_test(op = "-f",
                                                          x =  output_folder_paths)]
            # and number of files in boths sets compared
            expect_equal(object = length(x = input_only_files),
                         expected = length(x = output_only_files))

            after_test_cleanup()
          })

test_that("convert_folder - error is thrown when invalid input or output folders
          are provided",
          {
            before_test_init()

            expect_error(
              object = convert_folder(input_folder = "non_existing_input_folder",
                                      output_folder = test_out_path),
              regexp = "Input folder does not exist"
            )

            expect_error(
              object = convert_folder(input_folder = test_data_path,
                                      output_folder = "non_existing_output_folder"),
              regexp = "Output folder does not exist"
            )

            after_test_cleanup()
          })

test_that("convert_folder - pattern matching - function filters out only valid
          files",
          {
            before_test_init()

            expect_false(object = file.exists(file.path(test_out_path,
                                                        "test.css")
                                              )
                         )

            convert_folder(input_folder = test_data_path,
                           output_folder =  test_out_path,
                           pattern = ".css")
            expect_false(object = file.exists(file.path(test_out_path,
                                                        "test.css")
                                              )
                         )

            convert_folder(input_folder = test_data_path,
                           output_folder =  test_out_path,
                           pattern = ".less")
            expect_true(object = file.exists(file.path(test_out_path,
                                                       "test.css")
                                             )
                        )

            after_test_cleanup()
          })

test_that(
  "convert_folder - recursive flag - number of converted files matches
  number of files in source folder even in recursive flag is on",
  {
    before_test_init()

    expect_false(object = file.exists(file.path(test_out_path, "test.css")))

    convert_folder(input_folder = test_data_path,
                   output_folder = test_out_path,
                   recursive = TRUE)
    expect_true(object = file.exists(file.path(test_out_path, "test.css")))

    expect_true(
      object = file.exists(file.path(test_out_path,
                                     "recursion_test",
                                     "test.css")
                           )
      )

    expect_equal(
      object = length(x = list.files(path = test_data_path, recursive = TRUE)),
      expected = length(x = list.files(path = test_out_path, recursive = TRUE)))

    after_test_cleanup()
  }
)
