library(reticulate)
library(gmailr)
library(glue)


# gmailr credentials setup
gm_auth_configure(path = "price_checker_creds.json")

# source the python file that scrapes for the current price
source_python("price_scraper.py")


# function to send myself an email containing the current price and sale status
send_notification <- function(item_name, info) {
  
  email <-  
    gm_mime() %>%
    gm_to("emmacooperpeterson@gmail.com") %>%
    gm_from("emmacooperpeterson@gmail.com") %>%
    gm_subject(glue("Price Check: {item_name}"))
  
  if (info[[1]] == "error") {
    email <-
      email %>%
      gm_text_body(info[[2]])

  } else {
    price <- info[[1]]
    sale <- info[[2]]
    message <- paste0(price, sale)
    
    email <-
      email %>%
      gm_html_body(message)
  }

  gm_send_message(email)
}


# run python file and send email
item_name <- "West Elm Anton Bed"
url <- "https://www.westelm.com/products/anton-bed-h4426/?pkey=cbeds&isx=0.0.8294"
info <- get_current_price(url)
send_notification(item_name, info)





