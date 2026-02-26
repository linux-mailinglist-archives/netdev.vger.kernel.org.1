Return-Path: <netdev+bounces-261538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MArSG2WSoGllkwQAu9opvQ
	(envelope-from <netdev+bounces-261538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:35:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CADC1ADBED
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B4D43098B1A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CBC3E8C5B;
	Thu, 26 Feb 2026 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y9eAN07I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DF428837
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130177; cv=none; b=tbNeAwQWShMwdghwZ0Z5OJcvog+k9TKznapOmJ8kFcXoJmnm0bYNjCZpbTTaMqheA1WQVCWYPlltcnev3CeY5T6ZuYAZ+Ic62ycc6BEbLTK+ibxnlZTmlxE2VKJ7oEVfzrfGN12kpWo39uvhB+9JpX/IuXO/jRGIdsSeeyDmogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130177; c=relaxed/simple;
	bh=VAJPtSz2Fi4CfU/cWreGio0ngANvFTPjoaoTm2qwyKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev6fqDUgxYpwv5owcnhemdz+WZxZ9sae+Q8vY38oaC++qtw0rhS/m3jmUPkN5S5FPqfyTQmrf5qkVqXbJoO127wH1+uTQv6iT1SXU2i9P7Hlhs7v6nObvtv2M5ckVg2tdLoS+Ss9WyI88nyaFw6MEvn6VzzXSvWc5wMfN3V1NH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y9eAN07I; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-358e16d7da4so709637a91.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130176; x=1772734976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOSdVE7QGMpM1n9UC5hcdfQe4GJ8NgDaBIZ1ScDmGuU=;
        b=sgRgqzcSDEIZneTvcYszkhutqenUq/1R0SLzOKeIQKEd3Ch21TIyXDyvGKLKpUksVp
         BdjbIK+HxSibaU8TFY9BdVGNk4HRNlfZ45zcwMP72fq5DDsIkg6yb047DZGOZpyuh+pJ
         n/vrPC6GubIuA+JElluUt8YVdJZxpJV4eK7ycTaFvZeGjwzGHpMXrWXLjOlP8sLw8kLw
         SLTrscgMtkX98bazoka3zg3LIj78WiZynJEjG4P2P2cP7Iuk6cIFuh29MCyIR8Ezpobu
         DafHXNOth+tfIc9IgvzSa2L/YJOowQXFIArtbSQ+7Sm6flNDWpOlpmexD20Wp+hzyeb1
         qycw==
X-Gm-Message-State: AOJu0YxZ24CyfvTzjk/z2nXGw4wHiGm8IJ6Be8YwOduA/PWEFYiAIX9V
	zgTTM7kexZj0Mocb7+Zl5xBC51dw6flTFdH867gmtNIFEtpLC+6Qv4Q6HXIZqWZqdAm1ikRgwdz
	pfnxUNWNkCxDf0WYUjrXjxyPHCPqtLePq/2H5hafb6kdo7fw+ralmLO0Uqt8tCQtzDzsd/UA9mi
	SI7ahP/Ai0Tbdzh64kyqgHByeV2xKEmGZEI93ORHKc3gRj0fVhXafhhr6EmSXtqLEtE5ujpcY/L
	3PfWi+bX+uMCQRZIQ==
X-Gm-Gg: ATEYQzySOFLcNRFB1tsIUzrgVrf6qAUdySmXIRWQBrE64YVBdOCGuU4lvyqHW98ZMiE
	3yOFKJF1FNjP47JsHUv2R4pQ3lntg8fQdkmDJJ0DSLZogOCH9a9cOitUdcWkkrI3HeJjRQYQxAG
	+8N9Q/7SrSYKamX1c/QdpcYsl2/bVCpa2F6gprui8lFt9yNFFsuj2yo0x4/DTSQ27PF45qt8UeQ
	koEA56ccTKKVQfPVh8mGHElJY4U/+LD06fJaT7F1QSZjJg8lwyV3QDhtjGPgbJe0oCcbBm2FrJF
	cIeGnr24auiekP+hYTa6OxzEb97KtdmBYuCBOdepcZTV1r37+FUkBp0NWYTZE6EdWgFKDVGao2x
	lGu/k48yrn5aAXvbVKc+XsrWe/nDCc6IojG/TKsHwTppKLHoArexUurDTESADcFqMqhYLNyRzQS
	ktE3pyJ9DP7EfFbhyNOBprBn1ClpPRzbfhpmr2geuNx0hKZri1YK5TrXlIwJGByjyn7w==
X-Received: by 2002:a17:90b:1f8a:b0:352:ba0f:fb28 with SMTP id 98e67ed59e1d1-35965c117aamr109031a91.1.1772130175591;
        Thu, 26 Feb 2026 10:22:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3593ddfa655sm314877a91.8.2026.02.26.10.22.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:22:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad60525deso61993725ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772130174; x=1772734974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOSdVE7QGMpM1n9UC5hcdfQe4GJ8NgDaBIZ1ScDmGuU=;
        b=Y9eAN07IILeW9meO+Vx67S8ed0Z4YrcS9yX1t8wBkB1SwIKSVMW2PUbR9S1nw49YoA
         PuzsjJx7paY7es1s1OkxPo/RgdYB4/a0JYugeEgKICq5h8U4ehTw0EoM7Ee1bK0fvEu6
         sNQ1u1wj+zQDTwM4KePlcLgg2w612fwDYlbdI=
X-Received: by 2002:a17:902:e785:b0:2ad:c1e1:c286 with SMTP id d9443c01a7336-2adc1e1c458mr76045505ad.24.1772130174087;
        Thu, 26 Feb 2026 10:22:54 -0800 (PST)
X-Received: by 2002:a17:902:e785:b0:2ad:c1e1:c286 with SMTP id d9443c01a7336-2adc1e1c458mr76045045ad.24.1772130173384;
        Thu, 26 Feb 2026 10:22:53 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm35941565ad.53.2026.02.26.10.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:22:52 -0800 (PST)
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
Subject: [PATCH net-next v2 8/8] bng_en: implement ndo_get_stats64
Date: Thu, 26 Feb 2026 23:51:33 +0530
Message-ID: <20260226182133.1566714-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
References: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261538-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1CADC1ADBED
X-Rspamd-Action: no action

Implement the ndo_get_stats64 callback to report aggregate network
statistics. The driver gathers these by accumulating the per-ring
counters into the provided rtnl_link_stats64 structure.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 111 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   2 +
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 2b772956df8..7de82a0ce9a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -468,7 +468,8 @@ static void bnge_sp_task(struct work_struct *work)
 
 static bool bnge_drv_busy(struct bnge_net *bn)
 {
-	return test_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+	return test_bit(BNGE_STATE_IN_SP_TASK, &bn->state) ||
+	       test_bit(BNGE_STATE_READ_STATS, &bn->state);
 }
 
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
@@ -2934,6 +2935,106 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
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
+	set_bit(BNGE_STATE_READ_STATS, &bn->state);
+	/* Make sure bnge_close_core() sees that we are reading stats before
+	 * we check the BNGE_STATE_OPEN flag.
+	 */
+	smp_mb__after_atomic();
+	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
+		clear_bit(BNGE_STATE_READ_STATS, &bn->state);
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
+	clear_bit(BNGE_STATE_READ_STATS, &bn->state);
+}
+
 static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2949,6 +3050,13 @@ static void bnge_close_core(struct bnge_net *bn)
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
@@ -2998,6 +3106,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_features_check	= bnge_features_check,
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index f28edf94257..775438bccd0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -291,6 +291,7 @@ struct bnge_sw_stats {
 enum bnge_net_state {
 	BNGE_STATE_NAPI_DISABLED,
 	BNGE_STATE_IN_SP_TASK,
+	BNGE_STATE_READ_STATS,
 };
 
 #define BNGE_TIMER_INTERVAL	HZ
@@ -382,6 +383,7 @@ struct bnge_net {
 
 	u64			flags;
 
+	struct rtnl_link_stats64	net_stats_prev;
 	struct bnge_total_ring_err_stats ring_err_stats_prev;
 
 	struct bnge_stats_mem	port_stats;
-- 
2.47.3


