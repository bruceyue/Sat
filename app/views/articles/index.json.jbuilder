json.array!(@articles) do |article|
  json.extract! article, :subject, :body, :is_published, :picture
  json.url article_url(article, format: :json)
end
