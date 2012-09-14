module Refinery
  module Calendar
    module CalendarHelper
      def calendar(date = Date.today, &block)
        Calendar.new(self, date, block).table
      end

       class Calendar < Struct.new(:view, :date, :callback)
         HEADER = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
         START_DAY = :sunday

         delegate :content_tag, to: :view

         def table
           content_tag :table, class: "calendar" do
             header + week_rows
           end
         end

         def header
           content_tag :tr do
             HEADER.map{ |day| content_tag :th, day }.join.html_safe
           end
         end

         def week_rows
           weeks.map do |week|
             content_tag :tr do
               week.map{ |day| day_cell(day) }.join.html_safe
             end
           end
         end

         def day_classes(day)
           classes = []
           classes << "today" if day == Date.today
           classes << "notmonth" if day.month != date.month
           classes.empty? ? nil : classes.join("")
         end

       end


    end
  end
end
