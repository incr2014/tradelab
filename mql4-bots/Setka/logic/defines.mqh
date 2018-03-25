#ifndef DEFINES_MQH
#define DEFINES_MQH

#define VER "1.43"
#define BUILD "1065"

#include "setting.mqh"
#include "scheduler.mqh"

#property strict
#property version VER

#ifdef NODE
#define INPUT
#define SINPUT
input int Iterator = 0;
#else
#define INPUT input
#define SINPUT sinput
#endif

#define DEFINES_LABEL_NAME( label_name ) SINPUT string label_name##_1_43_1065_23_34_12_04_2017

// Основные (общие) настройки
DEFINES_LABEL_NAME ( main_settings ) = "Общие настройки и управление торгами"; //===== Общие настройки
// (true|false)(1|0) - разрешить|запретить открывать Sell ордера. Применяется немедленно и действует пока вы не прикажете противоположное.
SINPUT bool TradeSell = true;
// (true|false)(1|0) - разрешить|запретить открывать Buy ордера. Применяется немедленно и действует пока вы не прикажете противоположное.
SINPUT bool TradeBuy = true;
// (true|false)(1|0) - разрешить|запретить боту самому открывать первый ордер Sell сетки. Если хоть 1 ордер(-а) открыт, сетка строится согласно настроек.
SINPUT bool S_OpenFirstOrder = true;
// (true|false)(1|0) - разрешить|запретить боту самому открывать первый ордер Buy сетки. Если хоть 1 ордер(-а) открыт, сетка строится согласно настроек.
SINPUT bool B_OpenFirstOrder = true;
// (false|true)(0|1) - когда вы зададите =true, по текущим ценам будут закрыты все Sell ордера и удалены все SellStop отложки. Дефолтно и всегда =false.
SINPUT bool S_CloseAllOrders = false;
// (false|true)(0|1) - когда вы зададите =true, по текущим ценам будут закрыты все Buy ордера и удалены все BuyStop отложки. Дефолтно и всегда =false.
SINPUT bool B_CloseAllOrders = false;
// минут паузы после закрытия сответствующей сетки ордеров
SINPUT int S_PauseOnClose = 0;
SINPUT int B_PauseOnClose = 0;
// Магик (технический - групповой фиксированный №) всех ордеров Sell и Buy сеток данной копии бота.
SINPUT int MagicNumber = 1110;
SINPUT string AddComment = EXT_STRING_EMPTY;
// Применять настройки Sell сеток в Buy сетках - симметричные настройки. Вам надо вводить настройки только для Sell сеток.
SINPUT bool ReflectSellSettingsToBuy = false;

DEFINES_LABEL_NAME ( filters_part ) = "Фильтры спрэда и одновременно торгуемых пар и валют"; // ===== Фильтры, часть 1
// (=0 - отключено) Предельный спрэд. Если текущий спрэд превысит MaxSpread, включается запрет открытия ордеров - пока текущий спрэд больше MaxSpread
INPUT int MaxSpread = 5;
INPUT int MaxSpreadStopTradingTimining = 30;
SINPUT int MinLeverage = 0;
INPUT int MinTimeStep = 0;
SINPUT int MaxTradePairs = 0;
SINPUT int CurrencyBlock = 0;

DEFINES_LABEL_NAME ( trade_control_by_drawdown ) = "Управление торгами в зависимости от просадки"; // ===== Контроль просадки
INPUT int No1Order_ByDrawdownPercent = 0;
INPUT int No1Order_ByDrawdownPercent_Off = 0;
// (=0 - отключено) Запрет открытия ордеров (в той сетке, которая в просадке) по достижении просадки в % от депо
INPUT int StopTrade_ByDrawdownPercent = 0;
INPUT int StopTrade_ByDrawdownPercent_Off = 0;
// (=0 - откл) Запрет открытия ордеров (в той сетке, которая в просадке) по достижении просадки, равной указанной сумме в валюте счета
INPUT int StopTrade_ByDrawdownMoney = 0;
INPUT int StopTrade_ByDrawdownMoney_Off = 0;
// (=0 - отключено) Закрытие всех Buy и Sell ордеров по достижении прибыли в % от депо.
INPUT double CloseAllOrders_ByProfitPercent = 0;
//(=0 - отключено) Закрытие всех Buy и Sell ордеров по достижении прибыли, равной указанной сумме в валюте счета.
INPUT double CloseAllOrders_ByProfitMoney = 0;
// (=0 - отключено) Закрытие всех Buy и Sell ордеров по достижении просадки в % от депо.
INPUT double CloseAllOrders_ByDrawdownPercent = 0;
//(=0 - отключено) Закрытие всех Buy и Sell ордеров по достижении просадки, равной указанной сумме в валюте счета.
INPUT double CloseAllOrders_ByDrawdownMoney = 0;
SINPUT bool CloseAllOrders_ByDrawdown_StopTrade = false;

// Найстройки шага сетки для коротких позиций
DEFINES_LABEL_NAME ( sell_step_settings ) = "SELL сетки - настройки шагов, количества колен и длины"; //===== SELL сетки - шаг и поправки в 4-хзначных пипсах
// Максимальное количество SELL ордеров (колен), которое вы разрешаете боту открыть в SELL сетке
INPUT int S_MaxOpenOrders = 15;
// Начальный шаг SELL сетки в пипсах
INPUT int S_GridStep = 16;
// № п/п ордера (колена) SELL сетки, начиная с которого (включительно) текущий шаг SELL сетки будет корректироваться на S_GridStep_AddPips пипсов (на каждым колене)
INPUT int S_GridLevel = 6;
// Количество пипсов, на которое будет корректироваться текущий шаг SELL сетки на каждом колене, начиная с колена S_GridLevel. М.б. =0, >0 и даже <0.
INPUT int S_GridStep_AddPips = 1;
INPUT int S_GridStep_Level2 = 10;
INPUT int S_GridStep_Level2_AddPips = 6;
INPUT int S_Grid3 = 0;
INPUT int S_Grid3Add = 0;
INPUT int S_GridStop = 0;

// Настройки лота для коротких позиций
DEFINES_LABEL_NAME ( sell_lot_settings ) = "SELL сетки - min ордер и множители лота всех колен"; //===== SELL сетки - настройки лотов ордеров всех колен
SINPUT enum_calc_lot_type S_CalcLotType = calc_lot_type_last_order;
// Кол-во средств на ордер размера S_MinLot
INPUT int S_CurrencyForMinLot = 0;
// лот 1-го (первого) минимального ордера сетки
INPUT double S_MinLot = 0.01;
// Начальный множитель лота для ордеров SELL сетки. Чаще всего лот очередного открываемого ордера сетки = лоту последнего ордера SELL сетки * S_Mult (с или без коррекции)
INPUT double S_Mult = 1.4;
// № п/п ордера (колена) SELL сетки, начиная с которого начинает применяться S_Mult.  До округления лот ордера S_MultStart колена = S_MinLot * S_Mult
INPUT int S_MultStart = 3;
// № п/п ордера (колена) SELL сетки, начиная с которого (включительно) S_Mult корректируется на величину S_MultCorr (на каждом колене)
INPUT int S_MultLevel2 = 11;
// Величина коррекции (на каждом колене) текущего/расчетного значения множителя лота SELL сетки, начиная с колена S_MultLevel2 включительно
INPUT double S_MultCorr = 0.02;
INPUT int S_MultLevel3 = 0;
INPUT double S_MultСorrLevel3 = 0;
INPUT int S_Mult3 = 0;
INPUT double S_Mult3Add = 0.0;
INPUT int S_MultStop = 0;
INPUT double S_MaxLotCoef = 0.0;

// Настройки ТР для коротких позиций
DEFINES_LABEL_NAME ( sell_tp_settings ) = "SELL сетки: настройки TP (чистая прибыль) --> [уровень_БУ]+ТР"; //===== SELL сетки - TP и поправка в 4-хзначных пипсах
// Тип рассчета ТР ( tp_avg - по среднему взвешенному, tp_level_without_loss - относительно уровня безубытка)
INPUT enum_take_profit_calc_type S_TakeProffitType = tp_level_without_loss;
// Начальное количество пипсов ТР - прибыли от сетки.  Прибавляется (с минусом) к уровню безубытка или среднеарифметическому взвешенному SELL сетки.
INPUT int S_TakeProffit = 14;
// № п/п ордера (колена) SELL сетки, начиная с которого S_TakeProffit будет корректироваться на S_TakeProffit_Level1Corr (на каждом колене)
INPUT int S_TakeProffit_Level1 = 6;
// Количество пипсов, на которое корректируется текущее/расчетное значение ТР, начиная с S_TakeProffit_Level1 колена.  Может быть >0 или <0.
INPUT int S_TakeProffit_Level1Corr = 1;
INPUT int S_TakeProffit_Level1_5 = 0;
INPUT int S_TakeProffit_Level1_5Corr = 0;
// № п/п ордера (колена) SELL сетки, начиная с которого уровень ТР сетки жестко выставляется на уровень безубытка - S_TakeProffit_Level2FixPips
INPUT int S_TakeProffit_Level2 = 0;
// Количество пипсов отступа в плюс (прибыли) от уровня безубытка SELL сетки, фиксированно выставляемого начиная с S_TakeProffit_Level2 колена
INPUT int S_TakeProffit_Level2FixPips = 0;

// Найстройки шага сетки для длинных позиций
DEFINES_LABEL_NAME ( buy_step_settings ) = "BUY сетки - настройки шагов, количества колен и длины"; //===== BUY сетки - шаг и поправки в 4-хзначных пипсах
INPUT int B_MaxOpenOrders = 15;
INPUT int B_GridStep = 16;
INPUT int B_GridLevel = 6;
INPUT int B_GridStep_AddPips = 1;
INPUT int B_GridStep_Level2 = 10;
INPUT int B_GridStep_Level2_AddPips = 6;
INPUT int B_Grid3 = 0;
INPUT int B_Grid3Add = 0;
INPUT int B_GridStop = 0;

// Настройки лота для длинных позиций
DEFINES_LABEL_NAME ( buy_lot_settings ) = "BUY сетки - min ордер и множители лота всех колен"; //===== BUY сетки - настройки лотов ордеров всех колен
SINPUT enum_calc_lot_type B_CalcLotType = calc_lot_type_last_order;
INPUT int B_CurrencyForMinLot = 0;
// лот 1-го (первого) минимального ордера сетки
INPUT double B_MinLot = 0.01;
INPUT double B_Mult = 1.4;
INPUT int B_MultStart = 3;
INPUT int B_MultLevel2 = 11;
INPUT double B_MultCorr = 0.02;
INPUT int B_MultLevel3 = 0;
INPUT double B_MultСorrLevel3 = 0;
INPUT int B_Mult3 = 0;
INPUT double B_Mult3Add = 0.0;
INPUT int B_MultStop = 0;
INPUT double B_MaxLotCoef = 0.0;

// Настройки ТР для длинных позиций
DEFINES_LABEL_NAME ( buy_tp_settings ) = "BUY сетки: настройки TP (прибыль) --> [уровень_БУ]+ТР"; //===== BUY сетки - TP и поправка в 4-хзначных пипсах
INPUT enum_take_profit_calc_type B_TakeProffitType = tp_level_without_loss;
INPUT int B_TakeProffit = 14;
INPUT int B_TakeProffit_Level1 = 6;
INPUT int B_TakeProffit_Level1Corr = 1;
INPUT int B_TakeProffit_Level1_5 = 0;
INPUT int B_TakeProffit_Level1_5Corr = 0;
INPUT int B_TakeProffit_Level2 = 0;
INPUT int B_TakeProffit_Level2FixPips = 0;

enum_position_signal PositionSignal = enum_position_signal_simple;
// Настройки безиндикаторного входа
DEFINES_LABEL_NAME ( without_indicator_settings ) = "Настройки параметров и фильтров безиндикаторного входа"; //===== Фильтры, часть 2 - безиндикаторный вход 1-м ордером
// Таймфрэйм, на котором бот принимает решение об открытии первого ордера Buy или Sell сетки (при безындикаторном входе)
INPUT ENUM_TIMEFRAMES OpenFirstOrderTF = PERIOD_M1;
INPUT int CandlesToOpen1Order = 3;
INPUT bool CandlesToOpen1Order_OpenClose = true;
INPUT int CandlesToOpen1Order_MinPips = 4;
INPUT int CandlesToOpen1Order_MaxPips = 20;
INPUT bool ReversSignalToOpen1Order = true;

// Настройки гэп контроля
DEFINES_LABEL_NAME ( gap_settings ) = "Настройки блока выявления и обработки гэпов"; //===== Фильтры, часть 3 - обработка мартин-гэпов
INPUT enum_gap_control_type GapControl = op_stop;
INPUT int GapMaxStopOrders = 3;
INPUT int GapMinDistanceFromMarket = 4;
INPUT int S_GapMinPips = 10;
INPUT int S_GapMinPercent = 0;
INPUT double S_GapLotKoef = 0.5;
INPUT double S_GapLastOrderKoef = 2.0;
INPUT int B_GapMinPips = 10;
INPUT int B_GapMinPercent = 0;
INPUT double B_GapLotKoef = 0.5;
INPUT double B_GapLastOrderKoef = 2.0;

// Настройки фильтра волатильности
DEFINES_LABEL_NAME ( vol_filter_settings ) = "Фильтр - Запрет открывать ордера, если импульс"; //===== Фильтры, часть 4 - фильтр волатильности
INPUT ENUM_TIMEFRAMES VolCandleTF = PERIOD_M1;
INPUT int VolCandleMaxSize = 15;
INPUT int VolStopTradeTimining = 60;

// Настройки планировщика
DEFINES_LABEL_NAME ( sheduler_settings ) = "Настройки планировщиков торговли - их 5 разных"; //===== Фильтры, часть 5 - фильтры времени торговли
DEFINES_LABEL_NAME ( sheduler_trade_week_settings ) = "№1 Еженедельно: можно открывать 1-е ордера со Start_дня|время по End_день|время"; //===№1 Еженедельно: можно открывать 1-е ордера - начало/конец интервала
INPUT day_of_week_t TradeStartDay = day_of_week_t_sunday;
INPUT int TradeStartHour = 0;
INPUT int TradeStartMinute = 0;
INPUT day_of_week_t TradeEndDay = day_of_week_t_saturday;
INPUT int TradeEndHour = 12;
INPUT int TradeEndMinute = 0;

DEFINES_LABEL_NAME ( sheduler_new_positio_pause_settings ) = "№2 Однократно: от и до - запрещено открывать любые новые позиции"; //===№2 Ежедневно - Периоды запрета открывать любые новые позиции
#define input_new_position_pause(number) \
	SINPUT datetime NewPositionPause##number##Start = MIN_DATE; \
	SINPUT datetime NewPositionPause##number##End = MIN_DATE;

input_new_position_pause ( 1 );
input_new_position_pause ( 2 );
input_new_position_pause ( 3 );
input_new_position_pause ( 4 );
input_new_position_pause ( 5 );
input_new_position_pause ( 6 );
input_new_position_pause ( 7 );
input_new_position_pause ( 8 );
input_new_position_pause ( 9 );
input_new_position_pause ( 10 );

DEFINES_LABEL_NAME ( sheduler_trade_day_settings ) = "№3 Ежедневно: можно открывать 1-е ордера сеток - 10 интервалов"; //===№3 Ежедневно: можно открывать 1-е ордера - 5 интервалов
#define input_intraday(number) \
	INPUT ushort IntraDay##number##StartHour = 0; \
	INPUT ushort IntraDay##number##StartMinute = 0; \
	INPUT ushort IntraDay##number##EndHour = 0; \
	INPUT ushort IntraDay##number##EndMinute = 0

input_intraday ( 1 );
input_intraday ( 2 );
input_intraday ( 3 );
input_intraday ( 4 );
input_intraday ( 5 );
input_intraday ( 6 );
input_intraday ( 7 );
input_intraday ( 8 );
input_intraday ( 9 );
input_intraday ( 10 );

DEFINES_LABEL_NAME ( sheduler_trade_pause_settings ) = "№4 Однократно: от и до - запрещено открывать любые ордера"; //===№4 Однократно - запрет открывать любые ордера
#define input_tradepause(number) \
	SINPUT datetime TradePause##number##Start = MIN_DATE; \
	SINPUT datetime TradePause##number##End = MIN_DATE

input_tradepause ( 1 );
input_tradepause ( 2 );
input_tradepause ( 3 );
input_tradepause ( 4 );
input_tradepause ( 5 );
input_tradepause ( 6 );
input_tradepause ( 7 );
input_tradepause ( 8 );
input_tradepause ( 9 );
input_tradepause ( 10 );

DEFINES_LABEL_NAME ( sheduler_trade_stop_settings ) = "№5 Ежедневно - до 10 интервалов запрета открывать любые ордера"; //===№5 Ежедневно - Периоды запрета открывать любые ордера
#define input_stoptrade(number) \
	INPUT ushort IntraDayStopTrade##number##StartHour = 0; \
	INPUT ushort IntraDayStopTrade##number##StartMinute = 0; \
	INPUT ushort IntraDayStopTrade##number##EndHour = 0; \
	INPUT ushort IntraDayStopTrade##number##EndMinute = 0

input_stoptrade ( 1 );
input_stoptrade ( 2 );
input_stoptrade ( 3 );
input_stoptrade ( 4 );
input_stoptrade ( 5 );
input_stoptrade ( 6 );
input_stoptrade ( 7 );
input_stoptrade ( 8 );
input_stoptrade ( 9 );
input_stoptrade ( 10 );

DEFINES_LABEL_NAME ( sheduler_close_all_order_settings ) = "№6 Ежедневно - закрытие обеих сеток в одно время"; //===№6 Ежедневно - закрытие обеих сеток в одно время
INPUT int CloseAllOrders_EveryDay_Hour = 0;
INPUT int CloseAllOrders_EveryDay_Minute = 0;

// Прочие настройки
DEFINES_LABEL_NAME ( other_settings ) = "===Прочие общие настройки"; //===== Прочие общие настройки
// ( 0 = выкл, >0 - вкл) Кол-во секунд через которые перепроверяется и корректируется ТР сеток
SINPUT int TakeProffitControlTiming = 90;
// Кол-во пипсов для S_TakeProffitControlTiming. ТР сетки будет установлен на Б/У - TakeProffitNoLossControlFixPips
INPUT int TakeProffitControlNoLossFixPips = 3;
//Остановить торговлю - запрет открытиия новых сеток
SINPUT datetime FinalGridDate = D'2020.12.30 00: 00: 00';
								// Кол-во секунд для таймера обновления глобальных параметров
								SINPUT int GlobalParamsUpdateTiming = 60;
// ( 0 = выкл, 1 = ошибки, 2 = мелкая информация, 3 = более детальная информация, 4 = отладочная информация  ) Отображение лога
SINPUT int LogVerbose = 2;

#define conv_expression(exp) \
	ext_string::replace( ext_string::replace( ext_string::replace( ext_string::replace( exp, "!=", SRC_DEFINES_NOT_EQUALLY ), "==", SRC_DEFINES_EQUALLY ), "||", SRC_DEFINES_OR ), "&&", SRC_DEFINES_AND )

#ifdef FOR_OPTIMIZATION

#define def_to_str_from_int( value ) EXT_STRING_EMPTY

#define valid_tboo(field) ( true )
#define valid_tint(field) ( true )
#define valid_tdou(field) ( true )
#define valid_tenu(field) ( true )
#define valid_tstr(field) ( true )
#define valid_bool(field, expression) ( expression )
#define valid_inte(field, expression) ( expression )
#define valid_doub(field, expression) ( expression )
#define valid_enum(field, expression) ( expression )

#else

#define def_to_str_from_int( value ) StringFormat("%s = %s", #value, IntegerToString( value ) )

#define valid_tboo(field) \
	defines_validate( true,\
					  EXT_STRING_EMPTY,\
					  StringFormat ( SRC_DEFINES_VALID_MSG, #field, ( field ? "true" : "false" ) ) )

#define valid_tint(field) \
	defines_validate( true,\
					  EXT_STRING_EMPTY,\
					  StringFormat ( SRC_DEFINES_VALID_MSG, #field, IntegerToString ( field ) ) )

#define valid_tdou(field) \
	defines_validate( true,\
					  EXT_STRING_EMPTY,\
					  StringFormat ( SRC_DEFINES_VALID_MSG, #field, DoubleToString ( field ) ) )

#define valid_tenu(field) \
	defines_validate( true,\
					  EXT_STRING_EMPTY,\
					  StringFormat ( SRC_DEFINES_VALID_MSG, #field, EnumToString ( field ) ) )

#define valid_tstr(field) \
	defines_validate( true,\
					  EXT_STRING_EMPTY,\
					  StringFormat ( SRC_DEFINES_VALID_MSG, #field, field ) )

#define valid_bool(field, expression) \
	defines_validate( expression,\
					  StringFormat ( SRC_DEFINES_ERROR_MSG, #field, conv_expression(#expression) ),\
					  StringFormat ( SRC_DEFINES_VALID_MSG, #field, ( field ? "true" : "false" ) ) )

#define valid_inte(field, expression) \
	defines_validate( expression,\
					  StringFormat ( SRC_DEFINES_ERROR_MSG, #field, conv_expression(#expression) ),\
					  StringFormat ( SRC_DEFINES_VALID_MSG, #field, IntegerToString ( field ) ) )

#define valid_doub(field, expression) \
	defines_validate( expression,\
					  StringFormat ( SRC_DEFINES_ERROR_MSG, #field, conv_expression(#expression) ),\
					  StringFormat ( SRC_DEFINES_VALID_MSG, #field, DoubleToString ( field ) ) )

#define valid_enum(field, expression) \
	defines_validate( expression,\
					  StringFormat ( SRC_DEFINES_ERROR_MSG, #field, conv_expression(#expression) ),\
					  StringFormat ( SRC_DEFINES_VALID_MSG, #field, EnumToString ( field ) ) )

bool defines_validate ( bool value, string not_valid_msg, string valid_msg )
{
	log_info ( valid_msg );

	if ( value ) {
		return true;
	}

	log_error ( not_valid_msg );
	MessageBox ( not_valid_msg, SRC_DEFINES_ERROR_INPUT, MB_OK );
	return false;
}

#endif

#define check_new_position_pause(number) \
	(valid_tint ( NewPositionPause##number##Start ) \
	 && valid_inte ( NewPositionPause##number##End, \
					 NewPositionPause##number##Start == MIN_DATE \
					 || NewPositionPause##number##End > NewPositionPause##number##Start ))

#define check_trade_pause(number) \
	(valid_tint ( TradePause##number##Start ) \
	 && valid_inte ( TradePause##number##End, \
					 TradePause##number##Start == MIN_DATE \
					 || TradePause##number##End > TradePause##number##Start ))

#define check_intrade(number) \
	(valid_inte ( IntraDay##number##StartHour, \
				  IntraDay##number##StartHour >= 0 \
				  && IntraDay##number##StartHour <= 23 ) \
	 && valid_inte ( IntraDay##number##StartMinute, \
					 IntraDay##number##StartMinute >= 0 \
					 && IntraDay##number##StartMinute <= 59 ) \
	 && valid_inte ( IntraDay##number##EndHour, \
					 IntraDay##number##EndHour >= 0 \
					 && IntraDay##number##EndHour <= 23 \
					 && IntraDay##number##EndHour >= IntraDay##number##StartHour ) \
	 && valid_inte ( IntraDay##number##EndMinute, \
					 IntraDay##number##EndMinute >= 0 \
					 && IntraDay##number##EndMinute <= 59 \
					 && ( IntraDay##number##StartHour != IntraDay##number##EndHour \
						  || ( IntraDay##number##StartHour == IntraDay##number##EndHour \
							   &&  IntraDay##number##StartMinute <= IntraDay##number##EndMinute ) ) ))

#define check_intraday_stop_trade(number) \
	(valid_inte ( IntraDayStopTrade##number##StartHour, \
				  IntraDayStopTrade##number##StartHour >= 0 \
				  && IntraDayStopTrade##number##StartHour <= 23 ) \
	 && valid_inte ( IntraDayStopTrade##number##StartMinute, \
					 IntraDayStopTrade##number##StartMinute >= 0 \
					 && IntraDayStopTrade##number##StartMinute <= 59 ) \
	 && valid_inte ( IntraDayStopTrade##number##EndHour, \
					 IntraDayStopTrade##number##EndHour >= 0 \
					 && IntraDayStopTrade##number##EndHour <= 23 \
					 && IntraDayStopTrade##number##EndHour >= IntraDayStopTrade##number##StartHour ) \
	 && valid_inte ( IntraDayStopTrade##number##EndMinute, \
					 IntraDayStopTrade##number##EndMinute >= 0 \
					 && IntraDayStopTrade##number##EndMinute <= 59 \
					 && ( IntraDayStopTrade##number##StartHour != IntraDayStopTrade##number##EndHour \
						  || ( IntraDayStopTrade##number##StartHour == IntraDayStopTrade##number##EndHour \
							   &&  IntraDayStopTrade##number##StartMinute <= IntraDayStopTrade##number##EndMinute ) ) ))

bool defines_validate()
{
	return valid_tboo ( TradeSell )
		   && valid_tboo ( TradeBuy )
		   && valid_tboo ( S_OpenFirstOrder )
		   && valid_tboo ( B_OpenFirstOrder )
		   && valid_tboo ( S_CloseAllOrders )
		   && valid_tboo ( B_CloseAllOrders )
		   && valid_inte ( No1Order_ByDrawdownPercent,
						   No1Order_ByDrawdownPercent >= 0
						   && No1Order_ByDrawdownPercent <= 100 )
		   && valid_inte ( StopTrade_ByDrawdownPercent,
						   StopTrade_ByDrawdownPercent >= 0
						   && StopTrade_ByDrawdownPercent <= 100 )
		   && valid_inte ( StopTrade_ByDrawdownPercent_Off,
						   StopTrade_ByDrawdownPercent_Off == 0
						   || ( StopTrade_ByDrawdownPercent_Off >= 0
								&& StopTrade_ByDrawdownPercent_Off <= StopTrade_ByDrawdownPercent ) )
		   && valid_inte ( StopTrade_ByDrawdownMoney,
						   StopTrade_ByDrawdownMoney >= 0 )
		   && valid_inte ( StopTrade_ByDrawdownMoney_Off,
						   StopTrade_ByDrawdownMoney_Off == 0
						   || ( StopTrade_ByDrawdownMoney_Off >= 0
								&& StopTrade_ByDrawdownMoney_Off <= StopTrade_ByDrawdownMoney ) )
		   && valid_doub ( CloseAllOrders_ByProfitPercent,
						   CloseAllOrders_ByProfitPercent >= 0.0
						   && CloseAllOrders_ByProfitPercent <= 100.0 )
		   && valid_doub ( CloseAllOrders_ByProfitMoney,
						   CloseAllOrders_ByProfitMoney >= 0.0 )
		   && valid_doub ( CloseAllOrders_ByDrawdownPercent,
						   CloseAllOrders_ByDrawdownPercent >= 0.0
						   && CloseAllOrders_ByDrawdownPercent <= 100.0 )
		   && valid_doub ( CloseAllOrders_ByDrawdownMoney,
						   CloseAllOrders_ByDrawdownMoney >= 0 )
		   && valid_inte ( S_PauseOnClose, S_PauseOnClose >= 0 )
		   && valid_inte ( B_PauseOnClose, B_PauseOnClose >= 0 )
		   && valid_inte ( MaxSpread,
						   MaxSpread == 0
						   || ( MaxSpread > 0 && MaxSpreadStopTradingTimining >= 30 ) )
		   && valid_inte ( MaxSpreadStopTradingTimining,
						   MaxSpread == 0
						   || ( MaxSpread > 0 && MaxSpreadStopTradingTimining >= 30 ) )
		   && valid_inte ( MinLeverage,
						   MinLeverage >= 0 )
		   && valid_inte ( MinTimeStep,
						   MinTimeStep >= 0 )
		   && valid_inte ( MaxTradePairs,
						   MaxTradePairs >= 0 )
		   && valid_inte ( CurrencyBlock,
						   CurrencyBlock >= 0 && CurrencyBlock < 100 )
		   && valid_tint ( MagicNumber )
		   && valid_tstr ( AddComment )
		   && valid_tboo ( ReflectSellSettingsToBuy )
		   // Найстройки шага сетки для коротких позиций
		   && valid_inte ( S_MaxOpenOrders,
						   S_MaxOpenOrders > 0 )
		   && valid_inte ( S_GridStep, S_GridStep > 0 )
		   && valid_inte ( S_GridLevel,
						   S_GridLevel == 0
						   || ( S_GridLevel > 1
								&& S_GridLevel <= S_MaxOpenOrders ) )
		   && valid_tint ( S_GridStep_AddPips )
		   && valid_inte ( S_GridStep_Level2,
						   S_GridStep_Level2 == 0
						   || ( S_GridLevel > 0
								&& S_GridStep_Level2 > S_GridLevel
								&& S_GridStep_Level2 <= S_MaxOpenOrders ) )
		   && valid_tint ( S_GridStep_Level2_AddPips )
		   && valid_inte ( S_Grid3,
						   S_Grid3 == 0
						   || ( S_GridStep_Level2 > 0
								&& S_Grid3 > S_GridStep_Level2
								&& S_Grid3 <= S_MaxOpenOrders ) )
		   && valid_tint ( S_Grid3Add )
		   && valid_inte ( S_GridStop,
						   S_GridStop >= 0
						   && S_GridStop <= S_MaxOpenOrders )
		   // Настройки лота для коротких позиций
		   && valid_tint ( S_CalcLotType )
		   && valid_inte ( S_CurrencyForMinLot,
						   S_CurrencyForMinLot >= 0 )
		   && valid_tdou ( S_MinLot )
		   && valid_doub ( S_Mult,
						   S_Mult > 0.00 )
		   && valid_inte ( S_MultStart,
						   S_MultStart > 1
						   && S_MultStart <= S_MaxOpenOrders )
		   && valid_inte ( S_MultLevel2,
						   S_MultLevel2 == 0
						   || ( S_MultStart > 0
								&& S_MultLevel2 > S_MultStart
								&& S_MultLevel2 <= S_MaxOpenOrders ) )
		   && valid_tdou ( S_MultCorr )
		   && valid_inte ( S_MultLevel3,
						   S_MultLevel3 == 0
						   || ( S_MultLevel2 > 0
								&& S_MultLevel3 > S_MultLevel2
								&& S_MultLevel3 <= S_MaxOpenOrders ) )
		   && valid_tdou ( S_MultСorrLevel3 )
		   && valid_inte ( S_Mult3,
						   S_Mult3 == 0
						   || ( S_MultLevel3 > 0
								&& S_Mult3 > S_MultLevel3
								&& S_Mult3 <= S_MaxOpenOrders ) )
		   && valid_tdou ( S_Mult3Add )
		   && valid_inte ( S_MultStop,
						   S_MultStop >= 0
						   && S_MultStop <= S_MaxOpenOrders )
		   && valid_doub ( S_MaxLotCoef,
						   S_MaxLotCoef == 0
						   || S_MaxLotCoef >= S_MaxLotCoef )
		   // Настройки ТР для коротких позиций
		   && valid_tint ( S_TakeProffitType )
		   && valid_doub ( S_TakeProffit,
						   S_TakeProffit > 0.0 )
		   && valid_inte ( S_TakeProffit_Level1,
						   S_TakeProffit_Level1 == 0
						   || ( S_TakeProffit_Level1 > 1
								&& S_TakeProffit_Level1 <= S_MaxOpenOrders ) )
		   && valid_tint ( S_TakeProffit_Level1Corr )
		   && valid_inte ( S_TakeProffit_Level1_5,
						   S_TakeProffit_Level1_5 == 0
						   || ( S_TakeProffit_Level1_5 > S_TakeProffit_Level1
								&& S_TakeProffit_Level1_5 <= S_MaxOpenOrders ) )
		   && valid_tint ( S_TakeProffit_Level1_5Corr )
		   && valid_inte ( S_TakeProffit_Level2,
						   S_TakeProffit_Level2 == 0
						   || ( S_TakeProffit_Level2 > S_TakeProffit_Level1
								&& S_TakeProffit_Level2 <= S_MaxOpenOrders ) )
		   && valid_inte ( S_TakeProffit_Level2FixPips,
						   S_TakeProffit_Level2 == 0
						   || S_TakeProffit_Level2FixPips >= TakeProffitControlNoLossFixPips )
		   // Найстройки шага сетки для длинных позиций
		   && ( ReflectSellSettingsToBuy
				|| ( valid_inte ( B_MaxOpenOrders,
								  B_MaxOpenOrders > 0 )
					 && valid_inte ( B_GridStep, B_GridStep > 0 )
					 && valid_inte ( B_GridLevel,
									 B_GridLevel == 0
									 || ( B_GridLevel > 1
										  && B_GridLevel <= B_MaxOpenOrders ) )
					 && valid_tint ( B_GridStep_AddPips )
					 && valid_inte ( B_GridStep_Level2,
									 B_GridStep_Level2 == 0
									 || ( B_GridLevel > 0
										  && B_GridStep_Level2 > B_GridLevel
										  && B_GridStep_Level2 <= B_MaxOpenOrders ) )
					 && valid_tint ( B_GridStep_Level2_AddPips )
					 && valid_inte ( B_Grid3,
									 B_Grid3 == 0
									 || ( B_GridStep_Level2 > 0
										  && B_Grid3 > B_GridStep_Level2
										  && B_Grid3 <= B_MaxOpenOrders ) )
					 && valid_tint ( S_Grid3Add )
					 && valid_inte ( B_GridStop,
									 B_GridStop >= 0
									 && B_GridStop <= B_MaxOpenOrders ) ) )
		   // Настройки лота для длинных позиций
		   && ( ReflectSellSettingsToBuy
				|| ( valid_tint ( B_CalcLotType )
					 && valid_inte ( B_CurrencyForMinLot,
									 B_CurrencyForMinLot >= 0 )
					 && valid_tdou ( B_MinLot )
					 && valid_doub ( B_Mult,
									 B_Mult > 0.00 )
					 && valid_inte ( B_MultStart,
									 B_MultStart > 1
									 && B_MultStart <= B_MaxOpenOrders )
					 && valid_inte ( B_MultLevel2,
									 B_MultLevel2 == 0
									 || ( B_MultStart > 0
										  && B_MultLevel2 > B_MultStart
										  && B_MultLevel2 <= B_MaxOpenOrders ) )
					 && valid_tdou ( B_MultCorr )
					 && valid_inte ( B_MultLevel3,
									 B_MultLevel3 == 0
									 || ( B_MultLevel2 > 0
										  && B_MultLevel3 > B_MultLevel2
										  && B_MultLevel3 <= B_MaxOpenOrders ) )
					 && valid_tdou ( B_MultСorrLevel3 )
					 && valid_inte ( B_Mult3,
									 B_Mult3 == 0
									 || ( B_MultLevel3 > 0
										  && B_Mult3 > B_MultLevel3
										  && B_Mult3 <= B_MaxOpenOrders ) )
					 && valid_tdou ( B_Mult3Add )
					 && valid_inte ( B_MultStop,
									 B_MultStop >= 0
									 && B_MultStop <= B_MaxOpenOrders )
					 && valid_doub ( B_MaxLotCoef,
									 B_MaxLotCoef == 0
									 || B_MaxLotCoef >= B_MinLot  ) ) )
		   // Настройки ТР для длинных позиций
		   && ( ReflectSellSettingsToBuy
				|| ( valid_tint ( B_TakeProffitType )
					 && valid_doub ( B_TakeProffit,
									 B_TakeProffit > 0.0 )
					 && valid_inte ( B_TakeProffit_Level1,
									 B_TakeProffit_Level1 == 0
									 || ( B_TakeProffit_Level1 > 1
										  && B_TakeProffit_Level1 <= B_MaxOpenOrders ) )
					 && valid_tint ( B_TakeProffit_Level1Corr )
					 && valid_inte ( B_TakeProffit_Level1_5,
									 B_TakeProffit_Level1_5 == 0
									 || ( B_TakeProffit_Level1_5 > B_TakeProffit_Level1
										  && B_TakeProffit_Level1_5 <= B_MaxOpenOrders ) )
					 && valid_tint ( S_TakeProffit_Level1_5Corr )
					 && valid_inte ( B_TakeProffit_Level2,
									 B_TakeProffit_Level2 == 0
									 || ( B_TakeProffit_Level2 > B_TakeProffit_Level1
										  && B_TakeProffit_Level2 <= B_MaxOpenOrders ) )
					 && valid_inte ( B_TakeProffit_Level2FixPips,
									 B_TakeProffit_Level2 == 0
									 || B_TakeProffit_Level2FixPips >= TakeProffitControlNoLossFixPips ) ) )
		   // Настройки безиндикаторного входа
		   && valid_tint ( OpenFirstOrderTF )
		   && valid_inte ( CandlesToOpen1Order,
						   CandlesToOpen1Order >= 0 )
		   && valid_tboo ( CandlesToOpen1Order_OpenClose )
		   && valid_inte ( CandlesToOpen1Order_MinPips,
						   CandlesToOpen1Order_MinPips == 0
						   || CandlesToOpen1Order_MinPips > 0 )
		   && valid_inte ( CandlesToOpen1Order_MaxPips,
						   CandlesToOpen1Order_MaxPips == 0
						   || ( CandlesToOpen1Order_MinPips == 0 && CandlesToOpen1Order_MaxPips > 0 )
						   || ( CandlesToOpen1Order_MinPips > 0 && CandlesToOpen1Order_MaxPips > CandlesToOpen1Order_MinPips ) )
		   && valid_tboo ( ReversSignalToOpen1Order )
		   // Настройки гэп контроля
		   && valid_tint ( GapControl )
		   && valid_inte ( GapMaxStopOrders,
						   GapMaxStopOrders >= 0 )
		   && valid_tint ( GapMinDistanceFromMarket )
		   && valid_inte ( S_GapMinPips,
						   S_GapMinPips == 0
						   || ( S_GapMinPips > 0 && S_GapMinPercent == 0 ) )
		   && valid_inte ( S_GapMinPercent,
						   S_GapMinPercent == 0
						   || ( S_GapMinPercent > 0 && S_GapMinPips == 0 ) )
		   && valid_doub ( S_GapLotKoef,
						   S_GapLotKoef <= 1 )
		   && valid_doub ( S_GapLastOrderKoef,
						   S_GapLastOrderKoef >= 0.00 )
		   && ( ReflectSellSettingsToBuy
				|| ( valid_inte ( B_GapMinPips,
								  B_GapMinPips == 0
								  || ( B_GapMinPips > 0 && B_GapMinPercent == 0 ) )
					 && valid_inte ( B_GapMinPercent,
									 B_GapMinPercent == 0
									 || ( B_GapMinPercent > 0 && B_GapMinPips == 0 ) )

					 && valid_doub ( B_GapLotKoef,
									 B_GapLotKoef <= 1 )
					 && valid_doub ( B_GapLastOrderKoef,
									 B_GapLastOrderKoef >= 0.00 ) ) )
		   // Настройки фильтра волатильности
		   && valid_tint ( VolCandleTF )
		   && valid_inte ( VolCandleMaxSize,
						   VolCandleMaxSize >= 0 )
		   && valid_inte ( VolStopTradeTimining,
						   VolStopTradeTimining == 0 || VolStopTradeTimining >= 30 )
		   // Настройки планировщика
		   && valid_bool ( CloseAllOrders_ByDrawdown_StopTrade,
						   !CloseAllOrders_ByDrawdown_StopTrade
						   || ( CloseAllOrders_ByDrawdown_StopTrade
								&& ( CloseAllOrders_ByDrawdownPercent > 0
									 || CloseAllOrders_ByDrawdownMoney > 0 ) ) )
		   && valid_inte ( TradeStartDay,
						   TradeStartDay <= TradeEndDay
						   && TradeStartDay >= day_of_week_t_sunday )
		   && valid_inte ( TradeStartHour,
						   TradeStartHour >= 0
						   && TradeStartHour <= 23
						   && ( TradeStartDay != TradeEndDay
								|| ( TradeStartDay == TradeEndDay
									 && TradeStartHour <= TradeEndHour  ) ) )
		   && valid_inte ( TradeStartMinute,
						   TradeStartMinute >= 0
						   && TradeStartMinute <= 59
						   && ( TradeStartDay != TradeEndDay
								|| ( TradeStartDay == TradeEndDay
									 && ( TradeStartHour < TradeEndHour
										  || ( TradeStartHour == TradeEndHour
												  && TradeStartMinute < TradeEndMinute )  ) ) ) )
		   && valid_inte ( TradeEndDay,
						   TradeEndDay >= TradeStartDay
						   && TradeEndDay <= day_of_week_t_saturday )
		   && valid_inte ( TradeEndHour,
						   TradeEndHour >= 0
						   && TradeEndHour <= 23 )
		   && valid_inte ( TradeEndMinute,
						   TradeEndMinute >= 0
						   && TradeEndMinute <= 59 )
		   && check_new_position_pause ( 1 )
		   && check_new_position_pause ( 2 )
		   && check_new_position_pause ( 3 )
		   && check_new_position_pause ( 4 )
		   && check_new_position_pause ( 5 )
		   && check_new_position_pause ( 6 )
		   && check_new_position_pause ( 7 )
		   && check_new_position_pause ( 8 )
		   && check_new_position_pause ( 9 )
		   && check_new_position_pause ( 10 )
		   && check_trade_pause ( 1 )
		   && check_trade_pause ( 2 )
		   && check_trade_pause ( 3 )
		   && check_trade_pause ( 4 )
		   && check_trade_pause ( 5 )
		   && check_trade_pause ( 6 )
		   && check_trade_pause ( 7 )
		   && check_trade_pause ( 8 )
		   && check_trade_pause ( 9 )
		   && check_trade_pause ( 10 )
		   && check_intrade ( 1 )
		   && check_intrade ( 2 )
		   && check_intrade ( 3 )
		   && check_intrade ( 4 )
		   && check_intrade ( 5 )
		   && check_intrade ( 6 )
		   && check_intrade ( 7 )
		   && check_intrade ( 8 )
		   && check_intrade ( 9 )
		   && check_intrade ( 10 )
		   && check_intraday_stop_trade ( 1 )
		   && check_intraday_stop_trade ( 2 )
		   && check_intraday_stop_trade ( 3 )
		   && check_intraday_stop_trade ( 4 )
		   && check_intraday_stop_trade ( 5 )
		   && check_intraday_stop_trade ( 6 )
		   && check_intraday_stop_trade ( 7 )
		   && check_intraday_stop_trade ( 8 )
		   && check_intraday_stop_trade ( 9 )
		   && check_intraday_stop_trade ( 10 )
		   && valid_inte ( CloseAllOrders_EveryDay_Hour,
						   CloseAllOrders_EveryDay_Hour >= 0
						   && CloseAllOrders_EveryDay_Hour <= 23 )
		   && valid_inte ( CloseAllOrders_EveryDay_Minute,
						   CloseAllOrders_EveryDay_Minute >= 0
						   && CloseAllOrders_EveryDay_Minute <= 57 )
		   // Прочие настройки
		   && valid_inte ( TakeProffitControlTiming,
						   TakeProffitControlTiming == 0
						   || TakeProffitControlTiming >= 30 )
		   && valid_tint ( TakeProffitControlNoLossFixPips )
		   && valid_inte ( GlobalParamsUpdateTiming,
						   GlobalParamsUpdateTiming == 0
						   || GlobalParamsUpdateTiming >= 30 )
		   && valid_inte ( LogVerbose,
						   LogVerbose >= 0
						   && LogVerbose <= 4 );
}

setting_t *defines_create ( bool is_buy, int lot_exp )
{
#ifndef FOR_OPTIMIZATION

	//TODO: нужно перенести вниз и сделать все это через reflect
	if ( is_buy && ReflectSellSettingsToBuy ) {
		log_info ( SRC_DEFINES_REFLECT_SELL_SETTINGS_TO_BUY );

		valid_tint ( S_MaxOpenOrders );
		valid_tint ( S_GridStep );
		valid_tint ( S_GridLevel );
		valid_tint ( S_GridStep_AddPips );
		valid_tint ( S_GridStep_Level2 );
		valid_tint ( S_GridStep_Level2_AddPips );
		valid_tint ( S_Grid3 );
		valid_tint ( S_Grid3Add );
		valid_tint ( S_GridStop );

		valid_tint ( S_CalcLotType );
		valid_tint ( S_CurrencyForMinLot );
		valid_tdou ( S_MinLot );
		valid_tdou ( S_Mult );
		valid_tint ( S_MultStart );
		valid_tint ( S_MultLevel2 );
		valid_tdou ( S_MultCorr );
		valid_tint ( S_MultLevel3 );
		valid_tdou ( S_MultСorrLevel3 );
		valid_tint ( S_Mult3 );
		valid_tdou ( S_Mult3Add );
		valid_tint ( S_MultStop );
		valid_tdou ( S_MaxLotCoef );

		valid_tint ( S_TakeProffitType );
		valid_tdou ( S_TakeProffit );
		valid_tint ( S_TakeProffit_Level1 );
		valid_tint ( S_TakeProffit_Level1Corr );
		valid_tint ( S_TakeProffit_Level1_5 );
		valid_tint ( S_TakeProffit_Level1_5Corr );
		valid_tint ( S_TakeProffit_Level2 );
		valid_tint ( S_TakeProffit_Level2FixPips );

		valid_tint ( S_GapMinPips );
		valid_tint ( S_GapMinPercent );
		valid_tdou ( S_GapLotKoef );
		valid_tdou ( S_GapLastOrderKoef );
	}

#endif

#define bs( name ) ( is_buy ? B_##name : S_##name )
#define bs_reflect( name ) ( is_buy && !ReflectSellSettingsToBuy ? B_##name : S_##name )

	int bit_multiplier = layer_account::bit_multiplier();
	setting_t *result = new setting_t();
	result.magic_number = MagicNumber;
	result.max_spread =	MaxSpread * bit_multiplier;
	result.close_all_orders = bs ( CloseAllOrders );
	result.open_positions = is_buy ? TradeBuy : TradeSell;
	result.open_first_order = bs ( OpenFirstOrder );
	result.max_open_orders = bs_reflect ( MaxOpenOrders );
	result.pause_on_close_in_sec = 60 *	bs ( PauseOnClose );
	result.position_signal = PositionSignal;
	result.time_frame =	OpenFirstOrderTF;
	result.candles_for_open_first_order = CandlesToOpen1Order;
	result.candles_for_open_first_order_open_close = CandlesToOpen1Order_OpenClose;
	result.candles_for_open_first_order_min_pips = CandlesToOpen1Order_MinPips * bit_multiplier;
	result.candles_for_open_first_order_max_pips = CandlesToOpen1Order_MaxPips * bit_multiplier;
	result.revers_signal_to_open_first_order = ReversSignalToOpen1Order;;
	result.grid_step = bs_reflect ( GridStep ) * bit_multiplier;
	result.grid_level = bs_reflect ( GridLevel );
	result.grid_value =	bs_reflect ( GridStep_AddPips ) * bit_multiplier;
	result.grid_level2 = bs_reflect ( GridStep_Level2 );
	result.grid_level2_add_pips = bs_reflect ( GridStep_Level2_AddPips ) * bit_multiplier;
	result.grid_level3 = bs_reflect ( Grid3 );
	result.grid_level3_add_pips = bs_reflect ( Grid3Add ) * bit_multiplier;
	result.grid_stop = bs_reflect ( GridStop );
	result.lot_exp = lot_exp;
	result.tp_type = bs_reflect ( TakeProffitType );
	result.take_profit_control_timing =	TakeProffitControlTiming;
	result.take_profit_control_noloss_fixpips =	TakeProffitControlNoLossFixPips * bit_multiplier;
	result.take_proffit = bs_reflect ( TakeProffit ) * bit_multiplier;
	result.take_proffit_level1 = bs_reflect ( TakeProffit_Level1 );
	result.take_proffit_level1_corr = bs_reflect ( TakeProffit_Level1Corr ) * bit_multiplier;
	result.take_proffit_level2 = bs_reflect ( TakeProffit_Level1_5 );
	result.take_proffit_level2_corr = bs_reflect ( TakeProffit_Level1_5Corr ) * bit_multiplier;
	result.take_proffit_level3 = bs_reflect ( TakeProffit_Level2 );
	result.take_proffit_level3_fix_pips = bs_reflect ( TakeProffit_Level2FixPips ) * bit_multiplier;
	result.max_spread_stop_drading_timing =	MaxSpreadStopTradingTimining;
	result.mult_type = bs_reflect ( CalcLotType );
	result.currency_for_min_lot = bs_reflect ( CurrencyForMinLot );
	result.lots = bs_reflect ( MinLot );
	result.multi_lots_factor = bs_reflect ( Mult );
	result.multi_lots_level1 = bs_reflect ( MultStart );
	result.multi_lots_level2 = bs_reflect ( MultLevel2 );
	result.multi_lots_level2_corr = bs_reflect ( MultCorr );
	result.multi_lots_level3 = bs_reflect ( MultLevel3 );
	result.multi_lots_level3_corr = bs_reflect ( MultСorrLevel3 );
	result.mult4 = bs_reflect ( Mult3 );
	result.mult4_add = bs_reflect ( Mult3Add );
	result.mult_stop = bs_reflect ( MultStop );
	result.gap_control = GapControl;
	result.gap_max_order_stop = GapMaxStopOrders;
	result.gap_min_pips_from_market = GapMinDistanceFromMarket * bit_multiplier;
	result.gap_min_pips = bs_reflect ( GapMinPips ) * bit_multiplier;
	result.gap_min_percent = bs_reflect ( GapMinPercent );
	result.gap_lot_koef = bs_reflect ( GapLotKoef );
	result.gap_last_order_koef = bs_reflect ( GapLastOrderKoef );
	result.vol_candle_tf = VolCandleTF;
	result.vol_candle_max_size = VolCandleMaxSize * bit_multiplier;
	result.vol_stop_trade_timing = VolStopTradeTimining;
	result.trade_start_day = TradeStartDay;
	result.trade_start_minute =	60 * TradeStartHour + TradeStartMinute;
	result.trade_end_day = TradeEndDay;
	result.trade_stop_minute = 60 * TradeEndHour + TradeEndMinute;
	result.final_stop_trading =	FinalGridDate;
	result.max_trade_pairs = MaxTradePairs;
	result.currency_block =	CurrencyBlock;
	result.no1Order_by_drawdown_percent = No1Order_ByDrawdownPercent;
	result.no1Order_by_drawdown_percent_off = No1Order_ByDrawdownPercent_Off;
	result.close_all_orders_by_drawdown_stop_trade = CloseAllOrders_ByDrawdown_StopTrade;
	result.add_comment = AddComment;
	result.min_leverage = MinLeverage;
	result.min_time_step = MinTimeStep;
	result.max_lot = bs_reflect ( MaxLotCoef );

	result.currency_block_label = def_to_str_from_int ( CurrencyBlock );
	result.max_trade_pairs_label = def_to_str_from_int ( MaxTradePairs );

	return result;
}

#define define_check_new_position_pause( number ) \
	( NewPositionPause##number##Start != MIN_DATE \
	  || NewPositionPause##number##End != MIN_DATE )
#define define_check_intraday( number ) \
	( IntraDay##number##StartHour != IntraDay##number##EndHour \
	  || IntraDay##number##StartMinute != IntraDay##number##EndMinute )
#define define_check_trade_pause( number ) \
	( TradePause##number##Start != MIN_DATE \
	  && TradePause##number##End != MIN_DATE )
#define define_check_intraday_stop_trade( number ) \
	( IntraDayStopTrade##number##StartHour != IntraDayStopTrade##number##EndHour \
	  || IntraDayStopTrade##number##StartMinute != IntraDayStopTrade##number##EndMinute )

#define defines_put_new_position_pause( number ) \
	NewPositionPause##number##Start, \
	NewPositionPause##number##End
#define defines_put_trade_pause( number ) \
	TradePause##number##Start, \
	TradePause##number##End
#define define_put_intraday( number ) \
	IntraDay##number##StartHour, \
	IntraDay##number##StartMinute, \
	IntraDay##number##EndHour, \
	IntraDay##number##EndMinute
#define define_put_intraday_stop_trade( number ) \
	IntraDayStopTrade##number##StartHour, \
	IntraDayStopTrade##number##StartMinute, \
	IntraDayStopTrade##number##EndHour, \
	IntraDayStopTrade##number##EndMinute

void defines_init_scheduler()
{
	if ( TradeStartDay != TradeEndDay
			|| TradeStartHour != TradeEndHour
			|| TradeStartMinute != TradeEndMinute ) {
		scheduler::set_trade ( TradeStartDay,
							   TradeStartHour,
							   TradeStartMinute,
							   TradeEndDay,
							   TradeEndHour,
							   TradeEndMinute );
	} else {
		scheduler::reset_trade ();
	}

	if ( define_check_new_position_pause ( 1 )
			|| define_check_new_position_pause ( 2 )
			|| define_check_new_position_pause ( 3 )
			|| define_check_new_position_pause ( 4 )
			|| define_check_new_position_pause ( 5 )
			|| define_check_new_position_pause ( 6 )
			|| define_check_new_position_pause ( 7 )
			|| define_check_new_position_pause ( 8 )
			|| define_check_new_position_pause ( 9 )
			|| define_check_new_position_pause ( 10 ) ) {
		scheduler::set_new_position_pause ( defines_put_new_position_pause ( 1 ),
											defines_put_new_position_pause ( 2 ),
											defines_put_new_position_pause ( 3 ),
											defines_put_new_position_pause ( 4 ),
											defines_put_new_position_pause ( 5 ),
											defines_put_new_position_pause ( 6 ),
											defines_put_new_position_pause ( 7 ),
											defines_put_new_position_pause ( 8 ),
											defines_put_new_position_pause ( 9 ),
											defines_put_new_position_pause ( 10 )  );
	} else {
		scheduler::reset_new_position_pause();
	}

	if ( define_check_trade_pause ( 1 )
			|| define_check_trade_pause ( 2 )
			|| define_check_trade_pause ( 3 )
			|| define_check_trade_pause ( 4 )
			|| define_check_trade_pause ( 5 )
			|| define_check_trade_pause ( 6 )
			|| define_check_trade_pause ( 7 )
			|| define_check_trade_pause ( 8 )
			|| define_check_trade_pause ( 9 )
			|| define_check_trade_pause ( 10 ) ) {
		scheduler::set_trade_pause ( defines_put_trade_pause ( 1 ),
									 defines_put_trade_pause ( 2 ),
									 defines_put_trade_pause ( 3 ),
									 defines_put_trade_pause ( 4 ),
									 defines_put_trade_pause ( 5 ),
									 defines_put_trade_pause ( 6 ),
									 defines_put_trade_pause ( 7 ),
									 defines_put_trade_pause ( 8 ),
									 defines_put_trade_pause ( 9 ),
									 defines_put_trade_pause ( 10 )  );
	} else {
		scheduler::reset_trade_pause();
	}

	if ( define_check_intraday ( 1 )
			|| define_check_intraday ( 2 )
			|| define_check_intraday ( 3 )
			|| define_check_intraday ( 4 )
			|| define_check_intraday ( 5 )
			|| define_check_intraday ( 6 )
			|| define_check_intraday ( 7 )
			|| define_check_intraday ( 8 )
			|| define_check_intraday ( 9 )
			|| define_check_intraday ( 10 ) ) {
		scheduler::set_intraday ( define_put_intraday ( 1 ),
								  define_put_intraday ( 2 ),
								  define_put_intraday ( 3 ),
								  define_put_intraday ( 4 ),
								  define_put_intraday ( 5 ),
								  define_put_intraday ( 6 ),
								  define_put_intraday ( 7 ),
								  define_put_intraday ( 8 ),
								  define_put_intraday ( 9 ),
								  define_put_intraday ( 10 ) );
	} else {
		scheduler::reset_intraday();
	}

	if ( define_check_intraday_stop_trade ( 1 )
			|| define_check_intraday_stop_trade ( 2 )
			|| define_check_intraday_stop_trade ( 3 )
			|| define_check_intraday_stop_trade ( 4 )
			|| define_check_intraday_stop_trade ( 5 )
			|| define_check_intraday_stop_trade ( 6 )
			|| define_check_intraday_stop_trade ( 7 )
			|| define_check_intraday_stop_trade ( 8 )
			|| define_check_intraday_stop_trade ( 9 )
			|| define_check_intraday_stop_trade ( 10 ) ) {
		scheduler::set_intraday_stop_trade ( define_put_intraday_stop_trade ( 1 ),
											 define_put_intraday_stop_trade ( 2 ),
											 define_put_intraday_stop_trade ( 3 ),
											 define_put_intraday_stop_trade ( 4 ),
											 define_put_intraday_stop_trade ( 5 ),
											 define_put_intraday_stop_trade ( 6 ),
											 define_put_intraday_stop_trade ( 7 ),
											 define_put_intraday_stop_trade ( 8 ),
											 define_put_intraday_stop_trade ( 9 ),
											 define_put_intraday_stop_trade ( 10 ) );
	} else {
		scheduler::reset_intraday_stop_trade();
	}

	if ( CloseAllOrders_EveryDay_Hour != 0
			|| CloseAllOrders_EveryDay_Minute != 0 ) {
		scheduler::set_close_all_orders ( CloseAllOrders_EveryDay_Hour,
										  CloseAllOrders_EveryDay_Minute );
	} else {
		scheduler::reset_close_all_orders();
	}
}

#endif