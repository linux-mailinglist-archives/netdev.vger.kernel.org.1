Return-Path: <netdev+bounces-303336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3kRKEv8TRGp4oAoAu9opvQ
	(envelope-from <netdev+bounces-303336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:07:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0B66E76C8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:07:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b=LOQoR6Vc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303336-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303336-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 485C03008D22
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4179379EF7;
	Tue, 30 Jun 2026 19:07:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F23033E1;
	Tue, 30 Jun 2026 19:07:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846455; cv=none; b=dzrLK6ND6FnzNhQYhLwgr6jR1A4hfqC7yadKMnoLShB/XYLKJ/ldGzNxWGGyRbvfiRGDH8bzEJ9XJz5Vtibv3ljvXhTcO3LAPNAXIZCAK2d+r9+Otpnad/epmyGKWJLoiV0U66kQPfXa1ZgyzHzvBRs8G9RKXmdP1OPpDgoL3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846455; c=relaxed/simple;
	bh=rgmUMT2OCATjyxZnX0yrHJxJnIcQqj+Baw3RxcdYMnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9DL5LD14QNAQxcMWOrZCWfreTqz937YEtYP44CWOPGxRw6Y+IxdObyN4h8Cbw79gL4SomVoI6M/kAauttVu2RT1uty6iiUZCgjql/fV2Hpu/h7VlBGY+/m7DPuZ7+th14Gvmy1p+5RF9zVs8LnWMWFEHC+djBHd/mlppSk+Ies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=LOQoR6Vc; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1782846428;
	bh=pgszCChrYSmAJ7VyYDGMWxduJ1+pYglUugd4xruCdAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LOQoR6Vcn6PKl4153aWkqxJcRLGc7QbAbFAzRvbZZ6H61lVtEbcVLgx5twBU+DJXQ
	 PN+3JzitzDL9/mSJEBXHhklhCFaUq7tWKYI1A60qN9a1GWFWaXOpNLWiJMU+MLLP9L
	 Lp5cWci1LpIknZS/ksuY/yFXBIifzPcvIXWhzy6s=
Received: from [192.168.178.68] (p5dc887d7.dip0.t-ipconnect.de [93.200.135.215])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 65UJ76ZN002542
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:07:07 +0200 (CEST)
Message-ID: <9205d83f-2c9e-4abb-91a0-488704bcdef3@tu-dortmund.de>
Date: Tue, 30 Jun 2026 21:07:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        hawk@kernel.org, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260612083530.1650245-1-hawk@kernel.org>
 <20260612083530.1650245-6-hawk@kernel.org>
 <f120fd22-1ee5-4d5b-9cdd-71804353e6a7@tu-dortmund.de>
 <c4154d9c-8930-436d-b8b8-01951e8bd9f4@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <c4154d9c-8930-436d-b8b8-01951e8bd9f4@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303336-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:j.koeppeler@tu-berlin.de,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,dql.limit:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E0B66E76C8

On 6/30/26 16:00, Jonas Köppeler wrote:
> On 6/13/26 4:14 PM, Simon Schippers wrote:
>> On 6/12/26 10:35, hawk@kernel.org wrote:
>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>
>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>
>>> Accumulate BQL completions and flush them when a configurable time
>>> threshold (tx-usecs) is exceeded, letting DQL discover a limit that
>>> bounds actual queuing delay to the configured interval. Coalescing
>>> state persists across NAPI polls in struct veth_rq so completions can
>>> accumulate beyond a single budget=64 cycle.
>>>
>>> The flush condition is:
>>>
>>> state->time + bql_flush_ns <= current_time || state->n_bql > dql.limit
>>>
>>> Flushing when n_bql exceeds dql.limit handles BQL starvation.
>>>
>>> The comparison is strictly greater-than because netdev_tx_sent_queue()
>>> always lets the producer exceed the limit by one before it stops, so
>>> n_bql == dql.limit is a normal in-flight state. dql.limit lives in
>>> the same cacheline as the completion path, so the check is cheap.
>>>
>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>> completion.
>>>
>>>    ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>    ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>
>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Co-developed-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
>>> Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>> ---
>>>   drivers/net/veth.c | 123 ++++++++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 117 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>> index 2473f730734b..c62d87a8402c 100644
>>> --- a/drivers/net/veth.c
>>> +++ b/drivers/net/veth.c
>>> @@ -28,6 +28,7 @@
>>>   #include <linux/bpf_trace.h>
>>>   #include <linux/net_tstamp.h>
>>>   #include <linux/skbuff_ref.h>
>>> +#include <linux/sched/clock.h>
>>>   #include <net/page_pool/helpers.h>
>>>     #define DRV_NAME    "veth"
>>> @@ -50,6 +51,7 @@
>>>    * delay => 64 * 250 ms = 16 s.
>>>    */
>>>   #define VETH_WATCHDOG_TIMEOUT_MS    (64 * 250)
>>> +#define VETH_BQL_COAL_TX_USECS    100 /* default tx-usecs for BQL batching*/
>>>     struct veth_stats {
>>>       u64    rx_drops;
>>> @@ -69,6 +71,11 @@ struct veth_rq_stats {
>>>       struct u64_stats_sync    syncp;
>>>   };
>>>   +struct veth_bql_state {
>>> +    u64    time;    /* sched_clock() when current coalescing window started */
>>> +    uint    n_bql;    /* BQL completions batched in the current window */
>>> +};
>>> +
>>>   struct veth_rq {
>>>       struct napi_struct    xdp_napi;
>>>       struct napi_struct __rcu *napi; /* points to xdp_napi when the latteris initialized */
>>> @@ -76,6 +83,7 @@ struct veth_rq {
>>>       struct bpf_prog __rcu    *xdp_prog;
>>>       struct xdp_mem_info    xdp_mem;
>>>       struct veth_rq_stats    stats;
>>> +    struct veth_bql_state    bql_state;
>>>       bool            rx_notify_masked;
>>>       struct ptr_ring        xdp_ring;
>>>       struct xdp_rxq_info    xdp_rxq;
>>> @@ -88,6 +96,7 @@ struct veth_priv {
>>>       struct bpf_prog        *_xdp_prog;
>>>       struct veth_rq        *rq;
>>>       unsigned int        requested_headroom;
>>> +    unsigned int        tx_coal_usecs;    /* BQL completion coalescing */
>>>   };
>>>     struct veth_xdp_tx_bq {
>>> @@ -272,7 +281,56 @@ static void veth_get_channels(struct net_device *dev,
>>>   static int veth_set_channels(struct net_device *dev,
>>>                    struct ethtool_channels *ch);
>>>   +static int veth_get_coalesce(struct net_device *dev,
>>> +                 struct ethtool_coalesce *ec,
>>> +                 struct kernel_ethtool_coalesce *kernel_coal,
>>> +                 struct netlink_ext_ack *extack)
>>> +{
>>> +    struct veth_priv *priv = netdev_priv(dev);
>>> +
>>> +    ec->tx_coalesce_usecs = priv->tx_coal_usecs;
>>> +    return 0;
>>> +}
>>> +
>>> +static int veth_set_coalesce(struct net_device *dev,
>>> +                 struct ethtool_coalesce *ec,
>>> +                 struct kernel_ethtool_coalesce *kernel_coal,
>>> +                 struct netlink_ext_ack *extack)
>>> +{
>>> +    struct veth_priv *priv = netdev_priv(dev);
>>> +    struct net_device *peer;
>>> +
>>> +    /* The coalescing window delays BQL completions, so keep tx-usecs well
>>> +     * below the tx_timeout watchdog; otherwise a large value could stall a
>>> +     * stopped queue long enough to trip a false watchdog timeout. Cap at
>>> +     * half the watchdog to leave a generous safety margin. tx-usecs is
>>> +     * microseconds, the watchdog is milliseconds.
>>> +     */
>>> +    if (ec->tx_coalesce_usecs > VETH_WATCHDOG_TIMEOUT_MS / 2 * USEC_PER_MSEC) {
>>> +        NL_SET_ERR_MSG_MOD(extack,
>>> +                   "tx-usecs must stay below half the tx_timeout watchdog");
>>> +        return -ERANGE;
>>> +    }
>>> +
>>> +    /* Paired with READ_ONCE in veth_xdp_rcv(). */
>>> +    WRITE_ONCE(priv->tx_coal_usecs, ec->tx_coalesce_usecs);
>>> +
>>> +    /* veth_xdp_rcv() reads each device's own value, so mirror it onto
>>> +     * the peer to keep the pair symmetric: both directions coalesce
>>> +     * with the same tx-usecs. Called under RTNL, rtnl_dereference() is safe.
>>> +     */
>>> +    peer = rtnl_dereference(priv->peer);
>>> +    if (peer) {
>>> +        struct veth_priv *peer_priv = netdev_priv(peer);
>>> +
>>> +        WRITE_ONCE(peer_priv->tx_coal_usecs, ec->tx_coalesce_usecs);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static const struct ethtool_ops veth_ethtool_ops = {
>>> +    .supported_coalesce_params = ETHTOOL_COALESCE_TX_USECS,
>>>       .get_drvinfo        = veth_get_drvinfo,
>>>       .get_link        = ethtool_op_get_link,
>>>       .get_strings        = veth_get_strings,
>>> @@ -282,6 +340,8 @@ static const struct ethtool_ops veth_ethtool_ops ={
>>>       .get_ts_info        = ethtool_op_get_ts_info,
>>>       .get_channels        = veth_get_channels,
>>>       .set_channels        = veth_set_channels,
>>> +    .get_coalesce        = veth_get_coalesce,
>>> +    .set_coalesce        = veth_set_coalesce,
>>>   };
>>>     /* general routines */
>>> @@ -969,13 +1029,54 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>>>       return NULL;
>>>   }
>>>   +static void veth_bql_maybe_complete(struct veth_bql_state *state,
>>> +                    struct netdev_queue *peer_txq,
>>> +                    u64 bql_flush_ns)
>>> +{
>>> +    u64 current_time;
>>> +
>>> +    /* There is no reason to complete with 0 and
>>> +     * peer_txq could go away.
>>> +     */
>>> +    if (!state->n_bql || !peer_txq)
>>> +        return;
>>> +
>>> +    current_time = sched_clock();
>>> +
>>> +    /* We complete if:
>>> +     * 1. We reach bql_flush_ns.
>>> +     * 2. We potentially have BQL starvation.
>>> +     */
>>> +    if (state->time + bql_flush_ns <= current_time ||
>>> +        state->n_bql > peer_txq->dql.limit) {
>>
> Indeed, this does not compile when CONFIG_BQL is not set. I think we should just bring back the 'queue is empty + queue is stopped' check from v6 back at the end of the poll and remove the n_bql > dql.limit check.

We would put #ifdef CONFIG_BQL around that logic aswell.

> It also feels not obvious why this is handling the starvation case. This only works, because the producer has went overlimit previously and was stopped. So more than 'limit' packets have been enqueued to the ring, and they are eventually drained when this check is true.

I think it just needs some comment tweaking:

/* We complete if:
 * 1. We reach bql_flush_ns.
 * 2. We have BQL starvation. This means that the queue was over-limit
 *    in the last interval, and there is no more data in the queue,
 *    which is equivalent to we consumed more than limit items.
 */ 

> By removing this we can also avoid accessing dql internal members, but if you don't think that's a problem we can leave as is.

I agree accessing dql internal variables is not perfect.

That is why I have locally implemented DQL for software interfaces in
a generic way inside dynamic_queue_limits.{h,c}.
I was able to squeeze the time and n_bql variables into the completion
cacheline of the dql struct by moving around variables.
The logic applies inside dql_completed() if enabled.
With this we just have to call netdev_completed_queue().
Also it allows for per-queue tweaking of tx_usecs via sysfs.
Works well for me, can share it if we want to use it.

> 
> Further, this is only works if VETH_BQL_UNIT stays 1, otherwise it will never fire. Anyway, still its necessary to check for CONFIG_BQL. But we could solve this by adding VETH_BQL_UNIT to n_bql instead of 1. This is also safe from any overflows, since limit is bound to limit_max, inflight is always less than limit + 1*VETH_BQL_UNIT and n_bql <= inflight.

You are right.

But I think there is no reason for VETH_BQL_UNIT anyway.
There should be no difference in the BQL algorithm, I personally
would replace VETH_BQL_UNIT with a hard-coded 1.

> 
> In a version of bringing back the 'queue-empty' check and keeping most of the current logic (so a mixture of v6 and v7) resulted in the same performance on an x86_64 architecture.
> 
>> Both Sashiko-Nipa and Sashiko-Gemini are right, this is missing a
>> #ifdef CONFIG_BQL. Not sure what is the best way to add them.
>> And for the struct we could maybe do:
>>
>> #ifdef CONFIG_BQL
>> struct veth_bql_state {
>>      u64    time;    /* sched_clock() when current coalescing window started */
>>      uint    n_bql;    /* BQL completions batched in the current window */
>> };
>> #else
>> struct veth_bql_state {};
>> #endif
> Regarding the configs: we can just do something along those lines.
> struct veth_rq {
> ...
> #ifdef CONFIG_BQL
>     struct veth_bql_state        dql;
> #endif
> ...
> }
> 
> and we put the rest of the code that accesses or performs an action regarding bql in some functions and do it like in netdev_* functions with
> 
> Function-Signature()
> {
> #ifdef CONFIG_BQL
> // Code
> #endif
> }
> 
> Wdyt?
> - Jonas

Yes, we have to. Unless we put it into dynamic_queue_limits.{h,c}
of course :^)

Thanks,
Simon

>>
>>> +        netdev_tx_completed_queue(peer_txq, state->n_bql,
>>> +                      state->n_bql * VETH_BQL_UNIT);
>>> +        state->time = current_time;
>>> +        state->n_bql = 0;
>>> +    }
>>> +}
>>> +
>>>   static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>>               struct veth_xdp_tx_bq *bq,
>>>               struct veth_stats *stats,
>>>               struct netdev_queue *peer_txq)
>>>   {
>>> +    struct veth_priv *priv = netdev_priv(rq->dev);
>>> +    struct veth_bql_state *state = &rq->bql_state;
>>>       int i, done = 0, n_xdpf = 0;
>>>       void *xdpf[VETH_XDP_BATCH];
>>> +    u64 bql_flush_ns;
>>> +
>>> +    /* Mirrored to both peers; paired with WRITE_ONCE() in veth_set_coalesce */
>>> +    bql_flush_ns = (u64)READ_ONCE(priv->tx_coal_usecs) * 1000;
>>> +
>>> +    /* Clamp stored timestamp in case we migrated to a CPU with a behind
>>> +     * sched_clock(); tries to reduce late BQL flushes.
>>> +     */
>>> +    state->time = min(state->time, sched_clock());
>>> +
>>> +    /* Flush completions that timed out since the previous NAPI poll. */
>>> +    veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);>>
>>>       for (i = 0; i < budget; i++) {
>>>           void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>>> @@ -1000,12 +1101,11 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>>               }
>>>           } else {
>>>               /* ndo_start_xmit */
>>> -            bool bql_charged = veth_ptr_is_bql(ptr);
>>>               struct sk_buff *skb = veth_ptr_to_skb(ptr);
>>>   +            if (veth_ptr_is_bql(ptr))
>>> +                state->n_bql++;
>>>               stats->xdp_bytes += skb->len;
>>> -            if (peer_txq && bql_charged)
>>> -                netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
>>>                 skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
>>>               if (skb) {
>>> @@ -1015,6 +1115,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>>                       napi_gro_receive(&rq->xdp_napi, skb);
>>>               }
>>>           }
>>> +        veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
>>>           done++;
>>
>> Sashiko-Nipa reports:
>>
>> "If veth_xdp_rcv() finishes and returns a done count less than the budget,
>> NAPI will go to sleep in veth_poll(). Do we need to unconditionally flush
>> any stranded BQL completions in veth_poll() before sleeping?
>> If completions are left in rq->bql_state indefinitely across NAPI idle
>> periods, it might present an artificially massive delay to DQL. This could
>> cause DQL to mistakenly conclude the hardware is extremely slow and
>> aggressively shrink dql.limit to its minimum, crippling throughput on
>> subsequent bursts."
>>
>> Again the issue that I found to be non-problematic in [1] and can be
>> seen by an BQL inflight > 0 when for example pktgen suddenly stops.
>>
>> If we would "unconditionally flush any stranded BQL completions in
>> veth_poll() before sleeping" we would *not* accumulate BQL completions
>> across NAPI polls but we want to do that.
>>
>> Do you agree?
>>
>> [1] https://lore.kernel.org/netdev/c8650d3a-e488-4279-b28f-549d766c23a1@tu-dortmund.de/
> 

