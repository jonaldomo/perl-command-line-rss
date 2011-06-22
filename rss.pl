use XML::RSS::Parser::Lite;
use LWP::Simple;
no warnings;

        
my $xml = get($ARGV[0]) || die("Unable to load RSS feed!");
my $rp = new XML::RSS::Parser::Lite;
$rp->parse($xml);
@links = qw//;
        
print $rp->get('title') . " \n" . $rp->get('url') . "\n" . $rp->get('description') . "\n\n";

for (my $i = 0; $i < $rp->count(); $i++) {
   
    my $it = $rp->get($i);
    $links[$i] = $it->get('url');
    print "$i) ".$it->get('title')."\n"; # . " " . $it->get('url') . " " . $it->get('description') . 
}

print "\nWhich article # would you like to view? ";
$article = <STDIN>;
print "\nOpening url $links[$article]\n";
exec("C:\\lynx_w32\\lynx -accept_all_cookies $links[$article]") || die("Unable to open $links[$article]");
