/*
 * This file is part of SPINderella. It is subject to the license terms in
 * the LICENSE file found in the top-level directory of this distribution.
 * You may not use this file except in compliance with the License.
 */
package de.dfki.resc28.spinderella.services;

import java.io.IOException;
import java.io.OutputStream;

import javax.ws.rs.FormParam;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.core.StreamingOutput;

import org.apache.commons.io.IOUtils;
import org.apache.jena.query.Query;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.query.QueryParseException;
import org.apache.jena.rdf.model.InfModel;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.rdf.model.Resource;
import org.apache.jena.riot.Lang;
import org.apache.jena.riot.RDFDataMgr;
import org.apache.jena.vocabulary.RDF;
import org.topbraid.spin.arq.ARQ2SPIN;
import org.topbraid.spin.model.SPINFactory;
import org.topbraid.spin.vocabulary.SP;

import de.dfki.resc28.spinderella.Constants;

/**
 * @author resc01
 *
 */
@Path("")
public class SPINderellaService 
{
	@POST
	@Path("spin/sparql")
	@Produces(Constants.CT_APPLICATION_SPARQLQUERY)
	public Response fromSpinToSparql( @FormParam("spinQueryText") String spinQueryText,
									  @HeaderParam("Content-type") String contentType )
	{	
		try 
		{
			Model spinQueryModel = ModelFactory.createDefaultModel().read(IOUtils.toInputStream(spinQueryText, "UTF-8"), null, "TURTLE");
			Model spinSchema = RDFDataMgr.loadModel("http://spinrdf.org/sp", Lang.RDFXML);		
			InfModel infModel = ModelFactory.createRDFSModel(spinSchema, spinQueryModel);
			Resource queryInstance = SPINFactory.asQuery(infModel.listResourcesWithProperty(RDF.type, SP.Query).next());		
			org.topbraid.spin.model.Query spinQuery = SPINFactory.asQuery(queryInstance);
			
			return Response.ok(spinQuery.toString())
						   .build();
		} 
		catch (IOException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new WebApplicationException(e.getMessage(), Status.BAD_REQUEST);
		}
	}

	@POST
	@Path("sparql/spin")
	@Produces({ Constants.CT_TEXT_TURTLE, Constants.CT_APPLICATION_RDFXML, Constants.CT_APPLICATION_XTURTLE, Constants.CT_APPLICATION_JSON, Constants.CT_APPLICATION_LD_JSON })
	public Response fromSparqlToSpin( @FormParam("spinQueryURI") String spinQueryURI,
									  @FormParam("sparqlQueryText") String sparqlQueryText,
									  @HeaderParam("Accept") final String acceptType )
	{
		try
		{
			final Query sparqlQuery = QueryFactory.create(sparqlQueryText);
			
			final Model spinQueryModel = ModelFactory.createDefaultModel();
			spinQueryModel.setNsPrefix(SP.PREFIX, SP.NS);
			spinQueryModel.setNsPrefixes(sparqlQuery.getPrefixMapping());
			
	
			ARQ2SPIN arq2SPIN = new ARQ2SPIN( spinQueryModel, true );
			
			if (!spinQueryURI.isEmpty())
				arq2SPIN.createQuery( sparqlQuery, spinQueryURI);
			else 
				arq2SPIN.createQuery( sparqlQuery, null );
			
			StreamingOutput out = new StreamingOutput() 
			{
				public void write(OutputStream output) throws IOException, WebApplicationException
				{
					RDFDataMgr.write(output, spinQueryModel, Lang.TURTLE) ;
				}
			};
			
			return Response.ok(out)
						   .type(Constants.CT_TEXT_TURTLE)
						   .build(); 
		}
		catch (QueryParseException e)
		{
			throw new WebApplicationException(e.getMessage(), Status.BAD_REQUEST);
		}
	}
}
