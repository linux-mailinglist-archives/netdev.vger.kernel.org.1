Return-Path: <netdev+bounces-121532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69795D8A2
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B4AB216ED
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88410191493;
	Fri, 23 Aug 2024 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hAq6NSUF"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192EF383BF
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724449551; cv=none; b=cNw5ngvtfjRCdF6irr2Gbkd3wKW6aVnw6/ulM1anr0oT73GwfYxpTyFn8ZRRNt/AWvKf4x4rDuic5Up6iKsmxMLQOJl4zhKqyQ3sTIIVEJYmLwSkVtQqGtcR+22rCd1vIaZzDNolGXhbSJ3f7ZGiodT8Hw0U3zFYc6etqh3ReNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724449551; c=relaxed/simple;
	bh=E2PfdCUWQrf2uDP/LGPSZ+Tax04937a7xG2LwQ2/Qt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lb7ClVC3dAQi61JEmpNYVNZsSg0C2du0QIwFknieBtoW6AYkArmG0O5Bm2ZuwIeCayJqnjAfvtgzRnZiSnFHhRAds1Dkchb/tQzm5D7H3JyBPOjU4CFScRUrdX1SopKJyt9E64RdqTM7MbprnfXQANTucMG34Oe1T1pPsGVB+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hAq6NSUF; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724449549;
	bh=DZT9D0YL+MfAjwfIKWBNhTFYdAQCL09UUBbtbCTuoh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=hAq6NSUF5jOF4WXIIC1s1EIKI8wgKLkEYvh7umYCdZ/XRzo2b93E8q86oKqzvF5sd
	 DQTNxPNHnAbmLfzk33IzhGgrapIqe/fZjn0fh/LRiD2Vg/Ff5v5VzRQdGy4hI59INn
	 MP3iXSL56f+96Bv48hP+RoLtHyAnJH2r/7ELdZZnXBTbsE/nmq+Rqo2+nbxLD8+Uxt
	 gJru1GCaaJMa5gyvk7XU7whC58FvNzd0muIIvzLWgQ+XQnMAyY7SbEINgtlus22GVa
	 MtD4sCegmgH8Tp1bdEcOVo/onBiL8mCt79modaONriIr9mslBbj2EQ/X2jhci5mY8d
	 UnB5qkME5FEhQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id CE61B740123;
	Fri, 23 Aug 2024 21:45:42 +0000 (UTC)
Message-ID: <dcddaabd-8a8a-4ccc-ba38-02088a4134a4@icloud.com>
Date: Sat, 24 Aug 2024 05:45:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] driver core: Make parameter check consistent for
 API cluster device_(for_each|find)_child()
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
 <20240815-const_dfc_prepare-v2-1-8316b87b8ff9@quicinc.com>
 <66c491c32091d_2ddc24294e8@iweiny-mobl.notmuch>
 <2b9fc661-e061-4699-861b-39af8bf84359@icloud.com>
 <66c4a4e15302b_2f02452943@iweiny-mobl.notmuch>
 <e30eac3b-4244-460d-ab0b-baaa659999fe@icloud.com>
 <66c8c4a0633e9_a87cd294f6@iweiny-mobl.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <66c8c4a0633e9_a87cd294f6@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: f32q2jKvmmVMqFEqfpaAeRCwDZQtvNnD
X-Proofpoint-GUID: f32q2jKvmmVMqFEqfpaAeRCwDZQtvNnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408230162

On 2024/8/24 01:19, Ira Weiny wrote:
> Zijun Hu wrote:
>> On 2024/8/20 22:14, Ira Weiny wrote:
>>> Zijun Hu wrote:
>>>> On 2024/8/20 20:53, Ira Weiny wrote:
>>>>> Zijun Hu wrote:
>>>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>
>>>>>> The following API cluster takes the same type parameter list, but do not
>>>>>> have consistent parameter check as shown below.
>>>>>>
>>>>>> device_for_each_child(struct device *parent, ...)  // check (!parent->p)
>>>>>> device_for_each_child_reverse(struct device *parent, ...) // same as above
>>>>>> device_find_child(struct device *parent, ...)      // check (!parent)
>>>>>>
>>>>>
>>>>> Seems reasonable.
>>>>>
>>>>> What about device_find_child_by_name()?
>>>>>
>>>>
>>>> Plan to simplify this API implementation by * atomic * API
>>>> device_find_child() as following:
>>>>
>>>> https://lore.kernel.org/all/20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com
>>>> struct device *device_find_child_by_name(struct device *parent,
>>>>  					 const char *name)
>>>> {
>>>> 	return device_find_child(parent, name, device_match_name);
>>>> }
>>>
>>> Ok.  Thanks.
>>>
>>>>
>>>>>> Fixed by using consistent check (!parent || !parent->p) for the cluster.
>>>>>>
>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>> ---
>>>>>>  drivers/base/core.c | 6 +++---
>>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>>>> index 1688e76cb64b..b1dd8c5590dc 100644
>>>>>> --- a/drivers/base/core.c
>>>>>> +++ b/drivers/base/core.c
>>>>>> @@ -4004,7 +4004,7 @@ int device_for_each_child(struct device *parent, void *data,
>>>>>>  	struct device *child;
>>>>>>  	int error = 0;
>>>>>>  
>>>>>> -	if (!parent->p)
>>>>>> +	if (!parent || !parent->p)
>>>>>>  		return 0;
>>>>>>  
>>>>>>  	klist_iter_init(&parent->p->klist_children, &i);
>>>>>> @@ -4034,7 +4034,7 @@ int device_for_each_child_reverse(struct device *parent, void *data,
>>>>>>  	struct device *child;
>>>>>>  	int error = 0;
>>>>>>  
>>>>>> -	if (!parent->p)
>>>>>> +	if (!parent || !parent->p)
>>>>>>  		return 0;
>>>>>>  
>>>>>>  	klist_iter_init(&parent->p->klist_children, &i);
>>>>>> @@ -4068,7 +4068,7 @@ struct device *device_find_child(struct device *parent, void *data,
>>>>>>  	struct klist_iter i;
>>>>>>  	struct device *child;
>>>>>>  
>>>>>> -	if (!parent)
>>>>>> +	if (!parent || !parent->p)
>>>>>
>>>>> Perhaps this was just a typo which should have been.
>>>>>
>>>>> 	if (!parent->p)
>>>>> ?
>>>>>
>>>> maybe, but the following device_find_child_by_name() also use (!parent).
>>>>
>>>>> I think there is an expectation that none of these are called with a NULL
>>>>> parent.
>>>>>
>>>>
>>>> this patch aim is to make these atomic APIs have consistent checks as
>>>> far as possible, that will make other patches within this series more
>>>> acceptable.
>>>>
>>>> i combine two checks to (!parent || !parent->p) since i did not know
>>>> which is better.
>>>
>>> I'm not entirely clear either.  But checking the member p makes more sense
>>> to me than the parent parameter.  I would expect that iterating the
>>> children of a device must be done only when the parent device is not NULL.
>>>
>>> parent->p is more subtle.  I'm unclear why the API would need to allow
>>> that to run without error.
>>>
>> i prefer (!parent || !parent->p) with below reasons:
>>
>> 1)
>> original API authors have such concern that either (!parent) or
>> (!parent->p) maybe happen since they are checked, all their concerns
>> can be covered by (!parent || !parent->p).
>>
>> 2)
>> It is the more robust than either (!parent) or (!parent->p)
>>
>> 3)
>> it also does not have any negative effect.
> 
> It adds code and instructions to all paths calling these functions.
> 
such slight impacts can be ignored if a machine run linux OS.

right?

> What is the reason to allow?
> 
1)
it allow to use device_for_each_child() without misgiving.

2)
there are many many existing APIs which have similar checks such as
get_device(), kfree()...

> void foo() {
> ...
> 	device_for_each_child(NULL, ...);
> ...
> }
> 
> What are we finding the child of in that case?
>
similar usage as device_find_child(NULL, ...) which have check (!parent).

both device_for_each_child() and device_find_child() iterates over its
child.

original author's concern (!parent->p) for device_for_each_child() is
applicable for the other.

original author's concern (!parent) for device_find_child() is
applicable for the other as well.

so i use (!parent || !parent->p).

> Ira
> 
>>
>>> Ira
>>
> 
> 


