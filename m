Return-Path: <netdev+bounces-116572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F4B94B012
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 20:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D250D28457E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A98813E8B6;
	Wed,  7 Aug 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="w7TFhca1"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC82770E;
	Wed,  7 Aug 2024 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056863; cv=none; b=X9H8RrdSV2D67nhKWY5ICQJdOYp9Y7Ja74JH/gcmLcFj/qtjb3FcUqVmnZqSTvVw9nenLgtrgWiqQFhR8npXvzx7Nnyc6J7MpE1v5ORfGaqaP7apwHRP60iYNwaYCNLUy9bTp4ZsHtTO/8jO0Uj8jTjszDJF83exr2xgnn/d9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056863; c=relaxed/simple;
	bh=Oy3Arc9xnm29CObRN4hnz61tzv8F5MKNJjwlTCeU/D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwEICz14WjSSTp2ENWgbyeVJUkzMSQS4u5thgJiMuPrxrK2NjAUZHzo6IFedwhK7jiA9zU90v09tuB2MwZmE0vZBB3c541neZlEQ4EpkIZFDBS9U6L1sRSRehvIsR0s9XmX0Fhj01W6nNXdemabim/GHE6k8M5FW++f0xSNOqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=w7TFhca1; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from [192.168.10.7] (unknown [10.0.12.132])
	by kozue.soulik.info (Postfix) with ESMTPSA id ECB522FE4F7;
	Thu,  8 Aug 2024 03:54:47 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info ECB522FE4F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1723056888; bh=a4G2GaIu3qEW2hkacxQ3XBO0hk1/jOYpCv/D8YD+r2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=w7TFhca1n/5Pp47Cz5kUFBfYNgckGPV3rQicX+X+b0Xw3eMg3VJyAXXbyB4K9TZvG
	 CnpnrMRcFmn5XthsMw5iq8v+OblghItw5l9D86UZ4AHukmaTrAVSbCLnSaPlqYYJOn
	 NInnI6EemCUkIlNVm4hy2s0LvBe+4GzJIz/5D+JY=
Message-ID: <3a3695a1-367c-4868-b6e1-1190b927b8e7@soulik.info>
Date: Thu, 8 Aug 2024 02:54:12 +0800
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
 <343bab39-65c5-4f02-934b-84b6ceed1c20@soulik.info>
 <66ab99162673_246b0d29496@willemb.c.googlers.com.notmuch>
 <328c71e7-17c7-40f4-83b3-f0b8b40f4730@soulik.info>
 <66acf6cc551a0_2751b6294bf@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Randy Li <ayaka@soulik.info>
In-Reply-To: <66acf6cc551a0_2751b6294bf@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Willem

On 2024/8/2 23:10, Willem de Bruijn wrote:
> Randy Li wrote:
>> On 2024/8/1 22:17, Willem de Bruijn wrote:
>>> Randy Li wrote:
>>>> On 2024/8/1 21:04, Willem de Bruijn wrote:
>>>>> Randy Li wrote:
>>>>>> On 2024/8/1 05:57, Willem de Bruijn wrote:
>>>>>>> nits:
>>>>>>>
>>>>>>> - INDX->INDEX. It's correct in the code
>>>>>>> - prefix networking patches with the target tree: PATCH net-next
>>>>>> I see.
>>>>>>> Randy Li wrote:
>>>>>>>> On 2024/7/31 22:12, Willem de Bruijn wrote:
>>>>>>>>> Randy Li wrote:
>>>>>>>>>> We need the queue index in qdisc mapping rule. There is no way to
>>>>>>>>>> fetch that.
>>>>>>>>> In which command exactly?
>>>>>>>> That is for sch_multiq, here is an example
>>>>>>>>
>>>>>>>> tc qdisc add dev  tun0 root handle 1: multiq
>>>>>>>>
>>>>>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>>>>>>>> 172.16.10.1 action skbedit queue_mapping 0
>>>>>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>>>>>>>> 172.16.10.20 action skbedit queue_mapping 1
>>>>>>>>
>>>>>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>>>>>>>> 172.16.10.10 action skbedit queue_mapping 2
>>>>>>> If using an IFF_MULTI_QUEUE tun device, packets are automatically
>>>>>>> load balanced across the multiple queues, in tun_select_queue.
>>>>>>>
>>>>>>> If you want more explicit queue selection than by rxhash, tun
>>>>>>> supports TUNSETSTEERINGEBPF.
>>>>>> I know this eBPF thing. But I am newbie to eBPF as well I didn't figure
>>>>>> out how to config eBPF dynamically.
>>>>> Lack of experience with an existing interface is insufficient reason
>>>>> to introduce another interface, of course.
>>>> tc(8) was old interfaces but doesn't have the sufficient info here to
>>>> complete its work.
>>> tc is maintained.
>>>
>>>> I think eBPF didn't work in all the platforms? JIT doesn't sound like a
>>>> good solution for embeded platform.
>>>>
>>>> Some VPS providers doesn't offer new enough kernel supporting eBPF is
>>>> another problem here, it is far more easy that just patching an old
>>>> kernel with this.
>>> We don't add duplicative features because they are easier to
>>> cherry-pick to old kernels.
>> I was trying to say the tc(8) or netlink solution sound more suitable
>> for general deploying.
>>>> Anyway, I would learn into it while I would still send out the v2 of
>>>> this patch. I would figure out whether eBPF could solve all the problem
>>>> here.
>>> Most importantly, why do you need a fixed mapping of IP address to
>>> queue? Can you explain why relying on the standard rx_hash based
>>> mapping is not sufficient for your workload?
>> Server
>>
>>     |
>>
>>     |------ tun subnet (e.x. 172.16.10.0/24) ------- peer A (172.16.10.1)
>>
>> |------ peer B (172.16.10.3)
>>
>> |------  peer C (172.16.10.20)
>>
>> I am not even sure the rx_hash could work here, the server here acts as
>> a router or gateway, I don't know how to filter the connection from the
>> external interface based on rx_hash. Besides, VPN application didn't
>> operate on the socket() itself.
>>
>> I think this question is about why I do the filter in the kernel not the
>> userspace?
>>
>> It would be much more easy to the dispatch work in kernel, I only need
>> to watch the established peer with the help of epoll(). Kernel could
>> drop all the unwanted packets. Besides, if I do the filter/dispatcher
>> work in the userspace, it would need to copy the packet's data to the
>> userspace first, even decide its fate by reading a few bytes from its
>> beginning offset. I think we can avoid such a cost.
> A custom mapping function is exactly the purpose of TUNSETSTEERINGEBPF.
>
> Please take a look at that. It's a lot more elegant than going through
> userspace and then inserting individual tc skbedit filters.

I checked how this socket filter works, I think we still need this 
serial of patch.

If I was right, this eBPF doesn't work like a regular socket filter. The 
eBPF's return value here means the target queue index not the size of 
the data that we want to keep from the sk_buf parameter's buf.

Besides, according to 
https://ebpf-docs.dylanreimerink.nl/linux/program-type/BPF_PROG_TYPE_SOCKET_FILTER/

I think the eBPF here can modify neither queue_mapping field nor hash 
field here.

> See SKF_AD_QUEUE for classic BPF and __sk_buff queue_mapping for eBPF.

Is it a map type BPF_MAP_TYPE_QUEUE?

Besides, I think the eBPF in TUNSETSTEERINGEBPF would NOT take 
queue_mapping.

If I want to drop packets for unwanted destination, I think 
TUNSETFILTEREBPF is what I need?

That would lead to lookup the same mapping table twice, is there a 
better way for the CPU cache?


