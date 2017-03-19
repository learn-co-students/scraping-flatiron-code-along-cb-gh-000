require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
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

  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    doc = self.get_page
    doc.css(".post")
  end

  def make_courses
    courses = self.get_courses
    courses.each do |course|
      cur_course = Course.new
      cur_course.title = course.css("h2").text
      cur_course.schedule = course.css(".date").text
      cur_course.description = course.css("p").text
    end
  end
  
end



