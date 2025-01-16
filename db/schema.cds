namespace riskmanagement;

using {managed} from '@sap/cds/common';

entity Risks : managed {
    key ID          : UUID @(Core.Computed: true);
        title       : String(100);
        owner       : String;
        prio        : String(5);
        descr       : String;
        miti        : Association to Mitigations;  
        impact      : Integer;
        bp          : Association to BusinessPartners ; // <-- uncomment this
        criticality : Integer;
}

entity BusinessPartners : managed {
    key ID           :  String;
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


type EMailAddress : String;
type PhoneNumber  : String;
