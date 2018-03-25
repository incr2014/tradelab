#ifndef SCHEDULER_MQH
#define SCHEDULER_MQH

#define MIN_DATE D'1970.01.01 00:00:00'

enum day_of_week_t {
	day_of_week_t_sunday = 0,
	day_of_week_t_monday = 1,
	day_of_week_t_tuesday = 2,
	day_of_week_t_wednesday = 3,
	day_of_week_t_thursday = 4,
	day_of_week_t_friday = 5,
	day_of_week_t_saturday = 6
};

//TODO: почему-то нельзя сделать внутри класса ... блядский mql
bool scheduler_is_trade_enabled;
day_of_week_t scheduler_trade_start_day;
int scheduler_start_hour;
int scheduler_start_minutes;
int scheduler_start_total_minutes;
day_of_week_t scheduler_trade_end_day;
int scheduler_end_hour;
int scheduler_end_minutes;
int scheduler_end_total_minutes;

bool scheduler_new_position_pause_enabled;
datetime scheduler_new_position_pause_start[];
datetime scheduler_new_position_pause_end[];

bool scheduler_is_trade_pause_enabled;
datetime scheduler_start_pause[];
datetime scheduler_end_pause[];

bool scheduler_is_intraday_enabled;
int scheduler_start_intraday_hour[];
int scheduler_start_intraday_minutes[];
int scheduler_start_intraday_total_minutes[];
int scheduler_end_intraday_hour[];
int scheduler_end_intraday_minutes[];
int scheduler_end_intraday_total_minutes[];

bool scheduler_is_intraday_stop_trade_enabled;
int scheduler_start_intraday_stop_trade_hour[];
int scheduler_start_intraday_stop_trade_minutes[];
int scheduler_start_intraday_stop_trade_total_minutes[];
int scheduler_end_intraday_stop_trade_hour[];
int scheduler_end_intraday_stop_trade_minutes[];
int scheduler_end_intraday_stop_trade_total_minutes[];

bool scheduler_close_all_orders_enabled;
int scheduler_close_all_orders_hour;
int scheduler_close_all_orders_minute;
int scheduler_close_all_orders_total_minute;
int scheduler_close_all_orders_total_minute_with_wait;

class scheduler_close_all_orders_locker {
public:
	layer_order_setting *settings;
	bool lock;
};

list<scheduler_close_all_orders_locker *> *scheduler_close_all_orders_lockers;
class scheduler {
private:
	static int get_current_total_minutes() {
		TOOL_CACHED_TICK ( int,
						   _current_total_minutes,
						   _current_total_minutes = 60 * kernel_time::get_hour ( layer::time_current() ) + kernel_time::get_minute ( layer::time_current() ) );
	}

public:
	static void set_trade ( day_of_week_t start_day,
							int start_hour,
							int start_minute,
							day_of_week_t end_day,
							int end_hour,
							int end_minute ) {
		scheduler_trade_start_day = start_day;
		scheduler_start_hour = start_hour;
		scheduler_start_minutes = start_minute;
		scheduler_start_total_minutes = ( 60 * start_hour ) + start_minute;

		scheduler_trade_end_day = end_day;
		scheduler_end_hour = end_hour;
		scheduler_end_minutes = end_minute;
		scheduler_end_total_minutes = ( 60 * end_hour ) + end_minute;

		scheduler_is_trade_enabled = true;
	}

	static void reset_trade () {
		scheduler_is_trade_enabled = false;
	}


#define declare_new_position_pause( number ) \
	datetime start##number, datetime end##number
#define declare_set_new_position_pause( number ) \
	scheduler_new_position_pause_start[number] = start##number; \
	scheduler_new_position_pause_end[number] = end##number;

	static void set_new_position_pause ( declare_new_position_pause ( 0 ),
										 declare_new_position_pause ( 1 ),
										 declare_new_position_pause ( 2 ),
										 declare_new_position_pause ( 3 ),
										 declare_new_position_pause ( 4 ),
										 declare_new_position_pause ( 5 ),
										 declare_new_position_pause ( 6 ),
										 declare_new_position_pause ( 7 ),
										 declare_new_position_pause ( 8 ),
										 declare_new_position_pause ( 9 ) ) {
		ArrayResize ( scheduler_new_position_pause_start, 10 );
		ArrayInitialize ( scheduler_new_position_pause_start, MIN_DATE );
		ArrayResize ( scheduler_new_position_pause_end, 10 );
		ArrayInitialize ( scheduler_new_position_pause_end, MIN_DATE );

		declare_set_new_position_pause ( 0 );
		declare_set_new_position_pause ( 1 );
		declare_set_new_position_pause ( 2 );
		declare_set_new_position_pause ( 3 );
		declare_set_new_position_pause ( 4 );
		declare_set_new_position_pause ( 5 );
		declare_set_new_position_pause ( 6 );
		declare_set_new_position_pause ( 7 );
		declare_set_new_position_pause ( 8 );
		declare_set_new_position_pause ( 9 );

		scheduler_new_position_pause_enabled = true;
	}

	static void reset_new_position_pause () {
		scheduler_new_position_pause_enabled = false;
	}

#define declare_intraday_range( number ) \
	int start_hour_##number, \
	int start_minute_##number, \
	int end_hour_##number, \
	int end_minute_##number
#define set_intraday_range( number ) \
	scheduler_start_intraday_hour[number] = start_hour_##number; \
	scheduler_start_intraday_minutes[number] = start_minute_##number; \
	scheduler_start_intraday_total_minutes[number] = ( 60 * start_hour_##number ) + start_minute_##number; \
	scheduler_end_intraday_hour[number] = end_hour_##number; \
	scheduler_end_intraday_minutes[number] = end_minute_##number; \
	scheduler_end_intraday_total_minutes[number] = ( 60 * end_hour_##number ) + end_minute_##number;

	static void set_intraday ( declare_intraday_range ( 0 ),
							   declare_intraday_range ( 1 ),
							   declare_intraday_range ( 2 ),
							   declare_intraday_range ( 3 ),
							   declare_intraday_range ( 4 ),
							   declare_intraday_range ( 5 ),
							   declare_intraday_range ( 6 ),
							   declare_intraday_range ( 7 ),
							   declare_intraday_range ( 8 ),
							   declare_intraday_range ( 9 ) ) {
		ArrayResize ( scheduler_start_intraday_hour, 10 );
		ArrayInitialize ( scheduler_start_intraday_hour, 0 );
		ArrayResize ( scheduler_start_intraday_minutes, 10 );
		ArrayInitialize ( scheduler_start_intraday_minutes, 0 );
		ArrayResize ( scheduler_start_intraday_total_minutes, 10 );
		ArrayInitialize ( scheduler_start_intraday_total_minutes, 0 );

		ArrayResize ( scheduler_end_intraday_hour, 10 );
		ArrayInitialize ( scheduler_end_intraday_hour, 0 );
		ArrayResize ( scheduler_end_intraday_minutes, 10 );
		ArrayInitialize ( scheduler_end_intraday_minutes, 0 );
		ArrayResize ( scheduler_end_intraday_total_minutes, 10 );
		ArrayInitialize ( scheduler_end_intraday_total_minutes, 0 );

		set_intraday_range ( 0 );
		set_intraday_range ( 1 );
		set_intraday_range ( 2 );
		set_intraday_range ( 3 );
		set_intraday_range ( 4 );
		set_intraday_range ( 5 );
		set_intraday_range ( 6 );
		set_intraday_range ( 7 );
		set_intraday_range ( 8 );
		set_intraday_range ( 9 );

		scheduler_is_intraday_enabled = true;
	}

	static void reset_intraday_stop_trade() {
		scheduler_is_intraday_stop_trade_enabled = false;
	}

#define declare_trade_pause( number ) \
	datetime start##number, datetime end##number
#define set_pause( number ) \
	scheduler_start_pause[number] = start##number; \
	scheduler_end_pause[number] = end##number;

	static void set_trade_pause ( declare_trade_pause ( 0 ),
								  declare_trade_pause ( 1 ),
								  declare_trade_pause ( 2 ),
								  declare_trade_pause ( 3 ),
								  declare_trade_pause ( 4 ),
								  declare_trade_pause ( 5 ),
								  declare_trade_pause ( 6 ),
								  declare_trade_pause ( 7 ),
								  declare_trade_pause ( 8 ),
								  declare_trade_pause ( 9 ) ) {
		ArrayResize ( scheduler_start_pause, 10 );
		ArrayInitialize ( scheduler_start_pause, MIN_DATE );
		ArrayResize ( scheduler_end_pause, 10 );
		ArrayInitialize ( scheduler_end_pause, MIN_DATE );

		set_pause ( 0 );
		set_pause ( 1 );
		set_pause ( 2 );
		set_pause ( 3 );
		set_pause ( 4 );
		set_pause ( 5 );
		set_pause ( 6 );
		set_pause ( 7 );
		set_pause ( 8 );
		set_pause ( 9 );

		scheduler_is_trade_pause_enabled = true;
	}

	static void reset_trade_pause () {
		scheduler_is_trade_pause_enabled = false;
	}

#define declare_intraday_stop_trade_range( number ) \
	int start_hour_##number, \
	int start_minute_##number, \
	int end_hour_##number, \
	int end_minute_##number
#define set_intraday_stop_trade_range( number ) \
	scheduler_start_intraday_stop_trade_hour[number] = start_hour_##number; \
	scheduler_start_intraday_stop_trade_minutes[number] = start_minute_##number; \
	scheduler_start_intraday_stop_trade_total_minutes[number] = ( 60 * start_hour_##number ) + start_minute_##number; \
	scheduler_end_intraday_stop_trade_hour[number] = end_hour_##number; \
	scheduler_end_intraday_stop_trade_minutes[number] = end_minute_##number; \
	scheduler_end_intraday_stop_trade_total_minutes[number] = ( 60 * end_hour_##number ) + end_minute_##number;

	static void set_intraday_stop_trade ( declare_intraday_stop_trade_range ( 0 ),
										  declare_intraday_stop_trade_range ( 1 ),
										  declare_intraday_stop_trade_range ( 2 ),
										  declare_intraday_stop_trade_range ( 3 ),
										  declare_intraday_stop_trade_range ( 4 ),
										  declare_intraday_stop_trade_range ( 5 ),
										  declare_intraday_stop_trade_range ( 6 ),
										  declare_intraday_stop_trade_range ( 7 ),
										  declare_intraday_stop_trade_range ( 8 ),
										  declare_intraday_stop_trade_range ( 9 ) ) {
		ArrayResize ( scheduler_start_intraday_stop_trade_hour, 10 );
		ArrayInitialize ( scheduler_start_intraday_stop_trade_hour, 0 );
		ArrayResize ( scheduler_start_intraday_stop_trade_minutes, 10 );
		ArrayInitialize ( scheduler_start_intraday_stop_trade_minutes, 0 );
		ArrayResize ( scheduler_start_intraday_stop_trade_total_minutes, 10 );
		ArrayInitialize ( scheduler_start_intraday_stop_trade_total_minutes, 0 );

		ArrayResize ( scheduler_end_intraday_stop_trade_hour, 10 );
		ArrayInitialize ( scheduler_end_intraday_stop_trade_hour, 0 );
		ArrayResize ( scheduler_end_intraday_stop_trade_minutes, 10 );
		ArrayInitialize ( scheduler_end_intraday_stop_trade_minutes, 0 );
		ArrayResize ( scheduler_end_intraday_stop_trade_total_minutes, 10 );
		ArrayInitialize ( scheduler_end_intraday_stop_trade_total_minutes, 0 );

		set_intraday_stop_trade_range ( 0 );
		set_intraday_stop_trade_range ( 1 );
		set_intraday_stop_trade_range ( 2 );
		set_intraday_stop_trade_range ( 3 );
		set_intraday_stop_trade_range ( 4 );
		set_intraday_stop_trade_range ( 5 );
		set_intraday_stop_trade_range ( 6 );
		set_intraday_stop_trade_range ( 7 );
		set_intraday_stop_trade_range ( 8 );
		set_intraday_stop_trade_range ( 9 );

		scheduler_is_intraday_stop_trade_enabled = true;
	}

	static void reset_intraday () {
		scheduler_is_intraday_enabled = false;
	}

	static void set_close_all_orders ( int hour,
									   int minute ) {
		scheduler_close_all_orders_hour = hour;
		scheduler_close_all_orders_minute = minute;
		scheduler_close_all_orders_total_minute = ( 60 * hour ) + minute;
		scheduler_close_all_orders_total_minute_with_wait = scheduler_close_all_orders_total_minute + 3;

		scheduler_close_all_orders_enabled = true;

		scheduler_close_all_orders_lockers = new list<scheduler_close_all_orders_locker *>();
		gc::push ( gc_dispose_type_on_end_deinit, scheduler_close_all_orders_lockers );
	}

	static void reset_close_all_orders() {
		scheduler_close_all_orders_enabled = false;
	}

	static bool is_trade_time() {
		return pre_check_trade_pause();
	}

	static bool is_trade_time_for_first_order() {
		return pre_check_new_position_pause()
			   && pre_check_trade_on_week()
			   && pre_check_intraday();
	}

	static bool is_stop_trade_time() {
		return pre_check_intraday_stop_trade();
	}

	static bool is_close_all_orders ( layer_order_setting *settings_ptr ) {
		return pre_check_close_all_orders ( settings_ptr );
	}

private:
	static bool pre_check_trade_on_week() {
		if ( check_trade_on_week() ) {
			return true;
		}

		log_info ( StringFormat ( SRC_SCHEDULER_IS_NOT_TRADE_TIME_ON_WEEK,
								  get_day_of_week_str ( scheduler_trade_start_day ),
								  scheduler_start_hour,
								  scheduler_start_minutes,
								  get_day_of_week_str ( scheduler_trade_end_day ),
								  scheduler_end_hour,
								  scheduler_end_minutes ) );
		return false;
	}

	static bool check_trade_on_week() {
		if ( !scheduler_is_trade_enabled ) {
			return true;
		}

		int day = kernel_time::get_day_of_week();

		if ( scheduler_trade_start_day > day
				|| scheduler_trade_end_day < day ) {
			return false;
		}

		int total_minutes = get_current_total_minutes();

		if ( ( scheduler_trade_start_day == day && scheduler_start_total_minutes >= total_minutes )
				|| ( scheduler_trade_end_day == day && scheduler_end_total_minutes < total_minutes ) ) {
			return false;
		}

		return true;
	}

	static bool pre_check_new_position_pause() {
		int new_position_pause_index = get_new_position_pause_index();

		if ( new_position_pause_index == -1 ) {
			return true;
		}

		string from_time = TimeToString ( scheduler_new_position_pause_start[new_position_pause_index], TIME_DATE | TIME_MINUTES );
		string to_time = TimeToString ( scheduler_new_position_pause_end[new_position_pause_index], TIME_DATE | TIME_MINUTES );
		log_info ( StringFormat ( SRC_SCHEDULER_NEW_POSITION_PAUSE,
								  from_time,
								  to_time ) );
		return false;
	}

	static int get_new_position_pause_index() {
		if ( !scheduler_new_position_pause_enabled ) {
			return -1;
		}

		datetime current_time = layer::time_current();
		int size = ArraySize ( scheduler_new_position_pause_start );

		for ( int i = 0; i < size; i++ ) {
			if ( scheduler_new_position_pause_start[i] != MIN_DATE
					&& scheduler_new_position_pause_end[i] != MIN_DATE
					&& current_time >= scheduler_new_position_pause_start[i]
					&& current_time < scheduler_new_position_pause_end[i] ) {
				return i;
			}
		}

		return -1;
	}

	static bool pre_check_trade_pause() {
		int trade_pause_index = get_trade_pause_index();

		if ( trade_pause_index == -1 ) {
			return true;
		}

		string from_time = TimeToString ( scheduler_start_pause[trade_pause_index], TIME_DATE | TIME_MINUTES );
		string to_time = TimeToString ( scheduler_end_pause[trade_pause_index], TIME_DATE | TIME_MINUTES );
		log_info ( StringFormat ( SRC_SCHEDULER_IS_TRADE_PAUSE,
								  from_time,
								  to_time ) );
		return false;
	}

	static int get_trade_pause_index() {
		if ( !scheduler_is_trade_pause_enabled ) {
			return -1;
		}

		datetime current_time = layer::time_current();
		int size = ArraySize ( scheduler_start_pause );

		for ( int i = 0; i < size; i++ ) {
			if ( scheduler_start_pause[i] != MIN_DATE
					&& scheduler_end_pause[i] != MIN_DATE
					&& current_time >= scheduler_start_pause[i]
					&& current_time < scheduler_end_pause[i] ) {
				return i;
			}
		}

		return -1;
	}

	static bool pre_check_intraday() {
		if ( check_intraday() ) {
			return true;
		}

		int near_intraday_index = get_near_intraday_index();
		log_info ( StringFormat ( SRC_SCHEDULER_IS_NOR_INTRADAY,
								  scheduler_start_intraday_hour[near_intraday_index],
								  scheduler_start_intraday_minutes[near_intraday_index],
								  scheduler_end_intraday_hour[near_intraday_index],
								  scheduler_end_intraday_minutes[near_intraday_index] ) );
		return false;
	}

	static bool check_intraday() {
		if ( !scheduler_is_intraday_enabled ) {
			return true;
		}

		int total_minutes = get_current_total_minutes();
		bool is_all_same = true;

		int size = ArraySize ( scheduler_start_intraday_total_minutes );

		for ( int i = 0; i < size; i++ ) {
			if ( scheduler_start_intraday_total_minutes[i] == scheduler_end_intraday_total_minutes[i] ) {
				continue;
			}

			is_all_same = false;

			if ( check_total_minutes_range ( scheduler_start_intraday_total_minutes[i],
											 total_minutes,
											 scheduler_end_intraday_total_minutes[i] ) ) {
				return true;
			}
		}

		return is_all_same;
	}

	static int get_near_intraday_index() {
		int result = -1;
		int distance = 1440;
		int total_minutes = get_current_total_minutes();

		// Ищем ближайшее время внутри дня текущего дня
		int size = ArraySize ( scheduler_start_intraday_total_minutes );

		for ( int i = 0; i < size; i++ ) {
			if ( scheduler_start_intraday_total_minutes[i] == scheduler_end_intraday_total_minutes[i] ) {
				continue;
			}

			int tmp_distance = scheduler_start_intraday_total_minutes[i] - total_minutes;

			if ( tmp_distance < 0
					|| tmp_distance < distance ) {
				continue;
			}

			distance = tmp_distance;
			result = i;
		}

		if ( result != -1 ) {
			return result;
		}

		// Ищем ближайшее время внутри дня следующего дня
		for ( int i = 0; i < size; i++ ) {
			if ( scheduler_start_intraday_total_minutes[i] == scheduler_end_intraday_total_minutes[i] ) {
				continue;
			}

			if ( distance > scheduler_start_intraday_total_minutes[i] ) {
				distance = scheduler_start_intraday_total_minutes[i];
				result = i;
			}
		}

		return result;
	}

	static bool pre_check_intraday_stop_trade() {
		if ( !check_intraday_stop_trade() ) {
			return false;
		}

		int near_intraday_index = get_near_intraday_stop_trade_index();
		log_info ( StringFormat ( SRC_SCHEDULER_IS_NOR_INTRADAY_STOP_TRADE,
								  scheduler_start_intraday_stop_trade_hour[near_intraday_index],
								  scheduler_start_intraday_stop_trade_minutes[near_intraday_index],
								  scheduler_end_intraday_stop_trade_hour[near_intraday_index],
								  scheduler_end_intraday_stop_trade_minutes[near_intraday_index] ) );
		return true;
	}

	static bool check_intraday_stop_trade() {
		if ( !scheduler_is_intraday_stop_trade_enabled ) {
			return false;
		}

		int total_minutes = get_current_total_minutes();
		int size = ArraySize ( scheduler_start_intraday_stop_trade_total_minutes );

		for ( int i = 0; i < size; i++ ) {
			if ( scheduler_start_intraday_stop_trade_total_minutes[i] != scheduler_end_intraday_stop_trade_total_minutes[i]
					&& check_total_minutes_range ( scheduler_start_intraday_stop_trade_total_minutes[i],
												   total_minutes,
												   scheduler_end_intraday_stop_trade_total_minutes[i] ) ) {
				return true;
			}
		}

		return false;
	}

	static int get_near_intraday_stop_trade_index() {
		int result = -1;
		int distance = 1440;
		int total_minutes = get_current_total_minutes();

		// Ищем ближайшее время внутри дня текущего дня
		int size = ArraySize ( scheduler_start_intraday_stop_trade_total_minutes );

		for ( int i = 0; i < size; i++ ) {
			if ( scheduler_start_intraday_stop_trade_total_minutes[i] == scheduler_end_intraday_stop_trade_total_minutes[i] ) {
				continue;
			}

			int tmp_distance = scheduler_start_intraday_stop_trade_total_minutes[i] - total_minutes;

			if ( tmp_distance < 0
					|| tmp_distance < distance ) {
				continue;
			}

			distance = tmp_distance;
			result = i;
		}

		if ( result != -1 ) {
			return result;
		}

		// Ищем ближайшее время внутри дня следующего дня
		for ( int i = 0; i < size; i++ ) {
			if ( scheduler_start_intraday_stop_trade_total_minutes[i] == scheduler_end_intraday_stop_trade_total_minutes[i] ) {
				continue;
			}

			if ( distance > scheduler_start_intraday_stop_trade_total_minutes[i] ) {
				distance = scheduler_start_intraday_stop_trade_total_minutes[i];
				result = i;
			}
		}

		return result;
	}

	static bool pre_check_close_all_orders ( layer_order_setting *settings_ptr ) {
		if ( !check_close_all_orders ( settings_ptr ) ) {
			return false;
		}

		log_info_k ( StringFormat ( SRC_SCHEDULER_CLOSE_ALLORDERS_EVERYDAY,
									scheduler_close_all_orders_hour,
									scheduler_close_all_orders_minute ) );
		return true;
	}

	static bool check_close_all_orders ( layer_order_setting *settings_ptr ) {
		if ( !scheduler_close_all_orders_enabled ) {
			return false;
		}

		LIST_FIRST_OR_DEFAULT ( scheduler_close_all_orders_lockers, locker, scheduler_close_all_orders_locker *, item, item.settings == settings_ptr );
		ACTION_ON_NONVALUE_OR_DEFAULT ( locker, {
			locker = new scheduler_close_all_orders_locker();
			locker.settings = settings_ptr;
			locker.lock = false;
			scheduler_close_all_orders_lockers.add ( locker );
		} );

		bool result = check_total_minutes_range ( scheduler_close_all_orders_total_minute,
					  get_current_total_minutes(),
					  scheduler_close_all_orders_total_minute_with_wait );

		if ( !result ) {
			locker.lock = false;
			return false;
		}

		if ( locker.lock ) {
			return false;
		}

		locker.lock = true;
		return true;
	}

	static bool check_total_minutes_range ( int start_range, int value, int end_range ) {
		return start_range <= value && value < end_range;
	}

	static string get_day_of_week_str ( int day_of_week ) {
		switch ( day_of_week ) {
			case 0:
				return SRC_SCHEDULER_SUNDAY;

			case 1:
				return SRC_SCHEDULER_MONDAY;

			case 2:
				return SRC_SCHEDULER_TUESDAY;

			case 3:
				return SRC_SCHEDULER_WEDNESDAY;

			case 4:
				return SRC_SCHEDULER_THURSDAY;

			case 5:
				return SRC_SCHEDULER_FRIDAY;

			case 6:
				return SRC_SCHEDULER_SATURDAY;

			default:
				return "";
		}
	}
};

#endif