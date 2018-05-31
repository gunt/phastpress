<?php

namespace Kibo\PhastPlugins;

use Kibo\Phast\Retrievers\HTTPClient;
use Kibo\Phast\ValueObjects\URL;

class RequestsHTTPClient implements HTTPClient {

    public function retrieve(URL $url, array $headers = []) {
        try {
            $response = \Requests::get((string)$url, $headers);
        } catch (\Exception $e) {
            return false;
        }
        if ($response->success) {
            return $response->body;
        }
        return false;
    }

}
