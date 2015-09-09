require "lib/deploy"

activate :directory_indexes

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true,
               layout_engine: :haml,
               layout: :layout,
               no_intra_emphasis: true,
               footnotes: true

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :s3_deploy
  activate :asset_hash

  activate :cdn do |cdn|
    cdn.cloudflare = {
      # default ENV['CLOUDFLARE_CLIENT_API_KEY']
      # default ENV['CLOUDFLARE_EMAIL']
      zone: 'sicpdistilled.com',
      base_urls: [
        'https://www.sicpdistilled.com'
      ]
    }
  end
  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
