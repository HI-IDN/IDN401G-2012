function SaveFigure(filename, figure_handle)
% Save the figure to an ipe-compatible PDF.
% Filename is the name of the file to save it to (you can omit the .pdf
% extension if you like). figure_handle gives the figure to save. If
% omitted the current figure is used.

filename(find(filename == '\')) = '/';

if numel(filename >= 4) && strcmpi(filename(end-3:end), '.pdf')
    filename = filename(1:end-4);
end

if nargin < 2
    figure_handle = gcf;
end

saveas(figure_handle, filename, 'pdf');
CropPDF(filename);
PDFtoIPE(filename);

end


function CropPDF(pdffile)
% Uses the pdfcrop program to crop the PDF.
% pdffile is the file name (without the extension) to crop. It is
% overwritten.

% You need the pdfcrop.pl script in the current directory (or you can
% modify the command line below to point to it), and a version of perl
% installed.
%
% pdfcrop.pl is available on ctan, and you can use ActivePerl on windows.

system(['perl pdfcrop.pl --verbose --margin 5 "' pdffile '.pdf"']);
movefile([pdffile '-crop.pdf'], [pdffile '.pdf']);

end

function PDFtoIPE(pdffile)
% Uses the PDFtoIPE program to convert the PDF to one IPE can edit.
% pdffile is the file name (without the extension) to convert. It is
% overwritten.

% Alter these paths to point to the location of your ipe programs.
pdftoipe = '/usr/bin/pdftoipe';
ipe6upgrade = '/usr/bin/ipe6upgrade';
ipetoipe = '/usr/bin/ipetoipe';

system(['"' pdftoipe '" "' pdffile '.pdf" "' pdffile '.xml"']);
system(['sed ''1,2d'' <' pdffile '.xml > tmp.xml'])
system(['cat ipe_mix tmp.xml > ' pdffile '.xml'])
system(['"' ipetoipe '" -pdf "' pdffile '.xml" "' pdffile '.pdf"']);
delete('tmp.xml'); delete([pdffile '.pdf']);
 
end