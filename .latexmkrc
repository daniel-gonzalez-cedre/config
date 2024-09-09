$pdf_previewer = 'open -a Skim';
$pdflatex = 'pdflatex -interaction=nonstopmode -halt-on-error';

# $emulate_aux = 1;
$out_dir = '.';
$aux_dir = '/tmp/latexmk';

@generated_exts = (@generated_exts, 'synctex.gz');
