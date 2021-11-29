<cfset baseURL = 'http://pcpics.localhost' />
<!--- <cfset basePath = '/home/masoodanwar85/Pictures' /> --->
<cfset basePath = '/home/masood/Pictures' />

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
        function returnFileUrl() {

            var funcNum = getUrlParam( 'CKEditorFuncNum' );
            var fileUrl = $('#preview').attr('src');

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

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$('#jstree_div').jstree({
				"core" : {
				    "animation" : 0,
				    "check_callback" : true,
				    "themes" : { "stripes" : true },
				    'data' : {
				      'url' : function (node) {
						  return node.id === '#' ? 'getChildren.cfm?root=1' : 'getChildren.cfm?root=2';
				      },
				      'data' : function (node) {
						  return { 'id' : node.id };
				      }
				    }
				  },
				"types" : {
				    "#" : {
				      "max_children" : 1,
				      "max_depth" : -1,
				      "valid_children" : ["root"]
				    },
				    "root" : {
				      "valid_children" : ["Dir"]
				    },
				    "file" : {
				      "icon" : "/ckeditor-file-manager-plugin/image-icon.png",
				      "valid_children" : []
				    }
				  },
				  "plugins" : [
				    "state", "types", "wholerow"
				  ]
			});

			$('#jstree_div').on("changed.jstree", function (e, data) {
				if (data.node) {
					if (data.node.type == 'file') {
						console.log(data.selected);
						$('#preview').attr('src','<cfoutput>#baseURL#</cfoutput>/'+data.selected[0]);
					} else {
						console.log(data.selected);
					}
				}
			});
		});
	</script>
</head>
<body>

	<table width="100%">
		<tr>
			<td width="40%" style="overflow:scroll;">
				<div id="jstree_div">
				</div>
			</td>
			<td width="10%"><button style="position:fixed;" onclick="returnFileUrl()">Select File</button></td>
			<td valign="top" style="overflow:scroll">
				<img src="" id="preview" />
			</td>
		</tr>
	</table>
</body>
</html>
