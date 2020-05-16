package org.maats.deployaws

import spock.lang.Specification

class WebControllerSpec extends Specification {

    private static final String VALUE = 'value'
    private static final String VERSION = 'version'

    private WebController controller = new WebController(environmentValue: VALUE, version: VERSION)

    def 'test - home'() {
        expect:
        controller.home() == [
                version: VERSION,
                environmentValue: VALUE,
        ]
    }

    def 'test - echoPost'() {
        given:
        def body = [body: 'value']
        def headers = [header: 'value']

        expect:
        controller.echoPost(body, headers) == [
                body: body,
                headers: headers,
                version: VERSION,
                environmentValue: VALUE,
        ]
    }

    def 'test - echoGet'() {
        given:
        def queryParameters = [parameter: 'value']

        expect:
        controller.echoGet(queryParameters) == [
                queryParameters: queryParameters,
                version: VERSION,
                environmentValue: VALUE,
        ]
    }

}
