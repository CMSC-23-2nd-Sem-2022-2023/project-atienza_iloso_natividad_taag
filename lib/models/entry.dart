class Entry{
  String ? id;
  String ? date; 

  Entry(
    {
      required this.id,
      required this.date,
    }
  );

  static List<Entry> entryList(){
    return [
      Entry(id:'01', date:'05/25/2023'),
      Entry(id:'02', date:'05/24/2023'),
      Entry(id:'03', date:'05/23/2023'),
      Entry(id:'04', date:'05/22/2023'),
      Entry(id:'05', date:'05/21/2023'),
      Entry(id:'06', date:'05/20/2023'),
      Entry(id:'07', date:'05/19/2023'),
      Entry(id:'08', date:'05/18/2023'),
      Entry(id:'09', date:'05/217/2023'),
    ];
  }
}