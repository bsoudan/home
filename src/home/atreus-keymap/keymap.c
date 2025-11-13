#include QMK_KEYBOARD_H
#if __has_include("keymap.h")
#    include "keymap.h"
#endif

enum custom_keycodes {
  ALT_TAB = SAFE_RANGE,
  LMOD,
  RMOD
};

enum layers {
    L_DV = 0,
    L_SYM,
    L_NUM,
    L_NAV,
    L_CTL,
    L_LMOD,
    L_RMOD
};

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

#include "g/keymap_combo.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [L_DV] = LAYOUT(
        KC_QUOT, KC_COMM, KC_DOT,  KC_P,    KC_Y,                           KC_F,    KC_G,    KC_C,    KC_R,    KC_L,
        KC_A,    KC_O,    KC_E,    KC_U,    KC_I,                           KC_D,    KC_H,    KC_T,    KC_N,    KC_S,
        KC_SCLN, KC_Q,    KC_J,    KC_K,    KC_X,    _______,       CTL,    KC_B,    KC_M,    KC_W,    KC_V,    KC_Z,
        CTL,     _______, _______, LMOD,    SYM,     NAV,           NUM,  KC_SPC,    RMOD, _______, _______, _______
    ),

    [L_SYM] = LAYOUT(
        KC_GRV,   KC_LT,    KC_GT,    KC_DLR,    KC_PERC,                     KC_AMPR,  KC_ASTR,  KC_LPRN,  KC_RPRN,  KC_SLSH,
        KC_EXLM,  KC_AT,    KC_HASH,  KC_DQUO,   KC_COLN,                      KC_EQL,  KC_MINS,  KC_LCBR,  KC_RCBR,  KC_QUES,
        L1(COLN), L2(BSLS), L3(BSLS), L4(TILDE), KC_CIRC, _______,   _______, KC_PLUS, R4(UNDS), R3(LBRC), R2(RBRC), R1(PIPE),
        _______,  _______,  _______,  _______,   _______, _______,   _______, _______,  _______,  _______,  _______,  _______
    ),

    [L_NUM] = LAYOUT(
        KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                         KC_F6,   KC_F7,   KC_F8,   KC_F9,  KC_F10,
        KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                           KC_6,    KC_7,    KC_8,    KC_9,    KC_0,
        KC_LCTL, KC_LSFT, KC_LGUI, KC_LALT, KC_F11,  _______,   _______,  KC_F12, KC_RALT, KC_RGUI, KC_RSFT, KC_RCTL,
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),

#define NAV_UNDO  L1(P1)
#define NAV_CUT   L2(P2)
#define NAV_COPY  L3(P3)
#define NAV_PASTE L4(P4)
#define NAV_REDO  LCTL(KC_Y)

    [L_NAV] = LAYOUT(
        LGUI(KC_1), LGUI(KC_2), LGUI(KC_3), LGUI(KC_4), ALT_TAB,                         KC_ESC, KC_PGUP,   KC_UP, KC_PGDN,  KC_PSCR,
        LALT(KC_1), LALT(KC_2), LALT(KC_3), LALT(KC_4), LALT(KC_5),                       KC_NO, KC_LEFT, KC_DOWN, KC_RGHT,   KC_INS,
        NAV_UNDO,   NAV_CUT,    NAV_COPY,   NAV_PASTE,  MS_BTN3,    _______,   _______, _______, KC_HOME,   KC_NO,  KC_END, KC_PAUSE,
        NAV_REDO,   _______,    _______,    _______,    _______,    _______,   _______, _______, _______, _______, _______,  _______
    ),

    [L_CTL] = LAYOUT(
        _______, _______, _______, _______, _______,                     KC_MSTP, KC_MPLY, KC_VOLU, _______, KC_BRIU,
        _______, _______, _______, _______, _______,                     _______, KC_MPRV, KC_VOLD, KC_MNXT, KC_BRID,
        KC_LCTL, KC_LSFT, KC_LGUI, KC_LALT, _______, KC_SLEP,   _______, _______, _______, KC_MUTE, _______, _______,
        QK_BOOT, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),

    [L_LMOD] = LAYOUT(
        _______,  _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______,  _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        L1(SCLN), L2(Q),   L3(J),   L4(K),   _______, _______,   _______, _______, _______, _______, _______, _______,
        _______,  _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),

    [L_RMOD] = LAYOUT(
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,   _______, _______,   R4(M),   R3(W),   R2(V),   R1(Z),
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    )

    /* empty layer
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
bool lmod_active = false;
bool rmod_active = false;

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
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

#if defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {

};
#endif // defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)

