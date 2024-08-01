Return-Path: <netdev+bounces-114974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5486D944D42
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DAE1C22694
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9843213D520;
	Thu,  1 Aug 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="AMzWmzK0"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD8184549;
	Thu,  1 Aug 2024 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519403; cv=none; b=Dn3O3mLOVETbJtwqZQjN8grNYBM7PdYZ1Xr9CHll1Df+nxSQErk8vZ/J1Ido/5jOy3i+1f2ie8M/ilm2u/mX22Hsr2Piq2o5/kwZhiRzRKDiTXSYlVLsSDV+zA+Oy6ZfnPkmBNhh2pFjuYOIU2oyzalqPCDmrFXrqb1SI4DeApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519403; c=relaxed/simple;
	bh=ynpXurisuzSktHZ14DE8V6WfFeptJq60/86lwduYK2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ple3ifS6TD38yfoD21QqK19oo8fbup9Gh22a0wz4y8aCYTwS2U5qbpAPVOCfhd0bTNjXViAHLcPahGuAF6CKKNS267pJ3mqoF8DN2C5jOUb9+NLGGcigf1iuBk9Y5O+cirsgryiKotCEgazq81thY38SuB9vuc4Gm9Wwe4IHiS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=AMzWmzK0; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from [192.168.10.7] (unknown [10.0.12.132])
	by kozue.soulik.info (Postfix) with ESMTPSA id 675042FE3AC;
	Thu,  1 Aug 2024 22:36:58 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 675042FE3AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1722519419; bh=BP3sbfO++9xPVzs6EcUXJ/7nk/Ud/Qrbf6PGYuMSR0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AMzWmzK0AWJGnoHSh6ckpmtspv9OKUrGhNGtVy/4Jj7ci4cxglMmgqFuW2EtYBqmB
	 s/KQCKGL1cFonFNr37UZYA/cWUXF2vuFrhaJ71jT75K2GxraN7lvc+Qze69SFgd5Zi
	 jyB93IMhP1HcMCStWHQef7SGc6G55lB2+5Vyg5sc=
Message-ID: <343bab39-65c5-4f02-934b-84b6ceed1c20@soulik.info>
Date: Thu, 1 Aug 2024 21:36:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue
 index
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20240731111940.8383-1-ayaka@soulik.info>
 <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
 <bd69202f-c0da-4f46-9a6c-2375d82a2579@soulik.info>
 <66aab3614bbab_21c08c29492@willemb.c.googlers.com.notmuch>
 <3d8b1691-6be5-4fe5-aa3f-58fd3cfda80a@soulik.info>
 <66ab87ca67229_2441da294a5@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Randy Li <ayaka@soulik.info>
In-Reply-To: <66ab87ca67229_2441da294a5@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/8/1 21:04, Willem de Bruijn wrote:
> Randy Li wrote:
>> On 2024/8/1 05:57, Willem de Bruijn wrote:
>>> nits:
>>>
>>> - INDX->INDEX. It's correct in the code
>>> - prefix networking patches with the target tree: PATCH net-next
>> I see.
>>> Randy Li wrote:
>>>> On 2024/7/31 22:12, Willem de Bruijn wrote:
>>>>> Randy Li wrote:
>>>>>> We need the queue index in qdisc mapping rule. There is no way to
>>>>>> fetch that.
>>>>> In which command exactly?
>>>> That is for sch_multiq, here is an example
>>>>
>>>> tc qdisc add dev  tun0 root handle 1: multiq
>>>>
>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>>>> 172.16.10.1 action skbedit queue_mapping 0
>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>>>> 172.16.10.20 action skbedit queue_mapping 1
>>>>
>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>>>> 172.16.10.10 action skbedit queue_mapping 2
>>> If using an IFF_MULTI_QUEUE tun device, packets are automatically
>>> load balanced across the multiple queues, in tun_select_queue.
>>>
>>> If you want more explicit queue selection than by rxhash, tun
>>> supports TUNSETSTEERINGEBPF.
>> I know this eBPF thing. But I am newbie to eBPF as well I didn't figure
>> out how to config eBPF dynamically.
> Lack of experience with an existing interface is insufficient reason
> to introduce another interface, of course.

tc(8) was old interfaces but doesn't have the sufficient info here to 
complete its work.

I think eBPF didn't work in all the platforms? JIT doesn't sound like a 
good solution for embeded platform.

Some VPS providers doesn't offer new enough kernel supporting eBPF is 
another problem here, it is far more easy that just patching an old 
kernel with this.

Anyway, I would learn into it while I would still send out the v2 of 
this patch. I would figure out whether eBPF could solve all the problem 
here.

>> Besides, I think I still need to know which queue is the target in eBPF.
> See SKF_AD_QUEUE for classic BPF and __sk_buff queue_mapping for eBPF.
I would look into it. Wish I don't need the patch that keeps the queue 
index unchanged.
>>>> The purpose here is taking advantage of the multiple threads. For the
>>>> the server side(gateway of the tunnel's subnet), usually a different
>>>> peer would invoked a different encryption/decryption key pair, it would
>>>> be better to handle each in its own thread. Or the application would
>>>> need to implement a dispatcher here.
>>> A thread in which context? Or do you mean queue?
>> The thread in the userspace. Each thread responds for a queue.
>>>> I am newbie to the tc(8), I verified the command above with a tun type
>>>> multiple threads demo. But I don't know how to drop the unwanted ingress
>>>> filter here, the queue 0 may be a little broken.
>>> Not opposed to exposing the queue index if there is a need. Not sure
>>> yet that there is.
>>>
>>> Also, since for an IFF_MULTI_QUEUE the queue_id is just assigned
>>> iteratively, it can also be inferred without an explicit call.
>> I don't think there would be sequence lock in creating multiple queue.
>> Unless application uses an explicitly lock itself.
>>
>> While that did makes a problem when a queue would be disabled. It would
>> swap the last queue index with that queue, leading to fetch the queue
>> index calling again, also it would request an update for the qdisc flow
>> rule.
>>
>> Could I submit a ***new*** PATCH which would peak a hole, also it
>> applies for re-enabling the queue.
>>
>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>> index 1d06c560c5e6..5473a0fca2e1 100644
>>> --- a/drivers/net/tun.c
>>> +++ b/drivers/net/tun.c
>>> @@ -3115,6 +3115,10 @@ static long __tun_chr_ioctl(struct file *file,
>>> unsigned int cmd,
>>>            if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
>>>                return -EPERM;
>>>            return open_related_ns(&net->ns, get_net_ns);
>>> +    } else if (cmd == TUNGETQUEUEINDEX) {
>>> +        if (tfile->detached)
>>> +            return -EINVAL;
>>> +        return put_user(tfile->queue_index, (unsigned int __user*)argp);
>>> Unless you're certain that these fields can be read without RTNL, move
>>> below rtnl_lock() statement.
>>> Would fix in v2.
>> I was trying to not hold the global lock or long period, that is why I
>> didn't made v2 yesterday.
>>
>> When I wrote this,  I saw ioctl() TUNSETQUEUE->tun_attach() above. Is
>> the rtnl_lock() scope the lighting lock here?
>>
>

