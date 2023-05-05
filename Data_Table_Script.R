
#===============================================================================
# Data tables with R
#===============================================================================

### using DT and KableExtra

# There are 2 packages in R that are really amazing when it comes to data-frames, DT and Kable. DT provides somewhat of an interactive view, and kable allows you to add colors, subtitles, format text and foot notes.
 
# If you have a presentation for a project, these 2 packages can definitely add something special!
   
# Using kable
#===============================================================================

   
# kable() is a very useful function for creating nicely formatted tables from dataframes in R. 
# It is easy to use and provides many formatting options to customize the appearance of the table.
 
# While kable() is a function from the knitr package itself, KableExtra is a separate package that extends the functionality of kable() by adding new features such as:
   
# Advanced formatting options, such as adding footnotes, column highlighting, and color schemes
# Functions to add and format table captions, headers, and footers
# Tools for creating HTML, LaTeX, and Word documents with custom styles
 
install.packages("kableExtra")
library(kableExtra)
 
# Once loaded, you can use the kable() function as usual, but with additional formatting options provided by kableExtra.
 
# Using DT
# DT provides an interactive data table that can be easily customized and formatted with a variety of features, such as:
   
# Sorting, filtering, and searching capabilities Pagination and dynamic row/column display
# Ability to display large data sets without slowing down performance
# Customization appearance with themes, colors, styles With DT, you can easily create interactive and responsive data tables that allow for efficient exploration and analysis of large datasets.
 

install.packages("DT")
library(DT)

# It’s worth noting that kable uses piping “%>%”.
 
# If you’d like to know more about piping, please have a look at my article below:
   
#   Piping with R
# What is Piping ?
#   medium.com

# What I’ll cover here
# I’m going to get some data into R studio, and create several examples with both packages.
 
# Let’s get started

# ===========================================
# My setup
# ===========================================
 
library(knitr)
library(tidyverse)
library(DT)
library(kableExtra)

opts_chunk$set(fig.width=9, 
               fig.height=6, 
               fig.path="Figures/", 
                out.width="100%")

opts_chunk$set(comment="", 
               fig.align="center" , 
               fig.retina=2)
 
data <- read.csv("https://raw.githubusercontent.com/NicJC/ukflights/main/uk_flights.csv")

# I like using skimr to check out the status of my data. You don’t need a library call, simply skimr::skim(dataset)
 
skimr::skim(data)
 
# This gives me a good view of the data, missing values, data-type etc.
 
# Kable
#===============================================================================

# load kable via “library(kableExtra)”:
   
kable(head(data))
 
# I run head(dataframe) which will normally give me the first 6 rows, but I wrap it in kable.
 
# I decided to make the dataframe smaller for easier viewing:
   
df <- data %>% select(c(1:2,4,8,11))

# We can change font sizes:

kable(df) %>%
  kable_styling(font_size = 30)

# Foot note

kable(head(df,8)) %>%
  kable_styling("striped") %>%
  add_footnote("Footnote")

# Colors via rowspec and column_spec

kable(head(df,8)) %>%
  kable_styling(full_width = TRUE, position = "right") %>%
  column_spec(c(1,3,5), bold = T, color = "purple") %>%
  column_spec(c(2,4), italic = T, color = "blue") %>%
  row_spec(0,bold = T,font_size = 25 , color = "white", background = "black" )

# Header groups

kable(head(df,8), caption = "Colored Table[read the note]") %>%
  kable_styling(full_width = TRUE, position = "right") %>%
  add_header_above(c(" ", "Group 1[read the note]" = 2,
                     "Group 2[read the note]" = 2)) %>%
  column_spec(c(1,3,5), bold = T, color = "darkcyan") %>%
  column_spec(c(2,4), italic = T, color = "green") %>%
  row_spec(0,bold = T,font_size = 25 , color = "black",
           background = "darkgrey" )

# Bold and italic

kable(head(df,8)) %>%
  kable_styling(full_width = TRUE, position = "center") %>%
  column_spec(c(1,3,5), bold = T) %>%
  column_spec(c(1), italic = T) %>%
  row_spec(0,bold = T,font_size = 25 , color = "white",
           background = "steelblue" )
 

# load DT via “library(DT)”:

# ==============================================================================

# The basic table
dt <- datatable(df)
dt

# Paging though a table
# ==============================================================================
# We can change the pagination parameters
# datatable(df, options = list(paging = TRUE, pageLength = 7))

# Searching
datatable(df,
          class = 'cell-border stripe',
          rownames = FALSE,
          style = 'bootstrap',
          options = list(
            columnDefs = list(list(className = 'df-center', targets = "_all")),
            rowCallback = JS("function(nRow, aData, iDisplayIndex, iDisplayIndexFull){
              if(aData[1] == 'Jane'){
                $('td', nRow).css('background-color', 'lightblue');
              }
            }")
          )
)

# A colored footnote

datatable(df,caption = htmltools::tags$caption(
  style = 'caption-side: bottom; text-align: center;color: darkorange;',
  'Table: ', htmltools::em('UK Flights')
)
)

# Two pretty amazing packages.
# ==============================================================================

# Conclusion

# I’ve gone through a few examples here to get you started. 
# There’s various styles in DT like ‘bootstrap4’, ‘auto’, ‘default’, and ‘bootstrap5’ . 
# With column and row_spec in kable, you’re able to change the rows’ colors and styles.

# Check out ?kableExtra in R, and https://rstudio.github.io/DT/plugins.html should be quite helpful too.