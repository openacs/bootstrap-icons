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
    
    ns_log notice "ADDING CDN"
    
} else {
    set fn bootstrap-icons.css
    #
    # Unfortunately, the structure of the distributed .zip file is
    # version dependent: Versions greater or equal to 1.10.4 and less
    # than 1.11.0 require a "font" in the path. Also 1.11.2 requires this.
    #
    if {([apm_version_names_compare $::bootstrap_icons::version 1.10.4] >= 0
        && [apm_version_names_compare $::bootstrap_icons::version 1.11.0 ] < 0)
        || [apm_version_names_compare $::bootstrap_icons::version 1.11.2 ] >= 0
    } {
        #
        # Adding "font" to the path.
        #
        set fn font/$fn
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
