public class CalendlyApi {
    
  ////////////////////////////////////////
  // Error                              //
  ////////////////////////////////////////
  
  public class ErrorDetail {
    public String parameter;
    public String message;
  }
  
  public class CalendlyApiException extends Exception {
    public String title;
    public Integer statusCode;
    public String message;
    public List<CalendlyApi.ErrorDetail> details;
  }

  ////////////////////////////////////////
  // Collection Response                //
  ////////////////////////////////////////

  public class EventTypeCollection {
    public List<CalendlyApi.EventType> collection;
    public CalendlyApi.EventTypePagination pagination;
  }

  public class ScheduledEventCollection {
    public List<CalendlyApi.ScheduledEvent> collection;
    public CalendlyApi.ScheduledEventPagination pagination;
  }

  public class InviteeCollection {
    public List<CalendlyApi.Invitee> collection;
    public CalendlyApi.InviteePagination pagination;
  }

  public class OrganizationMembershipCollection {
    public List<CalendlyApi.OrganizationMembership> collection;
    public CalendlyApi.OrganizationMembershipPagination pagination;
  }

  public class OrganizationInvitationCollection {
    public List<CalendlyApi.OrganizationInvitation> collection;
    public CalendlyApi.OrganizationInvitationPagination pagination;
  }

  public class WebhookSubscriptionCollection {
    public List<CalendlyApi.WebhookSubscription> collection;
    public CalendlyApi.WebhookSubscriptionPagination pagination;
  }

  ////////////////////////////////////////
  // Resource Response                  //
  ////////////////////////////////////////

  public class UserResource {
    public CalendlyApi.User resource;
  }

  public class EventTypeResource {
    public CalendlyApi.EventType resource;
  }

  public class ScheduledEventResource {
    public CalendlyApi.ScheduledEvent resource;
  }

  public class InviteeResource {
    public CalendlyApi.Invitee resource;
  }

  public class OrganizationMembershipResource {
    public CalendlyApi.OrganizationMembership resource;
  }

  public class OrganizationInvitationResource {
    public CalendlyApi.OrganizationInvitation resource;
  }

  public class SchedulingLinkResource {
    public CalendlyApi.SchedulingLink resource;
  }

  public class WebhookSubscriptionResource {
    public CalendlyApi.WebhookSubscription resource;
  }

  ////////////////////////////////////////
  // Pagination                         //
  ////////////////////////////////////////

  public class EventTypePagination {
    public Integer count;
    public String next_page;

    public Boolean hasNextPage() {
      return this.next_page != null;
    }
      
    public CalendlyApi.EventTypeCollection nextPage() {
      if (this.next_page == null) {
        EventTypeCollection collection = new EventTypeCollection();
        collection.collection = new List<EventType>();
        collection.pagination = new EventTypePagination();

        return collection;
      }
  
      String queryString = this.next_page.substring(this.next_page.indexOf('?') + 1);
      
      Map<String, Object> objectMap = CalendlyApi.parseQueryString(queryString);
      CalendlyApi.EventTypeQueryParams params = new CalendlyApi.EventTypeQueryParams();

      Object user = objectMap.get('user');
      Object organization = objectMap.get('organization');
      Object page_token = objectMap.get('page_token');
      Object sort_params = objectMap.get('sort');
      Object count = objectMap.get('count');

      if (user != null) {
        params.user = (String) user;
      }
      if (organization != null) {
        params.organization = (String) organization;
      }
      if (page_token != null) {
        params.page_token = (String) page_token;
      }
      if (sort_params != null) {
        params.sort_params = (List<CalendlyApi.SortParam>) sort_params;
      }
      if (count != null) {
          params.count = Integer.valueOf(count);
      }
      
      return CalendlyApi.getEventTypes(params);
    }
  }

  public class ScheduledEventPagination {
    public Integer count;
    public String next_page;

    public Boolean hasNextPage() {
      return this.next_page != null;
    }
    
    public ScheduledEventCollection nextPage() {
      if (this.next_page == null) {
        CalendlyApi.ScheduledEventCollection collection = new CalendlyApi.ScheduledEventCollection();
        collection.collection = new List<CalendlyApi.ScheduledEvent>();
        collection.pagination = new CalendlyApi.ScheduledEventPagination();

        return collection;
      }
  
      String queryString = this.next_page.substring(this.next_page.indexOf('?') + 1);
      
      Map<String, Object> objectMap = CalendlyApi.parseQueryString(queryString);
      CalendlyApi.ScheduledEventQueryParams params = new CalendlyApi.ScheduledEventQueryParams();

      Object user = objectMap.get('user');
      Object organization = objectMap.get('organization');
      Object page_token = objectMap.get('page_token');
      Object sort_params = objectMap.get('sort');
      Object count = objectMap.get('count');
      Object invitee_email = objectMap.get('invitee_email');
      Object status = objectMap.get('status');
      Object min_start_time = objectMap.get('min_start_time');
      Object max_start_time = objectMap.get('max_start_time');

      if (user != null) {
        params.user = (String) user;
      }
      if (organization != null) {
        params.organization = (String) organization;
      }
      if (page_token != null) {
        params.page_token = (String) page_token;
      }
      if (sort_params != null) {
        params.sort_params = (List<CalendlyApi.SortParam>) sort_params;
      }
      if (count != null) {
        params.count = Integer.valueOf(count);
      }
      if (min_start_time != null) {
        params.min_start_time = (DateTime) System.JSON.deserialize('"' + min_start_time + '"', DateTime.class);
      }
      if (max_start_time != null) {
        params.max_start_time = (DateTime) System.JSON.deserialize('"' + max_start_time + '"', DateTime.class);
      }
      if (invitee_email != null) {
        params.invitee_email = (String) invitee_email;
      }
      if (status != null) {
        params.status = (String) status;
      }
      
      return CalendlyApi.getScheduledEvents(params);
    }
  }

  public class InviteePagination {
    public Integer count;
    public String next_page;

    public Boolean hasNextPage() {
      return this.next_page != null;
    }
    
    public CalendlyApi.InviteeCollection nextPage() {
      if (this.next_page == null) {
        CalendlyApi.InviteeCollection collection = new CalendlyApi.InviteeCollection();
        collection.collection = new List<Invitee>();
        collection.pagination = new CalendlyApi.InviteePagination();

        return collection;
      }

      String queryString = this.next_page.substring(this.next_page.indexOf('?') + 1);
      
      Map<String, Object> objectMap = CalendlyApi.parseQueryString(queryString);
      CalendlyApi.InviteeQueryParams params = new CalendlyApi.InviteeQueryParams();

      Object email = objectMap.get('email');
      Object status = objectMap.get('status');
      Object page_token = objectMap.get('page_token');
      Object sort_params = objectMap.get('sort');
      Object count = objectMap.get('count');

      if (email != null) {
        params.email = (String) email;
      }
      if (status != null) {
        params.status = (String) status;
      }
      if (page_token != null) {
        params.page_token = (String) page_token;
      }
      if (sort_params != null) {
        params.sort_params = (List<CalendlyApi.SortParam>) sort_params;
      }
      if (count != null) {
        params.count = Integer.valueOf(count);
      }

      String searchString = '/scheduled_events/';
      Integer eventUuidStart = this.next_page.indexOf(searchString) + searchString.length();
      Integer eventUuidEnd =  this.next_page.indexOf('/', eventUuidStart + 1);
      String eventUuid = this.next_page.substring(eventUuidStart, eventUuidEnd);

      return CalendlyApi.getInvitees(eventUuid, params);
    }
  }

  public class OrganizationMembershipPagination {
    public Integer count;
    public String next_page;

    public Boolean hasNextPage() {
      return this.next_page != null;
    }
    
    public CalendlyApi.OrganizationMembershipCollection nextPage() {
      if (this.next_page == null) {
        CalendlyApi.OrganizationMembershipCollection collection = new CalendlyApi.OrganizationMembershipCollection();
        collection.collection = new List<CalendlyApi.OrganizationMembership>();
        collection.pagination = new CalendlyApi.OrganizationMembershipPagination();

        return collection;
      }

      String queryString = this.next_page.substring(this.next_page.indexOf('?') + 1);
      
      Map<String, Object> objectMap = CalendlyApi.parseQueryString(queryString);
      CalendlyApi.OrganizationMembershipQueryParams params = new CalendlyApi.OrganizationMembershipQueryParams();

      Object user = objectMap.get('user');
      Object organization = objectMap.get('organization');
      Object page_token = objectMap.get('page_token');
      Object email = objectMap.get('email');
      Object count = objectMap.get('count');

      if (user != null) {
        params.user = (String) user;
      }
      if (organization != null) {
        params.organization = (String) organization;
      }
      if (page_token != null) {
        params.page_token = (String) page_token;
      }
      if (email != null) {
        params.email = (String) email;
      }
      if (count != null) {
        params.count = Integer.valueOf(count);
      }

      return CalendlyApi.getOrganizationMemberships(params);
    }
  }

  public class OrganizationInvitationPagination {
    public Integer count;
    public String next_page;

    public Boolean hasNextPage() {
      return this.next_page != null;
    }

    public CalendlyApi.OrganizationInvitationCollection nextPage() {
      if (this.next_page == null) {
        CalendlyApi.OrganizationInvitationCollection collection = new CalendlyApi.OrganizationInvitationCollection();
        collection.collection = new List<CalendlyApi.OrganizationInvitation>();
        collection.pagination = new CalendlyApi.OrganizationInvitationPagination();

        return collection;
      }

      String queryString = this.next_page.substring(this.next_page.indexOf('?') + 1);
      
      Map<String, Object> objectMap = CalendlyApi.parseQueryString(queryString);
      CalendlyApi.OrganizationInvitationQueryParams params = new CalendlyApi.OrganizationInvitationQueryParams();

      Object status = objectMap.get('status');
      Object sort_params = objectMap.get('sort');
      Object page_token = objectMap.get('page_token');
      Object email = objectMap.get('email');
      Object count = objectMap.get('count');

      if (email != null) {
        params.email = (String) email;
      }
      if (status != null) {
        params.status = (String) status;
      }
      if (page_token != null) {
        params.page_token = (String) page_token;
      }
      if (sort_params != null) {
        params.sort_params = (List<CalendlyApi.SortParam>) sort_params;
      }
      if (count != null) {
        params.count = Integer.valueOf(count);
      }

      String searchString = '/organizations/';
      Integer organizationUuidStart = this.next_page.indexOf(searchString) + searchString.length();
      Integer organizationUuidEnd =  this.next_page.indexOf('/', organizationUuidStart + 1);
      String organizationUuid = this.next_page.substring(organizationUuidStart, organizationUuidEnd);

      return CalendlyApi.getOrganizationInvitations(organizationUuid, params);
    }
  }

  public class WebhookSubscriptionPagination {
    public Integer count;
    public String next_page;

    public Boolean hasNextPage() {
      return this.next_page != null;
    }

    public CalendlyApi.WebhookSubscriptionCollection nextPage() {
      if (this.next_page == null) {
        CalendlyApi.WebhookSubscriptionCollection collection = new CalendlyApi.WebhookSubscriptionCollection();
        collection.collection = new List<CalendlyApi.WebhookSubscription>();
        collection.pagination = new CalendlyApi.WebhookSubscriptionPagination();

        return collection;
      }

      String queryString = this.next_page.substring(this.next_page.indexOf('?') + 1);
      
      Map<String, Object> objectMap = CalendlyApi.parseQueryString(queryString);
      CalendlyApi.WebhookSubscriptionQueryParams params = new CalendlyApi.WebhookSubscriptionQueryParams();

      Object organization = objectMap.get('organization');
      Object user = objectMap.get('user');
      Object sort_params = objectMap.get('sort');
      Object page_token = objectMap.get('page_token');
      Object scope = objectMap.get('scope');
      Object count = objectMap.get('count');

      if (scope != null) {
        params.scope = (String) scope;
      }
      if (organization != null) {
        params.organization = (String) organization;
      }
      if (user != null) {
        params.user = (String) user;
      }
      if (page_token != null) {
        params.page_token = (String) page_token;
      }
      if (sort_params != null) {
        params.sort_params = (List<CalendlyApi.SortParam>) sort_params;
      }
      if (count != null) {
        params.count = Integer.valueOf(count);
      }

      return CalendlyApi.getWebhookSubscriptions(params);
    }
  }

  ////////////////////////////////////////
  // Query Parameters                   //
  ////////////////////////////////////////

  public class EventTypeQueryParams {
    public String user;
    public String organization;
    public Integer count;
    public String page_token;
    public List<CalendlyApi.SortParam> sort_params;
  }

  public class ScheduledEventQueryParams {
    public String user;
    public String organization;
    public String invitee_email;
    public DateTime max_start_time;
    public DateTime min_start_time;
    public Integer count;
    public String page_token;
    public String status;
    public List<CalendlyApi.SortParam> sort_params;
  }

  public class InviteeQueryParams {
    public String email;
    public Integer count;
    public String page_token;
    public String status;
    public List<CalendlyApi.SortParam> sort_params;
  }

  public class OrganizationMembershipQueryParams {
    public String email;
    public Integer count;
    public String organization;
    public String page_token;
    public String user;
  }

  public class OrganizationInvitationQueryParams {
    public String email;
    public Integer count;
    public String page_token;
    public String status;
    public List<CalendlyApi.SortParam> sort_params;
  }

  public class WebhookSubscriptionQueryParams {
    public Integer count;
    public String page_token;
    public List<CalendlyApi.SortParam> sort_params;
    public String user;
    public String organization;
    public String scope;
  }

  ////////////////////////////////////////
  // User                               //
  ////////////////////////////////////////
  
  public class User {
    public String name;
    public String slug;
    public String email;
    public String scheduling_url;
    public String timezone;
    public String avatar_url;
    public String uri;
    public String current_organization;
    public DateTime created_at;
    public DateTime updated_at;
  }
  
  public static CalendlyApi.UserResource getCurrentUser() {
    return (CalendlyApi.UserResource) CalendlyApi.sendGetRequest('/users/me', CalendlyApi.UserResource.class);
  }
  
  public static CalendlyApi.UserResource getUser(String uuid) {
    return (CalendlyApi.UserResource) CalendlyApi.sendGetRequest('/users/' + uuid, CalendlyApi.UserResource.class);
  }
  
  ////////////////////////////////////////
  // EventType                          //
  ////////////////////////////////////////
  
  public class EventTypeProfile {
    public String type;
    public String name;
    public String owner;
  }
  
  public class EventType {
    public String uri;
    public String name;
    public Boolean active;
    public String scheduling_url;
    public Integer duration;
    public String kind;
    public String pooling_type;
    public String type;
    public String color;
    public DateTime created_at;
    public DateTime updated_at;
    public String internal_note;
    public String description_plain;
    public String description_html;
    public CalendlyApi.EventTypeProfile profile;
    public Boolean secret;

    public CalendlyApi.SchedulingLink createSchedulingLink() {
      CalendlyApi.CreateSchedulingLinkRequest req = new CalendlyApi.CreateSchedulingLinkRequest();
      req.max_event_count = 1;
      req.owner = this.uri;
      req.owner_type = 'EventType';
      
      CalendlyApi.SchedulingLinkResource res = CalendlyApi.createSchedulingLink(req);

      return res.resource;
    }
  }
  
  public static CalendlyApi.EventTypeResource getEventType(String uuid) {
    return (CalendlyApi.EventTypeResource) CalendlyApi.sendGetRequest('/event_types/' + uuid, CalendlyApi.EventTypeResource.class);
  }
  
  public static CalendlyApi.EventTypeCollection getEventTypes(CalendlyApi.EventTypeQueryParams queryParams) {
    String queryString = '?';
    
    if (queryParams.user != null) {
        queryString += 'user=' + queryParams.user + '&';
    }
    if (queryParams.organization != null) {
        queryString += 'organization=' + queryParams.organization + '&';
    }
    if (queryParams.page_token != null) {
        queryString += 'page_token=' + queryParams.page_token + '&';
    }
    if (queryParams.count != null) {
        queryString += 'count=' + queryParams.count + '&';
    }
    if (queryParams.sort_params != null) {
        String sortQueryString = queryParams.sort_params.get(0).name + ':' + queryParams.sort_params.get(0).order;
        queryString += 'sort=' + sortQueryString + '&';
    }
    
    return (CalendlyApi.EventTypeCollection) CalendlyApi.sendGetRequest('/event_types' + queryString, CalendlyApi.EventTypeCollection.class);
  }

  ////////////////////////////////////////
  // Location                           //
  ////////////////////////////////////////

  public class ConferenceLocationMetadata {
    public String id;
    public CalendlyApi.ZoomSettings settings;
    public CalendlyApi.ZoomExtraInfo extra;
    public String password;
    public Integer uniqueMeetingId;
    public String conferenceCallInfo;
    public CalendlyApi.MicrosoftTeamsAudioConferencing audioConferencing;
  }

  public class MicrosoftTeamsAudioConferencing {
    public String conferenceId;
    public String dialinUrl;
    public String tollNumber;
  }

  public class ZoomSettings {
    public List<CalendlyApi.ZoomGlobalDialInNumber> global_dial_in_numbers;
  }

  public class ZoomGlobalDialInNumber {
    public String country;
    public String type;
    public String city;
    public String country_name;
    public String dial_in_number;
  }

  public class ZoomExtraInfo {
    public String intl_numbers_url;
  }

  public class ScheduledEventLocation {
    public String type;
    public String location;
    public String join_url;
    public String status;
    public CalendlyApi.ConferenceLocationMetadata data;
  }

  ////////////////////////////////////////
  // Scheduled Event                    //
  ////////////////////////////////////////

  public class ScheduledEventProfile {
    public String type;
    public String name;
    public String owner;
  }

  public class EventMembership {
    public String user;

    public CalendlyApi.User getUser() {
      UserResource res = CalendlyApi.getUser(CalendlyApi.parseUuid(this.user));

      return res.resource;
    }
  }

  public class EventGuest {
    public String email;
    public DateTime created_at;
    public DateTime updated_at;
  }

  public class InviteesCounter {
    public Integer total;
    public Integer active;
    public Integer invitee_limit;
  }

  public class ScheduledEvent {
    public String uri;
    public String name;
    public String status;
    public Datetime start_time;
    public Datetime end_time;
    public String event_type;
    public CalendlyApi.ScheduledEventLocation location;
    public CalendlyApi.InviteesCounter invitees_counter;
    public DateTime created_at;
    public DateTime updated_at;
    public List<CalendlyApi.EventMembership> event_memberships;
    public List<CalendlyApi.EventGuest> event_guests;

    public CalendlyApi.EventType getEventType() {
      CalendlyApi.EventTypeResource res = CalendlyApi.getEventType(CalendlyApi.parseUuid(this.event_type));

      return res.resource;
    }

    public CalendlyApi.InviteeCollection getInvitees(CalendlyApi.InviteeQueryParams queryParams) {
      String eventUuid = CalendlyApi.parseUuid(this.uri);
      return CalendlyApi.getInvitees(eventUuid, queryParams);
    }
  }

  public static CalendlyApi.ScheduledEventResource getScheduledEvent(String uuid) {
    return (CalendlyApi.ScheduledEventResource) CalendlyApi.sendGetRequest('/scheduled_events/' + uuid, CalendlyApi.ScheduledEventResource.class);
  }

  public static CalendlyApi.ScheduledEventCollection getScheduledEvents(CalendlyApi.ScheduledEventQueryParams queryParams) {
    String queryString = '?';
    
    if (queryParams.user != null) {
      queryString += 'user=' + queryParams.user + '&';
    }
    if (queryParams.organization != null) {
      queryString += 'organization=' + queryParams.organization + '&';
    }
    if (queryParams.max_start_time != null) {
      String maxStartTime = queryParams.max_start_time.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
      queryString += 'max_start_time=' + maxStartTime + '&';
    }
    if (queryParams.min_start_time != null) {
      String minStartTime = queryParams.min_start_time.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
      queryString += 'min_start_time=' + minStartTime + '&';
    }
    if (queryParams.status != null) {
      queryString += 'status=' + queryParams.status + '&';
    }
    if (queryParams.invitee_email != null) {
      queryString += 'invitee_email=' + queryParams.invitee_email + '&';
    }
    if (queryParams.page_token != null) {
      queryString += 'page_token=' + queryParams.page_token + '&';
    }
    if (queryParams.count != null) {
      queryString += 'count=' + queryParams.count + '&';
    }
    if (queryParams.sort_params != null && queryParams.sort_params.size() > 0) {
      String sortQueryString = queryParams.sort_params.get(0).name + ':' + queryParams.sort_params.get(0).order;
      queryString += 'sort=' + sortQueryString + '&';
    }

    return (CalendlyApi.ScheduledEventCollection) CalendlyApi.sendGetRequest('/scheduled_events/' + queryString, CalendlyApi.ScheduledEventCollection.class);
  }

  ////////////////////////////////////////
  // Invitee                            //
  ////////////////////////////////////////

  public class InviteeQuestionsAndAnswer {
    public String question;
    public String answer;
    public Integer position;
  }

  public class InviteeTracking {
    public String utm_campaign;
    public String utm_source;
    public String utm_content;
    public String utm_medium;
    public String utm_term;
    public String salesforce_uuid;
  }

  public class InviteeCancellation {
    public String canceled_by;
    public String reason;
  }

  public class InviteePayment {
    public String external_id;
    public String provider;
    public Decimal payment_amount;
    public String payment_currency;
    public String terms;
    public Boolean successful;
  }

  public class Invitee {
    public String uri;
    public String name;
    public String email;
    public String status;
    public List<CalendlyApi.InviteeQuestionsAndAnswer> questions_and_answers;
    public String timezone;
    public String event;
    public DateTime created_at;
    public DateTime updated_at;
    public CalendlyApi.InviteeTracking tracking;
    public String text_reminder_number;
    public Boolean rescheduled;
    public String old_invitee;
    public String new_invitee;
    public String cancel_url;
    public String reschedule_url;
    public CalendlyApi.InviteeCancellation cancellation;
    public CalendlyApi.InviteePayment payment;

    public CalendlyApi.ScheduledEvent getEvent() {
      CalendlyApi.ScheduledEventResource res = CalendlyApi.getScheduledEvent(CalendlyApi.parseUuid(this.event));

      return res.resource;
    }

    public CalendlyApi.Invitee getOldInvitee() {
      if (this.old_invitee == null) {
        return null;
      }

      CalendlyApi.InviteeResource res = CalendlyApi.getInvitee(CalendlyApi.parseUuid(this.event), CalendlyApi.parseUuid(this.old_invitee));
        
      return res.resource;
    }

    public CalendlyApi.Invitee getNewInvitee() {
      if (this.new_invitee == null) {
        return null;
      }
        
      CalendlyApi.InviteeResource res = CalendlyApi.getInvitee(CalendlyApi.parseUuid(this.event), CalendlyApi.parseUuid(this.new_invitee));
        
      return res.resource;
    }
  }

  public static CalendlyApi.InviteeResource getInvitee(String eventUuid, String inviteeUuid) {
    return (CalendlyApi.InviteeResource) CalendlyApi.sendGetRequest('/scheduled_events/' + eventUuid + '/invitees/' + inviteeUuid, CalendlyApi.InviteeResource.class);
  }

  public static CalendlyApi.InviteeCollection getInvitees(String eventUuid, InviteeQueryParams queryParams) {
    String queryString = '?';
      
    if (queryParams.email != null) {
      queryString += 'email=' + queryParams.email + '&';
    }
    if (queryParams.status != null) {
      queryString += 'status=' + queryParams.status + '&';
    }
    if (queryParams.page_token != null) {
      queryString += 'page_token=' + queryParams.page_token + '&';
    }
    if (queryParams.count != null) {
      queryString += 'count=' + queryParams.count + '&';
    }
    if (queryParams.sort_params != null && queryParams.sort_params.size() > 0) {
      String sortQueryString = queryParams.sort_params.get(0).name + ':' + queryParams.sort_params.get(0).order;
      queryString += 'sort=' + sortQueryString + '&';
    }
    
    return (CalendlyApi.InviteeCollection) CalendlyApi.sendGetRequest('/scheduled_events/' + eventUuid + '/invitees' + queryString, CalendlyApi.InviteeCollection.class);
  }

  ////////////////////////////////////////
  // Scheduling Link                    //
  ////////////////////////////////////////

  public class SchedulingLink {
    public String booking_url;
    public String owner;
    public String owner_type;

    public CalendlyApi.EventType getOwner() {
      CalendlyApi.EventTypeResource res = CalendlyApi.getEventType(CalendlyApi.parseUuid(this.owner));

      return res.resource;
    }
  }

  public class CreateSchedulingLinkRequest {
    public Integer max_event_count;
    public String owner;
    public String owner_type;
  }

  public static CalendlyApi.SchedulingLinkResource createSchedulingLink(CalendlyApi.CreateSchedulingLinkRequest request) {
    String requestBody = System.JSON.serialize(request, true); 

    return (CalendlyApi.SchedulingLinkResource) CalendlyApi.sendPostRequest('/scheduling_links', requestBody, CalendlyApi.SchedulingLinkResource.class);
  }

  ////////////////////////////////////////
  // Organization Membership            //
  ////////////////////////////////////////

  public class OrganizationMembershipUser {
    public String name;
    public String slug;
    public String email;
    public String scheduling_url;
    public String timezone;
    public String avatar_url;
    public String uri;
    public DateTime created_at;
    public DateTime updated_at;
  }

  public class OrganizationMembership {
    public String uri;
    public String role;
    public CalendlyApi.OrganizationMembershipUser user;
    public String organization;
    public DateTime created_at;
    public DateTime updated_at;

    public void removeUser() {
      String uuid = CalendlyApi.parseUuid(this.uri);
      CalendlyApi.sendDeleteRequest('/organization_memberships/' + uuid, String.class);
    }
  }

  public static CalendlyApi.OrganizationMembershipResource getOrganizationMembership(String uuid) {
    return (CalendlyApi.OrganizationMembershipResource) CalendlyApi.sendGetRequest('/organization_memberships/' + uuid, CalendlyApi.OrganizationMembershipResource.class);    
  }

  public static CalendlyApi.OrganizationMembershipCollection getOrganizationMemberships(CalendlyApi.OrganizationMembershipQueryParams queryParams) {
    String queryString = '?';
    
    if (queryParams.user != null) {
      queryString += 'user=' + queryParams.user + '&';
    }
    if (queryParams.organization != null) {
      queryString += 'organization=' + queryParams.organization + '&';
    }
    if (queryParams.email != null) {
      queryString += 'email=' + queryParams.email + '&';
    }
    if (queryParams.page_token != null) {
      queryString += 'page_token=' + queryParams.page_token + '&';
    }
    if (queryParams.count != null) {
      queryString += 'count=' + queryParams.count + '&';
    }

    return (CalendlyApi.OrganizationMembershipCollection) CalendlyApi.sendGetRequest('/organization_memberships' + queryString, CalendlyApi.OrganizationMembershipCollection.class);    
  }

  ////////////////////////////////////////
  // Organization                       //
  ////////////////////////////////////////

  public class Organization {
    public String uri;

    public CalendlyApi.OrganizationInvitationResource sendOrganizationInvitation(String email) {
      String organizationUuid = CalendlyApi.parseUuid(this.uri);
      String requestBody = '{ "email": "' + email + '"' + '}';
      return (CalendlyApi.OrganizationInvitationResource) CalendlyApi.sendPostRequest('/organizations/' + organizationUuid + '/invitations', requestBody, CalendlyApi.OrganizationInvitationResource.class);
    }

    public CalendlyApi.OrganizationInvitationCollection getOrganizationInvitations(CalendlyApi.OrganizationInvitationQueryParams params) {
      String organizationUuid = CalendlyApi.parseUuid(this.uri);
      
      return CalendlyApi.getOrganizationInvitations(organizationUuid, params);
    }

    public CalendlyApi.OrganizationMembershipCollection getOrganizationMemberships(CalendlyApi.OrganizationMembershipQueryParams params) {
      params.organization = this.uri;
      
      return CalendlyApi.getOrganizationMemberships(params);
    }
  }

  public static CalendlyApi.Organization getCurrentOrganization() {
    CalendlyApi.UserResource userResource = CalendlyApi.getCurrentUser();

    CalendlyApi.Organization organization = new CalendlyApi.Organization();
    organization.uri = userResource.resource.current_organization;

    return organization;
  }

  ////////////////////////////////////////
  // Organization Invitation            //
  ////////////////////////////////////////

  public class OrganizationInvitation {
    public String uri;
    public String organization;
    public String email;
    public String status;
    public DateTime created_at;
    public DateTime updated_at;
    public DateTime last_sent_at;
    public String user;

    public CalendlyApi.User getUserWhoSentInvitation() {
      String uuid = CalendlyApi.parseUuid(this.user);

      CalendlyApi.UserResource userResource = (CalendlyApi.UserResource) CalendlyApi.sendGetRequest('/users/' + uuid, CalendlyApi.UserResource.class);

      return userResource.resource;
    }

    public void revokeInvitation() {
      String invitationUuid = CalendlyApi.parseUuid(this.uri);
      String organizationUuid = CalendlyApi.parseUuid(this.organization);

      CalendlyApi.sendDeleteRequest('/organizations/' + organizationUuid + '/invitations/' + invitationUuid, String.class);
    }
  }

  public static CalendlyApi.OrganizationInvitationCollection getOrganizationInvitations(String organizationUuid, CalendlyApi.OrganizationInvitationQueryParams queryParams) {
    String queryString = '?';
    
    if (queryParams.email != null) {
      queryString += 'email=' + queryParams.email + '&';
    }
    if (queryParams.status != null) {
      queryString += 'status=' + queryParams.status + '&';
    }
    if (queryParams.page_token != null) {
      queryString += 'page_token=' + queryParams.page_token + '&';
    }
    if (queryParams.count != null) {
      queryString += 'count=' + queryParams.count + '&';
    }
    if (queryParams.sort_params != null && queryParams.sort_params.size() > 0) {
      String sortQueryString = queryParams.sort_params.get(0).name + ':' + queryParams.sort_params.get(0).order;
      queryString += 'sort=' + sortQueryString + '&';
    }
    String url = '/organizations/' + organizationUuid + '/invitations' + queryString;

    return (CalendlyApi.OrganizationInvitationCollection) CalendlyApi.sendGetRequest(url, CalendlyApi.OrganizationInvitationCollection.class);
  }
  

  ////////////////////////////////////////
  // Webhook Subscription               //
  ////////////////////////////////////////

  public class WebhookSubscription {
    public String uri;
    public String callback_url;
    public String organization;
    public String user;
    public String creator;
    public String state;
    public String scope;
    public List<String> events;
    public DateTime retry_started_at;
    public DateTime created_at;
    public DateTime updated_at;

    public void deleteWebhookSubscription() {
      String uuid = CalendlyApi.parseUuid(this.uri);
      CalendlyApi.sendDeleteRequest('/webhook_subscriptions/' + uuid, String.class);
    }
  }

  public class CreateWebhookSubscriptionRequest {
    public String url;
    public String organization;
    public String user;
    public String scope;
    public String signing_key;
    public List<String> events;
  }

  public class WebhookPayload {
    public String event;
    public Datetime created_at;
    public CalendlyApi.Invitee payload;
  }

  public static CalendlyApi.WebhookSubscriptionResource createWebhookSubscription(CalendlyApi.CreateWebhookSubscriptionRequest request) {
    String requestBody = System.JSON.serialize(request, true); 

    return (CalendlyApi.WebhookSubscriptionResource) CalendlyApi.sendPostRequest('/webhook_subscriptions', requestBody, CalendlyApi.WebhookSubscriptionResource.class);
  }

  public static CalendlyApi.WebhookSubscriptionResource getWebhookSubscription(String uuid) {
    return (CalendlyApi.WebhookSubscriptionResource) CalendlyApi.sendGetRequest('/webhook_subscriptions/' + uuid, CalendlyApi.WebhookSubscriptionResource.class);
  }

  public static CalendlyApi.WebhookSubscriptionCollection getWebhookSubscriptions(CalendlyApi.WebhookSubscriptionQueryParams queryParams) {
    String queryString = '?';
    
    if (queryParams.organization != null) {
      queryString += 'organization=' + queryParams.organization + '&';
    }
    if (queryParams.scope != null) {
      queryString += 'scope=' + queryParams.scope + '&';
    }
    if (queryParams.user != null) {
      queryString += 'user=' + queryParams.user + '&';
    }
    if (queryParams.page_token != null) {
      queryString += 'page_token=' + queryParams.page_token + '&';
    }
    if (queryParams.count != null) {
      queryString += 'count=' + queryParams.count + '&';
    }
    if (queryParams.sort_params != null && queryParams.sort_params.size() > 0) {
      String sortQueryString = queryParams.sort_params.get(0).name + ':' + queryParams.sort_params.get(0).order;
      queryString += 'sort=' + sortQueryString + '&';
    }
    String url = '/webhook_subscriptions' + queryString;

    return (CalendlyApi.WebhookSubscriptionCollection) CalendlyApi.sendGetRequest(url, CalendlyApi.WebhookSubscriptionCollection.class);
  }
  
  public class VerifyWebhookResult {
    public Boolean isValid;
    public String errorMessage;
  }

  public static CalendlyApi.VerifyWebhookResult verifyWebhookSignature(String signature, String webhookSigningKey, String webhookPayload) {
    return CalendlyApi.verifyWebhookSignature(signature, webhookSigningKey, webhookPayload, null);
  }

  public static CalendlyApi.VerifyWebhookResult verifyWebhookSignature(String signature, String webhookSigningKey, String webhookPayload, Long tolerance) {
    CalendlyApi.VerifyWebhookResult result = new CalendlyApi.VerifyWebhookResult();
    result.isValid = false;
    
    if (signature == null) {
      result.errorMessage = 'Invalid Signature';
      return result;
    }

    Long fiveMinutes = 300000L;
    if (tolerance == null) {
      tolerance = fiveMinutes;
    }
    
    Map<String, String> params = CalendlyApi.parseWebhookSignature(signature);
    Boolean hasValidParams = (params.get('t') != null) && (params.get('v1') != null);

    if (!hasValidParams) {
      result.errorMessage = 'Invalid Signature';
      return result;
    }

    String payload = params.get('t') + '.' + webhookPayload;
    Long webhookTimestamp = Long.valueOf(params.get('t'));
    Blob hmac = Crypto.generateMac('HmacSHA256', Blob.valueOf(payload), Blob.valueOf(webhookSigningKey));
    String expectedSignature = EncodingUtil.convertToHex(hmac);
    Long currentTime = Datetime.now().getTime();
    
    if (Test.isRunningTest()) {
      if (tolerance != fiveMinutes) {
        currentTime = 1614722706762L;
      } else {
        currentTime = 1614722706562L;
      }
    }

    if (expectedSignature != params.get('v1')) {
      result.errorMessage = 'Invalid Signature';
    } else if (webhookTimestamp < (currentTime - tolerance)) {
      result.errorMessage = 'Invalid Signature. The signature\'s timestamp is outside of the tolerance zone.';  
    } else {
      result.isValid = true;
    }

    return result;
  }
  
  ////////////////////////////////////////
  // Sort                               //
  ////////////////////////////////////////

  public class SortParam {
    public String name;
    public String order;
  }
  
  ////////////////////////////////////////
  // Private Methods                    //
  ////////////////////////////////////////
  
  private static Map<String, Object> parseQueryString(String qs) {
    Map<String, Object> objectMap = new Map<String, Object>();
    for (String keyValue : qs.split('&')) {
        String[] keyValueArray = keyValue.split('=');
        String key = keyValueArray[0];
        String value = keyValueArray[1];
        
        if (key == 'sort') {
            String[] sortKeyValue = value.split(':');
            
            CalendlyApi.SortParam sortParam = new CalendlyApi.SortParam();
            sortParam.name = sortKeyValue[0];
            sortParam.order = sortKeyValue[1];
            List<CalendlyApi.SortParam> sortParams = new List<CalendlyApi.SortParam>();
            sortParams.add(sortParam);
            
            objectMap.put(key, sortParams);
        } else {
            objectMap.put(key, value);
        }
    }
              
    return objectMap;
  }

  private static String parseUuid(String path) {
    return path.substring(path.lastIndexOf('/') + 1);
  }
  
  private static Object sendGetRequest(String path, System.Type apexType) {
    HttpRequest req = new HttpRequest();
    
    req.setEndpoint('callout:calendly_api' + path);            
    req.setMethod('GET');
    
    return CalendlyApi.sendRequest(req, apexType);
  }

  private static Object sendDeleteRequest(String path, System.Type apexType) {
    HttpRequest req = new HttpRequest();
    
    req.setEndpoint('callout:calendly_api' + path);            
    req.setMethod('DELETE');
    
    return CalendlyApi.sendRequest(req, apexType);
  }

  private static Object sendPostRequest(String path, String body, System.Type apexType) {
    HttpRequest req = new HttpRequest();
    
    req.setEndpoint('callout:calendly_api' + path);            
    req.setMethod('POST');
    req.setBody(body);
   
    return CalendlyApi.sendRequest(req, apexType);
  }

  private static Object parseJSONScheduledEventCollectionWithApexReservedKeywords(String responseBody) {
    JSONParser parser = System.JSON.createParser(responseBody);

    Map<String, Object> m = (Map<String, Object>) System.JSON.deserializeUntyped(responseBody);
    List<Object> collection = (List<Object>) m.get('collection');
    Map<String, Integer> inviteeLimitMap = new Map<String, Integer>();

    for (Object record : collection) {
      Map<String, Object> recordMap = (Map<String, Object>) record;
      Map<String, Object> inviteeCounter = (Map<String, Object>) recordMap.get('invitees_counter');
      inviteeLimitMap.put((String) recordMap.get('uri'), (Integer) inviteeCounter.get('limit'));
    }

    CalendlyApi.ScheduledEventCollection eventCollection = (CalendlyApi.ScheduledEventCollection) parser.readValueAs(CalendlyApi.ScheduledEventCollection.class);

    for (CalendlyApi.ScheduledEvent event : eventCollection.collection) {
      event.invitees_counter.invitee_limit = inviteeLimitMap.get(event.uri);
    }

    return eventCollection;
  }

  private static Object parseJSONScheduledEventResourceWithApexReservedKeywords(String responseBody) {
    JSONParser parser = System.JSON.createParser(responseBody);

    Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
    Map<String, Object> record = (Map<String, Object>) m.get('resource');
    Map<String, Object> inviteeCounter = (Map<String, Object>) record.get('invitees_counter');
    
    CalendlyApi.ScheduledEventResource eventResource = (CalendlyApi.ScheduledEventResource) parser.readValueAs(CalendlyApi.ScheduledEventResource.class);
    eventResource.resource.invitees_counter.invitee_limit = (Integer) inviteeCounter.get('limit');

    return eventResource;
  }

  private static Object parseJSONInviteeCollectionWithApexReservedKeywords(String responseBody) {
    JSONParser parser = System.JSON.createParser(responseBody);

    Map<String, Object> m = (Map<String, Object>) System.JSON.deserializeUntyped(responseBody);
    List<Object> collection = (List<Object>) m.get('collection');
    Map<String, Object> inviteePaymentAmountMap = new Map<String, Decimal>();
    Map<String, Object> inviteePaymentCurrencyMap = new Map<String, String>();

    for (Object record : collection) {
      Map<String, Object> recordMap = (Map<String, Object>) record;
      Map<String, Object> inviteePayment = (Map<String, Object>) recordMap.get('payment');

      if (inviteePayment == null) {
        continue;
      }

      inviteePaymentAmountMap.put((String) recordMap.get('uri'), inviteePayment.get('amount'));
      inviteePaymentCurrencyMap.put((String) recordMap.get('uri'), inviteePayment.get('currency'));
    }

    CalendlyApi.InviteeCollection inviteeCollection = (CalendlyApi.InviteeCollection) parser.readValueAs(CalendlyApi.InviteeCollection.class);

    for (CalendlyApi.Invitee invitee : inviteeCollection.collection) {
      if (invitee.payment != null) {
        invitee.payment.payment_amount = (Decimal) inviteePaymentAmountMap.get(invitee.uri);
        invitee.payment.payment_currency = (String) inviteePaymentCurrencyMap.get(invitee.uri);
      }
    }

    return inviteeCollection;
  }

  private static Object parseJSONInviteeResourceWithApexReservedKeywords(String responseBody) {
    JSONParser parser = System.JSON.createParser(responseBody);

    Map<String, Object> m = (Map<String, Object>) System.JSON.deserializeUntyped(responseBody);
    Map<String, Object> record = (Map<String, Object>) m.get('resource');
    Map<String, Object> inviteePaymentMap = (Map<String, Object>) record.get('payment');
    CalendlyApi.InviteeResource inviteeResource = (CalendlyApi.InviteeResource) parser.readValueAs(CalendlyApi.InviteeResource.class);

    if (inviteePaymentMap == null) {
      return inviteeResource;
    }

    inviteeResource.resource.payment.payment_amount = (Decimal) inviteePaymentMap.get('amount');
    inviteeResource.resource.payment.payment_currency = (String) inviteePaymentMap.get('currency');

    return inviteeResource;
  }
  
  private static Map<String, String> parseWebhookSignature(String signature) {
    List<String> params = signature.split(',');
    Map<String, String> result = new Map<String, String>();
      
    if (params.size() < 2) {
        return result;
    }
      
    String t = params.get(0);
    String v1 = params.get(1);
      
    Integer timestampStartIndex = t.indexOf('t=');
    Integer versionStartIndex = v1.indexOf('v1=');
      
    if (timestampStartIndex == -1 || versionStartIndex == -1) {
      return result;
    }

    t = t.substring(timestampStartIndex + 't='.length());
    v1 = v1.substring(versionStartIndex + 'v1='.length());
    
    result.put('t', t);
    result.put('v1', v1);

    return result;
  }

  private static Object sendRequest(HttpRequest req, System.Type apexType) {
    Http http = new Http();
    req.setHeader('Authorization', 'Bearer {!$Credential.Password}');
    req.setHeader('Content-Type', 'application/json');
    
    HttpResponse res = http.send(req);
    Integer statusCode = res.getStatusCode();
    String responseBody = res.getBody();
    JSONParser parser = System.JSON.createParser(responseBody);
    
    if (statusCode >= 400) {
      CalendlyApi.CalendlyApiException error = (CalendlyApi.CalendlyApiException) parser.readValueAs(CalendlyApi.CalendlyApiException.class);
      error.statusCode = statusCode;
      
      throw error;
    }

    String name = apexType.getName();

    if (name == 'CalendlyApi.ScheduledEventCollection') {
      return parseJSONScheduledEventCollectionWithApexReservedKeywords(responseBody);
    } else if (name == 'CalendlyApi.ScheduledEventResource') {
      return parseJSONScheduledEventResourceWithApexReservedKeywords(responseBody);
    } else if (name == 'CalendlyApi.InviteeCollection') {
      return parseJSONInviteeCollectionWithApexReservedKeywords(responseBody);
    } else if (name == 'CalendlyApi.InviteeResource') {
      return parseJSONInviteeResourceWithApexReservedKeywords(responseBody);
    }

    if (responseBody == '') {
      return responseBody;
    }

    return parser.readValueAs(apexType);
  }
}