# spinderella
SPINderella provides a REST API to convert between textual SPARQL syntax and the SPIN RDF Vocabulary.

## Installation & Running
Run SPINderella on your localhost by typing
```
mvn clean package tomcat7:run
```

You can modify SPINderella's listening port in the `pom.xml`
```
<build>
	...
	<plugins>
		...
		<plugin>
			<groupId>org.apache.tomcat.maven</groupId>
			<artifactId>tomcat7-maven-plugin</artifactId>
			<version>2.2</version>  	
            		<configuration>
				<server>SPINderella</server>
				<port>8080</port>
				<path>/</path>
			</configuration>
		</plugin>
		...
	</plugins>
</build>
```

## Usage
Get SPINderella up and running. Then, use your favourite REST client against one of our REST APIs.


### HTML UI
Point your good ol' browser to `http://localhost:{YOUR_PORT}` for some self-explainatory WebUI.

### Form-style POST API
HTTP POST requests can be made against SPINderella's form-style POST APIs
```
curl -H "Content-Type: application/x-www-form-urlencoded" -X POST -d "spinQueryText={your_SPIN_query}" http://localhost:{port}/api/spin/sparql
```
and 
```
curl -H "Content-Type: application/x-www-form-urlencoded" -X POST -d "sparqlQueryText={your_SPARQL_query}&spinQueryURI={your_SPIN_resourceURI}" http://localhost:{port}/api/sparql/spin
```
The parameter `spinQueryURI` is optional. If not set, SPINderella defaults to a blank node.

## Contributing
Contributions are very welcome.

## License
This source distribution is subject to the license terms in the LICENSE file found in the top-level directory of this distribution.
You may not use this file except in compliance with the License.

## Third-party Contents
This source distribution includes the third-party items with respective licenses as listed in the THIRD-PARTY file found in the top-level directory of this distribution.
