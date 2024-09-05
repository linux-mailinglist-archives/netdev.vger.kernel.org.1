Return-Path: <netdev+bounces-125507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4796D6F2
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D053E1F2296D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9C519924A;
	Thu,  5 Sep 2024 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zd3n2A6h"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228B19884A
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535143; cv=none; b=hEEGfS/1pXKos+1Si67Iv6yYPmBYHdEYPo2l8gYNNgO9Ygfi8xUFi/fCJHFCiwRAEkLmMphrh8sB6FSyDea6vNFovKfcQinqJFyZ+avUnofzYVcp/klZItIfQgZKG8ZHTt6lU0ilKvxSvI4d9YathGuBCb7mfaqfktGkBWWDDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535143; c=relaxed/simple;
	bh=lMp1ke43TA48pLwZz2aBhY6oDUH1zsX1teUgRgCDxF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/ittarsIW3jfLtE5acDw3AaDhREsyaKhO9w+ey8e3h/orZdMFU7ZwgkxoMNup4JZfZzmgDPhibwiFau0OrrCn2Pz61SqdQBwM9gIegalf7cAa30hteBQmYVHmPgZNvS69gHcMchv+nETPd/j3Kh6D/ICAszjYdVu0bVnkJuLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zd3n2A6h; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725535141;
	bh=DefRs6VFP4+6dHR//STGdVMunQuKjjIDMnCyAZvxDuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=zd3n2A6hYtpgHxT1rRV+1tzdqQBmWZ599/qp4fT9DMjFW7yBxa1OUG9oxRWT6SjV2
	 pBmGwS5VJCY9pMKC3IW5sxE4MyL9OJ0SJDkzerWjxsMpJzMfx/RTainIDwd6mjUoN/
	 UKBdb8olaSPoeFvJsNBF95OZZLNOza3M9giChaYUXFHlFWVqt293DaQT/h+gu03jjv
	 b5JIGF+HMQ4maAjK4F2DOGzolA8hLfDJQBiz+uAgTjeVDGIPQCxdPrrJg39DyLMwSQ
	 /D/qwpZMxtQDZMegfwer9g3ihxvG6TFr7pSnB/FPHalW1tiQBtAcLXm9BprHOyg8za
	 otlb9tIZIoGeA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 4F06A3A103A;
	Thu,  5 Sep 2024 11:18:52 +0000 (UTC)
Message-ID: <c1e70de3-5c08-4213-a15d-fe565d8a533a@icloud.com>
Date: Thu, 5 Sep 2024 19:18:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024090531-mustang-scheming-3066@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: V_PDx_zY9TCLD3jByaAHCB0SsebnLhlI
X-Proofpoint-ORIG-GUID: V_PDx_zY9TCLD3jByaAHCB0SsebnLhlI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_06,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409050083

On 2024/9/5 13:32, Greg Kroah-Hartman wrote:
> On Thu, Sep 05, 2024 at 08:36:09AM +0800, Zijun Hu wrote:
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
>> By the way, this commit does not change any existing logic.
>>
>> Suggested-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
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
>>  		return 0;
>>  
>> -	if (!cxld->region)
>> +	if (!cxld->region) {
>> +		match_data->target_device = get_device(dev);
> 
> Where is put_device() called?
> 
> Ah, it's on the drop later on after find_free_decoder(), right?
> 
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
> 
> This still feels more complex that I think it should be.  Why not just
> modify the needed device information after the device is found?  What
> exactly is being changed in the match_free_decoder that needs to keep
> "state"?  This feels odd.
> 

i noticed that state of below exclusive fix have changed to "Handled
Elsewhere", that fix can solve our concern as well, let us wait for 2-3
days to see if there are some progress.

https://patchwork.kernel.org/project/cxl/patch/20240903-fix_cxld-v1-1-61acba7198ae@quicinc.com/

thanks

> thanks,
> 
> greg k-h


