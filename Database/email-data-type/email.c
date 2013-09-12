/*
* src/tutorial/complex.c
*
******************************************************************************
	This file contains routines that can be bound to a Postgres backend and
	called by the backend in the process of processing queries.  The calling
	format for these routines is dictated by Postgres architecture.
******************************************************************************/

#include "postgres.h"

#include "fmgr.h"
#include "libpq/pqformat.h"		/* needed for send/recv functions */
#include "stdio.h"
#include "stdlib.h"
#include <string.h>

PG_MODULE_MAGIC;

typedef struct Email
{
		int4 len;
		char z[1];
		
	
	
}	Email;

/*
* Since we use V1 function calling convention, all these functions have
* the same signature as far as C is concerned.  We provide these prototypes
* just to forestall warnings when compiled with gcc -Wmissing-prototypes.
*/
Datum		email_in(PG_FUNCTION_ARGS);
Datum		email_out(PG_FUNCTION_ARGS);

Datum		email_eql(PG_FUNCTION_ARGS);
Datum		email_gt(PG_FUNCTION_ARGS);
Datum		email_domain_eql(PG_FUNCTION_ARGS);
Datum		email_not_eql(PG_FUNCTION_ARGS);
Datum		email_ge(PG_FUNCTION_ARGS);
Datum		email_ls(PG_FUNCTION_ARGS);
Datum		email_le(PG_FUNCTION_ARGS);
Datum		email_domain_not_eql(PG_FUNCTION_ARGS);
Datum		email_abs_cmp(PG_FUNCTION_ARGS);
Datum		email_check(PG_FUNCTION_ARGS);

Datum		email_recv(PG_FUNCTION_ARGS);
Datum		email_send(PG_FUNCTION_ARGS);


void output(char *t)
{
	FILE *output_file = fopen("output.txt", "w");
	fputs(t,output_file);
	fclose(output_file);
	}
void output2(int *t)
{
	FILE *output_file = fopen("output2.txt", "w");
	fprintf(output_file,"%d",t);
	fclose(output_file);
	}
/*****************************************************************************
* Input/Output functions
*****************************************************************************/

PG_FUNCTION_INFO_V1(email_in);

Datum
email_in(PG_FUNCTION_ARGS)
{
	
		char	   *str = PG_GETARG_CSTRING(0);
	int EmailLen;
	Email    *result;
	int resultLen;
	EmailLen = strlen( str );

	if (checkemail(str) == 0)
		ereport(ERROR,
				(errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
				errmsg("invalid input syntax for Email: \"%s\"",
						str)));

	resultLen = VARHDRSZ + EmailLen;
	result = (Email *) palloc(resultLen );
	
	SET_VARSIZE(result, strlen(str)+VARHDRSZ );
	snprintf(result->z, EmailLen+1, "%s", str);
		
			
	PG_RETURN_POINTER(result);
}

PG_FUNCTION_INFO_V1(email_out);

Datum
email_out(PG_FUNCTION_ARGS)
{
	Email    *email = (Email *) PG_GETARG_POINTER(0);
	char	   *result;
	int EmailLen = VARSIZE(email) - VARHDRSZ ; 
	result = (char *) palloc0(EmailLen + 1);
	snprintf(result, EmailLen+1, "%s", email->z);
	PG_RETURN_CSTRING(result);
}


/*****************************************************************************
 * Binary Input/Output functions
 *
 * These are optional.
 *****************************************************************************/

PG_FUNCTION_INFO_V1(email_recv);

Datum
email_recv(PG_FUNCTION_ARGS)
{
	StringInfo	buf = (StringInfo) PG_GETARG_POINTER(0);
	Email    *result;
	
	int EmailLen;
	
	char *str;
	EmailLen = pq_getmsgint64(buf);
	str=pq_getmsgstring(buf);
	str[EmailLen]='\0';
	
	result = (Email *) palloc(EmailLen +  VARHDRSZ);
	
	SET_VARSIZE(result, EmailLen +  VARHDRSZ );
	snprintf(result->z, EmailLen+1, "%s", str);
		
	
	PG_RETURN_POINTER(result);
}

PG_FUNCTION_INFO_V1(email_send);

Datum
email_send(PG_FUNCTION_ARGS)
{
	Email    *email = (Email *) PG_GETARG_POINTER(0);
	StringInfoData buf;

		
	pq_begintypsend(&buf);
	pq_sendint64(&buf,  VARSIZE(email) - VARHDRSZ);
	pq_sendstring(&buf, email->z);
	//pq_sendstring(&buf, '\0');
	PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}



/*****************************************************************************
* Operation functions
*****************************************************************************/
static int
email_cmp(Email * a, Email * b)
{ 
	int pos_a;
	int pos_b;
	int domain;
	int local;
	int i;
	int la=VARSIZE(a)-VARHDRSZ - 1;
	int lb=VARSIZE(b)-VARHDRSZ - 1;
	
	for(i = 0;i< la ;i++)
		if(a->z[i]=='@')
			{
				pos_a = i;
				break;
			}
	for(i = 0;i< lb ;i++)
		if(b->z[i]=='@')
			{
				pos_b = i;
				break;
			}
	char do1[la - pos_a - 1];
	char do2[lb - pos_b - 1];	
	
	for(i=pos_a + 1;i<la;i++)
		do1[i-pos_a - 1]=tolower(a->z[i]);
	do1[la-pos_a - 1]='\0';	

	for(i=pos_b + 1;i<lb;i++)
		do2[i-pos_b - 1]=tolower(b->z[i]);
	do2[lb-pos_b - 1]='\0';	
			
	domain = strcmp(do1,do2);
	char de1[pos_a+1];
	char de2[pos_b+1];
	for(i=0;i<pos_a;i++)
		de1[i]=tolower(a->z[i]);
	de1[pos_a]='\0';
	for(i=0;i<pos_b;i++)
		de2[i]=tolower(b->z[i]);
	de2[pos_b]='\0';
	local = strcmp(de1,de2);
	
	if(domain==0)
		{
			if(local > 0) 
				return 1;
			if(local == 0) 
				return 2;
			if(local < 0) 
				return 3;	
			}
		
	if(domain > 0)
		return 4;
	if(domain < 0)
		return 5;
        
}

int checkemail(char *emailaddress)
{
    // vailale chars
    char vailch[]="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@.-1234567890";
    int pos; //@ position
    int num=0; // @ appearence times
    int len=strlen(emailaddress); //email length
    int pnum =0;  //. appearence times
    int novailch = 1;
    int i;
    int j;
    //if there is a invailed char
    for( i = 0; i <len; i++)
      {
      	  novailch = 0;
      	  for(j =0;j<strlen(vailch);j++)
            {
               if(emailaddress[i]==vailch[j])
                 novailch = 1;                    
            }
            
         if(novailch == 0)
            break;
        }
    if(novailch == 0)
        return 0;
    //if num of @ is 1
    for(i = 0;i< len;i++)
        if(emailaddress[i]=='@')
            {
                pos = i;
                num++;
            }
    if(num !=1)
        return 0;
    //after @, if there is one .
    for(i=pos;i<len;i++)
        if(emailaddress[i]=='.')
            pnum++;
    if(pnum<1)
        return 0;
    //if first char is a letter
    if(!isalpha(emailaddress[0]))
       return 0;
   
    //if last char is a letter or digit
    if(!isdigit(emailaddress[len-1]) && !isalpha(emailaddress[len-1]))
        return 0;
    //record . position
    pnum = 0;
     for(i=0;i<len;i++)
        if(emailaddress[i]=='.')
            pnum++;
     int p_pos[pnum];
     pnum=0;
      for(i=0;i<len;i++)
        if(emailaddress[i]=='.')
            {
                p_pos[pnum]=i;
                pnum++;
            }
      //if @ is at first or last position
      if(pos +1>len - 1 ||pos - 1 < 0)
          return 0;
      //first word after @, if it starts with a letter||
      if(!isalpha(emailaddress[pos+1]))
        return 0;
       //last word before @, if it ends with a letter or digit
      if(!isalpha(emailaddress[pos-1]) && !isdigit(emailaddress[pos-1]))
        return 0;
      for(i=0;i<pnum;i++)
          {
              //if . is at first or last position
              if(p_pos[i]+1>len-1 || p_pos[i]-1<0)
                  return 0;
                //for each .  if last char of each word is letter or digit
              if(!isalpha(emailaddress[p_pos[i]-1]) && !isdigit(emailaddress[p_pos[i]-1]))
        return 0;
               //for each .  if first char of each word is letter 
              if(!isalpha(emailaddress[p_pos[i]+1]))
        return 0;
          }
    return 1;
}


PG_FUNCTION_INFO_V1(email_eql);

Datum 
email_eql(PG_FUNCTION_ARGS)
{
	Email    *a = (Email *) PG_GETARG_POINTER(0);
	Email    *b = (Email *) PG_GETARG_POINTER(1);
	int re;
	if(email_cmp(a,b)==2)
		re = 1;
	else 
		re = 0;
		
	PG_RETURN_BOOL(re);
}

PG_FUNCTION_INFO_V1(email_gt);

Datum 
email_gt(PG_FUNCTION_ARGS)
{
	Email    *a = (Email *) PG_GETARG_POINTER(0);
	Email    *b = (Email *) PG_GETARG_POINTER(1);
	int re;
	if(email_cmp(a,b)==1 || email_cmp(a,b)==4)
		re = 1;
	else 
		re = 0;
		
	PG_RETURN_BOOL(re);
}


PG_FUNCTION_INFO_V1(email_domain_eql);

Datum 
email_domain_eql(PG_FUNCTION_ARGS)
{
	Email    *a = (Email *) PG_GETARG_POINTER(0);
	Email    *b = (Email *) PG_GETARG_POINTER(1);
	int re;
	if(email_cmp(a,b)==1 || email_cmp(a,b)==2 || email_cmp(a,b)==3)
		re = 1;
	else 
		re = 0;
		
	PG_RETURN_BOOL(re);
}

PG_FUNCTION_INFO_V1(email_not_eql);

Datum 
email_not_eql(PG_FUNCTION_ARGS)
{
	Email    *a = (Email *) PG_GETARG_POINTER(0);
	Email    *b = (Email *) PG_GETARG_POINTER(1);
	int re;
	if(email_cmp(a,b)!=2)
		re = 1;
	else 
		re = 0;
		
	PG_RETURN_BOOL(re);
}

PG_FUNCTION_INFO_V1(email_ge);

Datum 
email_ge(PG_FUNCTION_ARGS)
{
	Email    *a = (Email *) PG_GETARG_POINTER(0);
	Email    *b = (Email *) PG_GETARG_POINTER(1);
	int re;
	if(email_cmp(a,b)==1 || email_cmp(a,b)==2 || email_cmp(a,b)==4)
		re = 1;
	else 
		re = 0;
		
	PG_RETURN_BOOL(re);
}

PG_FUNCTION_INFO_V1(email_ls);

Datum 
email_ls(PG_FUNCTION_ARGS)
{
	Email    *a = (Email *) PG_GETARG_POINTER(0);
	Email    *b = (Email *) PG_GETARG_POINTER(1);
	int re;
	if(email_cmp(a,b)==3 || email_cmp(a,b)==5)
		re = 1;
	else 
		re = 0;
		
	PG_RETURN_BOOL(re);
}

PG_FUNCTION_INFO_V1(email_le);

Datum 
email_le(PG_FUNCTION_ARGS)
{
	Email    *a = (Email *) PG_GETARG_POINTER(0);
	Email    *b = (Email *) PG_GETARG_POINTER(1);
	int re;
	if(email_cmp(a,b)==2 || email_cmp(a,b)==3 || email_cmp(a,b)==5)
		re = 1;
	else 
		re = 0;
		
	PG_RETURN_BOOL(re);
}

PG_FUNCTION_INFO_V1(email_domain_not_eql);

Datum 
email_domain_not_eql(PG_FUNCTION_ARGS)
{
	Email    *a = (Email *) PG_GETARG_POINTER(0);
	Email    *b = (Email *) PG_GETARG_POINTER(1);
	int re;
	if(email_cmp(a,b)!=1 && email_cmp(a,b)!=2 && email_cmp(a,b)!=3)
		re = 1;
	else 
		re = 0;
		
	PG_RETURN_BOOL(re);
}

PG_FUNCTION_INFO_V1(email_abs_cmp);

Datum
email_abs_cmp(PG_FUNCTION_ARGS)
{
	Email    *a = (Email *) PG_GETARG_POINTER(0);
	Email    *b = (Email *) PG_GETARG_POINTER(1);

	int32 re;
	if(email_cmp(a,b)==2)
		re = 0;
	else if(email_cmp(a,b)==1 || email_cmp(a,b)==4)
		re = 1;
	else if(email_cmp(a,b)==3 || email_cmp(a,b)==5)
		re = -1;
	PG_RETURN_INT32(re);
}


PG_FUNCTION_INFO_V1(email_check);

Datum
email_check(PG_FUNCTION_ARGS)
{
	Email    *a = (Email *) PG_GETARG_POINTER(0);
	

	PG_RETURN_INT32(checkemail(a));
}


