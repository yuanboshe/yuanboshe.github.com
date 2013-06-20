include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::LinkTo

#dates helper
def url_for_date(year, month)
  if month.nil?
    "/blog/#{year}.html"
  else
    "/blog/#{year}/#{'%02d' % month}.html"
  end
end

def all_dates
  dates = OrderedHash.new
  for item in sorted_articles
    date = item[:created_at]
    if dates[date.year] == nil
      dates[date.year] = { :num => 1 }
    else
      dates[date.year][:num] += 1
    end
    months = dates[date.year]
    if months[date.month] == nil
      months[date.month] = 1
    else
      months[date.month] += 1
    end
  end
  dates
end

def articles_with_year_and_month(year, month)
  articles = []
  unless month.nil?
    articles = sorted_articles.select{|i| year == i[:created_at].year && month == i[:created_at].month}
  else
    articles = sorted_articles.select{|i| year == i[:created_at].year}
  end
  articles
end

#tags helper
def url_for_tag(tag)
  "/blog/tags/#{tag}.html"
end

def tags_for_article(article)
  tags = []
  article[:tags].each { |tag| tags << link_to(tag, url_for_tag(tag)) }
  tags
end

def all_tags
  tags = []
  sorted_articles.each do |item|
    next if item[:tags].nil?
    item[:tags].each { |tag| tags << tag }
  end
  tags.uniq
end

def articles_with_tag(tag)
  sorted_articles.select{|a| a[:tags].include?(tag) rescue false }
end