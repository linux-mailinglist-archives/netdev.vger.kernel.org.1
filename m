Return-Path: <netdev+bounces-269310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFhNOIuQu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:58:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB82C66C4
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DEE231EE962
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D639A805;
	Thu, 19 Mar 2026 05:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iKREEZLq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13B2DCF52
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899587; cv=none; b=LdGhJ5Uw1PXlGbPVRHvXBzHTGCUGteCIwhE9suw/yemC4Saz5PqF8tT87VTSRAvM0xJmjGTlKdz+4t7izSQl80aeVRbCd/vRkBbB/Nkpqwq+vxLgxvTT/uRmPIpU21KoaVUxoPvja4UCkUGd/01SltthcBxfCmMAyuNP8EOIEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899587; c=relaxed/simple;
	bh=xeLBGKWLDwoWzVUgrLFagxSMqAxIiAVyI6AvxJHgAb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvivGa87wVFymyi3TyYT3xDWxRwIo2Wb+f4n56lbYVtXO3GFTB3CfQXLCx+AXQ+Jy1IavryIlsIXirGiPAScaCtH8abwG0pZS6d4GxBu+msCsb1dnRS1wwxca9rNVCQsBjas6Y/I5k7iwgn3nbtTbiXuvfhBWtCzy7fm3CHJJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iKREEZLq; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-40974bf7781so1174108fac.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899585; x=1774504385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAh3ISKJQxB+of/XmTrFR/7AjtNkBJimjNnj4gDwdz4=;
        b=Xtw0xt4WQOpDPSk0/GWfJ6luXEoKtvMBwz/UMeGEbpsqsncGSht1bNFE4CyF2YTdlu
         85m9zavwvqGUaB9f4B9m5pQFUUsKG/VWBkhErYgBxqLLk2H9wvOHs4HzOjn7X/5f7RjR
         J4U76WUJGyMIcjacFibE7RTUXZyxrxytGzmm2GQFQo/MgR0nIznb99BqOCJn/AfKsmsp
         EgIb366VvX14stZfAaen7v566VrxQU2j9X478ZVmLWaRBjdiihI+8vn+CFdowUv+olBK
         mWjk6MGIrVBuioYQKSbOIdv4XNkPJM64lIHhqkJCAmCQj7NfVniRgHtSJ84ZOtg1P3r8
         iDOA==
X-Gm-Message-State: AOJu0Yx8QyHgmJ1b+2trBLEYBlP5d2ctwsEWtp0yTIyqAk7oZDet1uWc
	Ivr1aEqGNUMYnKj4yfYJ0dUWja9xAJqFDpjeKFicLtkCTiZZYXEDugnK/D9ba1DbXBQjNQiy70+
	2YZpUVNt6D0gXcsdJGAGou2XnVL1gmt5ssedmy5uH2nobNMI1jw9/KYhx19UA/WelDp1GAB+/jd
	tY9ODjJs1SLQWTe0ixhfc7QyFYQgYszEH40+4AwMwqqdFzbYV/06Ex+noZxDMdi6JmMvzbg4pwW
	STZIaiF/w==
X-Gm-Gg: ATEYQzxtqHJISKUWmsw0xO/oW1YSKDB4v3T7LQ+y3JmSgOxe1c8HA9lRWbUcEXc5fgq
	n2vmIGBmSRxhVQW314j5c6XdPT3tJ5fSPuxylozPi1dwk2DmU1JEaG0ewppYyQ8WxsQjSGKLT50
	1/UIFCaSKx3iQjAPGpycSRgT1ICwQQbxLRawTd959PcBqYeTlDsLEu8HAFjU1URz+pgLicTSTZ+
	UYBonba5++Diy61A1HmG92W5xHdy0zqInqjImGfKGElzEYKzwXiPyAxKCcHAH5MWc8nwJ9Nffrc
	ZTxbYkKQ/4gWd3emPOOKqbwgFoK8Hepo+lPWEmC2nmO5TVn4a3d2jTgv4Snuno28PQeuD/PAzdq
	ZE57OXqSbRbqTZNDq6wFoED2cH18hNW8y2ZmY+zFRKNXk5xv0PDK/C6MRfLUVCcpMerwqjGjkwx
	zg0moqwJ6w2gSTQpFmj8/GN4uCziu+RDFVjdsJ3Yib5OaiE4CtAhwyl/RvvQ==
X-Received: by 2002:a05:6871:b09:b0:3f5:b761:5234 with SMTP id 586e51a60fabf-41beff8ca82mr1450396fac.28.1773899584907;
        Wed, 18 Mar 2026 22:53:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41bd28da754sm715788fac.5.2026.03.18.22.53.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:53:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-79868381229so61626667b3.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773899584; x=1774504384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAh3ISKJQxB+of/XmTrFR/7AjtNkBJimjNnj4gDwdz4=;
        b=iKREEZLqFx5KvF4ZMmEojqZisXhWeESsxERwf3iMgXZmVT+z2rWEXnE4r1lVMdNa3h
         RYPiltWINllWBQ3Dx+0VqKlEOJFaZ4uW5rqdErFZfqIudbxnf1B0B3DmrdgHTkljrOY8
         34i8mHWPfcWgSd+0+GthxBVG2le2CaWvk4Dww=
X-Received: by 2002:a05:690e:16e4:b0:64c:9c1c:5f6e with SMTP id 956f58d0204a3-64e9ccc4ed3mr1469945d50.5.1773899583682;
        Wed, 18 Mar 2026 22:53:03 -0700 (PDT)
X-Received: by 2002:a05:690e:16e4:b0:64c:9c1c:5f6e with SMTP id 956f58d0204a3-64e9ccc4ed3mr1469937d50.5.1773899583275;
        Wed, 18 Mar 2026 22:53:03 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a1cd32sm2918980d50.2.2026.03.18.22.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:53:02 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
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
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v8 08/10] bng_en: implement ndo_get_stats64
Date: Thu, 19 Mar 2026 11:21:22 +0530
Message-ID: <20260319055124.1350670-9-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269310-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 63CB82C66C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

Implement the ndo_get_stats64 callback to report aggregate network
statistics. The driver gathers these by accumulating the per-ring
counters into the provided rtnl_link_stats64 structure.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 100 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   2 +
 2 files changed, 102 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 93f0149bd775..2513b0907693 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2904,6 +2904,99 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
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
+		struct bnge_nq_ring_info *nqr;
+		u64 *sw;
+
+		nqr = &bnapi->nq_ring;
+		sw = nqr->stats.sw_stats;
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
+		stats->tx_dropped += BNGE_GET_RING_STATS64(sw, tx_error_pkts);
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
@@ -2911,10 +3004,16 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_tx_disable(bn);
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	synchronize_rcu();
 
 	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+
+	/* Save ring stats before shutdown */
+	if (bn->bnapi)
+		bnge_get_ring_stats(bd, &bn->net_stats_prev);
+
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
@@ -2936,6 +3035,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_features_check	= bnge_features_check,
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 548c5a77e76a..a23302a1ab9d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -353,6 +353,8 @@ struct bnge_net {
 
 	u64			flags;
 
+	struct rtnl_link_stats64	net_stats_prev;
+
 	struct bnge_stats_mem	port_stats;
 	struct bnge_stats_mem	rx_port_stats_ext;
 	struct bnge_stats_mem	tx_port_stats_ext;
-- 
2.47.1


