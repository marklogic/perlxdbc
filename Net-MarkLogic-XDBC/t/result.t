# -*- perl -*-
use Test::More qw(no_plan);
use Data::Dumper;
BEGIN 
{ 
    use_ok( 'Net::MarkLogic::XDBC::Result' );
    use_ok( 'HTTP::Response' );
    use_ok( 'HTTP::Headers' );
}

#HTTP/1.1 200 OK
#Connection: close
#Content_Length => 529,
#Content_Type => 'multipart/mixed; boundary=9136820dbdf95949',
#Client-Date: Fri, 18 Mar 2005 22:40:37 GMT
#Client-Peer: 69.10.144.53:8002
#Client-Response-Num: 1

my $headers  = HTTP::Headers->new(
    Content_Length => 529,
    Content_Type => 'multipart/mixed; boundary=e1a8ea8e970ee825',
);

open (XML, "t/data/response_1.xml") || die "Can't open data file, $!";
my $content = join('', <XML>);
close XML;

my $h_resp1 = HTTP::Response->new(200, '', $headers, $content);

my $x_resp1 = Net::MarkLogic::XDBC::Result->new ( response => $h_resp1 );
                                        
isa_ok ($x_resp1, 'Net::MarkLogic::XDBC::Result');

like( $x_resp1->content, qr{<title>SYNOPSIS\s*</title>}xms, 'Content contains expected data');

like( $x_resp1->as_xml, qr{<title>SYNOPSIS\s*</title>}xms, 'Content contains expected data');

my @items = $x_resp1->items();

ok( @items == 5, "Got 5 items back (actual number:" . @items . ")");

foreach my $item (@items) {
    isa_ok($item, 'Net::MarkLogic::XDBC::Result::Item');
    like($item->as_xml, qr{<title>}xms, "Item contains expected content");
    ok($item->content_type eq "text/xml", "Got expected content-type");
    ok($item->type eq "node()", "Got expected type");
}
