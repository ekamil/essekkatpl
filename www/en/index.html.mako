<%inherit file="_templates/site.mako" />
<a href="${bf.util.site_path_helper('en/about.html')}">About me
</a>
<br /><br />
<a href="${bf.util.site_path_helper('files/KamilE.asc')}">My PGP public key</a>
<br />Fingerprint: 7B60 0895 08F7 40BE 59D0 487F 696E AE84 598C 2A2D
<br /><br />
<a href="${bf.util.site_path_helper('en/kontakt.html')}">Contact
</a>
<br /><br />
A few newest posts:
<ul>
% for post in bf.config.blog.posts[:5]:
    <li><a href="${post.path}">${post.title}</a></li>
% endfor
</ul>
