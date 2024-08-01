Return-Path: <netdev+bounces-115117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758F94538A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BB0281A0B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6146149C46;
	Thu,  1 Aug 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="wXEMXIDI"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAE14AA9;
	Thu,  1 Aug 2024 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541981; cv=none; b=aC2CJ4tYapAt8QJIRu+JtkcvS5lwuUQwEDKwa76SS7YehAdu+Hl61poSO7GO3GZMwa7w78bxJsNWkO1pcOeSVxQQsYX6DVtRaewUDpgBK/8ByMR3IHbBypXk9XYInHg/4f1cUOYj488fttyXai/VZIKnLiquXu6SkxfNR76RgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541981; c=relaxed/simple;
	bh=nuIZYtjden9cPAxi6LWM1j1FEht2xIVi2QT+VN7bgG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+4vt5Emym+2zPJ0sfjXu05SQ1PlRPErRc1xLCijEMcAUoKD5+LsLX6qZ2Uv5t/zrONW8ISXxvTAcxm2psHg7gU3QglNjPgLf+/zj3YSKAYXf7AdihBtIvGeswzjZuqdsW76eSwnOkPnNPPRPb2zjh5Aeslao0HZ3GGglFJzrws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=wXEMXIDI; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from [192.168.10.7] (unknown [10.0.12.132])
	by kozue.soulik.info (Postfix) with ESMTPSA id DE3A62FE3F0;
	Fri,  2 Aug 2024 04:53:23 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info DE3A62FE3F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1722542004; bh=LQs02GgnJTubPIcXTKpXwjp7GLB8clNv1VWhPwPjiOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wXEMXIDIS177aAwnAgCgI66dVvLYCvASMAGgPKi3IQXBf84eXPokvU+g6ZjBVn8PA
	 eH2FJFUlktGdSGfLgyEC0pAznUV4ZJizkQ6sTUjGisGGwYZN5ZYcE+9k+R4JzfiMEP
	 DuZNC/Pv2H8BtENLCPc1Upyk4xIhOVUa+UdGUzRg=
Message-ID: <328c71e7-17c7-40f4-83b3-f0b8b40f4730@soulik.info>
Date: Fri, 2 Aug 2024 03:52:57 +0800
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
Content-Language: en-US
From: Randy Li <ayaka@soulik.info>
In-Reply-To: <66ab99162673_246b0d29496@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/8/1 22:17, Willem de Bruijn wrote:
> Randy Li wrote:
>> On 2024/8/1 21:04, Willem de Bruijn wrote:
>>> Randy Li wrote:
>>>> On 2024/8/1 05:57, Willem de Bruijn wrote:
>>>>> nits:
>>>>>
>>>>> - INDX->INDEX. It's correct in the code
>>>>> - prefix networking patches with the target tree: PATCH net-next
>>>> I see.
>>>>> Randy Li wrote:
>>>>>> On 2024/7/31 22:12, Willem de Bruijn wrote:
>>>>>>> Randy Li wrote:
>>>>>>>> We need the queue index in qdisc mapping rule. There is no way to
>>>>>>>> fetch that.
>>>>>>> In which command exactly?
>>>>>> That is for sch_multiq, here is an example
>>>>>>
>>>>>> tc qdisc add dev  tun0 root handle 1: multiq
>>>>>>
>>>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>>>>>> 172.16.10.1 action skbedit queue_mapping 0
>>>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>>>>>> 172.16.10.20 action skbedit queue_mapping 1
>>>>>>
>>>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>>>>>> 172.16.10.10 action skbedit queue_mapping 2
>>>>> If using an IFF_MULTI_QUEUE tun device, packets are automatically
>>>>> load balanced across the multiple queues, in tun_select_queue.
>>>>>
>>>>> If you want more explicit queue selection than by rxhash, tun
>>>>> supports TUNSETSTEERINGEBPF.
>>>> I know this eBPF thing. But I am newbie to eBPF as well I didn't figure
>>>> out how to config eBPF dynamically.
>>> Lack of experience with an existing interface is insufficient reason
>>> to introduce another interface, of course.
>> tc(8) was old interfaces but doesn't have the sufficient info here to
>> complete its work.
> tc is maintained.
>
>> I think eBPF didn't work in all the platforms? JIT doesn't sound like a
>> good solution for embeded platform.
>>
>> Some VPS providers doesn't offer new enough kernel supporting eBPF is
>> another problem here, it is far more easy that just patching an old
>> kernel with this.
> We don't add duplicative features because they are easier to
> cherry-pick to old kernels.
I was trying to say the tc(8) or netlink solution sound more suitable 
for general deploying.
>> Anyway, I would learn into it while I would still send out the v2 of
>> this patch. I would figure out whether eBPF could solve all the problem
>> here.
> Most importantly, why do you need a fixed mapping of IP address to
> queue? Can you explain why relying on the standard rx_hash based
> mapping is not sufficient for your workload?

Server

   |

   |------ tun subnet (e.x. 172.16.10.0/24) ------- peer A (172.16.10.1)

|------ peer B (172.16.10.3)

|------  peer C (172.16.10.20)

I am not even sure the rx_hash could work here, the server here acts as 
a router or gateway, I don't know how to filter the connection from the 
external interface based on rx_hash. Besides, VPN application didn't 
operate on the socket() itself.

I think this question is about why I do the filter in the kernel not the 
userspace?

It would be much more easy to the dispatch work in kernel, I only need 
to watch the established peer with the help of epoll(). Kernel could 
drop all the unwanted packets. Besides, if I do the filter/dispatcher 
work in the userspace, it would need to copy the packet's data to the 
userspace first, even decide its fate by reading a few bytes from its 
beginning offset. I think we can avoid such a cost.


