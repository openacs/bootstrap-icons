ad_library {
    Initialization for Bootstrap Icons
}

set resource_info [::bootstrap_icons::resource_info]

if {[dict exists $resource_info cdnHost] && [dict get $resource_info cdnHost] ne ""} {
    #
    # The .min.css is just on the CDN
    #
    set fn bootstrap-icons.min.css

    #
    # Add global CSP rules.
    #
    lappend ::security::csp::default_directives \
        style-src [dict get $resource_info cdnHost] \
        font-src [dict get $resource_info cdnHost]
   
} else {
    #
    # Unfortunately, the structure of the distributed .zip file is a
    # moving target. Sometimes, a sub folder "fonts" is used,
    # sometimes, minifiled versions are included. Check in the
    # filesystem, what we have actually got.
    #
    set fspath [dict get $resource_info resourceDir]/bootstrap-icons-$::bootstrap_icons::version

    #
    # Do we have the subdirectory "font"? If yes, use it.
    #
    set subdir [expr {[file isdirectory $fspath/font] ? "font/" : ""}]
    #
    # Do we have a minified version? If yes, use it.
    #
    set fn [expr {[file exists $fspath/${subdir}bootstrap-icons.min.css]
                  ? "${subdir}bootstrap-icons.min.css"
                  : "${subdir}bootstrap-icons.css"}]
}

set URN urn:ad:css:bootstrap-icons
ns_log notice "CSS [dict get $resource_info prefix]/$fn "
template::register_urn \
    -urn $URN \
    -resource [dict get $resource_info prefix]/$fn \
    -csp_list [expr {[dict exists $resource_info cspMap $URN]
                     ? [dict get $resource_info cspMap $URN]
                     : ""}]

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
