import ballerina/log;
import ballerinax/covid19;
import wso2/choreo.sendemail;

@display {label: "Country Code"}
configurable string country = ?;

@display {label: "Recipient's Email"}
configurable string emailAddress = ?;

public function main() returns error? {

    covid19:Client covid19Client = check new ();
    covid19:CovidCountry statusByCountry = check covid19Client->getStatusByCountry(country);
    decimal totalCases = statusByCountry.cases;



    string mailBody = string `Total Cases : ${totalCases}`;

    sendemail:Client sendemailEndpoint = check new ();
    _ = check sendemailEndpoint->sendEmail(emailAddress, string `Covid Status in ${country}`,
    mailBody);
    log:printInfo("Email sent successfully!");
}