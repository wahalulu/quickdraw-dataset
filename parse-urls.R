library(rvest)
library(tidyverse)
html_in <- read_html("https://storage.googleapis.com/quickdraw_dataset/")

keys <- html_in %>% html_nodes(xpath = "//key")

full <- grep("full/raw", keys, value = T)
fulldataurls <- sprintf("https://storage.googleapis.com/quickdraw_dataset/%s",
                        gsub("</?key>", "", full))
dataset_category <-
  gsub("</?key>|\\.ndjson|full/raw/", "", full)

meta <- tibble(category = dataset_category, url = fulldataurls)
write_csv(meta, "doodle-categories-urls.csv")
