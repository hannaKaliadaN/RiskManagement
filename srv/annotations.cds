using  from './risk-service';

 // Annotate Risk elements
 annotate RiskService.Risks with {
    ID @title : '{i18n>risk}';
   title @title : '{i18n>Title}';
   owner @title : '{i18n>Owner}';
   prio @title : 'Priority';
   descr @title : 'Description';
   miti @title : 'Mitigation';
   impact @title : 'Impact';
   bp @title : '{i18n>businessPartner}';
   criticality @title : 'Criticality';
 }

 // Annotate Miti elements
 annotate RiskService.Mitigations with {
   ID @(
     UI.Hidden,
     Common : {Text : descr}
   );
   owner @title : 'Mitigation Owner';
   descr @title : 'Description';
 }

 //### BEGIN OF INSERT
 annotate RiskService.BusinessPartners with {
   BusinessPartner @(
     UI.Hidden,
     Common : {Text : LastName}
   );
   LastName @title : 'Last Name';
   FirstName @title : 'First Name';
 }
 //### END OF INSERT

annotate RiskService.Risks with {
   miti @(Common : {
     //show text, not id for mitigation in the context of risks
     Text : miti.descr,
     TextArrangement : #TextOnly,
     ValueList : {
     Label : 'Mitigations',
     CollectionPath : 'Mitigations',
     Parameters : [
       {
         $Type : 'Common.ValueListParameterInOut',
         LocalDataProperty : miti_ID,
         ValueListProperty : 'ID'
       },
       {
         $Type : 'Common.ValueListParameterDisplayOnly',
         ValueListProperty : 'descr'
       }
     ]
   }
 });
 //### BEGIN OF INSERT
 bp @(Common : {
   Text : bp.LastName,
   TextArrangement : #TextOnly,
   ValueList : {
      Label : 'Business Partners',
      CollectionPath : 'BusinessPartners',
      Parameters : [
         {
           $Type : 'Common.ValueListParameterInOut',
           LocalDataProperty : bp_BusinessPartner,
           ValueListProperty : 'FirstName'
         },
         {
            $Type : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'LastName'
          },
          {
             $Type : 'Common.ValueListParameterDisplayOnly',
             ValueListProperty : 'FirstName'
          }
       ]
     }
  })
//### END OF INSERT 
}