import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFA3916B);
const kSecondaryColor = Color(0xFF294C46);
const domain = 'http://west-online-academy.com';
const imgPath = '$domain/upload/';
const signInApi = '$domain/api/api-login.php';
const signUpApi = '$domain/api/api-sing-up.php';
const getAllLessonsApi =
    '$domain/api/api-selectData.php?tableName=videos&where=sub&equalWhat=';
const getAllTeachersApi =
    '$domain/api/api-selectData.php?tableName=users&where=rank&equalWhat=2';
const getTeacherByCourseApi =
    '$domain/api/api-selectData.php?tableName=users&where=id&equalWhat=';
const getCourseByCode = '$domain/api/api-code.php';
const getOwnedCourses =
    '$domain/api/api-getOwnedCourse.php';
const getAllYearsApi =
    '$domain/api/api-selectData.php?tableName=class&where=NULL&equalWhat=NULL';
const getAllCoursesByYear =
    '$domain/api/api-selectData.php?tableName=cat&where=class&equalWhat=';
const checkIfTheCourseIsOwned =
    '$domain/api/api-getOwnedCourse.php';
const getCoursesByTeacher =
    '$domain/api/api-selectData.php?tableName=videos&where=pub&equalWhat=';
const getAllLessonsByYearApi =
    '$domain/api/api-selectData.php?tableName=videos&where=yr&equalWhat=';
