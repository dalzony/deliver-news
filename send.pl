#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

use Data::Dumper;
use DateTime;
use Encode;
use Email::Sender::Simple qw(sendmail);
use Email::Simple;
use Email::Simple::Creator;
use Email::MIME;
use Path::Class;

my $body="<html><body>hello,  나는 민선, 테스트중이다 오바<body><html>";
my $msg = Email::MIME->create(
    header => [
        From        => 'noreply@deliverynews.minsun', 
        To          => 'mintegrals@gmail.com',
        #CC          => ',quimien@gmail.com',
        Subject     => "Reading Article",
        Type        => 'multipart/mixed',
    ],
    parts => [
        Email::MIME->create(
            attributes => {
                content_type => 'text/html',
                charset      => 'utf8',
            },
          body => $body,#'HELLO',#FIXME
        ),
    ],
);
sendmail($msg) && print "sent\n";    
