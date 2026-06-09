Return-Path: <netdev+bounces-297060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OJoLNhYeKGoG+QIAu9opvQ
	(envelope-from <netdev+bounces-297060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:07:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC2660D8E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:07:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Zb+rona3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297060-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297060-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DEEF306EC30
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE24183C8;
	Tue,  9 Jun 2026 13:59:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0D3FFAD7;
	Tue,  9 Jun 2026 13:59:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013556; cv=none; b=EVn/YVALw7YinHSuznYyukX+lgBVd3/WKXO4qHHNL2SD4j5I4schFxkqqbMFJbVNanoIbzjw56xBnEwkCxBE5n89Ku2xbsLujDq5JX3tGCKN1S1FaUvmOBwM3S+ogOiM3Q0SA3tLgLTrLY1pkrnTnImWfzMwquNJ1XgBV/A6WAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013556; c=relaxed/simple;
	bh=SGpeduoIgjpwHb9NKzMDERcHhkrXLGonfeaNONdBvNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgNO8Tm5KAAQGXKpRfi324o/dH314jSass08DLv/cOEMD/VWKFSz4hWSfZwBNXouuTzYlVAJSU7FC67ASEVf9HdOEHLFe1wSMAqAbVSyh/ED9iXZDwyInMVXDcN2UMIs05DRHxRvyp1xrPcJGL70713FNy2Qy2KM5o0gC8lpAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb+rona3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F931F00893;
	Tue,  9 Jun 2026 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781013554;
	bh=M5sOtZJNCdeKew31+SiH0I1uiASiB7jZ9KUuwaJ78DA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zb+rona37684YmLY8VU3BpcVmVVizmZI7uU3vy7ZCagnn8ddxuL0S4fEsW3CImFQm
	 wWxmejxqsBagFYhVckHrt59zYShFglSoXIAMwwc4CIsfjHQrspyAga1dqznbuOq1SV
	 f38y7gMi54uwmInywsQUEzQAT3idlYUnBmFPlOccmmZCueJmRgHKXLjhu5Rq9XkVeB
	 28bMTTQljwnH7BqHNKWE9maKYwWM/aQpiwEBrEvhU3HaapuLlxIYJEvUYu2CvV9QOA
	 ObHtQUKlfcAHoaHS4AN8DUyJzs/QkyoggarDgtDkaavBc6VTyXLQzPdzSN+2x3/tn7
	 Jknb++kx6zrdw==
Message-ID: <90fc9fc1-f396-4ed1-888f-89a96294664e@kernel.org>
Date: Tue, 9 Jun 2026 15:59:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: Simon Schippers <simon.schippers@tu-dortmund.de>,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <db2aa3b9-09d4-46d8-aafc-0a859ee8b635@tu-dortmund.de>
 <7fcb9f02-db61-416c-a6f5-b737d74110ec@kernel.org>
 <e8478d82-5af6-44f7-a481-584c09ae8337@tu-berlin.de>
 <b8569d0f-7a99-4488-a1bb-63d813231b7d@tu-dortmund.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <b8569d0f-7a99-4488-a1bb-63d813231b7d@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297060-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:j.koeppeler@tu-berlin.de,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,dql.limit:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8EC2660D8E



On 08/06/2026 16.21, Simon Schippers wrote:
> On 6/8/26 15:13, Jonas Köppeler wrote:
>>
>> On 6/8/26 3:04 PM, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 08/06/2026 12.38, Simon Schippers wrote:
>>>> On 5/27/26 15:54, hawk@kernel.org wrote:
>>>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>>
>>>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>>>
>>>>> Accumulate BQL completions and flush them when a configurable time
>>>>> threshold is exceeded, letting DQL discover a limit that bounds actual
>>>>> queuing delay to the configured interval. Coalescing state persists
>>>>> across NAPI polls in struct veth_rq so completions can accumulate
>>>>> beyond a single budget=64 cycle.
>>>>>
>>>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>>>> completion.
>>>>>
>>>>>     ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>>>     ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>>>
>>>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>> ---
>>>>
>>>> I found the issue that n_bql may become infinitly large if producer
>>>> and consumer have the same speed (and tx_usecs is large). It could
>>>> cause a potential BUG_ON if n_bql grows beyond INT_MAX...
>>>> Also I figured that no hardware BQL driver ever completes more than
>>>> BQL limit many elements.
>>>>
>>>> Therefore, I propose a simpler logic (see attachment) that completes
>>>> either on the usual bql_flush_ns or if n_bql > dql.limit.
>>>> If n_bql > dql.limit then we either have the case above that the
>>>> producer is as fast as the consumer or we have BQL starvation.
>>>>
>>>> if (state->time + bql_flush_ns <= current_time ||
>>>>      state->n_bql > peer_txq->dql.limit) {
>>>>
>>>> It must be n_bql *bigger than* dql.limit because the producer will
>>>> always exceed the limit before it stops, see netdev_tx_sent_queue().
>>>> It is fast because peer_txq->dql.limit is in the cacheline of the
>>>> completion path, see dynamic_queue_limits.h.
>>>>
>>>> Another advantage is that we avoid the snippet checking for empty
>>>> and BQL stopped which requires an smp_rmb() and an test_bit().
>>>>
>>>> Apart from that I:
>>>> - Always call veth_bql_maybe_complete() in the for loop to have
>>>>     more accurate completion intervals when having mixed XDP and
>>>>     non-XDP packets.
>>>> - Made it so tx_usecs = 0 is now also a normal case.
>>>> - Change the type of n_bql to uint instead of int.
>>>> - Added _ONCE() for tx_coalesce_usecs as suggested by Paolo.
>>>> - Moved the bql_state init in __veth_napi_enable_range() in front
>>>>     of napi_enable() to avoid a race (Sashiko).
>>>> - Moved the bql_state reset in veth_napi_del_range() after the
>>>>     ptr_ring_cleanup() (probably does not matter but makes sense to me)
>>>>
>>>> Benchmarks look just fine, see commit message.
>>>>
>>>> WDYT?
>>
>>>
>>> Looks good to me, I will use this in my V7 patchset.
>>>
>>> A bike-shedding issue: We change the coalescing parameters for the veth
>>> net_device, but should this be a TX or RX parameter?
>>>
>>
>> Hi,
>>
>> The results look a little bit suspicious, that in some cases the p99 is smaller than the average, which can happen if you have really large max values. It feels something is off with the methodology. I think we should drop the avg, and include the max value. This would give a better picture.
> 
> Luckily I saved the raw test result from /tmp (the raw ping output
> is included).
> 
> extract_ping_p99() seems to be broken. It has issues ordering the
> numbers. So if there are 2 or 3 numbers after the point I think.
> avg ping is fine.
> 
> Claude Sonnet wrote a script for me to recalculate the p99 pings
> from the raw ping output).

For programming switch to Claude Opus, as Sonnet cannot code IMHO.
(Claude Opus wrote the selftest we placed in [1])

Is your script still based on our github[1] selftest ?
If so, then please make some PR(s) against my repo.
I want this to be easy reproducible for others.

[1] https://github.com/netoptimizer/veth-backpressure-performance-testing

> Below is the new result. Not 100% sure but this seems right now.
> Most pings are the same.
> 
> Ping RTT ms (p99)
> ===========================================================================
> nrules |   0us |  50us | 100us | 500us | 1000us | 5000us | 10000us || stock
> -------+-------+-------+-------+-------+--------+--------+---------++------
>       0 | 0.028 | 0.115 | 0.159 | 0.161 |  0.163 |  0.161 |   0.163 || 0.154
>       1 | 0.027 | 0.123 | 0.169 | 0.172 |  0.169 |  0.173 |   0.172 || 0.169
>      10 | 0.030 | 0.117 | 0.189 | 0.193 |  0.195 |  0.192 |   0.196 || 0.186
>     100 | 0.045 | 0.134 | 0.233 | 0.368 |  0.365 |  0.369 |   0.361 || 0.358
>    1000 | 0.230 | 0.300 | 0.412 |  1.26 |   2.11 |   2.12 |    2.13 ||  2.07
>   10000 |  2.04 |  2.55 |  2.54 |  2.72 |   3.77 |   12.1 |    20.1 ||  20.3
> 
>>
>> Is state->n_bql += veth_ptr_is_bql(ptr) something that is commonly done in the kernel? It relies on bool normalization which feels a bit implicit to me.
> 
> Ok, we could swap for something like
> 
> if (veth_ptr_is_bql(ptr))
> 	state->n_bql+;

I'll see if I can adjust the V7 patch to this feedback.


>>
>>> For physical NICs adjusting TX coalescing will affect the BQL as this
>>> affect the TX completion of the transmitted packets. For veth, it is the
>>> veth-peer's RX NAPI that is "completing" or emptying the ptr_ring, which
>>> is where this patch adds netdev_tx_completed_queue calls for BQL.
>>> Any opinions on the "TX" or "RX" color?
> 
> Personally I would also say TX.
> 

Okay, we seem to have more votes for TX :-)


>> I think I would prefer to configure it on the tx dev, and the recv
>> side gets the value from the peer. Maybe something like this.
>> 

I'm considering if we should simplify the config by having veth pairs 
have the same tx-coal value. WDYT?


>> @@ -997,11 +998,12 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>          struct veth_bql_state *state = &rq->bql_state;
>>          int i, done = 0, n_xdpf = 0;
>>          void *xdpf[VETH_XDP_BATCH];
> 
> Why this deletion?
> 
>> -       struct veth_priv *priv;
>> -       u64 bql_flush_ns;
>> +       u64 bql_flush_ns = 0;
>>
>> -       priv = netdev_priv(rq->dev);
>> -       bql_flush_ns = (u64)priv->tx_coal_usecs * 1000;
> 
> I see we should check if peer_txq exists.
> 
>> +       if (peer_txq) {
>> +           struct veth_priv *peer_priv = netdev_priv(peer_txq->dev);
>> +           bql_flush_ns = (u64)READ_ONCE(peer_priv->tx_coal_usecs) * 1000;
>> +       }
>>
>>          /* Clamp stored timestamp in case we migrated to a CPU with a behind
>>           * sched_clock(); prevents the deadline from never firing.
>>
>> - Jonas

--Jesper


