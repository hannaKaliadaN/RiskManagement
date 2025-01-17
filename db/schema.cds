namespace riskmanagement;

using {
  cuid,
  managed,
  sap.common.CodeList
} from '@sap/cds/common';

entity Risks : managed {
  key ID          : UUID @(Core.Computed: true);
      title       : String(100);
      owner       : String;
      prio        : String(5);
      descr       : String;
      miti        : Association to Mitigations;
      impact      : Integer;
      bp          : Association to BusinessPartners; // <-- uncomment this
      criticality : Integer;
}

entity BusinessPartners : managed {
  key ID           : String;
      firstName    : String;
      lastName     : String;
      name         : String;
      email        : EMailAddress;
      phone        : PhoneNumber;
      creditCardNo : String(16) @assert.format: '^[1-9]\d{15}$';

}

entity Mitigations : managed {
  key ID       : UUID @(Core.Computed: true);
      descr    : String;
      owner    : String;
      timeline : String;
      risks    : Association to many Risks
                   on risks.miti = $self;
}


entity Customers : managed {
  key ID           : String @PersonalData.FieldSemantics: 'DataSubjectID';
      firstName    : String;
      lastName     : String;
      name         : String = firstName || ' ' || lastName;
      email        : EMailAddress;
      phone        : PhoneNumber;
      creditCardNo : String(16) @assert.format: '^[1-9]\d{15}$';
      addresses    : Composition of many Addresses
                       on addresses.customer = $self;
      incidents    : Association to many Incidents
                       on incidents.customer = $self;
}

entity Addresses : cuid, managed {
  customer      : Association to Customers;
  city          : String;
  postCode      : String;
  streetAddress : String;
}


/**
 * Incidents created by Customers.
 */
entity Incidents : cuid, managed {
  customer     : Association to Customers;
  title        : String @title: 'Title';
  urgency      : Association to Urgency default 'M';
  status       : Association to Status default 'N';
  conversation : Composition of many {
                   key ID        : UUID;
                       timestamp : type of managed : createdAt;
                       author    : type of managed : createdBy;
                       message   : String;
                 };
}

entity Status : CodeList {
  key code        : String enum {
        new        = 'N';
        assigned   = 'A';
        in_process = 'I';
        on_hold    = 'H';
        resolved   = 'R';
        closed     = 'C';
      };
      criticality : Integer;
}

entity Urgency : CodeList {
  key code : String enum {
        high   = 'H';
        medium = 'M';
        low    = 'L';
      };
}

type EMailAddress : String;
type PhoneNumber  : String;
