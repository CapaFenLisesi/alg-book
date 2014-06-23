#add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
#sub makeglossaries {
#	system( "makeglossaries \"$_[0]\"" );
#}
#
#$clean_ext = 'synctex.gz synctex.gz(busy) run.xml tex.bak bbl bcf fdb_latexmk run tdo %R-blx.bib'

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
$clean_ext .= ' %R.ist %R.xdy';