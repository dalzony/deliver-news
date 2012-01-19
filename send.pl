#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

use Data::Dumper;
use DateTime;
use Encode qw/encode_utf8 decode_utf8 encode/;
use Email::Sender::Simple qw(sendmail);
use Email::Simple;
use Email::Simple::Creator;
use Email::MIME;
use Path::Class;

my $body='<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /></head><body>hello,  나는 민선, 테스트중이다 오바</body></html>';

my $msg = Email::MIME->create(
    header_str => [
          From        => q(Deliver News <noreply@minsun>),
          To          => q(Minsun Lee <mintegrals@gmail.com>),
          Cc          => q(SeongHo Park <quimien@gmail.com>),
          Subject     => "test,한글",
    ],
    body => encode_utf8($body),
);
$msg->charset_set('utf8');
$msg->content_type_set( 'text/html' );
sendmail($msg) && print "sent\n";
