public class GoogleCalendarEvent extends AbstractJsonObject {

	private static final Time TIME_ZERO = Time.newInstance(0, 0, 0, 0);

	public GoogleCalendarEvent() {
		this.start_xx = new EventTime();
		this.end_xx = new EventTime();
	}

	public String id { get;}
	public String status { get;}
	public String summary { get; set;}
	public String description { get; set;}
	public EventTime start_xx { get; set;}
	public EventTime end_xx { get; set;}
	public List<Attendee> attendees { get; set;}
	public Boolean sendNotifications = true;
	public String sendUpdates = 'all';
	public Datetime created { get;}
	public Datetime updated { get;}

	public void setDateAndDuration(Datetime startTime, Integer minutes) {
		this.start_xx.date_xx = null;
		this.end_xx.date_xx = null;
		this.start_xx.dateTime_xx = startTime;
		this.end_xx.dateTime_xx = startTime.addMinutes(minutes);
	}

	public Attendee addAttendee(String email) {
		Attendee a = new Attendee();
		a.email = email;
		return addAttendee(a);
	}

	public Attendee addAttendee(Attendee a) {
		if (this.attendees == null) {
			this.attendees = new List<Attendee>();
		}
		this.attendees.add(a);
		return a;
	}

	public override String toString() {
		String ret = super.toString();
		ret = ret.replaceAll('"start_xx":', '"start":');
		ret = ret.replaceAll('"end_xx":', '"end":');
		ret = ret.replaceAll('"date_xx":', '"date":');
		ret = ret.replaceAll('"dateTime_xx":', '"dateTime":');
		ret = ret.replaceAll('"private_xx":', '"private":');
		return ret;
	}

	public static String replaceProperties(String str) {
		str = str.replaceAll('"start":', '"start_xx":');
		str = str.replaceAll('"end":', '"end_xx":');
		str = str.replaceAll('"date":', '"date_xx":');
		str = str.replaceAll('"dateTime":', '"dateTime_xx":');
		str = str.replaceAll('"private":', '"private_xx":');
		return str;
	}

	public class EventTime {

		public Date date_xx { get; set;}
		public Datetime dateTime_xx { get; set;}

		public override String toString() {
			String ret = JSON.serialize(this);
			ret = ret.replaceAll('"date_xx":', '"date":');
			ret = ret.replaceAll('"dateTime_xx":', '"dateTime":');
			return ret;
		}
	}

	public class Attendee  {

		public String id { get;}
		public String email { get; set;}
		public String displayName { get; set;}
	}

}
