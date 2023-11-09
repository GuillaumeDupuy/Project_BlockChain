pragma solidity ^0.5.3;

pragma experimental ABIEncoderV2;

import "./Token.sol";

/**
    * @title Higher Education Diploma Verification
    * @dev Verification of the authenticity of diplomas issued by higher education institutions
*/

contract Diploma {
    address private owner;
    address private token;

    /**
        * @dev The establishment structure.
    */
    struct Establishment {
        bool exists;
        uint256 ees_id;
        string establishment_name;
        string establishment_type;
        string country;
        string addresses;
        string website;
        uint256 agent_id;
    }

    /**
        * @dev The student personal information structure.
    */
    struct StudentPersonalInfo {
        string LastName;
        string FirstName;
        string DateOfBirth;
        string Gender;
        string Nationality;
        string MaritalStatus;
        string Address;
        string Email;
        string Phone;
    }

    /**
        * @dev The student academic information structure.
    */
    struct StudentAcademicInfo {
        string Section;
        string ThesisTopic;
        string InternshipCompany;
        string InternshipSupervisor;
        string InternshipStartDate;
        string InternshipEndDate;
        string Evaluation;
    }

    /**
        * @dev The student structure.
    */
    struct Student {
        bool exists;
        uint256 student_id;
        StudentPersonalInfo personalInfo;
        StudentAcademicInfo academicInfo;
    }

    /**
        * @dev The diploma structure.
    */
    struct DiplomaInfo {
        bool exists;
        uint256 holder_id;
        string institution_name;
        string country;
        string diploma_type;
        string specialization;
        string honors;
        string date_of_obtention;
    }

    /**
        * @dev The company structure.
    */
    struct Company {
        bool exists;
        uint256 diploma_id;
        uint256 company_id;
        string Name;
        string Sector;
        string DateOfCreation;
        string SizeClassification;
        string Country;
        string Address;
        string Email;
        string Phone;
        string Website;
    }

    mapping(uint256 => Establishment) public Establishments;
    mapping(address => uint256) AddressEstablishments;
    mapping(uint256 => Student) public Students;
    mapping(uint256 => Company) public Companies;
    mapping(address => uint256) AddressCompanies;
    mapping(uint256 => DiplomaInfo) public Diplomas;

    uint256 public NbEstablishments;
    uint256 public NbStudents;
    uint256 public NbCompanies;
    uint256 public NbDiplomas;

    /**
        * @dev The constructor of the contract.
        * @param tokenaddress The address of the token.
    */
    constructor(address tokenaddress) public {
        token = tokenaddress;
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor

        NbEstablishments = 0;
        NbStudents = 0;
        NbCompanies = 0;
        NbDiplomas = 0;
    }

    /**
        * @dev Adds an establishment to the registry.
        * @param e The establishment information to add.
        * @param a The address associated with the establishment.
    */
    function AddEstablishments(Establishment memory e, address a) private {
        NbEstablishments += 1;
        e.exists = true;
        e.ees_id += 1;
        Establishments[NbEstablishments] = e;
        AddressEstablishments[a] = NbEstablishments;
    }

    /**
        * @dev Adds a company to the registry.
        * @param e The company information to add.
        * @param a The address associated with the company.
    */
    function AddCompanies(Company memory e, address a) private {
        NbCompanies += 1;
        e.exists = true;
        e.company_id += 1;
        Companies[NbCompanies] = e;
        AddressCompanies[a] = NbCompanies;
    }

    /**
        * @dev Adds a student to the registry.
        * @param e The student information to add.
    */
    function AddStudents(Student memory e) private {
        e.exists = true;
        e.student_id += 1;
        NbStudents += 1;
        Students[NbStudents] = e;
    }

    /**
        * @dev Adds a diploma to the registry.
        * @param d The diploma information to add.
    */
    function AddDiplomas(DiplomaInfo memory d) private {
        d.exists = true;
        d.holder_id += 1;
        NbDiplomas += 1;
        Diplomas[NbDiplomas] = d;
    }

    /**
        * @dev Adds an establishment to the registry.
        * @param name The name of the establishment.
        * @param establishmentType The type of the establishment.
        * @param country The country of the establishment.
        * @param addresses The address of the establishment.
        * @param website The website of the establishment.
        * @param agentId The agent id of the establishment.
    */
    function AddEstablishments(string memory name, string memory establishmentType, string memory country, string memory addresses, string memory website, uint256 agentId) public {
        Establishment memory e;
        e.establishment_name = name;
        e.establishment_type = establishmentType;
        e.country = country;
        e.addresses = addresses;
        e.website = website;
        e.agent_id = agentId;
        AddEstablishments(e, msg.sender);
    }

    /**
        * @dev Adds a company to the registry.
        * @param name The name of the company.
        * @param sector The sector of the company.
        * @param dateOfCreation The date of creation of the company.
        * @param sizeClassification The size classification of the company.
        * @param country The country of the company.
        * @param companyAddress The address of the company.
        * @param email The email of the company.
        * @param phone The phone of the company.
        * @param website The website of the company.
    */
    function AddCompanies(string memory name, string memory sector, string memory dateOfCreation, string memory sizeClassification, string memory country, string memory companyAddress, string memory email, string memory phone, string memory website) public {
        Company memory e;
        e.Name = name;
        e.Sector = sector;
        e.DateOfCreation = dateOfCreation;
        e.SizeClassification = sizeClassification;
        e.Country = country;
        e.Address = companyAddress;
        e.Email = email;
        e.Phone = phone;
        e.Website = website;
        AddCompanies(e, msg.sender);
    }

    /**
    * @dev Adds a new student to the registry.
    * @param personalInfo Student's personal information.
    * @param academicInfo Student's academic information.
    */
    function AddStudents(StudentPersonalInfo memory personalInfo,StudentAcademicInfo memory academicInfo) public {
        uint256 id = AddressEstablishments[msg.sender];
        require(id != 0, "Not Establishment");
        
        Student storage e = Students[NbStudents + 1];
        e.exists = true;
        e.student_id = NbStudents + 1;
        e.personalInfo = personalInfo;
        e.academicInfo = academicInfo;
        NbStudents += 1;
    }
  
    /**
        * @dev Adds a diploma to the registry.
        * @param holderId The id of the holder of the diploma.
        * @param country The country of the diploma.
        * @param diplomaType The type of the diploma.
        * @param specialization The specialization of the diploma.
        * @param honors The honors of the diploma.
        * @param dateOfObtention The date of obtention of the diploma.
    */
    function AddDiplomas(uint256 holderId, string memory country, string memory diplomaType, string memory specialization, string memory honors, string memory dateOfObtention) public {
        uint256 id = AddressEstablishments[msg.sender];
        require(id != 0, "Not Establishment");
        require(Students[holderId].exists == true, "Not Students");
        DiplomaInfo memory d;
        d.exists = true;
        d.holder_id = holderId;
        d.institution_name = Establishments[id].establishment_name;
        d.country = country;
        d.diploma_type = diplomaType;
        d.specialization = specialization;
        d.honors = honors;
        d.date_of_obtention = dateOfObtention;
        AddDiplomas(d);
    }

    /**
        * @dev Adds a diploma to the registry.
    */
    function evaluate(uint256 studentId,string memory thesisTopic,string memory internshipCompany,string memory internshipSupervisor,string memory internshipStartDate,string memory internshipEndDate,string memory evaluation) public {
        uint256 id = AddressCompanies[msg.sender];
        require(id != 0, "No Companies");
        require(Students[studentId].exists == true, "Not Students");
        Students[studentId].academicInfo.ThesisTopic = thesisTopic;
        Students[studentId].academicInfo.InternshipCompany = internshipCompany;
        Students[studentId].academicInfo.InternshipSupervisor = internshipSupervisor;
        Students[studentId].academicInfo.InternshipStartDate = internshipStartDate;
        Students[studentId].academicInfo.InternshipEndDate = internshipEndDate;
        Students[studentId].academicInfo.Evaluation = evaluation;
        
        // Company evaluation
        // Payment of 15 tokens as remuneration
        // Deduct 10 tokens for expenses
        require(
            Token(token).allowance(owner, address(this)) >= 15, // Check the amount authorized by the owner >= number of tokens the user wants to buy
            "Token not allowed"
        );
        require(
            Token(token).transferFrom(owner, msg.sender, 15), // Transfer tokens
            "Transfer failed"
        );
    }

    /**
        * @dev The event triggered when a diploma is verified.
        * @param success The result of the verification.
        * @param diploma The diploma information.
    */
    event VerificationResult(bool success, DiplomaInfo diploma);

    /**
        * @dev Verifies the authenticity of a diploma.
        * @param diplomaId The id of the diploma.
    */
    function verify(uint256 diplomaId) public returns (bool, DiplomaInfo memory) {
        // Payment of 10 tokens as a fee
        require(
            Token(token).allowance(msg.sender, address(this)) >= 10, // Check the amount authorized by the owner >= number of tokens the user wants to buy
            "Token not allowed"
        );
        require(
            Token(token).transferFrom(msg.sender, owner, 10), // Transfer tokens
            "Transfer failed"
        );
        emit VerificationResult(Diplomas[diplomaId].exists, Diplomas[diplomaId]);
        return (Diplomas[diplomaId].exists, Diplomas[diplomaId]);
    }
}