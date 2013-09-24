require 'net/http'
require 'rspec'
require 'resolv'

url = ENV['url'] || 'http://www.now.ninemsn.com.au'
uri = URI(url)
response = nil
Net::HTTP.start(uri.host) {|http|
  response = http.head("#{uri.path}?#{uri.query}")
}
response.each_header {|key,value| puts "#{key} = #{value}" }


describe 'Common caching issues' do
	it 'should have a valid expires header' do

	end

  #docs https://control.akamai.com/portal/kb/kbSearchDetails.jsf?articleId=4577
	it 'should be encoded if Vary: Accept-Encoding' do
		if response['Vary'] 
			response['Content-Encoding'].should_not be(nil)
		end
	end
	
end