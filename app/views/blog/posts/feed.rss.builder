xml.instruct! :xml, :version => "1.0" 
xml.rss :version => '2.0', "xmlns:content" => "http://purl.org/rss/1.0/modules/content/", "xmlns:wfw" => "http://wellformedweb.org/CommentAPI/", "xmlns:dc" => "http://purl.org/dc/elements/1.1/", "xmlns:atom" => "http://www.w3.org/2005/Atom", "xmlns:sy" => "http://purl.org/rss/1.0/modules/syndication/", "xmlns:slash" => "http://purl.org/rss/1.0/modules/slash/"  do
  xml.channel do
    xml.title "Efreesen's Blog"
    xml.author "Caio Torres"
    xml.description "A recursive Blog, wrote to explain how it was built."
    xml.link posts_url
    xml.language "en"

    for post in @posts
      xml.item do
        xml.title post.title
        xml.tag! 'content:encoded' do
          xml.cdata! sanitize(post.content)
        end
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post.slug
      end
    end
  end
end
