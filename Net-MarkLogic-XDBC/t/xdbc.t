# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More qw(no_plan);

BEGIN { use_ok( 'Net::MarkLogic::XDBC' ); }

my $xdbc1 = Net::MarkLogic::XDBC->new (host => "host",
                                        port => "7999",
                                        username => "user",
                                        password => "pass",);
isa_ok ($xdbc1, 'Net::MarkLogic::XDBC');


# 4 arg constructor
ok( $xdbc1->host eq "host", "hostname set correctly by constructor" );
ok( $xdbc1->port == 7999, "port set correctly by constructor" );
ok( $xdbc1->username eq "user", "username set correctly by constructor" );
ok( $xdbc1->password eq "pass", "password set correctly by constructor" );

# easy constructor
my $xdbc2 = Net::MarkLogic::XDBC->new( 'user1:pass1@host1:8000' );

isa_ok ($xdbc2, 'Net::MarkLogic::XDBC');
ok( $xdbc2->host eq "host1", "hostname set correctly by constructor" );
ok( $xdbc2->port == 8000, "port set correctly by constructor" );
ok( $xdbc2->username eq "user1", "username set correctly by constructor" );
ok( $xdbc2->password eq "pass1", "password set correctly by constructor" );

# setters 
$xdbc2->host("newhost");
ok($xdbc2->host eq "newhost", "set hostname.");
$xdbc2->port(8001);
ok($xdbc2->port == 8001 , "set port.");
$xdbc2->username("newuser");
ok($xdbc2->username eq "newuser", "set username.");
$xdbc2->password("newpass");
ok($xdbc2->password eq "newpass", "set password.");

isa_ok($xdbc2->ua, "LWP::UserAgent");
isa_ok($xdbc2->header, "HTTP::Headers");



