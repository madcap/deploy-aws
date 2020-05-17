package org.maats.deployaws;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.Map;

@Controller
@RequestMapping("/")
public class WebController {

    @Value("${environment}")
    private String environment;

    @Value("${version}")
    private String version;

    @RequestMapping(path = "/", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody Object home(
            @RequestParam Map<String,String> queryParameters
    ) {
        return Map.of(
                "version", version,
                "environment", environment
        );
    }

    @RequestMapping(path = "/echo", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody Object echoPost(
            @RequestBody Object body,
            @RequestHeader Map<String, String> headers
    ) {
        return Map.of(
                "headers", headers,
                "body", body,
                "version", version,
                "environment", environment
        );
    }

    @RequestMapping(path = "/echo", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody Object echoGet(
            @RequestParam Map<String,String> queryParameters
    ) {
        return Map.of(
                "queryParameters", queryParameters,
                "version", version,
                "environment", environment
        );
    }

}
