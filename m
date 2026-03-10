Return-Path: <netdev+bounces-266190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMo2D7pAsGkehgIAu9opvQ
	(envelope-from <netdev+bounces-266190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:03:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE60254395
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91BDA3003714
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B630B502;
	Tue, 10 Mar 2026 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B+XQa83+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FC30B525
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153747; cv=none; b=tPYPzANR0tAAUtjxB4V+vBiMr8FdMsyySpNQ65ZBperou3oF+q9jqWMAVY0QxzvfFrThN40840RJfcKmS3MpoYMjnlp/6DoL+PCJz2seShCEJs6EY6nUxJwjLKUdnqG3UOcKa+5AmPiAw2K/T4je0jhgb1cqgFQKavWY3H4n0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153747; c=relaxed/simple;
	bh=2dSqv9SKAmQyIiVz6uMiFbeoTsqTWFo88VA9jUePmV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tU0IVGSeVR2XVrgKalwda/bLGuceVHLxqPCByDe6ZMOWRKSrihJoc+glPMnFkk8VnfRCcUzGYAMtzR1PYlgizYzopd0EFJufjLKTEIAgCDpWYQFPKjd4VqDmpl05t16LQ72+B7dPF+dwaeXzsUcXLDvJ4hQb8nHvqH88215N8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B+XQa83+; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-8296d553142so3204001b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153746; x=1773758546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLlu963kRco1uT795rjGcEctBvQz2SJy9aG5P2+yFUM=;
        b=K7OX+ssyf8iR2QbFNWzqAryd1jTmt5baXJAbVs1N1lvOIbfaoE1PycZPj8y2HkT0ub
         7siFs0sJ+jzJuuVVy2yCVFHliMcEv3OTuWlbFIKLwxh5DoxqDtKxEaJqJ0lkqKVcA4bF
         nyQAH1Q8qURnmBSgG16DBVKn6pS0H4Ri7PFkA/wsFFDCxg3I41LjhJ6JqWWGDYGT65PV
         6q6PF8S5WhhZmFwzUU++yahpTfZ1o+gkWIYTT/6WGs1rTfDJXXLLwkBmp5VGIE7tYDDf
         aq0Dse8ZMoex9eAMQa7cmaeeUIBAJWJZNGKg2wx64PTby6rTvqVmjQjyHLMq00Iln5AG
         Mw0w==
X-Gm-Message-State: AOJu0YwMDRBeucQGRKVe653WEWXsP06HMdPIuTGkSALNiKrrI5M3ZAN9
	LlvuYxHDtP+214pQgD4tTrw5EXkgnc/y+95YkiR7jm+BAq27GlZnfm2/f+ENYf5t1jOLZl6v5le
	cLBFfE6kL4PcCxeS4Attt1qxVOiMKA8FWNYRD/WOUmJ86sSHe34mNYJF7JZCgx9mcLSmDRXDSDp
	/TdQRxUnbVJgjVXuNt8sQGZIUDIqE+nVe6rzAIo4vs+AcCHgWytofQEgrb9l2dFZWl+u0UpAx/e
	+R3x9FlGhna68m7+g==
X-Gm-Gg: ATEYQzz04awJePo/2nJGr6O6/kWTxR6wITUtDTWEZcvEStRRm7akk3i5IcUZjlGB/LO
	z0lu6QNuHTyCNIrnt2SpiNAwvesxDYYCEdFkFQ6WJI85uSXXsCFuiVusuUXFiwUqzlG3aUCL5Vw
	HuD7Htk/Apwvg3lR4gCXdKYrMBaPuFFp8dCMrN1v4/CN1vOeecosWr7pvKNG9V1imyMx3pIwGOE
	PdtCJLcyH5LzqbCWgkYR77xW7NTEKvbY97zAYC1HVEw9jDeRu5Ib3LSYEj8lLeqL01PwtXsel4H
	FOX1tab8Fnn4yK4dX8h8qx13pmOFE5nrF1UrWj+VjCR+YN53uhbVJazGxESxjTv6dD9I7PW9XfJ
	6Ok3eWOM0jwThcG3nObgSNFU79bOf9ctAZSQbdvmVTa53o9YE9sU3SusQgWkR1c5D5BRpQUF89q
	1vWBiVm40D8p8YVE/62dy+2TJzpGhGeZFnQRh8H2xyRAyfl9ZU3L4H4GsuYQty+TVZrQ==
X-Received: by 2002:a05:6a00:8d96:b0:81b:d5d9:a83a with SMTP id d2e1a72fcca58-829a30cd002mr12299774b3a.61.1773153745821;
        Tue, 10 Mar 2026 07:42:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-829a48a54c3sm1251276b3a.8.2026.03.10.07.42.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:42:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae47b3adacso89971805ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773153744; x=1773758544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLlu963kRco1uT795rjGcEctBvQz2SJy9aG5P2+yFUM=;
        b=B+XQa83+2dMY2fBRZDuo4ztk6kBLoLo8G45tWX3ulnPmCYTU4QSQ20CaT2P3gHiRnA
         Qjl4yvdh5Utx0N9R6ZHrTdOZ7b9aDPF23vdIRc38ltPA10G0Mff806h5O+OfoH6WoCCl
         j9VDeLLWBMdcqs6xWt2cd10an+5JnLFEQX5DI=
X-Received: by 2002:a17:902:e808:b0:2ae:a481:2a4f with SMTP id d9443c01a7336-2aea4812ce0mr31436405ad.12.1773153744072;
        Tue, 10 Mar 2026 07:42:24 -0700 (PDT)
X-Received: by 2002:a17:902:e808:b0:2ae:a481:2a4f with SMTP id d9443c01a7336-2aea4812ce0mr31436035ad.12.1773153743607;
        Tue, 10 Mar 2026 07:42:23 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783cfsm157096515ad.56.2026.03.10.07.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:42:23 -0700 (PDT)
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
Subject: [PATCH net-next v6 08/10] bng_en: implement ndo_get_stats64
Date: Tue, 10 Mar 2026 20:10:42 +0530
Message-ID: <20260310144044.21672-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
References: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: DAE60254395
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266190-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Implement the ndo_get_stats64 callback to report aggregate network
statistics. The driver gathers these by accumulating the per-ring
counters into the provided rtnl_link_stats64 structure.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 105 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   1 +
 2 files changed, 106 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 43446f3f5bd2..03872bde4cd0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2911,6 +2911,102 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
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
@@ -2918,10 +3014,18 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_tx_disable(bn);
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	synchronize_rcu();
 
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
@@ -2971,6 +3075,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_features_check	= bnge_features_check,
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index ca1977b58964..6be7dbe44be8 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -381,6 +381,7 @@ struct bnge_net {
 
 	u64			flags;
 
+	struct rtnl_link_stats64	net_stats_prev;
 	struct bnge_total_ring_err_stats ring_err_stats_prev;
 
 	struct bnge_stats_mem	port_stats;
-- 
2.47.3


