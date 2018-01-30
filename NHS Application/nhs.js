var docTemplate = '16b8EWGJloXMyu_tAEU9ctCxTZZarKv_Q5E5g67EVBs4';

function sendEmailToStudent(e) {
    var student_id = e.values[1];
    var last_name = e.values[2];
    var first_name = e.values[3];
    var middle_initial = e.values[4];
    var nickname = e.values[5];
    var class_ = e.values[6];
    var email = e.values[7]
    var parent_name = e.values[11];
    var parent_email = e.values[12];


    var copyId = DriveApp.getFileById(docTemplate).makeCopy("NHS Form for " + first_name + " " + last_name).getId();
    var copyDoc = DocumentApp.openById(copyId);
    var copyBody = copyDoc.getActiveSection();

    copyBody.replaceText('{Student ID}', student_id);
    copyBody.replaceText('{Last Name}', last_name);
    copyBody.replaceText('{First Name}', first_name);
    copyBody.replaceText('{MiddleInitial}', middle_initial);
    copyBody.replaceText('{Nickname}', nickname);
    copyBody.replaceText('{Class}', class_);
    copyBody.replaceText('{Email}', email);
    copyBody.replaceText('{Parent Name}', parent_name);
    copyBody.replaceText('{Parent Emails}', parent_email);

    copyDoc.saveAndClose();

    var pdf = DriveApp.getFileById(copyId).getAs("application/pdf");

    var subject = "NHS Application Cover Sheet";
    var body = "Here is the NHS New Member Application Form for " + first_name + " " + last_name + ".  Please print it out, sign it, and use it as the cover sheet for the rest of your application.";
    MailApp.sendEmail(email, subject, body, {htmlBody: body, attachments: pdf});

    DriveApp.getFileById(copyId).setTrashed(true);
}
