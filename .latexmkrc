$pdf_previewer = 'open -a Skim';
$pdflatex = 'pdflatex -file-line-error -halt-on-error -interaction=nonstopmode';

$out_dir = '.';
$aux_dir = '/tmp/latexmk';
# # $aux_dir = '/tmp/latexmk/%Z/';
# # $aux_dir = "/tmp/latexmk"%Z;
# # $emulate_aux = 1;

@generated_exts = (@generated_exts, 'synctex.gz');
