<%inherit file="base.mako" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
<title>${bf.config.blog.name}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link rel="openid.server"   href="http://www.myopenid.com/server">
<link rel="openid.delegate" href="http://KamilEssekkat.myopenid.com/">
<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="${bf.util.site_path_helper('feed')}" />
<link rel="shortcut icon" href="${bf.util.site_path_helper('images/favicon.ico')}" type="image/x-icon"/>
<link rel='stylesheet' href="${bf.util.site_path_helper('css/style.css')}" type='text/css' />
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-17452503-1']);
  _gaq.push(['_trackPageview']);
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
  </head>
  <body>
    <div id="content">
        <div id="mainmenu" style="background: url(${bf.util.site_path_helper('images/tlo2.png')});">
        <div id="logo">
        <h1><a href="${bf.util.site_path_helper()}">${bf.config.blog.name}</a></h1>
        </div>
        </div>
      <div id="main_block">
        <div id="prose_block">
          ${next.body()}
        </div><!-- End Prose Block -->
      </div><!-- End Main Block -->
      <div id="footer">
<p id="credits">
Made with <a href="http://en.wikipedia.org/wiki/Free_and_open_source_software">FOSS</a>.<br />
Template CSS <a href="http://www.freecsstemplates.org/">Free CSS Templates</a>.<br />
Powered by <a href="http://www.blogofile.com">Blogofile</a>.<br />
<a href="http://validator.w3.org/check?uri=referer">
    <img src="${bf.util.site_path_helper('images/valid-xhtml10-blue.png')}"
    alt="Valid XHTML 1.0 Transitional" height="31" width="88" />
</a>
<a href="http://jigsaw.w3.org/css-validator/check/referer">
    <img style="border:0;width:88px;height:31px"
        src="${bf.util.site_path_helper('images/vcss-blue')}"
        alt="Poprawny CSS!" />
</a>
</p>
      </div> <!-- End Footer -->
    </div> <!-- End Content -->
  </body>
</html>
