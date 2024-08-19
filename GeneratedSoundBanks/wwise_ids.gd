class_name AK

class EVENTS:

	const PLAYMUSIC = 417627684
	const ENEMYDEATH = 3249137159

	const _dict = {
		"playMusic": PLAYMUSIC,
		"enemyDeath": ENEMYDEATH
	}

class STATES:

	class NEW_STATE_GROUP:
		const GROUP = 2012657067

		class STATE:
			const NONE = 748895195

	class GAMESTATE:
		const GROUP = 4091656514

		class STATE:
			const NONE = 748895195
			const CREDITS = 2201105581
			const BATTLE = 2937832959
			const MENU = 2607556080

	const _dict = {
		"New_State_Group": {
			"GROUP": 2012657067,
			"STATE": {
				"None": 748895195
			}
		},
		"gamestate": {
			"GROUP": 4091656514,
			"STATE": {
				"None": 748895195,
				"credits": 2201105581,
				"battle": 2937832959,
				"menu": 2607556080,
			}
		}
	}

class SWITCHES:

	class HP:
		const GROUP = 1769415205

		class SWITCH:
			const HIGHHP = 372966353
			const MIDHP = 2947131305
			const LOWHP = 624013381

	const _dict = {
		"HP": {
			"GROUP": 1769415205,
			"SWITCH": {
				"highHP": 372966353,
				"midHP": 2947131305,
				"lowHP": 624013381
			}
		}
	}

class GAME_PARAMETERS:

	const SS_AIR_TIMEOFDAY = 3203397129
	const SS_AIR_PRESENCE = 3847924954
	const SS_AIR_FURY = 1029930033
	const SS_AIR_MONTH = 2648548617
	const SS_AIR_TURBULENCE = 4160247818
	const SEESAWLENGTH = 41331145
	const SS_AIR_FEAR = 1351367891
	const SS_AIR_SIZE = 3074696722
	const SS_AIR_STORM = 3715662592
	const SS_AIR_FREEFALL = 3002758120
	const SS_AIR_RPM = 822163944

	const _dict = {
		"SS_Air_TimeOfDay": SS_AIR_TIMEOFDAY,
		"SS_Air_Presence": SS_AIR_PRESENCE,
		"SS_Air_Fury": SS_AIR_FURY,
		"SS_Air_Month": SS_AIR_MONTH,
		"SS_Air_Turbulence": SS_AIR_TURBULENCE,
		"seesawLength": SEESAWLENGTH,
		"SS_Air_Fear": SS_AIR_FEAR,
		"SS_Air_Size": SS_AIR_SIZE,
		"SS_Air_Storm": SS_AIR_STORM,
		"SS_Air_Freefall": SS_AIR_FREEFALL,
		"SS_Air_RPM": SS_AIR_RPM
	}

class TRIGGERS:

	const ENEMYDEATH = 3249137159

	const _dict = {
		"enemyDeath": ENEMYDEATH
	}

class BANKS:

	const INIT = 1355168291
	const MAIN = 3161908922

	const _dict = {
		"Init": INIT,
		"Main": MAIN
	}

class BUSSES:

	const MASTER_AUDIO_BUS = 3803692087

	const _dict = {
		"Master Audio Bus": MASTER_AUDIO_BUS
	}

class AUX_BUSSES:

	const _dict = {}

class AUDIO_DEVICES:

	const SYSTEM = 3859886410
	const NO_OUTPUT = 2317455096

	const _dict = {
		"System": SYSTEM,
		"No_Output": NO_OUTPUT
	}

class EXTERNAL_SOURCES:

	const _dict = {}

