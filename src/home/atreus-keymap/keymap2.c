
enum custom_keycodes {
  ALT_TAB = SAFE_RANGE,
  CTL_TAB,
  LMOD,
  RMOD
};


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT(
        KC_QUOT, KC_COMM, KC_DOT, KC_P,  KC_Y,                          KC_F,   KC_G,  KC_C,  KC_R,  KC_L,
        KC_A,    KC_O,    KC_E,   KC_U,  KC_I,                          KC_D,   KC_H,  KC_T,  KC_N,  KC_S, 
        KC_SCLN, KC_Q,    KC_J,   KC_K,  KC_X,  KC_NO,   KC_NO,         KC_B,   KC_M,  KC_W,  KC_V,  KC_Z, 
        MO(7),   KC_NO,   KC_NO,  LMOD,  MO(3), MO(1),   LT(2, KC_TAB), KC_SPC, RMOD,  KC_NO, KC_NO, MO(7)
    ),
    // sym layer.
    [1] = LAYOUT(
        KC_DQUO,  KC_LT,   KC_GT,   KC_DLR,  KC_PERC,                     KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_SLSH,
        KC_EXLM,  KC_BSLS, KC_PLUS, KC_DQUO, KC_DQUO,                     KC_EQL,  KC_MINS, KC_LCBR, KC_RCBR, KC_QUES,
        KC_COLN,  KC_AT,   KC_HASH, KC_TILDE,KC_GRV, _______,   _______, KC_CIRC, KC_UNDS, KC_LBRC, KC_RBRC, KC_PIPE,
        _______,  _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),
    // num layer
    [2] = LAYOUT(
        KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                       KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,
        KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                        KC_6,    KC_7,    KC_8,    KC_9,    KC_0, 
        KC_LGUI, KC_LALT, KC_LCTL, KC_LSFT, KC_F11,  _______,   _______, KC_F12,  KC_RSFT, KC_RCTL, KC_RALT, KC_RGUI,
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),
    // nav layer
    [3] = LAYOUT(
        KC_ESC, LCTL(KC_X), LCTL(KC_C), LCTL(KC_V), KC_BTN2,                KC_ESC,   KC_PGUP, KC_UP,   KC_PGDN, KC_BACKSPACE,
        LGUI(KC_TAB), ALT_TAB, CTL_TAB, KC_NO,   KC_NO,                   KC_NO, KC_LEFT, KC_DOWN, KC_RGHT, KC_ENTER, 
        KC_LGUI, KC_LALT, KC_LCTL, KC_LSFT, KC_ENTER, _______,   _______, LCTL_T(KC_Y),   KC_HOME, KC_NO,   KC_END,  LCTL_T(KC_Z),
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),
    // ctl layer
    [4] = LAYOUT(
        QK_BOOT, _______, KC_PRINT_SCREEN, KC_SCROLL_LOCK, KC_PAUSE,                     KC_AUDIO_MUTE, _______, KC_AUDIO_VOL_UP, _______, KC_BRIGHTNESS_UP,
        _______, _______, KC_INSERT, _______, _______,                     _______, KC_MEDIA_PREV_TRACK, KC_AUDIO_VOL_DOWN, KC_MEDIA_NEXT_TRACK, KC_BRIGHTNESS_DOWN,
        KC_LGUI, KC_LALT, KC_LCTL, KC_LSFT, _______, _______,   _______, _______, KC_RSFT, RCTL_T(KC_MEDIA_PLAY_PAUSE), RALT_T(KC_MEDIA_STOP), KC_RGUI,
        KC_SYSTEM_SLEEP, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______,KC_SYSTEM_SLEEP
    ),

    // lmod layer
    [5] = LAYOUT(
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        LGUI_T(KC_SCLN), LALT_T(KC_Q), LCTL_T(KC_J), LSFT_T(KC_K), _______, _______,   _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),
    // rmod layer
    [6] = LAYOUT(
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,   _______, _______, RSFT_T(KC_M), RCTL_T(KC_W), RALT_T(KC_V), RGUI_T(KC_Z),
        _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
    ),
    // ctl layer
};
