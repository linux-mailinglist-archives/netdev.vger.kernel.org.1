Return-Path: <netdev+bounces-292577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBmWAEbzF2q5WAgAu9opvQ
	(envelope-from <netdev+bounces-292577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:48:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C245EDEC4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 598333026CA3
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B58031195C;
	Thu, 28 May 2026 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="R6kE6glJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8DF2F7F1B;
	Thu, 28 May 2026 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954366; cv=none; b=dLAXyv0lPlotqcOXtyhlKbPjJDygDT6AYd8sgu1Q1GC7oHylI3LsgvP0K+Y46BivwD84GuA+avTYWvWyEZX38DWVr3tdOYVEjXE/VlxVPk9Lpv9Jl5NCa7MHR0Ot3IxbygrcVPDfy7n+jiE6S5bCnUhpYlQ1UvifuhBqu1TcP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954366; c=relaxed/simple;
	bh=N5L6aKv4wJWYgCkWMn+fFVo8QHXS7vN4X3b+VYl5r90=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WT8j56Lk4QOtSgVgqloakujGf0jlJR3X6gwOuxicPXFHEBDQB87zm3zS78XO0PU78qmTB0wlwErDdqSKCtunDwCzk5WTAzYn8scCRfGvLPtrfqAGuXvMRWf32ksaNK5DRtDRwGD+8W0XO8oQIQDWrMXixC7IzG5X8BSXwPOjQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=R6kE6glJ; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1779954364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZfyNY1uucZrB283irdiTXLHbacl0PzjBJDzZ20ZxAfk=;
  b=R6kE6glJNT/MeaOE+E+IeyTZbJ52c7t9BsYu5glXlllUwXANRb6tfPXv
   LlR225G3x+9Boz9TR8O9El+gx9e1nr+sifhvWsjXxMbzrUTRuanjog3GL
   6u/IsMFdzLsWU94/UVzqar3My4i0vdrIlfvj5WbeEEWwpFFsdde/jVvLr
   t07tdeFp4uhVkWaebWzDQnEo0Xmlh+MbLGKYYOz4NvXiuLZfJhrdnPlXs
   p9yTWrECl32VvMtsPx6tPw/8LPLvrEHGVOYT5lkhbh84e6/AS/27wkxfX
   6hJQ0yQEOd5nTsWuwR4oAa5tF3SrRiTVHvGRhvILpOlV7/ZDmY+uxDaV0
   g==;
X-CSE-ConnectionGUID: MutkEjNRQ1axxcVgohNjBQ==
X-CSE-MsgGUID: PigEJOYiQAWj7LA1tc1Oog==
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="47877427"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 28 May 2026 09:46:01 +0200
Message-ID: <2affe9f4-56a7-4482-931f-9d98cfdf09fd@tu-berlin.de>
Date: Thu, 28 May 2026 09:46:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: <hawk@kernel.org>, <netdev@vger.kernel.org>
CC: Simon Schippers <simon.schippers@tu-dortmund.de>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
In-Reply-To: <20260527135418.1166665-6-hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub26];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292577-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[tu-dortmund.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tu-berlin.de:email,tu-berlin.de:mid,tu-berlin.de:dkim,tu-dortmund.de:email]
X-Rspamd-Queue-Id: 76C245EDEC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 3:54 PM, hawk@kernel.org wrote:
> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>
> Per-packet BQL completion forces DQL to converge on limit=2, causing
> excessive NAPI scheduling overhead and qdisc requeues.
>
> Accumulate BQL completions and flush them when a configurable time
> threshold is exceeded, letting DQL discover a limit that bounds actual
> queuing delay to the configured interval. Coalescing state persists
> across NAPI polls in struct veth_rq so completions can accumulate
> beyond a single budget=64 cycle.
>
> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
> setting tx-usecs to 0 disables coalescing and falls back to per-packet
> completion.
>
>    ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>    ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>
> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>

Tested-by: Jonas Köppeler<j.koeppeler@tu-berlin.de>

> ---
>   drivers/net/veth.c | 100 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 98 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index d5675d9d5236..743d17b37223 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -28,6 +28,7 @@
>   #include <linux/bpf_trace.h>
>   #include <linux/net_tstamp.h>
>   #include <linux/skbuff_ref.h>
> +#include <linux/sched/clock.h>
>   #include <net/page_pool/helpers.h>
>   
>   #define DRV_NAME	"veth"
> @@ -44,6 +45,8 @@
>   #define VETH_XDP_TX_BULK_SIZE	16
>   #define VETH_XDP_BATCH		16
>   
> +#define VETH_BQL_COAL_TX_USECS	100 /* default tx-usecs for BQL batching */
> +
>   struct veth_stats {
>   	u64	rx_drops;
>   	/* xdp */
> @@ -62,6 +65,11 @@ struct veth_rq_stats {
>   	struct u64_stats_sync	syncp;
>   };
>   
> +struct veth_bql_state {
> +	u64	time;	/* sched_clock() when current coalescing window started */
> +	int	n_bql;	/* BQL completions batched in the current window */
> +};
> +
>   struct veth_rq {
>   	struct napi_struct	xdp_napi;
>   	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
> @@ -69,6 +77,7 @@ struct veth_rq {
>   	struct bpf_prog __rcu	*xdp_prog;
>   	struct xdp_mem_info	xdp_mem;
>   	struct veth_rq_stats	stats;
> +	struct veth_bql_state	bql_state;
>   	bool			rx_notify_masked;
>   	struct ptr_ring		xdp_ring;
>   	struct xdp_rxq_info	xdp_rxq;
> @@ -81,6 +90,7 @@ struct veth_priv {
>   	struct bpf_prog		*_xdp_prog;
>   	struct veth_rq		*rq;
>   	unsigned int		requested_headroom;
> +	unsigned int		tx_coal_usecs;	/* BQL completion coalescing */
>   };
>   
>   struct veth_xdp_tx_bq {
> @@ -265,7 +275,30 @@ static void veth_get_channels(struct net_device *dev,
>   static int veth_set_channels(struct net_device *dev,
>   			     struct ethtool_channels *ch);
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
> +
> +	priv->tx_coal_usecs = ec->tx_coalesce_usecs;
> +	return 0;
> +}
> +
>   static const struct ethtool_ops veth_ethtool_ops = {
> +	.supported_coalesce_params = ETHTOOL_COALESCE_TX_USECS,
>   	.get_drvinfo		= veth_get_drvinfo,
>   	.get_link		= ethtool_op_get_link,
>   	.get_strings		= veth_get_strings,
> @@ -275,6 +308,8 @@ static const struct ethtool_ops veth_ethtool_ops = {
>   	.get_ts_info		= ethtool_op_get_ts_info,
>   	.get_channels		= veth_get_channels,
>   	.set_channels		= veth_set_channels,
> +	.get_coalesce		= veth_get_coalesce,
> +	.set_coalesce		= veth_set_coalesce,
>   };
>   
>   /* general routines */
> @@ -937,13 +972,45 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>   	return NULL;
>   }
>   
> +static void veth_bql_complete(struct veth_bql_state *state,
> +			      struct netdev_queue *peer_txq)
> +{
> +	netdev_tx_completed_queue(peer_txq, state->n_bql,
> +				  state->n_bql * VETH_BQL_UNIT);
> +	state->n_bql = 0;
> +	state->time = sched_clock();
> +}
> +
> +static void veth_bql_maybe_complete(struct veth_bql_state *state,
> +				    struct netdev_queue *peer_txq,
> +				    u64 coalescing_ns)
> +{
> +	if (state->n_bql && sched_clock() >= state->time + coalescing_ns)
> +		veth_bql_complete(state, peer_txq);
> +}
> +
>   static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>   			struct veth_xdp_tx_bq *bq,
>   			struct veth_stats *stats,
>   			struct netdev_queue *peer_txq)
>   {
> +	struct veth_bql_state *state = &rq->bql_state;
>   	int i, done = 0, n_xdpf = 0;
>   	void *xdpf[VETH_XDP_BATCH];
> +	struct veth_priv *priv;
> +	u64 bql_flush_ns;
> +
> +	priv = netdev_priv(rq->dev);
> +	bql_flush_ns = (u64)priv->tx_coal_usecs * 1000;
> +
> +	/* Clamp stored timestamp in case we migrated to a CPU with a behind
> +	 * sched_clock(); prevents the deadline from never firing.
> +	 */
> +	state->time = min(state->time, sched_clock());
> +
> +	/* Flush completions that timed out since the previous NAPI poll. */
> +	if (peer_txq && bql_flush_ns)
> +		veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
>   
>   	for (i = 0; i < budget; i++) {
>   		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
> @@ -972,8 +1039,16 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>   			struct sk_buff *skb = veth_ptr_to_skb(ptr);
>   
>   			stats->xdp_bytes += skb->len;
> -			if (peer_txq && bql_charged)
> -				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
> +			if (peer_txq && bql_charged) {
> +				if (!bql_flush_ns) {
> +					netdev_tx_completed_queue(peer_txq, 1,
> +								  VETH_BQL_UNIT);
> +				} else {
> +					state->n_bql++;
> +					veth_bql_maybe_complete(state, peer_txq,
> +								bql_flush_ns);
> +				}
> +			}
>   
>   			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
>   			if (skb) {
> @@ -989,6 +1064,18 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>   	if (n_xdpf)
>   		veth_xdp_rcv_bulk_skb(rq, xdpf, n_xdpf, bq, stats);
>   
> +	/* If the ring is now empty and the peer TX queue is stalled by DQL
> +	 * backpressure, release completions immediately to unblock it.
> +	 */
> +	if (peer_txq && state->n_bql && __ptr_ring_empty(&rq->xdp_ring)) {
> +		/* Pairs with smp_wmb() in __ptr_ring_produce(); ensure ring
> +		 * emptiness is observed before reading peer_txq->state.
> +		 */
> +		smp_rmb();
> +		if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
> +			veth_bql_complete(state, peer_txq);
> +	}
> +
>   	u64_stats_update_begin(&rq->stats.syncp);
>   	rq->stats.vs.xdp_redirect += stats->xdp_redirect;
>   	rq->stats.vs.xdp_bytes += stats->xdp_bytes;
> @@ -1093,6 +1180,9 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
>   
>   		napi_enable(&rq->xdp_napi);
>   		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
> +
> +		rq->bql_state.time = sched_clock();
> +		rq->bql_state.n_bql = 0;
>   	}
>   
>   	return 0;
> @@ -1134,6 +1224,8 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
>   		struct veth_rq *rq = &priv->rq[i];
>   
>   		rq->rx_notify_masked = false;
> +		rq->bql_state.n_bql = 0;
> +		rq->bql_state.time = 0;
>   		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
>   	}
>   
> @@ -1813,6 +1905,8 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
>   
>   static void veth_setup(struct net_device *dev)
>   {
> +	struct veth_priv *priv = netdev_priv(dev);
> +
>   	ether_setup(dev);
>   
>   	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
> @@ -1838,6 +1932,8 @@ static void veth_setup(struct net_device *dev)
>   	dev->max_mtu = ETH_MAX_MTU;
>   	dev->watchdog_timeo = msecs_to_jiffies(16000);
>   
> +	priv->tx_coal_usecs = VETH_BQL_COAL_TX_USECS;
> +
>   	dev->hw_features = VETH_FEATURES;
>   	dev->hw_enc_features = VETH_FEATURES;
>   	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;

