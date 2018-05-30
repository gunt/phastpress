<?php

function phastpress_low_php_version_data() {
    wp_send_json(array(
        'error' => array(
            'type' => 'low-php',
            'version' => PHP_VERSION
        )
    ));
}

add_action('wp_ajax_phastpress_get_admin_panel_data', 'phastpress_low_php_version_data');