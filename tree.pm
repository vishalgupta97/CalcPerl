#!/usr/bin/perl
package tree;
use Exporter;
our @ISA=qw(Exporter);
our @EXPORT=qw(op num input traverse);
sub op($)
{
	my @param=@_;
	my %node=(childs=>[$param[2],$param[0]],val=>$param[1],name=>expr);
	return \%node;
}
sub num($)
{
	my %node=(val=>shift @_,name=>expr);
	return \%node;
}
sub input($$)
{
	@param=@_;
	my %node=(childs=>[$param[1]],name=>input);
	return \%node;
}
sub traverse($$$)
{
	my ($ref,$pos,$level)=@_;
	my %node=%$ref;
	print $level," ",$pos," ",$node{name}," ";
	if($node{val})
	{
		print @{$node{val}}," ";
	}
	print "\n";
	if($node{childs})
	{
		my $val1=$node{childs};
		my $i=1;
		foreach $child (@$val1)
		{
			traverse($child,$i,$level+1);
			$i++;
		}
	}
}