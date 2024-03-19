// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JobApplicationSystem {
    struct Student {
        uint256 studentID;
        string name;
        string skills;
        uint256 regid;
        uint256[] appliedCompanyIDs;
    
         // Company IDs to which the student has applied
    }

    struct Company {
        uint256 companyID;
        string name;
        string description;
    }

    struct JobApplication {
        uint256 studentID;
        uint256 companyID;
    }

    mapping(uint256 => Student) public students;
    mapping(uint256 => Company) public companies;
    mapping(uint256 => JobApplication) public jobApplications;
    mapping(uint256=>uint256)public studlogin;
    mapping(string=>uint256)public complogin;
   
    uint256 public numStudents = 0;
    uint256 public numCompanies = 0;
    uint256 public numApplications = 0;

    function createStudent(string memory _name, string memory _skills, uint256 _regid) public {
        numStudents++;
        students[numStudents] = Student({
            studentID: numStudents,
            name: _name,
            skills: _skills,
            regid:_regid,
            appliedCompanyIDs: new uint256[](0)
    
        });
        studlogin[_regid]=numStudents;
      
    }

    function createCompany(string memory _name, string memory _description) public {
        numCompanies++;
        companies[numCompanies] = Company({
            companyID: numCompanies,
            name: _name,
            description: _description
        });
        complogin[_name]=numCompanies;
    }

    function applyToCompany(uint256 studentID, uint256 companyID) public {
        require(studentID <= numStudents && studentID > 0, "Invalid studentID");
        require(companyID <= numCompanies && companyID > 0, "Invalid companyID");

        numApplications++;
        jobApplications[numApplications] = JobApplication({
            studentID: studentID,
            companyID: companyID
        });

        students[studentID].appliedCompanyIDs.push(companyID);
    }
    
    function getStudentApplications(uint256 studentID)
        public
        view
        returns (Company[] memory)
    {
        require(studentID <= numStudents && studentID > 0, "Invalid studentID");

        Student storage student = students[studentID];
        Company[] memory appliedCompanies = new Company[](student.appliedCompanyIDs.length);

        for (uint256 i = 0; i < student.appliedCompanyIDs.length; i++) {
            appliedCompanies[i] = companies[student.appliedCompanyIDs[i]];
        }

        return appliedCompanies;
    }
}
