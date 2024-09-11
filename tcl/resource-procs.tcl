ad_library {

    Bootstrap icons

    This script defines the following public procs:

    ::bootstrap_icons::resource_info
    ::bootstrap_icons::download


    @author Gustaf Neumann
    @creation-date 1 Jan 2022
}

namespace eval ::bootstrap_icons {
    variable parameter_info

    #
    # The version configuration can be tailored via the OpenACS
    # configuration file:
    #
    # ns_section ns/server/${server}/acs/bootstrap-icons
    #        ns_param BootstrapIconsVersion 1.11.3
    #
    set parameter_info {
        package_key bootstrap-icons
        parameter_name BootstrapIconsVersion
        default_value 1.11.3
    }

    ad_proc ::bootstrap_icons::resource_info {
        {-version ""}
    } {

        Get information about available version(s) of Bootstrap Icons,
        from the local filesystem, or from CDN.

    } {
        variable parameter_info

        #
        # If no version is specified, use the configured value.
        #
        if {$version eq ""} {
            dict with parameter_info {
                set version [::parameter::get_global_value \
                                 -package_key $package_key \
                                 -parameter $parameter_name \
                                 -default $default_value]
            }
        }

        #
        # Setup variables for access via CDN vs. local resources.
        #
        set resourceDir [acs_package_root_dir bootstrap-icons/www/resources]
        set cdnHost     cdnjs.cloudflare.com
        set cdn         //$cdnHost/

        if {[file exists $resourceDir/bootstrap-icons-$version]} {
            #
            # Local version is installed
            #
            set prefix  /resources/bootstrap-icons/bootstrap-icons-$version
            set cdnHost ""
            set cspMap  ""

            #
            # Unfortunately, the structure of the distributed .zip file is a
            # moving target. Sometimes, a sub folder "fonts" is used,
            # sometimes, minifiled versions are included. Check in the
            # filesystem, what we have actually got.
            #
            set fspath $resourceDir/bootstrap-icons-$version

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

            dict set URNs urn:ad:css:bootstrap-icons $fn
        } else {
            #
            # Use CDN
            #
            # cloudflare has e.g. the following resources:
            #
            #    https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/bootstrap-icons.svg
            #    https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css
            #    https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/icons/123.svg
            #
            # We just need the CSS file, which is on the CDN in the
            # "font" directory.
            #
            set prefix ${cdn}ajax/libs/bootstrap-icons/$version/font

            #
            # Use always the minified version over the CDN
            #
            dict set URNs   urn:ad:css:bootstrap-icons bootstrap-icons.min.css
            dict set cspMap urn:ad:css:bootstrap-icons [subst {
                style-src $cdnHost
                font-src $cdnHost
            }]
        }

        #
        # Return the dict with at least the required fields
        #
        lappend result \
            resourceName "Bootstrap Icons" \
            resourceDir $resourceDir \
            cdn $cdn \
            cdnHost $cdnHost \
            prefix $prefix \
            cssFiles {} \
            jsFiles  {} \
            extraFiles {} \
            downloadURLs https://github.com/twbs/icons/releases/download/v${version}/bootstrap-icons-${version}.zip \
            cspMap $cspMap \
            urnMap $URNs \
            versionCheckAPI {cdn cdnjs library bootstrap-icons count 1} \
            parameterInfo $parameter_info \
            configuredVersion $version

        return $result
    }

    ad_proc -private ::bootstrap_icons::download {
        {-version ""}
    } {
        Download Bootstrap Icons in the specified version and put it
        into a directory structure similar to the CDN to support the
        installation of multiple versions.
    } {
        set resource_info [resource_info -version $version]
        ::util::resources::download -resource_info $resource_info

        set resourceDir [dict get $resource_info resourceDir]
        ns_log notice " ::bootstrap_icons::download resourceDir $resourceDir"

        #
        # Do we have unzip installed?
        #
        set unzip [::util::which unzip]
        if {$unzip eq ""} {
            error "can't install Bootstrap Icons locally; no unzip program found on PATH"
        }

        #
        # Do we have a writable output directory under resourceDir?
        #
        if {![file isdirectory $resourceDir]} {
            file mkdir $resourceDir
        }
        if {![file writable $resourceDir]} {
            error "directory $resourceDir is not writable"
        }

        #
        # So far, everything is fine, unpack the downloaded zip file
        #
        foreach url [dict get $resource_info downloadURLs] {
            set fn [file tail $url]
            util::unzip \
                -overwrite \
                -source $resourceDir/$version/$fn \
                -destination $resourceDir
        }
    }
}


# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
