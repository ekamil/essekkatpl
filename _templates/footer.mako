
<p id="credits">
<a href="${bf.util.site_path_helper('feed')}">RSS feeds</a><br />
% if bf.config.blog.disqus.enabled:
 and <a href="http://${bf.config.blog.disqus.name}.disqus.com/latest.rss">Comments</a>.
<br />
% endif
Only <a href="http://en.wikipedia.org/wiki/Free_and_open_source_software">FOSS</a>.<br />
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
<a href="http://petition.stopsoftwarepatents.eu/491006640910/"><img
src="http://petition.stopsoftwarepatents.eu/banner/491006640910/ssp-362-60.gif"
alt="stopsoftwarepatents.eu petition banner"
width="362" height="60" /></a> 
</p>
% if bf.config.blog.disqus.enabled:
<script type="text/javascript">
//<![CDATA[
(function() {
		var links = document.getElementsByTagName('a');
		var query = '?';
		for(var i = 0; i < links.length; i++) {
			if(links[i].href.indexOf('#disqus_thread') >= 0) {
				query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
			}
		}
		document.write('<script charset="utf-8" type="text/javascript" src="http://disqus.com/forums/${bf.config.blog.disqus.name}/get_num_replies.js' + query + '"></' + 'script>');
	})();
//]]>
</script>
% endif
