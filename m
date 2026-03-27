Return-Path: <netdev+bounces-272677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IkyIHXoxmloQAUAu9opvQ
	(envelope-from <netdev+bounces-272677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:28:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A44234AF3F
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CBEE30BA7B1
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C4539E185;
	Fri, 27 Mar 2026 20:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QyoZZODq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E44396597
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642526; cv=none; b=lBS8fMMYI91j98Cryw0QPXL197b/bn1FWO29au+BgSEkgUf88sVKutooyZMEwaJi2B9uWTK9eDLGn+GxI/FOjlikUyWwzHHb3pESVoHfRqhwoqYOQc3aHagmknR5kkTYRP8JuqLWy5eySTbz/yPkwvF2J+z81Kfkulb7p/0Hf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642526; c=relaxed/simple;
	bh=RzaqFNKdVRTX/6fbKxbgoh8rdmg6EYIZDsbIZdlQBIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnnkB9g3ZwblJvXxEWx66SFqzt0noK/t4dsAbvnQi8eM659ldtqhiWg4I1NjL7BRZVXKGcyLDx8oe/CS9TC7FYxlcUcjKQKbHhctLF1tSeUdHUFtdGkwfkFlz9cnZEiNN8KzGpU+nrCyryEJza5owwSmyxFNG7JdAG4x/W4hndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QyoZZODq; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1124547a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642524; x=1775247324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcrU2S3pwS1dF0Y8GuCFOSv27TX89aMT8zCjbmcIpD8=;
        b=PvpBKiQnH2ksE4GBzMpvaS6MXyZItAliwY6+TJoe0S1wdkv7hS/Tg5mEKtCLjFfyJe
         ur1qJjvNzqlQv3qdN4ddQvCmuwH5/hBy8Dyyrrdb/OwZE5kfUK31J94qe+lQ7HcmfYEg
         tQuPXwqFKP8YTlF9jRuSDI1h9HOPR2KNNFxa+obWtGZfOlyKko1zj66yTdMc1tY8UGdG
         EnlM/hwIsAukVRkmGcWNsTFmPa3DiXYYfSZIeZiHV4/cRAtfxXGIr6KPt12bSZoGnUaz
         sp8Zw0VG2ypmSZJXvqrNZZUNGKE8ve4RuDAOOQOwzvlFNbCu1bjg4ACr4ZEcdupWEyvI
         C2vQ==
X-Gm-Message-State: AOJu0Yy61w2RPwpA3CC/1S7T/2PzVuB9LaMW5jligucDTkh6ncV9z7NN
	NImL9n79paNRyhJuPH+k3p8FEM4ZlT8Py7Is+Q8w7HfWnEmSDXWwrCOZ+53vdXLjgwY+AjzUAcM
	HutoHdFviU9zHaZoaiqoBL7Wxl7NWt+IE41Of+qtXF9rFksNE0FmQ0jrPnRJJJ85ODJp5wQMW1E
	Nv2dT/lL+9vTdycFhBQwa8tnJJvb1Hl9Qo6fT3lAjgdmwAv5kwrWVsQSDtU4sAh8ewgxhoakCrK
	06jqnkwZLDhol60DCoB
X-Gm-Gg: ATEYQzx0+6d0oKSC50RdrfMCLuC5KfgJzMwh0q6vvJGMshuX9OzPRJUjtNrQu8GxnkE
	iVxR7h0DmFZjYQ5avChPXfIvb3zikgLyIHZF6jiEq5P6Ncqd9SM3Y0aNd3u1A78JZZ5Gav3jgiM
	9iHVH0DA4TH0H22Uhfu5SvB6efwSirVfNAwJLeCqg3w7ta+HzFYoOweeSxYlOn8sTJrQ+rD3SRj
	AfFnlUMZwKbydBBKARgMtUhw0GU07pP8lsDN2/Lh+yEnb4Y2jmLBLzXvV6AcNFvJLywH2HgbaIQ
	8Fntp1UiMJMCNq5eNkcHTNim8hsXa9ym9Fu+f6kKD5K1QKuDjU7Zimynsl9Yfres0oLF/JdIGfI
	aaZ1FGv9ePAQTlGBjFMIgf/oYD6FIHKfV1n9uNw52/FNQbMx3xhGDyTpbBiX98i0S9qejIVMfWS
	pdR+M9tSZOWlw=
X-Received: by 2002:a17:902:c946:b0:2ae:c8b4:6d9e with SMTP id d9443c01a7336-2b0cdc1b6dfmr41069655ad.13.1774642523964;
        Fri, 27 Mar 2026 13:15:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b242729a0esm249135ad.32.2026.03.27.13.15.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:15:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79a51ba2bf9so53678837b3.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774642523; x=1775247323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcrU2S3pwS1dF0Y8GuCFOSv27TX89aMT8zCjbmcIpD8=;
        b=QyoZZODqZ1+se4BI/1+5vRzmq6xX6qO8t+Wvzgdyx7NxptBDRv0sCnfDqgZB3dsDQH
         XPzdIWdzs4cXLSCuLS2e46KAvLiSs06hJpbBOzG9AQ2V1AGMg0CC07xXMOpxLIPZtZTj
         /LyozzkdxoJaknVW7lxiAhnrZuPBAajdr8Mos=
X-Received: by 2002:a05:690c:c50f:b0:798:2629:85d7 with SMTP id 00721157ae682-79bddd7743emr36729097b3.9.1774642522627;
        Fri, 27 Mar 2026 13:15:22 -0700 (PDT)
X-Received: by 2002:a05:690c:c50f:b0:798:2629:85d7 with SMTP id 00721157ae682-79bddd7743emr36728627b3.9.1774642521952;
        Fri, 27 Mar 2026 13:15:21 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f324sm119057b3.28.2026.03.27.13.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:15:21 -0700 (PDT)
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
Subject: [PATCH net-next v10 08/10] bng_en: implement ndo_get_stats64
Date: Sat, 28 Mar 2026 01:43:41 +0530
Message-ID: <20260327201343.16146-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
References: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
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
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272677-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A44234AF3F
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
index 3b9bcfbe6fdc..b5cc96d1ee0e 100644
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
+		u64 *tx = bn->port_stats.sw_stats +
+			  BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		u64 *rx = bn->port_stats.sw_stats;
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
@@ -2943,6 +3045,7 @@ static const struct net_device_ops bnge_netdev_ops = {
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


