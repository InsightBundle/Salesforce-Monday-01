@isTest
private class CalendlyApiTest {
  @isTest 
  static void getCurrentUserTest() {       
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 
    
    CalendlyApi.UserResource response = CalendlyApi.getCurrentUser();

    System.assertEquals(response.resource.avatar_url, 'avatar_url');
    validateDateField(response.resource.created_at);
    validateDateField(response.resource.updated_at);
    System.assertEquals(response.resource.email, 'test@test.com');
    System.assertEquals(response.resource.name, 'John Doe');
    System.assertEquals(response.resource.scheduling_url, 'https://calendly.com');
    System.assertEquals(response.resource.slug, 'test');
    System.assertEquals(response.resource.timezone, 'America/New_York');
    System.assertEquals(response.resource.uri, 'https://api.calendly.com/users/me');
  }

  @isTest
  static void getUserTest() {       
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 
    
    String uuid = '123456789';
    CalendlyApi.UserResource response = CalendlyApi.getUser(uuid);

    System.assertEquals(response.resource.avatar_url, 'avatar_url');
    validateDateField(response.resource.created_at);
    validateDateField(response.resource.updated_at);
    System.assertEquals(response.resource.email, 'test@test.com');
    System.assertEquals(response.resource.name, 'John Doe');
    System.assertEquals(response.resource.scheduling_url, 'https://calendly.com');
    System.assertEquals(response.resource.slug, 'test');
    System.assertEquals(response.resource.timezone, 'America/New_York');
    System.assertEquals(response.resource.uri, 'https://api.calendly.com/users/' + uuid);
    System.assertEquals(response.resource.current_organization, 'https://api.calendly.com/organizations/123456789');
  }

  @isTest
  static void getEventTypesTest() {       
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 
    
    CalendlyApi.EventTypeQueryParams params = new CalendlyApi.EventTypeQueryParams();
    CalendlyApi.SortParam sortParam = new CalendlyApi.SortParam();
    List<CalendlyApi.SortParam> sortParams = new List<CalendlyApi.SortParam>();
    sortParam.name = 'sort_name';
    sortParam.order = 'asc';
    sortParams.add(sortParam);

    params.count = 10;
    params.organization = 'https://api.calendly.com/organizations/123456789';
    params.page_token = '123';
    params.sort_params = sortParams;
    params.user = 'https://api.calendly.com/users/123456789';

    CalendlyApi.EventTypeCollection response = CalendlyApi.getEventTypes(params);

    CalendlyApi.EventType eventType = response.collection.get(0);
    CalendlyApi.EventTypePagination pagination = response.pagination;
    CalendlyApi.EventTypeCollection nextPage = response.pagination.nextPage();

    System.assertEquals(response.pagination.count, 1);
    System.assertEquals(response.pagination.next_page, 'https://api.calendly.com/event_types?user=https://api.calendly.com/users/123456789&organization=https://api.calendly.com/organizations/123456789&page_token=123&count=10&sort=sort_name:asc&');
    System.assertEquals(response.pagination.hasNextPage(), true);
    System.assertNotEquals(nextPage, null);
    
    System.assertEquals(eventType.internal_note, 'internal_note');
    validateDateField(eventType.created_at);
    validateDateField(eventType.updated_at);
    System.assertEquals(eventType.kind, 'solo');
    System.assertEquals(eventType.name, '15 Minute Meeting');
    System.assertEquals(eventType.pooling_type, 'pooling_type');
    System.assertEquals(eventType.profile.name, 'John Doe');
    System.assertEquals(eventType.profile.owner, 'https://api.calendly.com/users/123456789');
    System.assertEquals(eventType.profile.type, 'User');
    System.assertEquals(eventType.secret, false);
    System.assertEquals(eventType.scheduling_url, 'https://calendly.com');
    System.assertEquals(eventType.duration, 15);
    System.assertEquals(eventType.description_html, 'html');
    System.assertEquals(eventType.description_plain, 'text');
    System.assertEquals(eventType.color, '#dfc12d');
    System.assertEquals(eventType.uri, 'https://api.calendly.com/event_types/123456789');
  }

  @isTest
  static void getEventTypeTest() {
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 

    CalendlyApi.EventTypeResource response = CalendlyApi.getEventType('123456789');
    
    System.assertEquals(response.resource.internal_note, 'internal_note');
    validateDateField(response.resource.created_at);
    validateDateField(response.resource.updated_at);
    System.assertEquals(response.resource.kind, 'solo');
    System.assertEquals(response.resource.name, '15 Minute Meeting');
    System.assertEquals(response.resource.pooling_type, 'pooling_type');
    System.assertEquals(response.resource.profile.name, 'John Doe');
    System.assertEquals(response.resource.profile.owner, 'https://api.calendly.com/users/123456789');
    System.assertEquals(response.resource.profile.type, 'User');
    System.assertEquals(response.resource.secret, false);
    System.assertEquals(response.resource.scheduling_url, 'https://calendly.com');
    System.assertEquals(response.resource.duration, 15);
    System.assertEquals(response.resource.description_html, 'html');
    System.assertEquals(response.resource.description_plain, 'text');
    System.assertEquals(response.resource.color, '#dfc12d');
    System.assertEquals(response.resource.uri, 'https://api.calendly.com/event_types/123456789');
  }

  @isTest
  static void createSchedulingLinkTest() {
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 

    CalendlyApi.EventTypeResource response = CalendlyApi.getEventType('123456789');
    
    System.assertEquals(response.resource.uri, 'https://api.calendly.com/event_types/123456789');

    CalendlyApi.SchedulingLink schedulingLink = response.resource.createSchedulingLink();

    System.assertEquals(schedulingLink.booking_url, 'https://calendly.com');
    System.assertEquals(schedulingLink.owner, 'https://api.calendly.com/event_types/123456789');
    System.assertEquals(schedulingLink.owner_type, 'EventType');

    CalendlyApi.EventType eventType = schedulingLink.getOwner();

    System.assertEquals(eventType.uri, schedulingLink.owner);
  }

  @isTest
  static void getScheduledEventsTest() {       
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 
    
    CalendlyApi.ScheduledEventQueryParams params = new CalendlyApi.ScheduledEventQueryParams();
    CalendlyApi.SortParam sortParam = new CalendlyApi.SortParam();
    List<CalendlyApi.SortParam> sortParams = new List<CalendlyApi.SortParam>();
    
    sortParam.name = 'sort_name';
    sortParam.order = 'asc';
    sortParams.add(sortParam);

    Datetime minStartTime = (DateTime) JSON.deserialize('"2020-03-09T14:00:17.399Z"', DateTime.class);
    Datetime maxStartTime = (DateTime) JSON.deserialize('"2020-03-09T14:00:17.399Z"', DateTime.class);

    params.count = 10;
    params.max_start_time = maxStartTime;
    params.min_start_time = minStartTime;
    params.invitee_email = 'test@test.com';
    params.status = 'active';
    params.organization = 'https://api.calendly.com/organizations/123456789';
    params.page_token = '123';
    params.sort_params = sortParams;
    params.user = 'https://api.calendly.com/users/123456789';

    CalendlyApi.ScheduledEventCollection response = CalendlyApi.getScheduledEvents(params);

    CalendlyApi.ScheduledEvent event = response.collection.get(0);
    CalendlyApi.ScheduledEventPagination pagination = response.pagination;
    CalendlyApi.ScheduledEventCollection nextPage = response.pagination.nextPage();
    CalendlyApi.EventGuest guest = event.event_guests.get(0);
    CalendlyApi.EventMembership eventMembership = event.event_memberships.get(0);

    System.assertEquals(response.pagination.count, 1);
    System.assertEquals(response.pagination.next_page, 'https://api.calendly.com/scheduled_events/?user=https://api.calendly.com/users/123456789&organization=https://api.calendly.com/organizations/123456789&max_start_time=2020-03-09T14:00:17.399Z&min_start_time=2020-03-09T14:00:17.399Z&status=active&invitee_email=test@test.com&page_token=123&count=10&sort=sort_name:asc&');
    System.assertEquals(response.pagination.hasNextPage(), true);
    System.assertEquals(nextPage.collection.size(), 1);
    
    System.assertEquals(event.status, 'active');
    validateDateField(event.created_at);
    validateDateField(event.updated_at);
    validateDateField(event.end_time);
    validateDateField(event.start_time);
    validateDateField(guest.created_at);
    validateDateField(guest.updated_at);
    System.assertEquals(guest.email, 'test@test.com');
    System.assertEquals(event.event_type, 'https://api.calendly.com/event_types/123456789');
    System.assertEquals(event.invitees_counter.invitee_limit, 1);
    System.assertEquals(event.invitees_counter.active, 1);
    System.assertEquals(event.invitees_counter.total, 1);
    System.assertEquals(event.location.type, 'custom');
    System.assertEquals(event.location.location, 'custom location');
    System.assertEquals(eventMembership.user, 'https://api.calendly.com/users/123456789');
  }

  @isTest
  static void getScheduledEventTest() {       
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 

    CalendlyApi.ScheduledEventResource response = CalendlyApi.getScheduledEvent('123456789');
    CalendlyApi.ScheduledEvent event = response.resource;
    CalendlyApi.EventMembership eventMembership = event.event_memberships.get(0);
    CalendlyApi.EventGuest guest = event.event_guests.get(0);
    
    System.assertEquals(event.status, 'active');
    validateDateField(event.created_at);
    validateDateField(event.updated_at);
    validateDateField(event.end_time);
    validateDateField(event.start_time);
    validateDateField(guest.created_at);
    validateDateField(guest.updated_at);
    System.assertEquals(guest.email, 'test@test.com');
    System.assertEquals(event.event_type, 'https://api.calendly.com/event_types/123456789');
    System.assertEquals(event.invitees_counter.invitee_limit, 1);
    System.assertEquals(event.invitees_counter.active, 1);
    System.assertEquals(event.invitees_counter.total, 1);
    System.assertEquals(event.location.type, 'custom');
    System.assertEquals(event.location.location, 'custom location');

    CalendlyApi.EventType eventType = event.getEventType();
    CalendlyApi.User user = eventMembership.getUser();
    System.assertEquals(eventMembership.user, user.uri);
    

    CalendlyApi.InviteeQueryParams params = new CalendlyApi.InviteeQueryParams();
    CalendlyApi.SortParam sortParam = new CalendlyApi.SortParam();
    List<CalendlyApi.SortParam> sortParams = new List<CalendlyApi.SortParam>();
    
    sortParam.name = 'sort_name';
    sortParam.order = 'asc';
    sortParams.add(sortParam);

    params.count = 10;
    params.email = 'test@test.com';
    params.status = 'active';
    params.page_token = '123';
    params.sort_params = sortParams;

    CalendlyApi.InviteeCollection inviteeCollection = event.getInvitees(params);

    System.assertEquals(inviteeCollection.collection.size(), 1);
    System.assertEquals(inviteeCollection.pagination.next_page, 'https://api.calendly.com/scheduled_events/123456789/invitees?email=test@test.com&status=active&page_token=123&count=10&sort=sort_name:asc&');
  }

  @isTest
  static void getInviteesTest() {       
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 
    CalendlyApi.InviteeQueryParams params = new CalendlyApi.InviteeQueryParams();
    CalendlyApi.SortParam sortParam = new CalendlyApi.SortParam();
    List<CalendlyApi.SortParam> sortParams = new List<CalendlyApi.SortParam>();
    
    sortParam.name = 'sort_name';
    sortParam.order = 'asc';
    sortParams.add(sortParam);

    params.count = 10;
    params.email = 'test@test.com';
    params.status = 'active';
    params.page_token = '123';
    params.sort_params = sortParams;

    CalendlyApi.InviteeCollection response = CalendlyApi.getInvitees('123456789', params);

    CalendlyApi.Invitee invitee = response.collection.get(0);
    CalendlyApi.InviteePagination pagination = response.pagination;
    CalendlyApi.InviteeCollection nextPage = response.pagination.nextPage();

    System.assertEquals(response.pagination.count, 1);
    System.assertEquals(response.pagination.next_page, 'https://api.calendly.com/scheduled_events/123456789/invitees?email=test@test.com&status=active&page_token=123&count=10&sort=sort_name:asc&');
    System.assertEquals(response.pagination.hasNextPage(), true);
    System.assertEquals(nextPage.collection.size(), 1);
    
    CalendlyApi.InviteePayment payment = invitee.payment;
    CalendlyApi.InviteeQuestionsAndAnswer questionAndAnswer = invitee.questions_and_answers.get(0);
    
    System.assertEquals(invitee.uri, 'https://api.calendly.com/scheduled_events/123456789/invitees/123456789');
    validateDateField(invitee.created_at);
    validateDateField(invitee.updated_at);
    System.assertEquals(invitee.email, 'test@test.com');
    System.assertEquals(invitee.cancel_url, 'https://api.calendly.com/cancellations/123456789');
    System.assertEquals(invitee.cancellation.canceled_by, 'John Doe');
    System.assertEquals(invitee.cancellation.reason, 'cancellation reason');
    System.assertEquals(invitee.event, 'https://api.calendly.com/scheduled_events/123456789');
    System.assertEquals(invitee.name, 'John Doe');
    System.assertEquals(invitee.new_invitee, 'https://api.calendly.com/scheduled_events/123456789/invitees/123456789');
    System.assertEquals(invitee.old_invitee, 'https://api.calendly.com/scheduled_events/123456789/invitees/123456789');
    System.assertEquals(payment.external_id, 'ch_AAAAAAAAAAAAAAAAAAAAAAAA');
    System.assertEquals(payment.provider, 'stripe');
    System.assertEquals(payment.payment_amount, 1234.56);
    System.assertEquals(payment.payment_currency, 'USD');
    System.assertEquals(payment.terms, 'sample terms of payment (up to 1,024 characters)');
    System.assertEquals(payment.successful, true);
    System.assertEquals(questionAndAnswer.answer, 'answer');
    System.assertEquals(questionAndAnswer.position, 0);
    System.assertEquals(questionAndAnswer.question, 'question');
    System.assertEquals(invitee.reschedule_url, 'https://api.calendly.com/reschedulings/123456789');
    System.assertEquals(invitee.status, 'canceled');
    System.assertEquals(invitee.text_reminder_number, '123456789');
    System.assertEquals(invitee.timezone, 'America/New_York');
    System.assertEquals(invitee.tracking.utm_campaign, 'utm_campaign');
    System.assertEquals(invitee.tracking.utm_source, 'utm_source');
    System.assertEquals(invitee.tracking.utm_medium, 'utm_medium');
    System.assertEquals(invitee.tracking.utm_content, 'utm_content');
    System.assertEquals(invitee.tracking.utm_term, 'utm_term');
    System.assertEquals(invitee.tracking.salesforce_uuid, 'salesforce_uuid');
    System.assertEquals(invitee.uri, 'https://api.calendly.com/scheduled_events/123456789/invitees/123456789');
  }

  @isTest
  static void getInviteeTest() {       
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 

    CalendlyApi.InviteeResource response = CalendlyApi.getInvitee('123456789', '123456789');
    CalendlyApi.Invitee invitee = response.resource;
    CalendlyApi.InviteePayment payment = invitee.payment;
    CalendlyApi.InviteeQuestionsAndAnswer questionAndAnswer = invitee.questions_and_answers.get(0);
    
    System.assertEquals(invitee.uri, 'https://api.calendly.com/scheduled_events/123456789/invitees/123456789');
    validateDateField(invitee.created_at);
    validateDateField(invitee.updated_at);
    System.assertEquals(invitee.email, 'test@test.com');
    System.assertEquals(invitee.cancel_url, 'https://api.calendly.com/cancellations/123456789');
    System.assertEquals(invitee.cancellation.canceled_by, 'John Doe');
    System.assertEquals(invitee.cancellation.reason, 'cancellation reason');
    System.assertEquals(invitee.event, 'https://api.calendly.com/scheduled_events/123456789');
    System.assertEquals(invitee.name, 'John Doe');
    System.assertEquals(invitee.new_invitee, 'https://api.calendly.com/scheduled_events/123456789/invitees/123456789');
    System.assertEquals(invitee.old_invitee, 'https://api.calendly.com/scheduled_events/123456789/invitees/123456789');
    System.assertEquals(payment.external_id, 'ch_AAAAAAAAAAAAAAAAAAAAAAAA');
    System.assertEquals(payment.provider, 'stripe');
    System.assertEquals(payment.payment_amount, 1234.56);
    System.assertEquals(payment.payment_currency, 'USD');
    System.assertEquals(payment.terms, 'sample terms of payment (up to 1,024 characters)');
    System.assertEquals(payment.successful, true);
    System.assertEquals(questionAndAnswer.answer, 'answer');
    System.assertEquals(questionAndAnswer.position, 0);
    System.assertEquals(questionAndAnswer.question, 'question');
    System.assertEquals(invitee.reschedule_url, 'https://api.calendly.com/reschedulings/123456789');
    System.assertEquals(invitee.status, 'canceled');
    System.assertEquals(invitee.text_reminder_number, '123456789');
    System.assertEquals(invitee.timezone, 'America/New_York');
    System.assertEquals(invitee.tracking.utm_campaign, 'utm_campaign');
    System.assertEquals(invitee.tracking.utm_source, 'utm_source');
    System.assertEquals(invitee.tracking.utm_medium, 'utm_medium');
    System.assertEquals(invitee.tracking.utm_content, 'utm_content');
    System.assertEquals(invitee.tracking.utm_term, 'utm_term');
    System.assertEquals(invitee.tracking.salesforce_uuid, 'salesforce_uuid');
    System.assertEquals(invitee.uri, 'https://api.calendly.com/scheduled_events/123456789/invitees/123456789');

    CalendlyApi.Invitee oldInvitee = invitee.getOldInvitee();
    CalendlyApi.Invitee newInvitee = invitee.getNewInvitee();
    CalendlyApi.ScheduledEvent event = invitee.getEvent();

    System.assertEquals(oldInvitee.uri, 'https://api.calendly.com/scheduled_events/123456789/invitees/123456789');
    System.assertEquals(newInvitee.uri, 'https://api.calendly.com/scheduled_events/123456789/invitees/123456789');
    System.assertEquals(event.uri, invitee.event);
  }

  @isTest
  static void getOrganizationMembershipsTest() {       
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 

    CalendlyApi.OrganizationMembershipQueryParams params = new CalendlyApi.OrganizationMembershipQueryParams();

    params.count = 10;
    params.email = 'test@test.com';
    params.page_token = '123';
    params.organization = 'https://api.calendly.com/organizations/123456789';
    params.user = 'https://api.calendly.com/users/123456789';

    CalendlyApi.OrganizationMembershipCollection response = CalendlyApi.getOrganizationMemberships(params);
    CalendlyApi.OrganizationMembership membership = response.collection.get(0);
    CalendlyApi.OrganizationMembershipUser user = membership.user;
    
    CalendlyApi.OrganizationMembershipPagination pagination = response.pagination;
    CalendlyApi.OrganizationMembershipCollection nextPage = response.pagination.nextPage();

    System.assertEquals(response.pagination.count, 1);
    System.assertEquals(response.pagination.next_page, 'https://api.calendly.com/organization_memberships?user=https://api.calendly.com/users/123456789&organization=https://api.calendly.com/organizations/123456789&email=test@test.com&page_token=123&count=10&');
    System.assertEquals(response.pagination.hasNextPage(), true);
    System.assertEquals(nextPage.collection.size(), 1);

    System.assertEquals(membership.uri, 'https://api.calendly.com/organization_memberships/123456789');
    validateDateField(membership.created_at);
    validateDateField(membership.updated_at);
    validateDateField(user.created_at);
    validateDateField(user.updated_at);
    System.assertEquals(membership.organization, 'https://api.calendly.com/organizations/123456789');
    System.assertEquals(membership.role, 'user');
    System.assertEquals(user.email, 'test@test.com');
    System.assertEquals(user.name, 'John Doe');
    System.assertEquals(user.scheduling_url, 'https://calendly.com');
    System.assertEquals(user.slug, 'test');
    System.assertEquals(user.timezone, 'America/New_York');
    System.assertEquals(user.uri, 'https://api.calendly.com/users/123456789');
  }

  @isTest
  static void getOrganizationMembershipTest() {       
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 

    CalendlyApi.OrganizationMembershipResource response = CalendlyApi.getOrganizationMembership('123456789');
    CalendlyApi.OrganizationMembership membership = response.resource;
    CalendlyApi.OrganizationMembershipUser user = response.resource.user;
    
    System.assertEquals(membership.uri, 'https://api.calendly.com/organization_memberships/123456789');
    validateDateField(membership.created_at);
    validateDateField(membership.updated_at);
    validateDateField(user.created_at);
    validateDateField(user.updated_at);
    System.assertEquals(membership.organization, 'https://api.calendly.com/organizations/123456789');
    System.assertEquals(membership.role, 'user');
    System.assertEquals(user.email, 'test@test.com');
    System.assertEquals(user.name, 'John Doe');
    System.assertEquals(user.scheduling_url, 'https://calendly.com');
    System.assertEquals(user.slug, 'test');
    System.assertEquals(user.timezone, 'America/New_York');
    System.assertEquals(user.uri, 'https://api.calendly.com/users/123456789');

    membership.removeUser();
  }

  @isTest
  static void getCurrentOrganizationTest() {       
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 

    CalendlyApi.Organization organization = CalendlyApi.getCurrentOrganization();
    System.assertEquals(organization.uri, 'https://api.calendly.com/organizations/123456789');

    CalendlyApi.OrganizationInvitationResource resource = organization.sendOrganizationInvitation('test2@test.com');
    CalendlyApi.OrganizationInvitation invitation = resource.resource;

    validateDateField(invitation.created_at);
    validateDateField(invitation.updated_at);
    validateDateField(invitation.last_sent_at);
    System.assertEquals(invitation.email, 'test2@test.com');
    System.assertEquals(invitation.user, 'https://api.calendly.com/users/123456789');
    System.assertEquals(invitation.status, 'pending');
    System.assertEquals(invitation.organization, 'https://api.calendly.com/organizations/123456789');
    System.assertEquals(invitation.uri, 'https://api.calendly.com/organizations/123456789/invitations/123456789');

    invitation.revokeInvitation();
    CalendlyApi.User user = invitation.getUserWhoSentInvitation();

    System.assertEquals(user.uri, 'https://api.calendly.com/users/123456789');

    CalendlyApi.OrganizationInvitationQueryParams params = new CalendlyApi.OrganizationInvitationQueryParams();
    CalendlyApi.SortParam sortParam = new CalendlyApi.SortParam();
    List<CalendlyApi.SortParam> sortParams = new List<CalendlyApi.SortParam>();

    sortParam.name = 'sort_name';
    sortParam.order = 'asc';
    sortParams.add(sortParam);

    params.count = 10;
    params.email = 'test@test.com';
    params.status = 'active';
    params.page_token = '123';
    params.sort_params = sortParams;
    
    CalendlyApi.OrganizationInvitationCollection invitationCollection = organization.getOrganizationInvitations(params);
    System.assertEquals(invitationCollection.pagination.hasNextPage(), true);
    System.assertEquals(invitationCollection.collection.size(), 1);
    
    CalendlyApi.OrganizationInvitationCollection invitationCollection2 = invitationCollection.pagination.nextPage();
    System.assertEquals(invitationCollection2.collection.size(), 1);

    CalendlyApi.OrganizationMembershipQueryParams organizationMembershipQueryParams = new CalendlyApi.OrganizationMembershipQueryParams();
    organizationMembershipQueryParams.count = 10;
    organizationMembershipQueryParams.email = 'test@test.com';
    organizationMembershipQueryParams.page_token = '123';
    organizationMembershipQueryParams.user = 'https://api.calendly.com/users/123456789';

    CalendlyApi.OrganizationMembershipCollection organizationMemberships  = organization.getOrganizationMemberships(organizationMembershipQueryParams);
    System.assertEquals(organizationMemberships.pagination.hasNextPage(), true);
    System.assertEquals(organizationMemberships.collection.size(), 1);

  }

  @isTest
  static void createWebhookSubscriptionTest() {
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock());

    CalendlyApi.CreateWebhookSubscriptionRequest req = new CalendlyApi.CreateWebhookSubscriptionRequest();
    List<String> events = new List<String>();

    req.url = 'http://localhost:3000';
    req.organization = 'https://api.calendly.com/organizations/123456789';
    req.user = 'https://api.calendly.com/users/123456789';
    req.scope = 'organization';
    req.events = new List<String> {
      'invitee.created',
      'invitee.canceled'
    };


    CalendlyApi.WebhookSubscriptionResource response = CalendlyApi.createWebhookSubscription(req);
    CalendlyApi.WebhookSubscription subscription = response.resource;

    System.assertEquals(subscription.callback_url, req.url);
    System.assertEquals(subscription.organization, req.organization);
    System.assertEquals(subscription.user, req.user);
    System.assertEquals(subscription.scope, req.scope);
    System.assertEquals(subscription.events.get(0), 'invitee.created');
    System.assertEquals(subscription.events.get(1), 'invitee.canceled');
    System.assertEquals(subscription.creator, req.user);
    validateDateField(subscription.created_at);
    validateDateField(subscription.updated_at);
    validateDateField(subscription.retry_started_at);
  }

  @isTest
  static void getWebhookSubscriptionTest() {
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock());

    CalendlyApi.WebhookSubscriptionResource response = CalendlyApi.getWebhookSubscription('123456789');
    CalendlyApi.WebhookSubscription subscription = response.resource;

    System.assertEquals(subscription.uri, 'https://api.calendly.com/webhook_subscriptions/123456789');
    System.assertEquals(subscription.callback_url, 'http://localhost:3000');
    System.assertEquals(subscription.organization, 'https://api.calendly.com/organizations/123456789');
    System.assertEquals(subscription.user, 'https://api.calendly.com/users/123456789');
    System.assertEquals(subscription.scope, 'organization');
    System.assertEquals(subscription.events.get(0), 'invitee.created');
    System.assertEquals(subscription.events.get(1), 'invitee.canceled');
    System.assertEquals(subscription.creator, 'https://api.calendly.com/users/123456789');
    validateDateField(subscription.created_at);
    validateDateField(subscription.updated_at);
    validateDateField(subscription.retry_started_at);

    subscription.deleteWebhookSubscription();
  }

  @isTest
  static void getWebhookSubscriptionsTest() {
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock());

    CalendlyApi.WebhookSubscriptionQueryParams params = new CalendlyApi.WebhookSubscriptionQueryParams();
    CalendlyApi.SortParam sortParam = new CalendlyApi.SortParam();
    List<CalendlyApi.SortParam> sortParams = new List<CalendlyApi.SortParam>();
    sortParam.name = 'sort_name';
    sortParam.order = 'asc';
    sortParams.add(sortParam);

    params.count = 10;
    params.organization = 'https://api.calendly.com/organizations/123456789';
    params.page_token = '123';
    params.sort_params = sortParams;
    params.user = 'https://api.calendly.com/users/123456789';
    params.scope = 'organization';

    CalendlyApi.WebhookSubscriptionCollection response = CalendlyApi.getWebhookSubscriptions(params);

    CalendlyApi.WebhookSubscription subscription = response.collection.get(0);
    CalendlyApi.WebhookSubscriptionPagination pagination = response.pagination;
    CalendlyApi.WebhookSubscriptionCollection nextPage = response.pagination.nextPage();

    System.assertEquals(response.pagination.count, 1);
    System.assertEquals(response.pagination.next_page, 'https://api.calendly.com/webhook_subscriptions?organization=https://api.calendly.com/organizations/123456789&scope=organization&user=https://api.calendly.com/users/123456789&page_token=123&count=10&sort=sort_name:asc&');
    System.assertEquals(response.pagination.hasNextPage(), true);
    System.assertNotEquals(nextPage, null);

    System.assertEquals(subscription.uri, 'https://api.calendly.com/webhook_subscriptions/123456789');
    System.assertEquals(subscription.callback_url, 'http://localhost:3000');
    System.assertEquals(subscription.organization, 'https://api.calendly.com/organizations/123456789');
    System.assertEquals(subscription.user, 'https://api.calendly.com/users/123456789');
    System.assertEquals(subscription.scope, 'organization');
    System.assertEquals(subscription.events.get(0), 'invitee.created');
    System.assertEquals(subscription.events.get(1), 'invitee.canceled');
    System.assertEquals(subscription.creator, 'https://api.calendly.com/users/123456789');
    validateDateField(subscription.created_at);
    validateDateField(subscription.updated_at);
    validateDateField(subscription.retry_started_at);
  }
    
  @isTest
  static void verifyWebhookSubscriptionTest() {
    String signingKey = '1234567890';
    String webhookPayload = '{ "event": "invitee.created" }';
    String webhookSignature = 't=1614722706562,v1=a42c805e1f4d14ee1801bf57a48b6d69d6503d0de3e2330bc1defc954dd53f3f';
      
    CalendlyApi.VerifyWebhookResult result = CalendlyApi.verifyWebhookSignature(webhookSignature, signingKey, webhookPayload);
      
    System.assertEquals(result.isValid, true);
  }
    
  @isTest
  static void verifyWebhookSubscriptionTimestampErrorTest() {
    String signingKey = '1234567890';
    String webhookPayload = '{ "event": "invitee.created" }';
    String webhookSignature = 't=1614722706562,v1=a42c805e1f4d14ee1801bf57a48b6d69d6503d0de3e2330bc1defc954dd53f3f';
      
    CalendlyApi.VerifyWebhookResult result = CalendlyApi.verifyWebhookSignature(webhookSignature, signingKey, webhookPayload, 3L);
      
    System.assertEquals(result.isValid, false);
    System.assertEquals(result.errorMessage, 'Invalid Signature. The signature\'s timestamp is outside of the tolerance zone.');
  }
    
  @isTest
  static void verifyWebhookSubscriptionMissingParametersErrorTest() {
    String signingKey = '1234567890';
    String webhookPayload = '{ "event": "invitee.created" }';
    String webhookSignature = ' ';
      
    CalendlyApi.VerifyWebhookResult result = CalendlyApi.verifyWebhookSignature(webhookSignature, signingKey, webhookPayload);
      
    System.assertEquals(result.isValid, false);
    System.assertEquals(result.errorMessage, 'Invalid Signature');
  }
    
  @isTest
  static void verifyWebhookSubscriptionInvalidParametersErrorTest() {
    String signingKey = '1234567890';
    String webhookPayload = '{ "event": "invitee.created" }';
    String webhookSignature = 'timestamp=1614722706562,v2=a42c805e1f4d14ee1801bf57a48b6d69d6503d0de3e2330bc1defc954dd53f3f';
      
    CalendlyApi.VerifyWebhookResult result = CalendlyApi.verifyWebhookSignature(webhookSignature, signingKey, webhookPayload);
      
    System.assertEquals(result.isValid, false);
    System.assertEquals(result.errorMessage, 'Invalid Signature');
  }
    
  @isTest
  static void verifyWebhookSubscriptionSignatureDoesNotMatchErrorTest() {
    String signingKey = '1234567890';
    String webhookPayload = '{ "event": "invitee.created" }';
    String webhookSignature = 't=1614722706562,v1=a42c805e1f4d1';
      
    CalendlyApi.VerifyWebhookResult result = CalendlyApi.verifyWebhookSignature(webhookSignature, signingKey, webhookPayload);
      
    System.assertEquals(result.isValid, false);
    System.assertEquals(result.errorMessage, 'Invalid Signature');
  }

  @isTest
  static void verifyWebhookSubscriptionSignatureIsNullErrorTest() {
    String signingKey = '1234567890';
    String webhookPayload = '{ "event": "invitee.created" }';
    String webhookSignature = null;
      
    CalendlyApi.VerifyWebhookResult result = CalendlyApi.verifyWebhookSignature(webhookSignature, signingKey, webhookPayload);
      
    System.assertEquals(result.isValid, false);
    System.assertEquals(result.errorMessage, 'Invalid Signature');
  }

  @isTest
  static void httpErrorTest() {
    Test.setMock(HttpCalloutMock.class, new CalendlyApiHttpCalloutMock()); 

    try {
      CalendlyApi.EventTypeQueryParams params = new CalendlyApi.EventTypeQueryParams();

      CalendlyApi.EventTypeCollection response = CalendlyApi.getEventTypes(params);
    } catch (CalendlyApi.CalendlyApiException e) {
      System.assertEquals(e.message, 'The supplied parameters are invalid.');
      System.assertEquals(e.title, 'Invalid Argument');
      System.assertEquals(e.details.size(), 2);
      System.assertEquals(e.details.get(0).message, 'user or organization must be filled');
      System.assertEquals(e.details.get(0).parameter, 'organization');
      System.assertEquals(e.details.get(1).message, 'user or organization must be filled');
      System.assertEquals(e.details.get(1).parameter, 'user');
    }
  }

  private static void validateDateField(DateTime field) {
    System.assertEquals(field.getTime(), 1583762417399L);
  }
}