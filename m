Return-Path: <netdev+bounces-121990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF4E95F7BE
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86287283726
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1269D1946D0;
	Mon, 26 Aug 2024 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RdlVNqXD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA51946DA;
	Mon, 26 Aug 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692511; cv=none; b=Bbm24jVwcYVZWGIWpL8CW0EQiD6EEaF7Wx4Ex4Ul1VXuEOwAQAKcKlLc1CIQvHABZ9CQfiXe15GnbMfYf6coTS69xBvHTgBZDDp67r7tMR88jOO6QmSWAiHePWt/ek6jtZCtF01m8a8mpYCKkBd/aK2MIi8qpuqyyqYaCXAMBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692511; c=relaxed/simple;
	bh=XO/V8hWz4NH2myBpWtZGoY/SK13uVHnn+BzlOVcF39I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOXE+WHecr0FPJVLqreKmwKMDm0K/A8evQtFtEqcfUr5OcR1COUZ9RJJlkyNi4AIrq3wjl8Kmwj/Tz/2aLLYRWa+mhqxQCLQXiZjmsLVEWC5FIfQI5T772RvN/uNhIVEf/d5knqjtbIzM/NcEe8TlYk0OSw32sdNcQGjPy5KpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RdlVNqXD; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id idIusKUkBFtEmidIus4Qnh; Mon, 26 Aug 2024 19:15:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724692500;
	bh=NoAjW2R+o80sdyLbdCHHBi35GI05J7LD2G0MnQa6MWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=RdlVNqXDGoIcfOHx16drsR+hMe5aGLy1GFtGLONfa7t0tUPljKNgfBzgYSkDvMuxG
	 RILfXksBLAaN1wlZokC2GYKU2m7jyMde44Bp4jlaVCfHDS3dL0wqkaLPE8LNCe8oxX
	 RMPZ1uwuumGbYzi59I0rFTg6NPB6kMWgbgt3Uem/CBHvAfdF9Kd7JfdgsRaKYsgRUi
	 9vs12BmYVjT3OJ8ewJn+YslnWH5BKNmZRuD3emjhEH87R4tGHUQ4/K64JZCvfR++JG
	 bDslmHqL+dyHAabDSR3ngKZWBtwfXIFWZ8oQGLAOuSWeHFr0aOLbx6dWkuVW5izlH/
	 UE29btMe4pKCQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 26 Aug 2024 19:15:00 +0200
X-ME-IP: 90.11.132.44
Message-ID: <bbe06f51-459a-4973-9322-56b3d27427f1@wanadoo.fr>
Date: Mon, 26 Aug 2024 19:14:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] idpf: Slightly simplify memory management in
 idpf_add_del_mac_filters()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <fa4f19064be084d5e740e625dcf05805c0d71ad0.1724394169.git.christophe.jaillet@wanadoo.fr>
 <c786a345-9ec4-4e41-8e69-506239db291c@stanley.mountain>
 <2896a4b2-2297-44cd-b4c7-a4d320298740@intel.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <2896a4b2-2297-44cd-b4c7-a4d320298740@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/08/2024 à 11:15, Przemek Kitszel a écrit :
> On 8/23/24 11:10, Dan Carpenter wrote:
>> On Fri, Aug 23, 2024 at 08:23:29AM +0200, Christophe JAILLET wrote:
>>> In idpf_add_del_mac_filters(), filters are chunked up into multiple
>>> messages to avoid sending a control queue message buffer that is too 
>>> large.
>>>
>>> Each chunk has up to IDPF_NUM_FILTERS_PER_MSG entries. So except for the
>>> last iteration which can be smaller, space for exactly
>>> IDPF_NUM_FILTERS_PER_MSG entries is allocated.
>>>
>>> There is no need to free and reallocate a smaller array just for the 
>>> last
>>> iteration.
>>>
>>> This slightly simplifies the code and avoid an (unlikely) memory 
>>> allocation
>>> failure.
>>>
> 
> Thanks, that is indeed an improvement.
> 
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c 
>>> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>>> index 70986e12da28..b6f4b58e1094 100644
>>> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>>> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>>> @@ -3669,12 +3669,15 @@ int idpf_add_del_mac_filters(struct 
>>> idpf_vport *vport,
>>>           entries_size = sizeof(struct virtchnl2_mac_addr) * 
>>> num_entries;
>>>           buf_size = struct_size(ma_list, mac_addr_list, num_entries);
>>> -        if (!ma_list || num_entries != IDPF_NUM_FILTERS_PER_MSG) {
>>> -            kfree(ma_list);
>>> +        if (!ma_list) {
>>>               ma_list = kzalloc(buf_size, GFP_ATOMIC);
>>>               if (!ma_list)
>>>                   return -ENOMEM;
>>>           } else {
>>> +            /* ma_list was allocated in the first iteration
>>> +             * so IDPF_NUM_FILTERS_PER_MSG entries are
>>> +             * available
>>> +             */
>>>               memset(ma_list, 0, buf_size);
>>>           }
>>
>> It would be even nicer to move the ma_list allocation outside the loop:
>>
>>          buf_size = struct_size(ma_list, mac_addr_list, 
>> IDPF_NUM_FILTERS_PER_MSG);
>>          ma_list = kmalloc(buf_size, GFP_ATOMIC);
> 
> good point
> 
> I've opened whole function for inspection and it asks for even more,
> as of now, we allocate an array in atomic context, just to have a copy
> of some stuff from the spinlock-protected list.
> 
> It would be good to have allocation as pointed by Dan prior to iteration
> and fill it on the fly, sending when new message would not fit plus once
> at the end. Sending procedure is safe to be called under a spinlock.

If I understand correctly, you propose to remove the initial copy in 
mac_addr and hold &vport_config->mac_filter_list_lock till the end of 
the function?

That's it?

There is a wait_for_completion_timeout() in idpf_vc_xn_exec() and the 
default time-out is IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)

So, should an issue occurs, and the time out run till the end, we could 
hold the 'mac_filter_list_lock' spinlock for up to 60 seconds?
Is that ok?


And if in asynch update mode, idpf_mac_filter_async_handler() also takes 
&vport_config->mac_filter_list_lock;. Could we dead-lock?


So, I'm not sure to understand what you propose, or the code in 
idpf_add_del_mac_filters() and co.

> 
> CCing author; CCing Olek to ask if there are already some refactors that
> would conflict with this.

I'll way a few days for these feedbacks and send a v2.

CJ

> 
>>
>> regards,
>> dan carpenter
>>
> 
> 
> 


