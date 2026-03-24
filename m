Return-Path: <netdev+bounces-271280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBoVMwPxwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:16:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA031C333
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63D1931085CD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD2346E5E;
	Tue, 24 Mar 2026 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aOnet1Eo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1E32A3EC
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382940; cv=none; b=f/c217C79U6kGesnGA/LHn4MnBdUScc90EHoYFqmyE1/TkCtbcrZUU9nElEKnnVgr2eqIcGddQllwGgYYptRzXZdRjwgssRS5z7BlfPkgWWsye+26pUjro9N39NeSxEbzQtT2bddjpwx9MvQIpG457Tw5Q/5ixg8h0O1SasS0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382940; c=relaxed/simple;
	bh=uupls+EoIqFMksBYu+xgCc7pD5LnmGujwusczIJ2UCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRkRAB3v3InJ2Zq++/YCFUgoVet3aj+C3z59jOFaHHaqPvyfv9qi87SkWgkla2jpd1zAhSVtMzuoskhrTDBfGfTV8d5L/7Lnnixth2SoY3yVUzbxF4EQUA5tpzOoNvRRXoTwmUZ+vRlXJix3in0SNAhgiRINhlxvFysNdZrfZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aOnet1Eo; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c757a9251faso1660396a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382932; x=1774987732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekLCRy2qgCJCMkJPjj+3TMPL7gi7bF1+gj7eUMscTVs=;
        b=aq90YY+7LwISCc+NP33FbNIM4ksY20n1+LEIsH5S+/ACcwFM7DZoaVjlsWK6JVetey
         hrTEnmQlUhINDHzB+TzKPU+R7tZLajy/jc0yiqimUAIAmSoN5kUA/6lPENcrkXBwc93b
         I9fZjw8d81LauO+C2a7X0VbkGYZwy9kd4zCJWNGB54rcdXBCCZoLj3LKFk9vquJYHVhX
         PAEy052D1ioLuRuZmESOGUZ8xDElXj+HppCVGFD2bznOLY1aqRnJ2YmrW72WqGxH4PiR
         nLKzXdnkW71q3mzsfR1ENsx/i+73OBDQ2FGFEMV7Hyu7w0P2siyjgzvBhQnvV3huwJQB
         Fnrg==
X-Gm-Message-State: AOJu0Yxvhfi4PbWRO5RDxonzbdDhdITU4OoFsGP5U5v6txU7soGxLis7
	6f20E9OVFsHGhlhlDjABuC8Ejuf1mxM2V1hb3ifJW9qgVhrCFcsYogQ3HqEBIRqp+KORgDq01Ju
	9flLx/5q8b5NvYvhre1T8PSXHJWl8biXK8wWvQIjdmSDsiJ++dGhG7S8YgrtnoyaPEKwTVOYA9w
	IsBIlX9H2k7KENHBHBL+IQdLh2iVFGi/3u+utxPWP2h65TrKmBD+eYU4GijzGJbOfeqCOfMHWHn
	8tNJyRhIpYzbt8u6w==
X-Gm-Gg: ATEYQzzdw0KvievOoFQvhL00vd/t3ttuG8rZ8IFFmCKzYX4PlA4ZLdvhGxksSCO5odW
	Go4Lu+KbJKzXeQw+iSGB8qsnbrk/1Ao19n38pY5bUlYcBqEjNGxeURxxg60oUir+K/RIk12Z8qs
	Nqt+/Sf9mFftGJbxr8wujuAoKl+lDOpyjKwoPYW+syz2BPx91FlFw+HuRQzATwgFQQNOddjILtP
	UkmMt0KDKVBcAfv9B3rBcHyw/8RQBTKvZ8jVaURw6SvvVHzWGLHI5SaQxtL1zl2qU9uKwD8M8FY
	pcpHv2Af3FYd9ROhvozEI5YP37hyZuKwxktxB2vvArXvZI4SfePVFdUG7uz30gAJ9mYmAsM2bV5
	lS7De7FFEd+LoMpDW1YeLmTEtm7M1qvScOHiYRqPAncjItbuKFOaR14rf7Oa3WXfe6JMfR+70AK
	kfcOLZgAbBdVTCYnsW7YHmRN2ZWjsj9ynV4Y7pBTz9dapv3WNh1lH4LnL/XZIHYqd46g==
X-Received: by 2002:a17:902:f691:b0:2ae:aad7:5811 with SMTP id d9443c01a7336-2b0b09a69c1mr9190095ad.11.1774382932324;
        Tue, 24 Mar 2026 13:08:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b0ae4897d0sm1694975ad.52.2026.03.24.13.08.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2026 13:08:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c741b950511so2691098a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774382930; x=1774987730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekLCRy2qgCJCMkJPjj+3TMPL7gi7bF1+gj7eUMscTVs=;
        b=aOnet1Eo0oMb1kLcPYB20/RFf5GFBYwzjVKsODcJ3YyjbKZzUUsnqKConMOGpooxCU
         R4slzy3CEUYUfya58f9XE7WTIRfovp10mMgUTsvwMXSk8VENnrPlttASdzYKoQcRw3it
         G4QDgCP+d3yTlk4ZKQX7KJEThvCpdyvMeMgqQ=
X-Received: by 2002:a05:6a20:729f:b0:39b:f026:6f8d with SMTP id adf61e73a8af0-39c4ada9073mr976988637.43.1774382930619;
        Tue, 24 Mar 2026 13:08:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:729f:b0:39b:f026:6f8d with SMTP id adf61e73a8af0-39c4ada9073mr976971637.43.1774382930167;
        Tue, 24 Mar 2026 13:08:50 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a80163bsm9930057a12.1.2026.03.24.13.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:08:49 -0700 (PDT)
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
Subject: [PATCH net-next v9 08/10] bng_en: implement ndo_get_stats64
Date: Wed, 25 Mar 2026 01:37:38 +0530
Message-ID: <20260324200740.346029-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
References: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271280-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 24FA031C333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the ndo_get_stats64 callback to report aggregate network
statistics. The driver gathers these by accumulating the per-ring
counters into the provided rtnl_link_stats64 structure.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 103 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   3 +
 2 files changed, 106 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 8e59935c6826..3c624f528545 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2872,6 +2872,7 @@ static int bnge_open_core(struct bnge_net *bn)
 	}
 
 	set_bit(BNGE_STATE_OPEN, &bd->state);
+	set_bit(BNGE_STATE_STATS_ENABLE, &bn->state);
 
 	bnge_enable_int(bn);
 
@@ -2910,6 +2911,99 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
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
+	if (!test_bit(BNGE_STATE_STATS_ENABLE, &bn->state)) {
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
@@ -2921,6 +3015,14 @@ static void bnge_close_core(struct bnge_net *bn)
 	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+
+	/* Save ring stats before shutdown */
+	if (bn->bnapi)
+		bnge_get_ring_stats(bd, &bn->net_stats_prev);
+
+	clear_bit(BNGE_STATE_STATS_ENABLE, &bn->state);
+	synchronize_rcu();
+
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
@@ -2942,6 +3044,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_features_check	= bnge_features_check,
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 548c5a77e76a..c972567882bf 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -262,6 +262,7 @@ struct bnge_stats_mem {
 
 enum bnge_net_state {
 	BNGE_STATE_NAPI_DISABLED,
+	BNGE_STATE_STATS_ENABLE,
 };
 
 #define BNGE_TIMER_INTERVAL	HZ
@@ -353,6 +354,8 @@ struct bnge_net {
 
 	u64			flags;
 
+	struct rtnl_link_stats64	net_stats_prev;
+
 	struct bnge_stats_mem	port_stats;
 	struct bnge_stats_mem	rx_port_stats_ext;
 	struct bnge_stats_mem	tx_port_stats_ext;
-- 
2.47.3


