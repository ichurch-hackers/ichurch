path = ""

if Rails.env == 'production' then
  path = Rails.root.join "bin/wkhtmltopdf-linux-amd64"
else  ### Following allows for development on my MacBook or Linux box
  if /darwin/ =~ RUBY_PLATFORM then
    path = Rails.root.join "bin/wkhtmltopdf"
  elsif /linux/ =~ RUBY_PLATFORM then
    path = Rails.root.join "bin/wkhtmltopdf-linux-amd64"
  else
    raise "Unable to locate wkhtmltopdf"
  end
end

WickedPdf.config = {
  exe_path: path.to_s
}
