#!/usr/bin/perl
package lexer;
use Exporter;
our @ISA=qw(Exporter);
our @EXPORT=qw(lex);
sub lex($)
{
	$op="[\+\*\-\/]";
	#@tokens=[], accesing 0th element gives incorrect output
	@tokens;
	while($_)
	{
		if(s/^([0-9]+)//o)
		{
			push @tokens,["num_k",$1];
		}
		elsif(s/^($op)//o)
		{
			push @tokens,[$1];
		}
		elsif(s/^(\n)//o)
		{
			push @tokens,['\n'];
		}
		else
		{
			die "Incorrect input $_";
		}
	}
	return @tokens;
}

#print("Enter an Expression\n");
#$_=<STDIN>;
#@tokens=lex($_);
#foreach $token (@tokens)
#{
#	print join(" ",@{$token}),"\n";
#}

