import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/params/group_channel_params.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';


class ChatScreen extends StatefulWidget {
  // final String appID = 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF';
  final String appID ;
  final String userID;
  final List<String> otherUsersId;
  ChatScreen({
  Key? key,
  required this.appID,
  required this.userID,
  required this.otherUsersId

  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  List<BaseMessage> _messages = [];
  GroupChannel? _channel;


  @override
  void initState(){
    load();
    // SendbirdSdk().addChannelEventHandler("chat", this);
    SendbirdSdk().addChannelEventHandler("chat", this as ChannelEventHandler);
    super.initState();
  }

  @override
  void dispose(){
    SendbirdSdk().removeChannelEventHandler("chat");
    super.dispose();
  }

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message){
    setState(() {
      _messages.add(message);
    });
    // super.onMessageReceived(channel, message);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(
          messages: asDashChatMessage(_messages),
          currentUser: asDashChatUser(SendbirdSdk().currentUser),
          // currentUser: ChatUser(
          //     id: '',
          //   firstName: "",
          //   lastName: ""
          // ),
          onSend: (chatmessage){},
      ),
    );
  }

  ChatUser asDashChatUser(User? user){
    if(user == null){
      ChatUser(
          id: '',
        lastName: "",
        firstName: "",
        profileImage: ""
      );
    }

    return ChatUser(
      id: user!.userId,
      firstName: user!.nickname,
      profileImage: user!.profileUrl
    );
  }

  List<ChatMessage> asDashChatMessage(List<BaseMessage> messages){
    return [
      for (BaseMessage sbm in messages)
        ChatMessage(user: asDashChatUser(sbm.sender),
            createdAt: DateTime.now(),
          text: sbm.message
        )
    ];
  }

  void load()async{
    try{
      // final sendbird = await SendbirdSdk(appId: widget.appID);
      // final _ = await sendbird.connect(widget.userID);
      // final query = await GroupChannelListQuery()..limit = 1
      // ..userIdsExactlyIn = widget.otherUsersId;
      //
      // List<GroupChannel> channels = await query.loadNext();
      // GroupChannel achannel;
      //
      // if(channels.length == 0){
      //   achannel = await GroupChannel.createChannel(GroupChannelParams()..userIds = widget.otherUsersId+ [widget.userID]);
      // }else{
      //   achannel = channels[0] as GroupChannel;
      // }
      //
      // List<BaseMessage> messages = await achannel.getMessagesByTimestamp(DateTime.now().millisecondsSinceEpoch * 1000, MessageListParams());
      //
      // setState(() {
      //   _messages = messages;
      //   _channel = achannel;
      // });

      final CHANNEL_URL = "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac2911";
      final channel = await OpenChannel.getChannel(CHANNEL_URL);
      await channel.enter();
    }catch(e){
      print(e);
    }
  }

}
