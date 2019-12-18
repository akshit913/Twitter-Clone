// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"
import socket from "./socket"
import "phoenix_html"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
let channel = socket.channel('room:*', {});
channel.join(); // join the channel.

let username;
let tweetString;
let tofollow;
      // list of messages.
// if(document.getElementById('inpf')){
// 	username = document.getElementById('inpf').value;
// 	console.log(username);
// }
// if(document.getElementById('inptweet')){
// 	tweetString = document.getElementById('inptweet').value;
// 	console.log(tweetString)
// }
// if(document.getElementById('inpsubs')){
// 	tofollow = document.getElementById('inpsubs').value;
// }

          // name of message sender            // message input field
//document.getElementById('btnhash').addEventListener('keypress', hashFun());
// "listen" for the [Enter] keypress event to send a message:

if(document.getElementById('regbtn')){
	document.getElementById('regbtn').onclick = function(){hashFun();};
}
function hashFun()
{
	console.log("jj");
	console.log(username);
	username = document.getElementById('inpf').value;
	channel.push("registerUser",{name: username});
}
if(document.getElementById('btntweet')){
	document.getElementById('btntweet').onclick = function(){btntweet1();};
}

function btntweet1(){
	console.log("inside the tweetfunction");
	username = document.getElementById('inpf').value;
	tweetString = document.getElementById('inptweet').value;
	channel.push("tweet",{userId : username,tweet : tweetString});
}
if(document.getElementById('btnsubs')){
	document.getElementById('btnsubs').onclick = function(){btnsubs1();};
}

function btnsubs1(){
	console.log("inside the function");
	username = document.getElementById('inpf').value;
	tofollow = document.getElementById('inpsubs').value;
	channel.push("follow",{userId : username,accountId : tofollow});
}
if(document.getElementById('btnmention')){

	document.getElementById('btnmention').onclick = function(){btnmen();};
}

function btnmen(){
	console.log("inside the function");
	//document.getElementById('btnmention').onclick = function(){document.getElementById("inpmention").value = "Paragraph changed!"};
	username = '@' + document.getElementById('inpf').value;
	console.log(username);
	channel.push("tweetsWithMention",{userId : username});

}
channel.on('repTweetsWithMention',payload => {
	console.log(payload.userId);
	console.log(payload.list);
	//document.getElementById("target").innerHTML = payload.list;
	document.getElementById("inpmention").value = payload.list;
});
if(document.getElementById('btnhash')){

	document.getElementById('btnhash').onclick = function(){btnhash();};
}

function btnhash(){
	console.log("inside the function");
	//document.getElementById('btnmention').onclick = function(){document.getElementById("inpmention").value = "Paragraph changed!"};
	username = document.getElementById('inpf').value;
	let hashtag = document.getElementById('inphash').value;
	console.log(username);
	channel.push("tweetsWithHashtag",{userId : username,tag : hashtag});

}
channel.on('repTweetsWithHashtag',payload => {
	console.log(payload.userId);
	console.log(payload.list);
	document.getElementById("inphash").value = payload.list;
});
	


//channel.on('registerConfirmed', function (){
	//window.open("/main");
//}


//document.getElementById('')
//document.getElementById('btntweet').addEventListener('keypress', tweetFun());
//document.getElementById('btnsubs').addEventListener('keypress', followFun());
//document.getElementById('btnmention').addEventListener('keypress', 	menFun());
//document.getElementById('btnhash').addEventListener('keypress', hashFun());
//document.getElementById('delbtn').onclick = function(){document.getElementById("inpf").value = "Paragraph changed!"};

//document.getElementById('btntweet').addEventListener('keypress', registerFun());

//document.getElementById('dltBtn').onclick = function(){document.getElementById("inptweet").value = "Paragraph changed!"};


// Import local files
//
// Local files can be imported directly using relative paths, for example:
// 
