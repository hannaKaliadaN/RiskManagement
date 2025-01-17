using {
  RiskService,
  PDMService
} from './risk-service';


annotate RiskService.Risks with {
  ID          @title: '{i18n>risk}';
  title       @title: '{i18n>Title}';
  owner       @title: '{i18n>Owner}';
  prio        @title: 'Priority';
  descr       @title: 'Description';
  miti        @title: 'Mitigation';
  impact      @title: 'Impact';
  bp          @title: '{i18n>businessPartner}';
  criticality @title: 'Criticality';
}

// Annotate Miti elements
annotate RiskService.Mitigations with {
  ID    @(
    UI.Hidden,
    Common: {Text: descr}
  );
  owner @title: 'Mitigation Owner';
  descr @title: 'Description';
}

//### BEGIN OF INSERT

//### END OF INSERT

annotate RiskService.Risks with {
  miti @(Common: {
    //show text, not id for mitigation in the context of risks
    Text           : miti.descr,
    TextArrangement: #TextOnly,
    ValueList      : {
      Label         : 'Mitigations',
      CollectionPath: 'Mitigations',
      Parameters    : [
        {
          $Type            : 'Common.ValueListParameterInOut',
          LocalDataProperty: miti_ID,
          ValueListProperty: 'ID'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'descr'
        }
      ]
    }
  });

}

annotate RiskService.Customers with @PersonalData: {
  EntitySemantics: 'DataSubject',
  DataSubjectRole: 'Customer'
};

annotate RiskService.Addresses with @PersonalData: {EntitySemantics: 'DataSubjectDetails'};
annotate RiskService.Incidents with @PersonalData: {EntitySemantics: 'Other'};

annotate PDMService.IncidentConversationView with @(PersonalData.EntitySemantics: 'Other') {
  customer_ID @PersonalData.FieldSemantics: 'DataSubjectID';
};

annotate RiskService.Customers with @(Communication.Contact: {
  n    : {
    surname: lastName,
    given  : firstName
  },
  email: [{
    type   : #preferred,
    address: email
  }]
});

annotate PDMService.Customers with @AuditLog.Operation: {
  Read  : true,
  Insert: true,
  Update: true,
  Delete: true
};

annotate PDMService.IncidentConversationView with @AuditLog.Operation: {
  Read  : true,
  Insert: true,
  Update: true,
  Delete: true
};

annotate PDMService.Incidents with @AuditLog.Operation: {
  Read  : true,
  Insert: true,
  Update: true,
  Delete: true
};
