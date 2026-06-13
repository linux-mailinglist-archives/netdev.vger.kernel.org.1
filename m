Return-Path: <netdev+bounces-298968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HxBLGOplLWpMfwQAu9opvQ
	(envelope-from <netdev+bounces-298968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 16:15:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 490DB67EBCB
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 16:15:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b=NHlnwxN0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298968-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298968-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EB2B300371F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD00B30D3F5;
	Sat, 13 Jun 2026 14:14:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C8281532;
	Sat, 13 Jun 2026 14:14:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781360099; cv=none; b=snlc1Ba9CTQWEjx3PoDvsvfS/i0gpH4RH4pLaOUWn4JaQRVeTwdB00DiyfVvR2GtKNjuUo93xMIeMUHVybcOvHmk0tcAHBYFSo2TnQS/4f1/vNsa5obgyTi0VF6XuVn0pAXxiDdotxX40gYKWRSo/f/Anc08fGEv/OxcCnXuNAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781360099; c=relaxed/simple;
	bh=qQ8W96WP+lSqweOpcKDTC6+K7WCn2R8DsbMBXX4Xe3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuetTI1Vshh8zCHgFmPfmDDpdnnIFDr543oIJCjDSxbEajS4SgifCFAmvB5/siLOspKnQ5ivAOn14wxJfjrIw4uHDySNfdgdR7AduSHnOqmC/OCGc7FbQPeICPct2FELLnNGKjmiaLICDMo+RRn5B+zlg2w/sBbUrTf/ncYIr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=NHlnwxN0; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1781360072;
	bh=qQ8W96WP+lSqweOpcKDTC6+K7WCn2R8DsbMBXX4Xe3A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NHlnwxN0/Q9X+vB7DngAk5fMqILIejNKq3+VDCbHgFKCRDW8KP3zU+IzyJ/S2eyjo
	 WaprUJksEHM6Bcr3TQj7N2ZZ7UVKF1piJwsoNMjWuiyij5BJNZPnP9fWYlPXBRGHMS
	 irla4tJffOjvEd1dlRAbY70ywnbTZ6FW1tr+JtU8=
Received: from [192.168.178.68] (pd9eaa69d.dip0.t-ipconnect.de [217.234.166.157])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 65DEEU9v000324
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 16:14:30 +0200 (CEST)
Message-ID: <f120fd22-1ee5-4d5b-9cdd-71804353e6a7@tu-dortmund.de>
Date: Sat, 13 Jun 2026 16:14:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com,
        =?UTF-8?Q?Jonas_K=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260612083530.1650245-1-hawk@kernel.org>
 <20260612083530.1650245-6-hawk@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260612083530.1650245-6-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298968-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[cloudflare.com,tu-berlin.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hawk@kernel.org,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:j.koeppeler@tu-berlin.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 490DB67EBCB

On 6/12/26 10:35, hawk@kernel.org wrote:
> From: Simon Schippers <simon.schippers@tu-dortmund.de>
> 
> Per-packet BQL completion forces DQL to converge on limit=2, causing
> excessive NAPI scheduling overhead and qdisc requeues.
> 
> Accumulate BQL completions and flush them when a configurable time
> threshold (tx-usecs) is exceeded, letting DQL discover a limit that
> bounds actual queuing delay to the configured interval. Coalescing
> state persists across NAPI polls in struct veth_rq so completions can
> accumulate beyond a single budget=64 cycle.
> 
> The flush condition is:
> 
> state->time + bql_flush_ns <= current_time || state->n_bql > dql.limit
> 
> Flushing when n_bql exceeds dql.limit handles BQL starvation.
> 
> The comparison is strictly greater-than because netdev_tx_sent_queue()
> always lets the producer exceed the limit by one before it stops, so
> n_bql == dql.limit is a normal in-flight state. dql.limit lives in
> the same cacheline as the completion path, so the check is cheap.
> 
> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
> setting tx-usecs to 0 disables coalescing and falls back to per-packet
> completion.
> 
>   ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>   ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
> 
> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Co-developed-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
> Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/veth.c | 123 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 117 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 2473f730734b..c62d87a8402c 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -28,6 +28,7 @@
>  #include <linux/bpf_trace.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/skbuff_ref.h>
> +#include <linux/sched/clock.h>
>  #include <net/page_pool/helpers.h>
>  
>  #define DRV_NAME	"veth"
> @@ -50,6 +51,7 @@
>   * delay => 64 * 250 ms = 16 s.
>   */
>  #define VETH_WATCHDOG_TIMEOUT_MS	(64 * 250)
> +#define VETH_BQL_COAL_TX_USECS	100 /* default tx-usecs for BQL batching */
>  
>  struct veth_stats {
>  	u64	rx_drops;
> @@ -69,6 +71,11 @@ struct veth_rq_stats {
>  	struct u64_stats_sync	syncp;
>  };
>  
> +struct veth_bql_state {
> +	u64	time;	/* sched_clock() when current coalescing window started */
> +	uint	n_bql;	/* BQL completions batched in the current window */
> +};
> +
>  struct veth_rq {
>  	struct napi_struct	xdp_napi;
>  	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
> @@ -76,6 +83,7 @@ struct veth_rq {
>  	struct bpf_prog __rcu	*xdp_prog;
>  	struct xdp_mem_info	xdp_mem;
>  	struct veth_rq_stats	stats;
> +	struct veth_bql_state	bql_state;
>  	bool			rx_notify_masked;
>  	struct ptr_ring		xdp_ring;
>  	struct xdp_rxq_info	xdp_rxq;
> @@ -88,6 +96,7 @@ struct veth_priv {
>  	struct bpf_prog		*_xdp_prog;
>  	struct veth_rq		*rq;
>  	unsigned int		requested_headroom;
> +	unsigned int		tx_coal_usecs;	/* BQL completion coalescing */
>  };
>  
>  struct veth_xdp_tx_bq {
> @@ -272,7 +281,56 @@ static void veth_get_channels(struct net_device *dev,
>  static int veth_set_channels(struct net_device *dev,
>  			     struct ethtool_channels *ch);
>  
> +static int veth_get_coalesce(struct net_device *dev,
> +			     struct ethtool_coalesce *ec,
> +			     struct kernel_ethtool_coalesce *kernel_coal,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct veth_priv *priv = netdev_priv(dev);
> +
> +	ec->tx_coalesce_usecs = priv->tx_coal_usecs;
> +	return 0;
> +}
> +
> +static int veth_set_coalesce(struct net_device *dev,
> +			     struct ethtool_coalesce *ec,
> +			     struct kernel_ethtool_coalesce *kernel_coal,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct veth_priv *priv = netdev_priv(dev);
> +	struct net_device *peer;
> +
> +	/* The coalescing window delays BQL completions, so keep tx-usecs well
> +	 * below the tx_timeout watchdog; otherwise a large value could stall a
> +	 * stopped queue long enough to trip a false watchdog timeout. Cap at
> +	 * half the watchdog to leave a generous safety margin. tx-usecs is
> +	 * microseconds, the watchdog is milliseconds.
> +	 */
> +	if (ec->tx_coalesce_usecs > VETH_WATCHDOG_TIMEOUT_MS / 2 * USEC_PER_MSEC) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "tx-usecs must stay below half the tx_timeout watchdog");
> +		return -ERANGE;
> +	}
> +
> +	/* Paired with READ_ONCE in veth_xdp_rcv(). */
> +	WRITE_ONCE(priv->tx_coal_usecs, ec->tx_coalesce_usecs);
> +
> +	/* veth_xdp_rcv() reads each device's own value, so mirror it onto
> +	 * the peer to keep the pair symmetric: both directions coalesce
> +	 * with the same tx-usecs. Called under RTNL, rtnl_dereference() is safe.
> +	 */
> +	peer = rtnl_dereference(priv->peer);
> +	if (peer) {
> +		struct veth_priv *peer_priv = netdev_priv(peer);
> +
> +		WRITE_ONCE(peer_priv->tx_coal_usecs, ec->tx_coalesce_usecs);
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct ethtool_ops veth_ethtool_ops = {
> +	.supported_coalesce_params = ETHTOOL_COALESCE_TX_USECS,
>  	.get_drvinfo		= veth_get_drvinfo,
>  	.get_link		= ethtool_op_get_link,
>  	.get_strings		= veth_get_strings,
> @@ -282,6 +340,8 @@ static const struct ethtool_ops veth_ethtool_ops = {
>  	.get_ts_info		= ethtool_op_get_ts_info,
>  	.get_channels		= veth_get_channels,
>  	.set_channels		= veth_set_channels,
> +	.get_coalesce		= veth_get_coalesce,
> +	.set_coalesce		= veth_set_coalesce,
>  };
>  
>  /* general routines */
> @@ -969,13 +1029,54 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>  	return NULL;
>  }
>  
> +static void veth_bql_maybe_complete(struct veth_bql_state *state,
> +				    struct netdev_queue *peer_txq,
> +				    u64 bql_flush_ns)
> +{
> +	u64 current_time;
> +
> +	/* There is no reason to complete with 0 and
> +	 * peer_txq could go away.
> +	 */
> +	if (!state->n_bql || !peer_txq)
> +		return;
> +
> +	current_time = sched_clock();
> +
> +	/* We complete if:
> +	 * 1. We reach bql_flush_ns.
> +	 * 2. We potentially have BQL starvation.
> +	 */
> +	if (state->time + bql_flush_ns <= current_time ||
> +	    state->n_bql > peer_txq->dql.limit) {

Both Sashiko-Nipa and Sashiko-Gemini are right, this is missing a 
#ifdef CONFIG_BQL. Not sure what is the best way to add them.
And for the struct we could maybe do:

#ifdef CONFIG_BQL
struct veth_bql_state {
    u64	time;	/* sched_clock() when current coalescing window started */
    uint	n_bql;	/* BQL completions batched in the current window */
};
#else
struct veth_bql_state {};
#endif

> +		netdev_tx_completed_queue(peer_txq, state->n_bql,
> +					  state->n_bql * VETH_BQL_UNIT);
> +		state->time = current_time;
> +		state->n_bql = 0;
> +	}
> +}
> +
>  static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct veth_xdp_tx_bq *bq,
>  			struct veth_stats *stats,
>  			struct netdev_queue *peer_txq)
>  {
> +	struct veth_priv *priv = netdev_priv(rq->dev);
> +	struct veth_bql_state *state = &rq->bql_state;
>  	int i, done = 0, n_xdpf = 0;
>  	void *xdpf[VETH_XDP_BATCH];
> +	u64 bql_flush_ns;
> +
> +	/* Mirrored to both peers; paired with WRITE_ONCE() in veth_set_coalesce */
> +	bql_flush_ns = (u64)READ_ONCE(priv->tx_coal_usecs) * 1000;
> +
> +	/* Clamp stored timestamp in case we migrated to a CPU with a behind
> +	 * sched_clock(); tries to reduce late BQL flushes.
> +	 */
> +	state->time = min(state->time, sched_clock());
> +
> +	/* Flush completions that timed out since the previous NAPI poll. */
> +	veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
>  
>  	for (i = 0; i < budget; i++) {
>  		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
> @@ -1000,12 +1101,11 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			}
>  		} else {
>  			/* ndo_start_xmit */
> -			bool bql_charged = veth_ptr_is_bql(ptr);
>  			struct sk_buff *skb = veth_ptr_to_skb(ptr);
>  
> +			if (veth_ptr_is_bql(ptr))
> +				state->n_bql++;
>  			stats->xdp_bytes += skb->len;
> -			if (peer_txq && bql_charged)
> -				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
>  
>  			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
>  			if (skb) {
> @@ -1015,6 +1115,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  					napi_gro_receive(&rq->xdp_napi, skb);
>  			}
>  		}
> +		veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
>  		done++;

Sashiko-Nipa reports:

"If veth_xdp_rcv() finishes and returns a done count less than the budget,
NAPI will go to sleep in veth_poll(). Do we need to unconditionally flush
any stranded BQL completions in veth_poll() before sleeping?
If completions are left in rq->bql_state indefinitely across NAPI idle
periods, it might present an artificially massive delay to DQL. This could
cause DQL to mistakenly conclude the hardware is extremely slow and
aggressively shrink dql.limit to its minimum, crippling throughput on
subsequent bursts."

Again the issue that I found to be non-problematic in [1] and can be
seen by an BQL inflight > 0 when for example pktgen suddenly stops.

If we would "unconditionally flush any stranded BQL completions in
veth_poll() before sleeping" we would *not* accumulate BQL completions
across NAPI polls but we want to do that.

Do you agree?

[1] https://lore.kernel.org/netdev/c8650d3a-e488-4279-b28f-549d766c23a1@tu-dortmund.de/

