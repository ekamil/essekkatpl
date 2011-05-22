<%inherit file="_templates/site.mako" />
<a href="${bf.util.site_path_helper('about.html')}">O mnie
</a>
<br /><br />
<a href="${bf.util.site_path_helper('files/KamilE.asc')}">Klucz PGP</a>
<br />Odcisk: 7B60 0895 08F7 40BE 59D0 487F 696E AE84 598C 2A2D
<br /><br />
<a href="${bf.util.site_path_helper('kontakt.html')}">Kontakt
</a>
<br /><br />
Najnowsze kilka postów:
<ul>
% for post in bf.config.blog.posts[:5]:
    <li><a href="${post.path}">${post.title}</a></li>
% endfor
</ul>
