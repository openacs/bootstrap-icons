ad_library {

    Bootstrap icons

    This script defines the following public procs:

    ::bootstrap_icons::resource_info
    ::bootstrap_icons::download


    @author Gustaf Neumann
    @creation-date 1 Jan 2022
}

namespace eval ::bootstrap_icons {

    set package_id [apm_package_id_from_key "bootstrap-icons"]

    #
    # The Bootstrap Icons configuration can be tailored via the OpenACS
    # configuration file:
    #
    # ns_section ns/server/${server}/acs/bootstrap-icons
    #        ns_param BootstrapIconsVersion 1.11.3
    #
    set ::bootstrap_icons::version [parameter::get \
                                        -package_id $package_id \
                                        -parameter BootstrapIconsVersion \
                                        -default 1.11.3]

    ad_proc ::bootstrap_icons::resource_info {
        {-version ""}
    } {

        Get information about available version(s) of Bootstrap Icons,
        from the local filesystem, or from CDN.

    } {
        #
        # If no version is specified, use the namespaced variable.
        #
        if {$version eq ""} {
            set version $::bootstrap_icons::version
        }

        #
        # Setup variables for access via CDN vs. local resources.
        #
        set resourceDir [acs_package_root_dir bootstrap-icons/www/resources]
        set resourceUrl /resources/bootstrap-icons
        set cdnHost     cdnjs.cloudflare.com
        set cdn         //$cdnHost/

        if {[file exists $resourceDir/bootstrap-icons-$version]} {
            #
            # Local version is installed
            #
            set prefix  $resourceUrl/bootstrap-icons-$::bootstrap_icons::version
            set cdnHost ""
            set cspMap ""
        } else {
            #
            # Use CDN
            #
            # cloudflare has the following resources:
            #
            #    https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/bootstrap-icons.svg
            #    https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css
            #    https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/icons/123.svg
            #
            # We just need the CSS file, which is on the CDN in the
            # "font" directory.
            set prefix $cdn/ajax/libs/bootstrap-icons/$version/font
            set cspMap [subst {
                urn:ad:css:bootstrap-icons {
                    style-src $cdnHost
                    font-src $cdnHost
                }}]
            #
            #
            # Other potential source:
            #
            # @import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css");
            # <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
            #
            #set cdnHost cdn.jsdelivr.net

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
            urnMap {} \
            versionCheckURL "https://cdnjs.com/libraries?q=bootstrap-icons" \
            versionCheckAPI {cdn cdnjs library bootstrap-icons count 1} \
            installedVersion $version

        return $result
    }

    ad_proc -private ::bootstrap_icons::download {
        {-version ""}
    } {
        Download Bootstrap Icons in the specified version and put it
        into a directory structure similar to the CDN to support the
        installation of multiple versions.
    } {
        #
        # If no version is specified, use the namespaced variable.
        #
        if {$version eq ""} {
            set version ${::bootstrap_icons::version}
        }

        set resource_info [resource_info -version $version]
        ::util::resources::download \
            -resource_info $resource_info \
            -version_dir $version

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
