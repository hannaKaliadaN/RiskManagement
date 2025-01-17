sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'incidents/test/integration/FirstJourney',
		'incidents/test/integration/pages/IncidentsList',
		'incidents/test/integration/pages/IncidentsObjectPage',
		'incidents/test/integration/pages/Incidents_conversationObjectPage'
    ],
    function(JourneyRunner, opaJourney, IncidentsList, IncidentsObjectPage, Incidents_conversationObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('incidents') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheIncidentsList: IncidentsList,
					onTheIncidentsObjectPage: IncidentsObjectPage,
					onTheIncidents_conversationObjectPage: Incidents_conversationObjectPage
                }
            },
            opaJourney.run
        );
    }
);