#Akamai DNS tests

Sticking to this convention makes it much easier to manage our sites.

###Overview of tests

Tests for well known entry-points (Akamai fronted, origin)
redirection to www.
multi region support

###Running the specs
to run with defaults run:
> bundle install && bundle exec rake



to customise the execution set environment variables

ENV['sitename'] => Default is 'now'
ENV['domain'] => Default is 'ninemsn.com.au'

> bundle install && bundle exec rake