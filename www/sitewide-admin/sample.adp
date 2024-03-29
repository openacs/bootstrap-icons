<master>
<property name="doc(title)">@title;literal@</property>
<property name="context">@context;literal@</property>

<h1>@title;noquote@</h1>
<h3>Support for the adp:icon Tag</h3>
<p>Bootstrap Icons adp:icons can be used on ADP pages with
    <blockquote class="mx-4">
    <code>&lt;adp:icon name="<i>NAME</i>" title="..." style="..." class="..." iconset='...' invisible='...'&gt;</code>
    </blockquote>
    
<p>The last three arguments are optional. Bootstrap Icons defines in
version 1.8.1 more than 1,600 icons.  When installing Bootstrap Icons,
all of these are usable independent of the style of the site.

<p>However, when one wants to keep e.g. some subsites in Bootstrap 3
and others in Bootstrap 5, and the classic Bootstrap 3 look-and-feel
should be kept, and the identical markup should adapt its
Look-and-Feel depending on the subsite theme, there are some
restrictions. OpenACS supports the icon sets
<a href="https://openacs.org/doc/acs-subsite/images">"classic"</a>
(old-style gif/png images),
<a href="https://getbootstrap.com/docs/3.4/components/">"glyphicons"</a>
(Part of Bootstrap 3),
<a href="https://icons.getbootstrap.com/">"bootstrap-icons"</a> (usable for all
themes), and
<a href="https://fontawesome.com/search?m=free">"fa-icons"</a> (usable
for all themes).  Some of the icon names are usable via adp:icon for
all OpenACS icon sets, some of these can be used without further
mapping as replacement of the gyphicons of Bootstrap 3.

<p> The names which can be used for all icon sets are called "generic", since for these, a mapping from the specific icon set to the generic name exists. See below for lists of names and contexts, where
these can be used.

<ul>
<li><p>Defined <strong>generic names</strong> for <code>adp:icons</code>,
working with icon sets
<a href="https://openacs.org/doc/acs-subsite/images">"classic"</a>,
<a href="https://getbootstrap.com/docs/3.4/components/">"glyphicons"</a>,
<a href="https://icons.getbootstrap.com/">"bootstrap-icons"</a>, and
<a href="https://fontawesome.com/search?m=free">"fa-icons"</a>.  This means that the same
name can be used in the markup. When switching the themes/iconset,
different icon sets are used without the need of rewriting any markup.
The current default icon set is <strong>@iconset@</strong>.

<blockquote class="mx-4">
  @genericHTML;noquote@
</blockquote>
</li>

<li><p><em>Common adp:icons</em> defined for icon sets
<a href="https://getbootstrap.com/docs/3.4/components/">"glyphicons"</a>,
and <a href="https://icons.getbootstrap.com/">"bootstrap-icons"</a>.<br> These have identical names in these icon
sets and work without an additional mapping. This means that when using these names,
switching between Bootstrap 3 and Bootstrap 5 works without rewriting any code.

    <blockquote class="mx-4">
    align-center <adp:icon name='align-center'><br>
    apple <adp:icon name='apple'><br>
    arrow-down <adp:icon name='arrow-down'><br>
    arrow-left <adp:icon name='arrow-left'><br>
    arrow-right <adp:icon name='arrow-right'><br>
    arrow-up <adp:icon name='arrow-up'><br>
    asterisk <adp:icon name='asterisk'><br>
    bell <adp:icon name='bell'><br>
    book <adp:icon name='book'><br>
    bookmark <adp:icon name='bookmark'><br>
    briefcase <adp:icon name='briefcase'><br>
    calendar <adp:icon name='calendar'><br>
    camera <adp:icon name='camera'><br>
    check <adp:icon name='check'><br>
    chevron-down <adp:icon name='chevron-down'><br>
    chevron-left <adp:icon name='chevron-left'><br>
    chevron-right <adp:icon name='chevron-right'><br>
    chevron-up <adp:icon name='chevron-up'><br>
    cloud <adp:icon name='cloud'><br>
    cloud-download <adp:icon name='cloud-download'><br>
    cloud-upload <adp:icon name='cloud-upload'><br>
    credit-card <adp:icon name='credit-card'><br>
    download <adp:icon name='download'><br>
    eject <adp:icon name='eject'><br>
    envelope <adp:icon name='envelope'><br>
    file <adp:icon name='file'><br>
    film <adp:icon name='film'><br>
    filter <adp:icon name='filter'><br>
    flag <adp:icon name='flag'><br>
    forward <adp:icon name='forward'><br>
    fullscreen <adp:icon name='fullscreen'><br>
    gift <adp:icon name='gift'><br>
    globe <adp:icon name='globe'><br>
    hdd <adp:icon name='hdd'><br>
    headphones <adp:icon name='headphones'><br>
    heart <adp:icon name='heart'><br>
    hourglass <adp:icon name='hourglass'><br>
    inbox <adp:icon name='inbox'><br>
    lamp <adp:icon name='lamp'><br>
    link <adp:icon name='link'><br>
    list <adp:icon name='list'><br>
    lock <adp:icon name='lock'><br>
    magnet <adp:icon name='magnet'><br>
    menu-down <adp:icon name='menu-down'><br>
    menu-up <adp:icon name='menu-up'><br>
    paperclip <adp:icon name='paperclip'><br>
    pause <adp:icon name='pause'><br>
    pencil <adp:icon name='pencil'><br>
    phone <adp:icon name='phone'><br>
    piggy-bank <adp:icon name='piggy-bank'><br>
    play <adp:icon name='play'><br>
    play-circle <adp:icon name='play-circle'><br>
    plus <adp:icon name='plus'><br>
    record <adp:icon name='record'><br>
    save <adp:icon name='save'><br>
    scissors <adp:icon name='scissors'><br>
    search <adp:icon name='search'><br>
    send <adp:icon name='send'><br>
    share <adp:icon name='share'><br>
    signal <adp:icon name='signal'><br>
    star <adp:icon name='star'><br>
    stop <adp:icon name='stop'><br>
    sunglasses <adp:icon name='sunglasses'><br>
    tag <adp:icon name='tag'><br>
    tags <adp:icon name='tags'><br>
    trash <adp:icon name='trash'><br>
    upload <adp:icon name='upload'><br>
    volume-down <adp:icon name='volume-down'><br>
    volume-off <adp:icon name='volume-off'><br>
    volume-up <adp:icon name='volume-up'><br>
    wrench <adp:icon name='wrench'><br>
    zoom-in <adp:icon name='zoom-in'><br>
    zoom-out <adp:icon name='zoom-out'><br>
    </blockquote>
</li>
</ul>

@content;literal@
