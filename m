Return-Path: <netdev+bounces-269947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB9ZCothvWlF9gIAu9opvQ
	(envelope-from <netdev+bounces-269947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:02:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B93152DC3A1
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A14830D2767
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98BF3C73C6;
	Fri, 20 Mar 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StaLU4K7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D853C73C1
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018226; cv=none; b=kKprQoSEyz7C3T/P3/k19AGOkNmwMoDwyrBCl6WhHVojbCD4gJkt+YEPR24SNbX1B7TgZnk795YkstuZm9pYJBLMK6BxK5VzgoGHt+VU+pc1WdLdztScpE0eW7Z/NxzJKs5Ecsou1wk4ggFSPrXBDK9HInA8fJMcLbLnWV/n1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018226; c=relaxed/simple;
	bh=9r15zkBRZgwHE45GRs5lXdJzPqzlupyf2mT5NujU6Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJghCFfNyH9aSTNWnPu+lV5NYU8pEJLCHM+a8hma1EJeICNvsiNqsB1oyXkw+GontJBn+mT1mUmznEduDpzmwY60GiuiqOMet7JpRNqh/Ca9UF6ET1NVbY+hI7BQB2TZNe5QyfM1pF7jB2UvR5aqGUwi2zmzBL0Rx0CYWbKkSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StaLU4K7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA71CC19425;
	Fri, 20 Mar 2026 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774018226;
	bh=9r15zkBRZgwHE45GRs5lXdJzPqzlupyf2mT5NujU6Xc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=StaLU4K7CFQC4Fqr7Kx65Rk1h+jxfT+1iiTzNHdiSrtNUtd9YQafIUrgG5/PnbpoT
	 3SzeU9b2seBxjoSTT26dq0ewhF4Hh2kCBF5bE1EwunC6SoeHpdrPksFyNphiR80Ibe
	 jVpFbYuP6zWB6IH109kgz7CywLVSJFzm60f7IHem58QOBdM7WPQrSHi+IDhN77k9Mg
	 KMJD1m+h0QyO+UFv39M1GITMDDFIV7TmPRylS6v+YyBKwa3YshR2FdDOuIyd/Q3COz
	 44RxL1qcXV80wG3MiHlkMCbAjh2d1Z5jN02qv2NP0mjvZuDGeqcR1Dyn+iMnXrank9
	 LzCP6ymn6Ny4g==
Message-ID: <6d1b8a33-b645-4ab4-b459-36e826052e48@kernel.org>
Date: Fri, 20 Mar 2026 15:50:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 2/6] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@fomichev.me,
 j.koeppeler@tu-berlin.de, mfreemon@cloudflare.com, carges@cloudflare.com,
 kernel-team <kernel-team@cloudflare.com>
References: <20260318134826.1281205-1-hawk@kernel.org>
 <20260318134826.1281205-3-hawk@kernel.org> <87ms05nrdw.fsf@toke.dk>
 <cbfc927d-0b96-4788-8bf6-8a2ffa4dd9f4@kernel.org> <87h5qcnnjh.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87h5qcnnjh.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269947-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B93152DC3A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 19/03/2026 11.04, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
>> On 18/03/2026 15.28, Toke Høiland-Jørgensen wrote:
>>> hawk@kernel.org writes:
>>>
>>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>
>>>> Add BQL support to the veth driver to dynamically limit the number of
>>>> bytes queued in the ptr_ring, giving the qdisc earlier feedback to shape
>>>> traffic and reduce latency.
>>>>
>>>> The BQL charge (netdev_tx_sent_queue) is placed in veth_xmit() BEFORE
>>>> veth_forward_skb() produces the SKB into the ptr_ring. This ordering is
>>>> critical: with threaded NAPI the consumer runs on a separate CPU and can
>>>> complete the SKB (calling dql_completed) before veth_xmit() returns. If
>>>> the charge happened after the produce, the completion could race ahead
>>>> of the charge, violating dql_completed()'s invariant that completed
>>>> bytes never exceed queued bytes (BUG_ON).
>>>>
>>>> Whether an SKB was BQL-charged is tracked per-SKB using a VETH_BQL_FLAG
>>>> bit in the ptr_ring pointer (BIT(1), alongside the existing VETH_XDP_FLAG
>>>> BIT(0)). The do_bql flag from veth_xmit() propagates through
>>>> veth_forward_skb() and veth_xdp_rx() into the ptr_ring entry. On the
>>>> completion side in veth_xdp_rcv(), veth_ptr_is_bql() reads the flag to
>>>> decide whether to call netdev_tx_completed_queue(). Per-SKB tracking is
>>>> necessary because the qdisc can be replaced live (e.g. noqueue->sfq or
>>>> vice versa via 'tc qdisc replace') while SKBs are already in-flight in
>>>> the ptr_ring. SKBs charged under the old qdisc must complete correctly
>>>> regardless of what qdisc is attached when the consumer runs, so each
>>>> SKB carries its own BQL-charged state rather than re-checking the peer's
>>>> qdisc at completion time.
>>>
>>> It's not completely obvious to me why BQL can't be active regardless of
>>> whether there's a qdisc installed or not? If there's no qdisc, shouldn't
>>> BQL auto-tune to a higher value because the queue runs empty more?
>>>
>>
>> When net_device don't have qdisc we hit this code path:
>>    - [0]
>> https://elixir.bootlin.com/linux/v7.0-rc4/source/net/core/dev.c#L4806-L4852
>>    - Notice the check if(!netif_xmit_stopped(txq))
>>    - resulting in "Virtual device %s asks to queue packet!"
>>
>> We cannot unconditionally track BQL as calling netdev_tx_sent_queue()
>> can result in setting STACK_XOFF.  Resulting in above code dropping
>> packets and complaining.  (It have no qdisc to requeue store back-
>> pressured packet).
> 
> Ah, right. I realised the packet would be dropped, of course, but I did
> not realise the stack would complain. That seems... odd? Why not just
> get rid of the complaint instead of having this kludge to work around
> it?
> 

The BQL code manipulates txq (struct dql) and this requires correct
locking. Using noqueue on veth doesn't do the correct locking.

In the linked[0] code you were likely fooled by this code line[1]:
  HARD_TX_LOCK(dev, txq, cpu);
It is actually not taking the lock, because veth is a lltx device.
(Don't be fooled by the annotation it is for WARN_CONTEXT_ANALYSIS)

For fun I actually implemented it to see what happened. And I did manage
to crash the kernel on the DQL internal BUG_ON.  Analyzing the BUG_ON I
realized that my scheme of charging BQL and then undo the charge (if
ptr_ring were full) isn't correct, there is a race.  The BQL call
netdev_tx_completed_queue() is strictly to be used by the consumer, not
by the producer (like I did).

I'm now working on different approaches for the undo...

--Jesper

[1] https://elixir.bootlin.com/linux/v7.0-rc4/source/net/core/dev.c#L4831
[2] 
https://elixir.bootlin.com/linux/v7.0-rc4/source/include/linux/compiler-context-analysis.h#L166

