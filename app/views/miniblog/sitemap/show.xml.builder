xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  @posts.each do |post|
    xml.url do
      xml.loc miniblog.post_url(id: post.to_param)
      xml.lastmod post.updated_at.to_s(:miniblog_sitemap)
    end
  end
end
