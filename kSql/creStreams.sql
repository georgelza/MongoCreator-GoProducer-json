



-- Working with time/dates and timestamps in ksqldb
-- https://www.confluent.io/blog/ksqldb-2-0-introduces-date-and-time-data-types/

-- salesbaskets
CREATE STREAM json_salesbaskets (
	   	InvoiceNumber VARCHAR,
	 	SaleDateTime VARCHAR,
	 	SaleTimestamp VARCHAR,
	  	TerminalPoint VARCHAR,
	   	Nett DOUBLE,
	  	Vat DOUBLE,
	 	Total DOUBLE,
       	Store STRUCT<
       		Id VARCHAR,
     		Name VARCHAR>,
     	Clerk STRUCT<
     		Id VARCHAR,
          	Name VARCHAR>,
    	BasketItems ARRAY< STRUCT<
			id VARCHAR,
        	Name VARCHAR,
          	Brand VARCHAR,
          	Category VARCHAR,
         	Price DOUBLE,
        	Quantity integer >>) 
WITH (KAFKA_TOPIC='json_salesbaskets',
		    VALUE_FORMAT='Json',
        	PARTITIONS=1);
       
CREATE STREAM json_salesbaskets1 WITH (KAFKA_TOPIC='json_salesbaskets1',
       VALUE_FORMAT='Json',
       PARTITIONS=1)
       as  
		select
			InvoiceNumber,
	 		SaleDateTime,
		  	CAST(SaleTimestamp AS BIGINT) AS Sale_epoc_bigint,
	  		TerminalPoint,
	   		Nett,
	  		Vat,
	 		Total,
       		Store,
     		Clerk,
    		BasketItems 
		from json_salesbaskets
			emit changes;

CREATE STREAM json_salesbaskets2 WITH (KAFKA_TOPIC='json_salesbaskets2',
       VALUE_FORMAT='Json',
       PARTITIONS=1)
       as  
		select
			InvoiceNumber,
	 		SaleDateTime,
			TIMESTAMPTOSTRING(CAST(SaleTimestamp AS BIGINT), 'yyyy-MM-dd''T''HH:mm:ss.SSS') AS SaleTimestamp_str,
	  		TerminalPoint,
	   		Nett,
	  		Vat,
	 		Total,
       		Store,
     		Clerk,
    		BasketItems 
		from json_salesbaskets
			emit changes;


-- salespayments       
CREATE STREAM json_salespayments (
	      	InvoiceNumber VARCHAR,
	      	FinTransactionId VARCHAR,
	      	PayDateTime VARCHAR,
			PayTimestamp VARCHAR,
	      	Paid DOUBLE      )
WITH (KAFKA_TOPIC='json_salespayments',
       		VALUE_FORMAT='Json',
       		PARTITIONS=1);

CREATE STREAM pb_salespayments1 WITH (KAFKA_TOPIC='json_salespayments1',
       VALUE_FORMAT='Json',
       PARTITIONS=1)
       as  
		select   	
			InvoiceNumber,
	      	FinTransactionId,
	      	PayDateTime,
		  	CAST(PayTimestamp AS BIGINT) AS Pay_epoc_bigint,
	      	Paid  
		from json_salespayments
			emit changes;


CREATE STREAM json_salespayments2 WITH (KAFKA_TOPIC='json_salespayments2',
       VALUE_FORMAT='Json',
       PARTITIONS=1)
       as  
		select   	
			InvoiceNumber,
	      	FinTransactionId,
	      	PayDateTime,
		  	TIMESTAMPTOSTRING(CAST(PayTimestamp AS BIGINT), 'yyyy-MM-dd''T''HH:mm:ss.SSS') AS PayTimestamp_str,
	      	Paid  
		from json_salespayments
			emit changes;



CREATE STREAM json_salescompleted_json WITH (KAFKA_TOPIC='json_salescompleted_json',
       VALUE_FORMAT='Json',
       PARTITIONS=1)
       as  
select 
	b.InvoiceNumber InvNumber, 
	b.SaleDateTime,
	b.SaleTimestamp, 
	b.TerminalPoint,
	b.Nett,
	b.Vat,
	b.Total,
	b.store,
	b.clerk,
	b.BasketItems,
	p.FinTransactionId,
	p.PayDateTime,
	p.PayTimestamp,
	p.Paid
from 
	json_salespayments p INNER JOIN
	json_salesbaskets b
WITHIN 7 DAYS 
on b.InvoiceNumber = p.InvoiceNumber
emit changes;


CREATE TABLE pageviews_per_region AS
  SELECT regionid,
         COUNT(*)
  FROM pageviews
  GROUP BY regionid
  EMIT CHANGES;