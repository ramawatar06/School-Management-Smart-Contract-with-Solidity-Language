// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Title : School managment program
//Author : Danial Eyvazi

contract SchoolManagment { 

   //Modifiers
   modifier managerCheck {
          require(msg.sender == managerAddress , "Only the manager can do this ."); // for manager specific functionalities 
          _;
   }

   // Main variables
   address private managerAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; // An example of the manager's address
   bool private  isManagerDeclared; // Deafault is false 
   
   // Main data structures

    struct Teacher {
        address TeacherAdress;
        string firstName;
        string lastName;
        uint age;
        uint idNumber;
    }

    struct Manager {
        string firstName;
        string lastName;
        uint age;
        uint idNumber; 
    }

    struct Student {
        string firstName;
        string lastName;
        uint idNumber;
        bool isPaid;
        uint age;

    }

    struct Lesson {
        string courseName;
    }

    struct Class {
        uint classId;
        string lessonName;
        uint studentsCount;
        string teacherName;
        uint8 grade;
    }

    // declaring each struct array of object

    Teacher[] public teachers;
    Manager[] public managers;
    Student[] public students;
    Lesson[] public lessons;
    Class[] public classes;

// =============== Adding Functions ==================

   function addManager(string memory firstName, 
    string memory lastName, uint age, uint idNumber) public managerCheck{
        managers.push(Manager(firstName , lastName , age , idNumber));
    }


    // aading teacher
    function addTeacher(address TeacherAdress, string memory firstName,
     string memory lastName, uint age, uint idNumber) public managerCheck{
        teachers.push(Teacher(TeacherAdress, firstName, lastName, age, idNumber));
    }

    // aading student
    function addStudent( string memory firstName, string memory lastName,uint idNumber, 
    bool isPaid, uint age) public managerCheck{

        students.push(Student(firstName, lastName,  idNumber, isPaid, age));
    }

    // aading lesson
    function addLesson(string memory courseName) public managerCheck{

    lessons.push(Lesson(courseName));
    }

    // ading class
    function addClass(uint classId ,string memory lessonName ,uint studentsCount, string memory teacherName , uint8 grade) public managerCheck{

    classes.push(Class(classId ,lessonName ,studentsCount, teacherName , grade));
    }

// ================ Deleting functions ==================

  // Deleting a teacher
    function deleteTeacher(uint idNumber) public managerCheck{
        for (uint i = 0; i < teachers.length; i++) {
            if (teachers[i].idNumber == idNumber) {
                teachers[i] = teachers[teachers.length - 1];
                teachers.pop();
                break;
            }
        }
    }

    // Deleting a student
    function deleteStudent(uint idNumber) public managerCheck{

        for (uint i = 0; i < students.length; i++) {
            if (students[i].idNumber == idNumber) {
                students[i] = students[students.length - 1];
                students.pop();
                break;
            }
        } 
    }

    // Deleting a lesson
    function deleteLesson(string memory courseName) public managerCheck{

      for (uint i = 0; i < lessons.length; i++) {
        if (keccak256(bytes(lessons[i].courseName)) == keccak256(bytes(courseName))) {
            lessons[i] = lessons[lessons.length - 1];
            lessons.pop();
            break;
        }
      } 
    }

// ================ Editing functions ==================

   // Editing a teacher
    function editingTeacher(uint _idNumber , address _TeacherAdress , string memory _firstName ,
     string memory _lastName , uint _age ) public managerCheck returns (string memory) {

        for (uint i = 0; i < teachers.length; i++) {
            if (teachers[i].idNumber == _idNumber) {
                teachers[i].TeacherAdress = _TeacherAdress;
                teachers[i].firstName = _firstName;
                teachers[i].lastName  = _lastName ;
                teachers[i].age = _age;
                teachers[i].idNumber = _idNumber;
                break;
            }
        }

    // Add a default return statement
     return "The Teacher ID is wrong.";
    }

    // Editing a student
    function editingStudent(uint _idNumber , string memory _firstName ,
     string memory _lastName , uint _age ) public managerCheck returns (string memory){

        for (uint i = 0; i < teachers.length; i++) {
            if (students[i].idNumber == _idNumber) {
                students[i].firstName = _firstName;
                students[i].lastName  = _lastName ;
                students[i].age = _age;
                students[i].idNumber = _idNumber;
                break;
            }
        }

    // Add a default return statement
     return "The Student ID is wrong.";
    }

    // Editing a class
    function editingClass(uint _classId ,string memory _lessonName ,  uint _studentsCount ,
    string memory _teacherName ,
    uint8 _grade ) public managerCheck returns (string memory){

        for (uint i = 0; i < teachers.length; i++) {
            if (classes[i].classId == _classId) {
                classes[i].lessonName  = _lessonName;
                classes[i].studentsCount = _studentsCount;
                classes[i].teacherName = _teacherName;
                classes[i].grade = _grade ;
                break;
            }
        }

     // Add a default return statement
     return "The Class ID is wrong.";
    }

    


// ========== Other functionalities =============

    // checking tuition 
    function checkTuition(uint idNumber) public  managerCheck view returns (string memory) {
      require(idNumber != students[idNumber].idNumber , "");


       for (uint i = 0; i < students.length; i++) {
        if (students[i].idNumber == idNumber) {
            if (students[i].isPaid == true) {
                return "This student has paid his/her tuition fee.";
            } else {
                return "This student has not paid his/her tuition fee.";
            }
         }
       }

     // Add a default return statement
     return "";
     }
}

    
