import 'package:agora_video_call/utils/AppID.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_recognition/speech_recognition.dart';

class RealTimeMessaging extends StatefulWidget {
  final String channelName;
  final String userName;
  RealTimeMessaging(this.channelName, this.userName);
  @override
  _RealTimeMessagingState createState() => _RealTimeMessagingState();
}

class _RealTimeMessagingState extends State<RealTimeMessaging> {
  bool _isLogin = false;
  bool _isInChannel = false;

  final _channelMessageController = TextEditingController();

  final _infoStrings = <String>[];

  AgoraRtmClient _client;
  AgoraRtmChannel _channel;

  SpeechRecognition _speechRecognition;
  bool _isAvailable = true;
  bool _isListening = false;

  String resultText = '';

  @override
  void initState() {
    super.initState();
    _createClient();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(
        (bool result) => setState(() => _isAvailable = result));
    _speechRecognition.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));
    _speechRecognition.setRecognitionResultHandler(
        (String speech) => setState(() => resultText = speech));
    _speechRecognition.setRecognitionCompleteHandler(
        () => setState(() => _isListening = false));
    _speechRecognition
        .activate()
        .then((result) => setState(() => _isAvailable = result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Face2Face Voice Chat",
          style: GoogleFonts.poppins(color: Colors.red[700]),
        ),
      ),
      body: Center(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                )),
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: [
                Text(
                  resultText,
                  style: GoogleFonts.poppins(fontSize: 30, color: Colors.white),
                ),
                _buildInfoList(),
                _buildSendChannelMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createClient() async {
    _client = await AgoraRtmClient.createInstance(appID);
    _client.onMessageReceived = (AgoraRtmMessage message, String peerId) async {
      _logPeer("Peer msg: " + peerId + ", msg: " + message.text);
      await _bolo(message.text);
    };
    _client.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
      if (state == 5) {
        _client.logout();
        print('Logout.');
        setState(() {
          _isLogin = false;
        });
      }
    };
    String userId = widget.userName;
    await _client.login(null, userId);
    print('Login success: ' + userId);
    setState(() {
      _isLogin = true;
    });
    String channelName = widget.channelName;
    _channel = await _createChannel(channelName);
    await _channel.join();
    print('Join channel success.');
    setState(() {
      _isInChannel = true;
    });
  }

  Future<AgoraRtmChannel> _createChannel(String name) async {
    AgoraRtmChannel channel = await _client.createChannel(name);
    channel.onMemberJoined = (AgoraRtmMember member) {
      print(
          "Member joined: " + member.userId + ', channel: ' + member.channelId);
    };
    channel.onMemberLeft = (AgoraRtmMember member) {
      print("Member left: " + member.userId + ', channel: ' + member.channelId);
    };
    channel.onMessageReceived =
        (AgoraRtmMessage message, AgoraRtmMember member) async {
      _bolo(message.text);
      _logPeer(message.text);
    };
    return channel;
  }

  Widget _buildSendChannelMessage() {
    if (!_isLogin || !_isInChannel) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          color: Colors.red[900],
          width: MediaQuery.of(context).size.width * 0.55,
          child: TextFormField(
            controller: _channelMessageController,
            decoration: InputDecoration(
              hintText: 'Comment...',
              hintStyle: GoogleFonts.poppins(color: Colors.white70),
              border: OutlineInputBorder(
                
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black, width: 5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black, width: 5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black, width: 5),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                color: Colors.black,
                width: 2,
              )),
          child: IconButton(
            icon: Icon(Icons.mic),
            onPressed: () {
              if (!_isListening) {
                _speechRecognition
                    .listen(locale: "en_US")
                    .then((result) => print('ITS WORKING : $result'));
                print('$resultText');
              }
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                color: Colors.black,
                width: 2,
              )),
          child: IconButton(
            icon: Icon(Icons.mic_off),
            onPressed: () {
              print('THE FINAL OUTPUT IS: $resultText');
              _speechRecognition.cancel().then((result) => setState(() {
                    _isListening = false;
                    resultText = '';
                  }));
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                color: Colors.black,
                width: 2,
              )),
          child: IconButton(
            icon: Icon(Icons.send, color: Colors.black),
            onPressed: _toggleSendChannelMessage,
          ),
        )
      ],
    );
  }

  Widget buildState() {
    return Container();
  }

  Widget _buildInfoList() {
    return Expanded(
        child: Container(
            child: _infoStrings.length > 0
                ? ListView.builder(
                    reverse: true,
                    itemBuilder: (context, i) {
                      return Container(
                        child: ListTile(
                          title: Align(
                            alignment: _infoStrings[i].startsWith('%')
                                ? Alignment.bottomLeft
                                : Alignment.bottomRight,
                            child: Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              color: Colors.grey.shade400,
                              child: _infoStrings[i].startsWith('%')
                                  ? Text(
                                      _infoStrings[i].substring(1),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.poppins(
                                          color: Colors.red[900]),
                                    )
                                  : Text(
                                      _infoStrings[i],
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.poppins(
                                          color: Colors.red[900]),
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: _infoStrings.length,
                  )
                : Container()));
  }

  void _toggleSendChannelMessage() async {
    String text = _channelMessageController.text;
    if (text.isEmpty) {
      print('Please input text to send.');
      return;
    }
    try {
      await _channel.sendMessage(AgoraRtmMessage.fromText(text));
      _log(text);
      _channelMessageController.clear();
      _bolo(text);
    } catch (errorCode) {
      print('Send channel message error: ' + errorCode.toString());
    }
  }

  void _logPeer(String info) {
    info = '%' + info;
    print(info);
    setState(() {
      _infoStrings.insert(0, info);
    });
  }

  void _log(String info) {
    print(info);
    setState(() {
      _infoStrings.insert(0, info);
    });
  }

  Future<void> _bolo(String text) async {
    String message = '';
    message = text;
    VoiceController controller = FlutterTextToSpeech.instance.voiceController();
    controller.init().then((_) {
      controller.speak(message, VoiceControllerOptions(delay: 0));
    });
  }
}
