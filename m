Return-Path: <netdev+bounces-264002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOAkNKV7qGmHuwAAu9opvQ
	(envelope-from <netdev+bounces-264002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:36:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B84C20673C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 927F032CE472
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F53E1219;
	Wed,  4 Mar 2026 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WO7lo1Xn"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4803E0C69;
	Wed,  4 Mar 2026 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648697; cv=none; b=pJGj+awl/dnvPKUzP7Kf9PMB7YvDFSXh5RJTRPnz3W1iSaFXEpTZieo7bir0+rElUdakCPGZy0vUuAmYlZrDBQry8fTgEuNKASfW0pPI6ZOryJ4tfdnfwQQNDsYHwnOVIkcW/LDaeMO0OlwQyPQKhZmIknQEIh0NMI5a8PnLjWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648697; c=relaxed/simple;
	bh=V1cxfz1RVnwzXZRXsNSqaV7vjhBBeY9wugZ2uCUAE30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FcYfUYwGtqUhG7TkQwDAsoXidHwOCkcXivGGHAaDSo1HYmZhg48Njx8cbD1rG/B78AJyYb/fgK9h6O4XveEhjbnnngx0EVkhhbbY1ylVWxkrnJdNfxR8TRjtCNJB6RMoXiU+r9XrCjt60/X2aYzx3nvPqF1EMxuy9YThl+KegX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WO7lo1Xn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2B18E1A2CB5;
	Wed,  4 Mar 2026 18:24:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 008675FF5C;
	Wed,  4 Mar 2026 18:24:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47E8E103695EE;
	Wed,  4 Mar 2026 19:24:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648693; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=u1s91F5grS0fyQv6iyaQkfETkK6uLonCQoWR9iCw2sk=;
	b=WO7lo1XnDtILDDaRKOWMMFgOaKZWlrIjV14E2hymfx2CBiuOobTb/6fz8nQqAn+oVF0xRU
	EXsqFXH2jdh9jR3uQkZZlToYwRAQuBzqi3OSu1ou56etETfZR7/EkIL5owpf7uR2DUX0I4
	qA48joQlgSWH1B9YXp/xC2fsUwRdhH5xLg6ya/SIZmprpTx5fPMXEL6F7mHQWDkUxcsHEX
	03BX7D1La37q24DubVKojI4ud8/QJ51bfMA26IEiVzp+24n8fosZ0f+b2tacU8lE9SMkbj
	K6gRKXSXDVTeC9pmDvuKgnfrhqE7ZFgifVYFrK/0E962zpjOGObjebQS36mn6A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 04 Mar 2026 19:24:29 +0100
Subject: [PATCH net-next 6/8] net: macb: add infrastructure for XSK buffer
 pool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-macb-xsk-v1-6-ba2ebe2bdaa3@bootlin.com>
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
In-Reply-To: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 3B84C20673C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264002-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

Store a XSK buffer pool per queue, assigned through .ndo_bpf() with
command == XDP_SETUP_XSK_POOL.

We have no sequence upstream to disable a single queue, free its
buffers, refill it and re-enable the queue (without affecting other
queues). Therefore we protect our operation with interface-wide close
and open.

Also, prepare the terrain with a .ndo_xsk_wakeup() operation that does
the pre-flight-checks but is a no-op.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 66 +++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 009a44e94726..a9e6f0289ecb 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1278,6 +1278,7 @@ struct macb_queue {
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
 	struct page_pool	*page_pool;
+	struct xsk_buff_pool	*xsk_pool;
 	struct sk_buff		*skb;
 	struct xdp_rxq_info	xdp_rxq;
 };
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 65c2ec2a843c..a72d59ffd1cf 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -38,6 +38,7 @@
 #include <linux/types.h>
 #include <linux/udp.h>
 #include <net/pkt_sched.h>
+#include <net/xdp_sock_drv.h>
 #include "macb.h"
 
 /* This structure is only used for MACB on SiFive FU540 devices */
@@ -1564,6 +1565,24 @@ static int gem_xdp_xmit(struct net_device *dev, int num_frame,
 	return xmitted;
 }
 
+static int gem_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct macb_queue *queue = &bp->queues[qid];
+
+	if (unlikely(!netif_carrier_ok(dev)))
+		return -ENETDOWN;
+
+	if (unlikely(qid >= bp->num_queues ||
+		     !rcu_access_pointer(bp->prog) ||
+		     !queue->xsk_pool))
+		return -ENXIO;
+
+	/* no-op, until rx/tx implement XSK support */
+
+	return 0;
+}
+
 static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 		       unsigned int *len, unsigned int *headroom,
 		       dma_addr_t addr)
@@ -3580,6 +3599,46 @@ static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 	return err;
 }
 
+static int gem_xdp_setup_xsk_pool(struct net_device *netdev,
+				  struct xsk_buff_pool *pool, u16 qid)
+{
+	struct macb *bp = netdev_priv(netdev);
+	unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING;
+	struct macb_queue *queue = &bp->queues[qid];
+	bool running = netif_running(netdev);
+	struct device *dev = &bp->pdev->dev;
+	int err = 0;
+
+	if (qid >= bp->num_queues)
+		return -EINVAL;
+
+	if (pool && queue->xsk_pool)
+		return -EBUSY;
+
+	if (running)
+		macb_close(netdev);
+
+	if (pool) {
+		err = xsk_pool_dma_map(pool, dev, attrs);
+		if (err)
+			netdev_err(netdev, "xdp: failed to DMA map XSK pool\n");
+		else
+			queue->xsk_pool = pool;
+	} else {
+		if (queue->xsk_pool)
+			xsk_pool_dma_unmap(queue->xsk_pool, attrs);
+		queue->xsk_pool = NULL;
+	}
+
+	if (running) {
+		int err_open = macb_open(netdev);
+
+		err = err ?: err_open;
+	}
+
+	return err;
+}
+
 static int gem_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct macb *bp = netdev_priv(dev);
@@ -3590,6 +3649,9 @@ static int gem_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return gem_xdp_setup(dev, xdp->prog, xdp->extack);
+	case XDP_SETUP_XSK_POOL:
+		return gem_xdp_setup_xsk_pool(dev, xdp->xsk.pool,
+					      xdp->xsk.queue_id);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -4852,6 +4914,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_setup_tc		= macb_setup_tc,
 	.ndo_bpf		= gem_xdp,
 	.ndo_xdp_xmit		= gem_xdp_xmit,
+	.ndo_xsk_wakeup		= gem_xsk_wakeup,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -6156,7 +6219,8 @@ static int macb_probe(struct platform_device *pdev)
 
 		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
 				    NETDEV_XDP_ACT_REDIRECT |
-				    NETDEV_XDP_ACT_NDO_XMIT;
+				    NETDEV_XDP_ACT_NDO_XMIT |
+				    NETDEV_XDP_ACT_XSK_ZEROCOPY;
 	}
 
 	netif_carrier_off(dev);

-- 
2.53.0


