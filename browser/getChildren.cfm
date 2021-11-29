<cfheader name="Content-Type" value="application/json">

<cfset baseURL = 'http://pcpics.localhost' />
<!--- <cfset basePath = '/home/masoodanwar85/Pictures' /> --->
<cfset basePath = '/home/masood/Pictures' />

<cfparam name="URL.id" default="" />

<cfif URL.id EQ '##'>
    <cfset URL.id = '' />
</cfif>

<cfif len(trim(URL.id))>
    <cfset URL.id = '/' & URL.id />
</cfif>

<cfset path = basePath & URL.id />

<cfscript>
	boolean function filterBySize(path, type, extension) {
		var extensionList = "jpg,jpeg,gif,png";
		if(listFindNoCase(extensionList,extension) OR type is 'dir') {
			return true;
		}
		return false;
	}
</cfscript>

<cfset qryListDirectory = directoryList(path,false,'query', filterBySize, 'Type ASC,Name ASC') />

<cfset aryResponse = arrayNew(1) />
<cfset stInfo = structNew() />
<cfloop query="qryListDirectory">
    <cfset structClear(stInfo) />
    <cfset nodeId = qryListDirectory.directory & '/' & qryListDirectory.name />
    <cfset stInfo = {
        "id" = replaceNoCase(nodeId,basepath & '/','','one'),
        "text" = qryListDirectory.name,
        "type" = qryListDirectory.type EQ 'Dir' ? 'root' : 'file'
        } />

    <cfif qryListDirectory.type EQ 'dir'>
        <cfset qryListChildren = directoryList(qryListDirectory.directory,false,'query') />
        <cfif qryListChildren.recordCount>
            <cfset stInfo['children'] = true />
        </cfif>
    </cfif>
    <cfset arrayAppend(aryResponse, duplicate(stInfo)) />
</cfloop>

<cfoutput>
    #serializeJSON(aryResponse)#
</cfoutput>
