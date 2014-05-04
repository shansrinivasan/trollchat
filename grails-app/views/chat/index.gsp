<html>
<head data-gwd-animation-mode="quickMode">
    <title>ChatDash</title>
    <link href="/TrollChat/css/application.css" rel="stylesheet" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="generator" content="Google Web Designer 1.0.6.0428">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js" ></script>
	<!-- <script src="../../../webapp/js/start.js" ></script>-->
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

var userEmail = "";
  var helper = (function() {
  var BASE_API_PATH = 'plus/v1/';

  return {
    /**
     * Hides the sign in button and starts the post-authorization operations.
     *
     * @param {Object} authResult An Object which contains the access token and
     *   other authentication information.
     */
    onSignInCallback: function(authResult) {
      gapi.client.load('plus','v1', function(){
        $('#authResult').html('Auth Result:<br/>');
        for (var field in authResult) {
          $('#authResult').append(' ' + field + ': ' +
              authResult[field] + '<br/>');
        }
		
        if (authResult['access_token']) {
        	//alert(1)
		//displayVid();
		//window.location.href = "mainpage.htm"
		//helper.display();
		
		//add after success code here
          //$('#authOps').show('slow');
          $('#gConnect').hide();
          helper.profile();
          
          //helper.people();
        } else if (authResult['error']) {
          // There was an error, which means the user is not signed in.
          // As an example, you can handle by writing to the console:
          console.log('There was an error: ' + authResult['error']);
          $('#authResult').append('Logged out');
          $('#authOps').hide('slow');
          $('#gConnect').show();
        }
        console.log('authResult', authResult);
      });
    },
	
	display: function() {
	},
	
	display2: function() {
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
		$.ajax({
        type: 'GET',
        url: 'http://localhost:8080/TrollChat/api/NowTrolling',
        async: true,
        contentType: 'application/json',
        dataType: 'json',
        success: function(result) {
          console.log('revoke response: ' + result);
          //$('#authOps').hide();
          //$('#profile').empty();
          //$('#visiblePeople').empty();
          //$('#authResult').empty();
          //$('#gConnect').show();
        },
        error: function(e) {
          console.log(e);
        }
      });
	},

    /**
     * Calls the OAuth2 endpoint to disconnect the app for the user.
     */
    disconnect: function() {
      // Revoke the access token.
      $.ajax({
        type: 'GET',
        url: 'https://accounts.google.com/o/oauth2/revoke?token=' +
            gapi.auth.getToken().access_token,
        async: false,
        contentType: 'application/json',
        dataType: 'jsonp',
        success: function(result) {
          console.log('revoke response: ' + result);
          $('#authOps').hide();
          $('#profile').empty();
          $('#visiblePeople').empty();
          $('#authResult').empty();
          $('#gConnect').show();
		  resetDisplay();
        },
        error: function(e) {
          console.log(e);
        }
      });
    },

    /**
     * Gets and renders the list of people visible to this app.
     */
    people: function() {
      var request = gapi.client.plus.people.list({
        'userId': 'me',
        'collection': 'visible'
      });
      request.execute(function(people) {
        $('#visiblePeople').empty();
        $('#visiblePeople').append('Number of people visible to this app: ' +
            people.totalItems + '<br/>');
        for (var personIndex in people.items) {
          person = people.items[personIndex];
          $('#visiblePeople').append('<img src="' + person.image.url + '">');
        }
      });
    },

    /**
     * Gets and renders the currently signed in user's profile data.
     */
	 
    profile: function(){
      var request = gapi.client.plus.people.get( {'userId' : 'me'} );
	  
      request.execute( function(profile) {
        $('#profile').empty();
        //alert("***********" + profile)
		userEmail = profile['emails'][0].value;
        firstDisplay();
        addSearchBtn();
        if (profile.error) {
          $('#profile').append(profile.error);
          return;
        }
        $('#profile').append(
            $('<p><img src=\"' + profile.image.url + '\"></p>'));
        $('#profile').append(
            $('<p>Hello ' + profile.displayName + '!<br />Tagline: ' +
            profile.tagline + '<br />About: ' + profile.aboutMe + '</p>'));
        if (profile.cover && profile.coverPhoto) {
          $('#profile').append(
              $('<p><img src=\"' + profile.cover.coverPhoto.url + '\"></p>'));
        }
      });
    }
  };
})();

  function addSearchBtn() {
	  var $srchBtn= $('<input/>').attr({ id: 'srchBtn', type: 'button', name:'btn1', value:'Search'}).click(function() {
	  		searchVideo();
	  	});
	  	$('#srchbtndiv').append($srchBtn);
	  }
  
  function firstDisplay() {
		//alert(userEmail)
		var request = gapi.client.plus.people.get({
   'userId': 'me'
 });
		gapi.client.load('oauth2', 'v2', function() {
			  gapi.client.oauth2.userinfo.get().execute(function(resp) {
			    // Shows user email
			    console.log(resp.email);
			    userEmail = resp.email;
			  })
			});
		//userEmail

		 //return;
		 
		var tch = userEmail.split("@")[0];
		window.location.href = "/chat/join?tcHandle=" + tch + "&email=" + userEmail + "&url=" + $('#srchbox').val().split('v=')[1];
		//$('#t1').val(userEmail);
		//$('#t2').val(userEmail);
		//$('#url').val($('#srch').val().split('v=')[1]);//alert(userEmail)
		//$('#mainFrm').submit();
	}


  /**
   * Calls the helper method that handles the authentication flow.
   *
   * @param {Object} authResult An Object which contains the access token and
   *   other authentication information.
   */
  function onSignInCallback(authResult) {
    helper.onSignInCallback(authResult);
  }

  var videoid = 'M7lc1UVf-VE';
  function displayVid() {
  	var $srchBtn= $('<input/>').attr({ id: 'srchBtn', type: 'button', name:'btn1', value:'Search'}).click(function() {
  		searchVideo();
  	});
  	$('#srchbtndiv').append($srchBtn);
  	var $signOutBtn = $('<input/>').attr({ id: 'signOutBtn', type: 'button', name:'btn2', value:'SignOut'}).click(function() {
  		helper.disconnect();
  	});
  	//$('#signOutDiv').append($signOutBtn);
  	
  	
  	var $nxtBtn = $('<input/>').attr({ id: 'nxtBtn', type: 'button', name:'btn3', value:'Next'}).click(function() {
  		loadNextVideo();
  	});
  	//$('#nxtCell').append($nxtBtn);
  	
  	$('#mainPg').show();
  	videoid = $('#srchbox').val().split('v=')[1];
  	var tag = document.createElement('script');
  	//addUser(userEmail, userEmail, videoid);

        tag.src = "https://www.youtube.com/iframe_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
  	  
  	  //var $titleDiv= $('<div/>').attr({ id: 'title', innerText: 'test'});
  	  if(videoid != null) {
  	  $('#playerCell').append("<div id='titleDiv'>asdfsdfadfaf</div>");
  	  }
  	  //$('#titleDiv').innerHTML = 'test';
  	  
  }

  function loadNextVideo() {
  	$('#ytplayer').show();
  	$('#titleDiv').remove();
  	//addUser(userEmail, userEmail, videoid);
  	$('#playerCell').append("<div id='titleDiv'>" +player.getVideoData().title+"</div>");
  	player.loadVideoById(vid);
  }

  function resetDisplay() {
  	//$('#srchBtn').remove();
  	//$('#signOutBtn').remove();
  	var $logoutFrame = $('<iframe/>').attr({src: 'https://accounts.google.com/logout'});
  	$('#mainPg').append($logoutFrame);
  	//window.location.reload();
  }

  function searchVideo() {
  $('#ytplayer').show();

  	var vid = $('#srchbox').val().split('v=')[1];
  	player.loadVideoById(vid);
  	
  	//alert(player)
  	
  }

  // Replace the 'ytplayer' element with an <iframe> and
    // YouTube player after the API code downloads.
    var player;
    function onYouTubePlayerAPIReady() {
    var v = $('#srchbox').val().split('v=')[1];
    if(v == null) {
  	$('#ytplayer').hide();
    };
      player = new YT.Player('ytplayer', {
        height: '390',
        width: '640',
        videoId: v,
  	  events: {
              'onReady': onPlayerReady,
              'onStateChange': onPlayerStateChange
            }
      });
    }
    
    // 4. The API will call this function when the video player is ready.
        function onPlayerReady(event) {
  	  
  	  //$('#titleDiv').remove();
  	$('#playerCell').append("<div id='titleDiv'>" +player.getVideoData().title+"</div>");
          event.target.playVideo();
        }

        // 5. The API calls this function when the player's state changes.
        //    The function indicates that when playing a video (state=1),
        //    the player should play for six seconds and then stop.
        var done = false;
        function onPlayerStateChange(event) {
          if (event.data == YT.PlayerState.PLAYING && !done) {
            setTimeout(stopVideo, 6000);
            done = true;
          }
        }
        function stopVideo() {
          player.stopVideo();
        }
  	  

  	
  </script></head>
	<body>
	<div class="container">
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				 <div class="homepage-logo" >
			<img src="/TrollChat/images/chatdash_Logo_large.jpg"/>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<form class="form-horizontal">
			  

	      	<div class="homepage-center">
	        <input type="text" class="form-control" id="srchbox" placeholder="Url">
			</div>
		</div>

			  <div class="row">
			  	<div class="col-md-offset-2 col-md-8">
			  		<div class="homepage-center">

			  	<span class="help-block">add chat to your dash</span>
			  </div>
			</div>
						  	<div class="col-md-offset-2 col-md-8">
			  		<div class="homepage-center">

			    <div class="form-group">
			        <div id="gConnect">
    <button class="g-signin"
        data-scope="https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email"
        data-requestvisibleactions="http://schemas.google.com/AddActivity"
        data-clientId="948994549482-jcl82o2uupvmfeuh6u4u6n4adruujo5f.apps.googleusercontent.com"
        data-callback="onSignInCallback"
        data-theme="dark"
        data-cookiepolicy="single_host_origin">Search</button>
  </div><div id="srchbtndiv"></div>
			      </div>
			    </div>

			</form>
		</div>
	</div>
</div>

	</div>
</div>
</div>
</div>
	
	<div align="right" id="signOutDiv"></div>
	<table><tr>
	<td></td><td></td>
	<td></td>
  </tr></table>
  <div id="mainPg">
  <table><tr><td id="playerCell"><div class="gwd-div-ftpg" id="ytplayer"></div></td><td id="nxtCell"></td></tr></table>
  </div>
	</body>
</html>