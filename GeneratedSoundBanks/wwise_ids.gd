class_name AK

class EVENTS:

	const PLAYDASH = 1030691167
	const ENEMYDEATH = 3249137159
	const PLAYMUSIC = 417627684
	const PLAYDEATHENEMY = 3583473913
	const PLAYSEESAWDAMAGE = 1741543648
	const PLAYSEESAWDESTROYED = 3408267172
	const PLAYJUMP = 1717476791
	const PLAYSTAR = 373361795
	const PLAYDASHREPLENISH = 895721019
	const PLAYSMASH = 1977629621
	const PLAYCHANGEMUSICVOLUME = 3992794850
	const PLAYWACKERPLACE = 3345699297
	const PLAYTICK = 228694372
	const PLAYWACKERDISAPPEAR = 2441673863
	const PLAYCHANGESFXVOLUME = 3964040170

	const _dict = {
		"playDash": PLAYDASH,
		"enemyDeath": ENEMYDEATH,
		"playMusic": PLAYMUSIC,
		"playDeathEnemy": PLAYDEATHENEMY,
		"playSeesawDamage": PLAYSEESAWDAMAGE,
		"playSeesawDestroyed": PLAYSEESAWDESTROYED,
		"playJump": PLAYJUMP,
		"playStar": PLAYSTAR,
		"playDashReplenish": PLAYDASHREPLENISH,
		"playSmash": PLAYSMASH,
		"playChangeMusicVolume": PLAYCHANGEMUSICVOLUME,
		"playWackerPlace": PLAYWACKERPLACE,
		"playTick": PLAYTICK,
		"playWackerDisappear": PLAYWACKERDISAPPEAR,
		"playChangeSFXVolume": PLAYCHANGESFXVOLUME
	}

class STATES:

	class GAMESTATE:
		const GROUP = 4091656514

		class STATE:
			const BATTLE = 2937832959
			const GAMEOVER = 4158285989
			const MENU = 2607556080
			const NONE = 748895195

	class NEW_STATE_GROUP:
		const GROUP = 2012657067

		class STATE:
			const NONE = 748895195

	const _dict = {
		"gamestate": {
			"GROUP": 4091656514,
			"STATE": {
				"battle": 2937832959,
				"gameover": 4158285989,
				"menu": 2607556080,
				"None": 748895195
			}
		},
		"New_State_Group": {
			"GROUP": 2012657067,
			"STATE": {
				"None": 748895195,
			}
		}
	}

class SWITCHES:

	class HP:
		const GROUP = 1769415205

		class SWITCH:
			const LOWHP = 624013381
			const HIGHHP = 372966353
			const MIDHP = 2947131305

	class JUMP:
		const GROUP = 3833651337

		class SWITCH:
			const SECOND = 3476314365
			const THIRD = 931160808
			const FIRST = 998496889

	class POSITIONCRASHSEESAW:
		const GROUP = 3094881801

		class SWITCH:
			const MID = 1182670505
			const CLOSE = 1451272583
			const FAR = 1183803292

	const _dict = {
		"HP": {
			"GROUP": 1769415205,
			"SWITCH": {
				"lowHP": 624013381,
				"highHP": 372966353,
				"midHP": 2947131305,
			}
		},
		"jump": {
			"GROUP": 3833651337,
			"SWITCH": {
				"second": 3476314365,
				"third": 931160808,
				"first": 998496889,
			}
		},
		"positionCrashSeesaw": {
			"GROUP": 3094881801,
			"SWITCH": {
				"mid": 1182670505,
				"close": 1451272583,
				"far": 1183803292
			}
		}
	}

class GAME_PARAMETERS:

	const SS_AIR_TURBULENCE = 4160247818
	const SS_AIR_MONTH = 2648548617
	const SS_AIR_TIMEOFDAY = 3203397129
	const SS_AIR_RPM = 822163944
	const SS_AIR_PRESENCE = 3847924954
	const SEESAWLENGTH = 41331145
	const SS_AIR_FEAR = 1351367891
	const SS_AIR_STORM = 3715662592
	const SS_AIR_FREEFALL = 3002758120
	const SS_AIR_FURY = 1029930033
	const SS_AIR_SIZE = 3074696722
	const MUSICVOLUME = 2346531308
	const SFXVOLUME = 988953028
	const POSITIONFROMSEESAW = 1422592600

	const _dict = {
		"SS_Air_Turbulence": SS_AIR_TURBULENCE,
		"SS_Air_Month": SS_AIR_MONTH,
		"SS_Air_TimeOfDay": SS_AIR_TIMEOFDAY,
		"SS_Air_RPM": SS_AIR_RPM,
		"SS_Air_Presence": SS_AIR_PRESENCE,
		"seesawLength": SEESAWLENGTH,
		"SS_Air_Fear": SS_AIR_FEAR,
		"SS_Air_Storm": SS_AIR_STORM,
		"SS_Air_Freefall": SS_AIR_FREEFALL,
		"SS_Air_Fury": SS_AIR_FURY,
		"SS_Air_Size": SS_AIR_SIZE,
		"MusicVolume": MUSICVOLUME,
		"SFXVolume": SFXVOLUME,
		"positionFromSeesaw": POSITIONFROMSEESAW
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
	const SFX = 393239870
	const MUSIC = 3991942870

	const _dict = {
		"Master Audio Bus": MASTER_AUDIO_BUS,
		"SFX": SFX,
		"Music": MUSIC
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

