files = Dir.glob('./test/**/*.rb')
files.each{|file| require file }