Return-Path: <netdev+bounces-262099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DRONiiZomlI4QQAu9opvQ
	(envelope-from <netdev+bounces-262099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:28:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2971C0FCD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6282D304B833
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263836D4FA;
	Sat, 28 Feb 2026 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zo+tnzz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1036D4EC
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263714; cv=none; b=AbqLOnuevGHIqfag6wVUsjWyZ+suOa9rZZNqnAySgYyo02JN31Cxf6HRGpdGmmmhy6bkUSE8XtnzRgCA/IUW6IqqYkv7/I7jzCQqcWng2QYHqT//71h0q30XaSCVjhmjaqWOdc5Cbi3IlIgkz1K5CnbURaHQYsUJ026RH7lP/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263714; c=relaxed/simple;
	bh=ASJM102y1jQFLW2GfzBOmODT1mo/QBTC8rGfxdp0bGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trM3Nf86VQacfAngTRp5VIn1XSXFI4AiALw47yzWDbKdD02yin24a3NB/tBWhfRfuj+iZZo421gnrd97H6MUoKbPC6u5HNiLIo1JQqMpSZcthPnqxU1rxtOVZUH5fYRkJ2Y4zLjmPLsa3VOJRuzm/Q8+SJHvf57V5BkvS1UyBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zo+tnzz2; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-6759a5576f5so1730279eaf.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772263711; x=1772868511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDjphwjEKVTy/r//tJDIih4JMCHQoRzkSENJ5Jl96Jc=;
        b=km7WhoGyOj/JIUgiLzwCH+4/OazUPZreiE10ifAGiKEXk0yTgMHR/LI5Sz3remiJA3
         mgMl/A7j+QR5v5Vsiwhd6MchN/sJW2bukVmTecgA6hI4ueVl5T6CtIDZZ4hfA7CLg7Av
         ZiT5XpDsXRAxfNJ0+tQsHu9Vyke+fn/hnA1d5EvlY37RX+CYqzZ5ZFML1Q6d+pQ/YJqi
         kS+4GPw9zJN36Dl0mzgljLjRv1osRiX4TUXTBJtVClkd6jU5rD4aLB+jQgqAKH1sHGso
         uJlzM2Q+WrGRu1qlPHgFvB671fiVCLVy5nbW6pWlW0RBZkttt66GQjCKUPdW+jcD49wX
         Ouhg==
X-Gm-Message-State: AOJu0YxAyRRpSCuX+CLePqQDmZ/ZsjKskkjz5zZWhMVCkMPY2MZ8cPgt
	lWRYcLHOC28Nw7XlthD5k9qxAbKSPFOjEd6VIPPCK/Po6VeXVwx9bmxiDrVkg9zLGLriXTZxAqu
	pZUyoruhNdTM3U7IJvc4/jNMMTn8wVuajJ/0s3ZP1bqfXwikpFlGBeeuj+I8NTQQSRePuqjP4D4
	oosfCn1dR2JjloJ/4w7MLROS3Qsy6aie5fp9Cbg0Hqk0k1kwcygZwvkiteKOPMQnVKHEwyjkZAA
	Z6wWudPYffqKMX9ww==
X-Gm-Gg: ATEYQzx0PSd7HOBgxfl5tjkHFdqKv1BVHjwpeGVkEVu2+WbbWhaNDfyWLKx9Ia0DBM1
	KHuCO49A3yxX05N2hH0jNPsyUPBedvO3c05Ih8o7YZ9ZZzVkHaYk1y/30zZf4xTMODEEAq01rYv
	zUKqi4LxNnJfbEsfKDg32kGSTdVcxX/Hlz6c93CZ9oFYxJGg7PsEnGCIS/RElb5whLO7NWWebPn
	itGdKOKWlHCVQ9vQDU2Lzg+G/ZU9no5n30UYCr441TtDxyTMqtj19AO+uX124DtZkoJjnzI31hR
	JxqvMLoi9m9/6NHP/k2wYY1BIku2CkVKWr1TdSY01te4Gc/EqZZ6ArWLyZ4uVR5XL7UJ7UbLtU4
	wL/7FnatdCK27exOjj04jreQgnDoW3BlDkHc7K7zr7mpwC0W7UYSOwaf2k1ol9R1B78Je8Baxyr
	QGwx4vhsEsB1ziv+QhjmS6bAnptdHPCr97B7LoliiEK1iaipDkSgcIOXQd8r/+
X-Received: by 2002:a05:6820:3102:b0:679:e750:6c0e with SMTP id 006d021491bc7-679fadbad18mr3521385eaf.8.1772263711425;
        Fri, 27 Feb 2026 23:28:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-679f2c00f10sm818486eaf.3.2026.02.27.23.28.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 23:28:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8274bb61b6dso736176b3a.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772263710; x=1772868510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDjphwjEKVTy/r//tJDIih4JMCHQoRzkSENJ5Jl96Jc=;
        b=Zo+tnzz26aJjMldvZT2H7JQP9roOqbma9S1vm1/Bsmh285PWDTui82urEmfJjmmYt6
         YOhLf59Lew280B53Gdt2ZCauV9olEoAb2ujymBqoz9YORfSmJ1iRouRykqCu9EnPZKiX
         iYSguEcNTo/iVi9Ple/DObJhFP+/n7qtP7xC0=
X-Received: by 2002:a05:6a00:9295:b0:7e8:43f5:bd39 with SMTP id d2e1a72fcca58-8274d9e66c5mr5957400b3a.37.1772263709803;
        Fri, 27 Feb 2026 23:28:29 -0800 (PST)
X-Received: by 2002:a05:6a00:9295:b0:7e8:43f5:bd39 with SMTP id d2e1a72fcca58-8274d9e66c5mr5957383b3a.37.1772263709395;
        Fri, 27 Feb 2026 23:28:29 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm6809267b3a.36.2026.02.27.23.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:28:29 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v3 8/8] bng_en: implement ndo_get_stats64
Date: Sat, 28 Feb 2026 12:57:15 +0530
Message-ID: <20260228072715.1632280-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
References: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262099-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6A2971C0FCD
X-Rspamd-Action: no action

Implement the ndo_get_stats64 callback to report aggregate network
statistics. The driver gathers these by accumulating the per-ring
counters into the provided rtnl_link_stats64 structure.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 110 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   1 +
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 29c072e38a7..017bb68f71f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2924,6 +2924,102 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
 	return 0;
 }
 
+static void bnge_get_ring_stats(struct bnge_dev *bd,
+				struct rtnl_link_stats64 *stats)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+		u64 *sw = nqr->stats.sw_stats;
+
+		stats->rx_packets += BNGE_GET_RING_STATS64(sw, rx_ucast_pkts);
+		stats->rx_packets += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+		stats->rx_packets += BNGE_GET_RING_STATS64(sw, rx_bcast_pkts);
+
+		stats->tx_packets += BNGE_GET_RING_STATS64(sw, tx_ucast_pkts);
+		stats->tx_packets += BNGE_GET_RING_STATS64(sw, tx_mcast_pkts);
+		stats->tx_packets += BNGE_GET_RING_STATS64(sw, tx_bcast_pkts);
+
+		stats->rx_bytes += BNGE_GET_RING_STATS64(sw, rx_ucast_bytes);
+		stats->rx_bytes += BNGE_GET_RING_STATS64(sw, rx_mcast_bytes);
+		stats->rx_bytes += BNGE_GET_RING_STATS64(sw, rx_bcast_bytes);
+
+		stats->tx_bytes += BNGE_GET_RING_STATS64(sw, tx_ucast_bytes);
+		stats->tx_bytes += BNGE_GET_RING_STATS64(sw, tx_mcast_bytes);
+		stats->tx_bytes += BNGE_GET_RING_STATS64(sw, tx_bcast_bytes);
+
+		stats->rx_missed_errors +=
+			BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+
+		stats->multicast += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+
+		stats->tx_dropped += BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+
+		stats->rx_dropped +=
+			nqr->sw_stats->rx.rx_netpoll_discards +
+			nqr->sw_stats->rx.rx_oom_discards;
+	}
+}
+
+static void bnge_add_prev_stats(struct bnge_net *bn,
+				struct rtnl_link_stats64 *stats)
+{
+	struct rtnl_link_stats64 *prev_stats = &bn->net_stats_prev;
+
+	stats->rx_packets += prev_stats->rx_packets;
+	stats->tx_packets += prev_stats->tx_packets;
+	stats->rx_bytes += prev_stats->rx_bytes;
+	stats->tx_bytes += prev_stats->tx_bytes;
+	stats->rx_missed_errors += prev_stats->rx_missed_errors;
+	stats->multicast += prev_stats->multicast;
+	stats->rx_dropped += prev_stats->rx_dropped;
+	stats->tx_dropped += prev_stats->tx_dropped;
+}
+
+static void bnge_get_stats64(struct net_device *dev,
+			     struct rtnl_link_stats64 *stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+
+	rcu_read_lock();
+	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
+		rcu_read_unlock();
+		*stats = bn->net_stats_prev;
+		return;
+	}
+
+	bnge_get_ring_stats(bd, stats);
+	bnge_add_prev_stats(bn, stats);
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		u64 *rx = bn->port_stats.sw_stats;
+		u64 *tx = bn->port_stats.sw_stats +
+			  BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+
+		stats->rx_crc_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_fcs_err_frames);
+		stats->rx_frame_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_align_err_frames);
+		stats->rx_length_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_undrsz_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_ovrsz_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_runt_frames);
+		stats->rx_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_false_carrier_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_jbr_frames);
+		stats->collisions =
+			BNGE_GET_TX_PORT_STATS64(tx, tx_total_collisions);
+		stats->tx_fifo_errors =
+			BNGE_GET_TX_PORT_STATS64(tx, tx_fifo_underruns);
+		stats->tx_errors = BNGE_GET_TX_PORT_STATS64(tx, tx_err);
+	}
+	rcu_read_unlock();
+}
+
 static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2931,14 +3027,23 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_tx_disable(bn);
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
-	/* Ensure BNGE_STATE_OPEN is cleared before checking drv_busy */
-	smp_mb__after_atomic();
+	/* No explicit barrier needed - synchronize_rcu() provides full
+	 * ordering between clear_bit() above and drv_busy() below.
+	 */
+	synchronize_rcu();
 	while (bnge_drv_busy(bn))
 		msleep(20);
 
 	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+
+	/* Save ring stats before shutdown */
+	if (bn->bnapi) {
+		bnge_get_ring_stats(bd, &bn->net_stats_prev);
+		bnge_get_ring_err_stats(bn, &bn->ring_err_stats_prev);
+	}
+
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
@@ -2988,6 +3093,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_features_check	= bnge_features_check,
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index f160ba9b69c..5a2defa970c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -382,6 +382,7 @@ struct bnge_net {
 
 	u64			flags;
 
+	struct rtnl_link_stats64	net_stats_prev;
 	struct bnge_total_ring_err_stats ring_err_stats_prev;
 
 	struct bnge_stats_mem	port_stats;
-- 
2.47.3


