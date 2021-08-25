#2021.08.24 		pc1とpc2 のバックアップのため 更新日付より、退避ファイルの判定を行う
use strict;
use warnings;
use utf8;

use Encode; 

binmode STDIN,  ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';
	if (@ARGV != 2){ die "引数を2つ指定して下さい\n"};
  	my $infile = $ARGV[0];
  	my $otfile = $ARGV[1];

	my $true	 = "1";
	my $false	 = "0";	

	print "入力ファイル=$infile, 出力ファイル=$otfile\n";
	open(INDD,"<",$infile) or die("error :$!");
	open(OTDD,">",$otfile) or die("error :$!");
	my	$f_in_end	= $false;
	my	$line		= "";
#	my	$write_sw	= $false;
	my  $update		= 0;

	&read_rtn();
	while( $f_in_end	==	$false){

		if($line	=~/\s(\d{4})\/(\d{2})\/(\d{2})/){
			$update	= $1.$2.$3;
#			print 	"update:",$update,"\n";
		}
#
		if($update	ge	20210404){
			&write_rtn();
		}
#
		&read_rtn();
	}	
	close	INDD;
	close	OTDD;

sub read_rtn{
	if(!eof INDD){
		$line = <INDD>;
#		$line =   decode('utf8', $line);  
		$line =   decode('shiftjis', $line);  
		
#		print "read \n";
	}else{
# 		print "read owari \n";
		$f_in_end	= $true;
	}
}
sub write_rtn{
		$line =   encode('shiftjis', $line); 
#		$line =   encode('utf8', $line); 
		print OTDD	$line;
}
