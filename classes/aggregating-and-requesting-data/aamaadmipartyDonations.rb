require 'watir-webdriver'

browser = Watir::Browser.new :chrome

browser.goto 'https://donate.aamaadmiparty.org/Report/Donation_List.aspx'

puts browser.table(:class, 'mGrid').html

10000.times do |n|
  	browser.link(:text =>"Next").click
	puts browser.table(:class, 'mGrid').html
end