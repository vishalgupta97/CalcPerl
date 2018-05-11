%token num_k
%left '+' '-'
%left '*' '/'
%%

input : expr '\n';
expr: num_k 
	| expr '+' expr 
	| expr '-' expr
	| expr '*' expr
	| expr '/' expr

%%