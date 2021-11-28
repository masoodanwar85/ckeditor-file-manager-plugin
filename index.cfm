<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>CKEditor</title>
		<script src="https://cdn.ckeditor.com/4.17.1/standard/ckeditor.js"></script>
	</head>
	<body>
		<textarea name="editor1"></textarea>
		<script>
			var config = {
				fullPage: true,
				filebrowserBrowseUrl: 'browser/browse.cfm?type=Files',
				filebrowserUploadUrl: 'uploader/upload.php?type=Files'
			};
			CKEDITOR.replace( 'editor1' , config);
		</script>
	</body>
</html>
