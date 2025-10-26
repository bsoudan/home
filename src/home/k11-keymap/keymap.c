/* Copyright 2024 @ Keychron (https://www.keychron.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H
#include "keychron_common.h"

enum layers{
    QWERTY,
    DVORAK,
    SYMBOL,
    NUM,
    NAV,
    CTL,
};

//#include "g/keymap_combo.h"

// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [QWERTY] = LAYOUT_69_ansi(
        KC_ESC,  KC_1,    KC_2,    KC_3,   KC_4,    KC_5, KC_6,   /**/                    KC_7, KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_BSPC, KC_MUTE,
        KC_TAB,  KC_Q,    KC_W,    KC_E,   KC_R,    KC_T,         /**/           KC_Y,    KC_U, KC_I,    KC_O,    KC_P,    KC_LBRC, KC_RBRC, KC_BSLS, KC_PGUP,
        MO(NAV), KC_A,    KC_S,    KC_D,   KC_F,    KC_G,         /**/           KC_H,    KC_J, KC_K,    KC_L,    KC_SCLN, KC_QUOT,          KC_ENT,  KC_PGDN,
        KC_LSFT, KC_Z,    KC_X,    KC_C,   KC_V,    KC_B,         /**/  MO(CTL), KC_N,    KC_M, KC_COMM, KC_DOT,  KC_SLSH,          KC_RSFT, KC_UP,
        KC_LCTL, KC_LWIN, KC_LALT, KC_SPC,          MO(SYMBOL),   /**/  MO(NUM), KC_SPC,                 KC_RCTL,                   KC_LEFT, KC_DOWN, KC_RGHT),

    [DVORAK] = LAYOUT_69_ansi(
        KC_ESC,  KC_1,    KC_2,    KC_3,   KC_4,    KC_5, KC_6,   /**/                    KC_7, KC_8,    KC_9,    KC_0,    KC_LBRC, KC_RBRC, KC_BSPC, KC_MUTE,
        KC_TAB,  KC_QUOT, KC_COMM, KC_DOT, KC_P,    KC_Y,         /**/           KC_F,    KC_G, KC_C,    KC_R,    KC_L,    KC_SLSH, KC_EQL,  KC_BSLS, KC_PGUP,
        MO(NAV), KC_A,    KC_O,    KC_E,   KC_U,    KC_I,         /**/           KC_D,    KC_H, KC_T,    KC_N,    KC_S,    KC_MINS,          KC_ENT,  KC_PGDN,
        KC_LSFT, KC_SCLN, KC_Q,    KC_J,   KC_K,    KC_X,         /**/  MO(CTL), KC_B,    KC_M, KC_W,    KC_V,    KC_Z,             KC_RSFT, KC_UP,
        KC_LCTL, KC_LWIN, KC_LALT, KC_SPC,          MO(SYMBOL),   /**/  MO(NUM), KC_SPC,                 KC_RCTL,                   KC_LEFT, KC_DOWN, KC_RGHT),

    [SYMBOL] = LAYOUT_69_ansi(
        _______, _______, _______, _______, _______,  _______, _______,  /**/                    _______, _______, _______, _______, _______, _______, KC_DEL,  _______,
        _______, KC_GRV,  KC_LT,   KC_GT,   KC_DLR,   KC_PERC,           /**/           KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_SLSH, _______, _______, _______, KC_HOME,
        _______, KC_EXLM, KC_AT,   KC_HASH, KC_DQUO,  KC_COLN,           /**/           KC_EQL,  KC_MINS, KC_LCBR, KC_RCBR, KC_QUES, _______,          _______, KC_END,
        _______, KC_COLN, KC_BSLS, KC_BSLS, KC_TILDE, KC_CIRC,           /**/  _______, KC_PLUS, KC_UNDS, KC_LBRC, KC_RBRC, KC_PIPE,          _______, _______,
        _______, _______, _______, _______,           _______,           /**/  _______, _______,                   _______,                   _______, _______, _______),

    [NUM] = LAYOUT_69_ansi(
        _______, _______, _______, _______, _______,  _______, _______,  /**/                    _______, _______, _______, _______, _______, _______, _______, _______,
        _______, KC_F1,   KC_F2,   KC_F3,   KC_F4,    KC_F5,             /**/           KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  _______, _______, _______, KC_HOME,
        _______, KC_1,    KC_2,    KC_3,    KC_4,     KC_5,              /**/           KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    _______,          _______, KC_END,
        _______, _______, _______, _______, _______,  KC_F11,            /**/  KC_F12,  _______, _______, _______, _______, _______,          _______, _______,
        _______, _______, _______, _______,           _______,           /**/  _______, _______,                   _______,                   _______, _______, _______),

#define COPY LCTL(KC_C)
#define PASTE LCTL(KC_V)
#define MOUSE3 KC_BTN3

#define ALT_1 LALT(KC_1)
#define ALT_2 LALT(KC_2)
#define ALT_3 LALT(KC_3)
#define ALT_4 LALT(KC_4)
#define ALT_5 LALT(KC_5)

    [NAV] = LAYOUT_69_ansi(
        _______, _______, _______, _______, _______, _______, _______,  /**/                    _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, COPY,    PASTE,   MOUSE3,            /**/           KC_ESC,  KC_PGUP, KC_UP,   KC_PGDN, _______, _______, _______, _______, _______,
        _______, ALT_1,   ALT_2,   ALT_3,   ALT_4,   ALT_5,             /**/           _______, KC_LEFT, KC_DOWN, KC_RGHT, _______, _______,          _______, _______,
        _______, _______, _______, _______, _______, _______,           /**/  _______, _______, KC_HOME, _______, KC_END,  _______,          _______, _______,
        _______, _______, _______, _______,          _______,           /**/  _______, _______,                   _______,                   _______, _______, _______),

        /* BAT_LVL, ALT_TAB */

#define VOL_UP  KC_AUDIO_VOL_UP
#define VOL_DN  KC_AUDIO_VOL_DOWN
#define MUTE    KC_AUDIO_MUTE
#define PREVTRK KC_MEDIA_PREV_TRACK
#define NEXTTRK KC_MEDIA_NEXT_TRACK
#define PLAY    KC_MEDIA_PLAY_PAUSE
#define STOP    KC_MEDIA_STOP
#define SLEEP   KC_SYSTEM_SLEEP
#define BR_UP   KC_BRIGHTNESS_UP
#define BR_DN   KC_BRIGHTNESS_DOWN

    [CTL] = LAYOUT_69_ansi(
        _______, BT_HST1, BT_HST2, BT_HST3, P2P4G,   _______, _______,  /**/                    _______, _______, _______, _______, _______, _______, _______, RGB_TOG,
        _______, _______, _______, _______, _______, _______,           /**/           STOP,    PLAY,    VOL_UP,  _______, BR_UP,   _______, _______, _______, RGB_MOD,
        _______, _______, _______, _______, _______, _______,           /**/           _______, PREVTRK, VOL_DN,  NEXTTRK, BR_DN,   _______,          _______, RGB_RMOD,
        _______, _______, _______, _______, _______, SLEEP,             /**/  _______, _______, _______, MUTE,    _______, _______,          _______, _______,
        _______, _______, _______, _______,          _______,           /**/  _______, _______,                   _______,                   _______, _______, QK_BOOT),
/*
         RGB_HUI, RGB_SAI, RGB_SPI,  
         RGB_HUD, RGB_SAD, RGB_SPD,  NK_TOGG, */

    // [] = LAYOUT_69_ansi(
        // _______, _______, _______, _______, _______, _______, _______,  /**/                    _______, _______, _______, _______, _______, _______, _______, _______,
        // _______, _______, _______, _______, _______, _______,           /**/           _______, _______, _______, _______, _______, _______, _______, _______, _______,
        // _______, _______, _______, _______, _______, _______,           /**/           _______, _______, _______, _______, _______, _______,          _______, _______,
        // _______, _______, _______, _______, _______, _______,           /**/  _______, _______, _______, _______, _______, _______,          _______, _______,
        // _______, _______, _______, _______,          _______,           /**/  _______, _______,                   _______,                   _______, _______, _______),

/*        KC_SYSTEM_SLEEP, _______, KC_PRINT_SCREEN, KC_SCROLL_LOCK, KC_PAUSE,                     KC_AUDIO_MUTE, _______, KC_AUDIO_VOL_UP, _______, KC_BRIGHTNESS_UP,
        _______, _______, KC_INSERT, _______, _______,                     _______, KC_MEDIA_PREV_TRACK, KC_AUDIO_VOL_DOWN, KC_MEDIA_NEXT_TRACK, KC_BRIGHTNESS_DOWN,
        KC_LSFT, KC_LCTL, KC_LGUI, KC_LALT, _______, _______,   _______, _______, KC_RALT, RGUI_T(KC_MEDIA_PLAY_PAUSE), RSFT_T(KC_MEDIA_STOP), KC_RSFT,
        KC_SYSTEM_SLEEP, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, QK_BOOT*/
};

#if defined(ENCODER_MAP_ENABLE)
	const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][2] = {
		[QWERTY] = {ENCODER_CCW_CW(KC_VOLD, KC_VOLU)},
		[DVORAK] = {ENCODER_CCW_CW(KC_VOLD, KC_VOLU)},
		[SYMBOL] = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
		[NUM]    = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
		[NAV]	 = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
		[CTL]	 = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
	};
#endif // ENCODER_MAP_ENABLE

// clang-format on
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (!process_record_keychron_common(keycode, record)) {
        return false;
    }
    return true;
}
