#!/usr/bin/env perl

use warnings;
use strict;
use 5.010;

use URI;
use Web::Scraper;

# First, create your scraper block
my $tweets = scraper {
    # Parse all LIs with the class "status", store them into a resulting
    # array 'tweets'.  We embed another scraper for each tweet.
    process "li.status", "tweets[]" => scraper {
        # And, in that array, pull in the elementy with the class
        # "entry-content", "entry-date" and the link
        process ".entry-content", body => 'TEXT';
        process ".entry-date", when => 'TEXT';
        process 'a[rel="bookmark"]', link => '@href';
    };
};

my $res = $tweets->scrape( URI->new("http://twitter.com/miyagawa") );

# The result has the populated tweets array
for my $tweet (@{$res->{tweets}}) {
    print "$tweet->{body} $tweet->{when} (link: $tweet->{link})\n";
}
