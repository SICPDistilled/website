require "aws-sdk"
require "mime/types"

class S3Deploy < Middleman::Extension

  REGION = ENV['AWS_REGION']
  BUCKET = ENV['BUCKET']

  def initialize(app, options_hash={}, &block)
    super
    app.after_build do |builder|
      Dir[build_dir + "/**/*"].each do |file_path|
        file = file_path.gsub(/build\//, "")
        next if File.directory?(file_path)
        STDERR.puts "uploading #{file}"
        content_type = S3Deploy.mime_type_for(File.basename(file))
        S3Deploy.s3_upload( file, file_path, content_type )
      end
    end
  end

  private

  def self.mime_type_for asset
    ::MIME::Types.type_for( asset ).first.content_type
  end

  def self.s3_upload to, from, content_type, bucket = BUCKET
    bucket = s3.bucket(bucket)
    object = bucket.object(to)
    object.put(body: open(from), content_type: content_type, acl: 'public-read')
  end

  def self.s3
    @conn ||= Aws::S3::Resource.new(region: REGION)
  end
end

::Middleman::Extensions.register(:s3_deploy, S3Deploy)
