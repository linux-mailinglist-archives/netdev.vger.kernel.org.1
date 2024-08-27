Return-Path: <netdev+bounces-122269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54AA960958
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9EB28283E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE2C1A01AB;
	Tue, 27 Aug 2024 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zOzev3E+"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD119D88C
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759650; cv=none; b=KMiDgF8DAVByL6V+L79u4AN1LfHbqjAKgwAkOtcA8mAskDIX5G8+TgqksXjUzpkEC1ednTny8aH20Lu/cXg8gsNVRkKvGA3ZtHklQSGV92z2oFuKCiRWrs5QCJrfl+B/mV/Mvi4iDZcFG1IJdS5BjbNJo/SbVTXtWwwE9MKV+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759650; c=relaxed/simple;
	bh=nEi8II45wAmL1f5XTIWsbyTtcx8NX0c09t6x4DVix6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfSi24HYYCYku+u1mw2A0nxM7/qP7qx7V9UkORFjJoPTeaJgdnuiBhuihWKCmoy0Y3e8lR3FhBh3YrRN9eHph3MQNwu420usjtMX9YAS+tgWXMYtnYiYZFxvr7OI7GU5jWDK9nk6T0yiHCYPeY0iPckeQAZ4/Y9m/EaVXiY9lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zOzev3E+; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724759649;
	bh=OYrHNLwmvHe2oa0rD8JJuTUs4ODsC2IJMqoKI314ldc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=zOzev3E+mosk3j16HL4HiEHL5WWqXUvHyj+nqVG/LPaaLQZRkO/seWBBb5BOOhchn
	 O8MU75aMMqEEYO85vpySf8LxFn8N/b43eXisXvYRgH+QJU/0WExah46MmVzN9K1X48
	 eb9NV60IlxYNaiRXPck10Ma9wo4ObI2DfJaQTEShk6Qjyvv9/tzEh9bdetfRkGQYIT
	 EfFwSR4zeMoBe+zKTu4R0r+LCH8Cdr/Re0/DjjHX3XqpDbrjnHxBnASU5tAPwoQmhS
	 Eeo37doe9R1qcHVXLWqFnTGzz3zUx8F64fmjjPetf/zgqiLHxrM5+Ny6OsdkusmJUN
	 Pg5Rzlw8tC8gg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id DDCA83A008D;
	Tue, 27 Aug 2024 11:53:59 +0000 (UTC)
Message-ID: <cdfc6f98-1aa0-4cb5-bd7d-93256552c39b@icloud.com>
Date: Tue, 27 Aug 2024 19:53:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cxl/region: Find free cxl decoder by
 device_for_each_child()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com>
 <20240824-const_dfc_prepare-v3-2-32127ea32bba@quicinc.com>
 <20240827123006.00004527@Huawei.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240827123006.00004527@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zXSu555QJvhB-nSvhZ59A5Eowv9iK99L
X-Proofpoint-GUID: zXSu555QJvhB-nSvhZ59A5Eowv9iK99L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_06,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408270087

On 2024/8/27 19:30, Jonathan Cameron wrote:
> On Sat, 24 Aug 2024 17:07:44 +0800
> Zijun Hu <zijun_hu@icloud.com> wrote:
> 
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
>> match function indeed modifies relevant match data, so it is not suitable
>> for the new API any more, solved by using device_for_each_child() to
>> implement relevant finding free cxl decoder function.
>>
>> Suggested-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> This seems to functionally do the same as before.
> 

yes, this change have the same logic as previous existing logic.

> I'm not sure I like the original code though so a comment inline.
> 
>> ---
>>  drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++------
>>  1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..c2068e90bf2f 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>>  	return rc;
>>  }
>>  
>> +struct cxld_match_data {
>> +	int id;
>> +	struct device *target_device;
>> +};
>> +
>>  static int match_free_decoder(struct device *dev, void *data)
>>  {
>> +	struct cxld_match_data *match_data = data;
>>  	struct cxl_decoder *cxld;
>> -	int *id = data;
>>  
>>  	if (!is_switch_decoder(dev))
>>  		return 0;
>> @@ -805,17 +810,31 @@ static int match_free_decoder(struct device *dev, void *data)
>>  	cxld = to_cxl_decoder(dev);
>>  
>>  	/* enforce ordered allocation */
>> -	if (cxld->id != *id)
>> +	if (cxld->id != match_data->id)
> 
> Why do we carry on in this case?
> Conditions are:
> 1. Start match_data->id == 0
> 2. First pass cxld->id == 0 (all good) or
>    cxld->id == 1 say (and we skip until we match
>    on cxld->id == 0 (perhaps on the second child if they are
>    ordered (1, 0, 2) etc. 
> 
> If we skipped and then matched on second child but it was
> already in use (so region set), we will increment match_data->id to 1
> but never find that as it was the one we skipped.
> 
> So this can only work if the children are ordered.
> So if that's the case and the line above is just a sanity check
> on that, it should be noisier (so an error print) and might
> as well fail as if it doesn't match all bets are off.
> 

it seems Ira Weiny also has some concerns related to previous existing
logic as following:

https://lore.kernel.org/all/66c4a136d9764_2ddc2429435@iweiny-mobl.notmuch/
"Also for those working on CXL I'm questioning the use of ID here and
the dependence on the id's being added to the parent in order.  Is that
a guarantee?"

perhaps, create a new dedicated thread to discuss original design.

> Jonathan
>  
>>  		return 0;
>>  
>> -	if (!cxld->region)
>> +	if (!cxld->region) {
>> +		match_data->target_device = get_device(dev);
>>  		return 1;
>> +	}
>>  
>> -	(*id)++;
>> +	match_data->id++;
>>  
>>  	return 0;
>>  }
>>  
>> +/* NOTE: need to drop the reference with put_device() after use. */
>> +static struct device *find_free_decoder(struct device *parent)
>> +{
>> +	struct cxld_match_data match_data = {
>> +		.id = 0,
>> +		.target_device = NULL,
>> +	};
>> +
>> +	device_for_each_child(parent, &match_data, match_free_decoder);
>> +	return match_data.target_device;
>> +}
>> +
>>  static int match_auto_decoder(struct device *dev, void *data)
>>  {
>>  	struct cxl_region_params *p = data;
>> @@ -840,7 +859,6 @@ cxl_region_find_decoder(struct cxl_port *port,
>>  			struct cxl_region *cxlr)
>>  {
>>  	struct device *dev;
>> -	int id = 0;
>>  
>>  	if (port == cxled_to_port(cxled))
>>  		return &cxled->cxld;
>> @@ -849,7 +867,7 @@ cxl_region_find_decoder(struct cxl_port *port,
>>  		dev = device_find_child(&port->dev, &cxlr->params,
>>  					match_auto_decoder);
>>  	else
>> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
>> +		dev = find_free_decoder(&port->dev);
>>  	if (!dev)
>>  		return NULL;
>>  	/*
>>
> 


