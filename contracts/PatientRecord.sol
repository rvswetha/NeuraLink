pragma solidity ^0.8.0;

contract PatientRecord {
    address public owner;

    struct Record {
        string data;
        uint timestamp;
        address addedBy;
    }

    mapping(address => bool) public isDoctor;
    mapping(address => bool) public isPatient;
    mapping(address => mapping(address => bool)) public authorizedDoctors;
    mapping(address => Record[]) public patientRecords;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Register a doctor (only owner)
    function registerDoctor(address doctor) public onlyOwner {
        isDoctor[doctor] = true;
    }

    // Register as a patient (anyone)
    function registerPatient() public {
        require(!isPatient[msg.sender], "Already registered as patient");
        isPatient[msg.sender] = true;
    }

    // Patient grants access to a doctor
    function grantAccess(address doctor) public {
        require(isPatient[msg.sender], "Only patients can grant access");
        require(isDoctor[doctor], "Address is not a registered doctor");
        authorizedDoctors[msg.sender][doctor] = true;
    }

    // Patient revokes access from a doctor
    function revokeAccess(address doctor) public {
        require(isPatient[msg.sender], "Only patients can revoke access");
        authorizedDoctors[msg.sender][doctor] = false;
    }

    // Add a record for a patient (only authorized doctors)
    function addRecord(address patient, string memory data) public {
        require(isPatient[patient], "Patient does not exist");
        require(authorizedDoctors[patient][msg.sender], "Not authorized to add records");
        patientRecords[patient].push(Record(data, block.timestamp, msg.sender));
    }

    // View patient records (patient or authorized doctor)
    function getRecords(address patient) public view returns (Record[] memory) {
        require(isPatient[patient], "Patient does not exist");
        require(msg.sender == patient || authorizedDoctors[patient][msg.sender], "Not authorized to view records");
        return patientRecords[patient];
    }
}