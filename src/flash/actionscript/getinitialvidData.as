﻿package actionscript
{
	import flash.display.Sprite;
	import flash.display.*;
	import flash.events.*;
	import flash.external.*;

	public class getinitialvidData
	{
		private var arr:Array;
		private var bArr:Array;
		private var config:Object;
		private var id:Number;
		private var reference:Sprite;
		private var preview:Preview;
		private var videoType:String;
		public function getinitialvidData(Ref,Config)
		{
			reference = Ref;
			arr = new Array();
			bArr = new Array();
			config = Config;
			getVidId();
		}
		//======================================= get video initial data ============================================================
		public function getVidId()
		{
			if (config['local'] == 'true')
			{
				dataget();
			}
			else
			{
				if (config['embedplayer'] != "true" && config['pageURL'] != null && ExternalInterface.call("window.location.href.toString") != null && (ExternalInterface.call("window.location.href.toString").indexOf('?videoID=') > -1 || ExternalInterface.call("window.location.href.toString").indexOf('?video_id=') > -1) && config['intP'] == true)
				{
					config['intP'] = false;
					if(ExternalInterface.call("window.location.href.toString").indexOf('?videoID=') > -1)
					{
						var arrss:Array = ExternalInterface.call("window.location.href.toString").split('?videoID=');
						config['vid'] = arrss[arrss.length - 1];
					}
					else
					{
						var arrss:Array = new Array()
						if(ExternalInterface.call("window.location.href.toString").indexOf('&post_id') > -1)
						{
							var arrss:Array = ExternalInterface.call("window.location.href.toString").split('&post_id=');
							var stt:String = arrss[0]
							arrss = new Array()
							arrss = stt.split('?video_id=');
							
						}
						else
						{
							arrss = ExternalInterface.call("window.location.href.toString").split('?video_id=');
						}
						config['vid'] = Number(arrss[1])
						
						for (var s:int = 0; s<config['plistlength']; s++)
						{
							if(config['vid'] == config['video_id'][s])
							{
								config['vid'] = s;
								break;
							}
							else config['vid'] = arrss[arrss.length - 1];
						}
					}
					if(config['vid']>=config['plistlength'])config['vid'] = 0
				}
				else
				{
					dataget();
				}
			}
			config['file'] = "";
			var getvideoDetail = new getvideoData(config);
			videoType = config['HD_default'];
			if (videoType == "true")
			{
				config['videoType'] = "hd";
			}
			else
			{
				config['videoType'] = "normal";
			}
			switch (config['videoType'])
			{
				case "normal" :
					if (! reference.root.loaderInfo.parameters['file'])
					{
						if (config['plistlength'] != 0)
						{
							config['file'] = config['video_url'][config['vid']];
							config['preview'] = String(config['preview_image'][config['vid']]);
							config['streamer'] = config['streamer_path'][config['vid']];
							if (config['file'] == "")
							{
								config['file'] = config['video_hdpath'][config['vid']];
							}
						}
						else
						{
							config['file'] = reference.root.loaderInfo.parameters['hdpath'];
							config['preview'] = reference.root.loaderInfo.parameters['preview'];
							config['streamer'] = reference.root.loaderInfo.parameters['streamer'];
							config['isLive'] = reference.root.loaderInfo.parameters['isLive'];
							config['playlist_auto'] = "false";
						}
					}
					else
					{
						config['file'] = reference.root.loaderInfo.parameters['file'];
						config['preview'] = reference.root.loaderInfo.parameters['preview'];
						config['streamer'] = reference.root.loaderInfo.parameters['streamer'];
						config['isLive'] = reference.root.loaderInfo.parameters['isLive'];
						config['playlist_auto'] = "false";
					}
					config['skinMc'].hd.hdOffmode.visible = true;
					config['skinMc'].hd.hdOnmode.visible = false;
					if (config['file'] == "" || config['file'] == undefined)
					{
						config['file'] = reference.root.loaderInfo.parameters['hdpath'];
						config['playlist_auto'] = "false";
					}
					break;
				case "hd" :
					if (! reference.root.loaderInfo.parameters['hdpath'])
					{
						if (config['plistlength'] != 0)
						{
							config['file'] = config['video_hdpath'][config['vid']];
							config['preview'] = config['preview_image'][config['vid']];
							config['streamer'] = config['streamer_path'][config['vid']];
							if (config['file'] == "")
							{
								config['file'] = config['video_url'][config['vid']];
							}
						}
						else
						{
							config['file'] = reference.root.loaderInfo.parameters['file'];
							config['preview'] = reference.root.loaderInfo.parameters['preview'];
							config['streamer'] = reference.root.loaderInfo.parameters['streamer'];
							config['isLive'] = reference.root.loaderInfo.parameters['isLive'];
							config['playlist_auto'] = "false";
						}
					}
					else
					{
						config['file'] = reference.root.loaderInfo.parameters['hdpath'];
						config['preview'] = reference.root.loaderInfo.parameters['preview'];
						config['streamer'] = reference.root.loaderInfo.parameters['streamer'];
						config['isLive'] = reference.root.loaderInfo.parameters['isLive'];
						config['playlist_auto'] = "false"
						 ;
					}
					config['skinMc'].hd.hdOffmode.visible = false;
					config['skinMc'].hd.hdOnmode.visible = true;
					if (config['file'] == "" || config['file'] == undefined)
					{
						config['file'] = reference.root.loaderInfo.parameters['file'];
						config['playlist_auto'] = "false";
					}
					break;
			}
			config['hd'] = "true";
			config['skinMc'].hd.visible = true;
			if (config['file'] != undefined)
			{
				if (config['file'].indexOf('youtube') <= -1 && config['file'].indexOf('dailymotion') <= -1 && config['file'].indexOf('viddler') <= -1)
				{
					if ((reference.loaderInfo.parameters.file || config['video_url'][config['vid']]!= "") && (reference.loaderInfo.parameters.hdpath || config['video_hdpath'][config['vid']] != ""))
					{
						config['hd'] = "true";
					}
					else
					{
						config['hd'] = "false";
					}
				}
			}
			var skinArrnge = new skinarrnge(config);
			if (config['autoplay'] == 'false' && config['mov'] == 1 && config['update'] == false)
			{
				if (config['local'] != 'true' && config['embedplayer'] != "true")
				{
					ExternalInterface.call('currentVideo',config['vid_id'],config['video_id']);
					
					if(reference.root.loaderInfo.parameters['baserefWP'] || reference.root.loaderInfo.parameters['baserefW'])
					{
						if(reference.root.loaderInfo.parameters['videodata'])ExternalInterface.call(reference.root.loaderInfo.parameters['videodata'],config['vid_id'], config['title'])
			            else ExternalInterface.call('current_video',config['vid_id'], config['title'])
					}
					else
					{
						if(reference.root.loaderInfo.parameters['mid'])ExternalInterface.call('currentvideom',config['vid_id'], config['title'], config['caption_video'][config['vid']],config['video_views'][config['vid']]);
						else{
							 
							 ExternalInterface.call('getvideoData',config['vid_id'],config['title'], config['caption_video'][config['vid']]);
						}
					}
				}
				preview = new Preview(reference,config);
				preview.loadPreview();
			}
			else
			{
				if (config['mov'] == 1 && config['ini'] == false && config['pre_vid'] == config['vid'] && config['update'] == false)
				{
					preview = new Preview(reference,config);
					preview.loadPreview();
				}
				else
				{
					if (config['local'] != 'true' && config['embedplayer'] != "true")
					{
						ExternalInterface.call('currentVideo',config['vid_id'],config['video_id']);
						if(reference.root.loaderInfo.parameters['baserefWP'] || reference.root.loaderInfo.parameters['baserefW'])
						{
							if(reference.root.loaderInfo.parameters['videodata'])ExternalInterface.call(reference.root.loaderInfo.parameters['videodata'],config['vid_id'], config['title'])
							else ExternalInterface.call('current_video',config['vid_id'], config['title'])
						}
						else
						{
							if(reference.root.loaderInfo.parameters['mid'])ExternalInterface.call('currentvideom',config['vid_id'], config['title'], config['caption_video'][config['vid']],config['video_views'][config['vid']]);
							else
							{
								 
								 ExternalInterface.call('getvideoData',config['vid_id'],config['title'], config['caption_video'][config['vid']]);
							}
						}
					}
					var getvideo = new findVideoType(reference,config);
				}

			}
			config['update'] = false;
		}
		private function shuffle(a,b):int
		{
			var num = Math.round(Math.random() * 2 - 1);
			return num;
		}
		private function dataget()
		{
			if ((reference.root.loaderInfo.parameters['videoID'] || reference.root.loaderInfo.parameters['video_id']) && config['intP'] == true)
			{
				config['intP'] = false;
				if(reference.root.loaderInfo.parameters['videoID'])config['vid'] = reference.root.loaderInfo.parameters['videoID'];
				else 
				{
					var idd:Number=reference.root.loaderInfo.parameters['video_id'];
					for (var j:int = 0; j<config['plistlength']; j++)
					{
						if(idd == config['video_id'][j])
						{
							config['vid'] = j;
							break;
						}
						else config['vid'] = reference.root.loaderInfo.parameters['videoID'];
					}
					config['vid'] = reference.root.loaderInfo.parameters['videoID'];
				}
				if(config['vid']>=config['plistlength'])config['vid'] = 0
			}
			else if (config['plistlength'] !=0)
			{
				config['intP'] = false;
				if (config['plistrandom'] == "true" && config['update'] == false)
				{
					for (var i:int = 0; i<config['plistlength']; i++)
					{
						arr[i] = i;
						bArr = arr.sort(shuffle);
						config['vid'] = bArr[0];
					}
				}
			}
		}
	}
}