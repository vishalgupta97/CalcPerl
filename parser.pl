#!/usr/bin/perl
use lexer;
use tree;
@arr=({num_k=>1,expr=>3,input=>2},
	{reduce=>[1,\&num]},
	{end=>4},
	{'-'=>6,'/'=>8,'+'=>5,'*'=>7,'\n'=>9},
	{},
	{expr=>10,num_k=>1},
	{expr=>11,num_k=>1},
	{expr=>12,num_k=>1},
	{expr=>13,num_k=>1},
	{reduce=>[2,\&input]},
	{'*'=>7,'/'=>8,reduce=>[3,\&op]},
	{'*'=>7,'/'=>8,reduce=>[3,\&op]},
	{reduce=>[3,\&op]},
	{reduce=>[3,\&op]});
	
print("Enter an Expression\n");
$_=<STDIN>;
@tokens=lex($_);
print "Lexer Output\n";
foreach $token (@tokens)
{
	print join(" ",@{$token}),"\n";
}
push @tokens,["end"];
@stack=(0);
print "Parser Output\n";
while(@stack)
{
	if($stack[-1]==4)
	{
		print "Complete\nTree Traversal\n";
		traverse($stack[-4],0,0);
		last;
	}
	my @curr_token=@{$tokens[0]};	
	if($val=$arr[$stack[-1]]{$curr_token[0]})
	{
		push @stack,\@curr_token,$val;
		shift @tokens;
	}
	elsif($val=$arr[$stack[-1]]{reduce})
	{
		my @val1=@$val;
		my @param;
		for($i=1;$i<=2*$val1[0];$i++)
		{
			if($i%2==0)
			{
				$val=pop @stack;
				push @param,$val;
			}
			else
			{
				pop @stack;
			}
		}
		#print @param,"12\n";
		push @stack,$val1[1]->(@param);
		push @stack,$arr[$stack[-2]]{$stack[-1]->{name}};
	}
	else
	{
		die "Unexpected Token ". $curr_token."\n";
	}
	print @stack,"\n";
}