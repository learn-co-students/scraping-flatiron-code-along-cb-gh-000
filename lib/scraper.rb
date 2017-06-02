require 'nokogiri'
require 'open-uri'
require 'pry'

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
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    Nokogiri::HTML(html)
  end
  def get_courses
    get_page.css('#course-grid .posts-holder .post')
  end
  def make_courses()
    doc = get_page
    courses = get_courses
    courses.each {|course|
      title = course.css("h2").text
      schedule = course.css("em.date").text
      description = course.css("p").text
      course_obj = Course.new
      course_obj.title = title
      course_obj.schedule = schedule
      course_obj.description = description
    }
  end
end
