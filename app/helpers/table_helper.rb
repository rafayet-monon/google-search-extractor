module TableHelper
  def column(content, options = {})
    content_tag :td, content, options
  end

  def table_for(collection, headers, options = {})
    content_tag :table, options do
      concat (
               content_tag :thead do
                 content_tag :tr do
                   headers.map do |header|
                     concat(content_tag :th, header)
                   end
                 end
               end
             )

      concat (
               content_tag :tbody do
                 collection.map do |obj|
                   concat (content_tag :tr do
                     capture { yield obj }
                   end)
                 end
               end
             )
    end
  end
end
