require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  attr_accessor :doc

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def make_courses
    self.get_courses.each do |course_html|
      course = Course.new()
      course.title = course_html.css("h2").text
      course.schedule = course_html.css(".date").text
      course.description = course_html.css("p").text
    end
  end

  def get_courses
    self.get_page.css(".post")
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
