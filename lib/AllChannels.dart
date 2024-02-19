import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class AllChannels extends StatefulWidget {
  final String appID ;
  // final String userID;
  const AllChannels({Key? key,required this.appID}) : super(key: key);

  @override
  State<AllChannels> createState() => _AllChannelsState();
}

class _AllChannelsState extends State<AllChannels> {

  final CHANNEL_URI = "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211";
  final apiURL = "https://api-BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF.sendbird.com";
  final apiToken = "f93b05ff359245af400aa805bafd2a091a173064";
  List<BaseMessage> messageList = [];
  OpenChannel? _channel;

  @override
  void initState(){
    loadOpenChannel();
    super.initState();
  }

  void loadOpenChannel()async{
    try{
      final sendbird = SendbirdSdk(appId: widget.appID);
      await sendbird.connect("test",apiHost: apiURL,accessToken: apiToken);
      final channel = await OpenChannel.getChannel(CHANNEL_URI);
      // final channel = await OpenChannel.getChannel(apiURL);
      await channel.enter();
      List<BaseMessage> messages = await channel.getMessagesById(1, MessageListParams());
      setState(() {
        messageList = messages;
      });
      // channel.getMessagesByTimestamp(DateTime.now().millisecondsSinceEpoch * 1000, params)
    } catch (e) {
      print('error');
     print(e);
    }
    // try{
    //   // final SendbirdSdk = await SendbirdSdk(wid)
    //   final sendbird = await SendbirdSdk(appId: widget.appID,apiToken: apiToken);
    //   // await sendbird.connect(apiHost: apiURL,);
    //
    //   _channel = await OpenChannel.getChannel(CHANNEL_URI);
    //   _channel!.enter();
    //   List<BaseMessage> messages = await  _channel!.getMessagesByTimestamp(DateTime.now().millisecondsSinceEpoch * 1000, MessageListParams());
    //   // print(_channel);
    //   // MessageList =
    //   setState(() {
    //     messageList = messages;
    //     // _channel = achannel;
    //   });
    //   // final _ = await sendbird.connect(
    //   //   "test",
    //   //   apiHost: apiURL,
    //   //   accessToken: apiToken
    //   // );
    //   // print(sendbird.getAppInfo());
    //   //
    //   // _channel = await OpenChannel.getChannel(CHANNEL_URI);
    //   // _channel!.enter();
    //   // _channel!.createPreviousMessageListQuery().load(limit: 30);
    //   // _channel!.;
    //   // _channel = await sendbird.openChannelWithUrl("sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac2911");
    //
    //   // final _ = await sendbird.connect(widget.userID);
    //   //
    //   // User user = await sendbird.connect(apiToken);
    //   //
    //   // OpenChannel channel = await sendbird. //(CHANNEL_URI);
    //   //
    //   // // Start listening for events and messages in the channel
    //   // channel.enter();
    //   // channel.createPreviousMessageListQuery().load(limit: 30);
    //
    //
    //   // OpenChannel.getChannel(CHANNEL_URI).then((openChannel) {
    //   //   final query = PreviousMessageListQuery(
    //   //     channelType: ChannelType.open,
    //   //     channelUrl: CHANNEL_URI,
    //   //   )..loadNext().then((messages) {
    //   //     setState(() {
    //   //       messageList
    //   //         ..clear()
    //   //         ..addAll(messages);
    //   //       // title = '${openChannel.name} (${messageList.length})';
    //   //       // hasPrevious = query.hasNext;
    //   //       // participantCount = openChannel.participantCount;
    //   //     });
    //   //   });
    //   // });
    //   // final CHANNEL_URI = "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac2911";
    //   // final sendbird = await SendbirdSdk(appId: widget.appID);
    //   // final _ = await sendbird.connect(widget.userID);
    //   // final openChannel = await OpenChannel.getChannel(CHANNEL_URI);
    //   // await openChannel.enter();
    //   // final query = await PreviousMessageListQuery(
    //   //   channelType: ChannelType.open,
    //   //   // channelUrl: "https://api-BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF.sendbird.com",
    //   //   channelUrl: "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac2911",
    //   // );
    //   // setState(() async {
    //   //   messageList = await query.loadNext();
    //   // });
    // // ..next().then((messages) {
    // // setState(() {
    // // messageList
    // // ..clear()
    // // ..addAll(messages);
    // // // title = '${openChannel.name} (${messageList.length})';
    // // // hasPrevious = query.hasNext;
    // // // participantCount = openChannel.participantCount;
    // // });
    // // });
    //   print(messageList.length);
    // }catch(e){
    //   print(e);
    // }
  }

  // ChatUser asDashChatUser(User? user){
  //   if(user == null){
  //     ChatUser(
  //         id: '',
  //         lastName: "",
  //         firstName: "",
  //         profileImage: ""
  //     );
  //   }
  //
  //   return ChatUser(
  //       id: user!.userId,
  //       firstName: user!.nickname,
  //       profileImage: user!.profileUrl
  //   );
  // }
  //
  // List<ChatMessage> asDashChatMessage(List<BaseMessage> messages){
  //   return [
  //     for (BaseMessage sbm in messages)
  //       ChatMessage(user: asDashChatUser(sbm.sender),
  //           createdAt: DateTime.now(),
  //           text: sbm.message
  //       )
  //   ];
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 400,
              color: Colors.red,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: messageList.length,
                itemBuilder: (Context,index){
                  BaseMessage message = messageList[index];
              return Text('${message.message}',style: TextStyle(color: Colors.yellow),);
          }),
            )
            // DashChat(
            //   messages: asDashChatMessage(messageList),
            //   currentUser: asDashChatUser(SendbirdSdk().currentUser),
            //   // currentUser: ChatUser(
            //   //     id: '',
            //   //   firstName: "",
            //   //   lastName: ""
            //   // ),
            //   onSend: (chatmessage){},
            // ),
            // Text(messageList as String)
          ],
        ),
      ),
    );
  }
}
