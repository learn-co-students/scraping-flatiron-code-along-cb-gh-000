require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  #uses Nokogiri and open-uri to grab the entire HTML document from the web page
  def get_page
    # doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    self.get_page.css(".post")  #returns the collection of course offerings
  end

  # instantiating Course objects and giving each course object the correct title, schedule and description
  def make_courses
      self.get_courses.each do |post| #iterate through the collection of course offerings
        course = Course.new
        course.title = post.css("h2").text
        course.schedule = post.css(".date").text
        course.description = post.css("p").text
      end
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end

# Scraper.new.get_page
Scraper.new.print_courses
