Return-Path: <netdev+bounces-120558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23CC959C49
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798C32816B5
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2036191F92;
	Wed, 21 Aug 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="STA4wJbR"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9019047D
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244386; cv=none; b=MhYcc7TxNBi09j80QrUMGycrKCDsM1ipRMn9Pq92dQU4cUQ88RfmWefKgVuunWubNOhK+JefmmHi4BSL/NgOSDZUU0a2UMXeuXNCQQwOvtzEYJvnJWaz7jKJhmM7n3gtWJdauV70Pp1QBxSBAI3lA8sPL8lSi8h4jMiN4LqHxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244386; c=relaxed/simple;
	bh=B6WsG8Rck/unO8tXXResW+WijAzCkbEibhFVGOSzXsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHVpAmpIXMQ0QdLZ2Y9r2Vbuj0aVAQApzER6rusihFgoHtsObUuer26sCfk75+vdVcF/oiQ0MoUL2swZzayOE1ftl8FGMBHHS6j5yohLLOrwjOMbtqCdmXwf/BCT8gkT8GXZFu0jpffHkIJr3Fp5UtDwiVGlOPBEQnk7EPHqRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=STA4wJbR; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724244384;
	bh=T+wikT7QbRyFgwr7ixvpTx/a/TVVOL1Fh++smzpWiPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=STA4wJbR/OwBKc77aLOnPi2buIzVa46uixLFM64MFq2UsD6qDSxIZuNDtFni/X3gQ
	 EPr5IlFyCZI4EIE6BOd9d8H9QESvfWRfAeAkjz0bkd0W6vrPT30TYcZzBM+9uTdU6A
	 G/m775x4X+lkxsWgIkFEwRtonZf98ZHXp8dWMhSWeMuRoUHpLLunMDk5s6qFbnddkJ
	 aYhmvOlMMIxGh1c9Acqiq+7T3A9ZJeLfC18VmfQSH5c5iUtaYONaBh+/pMKyqP0jH/
	 WcqCX4pf7cbyuD77ZtmEtcaMjeo0G/73D7lJxMZ1MefTnqBk5jcfSE4mTHurtJkz3t
	 ZCvF/rPXJa7+g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 1F41A68001F;
	Wed, 21 Aug 2024 12:46:14 +0000 (UTC)
Message-ID: <dec374a6-073d-4b7f-9e83-adcfcf672852@icloud.com>
Date: Wed, 21 Aug 2024 20:46:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/region: Prevent device_find_child() from
 modifying caller's match data
To: Ira Weiny <ira.weiny@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com>
 <66c4a136d9764_2ddc2429435@iweiny-mobl.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <66c4a136d9764_2ddc2429435@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PQBbxUEcQPLkhubnh9QdLdCW5twymTGa
X-Proofpoint-ORIG-GUID: PQBbxUEcQPLkhubnh9QdLdCW5twymTGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408210093

On 2024/8/20 21:59, Ira Weiny wrote:
> Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> To prepare for constifying the following old driver core API:
>>
>> struct device *device_find_child(struct device *dev, void *data,
>> 		int (*match)(struct device *dev, void *data));
>> to new:
>> struct device *device_find_child(struct device *dev, const void *data,
>> 		int (*match)(struct device *dev, const void *data));
>>
>> The new API does not allow its match function (*match)() to modify
>> caller's match data @*data, but match_free_decoder() as the old API's
>> match function indeed modifies relevant match data, so it is not
>> suitable for the new API any more, fixed by implementing a equivalent
>> cxl_device_find_child() instead of the old API usage.
> 
> Generally it seems ok but I think some name changes will make this more
> clear.  See below.
> 

okay.

> Also for those working on CXL I'm questioning the use of ID here and the
> dependence on the id's being added to the parent in order.  Is that a
> guarantee?
> 
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/cxl/core/region.c | 36 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..8d8f0637f7ac 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -134,6 +134,39 @@ static const struct attribute_group *get_cxl_region_access1_group(void)
>>  	return &cxl_region_access1_coordinate_group;
>>  }
>>  
>> +struct cxl_dfc_data {
> 
> struct cxld_match_data
> 
> 'cxld' == cxl decoder in our world.
> 

make sense.

>> +	int (*match)(struct device *dev, void *data);
>> +	void *data;
>> +	struct device *target_device;
>> +};
>> +
>> +static int cxl_dfc_match_modify(struct device *dev, void *data)
> 
> Why not just put this logic into match_free_decoder?
> 

Actually, i ever considered solution B as you suggested in the end.

For this change, namely, solution A:
1) this change is clearer and easier to understand.
2) this change does not touch any existing cxld logic

For solution B:
it is more reasonable

i finally select A since it can express my concern and relevant solution
clearly.

>> +{
>> +	struct cxl_dfc_data *dfc_data = data;
>> +	int res;
>> +
>> +	res = dfc_data->match(dev, dfc_data->data);
>> +	if (res && get_device(dev)) {
>> +		dfc_data->target_device = dev;
>> +		return res;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * I have the same function as device_find_child() but allow to modify
>> + * caller's match data @*data.
>> + */
> 
> No need for this comment after the new API is established.
> 

i have given up the idea within v1 to introduce a new API which *should
ONLY* be used by this patch series, so it is not worthy of a new API
even if it can bring convenient for this patch series.

>> +static struct device *cxl_device_find_child(struct device *parent, void *data,
>> +					    int (*match)(struct device *dev, void *data))
>> +{
>> +	struct cxl_dfc_data dfc_data = {match, data, NULL};
>> +
>> +	device_for_each_child(parent, &dfc_data, cxl_dfc_match_modify);
>> +	return dfc_data.target_device;
>> +}
>> +
>>  static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>>  			 char *buf)
>>  {
>> @@ -849,7 +882,8 @@ cxl_region_find_decoder(struct cxl_port *port,
>>  		dev = device_find_child(&port->dev, &cxlr->params,
>>  					match_auto_decoder);
>>  	else
>> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
>> +		dev = cxl_device_find_child(&port->dev, &id,
>> +					    match_free_decoder);
> 
> This is too literal.  How about the following (passes basic cxl-tests).
> 

it is reasonable.

do you need me to submit that you suggest in the end and add you as
co-developer ?

OR

you submit it by yourself ?

either is okay for me.

> Ira
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c              
> index 21ad5f242875..c1e46254efb8 100644                                         
> --- a/drivers/cxl/core/region.c                                                 
> +++ b/drivers/cxl/core/region.c                                                 
> @@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>         return rc;                                                              
>  }                                                                              
>                                                                                 
> +struct cxld_match_data {                                                       
> +       int id;                                                                 
> +       struct device *target_device;                                           
> +};                                                                             
> +                                                                               
>  static int match_free_decoder(struct device *dev, void *data)                  
>  {                                                                              
> +       struct cxld_match_data *match_data = data;                              
>         struct cxl_decoder *cxld;                                               
> -       int *id = data;                                                         
>                                                                                 
>         if (!is_switch_decoder(dev))                                            
>                 return 0;                                                       
> @@ -805,17 +810,30 @@ static int match_free_decoder(struct device *dev, void *data)
>         cxld = to_cxl_decoder(dev);                                             
>                                                                                 
>         /* enforce ordered allocation */                                        
> -       if (cxld->id != *id)                                                    
> +       if (cxld->id != match_data->id)                                         
>                 return 0;                                                       
>                                                                                 
> -       if (!cxld->region)                                                      
> +       if (!cxld->region && get_device(dev)) {                                 

get_device(dev) failure may cause different logic against existing
but i think it should be impossible to happen normally.

> +               match_data->target_device = dev;                                
>                 return 1;                                                       
> +       }                                                                       
>                                                                                 
> -       (*id)++;                                                                
> +       match_data->id++;                                                       
>                                                                                 
>         return 0;                                                               
>  }                                                                              
>                                                                                 
> +static struct device *find_free_decoder(struct device *parent)                 
> +{                                                                              
> +       struct cxld_match_data match_data = {                                   
> +               .id = 0,                                                        
> +               .target_device = NULL,                                          
> +       };                                                                      
> +                                                                               
> +       device_for_each_child(parent, &match_data, match_free_decoder);         
> +       return match_data.target_device;                                        
> +}                                                                              
> +                                                                               
>  static int match_auto_decoder(struct device *dev, void *data)                  
>  {                                                                              
>         struct cxl_region_params *p = data;                                     
> @@ -840,7 +858,6 @@ cxl_region_find_decoder(struct cxl_port *port,              
>                         struct cxl_region *cxlr)                                
>  {                                                                              
>         struct device *dev;                                                     
> -       int id = 0;                                                             
>                                                                                 
>         if (port == cxled_to_port(cxled))                                       
>                 return &cxled->cxld;                                            
> @@ -849,7 +866,8 @@ cxl_region_find_decoder(struct cxl_port *port,              
>                 dev = device_find_child(&port->dev, &cxlr->params,              
>                                         match_auto_decoder);                    
>         else                                                                    
> -               dev = device_find_child(&port->dev, &id, match_free_decoder);   
> +               dev = find_free_decoder(&port->dev);                            
> +                                                                               
>         if (!dev)                                                               
>                 return NULL;                                                    
>         /*                                                                      


