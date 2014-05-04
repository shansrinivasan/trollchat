<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Simple Chat</title>
		<g:javascript library="application"/>		
		<r:layoutResources />
</head>
<body>
<g:form action="join">
    <label for="tcHandle">Please enter your name</label>
    <g:textField name="tcHandle"/><br/>
    <label for="nickname">Please enter your email</label>
    <g:textField name="email"/><br/>
    <label for="nickname">Please enter your url</label>
    <g:textField name="url"/><br/>
    <g:submitButton name="Join Chat"/>
</g:form>
</body>
</html>
