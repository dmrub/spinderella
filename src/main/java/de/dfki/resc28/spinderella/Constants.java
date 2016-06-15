/*
 * This file is part of SPINderella. It is subject to the license terms in
 * the LICENSE file found in the top-level directory of this distribution.
 * You may not use this file except in compliance with the License.
 */
package de.dfki.resc28.spinderella;

import javax.ws.rs.core.MediaType;

/**
 * @author resc01
 *
 */
public class Constants 
{
	// Content types
	public static final String CT_APPLICATION_JSON = MediaType.APPLICATION_JSON;
	public static final String CT_APPLICATION_LD_JSON = "application/ld+json";
	public static final String CT_APPLICATION_RDFXML = "application/rdf+xml";
	public static final String CT_APPLICATION_XTURTLE = "application/x-turtle";
	public static final String CT_APPLICATION_SPARQLQUERY = "application/sparql-query";
	public static final String CT_APPLICATION_SPARQLRESULTSXML = "application/sparql-results+xml";
	public static final String CT_APPLICATION_SPARQLRESULTSJSON = "application/sparql-results+json";
	public static final String CT_TEXT_HTML = MediaType.TEXT_HTML;
	public static final String CT_TEXT_TURTLE = "text/turtle";
	public static final String CT_TEXT_TRIG = "text/trig";
}
