Return-Path: <netdev+bounces-126961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FE397366A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E36A1F25F21
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD5190679;
	Tue, 10 Sep 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="G4BQ5oWh"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D518FC72
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968800; cv=none; b=oUc91/nVLMkkfln1i9g7WHIdg1z2vtr9SRrOt+wExgBHrfI/LMU9qfsnm7/FK/wizjXxtcEzNsX1zQ8EcKN715CLvK1KdfYC9guGQrUJ2GJksBa4QGEKzWZ2J/TxSdLs6hEoSJ5yvpw6ePyvJfgCZKboeWi4WhzNQlvYF+ZOmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968800; c=relaxed/simple;
	bh=lCuEX1B7G8V6W9Z6q+uGVeU5AA5ec3oX68AitYTYla4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGQIfvvpUzhBVIyRJskphqUiCjzF3sO6m+tiXSLzFt5qRYOGMz/xSTYaxyx/VMQwH6lKQ7sZY5UhyynBdIjEWtDOrytjxDAOS7IrOrQDT9gP1hki3eAkHdqi+Rynnmp2TQvwjuVd/IBSL5iN1xjlZJcR2fFcZEbjqU+InrPvbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=G4BQ5oWh; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725968797;
	bh=tmrBWDvF0iFyeIEX7Tyi7+YVVfmUxWfr5OWVJk8yh0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=G4BQ5oWhVYcRKTfdXQ4pIgR2PiqxXbB9NFXGNnQhcHs5IXSC/hd4q/B4FuiU4q12p
	 QvEYZukH3U+0sPeyayEBY/S0f/S76q+YFZTWrzABe9wqmRksIeAcaqL8L+vw7/9x4V
	 2qOxFXixhIy4w1BtiGqVxbFKO/aEqyXA3cW5efE/ERmKoBZ9v0fPZJqHQQUhr9dRf6
	 tBAHb5bm4DpJiACBGAp/3iswfuL7qcDMUS5RpL/a6Bvqcs/ywuGUOqd1htm37BSqKO
	 kp0IJQSpKMNOFA9z0zVhYrpDS4tiriV6ycXk8jmRSBtAD/qEoHM+yxHl1SXn2sKo76
	 zYlsYcUm4x9Vw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id CE6C8D000DB;
	Tue, 10 Sep 2024 11:46:28 +0000 (UTC)
Message-ID: <e7e6ea66-bcfe-4af4-9f82-ae39fef1a976@icloud.com>
Date: Tue, 10 Sep 2024 19:46:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
To: Dan Williams <dan.j.williams@intel.com>,
 quic_zijuhu <quic_zijuhu@quicinc.com>, Ira Weiny <ira.weiny@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
 <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
 <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a6dae308-ff34-4479-a638-8c12ff2e8d32@quicinc.com>
 <66dfc7d4f11a3_32646294f7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <66dfc7d4f11a3_32646294f7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: u82aMDuBd8roHSdBbqsymyDqICNgNuyL
X-Proofpoint-ORIG-GUID: u82aMDuBd8roHSdBbqsymyDqICNgNuyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409100087

On 2024/9/10 12:15, Dan Williams wrote:
> quic_zijuhu wrote:
>> On 9/10/2024 8:45 AM, Dan Williams wrote:
>>> Ira Weiny wrote:
>>> [..]
>>>>> This still feels more complex that I think it should be.  Why not just
>>>>> modify the needed device information after the device is found?  What
>>>>> exactly is being changed in the match_free_decoder that needs to keep
>>>>> "state"?  This feels odd.
>>>>
>>>> Agreed it is odd.
>>>>
>>>> How about adding?
>>>
>>> I would prefer just dropping usage of device_find_ or device_for_each_
>>> with storing an array decoders in the port directly. The port already
>>> has arrays for dports , endpoints, and regions. Using the "device" APIs
>>> to iterate children was a bit lazy, and if the id is used as the array
>>> key then a direct lookup makes some cases simpler.
>>
>> it seems Ira and Dan have corrected original logic to ensure
>> that all child decoders are sorted by ID in ascending order as shown
>> by below link.
>>
>> https://lore.kernel.org/all/66df666ded3f7_3c80f229439@iweiny-mobl.notmuch/
>>
>> based on above correction, as shown by my another exclusive fix
>> https://lore.kernel.org/all/20240905-fix_cxld-v2-1-51a520a709e4@quicinc.com/
>> there are a very simple change to solve the remaining original concern
>> that device_find_child() modifies caller's match data.
>>
>> here is the simple change.
>>
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -797,23 +797,13 @@ static size_t show_targetN(struct cxl_region
>> *cxlr, char *buf, int pos)
>>  static int match_free_decoder(struct device *dev, void *data)
>>  {
>>         struct cxl_decoder *cxld;
>> -       int *id = data;
>>
>>         if (!is_switch_decoder(dev))
>>                 return 0;
>>
>>         cxld = to_cxl_decoder(dev);
>>
>> -       /* enforce ordered allocation */
>> -       if (cxld->id != *id)
>> -               return 0;
>> -
>> -       if (!cxld->region)
>> -               return 1;
>> -
>> -       (*id)++;
>> -
>> -       return 0;
>> +       return cxld->region ? 0 : 1;
> 
> So I wanted to write a comment here to stop the next person from
> tripping over this dependency on decoder 'add' order, but there is a
> problem. For this simple version to work it needs 3 things:
> 
> 1/ decoders are added in hardware id order: done,
> devm_cxl_enumerate_decoders() handles that
> 

do not known how you achieve it, perhaps, it is not simpler than
my below solution:

finding a free switch cxl decoder with minimal ID
https://lore.kernel.org/all/20240905-fix_cxld-v2-1-51a520a709e4@quicinc.com/

which has simple logic and also does not have any limitation related
to add/allocate/de-allocate a decoder.

i am curious why not to consider this solution ?

> 2/ search for decoders in their added order: done, device_find_child()
> guarantees this, although it is not obvious without reading the internals
> of device_add().
> 
> 3/ regions are de-allocated from decoders in reverse decoder id order.
> This is not enforced, in fact it is impossible to enforce. Consider that
> any memory device can be removed at any time and may not be removed in
> the order in which the device allocated switch decoders in the topology.
>

sorry, don't understand, could you take a example ?

IMO, the simple change in question will always get a free decoder with
the minimal ID once 1/ is ensured regardless of de-allocation approach.

> So, that existing comment of needing to enforce ordered allocation is
> still relevant even though the implementation fails to handle the
> out-of-order region deallocation problem.
> 
> I alluded to the need for a "tear down the world" implementation back in
> 2022 [1], but never got around to finishing that.
> 
> Now, the cxl_port.hdm_end attribute tracks the "last" decoder to be
> allocated for endpoint ports. That same tracking needs to be added for
> switch ports, then this routine could check for ordering constraints by:
> 
>     /* enforce hardware ordered allocation */
>     if (!cxld->region && port->hdm_end + 1 == cxld->id)
>         return 1;
>     return 0;
> 
> As it stands now @hdm_end is never updated for switch ports.
> 
> [1]: 176baefb2eb5 cxl/hdm: Commit decoder state to hardware
> 
> 
> 
> 
> 
> 
> 
> Yes, that looks simple enough for now, although lets not use a ternary
> condition and lets leave a comment for the next person:
> 
> /* decoders are added in hardware id order
>  * (devm_cxl_enumerate_decoders), allocated to regions in id order
>  * (device_find_child() walks children in 'add' order)
>  */
>>  }
>>
>>  static int match_auto_decoder(struct device *dev, void *data)
>> @@ -840,7 +830,6 @@ cxl_region_find_decoder(struct cxl_port *port,
>>                         struct cxl_region *cxlr)
>>  {
>>         struct device *dev;
>> -       int id = 0;
>>
>>         if (port == cxled_to_port(cxled))
>>                 return &cxled->cxld;
>> @@ -849,7 +838,7 @@ cxl_region_find_decoder(struct cxl_port *port,
>>                 dev = device_find_child(&port->dev, &cxlr->params,
>>                                         match_auto_decoder);
>>         else
>> -               dev = device_find_child(&port->dev, &id,
>> match_free_decoder);
>> +               dev = device_find_child(&port->dev, NULL,
>> match_free_decoder);
>>         if (!dev)
>>                 return NULL;
>>
>>
> 
> 


