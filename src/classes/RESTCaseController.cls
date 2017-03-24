@RestResource(urlMapping='/myApi/*')
global with sharing class RESTCaseController {

@HttpPost   
  global static String sayHi() {
         return 'Hii';
     }
}