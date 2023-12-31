# Usage:
# 1) install dependencies `bundle install`
# 2) ruby random-art-from-asciiart.eu.rb

require 'watir'

# Setup Webdriver and navigate to the website
browser = Watir::Browser.new :firefox, headless: true 
browser.goto 'https://www.asciiart.eu'

# Define the JavaScript functions
select_random_div_with_xpath_js = <<-JS
  function selectRandomDivWithXPath() {
    var xpathExpression = "//div[@class='directory-columns']//ul/li";
    var items = document.evaluate(xpathExpression, document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
    var randomIndex = Math.floor(Math.random() * items.snapshotLength);
    return items.snapshotItem(randomIndex).querySelector('a').href;
  }
  return selectRandomDivWithXPath();
JS

get_random_pre_text_js = <<-JS
  function getRandomPreText() {
    var xpathExpression = "//*[contains(concat(' ', normalize-space(@class), ' '), ' border-header ') and contains(concat(' ', normalize-space(@class), ' '), ' border-top ') and contains(concat(' ', normalize-space(@class), ' '), ' p-3 ')]";
    var parents = document.evaluate(xpathExpression, document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
    var randomParentIndex = Math.floor(Math.random() * parents.snapshotLength);
    var randomParent = parents.snapshotItem(randomParentIndex);
    var preElement = randomParent.querySelector('pre');
    return preElement ? preElement.textContent : null;
  }
  return getRandomPreText();
JS

# Execute the first JavaScript function to get the href and navigate
first_href = browser.execute_script(select_random_div_with_xpath_js)
browser.goto first_href

# Execute the second JavaScript function to get the second href and navigate
second_href = browser.execute_script(select_random_div_with_xpath_js)
browser.goto second_href

# Execute the third JavaScript function to get the text content
ascii_art_text = browser.execute_script(get_random_pre_text_js)

# Output the ASCII art text
puts ascii_art_text

# Close the browser
browser.close

