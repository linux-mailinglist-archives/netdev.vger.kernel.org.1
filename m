Return-Path: <netdev+bounces-275692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKdHM9b202k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:09:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E23D3A603A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88F423072E12
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4C93932DC;
	Mon,  6 Apr 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VNsq+l5w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7080395DAC
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498745; cv=none; b=I7F4NMEUCDdDJ6Eju0GCGVTjppVyVJm6kfdCeK0MpzO6H91ITQTGgm+aru6jCgF4VoIYU99bVc5SLxxEW353y0YLvzEc35q5O2rsTX5yfwT5wlNMv0HhfJ76xFEpYYJiFWsZ0W66u5xN4igqfxe0AGvIVNVLksc1z0QIhEw4w5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498745; c=relaxed/simple;
	bh=Cajp8ShyjCKsjkWXi07E3Ep1vQT5l4912QE0EORrpEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWUHZHNrHlPGGJ/4PXYAqB9A6CNqEUzNQSKFQ4J6qnX9dK12zN0KE+nnTXklLZW//vAYwMnttweeZ59jQDr1b+5XpgY/lSNIgLGXhy2I0vQOFJ0mFp/zqZKm3Xx/QPDS801x08ZGlkvK9gZ9uctlVCTZ3AkQ0GLW7dWa43zGn00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VNsq+l5w; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2b2429f98d0so26980165ad.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498743; x=1776103543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62L+lkwkabTqrbJgOlUnrsnIX9RqZuB3+ZmXt/1peyc=;
        b=lza56hZIfHtEshzjUeMVwBP/x05SU2OXKKGWSXhHgajPKlPxnFsNolsIyFQTvgUpAc
         anof1/Pjr3y708r6MiiVQBpRUJwL6qZp7EtyBNaUPO+T4Dcr6KynDsH2UVoBwS2VEi34
         PhYgZjx7rkyqag/Hu8PupHSkf8FDnXvA52s79oDXatwRtNK1DKKZvuMqtRkUjmRwrBb7
         1vxqY81AeYb1P5rDTXKvGCQ+qKaGAiHJSZWAmmVvhyYB5gkXDQT96kGm8FgCj1aPcPfr
         q5M/pYnofPp/0mVQqOZm4Vloq3rG59p/DQD4upMedwXKYwI1Dthu/160CfMnbCFmk7KL
         YANg==
X-Gm-Message-State: AOJu0YwBSjDh0M5Dz+CoII287GaKVM+jbqwR25mFjzd9F7ZxdYW1k+Ju
	f6KHTQPgytkNicSpOL+naTrKFEeEUxdtgv4H2XejwEC9zyRWrUyZjcT3IkkzDIQjj/cH7F8lrlv
	psLQOx927yv/pvJN7KNdzmgPmPv+9mOcvveDmAHT+E3KQN+ILlC0mbSPl7EqzdGXSk/Mxc9aDIp
	1sLA6jas9coZrFIlzJaQL2qP5N3CvRB22fazifPMLE0jeYh4PtbOul7LzPoqUSsyRyl90Xna/XU
	vflC0AODZcRDT6Chg==
X-Gm-Gg: AeBDies+M3NRcko/6RBkb1jPHVkD+s5IeL+ypg2b5LDmgoCuwPki2hwvSrjd1B/vc0G
	khriyMQ2hyhInAcvkiC5yrKhRhdZE7bLp3l7bp1jp6FVAqp6oi0mUaB4tJrLler8pffihVO/+9z
	dtPNuQryKwXaQXopz2T3kcklYgzvG8UTaa9qxInb9pOz6NupMjAe/m0iBBwxiXGqIeVwxSjC8Ec
	0916rYU6O8iLYwcht2Qv3lIgAmfb+ev5Yc+3t93FcUetbVpNWvz1847aEVb0Ux50TG/vF4lk7yv
	bRmLE+5V+BxJxAYD6aEb9CaZvVUyiCIo2GsLINJV7EG1/QwHz6jqy8gGUq1aZCb5jo9mtSM+ZnI
	+P8dPsh5u1aQ33WpXMx+ZUx59er+ATbjCIx32cylUCXjMDbD/ATw419OgygGezFHQoO4CiEUVhU
	U+lCseXFk4DjdwKpL/ssk5Kjc/aD2569OusBHPrI3dGeJV8n1euLIVIUqpanHAfu0=
X-Received: by 2002:a17:903:2a8f:b0:2b2:5491:e32f with SMTP id d9443c01a7336-2b2816b95a4mr155157145ad.16.1775498743306;
        Mon, 06 Apr 2026 11:05:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b27471dfcesm9146165ad.9.2026.04.06.11.05.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:05:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b242b9359aso40100985ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775498741; x=1776103541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62L+lkwkabTqrbJgOlUnrsnIX9RqZuB3+ZmXt/1peyc=;
        b=VNsq+l5wZz4JqxQ6dVCwegLb92wOKDtwD68XY8naDdjJApx3mCIasU842BGbgr+tMx
         6z1clJzABLARHBau9KJ2vSbOmbd68S4AIEHoviufnzZCDVyQmAfcDZ44hwZMmzer77ZT
         vyiYmpYMGJvF4fjcgLyIhY4W5EXcy55Fgwx0M=
X-Received: by 2002:a17:902:7c89:b0:2ae:5eee:7a5 with SMTP id d9443c01a7336-2b28167aa4fmr99852955ad.12.1775498741338;
        Mon, 06 Apr 2026 11:05:41 -0700 (PDT)
X-Received: by 2002:a17:902:7c89:b0:2ae:5eee:7a5 with SMTP id d9443c01a7336-2b28167aa4fmr99852735ad.12.1775498740746;
        Mon, 06 Apr 2026 11:05:40 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm140625145ad.61.2026.04.06.11.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:05:40 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v12 09/10] bng_en: implement netdev_stat_ops
Date: Mon,  6 Apr 2026 23:34:19 +0530
Message-ID: <20260406180420.279470-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
References: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275692-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E23D3A603A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement netdev_stat_ops to provide standardized per-queue
statistics via the Netlink API.

Below is the description of the hardware drop counters:

rx-hw-drop-overruns: Packets dropped by HW due to resource limitations
(e.g., no BDs available in the host ring).
rx-hw-drops: Total packets dropped by HW (sum of overruns and error
drops).
tx-hw-drop-errors: Packets dropped by HW because they were invalid or
malformed.
tx-hw-drops: Total packets dropped by HW (sum of resource limitations
and error drops).

The implementation was verified using the ynl tool:

./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/netdev.yaml --dump qstats-get --json \
'{"ifindex":14, "scope":"queue"}'

[{'ifindex': 14, 'queue-id': 0, 'queue-type': 'rx', 'rx-bytes': 758,
'rx-hw-drop-overruns': 0, 'rx-hw-drops': 0, 'rx-packets': 11},
 {'ifindex': 14, 'queue-id': 1, 'queue-type': 'rx', 'rx-bytes': 0,
'rx-hw-drop-overruns': 0, 'rx-hw-drops': 0, 'rx-packets': 0},
{'ifindex': 14, 'queue-id': 0, 'queue-type': 'tx', 'tx-bytes': 0,
'tx-hw-drop-errors': 0, 'tx-hw-drops': 0, 'tx-packets': 0},
 {'ifindex': 14, 'queue-id': 1, 'queue-type': 'tx', 'tx-bytes': 0,
'tx-hw-drop-errors': 0, 'tx-hw-drops': 0, 'tx-packets': 0},
 {'ifindex': 14, 'queue-id': 2, 'queue-type': 'tx', 'tx-bytes': 810,
'tx-hw-drop-errors': 0, 'tx-hw-drops': 0, 'tx-packets': 10},]

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 227 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   7 +
 2 files changed, 234 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 4148a9ec6d23..70768193004c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2860,6 +2860,7 @@ static int bnge_open_core(struct bnge_net *bn)
 	}
 
 	set_bit(BNGE_STATE_OPEN, &bd->state);
+	set_bit(BNGE_STATE_STATS_ENABLE, &bn->state);
 
 	bnge_enable_int(bn);
 
@@ -2898,6 +2899,77 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
 	return 0;
 }
 
+static void bnge_add_prev_ring_stats64(struct bnge_net *bn,
+				       struct rtnl_link_stats64 *stats)
+{
+	struct netdev_queue_stats_rx *rx_save = &bn->rxq_prv_stats;
+	struct netdev_queue_stats_tx *tx_save = &bn->txq_prv_stats;
+	struct rtnl_link_stats64 *stats64_save = &bn->prv_stats64;
+
+	stats->rx_packets += rx_save->packets;
+	stats->tx_packets += tx_save->packets;
+	stats->rx_bytes += rx_save->bytes;
+	stats->tx_bytes += tx_save->bytes;
+	stats->rx_missed_errors += rx_save->hw_drop_overruns;
+	stats->tx_dropped += tx_save->hw_drop_errors;
+
+	stats->multicast += stats64_save->multicast;
+}
+
+static void bnge_get_ring_stats64(struct bnge_dev *bd,
+				  struct rtnl_link_stats64 *stats)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		u64 tx_bytes, tx_packets, tx_dropped;
+		u64 multicast, rx_missed_errors;
+		struct bnge_nq_ring_info *nqr;
+		u64 rx_bytes, rx_packets;
+		unsigned int start;
+		u64 *sw;
+
+		nqr = &bnapi->nq_ring;
+		sw = nqr->stats.sw_stats;
+
+		do {
+			start = u64_stats_fetch_begin(&nqr->stats.syncp);
+
+			rx_packets = BNGE_GET_RING_STATS64(sw, rx_ucast_pkts);
+			rx_packets += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+			rx_packets += BNGE_GET_RING_STATS64(sw, rx_bcast_pkts);
+
+			tx_packets = BNGE_GET_RING_STATS64(sw, tx_ucast_pkts);
+			tx_packets += BNGE_GET_RING_STATS64(sw, tx_mcast_pkts);
+			tx_packets += BNGE_GET_RING_STATS64(sw, tx_bcast_pkts);
+
+			rx_bytes = BNGE_GET_RING_STATS64(sw, rx_ucast_bytes);
+			rx_bytes += BNGE_GET_RING_STATS64(sw, rx_mcast_bytes);
+			rx_bytes += BNGE_GET_RING_STATS64(sw, rx_bcast_bytes);
+
+			tx_bytes = BNGE_GET_RING_STATS64(sw, tx_ucast_bytes);
+			tx_bytes += BNGE_GET_RING_STATS64(sw, tx_mcast_bytes);
+			tx_bytes += BNGE_GET_RING_STATS64(sw, tx_bcast_bytes);
+
+			multicast = BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+			rx_missed_errors =
+				BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+			tx_dropped =
+				BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+		} while (u64_stats_fetch_retry(&nqr->stats.syncp, start));
+
+		stats->rx_packets += rx_packets;
+		stats->tx_packets += tx_packets;
+		stats->rx_bytes += rx_bytes;
+		stats->tx_bytes += tx_bytes;
+		stats->multicast += multicast;
+		stats->rx_missed_errors += rx_missed_errors;
+		stats->tx_dropped += tx_dropped;
+	}
+}
+
 static void bnge_get_port_stats64(struct bnge_net *bn,
 				  struct rtnl_link_stats64 *stats)
 {
@@ -2929,6 +3001,22 @@ static void bnge_get_port_stats64(struct bnge_net *bn,
 	} while (u64_stats_fetch_retry(&bn->port_stats.syncp, start));
 }
 
+static void bnge_fill_prev_stats64(struct bnge_net *bn,
+				   struct rtnl_link_stats64 *stats)
+{
+	struct netdev_queue_stats_rx *rx_save = &bn->rxq_prv_stats;
+	struct netdev_queue_stats_tx *tx_save = &bn->txq_prv_stats;
+	struct rtnl_link_stats64 *stats64_save = &bn->prv_stats64;
+
+	stats->rx_packets = rx_save->packets;
+	stats->tx_packets = tx_save->packets;
+	stats->rx_bytes = rx_save->bytes;
+	stats->tx_bytes = tx_save->bytes;
+	stats->rx_missed_errors = rx_save->hw_drop_overruns;
+	stats->tx_dropped = tx_save->hw_drop_errors;
+	stats->multicast = stats64_save->multicast;
+}
+
 static void bnge_get_stats64(struct net_device *dev,
 			     struct rtnl_link_stats64 *stats)
 {
@@ -2936,6 +3024,57 @@ static void bnge_get_stats64(struct net_device *dev,
 
 	if (bn->flags & BNGE_FLAG_PORT_STATS)
 		bnge_get_port_stats64(bn, stats);
+
+	spin_lock_bh(&bn->stats_lock);
+	if (!test_bit(BNGE_STATE_STATS_ENABLE, &bn->state)) {
+		bnge_fill_prev_stats64(bn, stats);
+		spin_unlock_bh(&bn->stats_lock);
+		return;
+	}
+
+	bnge_get_ring_stats64(bn->bd, stats);
+	bnge_add_prev_ring_stats64(bn, stats);
+	spin_unlock_bh(&bn->stats_lock);
+}
+
+static void bnge_save_ring_stats(struct bnge_net *bn)
+{
+	struct netdev_queue_stats_rx *rx_save = &bn->rxq_prv_stats;
+	struct netdev_queue_stats_tx *tx_save = &bn->txq_prv_stats;
+	struct rtnl_link_stats64 *stats64_save = &bn->prv_stats64;
+	int i;
+
+	for (i = 0; i < bn->bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		u64 *sw;
+
+		nqr = &bnapi->nq_ring;
+		sw = nqr->stats.sw_stats;
+
+		rx_save->packets += BNGE_GET_RING_STATS64(sw, rx_ucast_pkts);
+		rx_save->packets += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+		rx_save->packets += BNGE_GET_RING_STATS64(sw, rx_bcast_pkts);
+		rx_save->bytes += BNGE_GET_RING_STATS64(sw, rx_ucast_bytes);
+		rx_save->bytes += BNGE_GET_RING_STATS64(sw, rx_mcast_bytes);
+		rx_save->bytes += BNGE_GET_RING_STATS64(sw, rx_bcast_bytes);
+		rx_save->hw_drop_overruns += BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+		rx_save->hw_drops += BNGE_GET_RING_STATS64(sw, rx_error_pkts) +
+				BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+
+		tx_save->packets += BNGE_GET_RING_STATS64(sw, tx_ucast_pkts);
+		tx_save->packets += BNGE_GET_RING_STATS64(sw, tx_mcast_pkts);
+		tx_save->packets += BNGE_GET_RING_STATS64(sw, tx_bcast_pkts);
+		tx_save->bytes += BNGE_GET_RING_STATS64(sw, tx_ucast_bytes);
+		tx_save->bytes += BNGE_GET_RING_STATS64(sw, tx_mcast_bytes);
+		tx_save->bytes += BNGE_GET_RING_STATS64(sw, tx_bcast_bytes);
+		tx_save->hw_drop_errors += BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+		tx_save->hw_drops += BNGE_GET_RING_STATS64(sw, tx_discard_pkts) +
+				BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+
+		stats64_save->multicast +=
+			BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+	}
 }
 
 static void bnge_close_core(struct bnge_net *bn)
@@ -2949,6 +3088,13 @@ static void bnge_close_core(struct bnge_net *bn)
 	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+
+	/* Save ring stats before shutdown */
+	spin_lock_bh(&bn->stats_lock);
+	bnge_save_ring_stats(bn);
+	clear_bit(BNGE_STATE_STATS_ENABLE, &bn->state);
+	spin_unlock_bh(&bn->stats_lock);
+
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
@@ -2967,6 +3113,85 @@ static int bnge_close(struct net_device *dev)
 	return 0;
 }
 
+static void bnge_get_queue_stats_rx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_nq_ring_info *nqr;
+	u64 *sw;
+
+	if (!bn->bnapi)
+		return;
+
+	nqr = &bn->bnapi[i]->nq_ring;
+	sw = nqr->stats.sw_stats;
+
+	stats->packets = 0;
+	stats->packets += BNGE_GET_RING_STATS64(sw, rx_ucast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, rx_bcast_pkts);
+
+	stats->bytes = 0;
+	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_ucast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_mcast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_bcast_bytes);
+
+	stats->hw_drop_overruns = BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+	stats->hw_drops = BNGE_GET_RING_STATS64(sw, rx_error_pkts) +
+				stats->hw_drop_overruns;
+}
+
+static void bnge_get_queue_stats_tx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_tx *stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_napi *bnapi;
+	u64 *sw;
+
+	if (!bn->tx_ring)
+		return;
+
+	bnapi = bn->tx_ring[bn->tx_ring_map[i]].bnapi;
+	sw = bnapi->nq_ring.stats.sw_stats;
+
+	stats->packets = 0;
+	stats->packets += BNGE_GET_RING_STATS64(sw, tx_ucast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, tx_mcast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, tx_bcast_pkts);
+
+	stats->bytes = 0;
+	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_ucast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_mcast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_bcast_bytes);
+
+	stats->hw_drop_errors = BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+	stats->hw_drops = BNGE_GET_RING_STATS64(sw, tx_discard_pkts) +
+				stats->hw_drop_errors;
+}
+
+static void bnge_get_base_stats(struct net_device *dev,
+				struct netdev_queue_stats_rx *rx,
+				struct netdev_queue_stats_tx *tx)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	rx->packets = bn->rxq_prv_stats.packets;
+	rx->bytes = bn->rxq_prv_stats.bytes;
+	rx->hw_drops = bn->rxq_prv_stats.hw_drops;
+	rx->hw_drop_overruns = bn->rxq_prv_stats.hw_drop_overruns;
+
+	tx->packets = bn->txq_prv_stats.packets;
+	tx->bytes = bn->txq_prv_stats.bytes;
+	tx->hw_drops = bn->txq_prv_stats.hw_drops;
+	tx->hw_drop_errors = bn->txq_prv_stats.hw_drop_errors;
+}
+
+static const struct netdev_stat_ops bnge_stat_ops = {
+	.get_queue_stats_rx	= bnge_get_queue_stats_rx,
+	.get_queue_stats_tx	= bnge_get_queue_stats_tx,
+	.get_base_stats		= bnge_get_base_stats,
+};
+
 static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
@@ -3113,6 +3338,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bd->netdev = netdev;
 
 	netdev->netdev_ops = &bnge_netdev_ops;
+	netdev->stat_ops = &bnge_stat_ops;
 
 	bnge_set_ethtool_ops(netdev);
 
@@ -3212,6 +3438,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	rc = bnge_alloc_port_stats(bn);
 	if (rc)
 		goto err_free_workq;
+	spin_lock_init(&bn->stats_lock);
 
 	netdev->request_ops_lock = true;
 	rc = register_netdev(netdev);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index a73f51b01bc2..f4636b5b0cf3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -8,6 +8,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/refcount.h>
 #include <linux/u64_stats_sync.h>
+#include <net/netdev_queues.h>
 #include "bnge_db.h"
 #include "bnge_hw_def.h"
 #include "bnge_link.h"
@@ -264,6 +265,7 @@ struct bnge_stats_mem {
 
 enum bnge_net_state {
 	BNGE_STATE_NAPI_DISABLED,
+	BNGE_STATE_STATS_ENABLE,
 };
 
 #define BNGE_TIMER_INTERVAL	HZ
@@ -361,6 +363,11 @@ struct bnge_net {
 	u16			fw_rx_stats_ext_size;
 	u16			fw_tx_stats_ext_size;
 
+	struct netdev_queue_stats_rx	rxq_prv_stats;
+	struct netdev_queue_stats_tx	txq_prv_stats;
+	struct rtnl_link_stats64	prv_stats64;
+	spinlock_t			stats_lock;
+
 	u8			pri2cos_idx[8];
 	bool			pri2cos_valid;
 };
-- 
2.47.3


