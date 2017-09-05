require 'nokogiri'
require 'open-uri'

html = open("https://flatironschool.com/")


doc = Nokogiri::HTML(html)

instructors = doc.css("#instructors .team-holder .person-box")
puts instructors
#puts doc.css(".s1").text
