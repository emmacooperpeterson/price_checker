# Price Checker
### Send myself a daily price email so I can see when an item is on sale


* `price_scraper.py` - scrape URL to find price and sale information (currently only set up for West Elm)
* `run_price_scraper.R` – run `price_scraper.py` and send myself an email with the results

I use the following cron job to run this daily at 3pm:

`0 15 * * * cd ~/my/path/to/price_checker && /usr/local/bin/Rscript run_price_scraper.R >> cronlog.log 2>&1`
