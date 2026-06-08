Return-Path: <netdev+bounces-296545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jIERK6+/JmogcQIAu9opvQ
	(envelope-from <netdev+bounces-296545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:12:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C17A6567A7
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:12:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="X/bK2s3C";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296545-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296545-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B60A4309D130
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8579B2E762C;
	Mon,  8 Jun 2026 13:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0122DF719;
	Mon,  8 Jun 2026 13:04:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923898; cv=none; b=OGoqvmic4/OrTUBBi4N2Kslmgg1ZxstBKW0HfZziYSaOo4qcbdX6BgkLdZIUcx1VrSHqg94m9PEaTMwic3V6FA0aZ3UR53J9gXyCOm8j9GP077iQomVAUvChxxyj06GPcOFa94xB8nC7EIsqq7ZgWvFe01Eu4gvab8e6Gyh6bCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923898; c=relaxed/simple;
	bh=BFN9j1L9bHi3SsKKw2kFSIa3T21c5+TnnoLCielMAQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwf28zYKXHjUIgL3IFPIuvRoSZez9gmOWaHw1MtaTYzZkdpPMwb4vCs+AoK8tTOV8odWYdRc2ATAKK5DWjbdCkPAK0Dfkji/eFEoeW3Fzfuj3gusY3akhD06YAfyNBqEPhkFQlv1H+RhkM/Z0rGNMw/MFm3NLihR3IjtjXHMLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/bK2s3C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9361F00893;
	Mon,  8 Jun 2026 13:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780923897;
	bh=aizvCcX/2MPlDbQGT1VKqHWF+USG6wHXOds6qmKibWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=X/bK2s3CL+bCYsDUN0eSgmLC9xipEfxcINDrNT/KPIRkuaaGZ/m7pDVsAZctszALg
	 wZTBe3oNxCL6p2O85HLV2NVSMcnwH/CGuGKWz8CmgyrWsOMFtTqFdxQYqb7kujTqLC
	 mCqOqEWHMNtPJ/1wYTpBGc/EqynL7KPid6VSKiyf3tBXVOtmavh9qFGZgNumIMnu93
	 1XodM9LlK+QL9PXz5agSuPGDfzscHsWrqPXw8ppaUdYO7P6NuRbKbOT9MZSwqSuN/Z
	 DCvew4H4xxgvoydEOLY/jP0a1Se3/ra1Idat8gIkkL663ThLRrivakmsCa1ArBefaA
	 PeIAzXN26+ZJg==
Message-ID: <7fcb9f02-db61-416c-a6f5-b737d74110ec@kernel.org>
Date: Mon, 8 Jun 2026 15:04:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: Simon Schippers <simon.schippers@tu-dortmund.de>, netdev@vger.kernel.org,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <db2aa3b9-09d4-46d8-aafc-0a859ee8b635@tu-dortmund.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <db2aa3b9-09d4-46d8-aafc-0a859ee8b635@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296545-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:netdev@vger.kernel.org,m:j.koeppeler@tu-berlin.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tu-dortmund.de:email,vger.kernel.org:from_smtp,dql.limit:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C17A6567A7



On 08/06/2026 12.38, Simon Schippers wrote:
> On 5/27/26 15:54, hawk@kernel.org wrote:
>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>
>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>> excessive NAPI scheduling overhead and qdisc requeues.
>>
>> Accumulate BQL completions and flush them when a configurable time
>> threshold is exceeded, letting DQL discover a limit that bounds actual
>> queuing delay to the configured interval. Coalescing state persists
>> across NAPI polls in struct veth_rq so completions can accumulate
>> beyond a single budget=64 cycle.
>>
>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>> completion.
>>
>>    ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>    ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>
>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>> ---
> 
> I found the issue that n_bql may become infinitly large if producer
> and consumer have the same speed (and tx_usecs is large). It could
> cause a potential BUG_ON if n_bql grows beyond INT_MAX...
> Also I figured that no hardware BQL driver ever completes more than
> BQL limit many elements.
> 
> Therefore, I propose a simpler logic (see attachment) that completes
> either on the usual bql_flush_ns or if n_bql > dql.limit.
> If n_bql > dql.limit then we either have the case above that the
> producer is as fast as the consumer or we have BQL starvation.
> 
> if (state->time + bql_flush_ns <= current_time ||
> 	state->n_bql > peer_txq->dql.limit) {
> 
> It must be n_bql *bigger than* dql.limit because the producer will
> always exceed the limit before it stops, see netdev_tx_sent_queue().
> It is fast because peer_txq->dql.limit is in the cacheline of the
> completion path, see dynamic_queue_limits.h.
> 
> Another advantage is that we avoid the snippet checking for empty
> and BQL stopped which requires an smp_rmb() and an test_bit().
> 
> Apart from that I:
> - Always call veth_bql_maybe_complete() in the for loop to have
>    more accurate completion intervals when having mixed XDP and
>    non-XDP packets.
> - Made it so tx_usecs = 0 is now also a normal case.
> - Change the type of n_bql to uint instead of int.
> - Added _ONCE() for tx_coalesce_usecs as suggested by Paolo.
> - Moved the bql_state init in __veth_napi_enable_range() in front
>    of napi_enable() to avoid a race (Sashiko).
> - Moved the bql_state reset in veth_napi_del_range() after the
>    ptr_ring_cleanup() (probably does not matter but makes sense to me)
> 
> Benchmarks look just fine, see commit message.
> 
> WDYT?

Looks good to me, I will use this in my V7 patchset.

A bike-shedding issue: We change the coalescing parameters for the veth
net_device, but should this be a TX or RX parameter?

For physical NICs adjusting TX coalescing will affect the BQL as this
affect the TX completion of the transmitted packets. For veth, it is the
veth-peer's RX NAPI that is "completing" or emptying the ptr_ring, which
is where this patch adds netdev_tx_completed_queue calls for BQL.
Any opinions on the "TX" or "RX" color?

--Jesper

