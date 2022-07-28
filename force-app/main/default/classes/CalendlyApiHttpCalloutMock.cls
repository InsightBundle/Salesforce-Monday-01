global class CalendlyApiHttpCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);

        String requestEndpoint = request.getEndpoint();
        String requestMethod = request.getMethod();

        if (requestEndpoint == 'callout:calendly_api/users/me') {
            response.setBody(getUserResourceResponse('me'));
        } else if (requestEndpoint == 'callout:calendly_api/users/123456789')  {
            response.setBody(getUserResourceResponse('123456789'));
        } else if (requestEndpoint == 'callout:calendly_api/event_types?') {
            response.setStatusCode(400);
            response.setBody(getInvalidRequestErrorResponse());
        } else if (requestEndpoint == getEventTypesPaginationUrl()) {
            response.setBody(getEventTypeCollectionResponse());
        } else if (requestEndpoint == getScheduledEventsPaginationUrl()) {
            response.setBody(getScheduledEventCollectionResponse());
        } else if (requestEndpoint == 'callout:calendly_api/scheduled_events/123456789') {
            response.setBody(getScheduledEventResponse());
        } else if (requestEndpoint == 'callout:calendly_api/event_types/123456789') {
            response.setBody(getEventTypeResponse());
        } else if (requestEndpoint == 'callout:calendly_api/scheduling_links') {
            JSONParser parser = System.JSON.createParser(request.getBody());
            CalendlyApi.CreateSchedulingLinkRequest createLinkRequest = (CalendlyApi.CreateSchedulingLinkRequest) parser.readValueAs(CalendlyApi.CreateSchedulingLinkRequest.class);
            
            System.assertEquals(createLinkRequest.max_event_count, 1);
            System.assertEquals(createLinkRequest.owner, 'https://api.calendly.com/event_types/123456789');
            System.assertEquals(createLinkRequest.owner_type, 'EventType');

            response.setBody(createSchedulingLinkResponse());
        } else if (requestEndpoint == 'callout:calendly_api/scheduled_events/123456789/invitees/123456789') {
            response.setBody(getInviteeResponse());
        } else if (requestEndpoint == getInviteesPaginationUrl()) {
            response.setBody(getInviteeCollectionResponse());
        } else if (requestEndpoint == 'callout:calendly_api/organization_memberships/123456789') {
            if (requestMethod == 'DELETE') {
                response.setBody('');
            } else {
                response.setBody(getOrganizationMembershipResponse());
            }
        } else if (requestEndpoint == 'callout:calendly_api/organization_memberships?user=https://api.calendly.com/users/me&count=1&') {
            response.setBody(getOrganizationMembershipCollectionResponse());
        } else if (requestEndpoint == getOrganizationMembershipsPaginationUrl()) {
            response.setBody(getOrganizationMembershipCollectionResponse());
        } else if (requestEndpoint == getOrganizationInvitationsPaginationUrl()) {
            response.setBody(getOrganizationInvitationCollectionResponse());
        } else if (requestEndpoint == getWebhookSubscriptionsPaginationUrl()) {
            response.setBody(getWebhookSubscriptionCollectionResponse());
        } else if (requestEndpoint == 'callout:calendly_api/organizations/123456789/invitations') {
            if (requestMethod == 'POST') {
                response.setBody(getOrganizationInvitationResourceResponse());
            }
        } else if (requestEndpoint == 'callout:calendly_api/organizations/123456789/invitations/123456789') {
            if (requestMethod == 'DELETE') {
                response.setBody('');
            } else {
                response.setBody(getOrganizationInvitationResourceResponse());
            }
        } else if (requestEndpoint == 'callout:calendly_api/webhook_subscriptions') {
            if (requestMethod == 'POST') {
                response.setBody(getCreateWebhookSubscriptionResponse());
            }
        } else if (requestEndpoint == 'callout:calendly_api/webhook_subscriptions/123456789') {
            if (requestMethod == 'GET') {
                response.setBody(getWebhookSubscriptionResponse());
            } else {
                response.setBody('');
            }
        } else {
            System.assert(false, 'Unexpected request: ' + requestEndpoint);
        }
        
        return response; 
    }

    private static String getUserResourceResponse(String uuid) {
        return '{' +
            '"resource": {' +
                '"avatar_url": "avatar_url",' +
                '"created_at": "2020-03-09T14:00:17.399346Z",' +
                '"email": "test@test.com",' +
                '"name": "John Doe",' +
                '"scheduling_url": "https://calendly.com",' +
                '"slug": "test",' +
                '"timezone": "America/New_York",' +
                '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                '"current_organization": "https://api.calendly.com/organizations/123456789",' +
                '"uri": "https://api.calendly.com/users/' + uuid +
                '"}' +
            '}';
    }

    private static String createSchedulingLinkResponse() {
        return '{' +
                '"resource": {' +
                  '"booking_url": "https://calendly.com",' +
                  '"owner": "https://api.calendly.com/event_types/123456789",' +
                  '"owner_type": "EventType"' +
                '}' +
            '}';

    }

    private static String getInviteeCollectionResponse() {
        return '{' +
                '"collection": [{' +
                    '"cancel_url": "https://api.calendly.com/cancellations/123456789",' +
                    '"cancellation": {' +
                        '"canceled_by": "John Doe",' +
                        '"reason": "cancellation reason"' +
                    '},' +
                    '"created_at": "2020-03-09T14:00:17.399346Z",' +
                    '"email": "test@test.com",' +
                    '"event": "https://api.calendly.com/scheduled_events/123456789",' +
                    '"name": "John Doe",' +
                    '"new_invitee": "https://api.calendly.com/scheduled_events/123456789/invitees/123456789",' +
                    '"old_invitee": "https://api.calendly.com/scheduled_events/123456789/invitees/123456789",' +
                    '"payment": {' +
                        '"external_id": "ch_AAAAAAAAAAAAAAAAAAAAAAAA",' +
                        '"provider": "stripe",' +
                        '"amount": 1234.56,' +
                        '"currency": "USD",' +
                        '"terms": "sample terms of payment (up to 1,024 characters)",' +
                        '"successful": true' +
                      '},' +
                    '"questions_and_answers": [' +
                        '{' +
                            '"answer": "answer",' +
                            '"position": 0,' +
                            '"question": "question"' +
                        '}' +
                    '],' +
                    '"reschedule_url": "https://api.calendly.com/reschedulings/123456789",' +
                    '"rescheduled": false,' +
                    '"status": "canceled",' +
                    '"text_reminder_number": "123456789",' +
                    '"timezone": "America/New_York",' +
                    '"tracking": {' +
                        '"utm_campaign": "utm_campaign",' +
                        '"utm_source": "utm_source",' +
                        '"utm_medium": "utm_medium",' +
                        '"utm_content": "utm_content",' +
                        '"utm_term": "utm_term",' +
                        '"salesforce_uuid": "salesforce_uuid"' +
                    '},' +
                    '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                    '"uri": "https://api.calendly.com/scheduled_events/123456789/invitees/123456789"' +
                '}],' +
                '"pagination": {' +
                    '"count": 1,' +
                    '"next_page": "https://api.calendly.com/scheduled_events/123456789/invitees?email=test@test.com&status=active&page_token=123&count=10&sort=sort_name:asc&"' +
                '}' +
            '}';
    }

    private static String getInviteeResponse() {
        return '{' +
                '"resource": {' +
                    '"cancel_url": "https://api.calendly.com/cancellations/123456789",' +
                    '"cancellation": {' +
                        '"canceled_by": "John Doe",' +
                        '"reason": "cancellation reason"' +
                    '},' +
                    '"created_at": "2020-03-09T14:00:17.399346Z",' +
                    '"email": "test@test.com",' +
                    '"event": "https://api.calendly.com/scheduled_events/123456789",' +
                    '"name": "John Doe",' +
                    '"new_invitee": "https://api.calendly.com/scheduled_events/123456789/invitees/123456789",' +
                    '"old_invitee": "https://api.calendly.com/scheduled_events/123456789/invitees/123456789",' +
                    '"payment": {' +
                        '"external_id": "ch_AAAAAAAAAAAAAAAAAAAAAAAA",' +
                        '"provider": "stripe",' +
                        '"amount": 1234.56,' +
                        '"currency": "USD",' +
                        '"terms": "sample terms of payment (up to 1,024 characters)",' +
                        '"successful": true' +
                      '},' +
                    '"questions_and_answers": [' +
                        '{' +
                            '"answer": "answer",' +
                            '"position": 0,' +
                            '"question": "question"' +
                        '}' +
                    '],' +
                    '"reschedule_url": "https://api.calendly.com/reschedulings/123456789",' +
                    '"rescheduled": false,' +
                    '"status": "canceled",' +
                    '"text_reminder_number": "123456789",' +
                    '"timezone": "America/New_York",' +
                    '"tracking": {' +
                        '"utm_campaign": "utm_campaign",' +
                        '"utm_source": "utm_source",' +
                        '"utm_medium": "utm_medium",' +
                        '"utm_content": "utm_content",' +
                        '"utm_term": "utm_term",' +
                        '"salesforce_uuid": "salesforce_uuid"' +
                    '},' +
                    '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                    '"uri": "https://api.calendly.com/scheduled_events/123456789/invitees/123456789"' +
                '}' +
            '}';
    }

    private static String getEventTypeResponse() {
        return '{' +
            '"resource": {' +
                '"active": true,' +
                '"color": "#dfc12d",' +
                '"created_at": "2020-03-09T14:00:17.399346Z",' +
                '"description_html": "html",' +
                '"description_plain": "text",' +
                '"duration": 15,' +
                '"internal_note": "internal_note",' +
                '"kind": "solo",' +
                '"name": "15 Minute Meeting",' +
                '"pooling_type": "pooling_type",' +
                '"profile": {' +
                    '"name": "John Doe",' +
                    '"owner": "https://api.calendly.com/users/123456789",' +
                    '"type": "User"' +
                '},' +
                '"scheduling_url": "https://calendly.com",' +
                '"secret": false,' +
                '"slug": "15min",' +
                '"type": "StandardEventType",' +
                '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                '"uri": "https://api.calendly.com/event_types/123456789"' +
                '}' +
            '}';
    }

    private static String getEventTypeCollectionResponse() {
        return '{' +
            '"collection": [' +
                '{' +
                    '"active": true,' +
                    '"color": "#dfc12d",' +
                    '"created_at": "2020-03-09T14:00:17.399346Z",' +
                    '"description_html": "html",' +
                    '"description_plain": "text",' +
                    '"duration": 15,' +
                    '"internal_note": "internal_note",' +
                    '"kind": "solo",' +
                    '"name": "15 Minute Meeting",' +
                    '"pooling_type": "pooling_type",' +
                    '"profile": {' +
                        '"name": "John Doe",' +
                        '"owner": "https://api.calendly.com/users/123456789",' +
                        '"type": "User"' +
                    '},' +
                    '"scheduling_url": "https://calendly.com",' +
                    '"secret": false,' +
                    '"slug": "15min",' +
                    '"type": "StandardEventType",' +
                    '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                    '"uri": "https://api.calendly.com/event_types/123456789"' +
                '}' +
            '],' +
            '"pagination": {' +
                '"count": 1,' +
                '"next_page": "https://api.calendly.com/event_types?user=https://api.calendly.com/users/123456789&organization=https://api.calendly.com/organizations/123456789&page_token=123&count=10&sort=sort_name:asc&"' +
            '}' +
        '}';
    }

    private static String getScheduledEventCollectionResponse() {
        return '{' +
            '"collection": [' +
                '{' +
                    '"status": "active",' +
                    '"end_time": "2020-03-09T14:00:17.399346Z",' +
                    '"start_time": "2020-03-09T14:00:17.399346Z",' +
                    '"created_at": "2020-03-09T14:00:17.399346Z",' +
                    '"event_guests": [{ "created_at": "2020-03-09T14:00:17.399346Z", "updated_at": "2020-03-09T14:00:17.399346Z", "email": "test@test.com" }],' +
                    '"event_memberships": [{ "user": "https://api.calendly.com/users/123456789" }],' +
                    '"event_type": "https://api.calendly.com/event_types/123456789",' +
                    '"invitees_counter": { "active": 1, "limit": 1, "total": 1 },' +
                    '"location": { "location": "custom location", "type": "custom" },' +
                    '"name": "15 Minute Meeting",' +
                    '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                    '"uri": "https://api.calendly.com/scheduled_events/123456789"' +
                '}' +
            '],' +
            '"pagination": {' +
                '"count": 1,' +
                '"next_page": "https://api.calendly.com/scheduled_events/?user=https://api.calendly.com/users/123456789&organization=https://api.calendly.com/organizations/123456789&max_start_time=2020-03-09T14:00:17.399Z&min_start_time=2020-03-09T14:00:17.399Z&status=active&invitee_email=test@test.com&page_token=123&count=10&sort=sort_name:asc&"' +
            '}' +
        '}';
    }

    private static String getScheduledEventResponse() {
        return '{' +
            '"resource":' +
                '{' +
                    '"status": "active",' +
                    '"end_time": "2020-03-09T14:00:17.399346Z",' +
                    '"start_time": "2020-03-09T14:00:17.399346Z",' +
                    '"created_at": "2020-03-09T14:00:17.399346Z",' +
                    '"event_guests": [{ "created_at": "2020-03-09T14:00:17.399346Z", "updated_at": "2020-03-09T14:00:17.399346Z", "email": "test@test.com" }],' +
                    '"event_memberships": [{ "user": "https://api.calendly.com/users/123456789" }],' +
                    '"event_type": "https://api.calendly.com/event_types/123456789",' +
                    '"invitees_counter": { "active": 1, "limit": 1, "total": 1 },' +
                    '"location": { "location": "custom location", "type": "custom" },' +
                    '"name": "15 Minute Meeting",' +
                    '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                    '"uri": "https://api.calendly.com/scheduled_events/123456789"' +
                '}' +
            '}';
    }

    private static String getOrganizationMembershipCollectionResponse() {
        return '{' +
                '"collection": [{' +
                    '"created_at": "2020-03-09T14:00:17.399346Z",' +
                    '"organization": "https://api.calendly.com/organizations/123456789",' +
                    '"role": "user",' +
                    '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                    '"uri": "https://api.calendly.com/organization_memberships/123456789",' +
                    '"user": {' +
                        '"avatar_url": "avatar_url",' +
                        '"created_at": "2020-03-09T14:00:17.399346Z",' +
                        '"email": "test@test.com",' +
                        '"name": "John Doe",' +
                        '"scheduling_url": "https://calendly.com",' +
                        '"slug": "test",' +
                        '"timezone": "America/New_York",' +
                        '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                        '"uri": "https://api.calendly.com/users/123456789"' +
                    '}' +
                 '}],' +
                 '"pagination": {' +
                    '"count": 1,' +
                    '"next_page": "https://api.calendly.com/organization_memberships?user=https://api.calendly.com/users/123456789&organization=https://api.calendly.com/organizations/123456789&email=test@test.com&page_token=123&count=10&"' +
                 '}' +
               '}';
    }

    private static String getOrganizationMembershipResponse() {
        return '{' +
                '"resource": {' +
                    '"created_at": "2020-03-09T14:00:17.399346Z",' +
                    '"organization": "https://api.calendly.com/organizations/123456789",' +
                    '"role": "user",' +
                    '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                    '"uri": "https://api.calendly.com/organization_memberships/123456789",' +
                    '"user": {' +
                        '"avatar_url": "avatar_url",' +
                        '"created_at": "2020-03-09T14:00:17.399346Z",' +
                        '"email": "test@test.com",' +
                        '"name": "John Doe",' +
                        '"scheduling_url": "https://calendly.com",' +
                        '"slug": "test",' +
                        '"timezone": "America/New_York",' +
                        '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                        '"uri": "https://api.calendly.com/users/123456789"' +
                    '}' +
                 '}' +
               '}';
    }

    private static String getInvalidRequestErrorResponse() {
        return '{' +
            '"details": [' +
                '{' +
                    '"message": "user or organization must be filled",' +
                    '"parameter": "organization"' +
                '},' +
                '{' +
                    '"message": "user or organization must be filled",' +
                    '"parameter": "user"' +
                '}' +
            '],' +
            '"message": "The supplied parameters are invalid.",' +
            '"title": "Invalid Argument"' +
        '}';
    }

    private static String getOrganizationInvitationResourceResponse() {
        return '{' +
            '"resource": {' +
                '"uri": "https://api.calendly.com/organizations/123456789/invitations/123456789",' +
                '"created_at": "2020-03-09T14:00:17.399346Z",' +
                '"email": "test2@test.com",' +
                '"organization": "https://api.calendly.com/organizations/123456789",' +
                '"status": "pending",' +
                '"last_sent_at": "2020-03-09T14:00:17.399346Z",' +
                '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                '"user": "https://api.calendly.com/users/123456789' +
            '"}' +
        '}';
    }

    private static String getOrganizationInvitationCollectionResponse() {
        return '{' +
            '"collection": [{' +
                '"uri": "https://api.calendly.com/organizations/123456789/invitations/123456789",' +
                '"created_at": "2020-03-09T14:00:17.399346Z",' +
                '"email": "test2@test.com",' +
                '"organization": "https://api.calendly.com/organizations/123456789",' +
                '"status": "pending",' +
                '"last_sent_at": "2020-03-09T14:00:17.399346Z",' +
                '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                '"user": "https://api.calendly.com/users/123456789' +
            '"}],' +
            '"pagination": {' +
                    '"count": 1,' +
                    '"next_page": "https://api.calendly.com/organizations/123456789/invitations?email=test@test.com&status=active&page_token=123&count=10&sort=sort_name:asc&"' +
              '}' +
            '}';
    }

    private static String getCreateWebhookSubscriptionResponse() {
        return '{' +
            '"resource": {' +
                '"uri": "https://api.calendly.com/webhook_subscriptions/123456789",' +
                '"created_at": "2020-03-09T14:00:17.399346Z",' +
                '"retry_started_at": "2020-03-09T14:00:17.399346Z",' +
                '"callback_url": "http://localhost:3000",' +
                '"state": "active",' +
                '"events": ["invitee.created", "invitee.canceled"],' +
                '"scope": "organization",' +
                '"status": "pending",' +
                '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                '"organization": "https://api.calendly.com/organizations/123456789",' +
                '"creator": "https://api.calendly.com/users/123456789",' +
                '"user": "https://api.calendly.com/users/123456789"' +
            '}' +
        '}';
    }

    private static String getWebhookSubscriptionResponse() {
        return '{' +
            '"resource": {' +
                '"uri": "https://api.calendly.com/webhook_subscriptions/123456789",' +
                '"created_at": "2020-03-09T14:00:17.399346Z",' +
                '"retry_started_at": "2020-03-09T14:00:17.399346Z",' +
                '"callback_url": "http://localhost:3000",' +
                '"state": "active",' +
                '"events": ["invitee.created", "invitee.canceled"],' +
                '"scope": "organization",' +
                '"status": "pending",' +
                '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                '"organization": "https://api.calendly.com/organizations/123456789",' +
                '"creator": "https://api.calendly.com/users/123456789",' +
                '"user": "https://api.calendly.com/users/123456789"' +
            '}' +
        '}';
    }

    private static String getWebhookSubscriptionCollectionResponse() {
        return '{' +
            '"collection": [{' +
                '"uri": "https://api.calendly.com/webhook_subscriptions/123456789",' +
                '"created_at": "2020-03-09T14:00:17.399346Z",' +
                '"retry_started_at": "2020-03-09T14:00:17.399346Z",' +
                '"callback_url": "http://localhost:3000",' +
                '"state": "active",' +
                '"events": ["invitee.created", "invitee.canceled"],' +
                '"scope": "organization",' +
                '"status": "pending",' +
                '"updated_at": "2020-03-09T14:00:17.399346Z",' +
                '"organization": "https://api.calendly.com/organizations/123456789",' +
                '"creator": "https://api.calendly.com/users/123456789",' +
                '"user": "https://api.calendly.com/users/123456789"' +
            '}],' +
            '"pagination": {' +
                    '"count": 1,' +
                    '"next_page": "https://api.calendly.com/webhook_subscriptions?organization=https://api.calendly.com/organizations/123456789&scope=organization&user=https://api.calendly.com/users/123456789&page_token=123&count=10&sort=sort_name:asc&"' +
            '}' +
        '}';
    }

    private static String getScheduledEventsPaginationUrl() {
        return 'callout:calendly_api/scheduled_events/?user=https://api.calendly.com/users/123456789&organization=https://api.calendly.com/organizations/123456789&max_start_time=2020-03-09T14:00:17.399Z&min_start_time=2020-03-09T14:00:17.399Z&status=active&invitee_email=test@test.com&page_token=123&count=10&sort=sort_name:asc&';
    }

    private static String getEventTypesPaginationUrl() {
        return 'callout:calendly_api/event_types?user=https://api.calendly.com/users/123456789&organization=https://api.calendly.com/organizations/123456789&page_token=123&count=10&sort=sort_name:asc&';
    }

    private static String getInviteesPaginationUrl() {
        return 'callout:calendly_api/scheduled_events/123456789/invitees?email=test@test.com&status=active&page_token=123&count=10&sort=sort_name:asc&';
    }

    private static String getOrganizationMembershipsPaginationUrl() {
        return 'callout:calendly_api/organization_memberships?user=https://api.calendly.com/users/123456789&organization=https://api.calendly.com/organizations/123456789&email=test@test.com&page_token=123&count=10&';
    }

    private static String getOrganizationInvitationsPaginationUrl() {
        return 'callout:calendly_api/organizations/123456789/invitations?email=test@test.com&status=active&page_token=123&count=10&sort=sort_name:asc&';
    }

    private static String getWebhookSubscriptionsPaginationUrl() {
        return 'callout:calendly_api/webhook_subscriptions?organization=https://api.calendly.com/organizations/123456789&scope=organization&user=https://api.calendly.com/users/123456789&page_token=123&count=10&sort=sort_name:asc&';
    }
  }