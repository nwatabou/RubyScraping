require 'bundler/setup'
require 'nokogiri'
require 'open-uri'
require 'csv'

url = 'http://www.aneikankou.co.jp/timetables'
charset = 'utf-8'
route_titles = []
route = []
time = []

html = open(url) do |f|
    charset = f.charset
    f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)
doc.xpath('//div[@class="route"]/table').each do |table|
    p table.xpath('preceding-sibling::h2[1]').inner_text

    table.xpath('tr').each do |table_value|
        table_value.xpath('th').each do |route_title|
            p route_title.inner_text
        end
        table_value.xpath('td[@class="time"]').each do |route_time|
            p route_time.inner_text
            p route_time.xpath('following-sibling::td[@class="check circle"]').inner_text
        end
    end
end

# doc.xpath('//div[@class="route"]/table').each do |table|
#     p table.xpath('preceding-sibling::h2[1]').inner_text
#     p table.xpath('/tr/th').inner_text
#     p table.xpath('/tr/td[@class="time"]').inner_text
# end



# doc.xpath('//div[@class="route"]/table/tr/td').each do |node|
#     time = node.inner_text
#     p time
# end

# CSV.open("route.csv", "w") do |csv|
#     csv << titles
# end