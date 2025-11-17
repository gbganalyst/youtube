############################################################
# AI HELPERS IN R: chores, buggy, ensure


#############################
# 0. SETUP: INSTALL & LOAD
#############################

install.packages("chores")
install.packages("ensure")  
pak::pak("simonpcouch/buggy")
install.packages("testthat")
library(testthat)

library(ellmer)
library(chores)
library(ensure)
library(buggy)


#############

#testthat → “Tool for writing automatic tests.”

#roxygen2 → “Tool for generating documentation from comments.”

#cli → “Tool for making readable, pretty console messages.”


# Testthat EXAMPLE 1 — Convert old tests to modern testthat (3rd edition)
add <- function(x, y) x + y

library(testthat)

test_that("add works", {
  result <- add(1, 2)
  expect_equal(result, 3)
})


# Keeps your package up to date with testthat best practices.


#Roxygen EXAMPLE 2 — Generate roxygen documentation for a function

add_three <- function(x) {
  x + 3
}

#Documentation is often neglected; chores makes it instant and consistent.

#cli EXAMPLE 3 — Convert printed messages to cli style

message("Reading file...")
print("Done!")

