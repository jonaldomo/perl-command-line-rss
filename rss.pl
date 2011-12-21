#this is a comment added by c9.io
use XML::RSS::Parser::Lite;
use LWP::Simple;
use Cwd;
use strict;
binmode STDOUT, ":utf8";

if($ARGV[0] =~ /-h/){
    my $dir = getdcwd();
    print "perl-command-line-rss"
         ."\nView rss feeds and articles from the command prompt"
         ."\nUsage: $dir\\rss.pl [option] [rss feed]"
         ."\n\t-h\t\tthis help menu"
         ."\n\t-o\t\topen rss feed.  e.g. rss.pl -o http://news.ycombinator.org/rss"
         ."\n\t-v\t\tstored rss feeds";
    exit;
} 

if($ARGV[0] =~ /-o/){     
    my $xml = get($ARGV[1]) || die("Unable to load RSS feed!");
    my $rp = new XML::RSS::Parser::Lite;
    $rp->parse($xml);
    my @links = qw//;
            
    print $rp->get('title') . " \n" . $rp->get('url') . "\n" . $rp->get('description') . "\n\n";

    for (my $i = 0; $i < $rp->count(); $i++) {
       
        my $it = $rp->get($i);
        $links[$i] = $it->get('url');
        print "$i) ".$it->get('title')."\n"; # . " " . $it->get('url') . " " . $it->get('description') . 
    }

    print "\nWhich article # would you like to view? ";
    my $article = <STDIN>;
    print "\nOpening url $links[$article]\n";

    exec("C:\\lynx_w32\\lynx -accept_all_cookies $links[$article]") || die("Unable to open $links[$article]");
}
