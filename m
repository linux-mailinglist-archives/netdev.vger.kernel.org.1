Return-Path: <netdev+bounces-252412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOoNE4FWcmkpiwAAu9opvQ
	(envelope-from <netdev+bounces-252412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:55:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C49316A702
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BDAD302837C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5C138170B;
	Thu, 22 Jan 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="botm2txQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282E3612C9;
	Thu, 22 Jan 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095986; cv=none; b=RM10eYQI7mjnN7ecDBf6e3Juco29cl4SF16bYAlpMAiS6BbQm4wrh8msYDouMih6MftSiGS6Lp226RvAsH9ejn8dCaOLDTIciDEAIUkNLYFvm5ik45WVDZUIshzic7o754C5pTPxEaWqZenJpkGrc+f7Vi9/M4sRmuY5FxwDmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095986; c=relaxed/simple;
	bh=DhY6iCfrE0xXdQhG98LPqIekLtebh744G12unCjSROE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcFajwDwmL3mqGsYh+wCYnUc6oG7BzLJ+CgSeTxAyJTaKPsD8VRrbS0pTB2YDVwy9BB6cNycTxA/bX552hiLfnVJoVCZkZmUsGa73o8nmwz2Zv6GwJM+r66zcsWek6KDjjaMRjjVS0uLwwewfDfeoCeT3Z4cf5y+yyzfM+uGvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=botm2txQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E812C116C6;
	Thu, 22 Jan 2026 15:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769095984;
	bh=DhY6iCfrE0xXdQhG98LPqIekLtebh744G12unCjSROE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=botm2txQS4Dz6OE6o2EWr6QLjXyALBmvvyNKKh0s4gptJ/V55Q/CYphZdv798g4DP
	 0zPkXVTejK7jYtaM5bGcYCldjC7C2zdRnUokyUw18zAMVGt+lkbhzcUHQQ/bzAN2A3
	 guBXtD/kjkwYcjgzQRpkx5EFZ1fYqE3A1boItERAcmIV/OH2VgFkmnUPrZcf31R1gD
	 eDpwknjjiW0Fs5Zf+7N326mjxLxwXaJFU58CzE+lFpDwTf+PP8Bod8rgewcWei2d15
	 7Cw1eATxzYHIAKXTzsXNQU89sOCCBis4HjpJuZAkAyxmAYO9mHXzPfe0So0b7pRo08
	 k6GEj5SbR77gg==
Message-ID: <28911dac-6aec-42ce-9101-9071e18e1522@kernel.org>
Date: Thu, 22 Jan 2026 16:33:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons
 for monitoring
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 carges@cloudflare.com, kernel-team@cloudflare.com,
 Yan Zhai <yan@cloudflare.com>
References: <176847978787.939583.16722243649193888625.stgit@firesoul>
 <1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
 <20260120162616.463c8af1@kernel.org>
 <412b91a2-15f3-4a5f-8f1a-249c9d79cb41@kernel.org>
 <20260121172155.6ec96ef8@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260121172155.6ec96ef8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252412-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C49316A702
X-Rspamd-Action: no action




On 22/01/2026 02.21, Jakub Kicinski wrote:
> On Wed, 21 Jan 2026 20:13:31 +0100 Jesper Dangaard Brouer wrote:
>>>> I noticed commit 5765c7f6e317 ("net_sched: sch_fq: add three
>>>> drop_reason") (Author: Eric Dumazet).
>>>>
>>>>     SKB_DROP_REASON_FQ_BAND_LIMIT: Per-band packet limit exceeded
>>>>     SKB_DROP_REASON_FQ_HORIZON_LIMIT: Packet timestamp too far in future
>>>>     SKB_DROP_REASON_FQ_FLOW_LIMIT: Per-flow packet limit exceeded
>>>>
>>>> Should I/we make SKB_DROP_REASON_QDISC_MAXDEPTH specific for SFQ ?
>>>> Like naming it = SKB_DROP_REASON_SFQ_MAXDEPTH ?
>>>
>>> FWIW FLOW_LIMIT is more intuitive to me, but I'm mostly dealing with
>>> fq so probably because that's the param name there.
>>>
>>> I'd prefer the reuse (just MAXDEPTH, I don't see equivalent of
>>> MAXFLOWS?). We assign multiple names the same values in the enum to
>>> avoid breaking FQ users.
>>
>> I've taken a detailed look at how we consume this in production and what
>> Prometheus metrics that we generate. My conclusion is that, we want to
>> keep the Eric's approach of having qdisc specific drop-reason (that
>> relates to qdisc tunables), but extend this with a prefix
>> "SKB_DROP_REASON_QDISC_xxx". This is what I implemented in [v2] like
>> "SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS".  The QDISC_ prefix enables pattern
>> matching for qdisc-related drops allowing monitoring tools to match this
>> for categorizing new/future drop reasons into same qdisc category.
>>
>> For Prometheus drop_reason metrics the decision was to omit the
>> net_device label to keep the metric counts manageable and avoid
>> exploding the number of time series (lower cardinality, less storage).
>> Without qdisc-specific names in the enum, we'd be forced to add back the
>> net_device label, which would explode our time series count.
>>
>> The FQ flow_limit and SFQ depth parameters have different semantics: FQ
>> uses exact flow classification while SFQ uses stochastic hashing. They
>> also have different defaults (FQ: 100 packets, SFQ: 127 packets). Having
>> the same drop_reason for both would obscure which qdisc's tunable needs
>> adjustment when analyzing production drops.
>>
>> Having more enum numbers for drop reasons is essentially free, while
>> keeping metrics per net_device is expensive in terms of storage and
>> query performance.
> 
> I'm not familiar with Prometheus is there some off-the-shelf plugin
> which exports the drops? 

(I assume you are familiar with Prometheus cardinality explosion problem?)
We have written our own drop-reason monitor that exports drop_reason
enums directly to Prometheus (without decoding netdev or qdisc
information). (Irrelevant: we also collect sampled (e.g. 1/4000) copies
of packet data to userspace where we collect as much metadata as
possible, but that is too expensive to do for every packet).

> The kfree_skb tracepoint does not have netdev,

Correct, the kfree_skb tracepoint does not have netdev avail.
I'm also saying that I don't want the netdev, because that would
explode/increase the Prometheus metric data.

> so if you're saying you have the ability to see the netdev then
> presumably there's some BPF in the mix BTF'ing the netdev info out.
> And if you can read the netdev info, you can as well read
> netdev->qdisc->ops->id and/or netdev->_tx[0]->qdisc->ops->id
> 
> It kinda reads to me like you're trying to encode otherwise-reachable
> metadata into the drop reason.

This feels like a misunderstanding. We don't want to (somehow) decode
extra metadata like netdev or qdisc.  First of all we don't want to
spend extra BPF prog cycles doing this (if it's even possible), and
secondly we want to keep metric simple (see cardinality explosion).

I'm simply saying let us keep Eric's current approach of having qdisc
specific drop-reason *when* those relates to qdisc specific tunables.
And I'm arguing that FQ flow_limit and SFQ depth are two different
things, and should have their own enums.
   I have a specific production use-case, where I want configure SFQ to
have small flow "depth" to penalize elefant flows, so I'm okay with
SKB_DROP_REASON_SFQ_MAXDEPTH events.  So, I want to be able to tell this
apart from FQ drops (SKB_DROP_REASON_FQ_FLOW_LIMIT). I hope that this
makes it clear why I want this to be separate enums(?)

--Jesper


