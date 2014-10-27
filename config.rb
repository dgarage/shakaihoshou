require 'bootstrap-sass'

##css内のスプライト画像生成時に生成されたファイル名パスに自動的に付けられるハッシュ文字列を削除する
## Make a copy of sprites with a name that has no uniqueness of the hash.
# on_sprite_saved do |filename|
#   if File.exists?(filename)
#     FileUtils.cp filename, filename.gsub(%r{-s[a-z0-9]{10}\.png$}, '.png')
#   end
# end

## Replace in stylesheets generated references to sprites
##by their counterparts without the hash uniqueness.
# on_stylesheet_saved do |filename|
#   if File.exists?(filename)
#     css = File.read filename
#     File.open(filename, 'w+') do |f|
#       f << css.gsub(%r{-s[a-z0-9]{10}\.png}, '.png')
#     end
#   end
# end

## スプライト画像生成時に生成されたファイル名に自動的に付けられるハッシュ文字列を削除する
# on_sprite_saved do |filename|
#   if File.file?(filename)
#     FileUtils.mv filename, filename.gsub(%r{-s[0-9a-f]{10}(\.\w+)}, '\1')
#   end
# end





# Set this to the root of your project when deployed:
# http_path = "/"
css_dir = "app/assets/stylesheets/"
sass_dir = "app/assets/sass/"
images_dir = "app/assets/images/"
javascripts_dir = "app/assets/javascripts/"
fonts_dir = "app/assets/fonts/"
cache_dir = "../.sass-cache"


# You can select your preferred output style here (can be overridden via the command line):
output_style = :expanded


# css用のpath 
# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true
http_generated_images_path = "assets"
# http_generated_images_path = "<%= asset_path%>"
http_generated_images_dir = "assets"

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

