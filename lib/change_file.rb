def ChangeOnFile( file, regex_to_find, text_to_put_in_place )
  text = File.read file
  File.open( file, 'w+' ) { | f | f << text.gsub( regex_to_find, text_to_put_in_place ) }
end


puts "Hello World"

ChangeOnFile "d:\\Work\\test\\test.txt", /:key => \"([^']*)\",/,
  ":key => \"s\","




#text = "abc => :key = \"aada\""
#
#puts text
#
#puts text.gsub(/abc => :key = \"([^']*)\"/, "abc => :key = \"1234\"")