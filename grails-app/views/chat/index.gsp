<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Simple Chat</title>
		<g:javascript library="application"/>		
		<r:layoutResources />
		<g:javascript src="jquery-2.1.0.min.js"/>
	 <g:javascript src="start.js"/>
	 <script type="text/javascript">
  (function() {
    var po = document.createElement('script');
    po.type = 'text/javascript'; po.async = true;
    po.src = 'https://plus.google.com/js/client:plusone.js';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(po, s);
  })();
  
  /**
 * jQuery initialization
 */
$(document).ready(function() {
  $('#disconnect').click(helper.disconnect);
  //$('#trollbtn').click(test);
  $('#loaderror').hide();
  //$('#contentpg').hide();
  if ($('[data-clientid="YOUR_CLIENT_ID"]').length > 0) {
    alert('This sample requires your OAuth credentials (client ID) ' +
        'from the Google APIs console:\n' +
        '    https://code.google.com/apis/console/#:access\n\n' +
        'Find and replace YOUR_CLIENT_ID with your client ID.'
    );
  }
});

function firstDisplay() {
	//$('#t1').val(userEmail);
	//$('#t2').val(userEmail);
	$('#url').val($('#srch').val().split('v=')[1]);//alert(userEmail)
	$('#mainFrm').submit();
}
  </script>
</head>
<body>
<g:form id="mainFrm" action="join">
<input type="text" id="srch"/><div id="gConnect">
    <button class="g-signin"
        data-scope="https://www.googleapis.com/auth/plus.login"
        data-requestvisibleactions="http://schemas.google.com/AddActivity"
        data-clientId="948994549482-jcl82o2uupvmfeuh6u4u6n4adruujo5f.apps.googleusercontent.com"
        data-callback="onSignInCallback"
        data-theme="dark"
        data-cookiepolicy="single_host_origin">Search</button>
  </div>
  <div style="">
<g:textField name="tcHandle"/>
<g:textField name="email"/>
<g:textField name="url"/>
</div>
</g:form>
<!--<g:form action="join">
    <label for="tcHandle">Please enter your name</label>
    <g:textField name="tcHandle"/><br/>
    <label for="nickname">Please enter your email</label>
    <g:textField name="email"/><br/>
    <label for="nickname">Please enter your url</label>
    <g:textField name="url"/><br/>
    <g:submitButton name="Join Chat"/>
</g:form>-->
</body>
</html>
