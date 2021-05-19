
class ToDoModel
{
    String _title;
    bool _done = false;
    String documentId;

    ToDoModel({String title})
    {
      this._title = title;
    }

    Map<String,dynamic> toJson(){
      return{
        "title": _title,
        "status": _done
      };
    }

    ToDoModel.fromJson(Map<String,dynamic> jsonData, String docId)
    {
        documentId = docId;
        _title = jsonData['title'];
        _done = jsonData['status'];
    }


    void setStatus(bool status)
    {
      this._done = status;
    }

    String getTitle()
    {
        return this._title;
    }

    bool getStatus(){
      return this._done;
    }
}