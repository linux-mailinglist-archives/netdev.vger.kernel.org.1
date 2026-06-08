Return-Path: <netdev+bounces-296562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IbawIFbAJmp1cQIAu9opvQ
	(envelope-from <netdev+bounces-296562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:15:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A496567FE
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:15:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-berlin.de header.s=dkim-tub26 header.b=KOKvek1c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296562-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296562-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=tu-berlin.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42988300C0F7
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19D73370E4;
	Mon,  8 Jun 2026 13:13:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050E25B08C;
	Mon,  8 Jun 2026 13:13:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924428; cv=none; b=NNDSowADbCtSdV1svfbF2BcJvbmETvljSVM8MUNENaNybgoLx9nW30acPZKEqxfYcEfemkPzi4Z/UCfdqHYh5GOcC5agBqLGiCeZeloFoFm/Hs2yqOT12fcqI6z50uwKFQ4pGobNjpPObAI/H183+zlcWQx6mVcztk7fgkcNh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924428; c=relaxed/simple;
	bh=mvy10hRTDRi5Z60KMRZgDerGypXk+bmuBV9ZRiZvXRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A/wDpxNRD8KRRs0MZv55HU6m/7lxfeCDVSfJaxekSW1kacfsOWDmU+ubyf2KeW+kTf4OFBUkc7fw7ORMuUNAIbi4jIyIcafL2OTSXk4n5F968yZPzjF+eWPY7exLXF+MM0RTooQ4c3c+SV0sd0q4W/c+2Im6//DI/a3EP4OrSDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=KOKvek1c; arc=none smtp.client-ip=130.149.7.70
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1780924425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=24yOuIKlqcFA9syMazCqxweLj6xoa6jUerFmuK+rQ4w=;
  b=KOKvek1c6Drfc1kVEtLX6QDUzixP7MaMW/9ccghJWioLZZNN7sN1IZAc
   ETx55nn8pI5osd+crN+arom5Y8K9yneZPEa2C0xTH/tq2Y/Sayr8w6GXu
   eDHZmiG0RM+vYjswIf5GXQcF/JSjq1bQjCz7bf+ySXSNVTH3kavI2tTFY
   l/cgzutXUSoObaFG9wquFo716g1D+T9k9N/Q54yfBmoFApk32P7O7B/n7
   ytAvsM3XkIknn+jCX90bEk7wouU+9jZitkkt+kuEZxDJyjqe+LgL5vl/W
   pSCSRVMC4uVtFfs9O5rW4ejfNF5aefeijLehdmSt9+nhV2s5bYIRBvDfB
   Q==;
X-CSE-ConnectionGUID: JxFSwjFWRRO53cGz9f/4uQ==
X-CSE-MsgGUID: c+zXCUgFQzaFCpj0N2RZrA==
X-IronPort-AV: E=Sophos;i="6.24,194,1774306800"; 
   d="scan'208";a="48439609"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 08 Jun 2026 15:13:37 +0200
Message-ID: <e8478d82-5af6-44f7-a481-584c09ae8337@tu-berlin.de>
Date: Mon, 8 Jun 2026 15:13:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: Jesper Dangaard Brouer <hawk@kernel.org>, Simon Schippers
	<simon.schippers@tu-dortmund.de>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <db2aa3b9-09d4-46d8-aafc-0a859ee8b635@tu-dortmund.de>
 <7fcb9f02-db61-416c-a6f5-b737d74110ec@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
In-Reply-To: <7fcb9f02-db61-416c-a6f5-b737d74110ec@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub26];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296562-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:hawk@kernel.org,m:simon.schippers@tu-dortmund.de,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:email,dql.limit:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tu-berlin.de:mid,tu-berlin.de:from_mime,tu-berlin.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11A496567FE


On 6/8/26 3:04 PM, Jesper Dangaard Brouer wrote:
> 
> 
> On 08/06/2026 12.38, Simon Schippers wrote:
>> On 5/27/26 15:54, hawk@kernel.org wrote:
>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>
>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>
>>> Accumulate BQL completions and flush them when a configurable time
>>> threshold is exceeded, letting DQL discover a limit that bounds actual
>>> queuing delay to the configured interval. Coalescing state persists
>>> across NAPI polls in struct veth_rq so completions can accumulate
>>> beyond a single budget=64 cycle.
>>>
>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>> completion.
>>>
>>>    ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>    ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>
>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>> ---
>>
>> I found the issue that n_bql may become infinitly large if producer
>> and consumer have the same speed (and tx_usecs is large). It could
>> cause a potential BUG_ON if n_bql grows beyond INT_MAX...
>> Also I figured that no hardware BQL driver ever completes more than
>> BQL limit many elements.
>>
>> Therefore, I propose a simpler logic (see attachment) that completes
>> either on the usual bql_flush_ns or if n_bql > dql.limit.
>> If n_bql > dql.limit then we either have the case above that the
>> producer is as fast as the consumer or we have BQL starvation.
>>
>> if (state->time + bql_flush_ns <= current_time ||
>>     state->n_bql > peer_txq->dql.limit) {
>>
>> It must be n_bql *bigger than* dql.limit because the producer will
>> always exceed the limit before it stops, see netdev_tx_sent_queue().
>> It is fast because peer_txq->dql.limit is in the cacheline of the
>> completion path, see dynamic_queue_limits.h.
>>
>> Another advantage is that we avoid the snippet checking for empty
>> and BQL stopped which requires an smp_rmb() and an test_bit().
>>
>> Apart from that I:
>> - Always call veth_bql_maybe_complete() in the for loop to have
>>    more accurate completion intervals when having mixed XDP and
>>    non-XDP packets.
>> - Made it so tx_usecs = 0 is now also a normal case.
>> - Change the type of n_bql to uint instead of int.
>> - Added _ONCE() for tx_coalesce_usecs as suggested by Paolo.
>> - Moved the bql_state init in __veth_napi_enable_range() in front
>>    of napi_enable() to avoid a race (Sashiko).
>> - Moved the bql_state reset in veth_napi_del_range() after the
>>    ptr_ring_cleanup() (probably does not matter but makes sense to me)
>>
>> Benchmarks look just fine, see commit message.
>>
>> WDYT?

> 
> Looks good to me, I will use this in my V7 patchset.
> 
> A bike-shedding issue: We change the coalescing parameters for the veth
> net_device, but should this be a TX or RX parameter?
> 

Hi,

The results look a little bit suspicious, that in some cases the p99 is 
smaller than the average, which can happen if you have really large max 
values. It feels something is off with the methodology. I think we 
should drop the avg, and include the max value. This would give a better 
picture.

Is state->n_bql += veth_ptr_is_bql(ptr) something that is commonly done 
in the kernel? It relies on bool normalization which feels a bit 
implicit to me.

> For physical NICs adjusting TX coalescing will affect the BQL as this
> affect the TX completion of the transmitted packets. For veth, it is the
> veth-peer's RX NAPI that is "completing" or emptying the ptr_ring, which
> is where this patch adds netdev_tx_completed_queue calls for BQL.
> Any opinions on the "TX" or "RX" color?
I think I would prefer to configure it on the tx dev, and the recv side 
gets the value from the peer. Maybe something like this.

@@ -997,11 +998,12 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
budget,
         struct veth_bql_state *state = &rq->bql_state;
         int i, done = 0, n_xdpf = 0;
         void *xdpf[VETH_XDP_BATCH];
-       struct veth_priv *priv;
-       u64 bql_flush_ns;
+       u64 bql_flush_ns = 0;

-       priv = netdev_priv(rq->dev);
-       bql_flush_ns = (u64)priv->tx_coal_usecs * 1000;
+       if (peer_txq) {
+           struct veth_priv *peer_priv = netdev_priv(peer_txq->dev);
+           bql_flush_ns = (u64)READ_ONCE(peer_priv->tx_coal_usecs) * 1000;
+       }

         /* Clamp stored timestamp in case we migrated to a CPU with a 
behind
          * sched_clock(); prevents the deadline from never firing.

- Jonas

