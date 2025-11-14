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

enum custom_keycodes {
  ALT_TAB = SAFE_RANGE,
  LMOD,
  RMOD
};

enum layers {
    L_DVO = 0,
    L_QRT,
    L_SYM,
    L_NUM,
    L_NAV,
    L_CTL,
    L_LMOD, // not defined for k11
    L_RMOD  // not defined for k11
};

// compat for older qmk
#define KC_PRSC KC_PRINT_SCREEN
#define MS_BTN3 KC_BTN3

#define SYM LT(L_SYM, KC_SPC)
#define NUM LT(L_NUM, KC_TAB)
#define NAV MO(L_NAV)
#define CTL MO(L_CTL)

#define L1(x) LCTL_T(KC_##x)
#define L2(x) LSFT_T(KC_##x)
#define L3(x) LGUI_T(KC_##x)
#define L4(x) LALT_T(KC_##x)

#define R1(x) RCTL_T(KC_##x)
#define R2(x) RSFT_T(KC_##x)
#define R3(x) RGUI_T(KC_##x)
#define R4(x) RALT_T(KC_##x)


//#include "g/keymap_combo.h"

// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [L_DVO] = LAYOUT_69_ansi(
        KC_ESC,  KC_1,    KC_2,    KC_3,   KC_4,    KC_5, KC_6,   /**/                    KC_7, KC_8,    KC_9,    KC_0,    KC_LBRC, KC_RBRC, KC_BSPC, KC_MUTE,
        KC_TAB,  KC_QUOT, KC_COMM, KC_DOT, KC_P,    KC_Y,         /**/           KC_F,    KC_G, KC_C,    KC_R,    KC_L,    KC_SLSH, KC_EQL,  KC_BSLS, KC_PGUP,
        MO(NAV), KC_A,    KC_O,    KC_E,   KC_U,    KC_I,         /**/           KC_D,    KC_H, KC_T,    KC_N,    KC_S,    KC_MINS,          KC_ENT,  KC_PGDN,
        KC_LSFT, KC_SCLN, KC_Q,    KC_J,   KC_K,    KC_X,         /**/      CTL, KC_B,    KC_M, KC_W,    KC_V,    KC_Z,             KC_RSFT, KC_UP,
        KC_LCTL, KC_LWIN, KC_LALT, SYM,             NAV,          /**/      NUM, KC_SPC,                 KC_RCTL,                   KC_LEFT, KC_DOWN, KC_RGHT),

    [L_QRT] = LAYOUT_69_ansi(
        KC_ESC,  KC_1,    KC_2,    KC_3,   KC_4,    KC_5, KC_6,   /**/                    KC_7, KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_BSPC, KC_MUTE,
        KC_TAB,  KC_Q,    KC_W,    KC_E,   KC_R,    KC_T,         /**/           KC_Y,    KC_U, KC_I,    KC_O,    KC_P,    KC_LBRC, KC_RBRC, KC_BSLS, KC_PGUP,
        MO(NAV), KC_A,    KC_S,    KC_D,   KC_F,    KC_G,         /**/           KC_H,    KC_J, KC_K,    KC_L,    KC_SCLN, KC_QUOT,          KC_ENT,  KC_PGDN,
        KC_LSFT, KC_Z,    KC_X,    KC_C,   KC_V,    KC_B,         /**/      CTL, KC_N,    KC_M, KC_COMM, KC_DOT,  KC_SLSH,          KC_RSFT, KC_UP,
        KC_LCTL, KC_LWIN, KC_LALT, KC_SPC,          NAV,          /**/      NUM, KC_SPC,                 KC_RCTL,                   KC_LEFT, KC_DOWN, KC_RGHT),

    [L_SYM] = LAYOUT_69_ansi(
        _______, _______,  _______,  _______,  _______,   _______, _______,  /**/                     _______,  _______,  _______,  _______, _______, _______, KC_DEL,  _______,
        _______, KC_GRV,   KC_LT,    KC_GT,    KC_DLR,    KC_PERC,           /**/           KC_AMPR,  KC_ASTR,  KC_LPRN,  KC_RPRN,  KC_SLSH, _______, _______, _______, KC_HOME,
        _______, KC_EXLM,  KC_AT,    KC_HASH,  KC_DQUO,   KC_COLN,           /**/           KC_EQL,   KC_MINS,  KC_LCBR,  KC_RCBR,  KC_QUES, _______,          _______, KC_END,
        _______, L1(COLN), L2(BSLS), L3(BSLS), L4(TILDE), KC_CIRC,           /**/  _______, KC_PLUS, R4(UNDS), R3(LBRC), R2(RBRC), R1(PIPE),          _______, _______,
        _______, _______,  _______,  _______,             _______,           /**/  _______, _______,                      _______,                    _______, _______, _______),

    [L_NUM] = LAYOUT_69_ansi(
        _______, _______, _______, _______, _______,  _______, _______,  /**/                    _______, _______, _______, _______, _______, _______, _______, _______,
        _______, KC_F1,   KC_F2,   KC_F3,   KC_F4,    KC_F5,             /**/             KC_F6,   KC_F7,   KC_F8,   KC_F9,  KC_F10, _______, _______, _______, KC_HOME,
        _______, KC_1,    KC_2,    KC_3,    KC_4,     KC_5,              /**/              KC_6,    KC_7,    KC_8,    KC_9,    KC_0, _______,          _______, KC_END,
        _______, KC_LCTL, KC_LSFT, KC_LGUI, KC_LALT,  KC_F11,            /**/  KC_F12,  KC_RALT, KC_RGUI, KC_RSFT, KC_RCTL, _______,          _______, _______,
        _______, _______, _______, _______,           _______,           /**/  _______, _______,                   _______,                   _______, _______, _______),

#define NAV_UNDO  L1(P1)
#define NAV_CUT   L2(P2)
#define NAV_COPY  L3(P3)
#define NAV_PASTE L4(P4)
#define NAV_REDO  LCTL(KC_Y)

    [L_NAV] = LAYOUT_69_ansi(
        _______, _______,    _______,    _______,    _______,    _______, _______,  /**/                    _______, _______, _______, _______, _______, _______, _______, _______,
        _______, LGUI(KC_1), LGUI(KC_2), LGUI(KC_3), LGUI(KC_4), ALT_TAB,           /**/           KC_ESC,  KC_PGUP, KC_UP,   KC_PGDN, KC_PRSC, _______, _______, _______, _______,
        _______, LALT(KC_1), LALT(KC_2), LALT(KC_3), LALT(KC_4), LALT(KC_5),        /**/           _______, KC_LEFT, KC_DOWN, KC_RGHT, KC_INS,  _______,          _______, _______,
        _______, NAV_UNDO,   NAV_CUT,    NAV_COPY,   NAV_PASTE,  MS_BTN3,           /**/  _______, _______, KC_HOME, _______, KC_END,  KC_PAUS,          _______, _______,
        _______, NAV_REDO,   _______,    _______,                _______,           /**/  _______, _______,                   _______,                   _______, _______, _______),

    [L_CTL] = LAYOUT_69_ansi(
        _______, _______, _______, _______, _______, _______, _______,  /**/                    _______, _______, _______, _______, _______, _______, _______, RGB_TOG,
        BAT_LVL, BT_HST1, BT_HST2, BT_HST3, P2P4G,   _______,           /**/           KC_MSTP, KC_MPLY, KC_VOLU, _______, KC_BRIU, _______, _______, _______, RGB_MOD,
        NK_TOGG, _______, _______, _______, _______, _______,           /**/           _______, KC_MPRV, KC_VOLD, KC_MNXT, KC_BRID, _______,          RGB_SPI, RGB_RMOD,
        _______, KC_LCTL, KC_LSFT, KC_LGUI, KC_LALT, KC_SLEP,           /**/  _______, _______, _______, KC_MUTE, _______, _______,          RGB_SPD, RGB_SAD,
        QK_BOOT, _______, _______, _______,          _______,           /**/  _______, _______,                   _______,                   RGB_HUD, RGB_SAI, RGB_HUI),

    // [] = LAYOUT_69_ansi(
        // _______, _______, _______, _______, _______, _______, _______,  /*7 8*/                    _______, _______, _______, _______, _______, _______, _______, _______,
        // _______, _______, _______, _______, _______, _______,           /*6 9*/           _______, _______, _______, _______, _______, _______, _______, _______, _______,
        // _______, _______, _______, _______, _______, _______,           /*6 8*/           _______, _______, _______, _______, _______, _______,          _______, _______,
        // _______, _______, _______, _______, _______, _______,           /*6 8*/  _______, _______, _______, _______, _______, _______,          _______, _______,
        // _______, _______, _______, _______,          _______,           /*5 6*/  _______, _______,                   _______,                   _______, _______, _______),



/*        KC_SYSTEM_SLEEP, _______, KC_PRINT_SCREEN, KC_SCROLL_LOCK, KC_PAUSE,                     KC_AUDIO_MUTE, _______, KC_AUDIO_VOL_UP, _______, KC_BRIGHTNESS_UP,
        _______, _______, KC_INSERT, _______, _______,                     _______, KC_MEDIA_PREV_TRACK, KC_AUDIO_VOL_DOWN, KC_MEDIA_NEXT_TRACK, KC_BRIGHTNESS_DOWN,
        KC_LSFT, KC_LCTL, KC_LGUI, KC_LALT, _______, _______,   _______, _______, KC_RALT, RGUI_T(KC_MEDIA_PLAY_PAUSE), RSFT_T(KC_MEDIA_STOP), KC_RSFT,
        KC_SYSTEM_SLEEP, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, QK_BOOT*/
};

#if defined(ENCODER_MAP_ENABLE)
	const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][2] = {
		[L_QRT] = {ENCODER_CCW_CW(KC_VOLD, KC_VOLU)},
		[L_DVO] = {ENCODER_CCW_CW(KC_VOLD, KC_VOLU)},
		[L_SYM] = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
		[L_NUM] = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
		[L_NAV]	 = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
		[L_CTL]	 = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
	};
#endif // ENCODER_MAP_ENABLE

// clang-format on

// https://www.reddit.com/r/MechanicalKeyboards/comments/mrnxrj/better_super_alttab/

bool is_alt_tab_active = false;
bool lmod_active = false;
bool rmod_active = false;

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (!process_record_keychron_common(keycode, record)) {
        return false;
    }

    switch (keycode){
        case ALT_TAB: // super alt tab macro
            if (record->event.pressed) {
                if (!is_alt_tab_active) {
                    is_alt_tab_active = true;
                    register_code(KC_LALT);
                }
                register_code(KC_TAB);
            } else {
                unregister_code(KC_TAB);
            }
            return false;
        case LMOD: // left mod layer
            if (record->event.pressed) {
                register_code(KC_LSFT);
                layer_on(L_LMOD);
                lmod_active = true;
            } else {
                unregister_code(KC_LSFT);
                layer_off(L_LMOD);
                lmod_active = false;
            }
            return false;
        case RMOD: // left mod layer
            if (record->event.pressed) {
                register_code(KC_RSFT);
                layer_on(L_RMOD);
                rmod_active = true;
            } else {
                unregister_code(KC_RSFT);
                layer_off(L_RMOD);
                rmod_active = false;
            }
            return false;
        case L1(COLN):
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_COLN);
                return false;
            }
            break;
        case L4(TILDE):
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_TILDE);
                return false;
            }
            break;
        case R4(UNDS):
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_UNDS);
                return false;
            }
            break;
        case R1(PIPE):
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_PIPE);
                return false;
            }
            break;
        case NAV_UNDO:
           if (record->event.pressed && record->tap.count) {
               tap_code16(LCTL(KC_Z));
               return false;
           }
           break;
        case NAV_CUT:
           if (record->event.pressed && record->tap.count) {
               tap_code16(LSFT(KC_DEL));
               return false;
           }
           break;
        case NAV_COPY:
           if (record->event.pressed && record->tap.count) {
               tap_code16(LCTL(KC_INS));
               return false;
           }
           break;
        case NAV_PASTE:
           if (record->event.pressed && record->tap.count) {
               tap_code16(LSFT(KC_INS));
               return false;
           }
           break;
    }

    if (is_alt_tab_active && keycode != KC_LEFT && keycode != KC_RIGHT) {
        unregister_code(KC_LALT);
        is_alt_tab_active = false;
        if (keycode == KC_ENTER) {
            return false;
        }
    }

    if (IS_LAYER_ON(L_LMOD) && lmod_active) {
        switch (keycode) {
            case LCTL_T(KC_SCLN):
            case LSFT_T(KC_Q):
            case LGUI_T(KC_J):
            case LALT_T(KC_K):
                if (!record->tap.count && record->event.pressed) {
                    unregister_code(KC_LSFT);
                    lmod_active = false;
                    return true;

                }
        }
    }

    if (IS_LAYER_ON(L_RMOD) && rmod_active) {
        switch (keycode) {
            case RALT_T(KC_M):
            case RGUI_T(KC_W):
            case RSFT_T(KC_V):
            case RCTL_T(KC_Z):
                if (!record->tap.count && record->event.pressed) {
                    unregister_code(KC_RSFT);
                    rmod_active = false;
                    return true;
                }
        }
    }

    return true;
}

layer_state_t layer_state_set_user(layer_state_t state) {
    if (is_alt_tab_active) {
        unregister_code(KC_LALT);
        is_alt_tab_active = false;
    }
    return state;
}

bool get_retro_tapping(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case NUM:
            return true;
        default:
            return false;
    }
}
