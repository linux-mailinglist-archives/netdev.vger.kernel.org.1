Return-Path: <netdev+bounces-298521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ePgCKkrFK2riEgQAu9opvQ
	(envelope-from <netdev+bounces-298521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:37:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03514677DC4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:37:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fDUINKdM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298521-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298521-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E44C32B9120
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BD734EF1F;
	Fri, 12 Jun 2026 08:35:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E81379C56;
	Fri, 12 Jun 2026 08:35:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253351; cv=none; b=j1q/o8U9mXUeF6dhzT8cCDq7FisVH9Fop63RAl1eMojRMZOzgqwc8PlGovSYf/ttlCPe0KYnhcl+bf0a90w1nlkgf0mC0glSUseH0GMXRwoi3RbRpBD+cnfeaJCy+tE5v0V0Kd5itUEpIKEGo4oqM/XmyveigEetD9mVfDk93Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253351; c=relaxed/simple;
	bh=flWs7KW3LIz0yAAZOSh6kcOPJuuZc6YXdNOhWgbD0Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9yH1iuHNM8z8t2T8rGFcvFyBVZacay+38tJ250YHYRVQsZE6rJip3ODv5Y1SPb+vBbiRNZkydlrs9D96Vu7leJbDCRzt8Dta6UfAkE04Nj6xQ+BYI4cZVuzQ3D32/0ct0Jyhih2gT6r647atRBD40eAESIy9bAmEMRrexroYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDUINKdM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723471F000E9;
	Fri, 12 Jun 2026 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253347;
	bh=hU+mBeqgS24JpmDSmShXgD1Niscqr5PZUf66FNgFciQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fDUINKdMDGgUGzJoSbg7hfw1Od9Sc5gwHT/6GXQKGwoYnRuOqundgn4BxRWd4e/cS
	 lKAQ+rK30kQIvW9U0WjT9khtB1HMrQ0+bffSY4TpmIXxy/4h4uOf5bLHuUqJzpEwqL
	 Vgz6X0O/Vmqh/sN4hpgToYml/p3vRqYTzY0quQogdKszLW+1Z49MG1V2YDMfUeAYhQ
	 xkFS76HBY0boQLSiARqW9wC2GSvtIRIaNV93J3ncyPVHq0cYXuK04YPB8IPHAVV2Sl
	 WpSGshEri/rmsEh9725KVQtxZx7njWfumpzKCsnRyRXAzfpBD3UCEGdtW6oh+2EF+V
	 Hg2OcJElVd7Tg==
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
Subject: [PATCH net-next v7 2/5] veth: implement Byte Queue Limits (BQL) for latency reduction
Date: Fri, 12 Jun 2026 10:35:25 +0200
Message-ID: <20260612083530.1650245-3-hawk@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298521-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03514677DC4

From: Jesper Dangaard Brouer <hawk@kernel.org>

Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
reduce TX drops") gave qdiscs control over veth by returning
NETDEV_TX_BUSY when the ptr_ring is full (DRV_XOFF).  That commit noted
a known limitation: the 256-entry ptr_ring sits in front of the qdisc as
a dark buffer, adding base latency because the qdisc has no visibility
into how many bytes are already queued there.

Add BQL support so the qdisc gets feedback and can begin shaping traffic
before the ring fills.  In testing with fq_codel, BQL reduces ping RTT
under UDP load from ~6.61ms to ~0.36ms (18x).

Charge a fixed VETH_BQL_UNIT (1) per packet rather than skb->len, so
the DQL limit tracks packets-in-flight.  Unlike a physical NIC, veth
has no link speed -- the ptr_ring drains at CPU speed and is
packet-indexed, not byte-indexed, so bytes are not the natural unit.
With byte-based charging, small packets sneak many more entries into
the ring before STACK_XOFF fires, deepening the dark buffer under
mixed-size workloads.  Testing with a concurrent min-size packet flood
shows 3.7x ping RTT degradation with skb->len charging versus no
change with fixed-unit charging.

Charge BQL inside veth_xdp_rx() under the ptr_ring producer_lock, after
confirming the ring is not full.  The charge must precede the produce
because the NAPI consumer can run on another CPU and complete the SKB
the instant it becomes visible in the ring.  Doing both under the same
lock avoids a pre-charge/undo pattern -- BQL is only charged when
produce is guaranteed to succeed.

BQL is enabled only when a real qdisc is attached (guarded by
!qdisc_txq_has_no_queue), as HARD_TX_LOCK provides serialization
for TXQ modification like dql_queued(). For lltx devices, like veth,
this HARD_TX_LOCK serialization isn't provided.  The ptr_ring
producer_lock provides additional serialization that would allow
BQL to work correctly even with noqueue, though that combination
is not currently enabled, as the netstack will drop and warn.

Track per-SKB BQL state via a VETH_BQL_FLAG pointer tag in the ptr_ring
entry.  This is necessary because the qdisc can be replaced live while
SKBs are in-flight -- each SKB must carry the charge decision made at
enqueue time rather than re-checking the peer's qdisc at completion.

Complete per-SKB in veth_xdp_rcv() rather than in bulk, so STACK_XOFF
clears promptly when producer and consumer run on different CPUs.

BQL introduces a second independent queue-stop mechanism (STACK_XOFF)
alongside the existing DRV_XOFF (ring full).  Both must be clear for the
queue to transmit.  At teardown, veth_napi_del_range() drains the
leftover ring entries after synchronize_net() -- once NAPI is gone and
the producer has stopped charging BQL (it observes rq->napi == NULL).
Rather than netdev_tx_reset_queue(), which calls dql_reset() and races
with a concurrent producer, balance the DQL accounting by completing the
outstanding charges via netdev_tx_completed_queue().  The peer txq is
still woken to clear any DRV_XOFF a late veth_xmit() may have set.  Clamp
the loop to the peer's num_tx_queues, since the peer may have fewer TX
queues than the local device has RX queues (e.g. veth enslaved to a bond
with XDP attached).

Co-developed-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c | 131 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 120 insertions(+), 11 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0cfb19b760dd..a3505627f49e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -34,9 +34,13 @@
 #define DRV_VERSION	"1.0"
 
 #define VETH_XDP_FLAG		BIT(0)
+#define VETH_BQL_FLAG		BIT(1)
 #define VETH_RING_SIZE		256
 #define VETH_XDP_HEADROOM	(XDP_PACKET_HEADROOM + NET_IP_ALIGN)
 
+/* Fixed BQL charge: DQL limit tracks packets-in-flight, not bytes */
+#define VETH_BQL_UNIT		1
+
 #define VETH_XDP_TX_BULK_SIZE	16
 #define VETH_XDP_BATCH		16
 
@@ -280,6 +284,21 @@ static bool veth_is_xdp_frame(void *ptr)
 	return (unsigned long)ptr & VETH_XDP_FLAG;
 }
 
+static bool veth_ptr_is_bql(void *ptr)
+{
+	return (unsigned long)ptr & VETH_BQL_FLAG;
+}
+
+static struct sk_buff *veth_ptr_to_skb(void *ptr)
+{
+	return (void *)((unsigned long)ptr & ~VETH_BQL_FLAG);
+}
+
+static void *veth_skb_to_ptr(struct sk_buff *skb, bool bql)
+{
+	return bql ? (void *)((unsigned long)skb | VETH_BQL_FLAG) : skb;
+}
+
 static struct xdp_frame *veth_ptr_to_xdp(void *ptr)
 {
 	return (void *)((unsigned long)ptr & ~VETH_XDP_FLAG);
@@ -295,7 +314,26 @@ static void veth_ptr_free(void *ptr)
 	if (veth_is_xdp_frame(ptr))
 		xdp_return_frame(veth_ptr_to_xdp(ptr));
 	else
-		kfree_skb(ptr);
+		kfree_skb(veth_ptr_to_skb(ptr));
+}
+
+/* Drain frames left in the ptr_ring at teardown, freeing each one and
+ * returning the number of BQL-charged SKBs.  The caller completes these
+ * via netdev_tx_completed_queue() to balance the DQL accounting, avoiding
+ * the racy netdev_tx_reset_queue()/dql_reset().
+ */
+static unsigned int veth_ptr_ring_drain(struct ptr_ring *ring)
+{
+	unsigned int n_bql = 0;
+	void *ptr;
+
+	while ((ptr = ptr_ring_consume(ring))) {
+		if (veth_ptr_is_bql(ptr))
+			n_bql++;
+		veth_ptr_free(ptr);
+	}
+
+	return n_bql;
 }
 
 static void __veth_xdp_flush(struct veth_rq *rq)
@@ -309,19 +347,39 @@ static void __veth_xdp_flush(struct veth_rq *rq)
 	}
 }
 
-static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
+static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb, bool do_bql,
+		       struct netdev_queue *txq)
 {
-	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
+	struct ptr_ring *ring = &rq->xdp_ring;
+
+	spin_lock(&ring->producer_lock);
+	if (unlikely(__ptr_ring_check_produce(ring))) {
+		spin_unlock(&ring->producer_lock);
 		return NETDEV_TX_BUSY; /* signal qdisc layer */
+	}
+
+	/* Charge BQL before produce; the consumer cannot see the entry yet.
+	 * veth is lltx, so the stack skips HARD_TX_LOCK and txq->_xmit_lock
+	 * does not serialise txq->dql here.  This producer_lock is the single
+	 * producer lock for dql_queued() (1:1 with this rq's peer txq), and
+	 * the peer NAPI in veth_xdp_rcv() is the single completer -- the
+	 * two-context model that dql_queued()/dql_completed() require.
+	 */
+	if (do_bql)
+		netdev_tx_sent_queue(txq, VETH_BQL_UNIT);
+
+	__ptr_ring_produce(ring, veth_skb_to_ptr(skb, do_bql));
+	spin_unlock(&ring->producer_lock);
 
 	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
 }
 
 static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
-			    struct veth_rq *rq, bool xdp)
+			    struct veth_rq *rq, bool xdp, bool do_bql,
+			    struct netdev_queue *txq)
 {
 	return __dev_forward_skb(dev, skb) ?: xdp ?
-		veth_xdp_rx(rq, skb) :
+		veth_xdp_rx(rq, skb, do_bql, txq) :
 		__netif_rx(skb);
 }
 
@@ -347,11 +405,12 @@ static bool veth_skb_is_eligible_for_gro(const struct net_device *dev,
 static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
+	struct netdev_queue *txq = NULL;
 	struct veth_rq *rq = NULL;
-	struct netdev_queue *txq;
 	struct net_device *rcv;
 	int length = skb->len;
 	bool use_napi = false;
+	bool do_bql = false;
 	int ret, rxq;
 
 	rcu_read_lock();
@@ -375,8 +434,12 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	skb_tx_timestamp(skb);
-
-	ret = veth_forward_skb(rcv, skb, rq, use_napi);
+	if (rxq < dev->real_num_tx_queues) {
+		txq = netdev_get_tx_queue(dev, rxq);
+		/* BQL charge happens inside veth_xdp_rx() under producer_lock */
+		do_bql = use_napi && !qdisc_txq_has_no_queue(txq);
+	}
+	ret = veth_forward_skb(rcv, skb, rq, use_napi, do_bql, txq);
 	switch (ret) {
 	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
 		if (!use_napi)
@@ -412,6 +475,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		net_crit_ratelimited("%s(%s): Invalid return code(%d)",
 				     __func__, dev->name, ret);
 	}
+
 	rcu_read_unlock();
 
 	return ret;
@@ -900,7 +964,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
 static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct veth_xdp_tx_bq *bq,
-			struct veth_stats *stats)
+			struct veth_stats *stats,
+			struct netdev_queue *peer_txq)
 {
 	int i, done = 0, n_xdpf = 0;
 	void *xdpf[VETH_XDP_BATCH];
@@ -928,9 +993,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			}
 		} else {
 			/* ndo_start_xmit */
-			struct sk_buff *skb = ptr;
+			bool bql_charged = veth_ptr_is_bql(ptr);
+			struct sk_buff *skb = veth_ptr_to_skb(ptr);
 
 			stats->xdp_bytes += skb->len;
+			if (peer_txq && bql_charged)
+				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
+
 			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
 			if (skb) {
 				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
@@ -976,7 +1045,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
 		   netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
 
 	xdp_set_return_frame_no_direct();
-	done = veth_xdp_rcv(rq, budget, &bq, &stats);
+	done = veth_xdp_rcv(rq, budget, &bq, &stats, peer_txq);
 
 	if (stats.xdp_redirect > 0)
 		xdp_do_flush();
@@ -1074,6 +1143,7 @@ static int __veth_napi_enable(struct net_device *dev)
 static void veth_napi_del_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
+	struct net_device *peer;
 	int i;
 
 	for (i = start; i < end; i++) {
@@ -1085,11 +1155,49 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 	}
 	synchronize_net();
 
+	/* This rq's frames were BQL-charged on the peer's txq[i]. */
+	peer = rtnl_dereference(priv->peer);
+
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
+		struct netdev_queue *txq;
+		unsigned int n_bql;
 
 		rq->rx_notify_masked = false;
+
+		/* Drain leftover ring frames, counting BQL-charged SKBs that
+		 * were charged via netdev_tx_sent_queue() but never consumed.
+		 */
+		n_bql = veth_ptr_ring_drain(&rq->xdp_ring);
 		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
+
+		if (!peer || i >= peer->num_tx_queues)
+			continue;
+
+		txq = netdev_get_tx_queue(peer, i);
+
+		/* Balance the peer txq's DQL accounting by completing the
+		 * outstanding charges instead of netdev_tx_reset_queue():
+		 * dql_reset() races with a concurrent producer, while
+		 * netdev_tx_completed_queue() is the normal single-completer
+		 * path and is safe here -- NAPI is gone (synchronize_net()
+		 * above) and the producer stopped charging BQL once it
+		 * observed rq->napi == NULL.  Completing every charge drives
+		 * DQL inflight to 0 and clears STACK_XOFF.
+		 */
+		if (n_bql)
+			netdev_tx_completed_queue(txq, n_bql,
+						  n_bql * VETH_BQL_UNIT);
+
+		/* DRV_XOFF is independent of BQL/STACK_XOFF: a concurrent
+		 * veth_xmit() may have set it between rcu_assign_pointer(napi,
+		 * NULL) and synchronize_net(); with NAPI gone nothing else
+		 * clears it.  The completion above only clears STACK_XOFF, so
+		 * still wake the txq to clear DRV_XOFF -- but only when the
+		 * device is still up.
+		 */
+		if (netif_running(dev))
+			netif_tx_wake_queue(txq);
 	}
 
 	for (i = start; i < end; i++) {
@@ -1741,6 +1849,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
+	dev->bql = true;
 
 	dev->netdev_ops = &veth_netdev_ops;
 	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
-- 
2.43.0


