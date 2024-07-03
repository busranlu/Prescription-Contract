// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract PrescriptionManager {
    //prescription scope
    struct Medicine {
        string name;
        uint quantity;
    }

    //user profiles
    enum UserRole {
        Doctor,
        Patient,
        Pharmacy,
        None
    }

    //prescription features
    struct Prescription {
        address doctor;
        address patient;
        Medicine[] medicines;
        bool isActive;
    }
    
    //user need for registration
    struct User {
        address id;
        UserRole role;
        string name;
    }

    mapping(address => User) public users;
    mapping(uint => Prescription) public prescriptions;
    uint public prescriptionCount;

    // only doctor create and edit Prescription
    modifier onlyDoctor() {
        require(users[msg.sender].role == UserRole.Doctor, "Only doctors can perform this action");
        _;
    }

    //only patient and pharmacy can view Prescription
    modifier onlyPatientOrPharmacy() {
        require(users[msg.sender].role == UserRole.Patient || users[msg.sender].role == UserRole.Pharmacy, "Only patients or pharmacies can perform this action");
        _;
    }

    function registerUser(address _id, UserRole _role, string memory _name) public {
        require(users[_id].id == address(0), "User already registered");
        users[_id] = User({
            id: _id,
            role: _role,
            name: _name
        });
    }

    function addPrescription(address _patient, Medicine[] memory _medicines) public onlyDoctor {
        prescriptionCount++;
        Prescription storage newPrescription = prescriptions[prescriptionCount];
        newPrescription.doctor = msg.sender;
        newPrescription.patient = _patient;
        newPrescription.isActive = true;

        for (uint i = 0; i < _medicines.length; i++) {
            newPrescription.medicines.push(_medicines[i]);
        }
    }

    function getPrescription(uint _prescriptionId) public view returns (address, address, Medicine[] memory, bool) {
        Prescription storage prescription = prescriptions[_prescriptionId];
        return (prescription.doctor, prescription.patient, prescription.medicines, prescription.isActive);
    }

    function viewPrescription(uint _prescriptionId) public view onlyPatientOrPharmacy returns (address, address, Medicine[] memory, bool) {
        Prescription storage prescription = prescriptions[_prescriptionId];
        return (prescription.doctor, prescription.patient, prescription.medicines, prescription.isActive);
    }

    function modifyPrescription(uint _prescriptionId, Medicine[] memory _medicines) public onlyDoctor {
        Prescription storage prescription = prescriptions[_prescriptionId];
        require(msg.sender == prescription.doctor, "Only the prescribing doctor can modify this prescription");

        delete prescription.medicines;

        for (uint i = 0; i < _medicines.length; i++) {
            prescription.medicines.push(_medicines[i]);
        }
    }

    function addMedicine(uint _prescriptionId, Medicine memory _medicine) public onlyDoctor {
        Prescription storage prescription = prescriptions[_prescriptionId];
        require(prescription.isActive, "Prescription is not active");
        prescription.medicines.push(_medicine);
    }

    function deactivatePrescription(uint _prescriptionId) public onlyDoctor {
        prescriptions[_prescriptionId].isActive = false;
    }
}
