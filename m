Return-Path: <netdev+bounces-267583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHH3Ma1wtGm2oAAAu9opvQ
	(envelope-from <netdev+bounces-267583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:16:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC8289A54
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80C1E3129FA1
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445143E4C85;
	Fri, 13 Mar 2026 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlAVTCAO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQtKGpLh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702613E1CEC
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432918; cv=none; b=dMLxA1AYHncsKC6bFmqCZfAzBW4h6S2yxTZKvtxffrceC8o8nvNnunm/25D3cbBSSSC/gwGEY1ip7Yg5goRfYX6pcUC5cVvdCXF28qk1DQg1J/bqDjeOy0jistN6bFJqldgjv9CUu2OymgPAEH5xZ1sh0YRCGNkQ5dPIrIWf5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432918; c=relaxed/simple;
	bh=6PdSfNwqEqRVwqKEl1diJ7mDQqp3k5KqQ9Hlmqdxlbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lf0vbgBxNTCm5xb2Umd9Vg4x5KfFQuP4HEvkVgrx7GMqoK4H34oacdff08j9PfzY/bwh+uS5KX/AuloiriAH8HYjVKE4foZY2W/2ZIXv6q9/9HZRT2u6Ga7Qy48gfK0OXz/C+B+jvoAc4Ghcar8ZG8dA2iBfvYvDhPZxfEKXPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlAVTCAO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQtKGpLh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773432912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TfY6mJ7jH0tKbI2eI71TkdtnAdzwPEX4+8G0DdopGI=;
	b=OlAVTCAOjjfaHDtZ0e5Y0Bteq6cuSNR2SNNW25Mb5Q22l9PGB2ENfmz01Lb7KUVo7zE3Wy
	c3BnBHMBnOjTc5nV05lasNQj5QqVn+2QRPeIm/psmTAvLObLre3sbDRrjbwtvP5d2fTcPH
	UKYV/cmbrV2T6xCIYguiBDupSa1tabg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-eIlrB8bGO7eoGTiIEdWRUg-1; Fri, 13 Mar 2026 16:15:11 -0400
X-MC-Unique: eIlrB8bGO7eoGTiIEdWRUg-1
X-Mimecast-MFC-AGG-ID: eIlrB8bGO7eoGTiIEdWRUg_1773432910
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853f33b7dbso22574145e9.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773432910; x=1774037710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TfY6mJ7jH0tKbI2eI71TkdtnAdzwPEX4+8G0DdopGI=;
        b=EQtKGpLhjPEyhcEZ81zgc5uSftUrVcFpmgtkVmt1jko8pRGU9oV9de+uDNRn5Y76Mm
         lSyHkOJoC1s9PrHFbZSSl1uKgd3l9+01tZ3RbGif5JfK9Q9VYzltjsewoS1U1MqiMqUK
         4SihAhD3hdwTCpY5gpgE7Ic2sF4AdHbBWukns6BkxzMEwDNf1OPrf4vt8owDJ3Q8nXQs
         CzEgvMrTsfRPZipU72zmL/wvf85nwMuzBiCUiJwUHY+rGsHA4Yg3r2/Fz3nU0Ov1AUgx
         03vNdPk82omUcIWE7nYzfyqxUm9Fs6IuH3yOjHpwZWoHthpzmHKJQSPCXFAlLyqFcXbJ
         Eumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773432910; x=1774037710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7TfY6mJ7jH0tKbI2eI71TkdtnAdzwPEX4+8G0DdopGI=;
        b=ad83hF/wk6eActZr/pf/ijYNPV0rAOQgxbCqQty5RUmYSNibGrKbukI7m7w1OsIAeo
         pWbhbvsy48RUXQjXa8J8DSHSTuFm+KY3hFqKAAiwEuP1Btq43LL4w2HPfGUOd9vqL7+4
         4Nsi7cOHQRurl9Y+ffz2H2Ayf24un8bvp6iESXTsmQbVVfC7gWaCoIdFhgDaL77ZkBCd
         U0vub0XeBUs9E6N0gQaAgTnzoWmMDdVdkN0pnzb7Sz0vUzNL6tRws0JhokyAzE8GGAd/
         QAA9glIw0YxgEdRE2i/GyZHjiQEtc+4Pgyd5+5u7hSoTqJVU6jtPKOHvFstOcc+BGkxf
         HwLg==
X-Gm-Message-State: AOJu0YzVECK7RgMHXxEY4+AQqFJahe8suqHgRypIAHLeFFArHj4Sp5S5
	pe7oxeoUPDzkqpdlTZu2Lmi2K7SKRgy2LXJB9YaIa8JIlcmFHsdy/e2un02HllEXbu1NsS3sxpc
	H7taOPF7c/QAcfMHjuMD03c1RDy9vN5xT9d0k0ZBl3UENNPct7AjHVnUOyjwhUba0yU9FPGVWF6
	9Zev+wKGqxlKRkW1cfInA9bQgGrhaJ3hvkWI9XmizmoQ==
X-Gm-Gg: ATEYQzymKBtyeXsuEjiDzOxhOj9Xb/X6j3kdhr9Y0cLp/DB8n/0BZ7rnYVFZiTsp7QI
	0IUhG30n+jmGz41rMB8xZeW8LlZ6jFFdxJo7JaJd4fzBO7jKR88gGwOEDKMHedrDxfykF3utttE
	RZ3uSJrqxLa1P9WDRO4p6HivP7b/QqDMpacXIiz4r57haY8ukBZFOVZCLXRrCQH7VPahuRP4kpt
	Q5xMlC17Wu4I9TbWOLRAernVva87frD4fyB2jub3JDu0s4IaOS1flaosd0svi8QZmcXx3V7J9md
	+1s9ECA7Igh0C2MA+pgi7Yw6IfIF07uikm92dznfUczThJH59HSIRgTQ1EDB448RppII1XSNzgO
	zDFihoEV+R2Cmma/t3itAfq1K9EZBFiUQZiGbWATFUSlMzsMLn1R2k8nhov4=
X-Received: by 2002:a05:600c:8b45:b0:485:4526:ee05 with SMTP id 5b1f17b1804b1-48556700c0dmr74152405e9.19.1773432909735;
        Fri, 13 Mar 2026 13:15:09 -0700 (PDT)
X-Received: by 2002:a05:600c:8b45:b0:485:4526:ee05 with SMTP id 5b1f17b1804b1-48556700c0dmr74152015e9.19.1773432909286;
        Fri, 13 Mar 2026 13:15:09 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm230810055e9.0.2026.03.13.13.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:15:08 -0700 (PDT)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v5 8/8] net: macb: introduce ndo_xdp_xmit support
Date: Fri, 13 Mar 2026 21:14:33 +0100
Message-ID: <20260313201433.2346119-9-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313201433.2346119-1-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267583-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CFC8289A54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce ndo_xdp_xmit function for redirection,
update macb_xdp_submit_frame() accordingly, and advertise
NETDEV_XDP_ACT_NDO_XMIT capability.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 73 +++++++++++++++++++-----
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index df2b3f5a2fed..a4649c0861f8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1195,11 +1195,13 @@ static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int bu
 {
 	if (type == MACB_TYPE_SKB) {
 		napi_consume_skb(buff, budget);
-	} else {
+	} else if (type == MACB_TYPE_XDP_TX) {
 		if (!budget)
 			xdp_return_frame(buff);
 		else
 			xdp_return_frame_rx_napi(buff);
+	} else {
+		xdp_return_frame(buff);
 	}
 }
 
@@ -1657,20 +1659,24 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 }
 
 static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
-				 struct net_device *dev, dma_addr_t addr)
+				 struct net_device *dev, bool dma_map,
+				 dma_addr_t addr)
 {
+	enum macb_tx_buff_type buff_type;
 	struct macb_tx_buff *tx_buff;
 	int cpu = smp_processor_id();
 	struct macb_dma_desc *desc;
 	struct macb_queue *queue;
 	unsigned int next_head;
 	unsigned long flags;
+	dma_addr_t mapping;
 	u16 queue_index;
 	int err = 0;
 	u32 ctrl;
 
 	queue_index = cpu % bp->num_queues;
 	queue = &bp->queues[queue_index];
+	buff_type = dma_map ? MACB_TYPE_XDP_NDO : MACB_TYPE_XDP_TX;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
@@ -1683,14 +1689,23 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 		goto unlock;
 	}
 
-	/* progs can adjust the head. Sync and set the adjusted one.
-	 * This also implicitly takes into account ip alignment,
-	 * if present.
-	 */
-	addr += xdpf->headroom + sizeof(*xdpf);
-
-	dma_sync_single_for_device(&bp->pdev->dev, addr,
-				   xdpf->len, DMA_BIDIRECTIONAL);
+	if (dma_map) {
+		mapping = dma_map_single(&bp->pdev->dev,
+					 xdpf->data,
+					 xdpf->len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(&bp->pdev->dev, mapping))) {
+			err = -ENOMEM;
+			goto unlock;
+		}
+	} else {
+		/* progs can adjust the head. Sync and set the adjusted one.
+		 * This also implicitly takes into account ip alignment,
+		 * if present.
+		 */
+		mapping = addr + xdpf->headroom + sizeof(*xdpf);
+		dma_sync_single_for_device(&bp->pdev->dev, mapping,
+					   xdpf->len, DMA_BIDIRECTIONAL);
+	}
 
 	next_head = queue->tx_head + 1;
 
@@ -1701,8 +1716,8 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 	desc = macb_tx_desc(queue, queue->tx_head);
 	tx_buff = macb_tx_buff(queue, queue->tx_head);
 	tx_buff->ptr = xdpf;
-	tx_buff->type = MACB_TYPE_XDP_TX;
-	tx_buff->mapping = 0;
+	tx_buff->type = buff_type;
+	tx_buff->mapping = dma_map ? mapping : 0;
 	tx_buff->size = xdpf->len;
 	tx_buff->mapped_as_page = false;
 
@@ -1713,7 +1728,7 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 		ctrl |= MACB_BIT(TX_WRAP);
 
 	/* Set TX buffer descriptor */
-	macb_set_addr(bp, desc, addr);
+	macb_set_addr(bp, desc, mapping);
 	/* desc->addr must be visible to hardware before clearing
 	 * 'TX_USED' bit in desc->ctrl.
 	 */
@@ -1738,6 +1753,32 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 	return err;
 }
 
+static int gem_xdp_xmit(struct net_device *dev, int num_frame,
+			struct xdp_frame **frames, u32 flags)
+{
+	struct macb *bp = netdev_priv(dev);
+	u32 xmitted = 0;
+	int i;
+
+	if (!macb_is_gem(bp))
+		return -EOPNOTSUPP;
+
+	if (unlikely(!netif_carrier_ok(dev)))
+		return -ENETDOWN;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	for (i = 0; i < num_frame; i++) {
+		if (macb_xdp_submit_frame(bp, frames[i], dev, true, 0))
+			break;
+
+		xmitted++;
+	}
+
+	return xmitted;
+}
+
 static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 		       unsigned int *len, unsigned int *headroom,
 		       dma_addr_t addr)
@@ -1775,7 +1816,7 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 	case XDP_TX:
 		xdpf = xdp_convert_buff_to_frame(&xdp);
 		if (unlikely(!xdpf) || macb_xdp_submit_frame(queue->bp, xdpf,
-							     dev, addr)) {
+							     dev, false, addr)) {
 			act = XDP_DROP;
 			break;
 		}
@@ -5028,6 +5069,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
 	.ndo_bpf		= gem_xdp,
+	.ndo_xdp_xmit		= gem_xdp_xmit,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -6308,7 +6350,8 @@ static int macb_probe(struct platform_device *pdev)
 			bp->rx_ip_align = NET_IP_ALIGN;
 
 		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				    NETDEV_XDP_ACT_REDIRECT;
+				    NETDEV_XDP_ACT_REDIRECT |
+				    NETDEV_XDP_ACT_NDO_XMIT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.53.0


