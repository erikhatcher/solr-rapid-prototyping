require 'net/http'

@dir = Dir.new("/Users/erikhatcher/apache-solr-3.3.0/docs")

@url = URI.parse("http://localhost:8983/solr")
@connection = Net::HTTP.new(@url.host, @url.port)

def index(filename)
  @connection.get(@url.path + "/update/extract?stream.file=#{filename}&literal.id=#{filename}")
end

def commit
  @connection.get(@url.path + "/update?commit=true")
end

@dir.each {|name|
  f = "#{@dir.path}/#{name}"
  if File.file?(f)
    puts "Indexing #{f}..."
    index(f)
  end
}

puts "Committing..."
commit

puts "Done!"
