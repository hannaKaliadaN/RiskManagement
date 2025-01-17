using {riskmanagement as rm} from '../db/schema';

/**
 * For serving end users
 */
service RiskService @(path: 'service/risk') {
  entity Incidents           as projection on rm.Incidents;
  entity Customers @readonly as projection on rm.Customers;

  entity Risks @(restrict: [
    {
      grant: ['READ'],
      to   : ['RiskViewer']
    },
    {
      grant: ['*'],
      to   : ['RiskManager']
    }
  ])                         as projection on rm.Risks;

  annotate Risks with @odata.draft.enabled;


  entity Mitigations @(restrict: [
    {
      grant: ['READ'],
      to   : ['RiskViewer']
    },
    {
      grant: ['*'],
      to   : ['RiskManager']
    }
  ])                         as projection on rm.Mitigations;

  annotate Mitigations with @odata.draft.enabled;
  entity BusinessPartners    as projection on rm.BusinessPartners;
}

@requires: 'PersonalDataManagerUser' // security check
service PDMService @(path: '/pdm') {
entity IncidentConversationView as
      select from Incidents {
              ID,
              title,
              urgency,
              status,
          key conversation.ID        as conversation_ID,
              conversation.timestamp as conversation_timestamp,
              conversation.author    as conversation_author,
              conversation.message   as conversation_message,
              customer.ID            as customer_ID,
              customer.email         as customer_email
      };
  // Data Privacy annotations on 'Customers' and 'Addresses' are derived from original entity definitions
  entity Customers as projection on rm.Customers;
  entity Addresses as projection on rm.Addresses;
  entity Incidents as projection on rm.Incidents


};
