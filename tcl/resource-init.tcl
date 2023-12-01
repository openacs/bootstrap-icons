ad_library {
    Initialization for Bootstrap Icons
}

set resource_info [::bootstrap_icons::resource_info]

#
# We go for the minified version.
#
set fn bootstrap-icons.min.css

if {[dict exists $resource_info cdnHost] && [dict get $resource_info cdnHost] ne ""} {
    #
    # Add global CSP rules.
    #
    lappend ::security::csp::default_directives \
        style-src [dict get $resource_info cdnHost] \
        font-src [dict get $resource_info cdnHost]

} else {
    #
    # Unfortunately, the structure of the distributed .zip file is
    # version dependent: Versions greater or equal to 1.10.4, with the
    # exception of versions 1.11.0 and 1.11.1 require a "font" in the
    # path.
    #
    if {
        $::bootstrap_icons::version ni {"1.11.0" "1.11.1"} &&
        [apm_version_names_compare $::bootstrap_icons::version 1.10.4] >= 0
    } {
        #
        # Adding "font" to the path.
        #
        set fn font/$fn
    } else {
        #
        # Old zip distributions may not carry the minified version. We
        # settle for the unminified one in this case.
        #
        set fn bootstrap-icons.css
    }
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
