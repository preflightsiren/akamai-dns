require 'net/http'
require 'rspec'
require 'resolv'

site_name = ENV['sitename'] || 'now'
domain = ENV['domain'] || 'ninemsn.com.au'
site_url = 'now.ninemsn.com.au'
dns = Resolv::DNS.new(:nameserver => ['8.8.8.8']) 

describe 'DNS conventions' do
  it 'has a apex zone publicly available' do
   rr = dns.getaddresses("#{site_name}.#{domain}")
   rr.should_not be_empty
  end
  it 'should have www CNAME\'d to edgesuite' do
    rr = dns.getresources("www.#{site_name}.#{domain}", Resolv::DNS::Resource::IN::CNAME)
    rr.should_not be_empty
    rr[0].name.to_s.should match('edgesuite.net')
  end
  it 'should have an origin record' do
    rr = dns.getresources("#{site_name}.origin.#{domain}", Resolv::DNS::Resource::IN::CNAME)
    rr.should_not be_empty
  end
  it 'should have a Sydney region record' do
    rr = dns.getresources("#{site_name}.ap2.#{domain}", Resolv::DNS::Resource::IN::CNAME)
    rr.should_not be_empty
  end
  it 'should have a Singapore region record' do
    rr = dns.getresources("#{site_name}.ap1.#{domain}", Resolv::DNS::Resource::IN::CNAME)
    rr.should_not be_empty
  end
end

describe 'hosting site off www. resource' do
  it 'should redirect to www.' do
    uri = URI("http://#{site_name}.#{domain}")
    response = Net::HTTP.get_response(uri)
    response.class.should be(Net::HTTPMovedPermanently)
  end
end