<%inherit file="_templates/site.mako" />
${bf.filter.run_chain('rst',
open('../cv_pl.rst').read() )}
