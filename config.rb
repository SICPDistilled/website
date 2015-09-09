require 'dotenv'
Dotenv.load

require "lib/deploy"

activate :directory_indexes

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

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :s3_deploy
  activate :asset_hash

  activate :cdn do |cdn|
    cdn.cloudflare = {
      zone: 'sicpdistilled.com',
      base_urls: [
        'https://www.sicpdistilled.com'
      ]
    }
  end
end
