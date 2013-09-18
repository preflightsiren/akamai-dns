require 'net/http'
require 'rspec'
require 'resolv'

site_url = 'now.ninemsn.com.au'
dns = Resolv::DNS.new(:nameserver => ['8.8.8.8']) 

describe 'DNS conventions' do
  it 'has a apex zone publicly available' do
   rr = dns.getaddresses(site_url)
   rr.should_not be_empty
  end
  it 'should have www CNAME\'d to edgesuite' do
    rr = dns.getresources("www.#{site_url}", Resolv::DNS::Resource::IN::CNAME)
    rr.should_not be_empty
    rr[0].name.to_s.should match('edgesuite.net')
  end
  it 'should have an origin record' do
    rr = dns.getresources("now.origin.ninemsn.com.au", Resolv::DNS::Resource::IN::CNAME)
    rr.should_not be_empty
  end
  it 'should have a Sydney region record' do
    rr = dns.getresources("now.ap2.ninemsn.com.au", Resolv::DNS::Resource::IN::CNAME)
    rr.should_not be_empty
  end
  it 'should have a Singapore region record' do
    rr = dns.getresources("now.ap1.ninemsn.com.au", Resolv::DNS::Resource::IN::CNAME)
    rr.should_not be_empty
  end
end
