/* Code to handle waiting for transitions to complete */
/* written by djp3 */
var bombCount:Number=0;
function createBomb():MovieClip{
	var index:Number = bombCount++;
	var bomb= this.createEmptyMovieClip("bomb_"+index.toString()+"_mc", this.getNextHighestDepth());
	return(bomb);
}

function loadBomb(payload:Function):MovieClip{
	var bomb = createBomb();
	bomb.onTweenComplete=function(){
			payload();
			bomb.removeMovieClip();};
	return(bomb);
}

function triggerBomb(bomb:MovieClip){
	bomb.tween("_alpha",0,noDuration,"linear");
}

//This one sets off an arbitrary payload
function lightFusePayload(duration:Number,payload:Function){
	loadBomb(payload).tween("_alpha",0,duration,"linear");
}

//This one sets off the bomb
function lightFuseBomb(duration:Number,bomb:MovieClip){
	loadBomb(function(){triggerBomb(bomb)}).tween("_alpha",0,duration,"linear");
}

