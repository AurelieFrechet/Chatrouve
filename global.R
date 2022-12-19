
# Libraries ---------------------------------------------------------------
library(magrittr)
library(shiny)
library(glue)
library(shinyMobile)
library(shinyWidgets)
library(shinyjs)
library(R.utils)
library(stringr)


# Functions --------------------------------------------------------------

sourceDirectory("functions")

# parameters --------------------------------------------------------------


fluffy   <- c("yes", "no")
size     <- c("kitten", "small", "normal", "massive")
behavior <- c("shy", "friendly", "aggressive", "frightened", "bitchy", "uninterested")

pattern <- data.frame(
  name = c("solid",
             "van",
             "bicolor",
             "pointed",
             "calico",
             "tortoiseshell",
             "mackerel tabby",
             "ticked tabby",
             "classic tabby",
             "spotted tabby"),
  number = c(1,
             2,
             2,
             2,
             3,
             3,
             2,
             2,
             2,
             2)
)

eyes_color <- data.frame(
  name = c("yellow",
           "green",
           "blue",
           "orange",
           "brown"),
  
  color = c("#e8f064",
            "#00dc72",
            "#24d4f9",
            "#fbbb27",
            "#dc9604")
)

coat_color <- data.frame(
  name = c("white",
           "blue",
           "cream",
           "cinnamon",
           "red",
           "chocolate",
           "gray",
           "black"),
  
  color = c("#f3f0f0",
            "#b3c0c8",
            "#ddc2b7",
            "#e5aa8c",
            "#b3503b",
            "#785654",
            "#555459",
            "#030303")
)


# Data base



