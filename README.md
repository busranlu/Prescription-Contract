# Prescription-Contract
The PrescriptionManager contract manages prescriptions and user roles on the blockchain. It allows for registration of users with different roles (Doctor, Patient, Pharmacy), and enables doctors to create prescriptions for patients. Patients and pharmacies can view these prescriptions, while only doctors can modify them. This contract facilitates secure and transparent management of medical prescriptions on the blockchain, ensuring that only authorized users can perform specific actions based on their roles.

////////////////////////////////////////////
Test Parameters:

-------registerUser -------------
(Doctor)
_id: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
_role: 0
_name: "Dr. Smith"

(Patient)

_id: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
_role: 1 
_name: "John Doe"

(Pharmacy)

_id: 0x17F6AD8Ef982297579C203069C1DbfFE4348c372
_role: 2 
_name: "Pharmacy Emma"

--------addPrescription ----------

_patient: 0x583031D1113aD414F02576BD6afaBfb302140225
_medicines: [["Aspirin", 20], ["Paracetamol", 10]]

--------modifyPrescription -------

_prescriptionId: 1
_medicines: [["Ibuprofen", 15], ["Amoxicillin", 5]]


