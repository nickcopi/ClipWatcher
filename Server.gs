function myFunction() {
  
}
function doPost(e) {
  var body = JSON.parse(e.postData.contents);
  if(!('clipboard' in body)){
    return ContentService.createTextOutput('Invalid Request: ' + JSON.stringify(body));
  }
  var dumpSheet =  SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Sheet1');
  dumpSheet.getRange(1, 1).setValue(body.clipboard)
  return ContentService.createTextOutput('Set');
}