<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>File Manager</title>
    <script>
        // Helper function to get parameters from the query string.
        function getUrlParam( paramName ) {
            var reParam = new RegExp( '(?:[\?&]|&)' + paramName + '=([^&]+)', 'i' );
            var match = window.location.search.match( reParam );

            return ( match && match.length > 1 ) ? match[1] : null;
        }
        // Simulate user action of selecting a file to be returned to CKEditor.
        function returnFileUrl(fileName) {

            var funcNum = getUrlParam( 'CKEditorFuncNum' );
            var fileUrl = 'http://pcpics.localhost/'+fileName;
            window.opener.CKEDITOR.tools.callFunction( funcNum, fileUrl, function() {
                // Get the reference to a dialog window.
                var dialog = this.getDialog();
                // Check if this is the Image Properties dialog window.
                if ( dialog.getName() == 'image' ) {
                    // Get the reference to a text field that stores the "alt" attribute.
                    var element = dialog.getContentElement( 'info', 'txtAlt' );
                    // Assign the new value.
                    if ( element )
                        element.setValue( 'alt text' );
                }
                // Return "false" to stop further execution. In such case CKEditor will ignore the second argument ("fileUrl")
                // and the "onSelect" function assigned to the button that called the file manager (if defined).
                // return false;
            } );
            window.close();
        }
    </script>
</head>
<body>
    <button onclick="returnFileUrl()">Select File</button>
	<cfset qryListDirectory = directoryList('/home/masoodanwar85/Pictures',false,'query') />

	<cfquery name="qryListDirectory" dbtype="query">
		SELECT * FROM qryListDirectory ORDER BY type,name ASC
	</cfquery>
	<table>
	<cfoutput query="qryListDirectory">
		<tr>
			<td>
				<cfif qryListDirectory.type EQ 'Dir'>
					<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/OneDrive_Folder_Icon.svg/2048px-OneDrive_Folder_Icon.svg.png" width="20" />
				<cfelse>
					<img src="data:image/png;base64,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" width="30" />
				</cfif>
			</td>
			<td><a href="javascript:void(0);" onclick="returnFileUrl('#qryListDirectory.name#')" path="#qryListDirectory.directory#">#qryListDirectory.name#</a></td>
		</tr>
	</cfoutput>
	</table>
</body>
</html>
