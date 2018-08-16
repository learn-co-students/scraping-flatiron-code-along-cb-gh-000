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
     Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
  end
  
  def get_courses
    # coursesArray = []
    Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses')).css('article')
    # coursesArray
  end
  
  def make_courses
    get_courses.each{|course| 
      cours = Course.new
      cours.title = course.css('h2').text 
      cours.description = course.css('p').text 
      cours.schedule = course.css('.date').text
    }
  end
  
end



