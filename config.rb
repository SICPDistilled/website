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

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
