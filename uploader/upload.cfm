<cfset fileUploadDirectoryURL = "http://pcpics.localhost/Uploads" />
<cfheader name="Content-Type" value="application/json">

<cffile action="upload" fileField="form.upload" destination="/home/masood/Pictures/Uploads" result="stResult" nameConflict="makeUnique" />
<cfoutput>
    #serializeJSON({
        'fileName' = "#stResult.serverFile#",
        'uploaded' = 1,
        'url' = "#fileUploadDirectoryURL#/#stResult.serverFile#"
    })#
</cfoutput>
