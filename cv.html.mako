<%inherit file="_templates/site.mako" />
${bf.filter.run_chain('rst',
open('_cv_pl.rst').read() )}
