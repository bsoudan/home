#include QMK_KEYBOARD_H
#if __has_include("keymap.h")
#    include "keymap.h"
#endif

enum custom_keycodes {
  ALT_TAB = SAFE_RANGE,
  CTL_TAB,
  LMOD,
  RMOD
};

#define LNUM LT(2, KC_TAB)

#include "g/keymap_combo.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT(
        KC_QUOT, KC_COMM, KC_DOT, KC_P,  KC_Y,                  KC_F,   KC_G,  KC_C,  KC_R,  KC_L,
        KC_A,    KC_O,    KC_E,   KC_U,  KC_I,                  KC_D,   KC_H,  KC_T,  KC_N,  KC_S,
        KC_SCLN, KC_Q,    KC_J,   KC_K,  KC_X,  KC_NO,   KC_NO, KC_B,   KC_M,  KC_W,  KC_V,  KC_Z,
        MO(4),   KC_NO,   KC_NO,  LMOD,  MO(3),  MO(1),   LNUM,  KC_SPC, RMOD,  KC_NO, KC_NO, MO(4)
    ),
    // sym layer
    [1] = LAYOUT(
        KC_GRV,  KC_LT,   KC_GT,   KC_DLR,  KC_PERC,                     KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_SLSH,
        KC_EXLM, KC_AT,   KC_HASH, KC_DQUO, KC_COLN,                     KC_EQL,  KC_MINS, KC_LCBR, KC_RCBR, KC_QUES,
        LCTL_T(KC_COLN),  LSFT_T(KC_BSLS),   LGUI_T(KC_BSLS), LALT_T(KC_TILDE), KC_CIRC,  _______,   _______, KC_PLUS, RALT_T(KC_UNDS), RGUI_T(KC_LBRC), RSFT_T(KC_RBRC), RCTL_T(KC_PIPE),
        _______,  _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),
    // num layer
    [2] = LAYOUT(
        KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                       KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,
        KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                        KC_6,    KC_7,    KC_8,    KC_9,    KC_0,
        KC_LSFT, KC_LCTL, KC_LGUI, KC_LALT, KC_F11,  _______,   _______, KC_F12,  KC_RALT, KC_RGUI, KC_RCTL, KC_RSFT,
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),
    // nav layer
    [3] = LAYOUT(
        KC_ESC, ALT_TAB,    LCTL(KC_C),    LCTL(KC_V), KC_BTN3,                                KC_ESC,  KC_PGUP,   KC_UP, KC_PGDN, KC_NO,
        LALT(KC_1), LALT(KC_2), LALT(KC_3), LALT(KC_4), LALT(KC_5),                            KC_NO,  KC_LEFT, KC_DOWN, KC_RGHT,     KC_NO,
        KC_LSFT,      KC_LCTL,    KC_LGUI,    KC_LALT,      KC_ENTER,     _______,   _______, LSFT(KC_Y),  KC_HOME,   KC_NO,  KC_END, LCTL(KC_Z),
        _______,      _______,    _______,    _______,      _______,      _______,   _______,      _______,  _______, _______, _______,      _______
    ),
    // ctl layer
    [4] = LAYOUT(
        KC_SYSTEM_SLEEP, _______, KC_PRINT_SCREEN, KC_SCROLL_LOCK, KC_PAUSE,                     KC_AUDIO_MUTE, _______, KC_AUDIO_VOL_UP, _______, KC_BRIGHTNESS_UP,
        _______, _______, KC_INSERT, _______, _______,                     _______, KC_MEDIA_PREV_TRACK, KC_AUDIO_VOL_DOWN, KC_MEDIA_NEXT_TRACK, KC_BRIGHTNESS_DOWN,
        KC_LSFT, KC_LCTL, KC_LGUI, KC_LALT, _______, _______,   _______, _______, KC_RALT, RGUI_T(KC_MEDIA_PLAY_PAUSE), RSFT_T(KC_MEDIA_STOP), KC_RSFT,
        KC_SYSTEM_SLEEP, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, QK_BOOT
    ),
    // lmod layer
    [5] = LAYOUT(
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        LCTL_T(KC_SCLN), LSFT_T(KC_Q), LGUI_T(KC_J), LALT_T(KC_K), _______, _______,   _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),
    // go layer
    [6] = LAYOUT(
        LALT(KC_1), LALT(KC_2), LALT(KC_3), LALT(KC_4), _______,                     _______, _______, _______, _______, _______,
        LWIN(KC_1), LWIN(KC_2), LWIN(KC_3), LWIN(KC_4), _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),
    // rmod layer -- needs to be 7 due to some weird bug with combo definitions
    [7] = LAYOUT(
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,   _______, _______, RALT_T(KC_M), RGUI_T(KC_W), RSFT_T(KC_V), RCTL_T(KC_Z),
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),
    /*
    // empty layer
    [7] = LAYOUT(
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    )
    */
};


// https://www.reddit.com/r/MechanicalKeyboards/comments/mrnxrj/better_super_alttab/

bool is_alt_tab_active = false;
bool is_ctl_tab_active = false;
bool lmod_active = false;
bool rmod_active = false;
bool nav_tap = false;

layer_state_t layer_state_set_user(layer_state_t state) {
    if (is_alt_tab_active) {
        unregister_code(KC_LALT);
        is_alt_tab_active = false;
    }
    if (is_ctl_tab_active) {
        unregister_code(KC_LCTL);
        is_ctl_tab_active = false;
    }
    return state;
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (!record->event.pressed) {
        clear_oneshot_layer_state(ONESHOT_PRESSED);
    }

    if (keycode == MO(3)) {
        if (record->event.pressed) {
            nav_tap = true;
            return true;
        } else if (nav_tap) {
            set_oneshot_layer(6, ONESHOT_START);
            nav_tap = false;
            return true;
        }
    }

    nav_tap = false;

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
        case CTL_TAB: // super alt tab macro
            if (record->event.pressed) {
                if (!is_ctl_tab_active) {
                    is_ctl_tab_active = true;
                    register_code(KC_LCTL);
                }
                register_code(KC_TAB);
            } else {
                unregister_code(KC_TAB);
            }
            return false;
        case LMOD: // left mod layer
            if (record->event.pressed) {
                register_code(KC_LSFT);
                layer_on(5);
                lmod_active = true;
            } else {
                unregister_code(KC_LSFT);
                layer_off(5);
                lmod_active = false;
            }
            return false;
        case RMOD: // left mod layer
            if (record->event.pressed) {
                register_code(KC_RSFT);
                layer_on(7);
                rmod_active = true;
            } else {
                unregister_code(KC_RSFT);
                layer_off(7);
                rmod_active = false;
            }
            return false;
        case RALT_T(KC_UNDS):
            if (record->tap.count && record->event.pressed) {
                register_code16(KC_UNDS);
                return false;
            }
            break;
        case LALT_T(KC_TILDE):
            if (record->tap.count && record->event.pressed) {
                register_code16(KC_TILDE);
                return false;
            }
            break;
        case RCTL_T(KC_PIPE):
            if (record->tap.count && record->event.pressed) {
                register_code16(KC_PIPE);
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

    if (is_ctl_tab_active && keycode != KC_LEFT && keycode != KC_RIGHT) {
        unregister_code(KC_LCTL);
        is_ctl_tab_active = false;
        if (keycode == KC_ENTER) {
            return false;
        }
    }


    if (IS_LAYER_ON(5) && lmod_active) {
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

    if (IS_LAYER_ON(7) && rmod_active) {
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

bool get_retro_tapping(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LNUM:
            return true;
        default:
            return false;
    }
}

#if defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {

};
#endif // defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)

