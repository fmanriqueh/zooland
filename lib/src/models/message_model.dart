class MessageList {
  List<MessageModel> _messageList;
  
  List<MessageModel> fromJson(messages) {
    _messageList = List();
    messages.forEach((uid, data) {
      _messageList.add(MessageModel.fromJson(data));
    });
    
    _messageList.sort((a,b) => b.timestamp['timestamp'].compareTo(a.timestamp['timestamp']) );
    return _messageList;
  }
}

class MessageModel {
  Map timestamp;
  String value;
  String author;

  MessageModel({
    this.author,
    this.value,
    this.timestamp
  });

  static MessageModel fromJson(message) {
    return MessageModel(
      author: message['author'],
      timestamp: {'timestamp' : message['timestamp']},
      value: message['value']
    );
  }

  Map<String, dynamic> toJson() => {
    'value'    : this.value,
    'author'   : this.author,
    'timestamp': this.timestamp
  };

}