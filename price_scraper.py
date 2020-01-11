from bs4 import BeautifulSoup as soup
from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver

def get_current_price(url):

    price = None
    sale = None

    # grab page source
    try:
        browser = webdriver.Chrome(ChromeDriverManager().install())
        browser.get(url)
        source_code = browser.page_source
        browser.close()
        page = soup(source_code, "html.parser")

    except Exception as e: # if something fails, just return the error
        return ("error", e)

    # find price and sale information
    price_tag = page.find_all("div", class_ = "product-price")
    if price_tag:
        raw_price = price_tag[0].text
        price = raw_price.replace("\n", " ").replace("\xa0", " ").strip()

    sale_tag = page.find("span", class_ = "ecm-messaging")
    if sale_tag:
        sale = sale_tag.text

    return (price, sale)