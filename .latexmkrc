add_cus_dep( 'acn', 'acr', 0, 'run_makeglossaries' );
add_cus_dep( 'glo', 'gls', 0, 'run_makeglossaries' );
add_cus_dep( 'ntn', 'not', 0, 'run_makeglossaries' );

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
push @generated_exts, 'ntn', 'not', 'nlg';

$aux_dir = 'aux';
$out_dir = 'aux';
$pdflatex = 'xelatex --shell-escape --interaction=nonstopmode %O %S';
$pdf_mode = 1;

$clean_ext .= " acr acn alg glo gls glg ist not ntn";

sub run_makeglossaries {
    my $dir = dirname($_[0]);
    my $base_name = basename($_[0]);

    my $return;
    if ( $silent ) {
        $return = system "makeglossaries", "-q", "-d", "$dir", "$base_name";
    }
    else {
        $return = system "makeglossaries", "-d", "$dir", "$base_name";
    };
    return $return;
}

