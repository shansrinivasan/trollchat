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
		displayVid();
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
		console.log(profile['emails'][0].value)
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
	
	alert(player)
	
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
	  

