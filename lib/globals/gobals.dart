library my_prj.globals;

int globGamingNumber = -1;
int globScore = 0;
String globFinishedTime = '';

// 遊戲id 對應 遊戲名稱
const Map gameMap = <int, String>{
  0: '數字點點名',
  1: '五顏配六色',
  10: '測試',
};

// current game ending record info
String globEndingRecordGameDateTime = '';
String globEndingRecordGameTime = '';
int globEndingRecordScore = 0;
