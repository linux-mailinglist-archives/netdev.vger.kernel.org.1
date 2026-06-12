Return-Path: <netdev+bounces-298524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SKNyKQLFK2rTEgQAu9opvQ
	(envelope-from <netdev+bounces-298524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:36:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C65C2677D9B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:36:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JX3sZlNi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298524-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298524-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 855D630136EA
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216D3624C2;
	Fri, 12 Jun 2026 08:36:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF69336657B;
	Fri, 12 Jun 2026 08:35:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253366; cv=none; b=ZRm8VAswH4ZiJbs5wo9hqCj/v0NLhsZyCO4DPtSN8tQrsKblQdixGr3FooNdfMhfMuh3kYIjC9utVwo6ahrE7Zn1Y7oBIGT7S1O7ARn+WQNuNzz1bKU4d3LxuSYAgaNHKYgLEoows3L2bo2czk92BW0tiMY0UMmXS+Uz1DKEH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253366; c=relaxed/simple;
	bh=vJvhoCjYFi7nku93XZ8Xsv5ZuhM4XpNSVt0umKRN1gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiU/CaF7cA+5B6cVPNAclBTnkn4BenQwQ9/6wEm5zql1xFjQToywyBmC6UrJyeWH2Dd/tOo/XMnqvalPpLF2bYXSg3cWF/i7vy9sFS7qaTkQZOBrXdtVGv8fgfy+RM/49UTGTM2RDRpKAg5O/0f4zI5slAtY24rs+y1hUfJSE2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX3sZlNi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7B41F000E9;
	Fri, 12 Jun 2026 08:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253358;
	bh=i1DTlKLgM/HMH8WkeRaA8e8qK8NysWWT7+U6NLDrelA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JX3sZlNiobtc4s5Q1ZdYOw/mor7ZGiYWSrSP1CESH986IpDMFwN4jlxMo+qG82ZJu
	 pgKBpi/NOHopKIQ9TI6J/bYtxw9XXSUq7KnbJtDBR074SwOukzsPQRJRNsFi94XsmL
	 1P+aw5K+2wORJyV16nx9WRWbFYFuhmPiYlDx5LSzlfo4LTUWmFsSiwr6uIc6oI8UlP
	 fuJi5j+0fRWXWccj7jVjqn/pbZhpgP8YuvoR28WK75bu8mntZiKUjI9sbPXX0bRAK3
	 DT7GEQwruPzuiXaGVLV/EGNQxbq4nd9E+PQFC0fYU2sKbZINMcL4QURBJB6qam+BAo
	 Jt6P/rFCoDDmA==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	simon.schippers@tu-dortmund.de,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v7 5/5] veth: time-based BQL completion coalescing via ethtool tx-usecs
Date: Fri, 12 Jun 2026 10:35:28 +0200
Message-ID: <20260612083530.1650245-6-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612083530.1650245-1-hawk@kernel.org>
References: <20260612083530.1650245-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298524-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:simon.schippers@tu-dortmund.de,m:hawk@kernel.org,m:j.koeppeler@tu-berlin.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[cloudflare.com,tu-dortmund.de,kernel.org,tu-berlin.de,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C65C2677D9B

From: Simon Schippers <simon.schippers@tu-dortmund.de>

Per-packet BQL completion forces DQL to converge on limit=2, causing
excessive NAPI scheduling overhead and qdisc requeues.

Accumulate BQL completions and flush them when a configurable time
threshold (tx-usecs) is exceeded, letting DQL discover a limit that
bounds actual queuing delay to the configured interval. Coalescing
state persists across NAPI polls in struct veth_rq so completions can
accumulate beyond a single budget=64 cycle.

The flush condition is:

state->time + bql_flush_ns <= current_time || state->n_bql > dql.limit

Flushing when n_bql exceeds dql.limit handles BQL starvation.

The comparison is strictly greater-than because netdev_tx_sent_queue()
always lets the producer exceed the limit by one before it stops, so
n_bql == dql.limit is a normal in-flight state. dql.limit lives in
the same cacheline as the completion path, so the check is cheap.

Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
setting tx-usecs to 0 disables coalescing and falls back to per-packet
completion.

  ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
  ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)

Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Co-developed-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/veth.c | 123 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 6 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 2473f730734b..c62d87a8402c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -28,6 +28,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/net_tstamp.h>
 #include <linux/skbuff_ref.h>
+#include <linux/sched/clock.h>
 #include <net/page_pool/helpers.h>
 
 #define DRV_NAME	"veth"
@@ -50,6 +51,7 @@
  * delay => 64 * 250 ms = 16 s.
  */
 #define VETH_WATCHDOG_TIMEOUT_MS	(64 * 250)
+#define VETH_BQL_COAL_TX_USECS	100 /* default tx-usecs for BQL batching */
 
 struct veth_stats {
 	u64	rx_drops;
@@ -69,6 +71,11 @@ struct veth_rq_stats {
 	struct u64_stats_sync	syncp;
 };
 
+struct veth_bql_state {
+	u64	time;	/* sched_clock() when current coalescing window started */
+	uint	n_bql;	/* BQL completions batched in the current window */
+};
+
 struct veth_rq {
 	struct napi_struct	xdp_napi;
 	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
@@ -76,6 +83,7 @@ struct veth_rq {
 	struct bpf_prog __rcu	*xdp_prog;
 	struct xdp_mem_info	xdp_mem;
 	struct veth_rq_stats	stats;
+	struct veth_bql_state	bql_state;
 	bool			rx_notify_masked;
 	struct ptr_ring		xdp_ring;
 	struct xdp_rxq_info	xdp_rxq;
@@ -88,6 +96,7 @@ struct veth_priv {
 	struct bpf_prog		*_xdp_prog;
 	struct veth_rq		*rq;
 	unsigned int		requested_headroom;
+	unsigned int		tx_coal_usecs;	/* BQL completion coalescing */
 };
 
 struct veth_xdp_tx_bq {
@@ -272,7 +281,56 @@ static void veth_get_channels(struct net_device *dev,
 static int veth_set_channels(struct net_device *dev,
 			     struct ethtool_channels *ch);
 
+static int veth_get_coalesce(struct net_device *dev,
+			     struct ethtool_coalesce *ec,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct veth_priv *priv = netdev_priv(dev);
+
+	ec->tx_coalesce_usecs = priv->tx_coal_usecs;
+	return 0;
+}
+
+static int veth_set_coalesce(struct net_device *dev,
+			     struct ethtool_coalesce *ec,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct veth_priv *priv = netdev_priv(dev);
+	struct net_device *peer;
+
+	/* The coalescing window delays BQL completions, so keep tx-usecs well
+	 * below the tx_timeout watchdog; otherwise a large value could stall a
+	 * stopped queue long enough to trip a false watchdog timeout. Cap at
+	 * half the watchdog to leave a generous safety margin. tx-usecs is
+	 * microseconds, the watchdog is milliseconds.
+	 */
+	if (ec->tx_coalesce_usecs > VETH_WATCHDOG_TIMEOUT_MS / 2 * USEC_PER_MSEC) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx-usecs must stay below half the tx_timeout watchdog");
+		return -ERANGE;
+	}
+
+	/* Paired with READ_ONCE in veth_xdp_rcv(). */
+	WRITE_ONCE(priv->tx_coal_usecs, ec->tx_coalesce_usecs);
+
+	/* veth_xdp_rcv() reads each device's own value, so mirror it onto
+	 * the peer to keep the pair symmetric: both directions coalesce
+	 * with the same tx-usecs. Called under RTNL, rtnl_dereference() is safe.
+	 */
+	peer = rtnl_dereference(priv->peer);
+	if (peer) {
+		struct veth_priv *peer_priv = netdev_priv(peer);
+
+		WRITE_ONCE(peer_priv->tx_coal_usecs, ec->tx_coalesce_usecs);
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops veth_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_TX_USECS,
 	.get_drvinfo		= veth_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_strings		= veth_get_strings,
@@ -282,6 +340,8 @@ static const struct ethtool_ops veth_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_channels		= veth_get_channels,
 	.set_channels		= veth_set_channels,
+	.get_coalesce		= veth_get_coalesce,
+	.set_coalesce		= veth_set_coalesce,
 };
 
 /* general routines */
@@ -969,13 +1029,54 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	return NULL;
 }
 
+static void veth_bql_maybe_complete(struct veth_bql_state *state,
+				    struct netdev_queue *peer_txq,
+				    u64 bql_flush_ns)
+{
+	u64 current_time;
+
+	/* There is no reason to complete with 0 and
+	 * peer_txq could go away.
+	 */
+	if (!state->n_bql || !peer_txq)
+		return;
+
+	current_time = sched_clock();
+
+	/* We complete if:
+	 * 1. We reach bql_flush_ns.
+	 * 2. We potentially have BQL starvation.
+	 */
+	if (state->time + bql_flush_ns <= current_time ||
+	    state->n_bql > peer_txq->dql.limit) {
+		netdev_tx_completed_queue(peer_txq, state->n_bql,
+					  state->n_bql * VETH_BQL_UNIT);
+		state->time = current_time;
+		state->n_bql = 0;
+	}
+}
+
 static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct veth_xdp_tx_bq *bq,
 			struct veth_stats *stats,
 			struct netdev_queue *peer_txq)
 {
+	struct veth_priv *priv = netdev_priv(rq->dev);
+	struct veth_bql_state *state = &rq->bql_state;
 	int i, done = 0, n_xdpf = 0;
 	void *xdpf[VETH_XDP_BATCH];
+	u64 bql_flush_ns;
+
+	/* Mirrored to both peers; paired with WRITE_ONCE() in veth_set_coalesce */
+	bql_flush_ns = (u64)READ_ONCE(priv->tx_coal_usecs) * 1000;
+
+	/* Clamp stored timestamp in case we migrated to a CPU with a behind
+	 * sched_clock(); tries to reduce late BQL flushes.
+	 */
+	state->time = min(state->time, sched_clock());
+
+	/* Flush completions that timed out since the previous NAPI poll. */
+	veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
 
 	for (i = 0; i < budget; i++) {
 		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
@@ -1000,12 +1101,11 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			}
 		} else {
 			/* ndo_start_xmit */
-			bool bql_charged = veth_ptr_is_bql(ptr);
 			struct sk_buff *skb = veth_ptr_to_skb(ptr);
 
+			if (veth_ptr_is_bql(ptr))
+				state->n_bql++;
 			stats->xdp_bytes += skb->len;
-			if (peer_txq && bql_charged)
-				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
 
 			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
 			if (skb) {
@@ -1015,6 +1115,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 					napi_gro_receive(&rq->xdp_napi, skb);
 			}
 		}
+		veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
 		done++;
 	}
 
@@ -1123,6 +1224,9 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
+		rq->bql_state.time = sched_clock();
+		rq->bql_state.n_bql = 0;
+
 		napi_enable(&rq->xdp_napi);
 		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
 	}
@@ -1172,11 +1276,15 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 
 		rq->rx_notify_masked = false;
 
-		/* Drain leftover ring frames, counting BQL-charged SKBs that
-		 * were charged via netdev_tx_sent_queue() but never consumed.
+		/* Drain leftover ring frames, counting BQL-charged SKBs, and
+		 * add the completions still pending in the coalescing window
+		 * (consumed by NAPI but not yet flushed).  Both were charged
+		 * via netdev_tx_sent_queue() and are still outstanding.
 		 */
-		n_bql = veth_ptr_ring_drain(&rq->xdp_ring);
+		n_bql = veth_ptr_ring_drain(&rq->xdp_ring) + rq->bql_state.n_bql;
 		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
+		rq->bql_state.n_bql = 0;
+		rq->bql_state.time = 0;
 
 		if (!peer || i >= peer->num_tx_queues)
 			continue;
@@ -1865,6 +1973,8 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 
 static void veth_setup(struct net_device *dev)
 {
+	struct veth_priv *priv = netdev_priv(dev);
+
 	ether_setup(dev);
 
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -1889,6 +1999,7 @@ static void veth_setup(struct net_device *dev)
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->watchdog_timeo = msecs_to_jiffies(VETH_WATCHDOG_TIMEOUT_MS);
+	priv->tx_coal_usecs = VETH_BQL_COAL_TX_USECS;
 
 	dev->hw_features = VETH_FEATURES;
 	dev->hw_enc_features = VETH_FEATURES;
-- 
2.43.0


