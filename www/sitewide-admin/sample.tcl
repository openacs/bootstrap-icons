ad_page_contract {
    @author Gustaf Neumann

    @creation-date Jan 1, 2020
} {
}

set resource_info [::bootstrap_icons::resource_info]

set title "Sample Icons"
set context [list [list "." "Boostrap Icons"] $title] 

# local URL
set URL /resources/bootstrap-icons/bootstrap-icons-$::bootstrap_icons::version/
#set CSS_URL $URL/bootstrap-icons.css

#
# The CSS file will handle the .woff files as well, like e.g.
#    www/resources/bootstrap-icons-1.8.1/fonts/bootstrap-icons.woff
#

# CDN URL for style sheet as recommended by
#    https://icons.getbootstrap.com/#icon-font
#
# set CSS_URL https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css

#
# Direct Cloudflare
#
# set CSS_URL https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/$::bootstrap_icons::version/font/bootstrap-icons.min.css

#
# Generic URL for CSS (based on URN)
#
set CSS_URL urn:ad:css:bootstrap-icons

template::head::add_css -href $CSS_URL

set content [subst {
    <h3>Using an Bootstrap Icons as SVG image</h3>
    <p>Bootstrap <img src="$URL/bootstrap.svg" alt="Bootstrap" width="32" height="32">

    <h3>Using an Bootstrap Icons as fonts (sample)</h3>
                                           
    <blockquote class="mx-4">
    GitHub <i class="bi-github" role="img" aria-label="GitHub"></i><br>
    archive <i class="bi bi-archive"></i><br>
    arrow-up-circle <i class="bi bi-arrow-up-circle"></i><br>
    arrow-up-right-square <i class="bi bi-arrow-up-right-square"></i><br>
    arrow-up-square <i class="bi bi-arrow-up-square"></i><br>
    box-arrow-up-right <i class="bi bi-box-arrow-up-right"></i><br>
    clock-history <i class="bi bi-clock-history"></i><br>
    cloud <i class="bi bi-cloud"></i><br>
    envelope <i class="bi bi-envelope"></i><br>
    eye <i class="bi bi-eye"></i><br>
    eyeglasses <i class="bi bi-eyeglasses"></i><br>
    file-earmark <i class="bi bi-file-earmark"></i><br>
    files <i class="bi bi-files"></i><br>
    folder <i class="bi bi-folder"></i><br>
    folder-symlink <i class="bi bi-folder-symlink"></i><br>
    info-square <i class="bi bi-info-square"></i><br>
    pencil-square <i class="bi bi-pencil-square"></i><br>
    trash <i class="bi bi-trash"></i><br>
    upload <i class="bi bi-upload"></i><br>
    </blockquote>

    <h3>Resource info for Bootstrap Icons</h3>
    
    <p> <table>[join [lmap {k v} $resource_info {string cat <tr><td><i>$k ":</td><td> " $v</td></tr>}]]</table>
}]

