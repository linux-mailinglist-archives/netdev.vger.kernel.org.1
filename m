Return-Path: <netdev+bounces-114871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEEF944800
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B812E1F21539
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5AE16F910;
	Thu,  1 Aug 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="YTbprTLY"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B424594D;
	Thu,  1 Aug 2024 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503731; cv=none; b=JaPpeXsbnWcqSnhRqAD2GLjLwFwbvzpLaD6quVTzQsQ3fxZBUDSiLog4d5tkZWAsfQ/9XRjO4xzIhxZuOQ//q1nLF4n7mxJpkps40ETj0QQyO/4yOHWv+KUoThJ2+bR89caQL8ehIorXzmXXolCJxTa0yaba8QWMAlCJkrldqSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503731; c=relaxed/simple;
	bh=cbzefxrzQ80Dfzy2Ho2K90TDriu/T8sdcVwC9iQMHyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLSHTaRVRfWjlKTxoYNavnsCnh2WqFJ73QesstrZRA59xTDIPSABtbQC+GEoKSYVtrgUkrox+GqATGAXeiuz7eLb1u+H57pX47b4ldIWILh1NhuPkcxA4UVV95AC6ZlK5YgrgWVgyFaCPn1AOITr2/lSH8p0ktlBHop3i0FFckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=YTbprTLY; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from [192.168.10.7] (unknown [10.0.12.132])
	by kozue.soulik.info (Postfix) with ESMTPSA id D09172FE3D7;
	Thu,  1 Aug 2024 18:15:52 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info D09172FE3D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1722503753; bh=6QQd4dc8kiPVSmwmqkksH22s5o2u6z3WEqgTrQlwiyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YTbprTLY4i35TB6ksB4wXO/HTlmeRSisYB180z9eAlrorWx4Ro70KP6ftoojNr1O6
	 4ftUUsSkg3s9w1hVlFTVaBMdli9jlvBFBbVVy4QvPCxdNUEKYFnBvPJxoZ32/ObzCs
	 ZXckQT6F05XPKzWjVGWX9eLQJYMpfa5jqauGl75E=
Message-ID: <3d8b1691-6be5-4fe5-aa3f-58fd3cfda80a@soulik.info>
Date: Thu, 1 Aug 2024 17:15:26 +0800
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
Content-Language: en-US
From: Randy Li <ayaka@soulik.info>
In-Reply-To: <66aab3614bbab_21c08c29492@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/8/1 05:57, Willem de Bruijn wrote:
> nits:
>
> - INDX->INDEX. It's correct in the code
> - prefix networking patches with the target tree: PATCH net-next
I see.
>
> Randy Li wrote:
>> On 2024/7/31 22:12, Willem de Bruijn wrote:
>>> Randy Li wrote:
>>>> We need the queue index in qdisc mapping rule. There is no way to
>>>> fetch that.
>>> In which command exactly?
>> That is for sch_multiq, here is an example
>>
>> tc qdisc add dev  tun0 root handle 1: multiq
>>
>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>> 172.16.10.1 action skbedit queue_mapping 0
>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>> 172.16.10.20 action skbedit queue_mapping 1
>>
>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst
>> 172.16.10.10 action skbedit queue_mapping 2
> If using an IFF_MULTI_QUEUE tun device, packets are automatically
> load balanced across the multiple queues, in tun_select_queue.
>
> If you want more explicit queue selection than by rxhash, tun
> supports TUNSETSTEERINGEBPF.

I know this eBPF thing. But I am newbie to eBPF as well I didn't figure 
out how to config eBPF dynamically.

Besides, I think I still need to know which queue is the target in eBPF.

>> The purpose here is taking advantage of the multiple threads. For the
>> the server side(gateway of the tunnel's subnet), usually a different
>> peer would invoked a different encryption/decryption key pair, it would
>> be better to handle each in its own thread. Or the application would
>> need to implement a dispatcher here.
> A thread in which context? Or do you mean queue?
The thread in the userspace. Each thread responds for a queue.
>
>> I am newbie to the tc(8), I verified the command above with a tun type
>> multiple threads demo. But I don't know how to drop the unwanted ingress
>> filter here, the queue 0 may be a little broken.
> Not opposed to exposing the queue index if there is a need. Not sure
> yet that there is.
>
> Also, since for an IFF_MULTI_QUEUE the queue_id is just assigned
> iteratively, it can also be inferred without an explicit call.

I don't think there would be sequence lock in creating multiple queue. 
Unless application uses an explicitly lock itself.

While that did makes a problem when a queue would be disabled. It would 
swap the last queue index with that queue, leading to fetch the queue 
index calling again, also it would request an update for the qdisc flow 
rule.

Could I submit a ***new*** PATCH which would peak a hole, also it 
applies for re-enabling the queue.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 1d06c560c5e6..5473a0fca2e1 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3115,6 +3115,10 @@ static long __tun_chr_ioctl(struct file *file, 
> unsigned int cmd,
>           if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
>               return -EPERM;
>           return open_related_ns(&net->ns, get_net_ns);
> +    } else if (cmd == TUNGETQUEUEINDEX) {
> +        if (tfile->detached)
> +            return -EINVAL;
> +        return put_user(tfile->queue_index, (unsigned int __user*)argp);
> Unless you're certain that these fields can be read without RTNL, move
> below rtnl_lock() statement.
> Would fix in v2. 
I was trying to not hold the global lock or long period, that is why I 
didn't made v2 yesterday.

When I wrote this,  I saw ioctl() TUNSETQUEUE->tun_attach() above. Is 
the rtnl_lock() scope the lighting lock here?


