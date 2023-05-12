#template::register_urn -urn urn:ad:css:bootstrap-icons \
#    -resource //maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css \
#    -csp_list {font-src maxcdn.bootstrapcdn.com style-src maxcdn.bootstrapcdn.com}

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
    set fn bootstrap-icons.css
    if {[apm_version_names_compare $::bootstrap_icons::version 1.10.4] >= 0} {
        ns_log notice "CSS [dict get $resource_info prefix]/$fn "
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
