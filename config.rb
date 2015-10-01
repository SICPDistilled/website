require 'dotenv'
Dotenv.load

activate :directory_indexes

set :haml, { ugly: true, format: :html5 }

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true,
               layout_engine: :haml,
               layout: :layout,
               no_intra_emphasis: true,
               footnotes: true

configure :development do
  activate :livereload
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'www.sicpdistilled.com'
  s3_sync.region                     = 'eu-west-1'
  s3_sync.delete                     = false
  s3_sync.after_build                = true
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.prefix                     = ''
  s3_sync.version_bucket             = false
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash

end

activate :cdn do |cdn|
  cdn.cloudflare = {
    email: 'thattommyhall@gmail.com',
    zone: 'sicpdistilled.com',
    base_urls: [
      'http://www.sicpdistilled.com'
    ]
  }
end

after_s3_sync do |files_by_status|
  cdn_invalidate(files_by_status[:updated])
end


# ready do
#   # proxy "/section/welcome", "/index.html"
#   %w[0.1 1.1 1.2 2.1 2.2.4].each do |id|
#     ['', '/'].each do |slash|
#       proxy "/slides/#{id}#{slash}", "/presentation.html", layout: false do
#         @id = id
#         @content = File.read("slides/#{id}.md")
#       end
#     end
#   end
# end
