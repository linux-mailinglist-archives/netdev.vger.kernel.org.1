Return-Path: <netdev+bounces-281412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLWBFGqT72ktDAEAu9opvQ
	(envelope-from <netdev+bounces-281412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8D476A6A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF1E530143CB
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DF23D6CDC;
	Mon, 27 Apr 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="ptfu44op"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DFC2EAD15
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308518; cv=pass; b=fL8yRxr4TeykXs+vmGOJqmmNzE2HawSyeFgh4zHTrSosvAaf+eR2sdOztZpIaUv4pgWrb+299lhcjnxU1ayS25qBqnVRdAUCG/bunHKA9NZhHJLrdPlYIEQr86FvjJh2jjVJCCFuRO9uxSqPJ2DMDgEgSfYV+HYYki3ueoAjE0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308518; c=relaxed/simple;
	bh=kTdf0cHqZqib53Q6lvudjIWhrsKIyXmElBkjKUM6zz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4QQ8cOftVTxsd+nQONed8/rOJQzQjz0xuOS/wiwGcSnN7GpPXs85N5tsP7btasnBlu70KIYbXpF394mik0AcE/XF803ImHIJG/dL1flf3EhbGBTuZFMNKdh71PjRxR06NpVzahDz5c6dqbK/Ib8RDb2RUPDOn9CABxCDXigfDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=ptfu44op; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1777308458; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jKMyrmFpQuzu35hhxWy4SilJORZkiRwVZnaPUYZIjUrDjAXVC0gtvYVc6zOVcl0C3UzMXxZbc3LrxbXDJoZ1uXfMRw15yuzbWiSz2DWRTJYwnOiobsC9KTyxiJJUPO6ZpZNlZ+tISGTHPGPEJV63Hr6FNRDXdh+rF/Ea5ARfco4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777308458; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4QdzGTGUHaemO8kZ8Ev3lPxpIU8PKMGf0wTH534f1vI=; 
	b=C/w99jCtWhk5qJhDAYjF/vdUddtl/Nc/ZfY/E7lT3v74B5kIlpZFedkQWDYxWGOpuwc2a96BSR6cKhdbp/HTdWzV9Tr7IENscRFM8O4IIlEQ4uhFCrmIQheIiZz964XQz/CyN/l0//NOta3L5QSytl9kPexUxWg5d05NHwhDNj8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777308458;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4QdzGTGUHaemO8kZ8Ev3lPxpIU8PKMGf0wTH534f1vI=;
	b=ptfu44opukKZTl5o3P9s9h5PEK1xrZuFfjh29FRKHiAM41bH3YhTRfSIlLdjVn1P
	t+v1l3UqCaO7Zn7MK3Rr/42yuHZZWpnAMbwKTBYvYCtdR5KkO3gG9L+RANUtyb3TyL5
	yuZdNeURZQrme81+6C1drGpi+nsvMaF5gJs1qKcKJCqXRz4jJwUkUXKidladI0nKv8G
	pLrVr652mK6A5Lr/5cnsmv91ILNPrQeZCk6Q4X1z2tKJavjaobx1jKcFOmR7vMelJGl
	3up6oJiBHKWRrkuWJ8sX9RLA3QC9X/FAkliiot/yv5iH/aYo7HhrjNeUK9OOiqbgiKz
	+Dh+rEzsyQ==
Received: by mx.zohomail.com with SMTPS id 1777308455387120.7335898632831;
	Mon, 27 Apr 2026 09:47:35 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v4 net-next 2/3] netdevsim: Implement basic ptp support
Date: Mon, 27 Apr 2026 18:47:26 +0200
Message-ID: <20260427164727.15418-3-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427164727.15418-1-maciek@machnikowski.net>
References: <20260427164727.15418-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: CBF8D476A6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-281412-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,machnikowski.net:email,machnikowski.net:dkim,machnikowski.net:mid]

Add support for virtual timestamping inside the netdevsim driver.
The implementation uses two attached ptp_mock clocks, reads the timestamps
of the ones attached either to the netdevsim or its peer and returns
timestamps using standard timestamps APIs.

This implementation enables running ptp4l on netdevsim adapters and
introduces a new ptp selftest.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/net/netdevsim/ethtool.c   | 11 ++++
 drivers/net/netdevsim/netdev.c    | 91 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 3 files changed, 103 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 36a201533aae..5b709033cc5f 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -200,7 +200,18 @@ static int nsim_get_ts_info(struct net_device *dev,
 {
 	struct netdevsim *ns = netdev_priv(dev);
 
+	ethtool_op_get_ts_info(dev, info);
+
 	info->phc_index = mock_phc_index(ns->phc);
+	if (info->phc_index < 0)
+		return 0;
+
+	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
+				 SOF_TIMESTAMPING_RX_HARDWARE |
+				 SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
 
 	return 0;
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index c71b8d116f18..af1783c88753 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -30,6 +30,8 @@
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
 #include <net/busy_poll.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
 
 #include "netdevsim.h"
 
@@ -122,7 +124,11 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct skb_shared_hwtstamps shhwtstamps = {};
 	struct netdevsim *ns = netdev_priv(dev);
+	struct ptp_clock_info *ptp_info;
+	struct timespec64 tx_ts, rx_ts;
+	struct sk_buff *skb_orig = skb;
 	struct skb_ext *psp_ext = NULL;
 	struct net_device *peer_dev;
 	unsigned int len = skb->len;
@@ -164,6 +170,36 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_linearize(skb);
 
 	skb_tx_timestamp(skb);
+
+	/* Generate RX timestamp using the peer's PHC if RX timestamping is enabled */
+	if (peer_ns->tstamp_config.rx_filter != HWTSTAMP_FILTER_NONE) {
+		ptp_info = mock_phc_get_ptp_info(peer_ns->phc);
+		ptp_info->gettime64(ptp_info, &rx_ts);
+	}
+
+	/* If TX hardware timestamping is enabled, generate and attach a TX timestamp */
+	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
+	    peer_ns->tstamp_config.tx_type == HWTSTAMP_TX_ON) {
+		ptp_info = mock_phc_get_ptp_info(ns->phc);
+		ptp_info->gettime64(ptp_info, &tx_ts);
+
+		/* Create a copy of the SKB to forward to peer and prevent
+		 * from reporting incorrect TX timestamp when skb_hwtstamps is set.
+		 */
+		skb = skb_copy(skb_orig, GFP_ATOMIC);
+		if (skb) {
+			shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
+			skb_tstamp_tx(skb_orig, &shhwtstamps);
+			consume_skb(skb_orig);
+		} else {
+			skb = skb_orig;
+		}
+	}
+
+	/* set the rx timestamp to the skb */
+	if (peer_ns->tstamp_config.rx_filter != HWTSTAMP_FILTER_NONE)
+		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);
+
 	if (unlikely(nsim_forward_skb(dev, peer_dev,
 				      skb, rq, psp_ext) == NET_RX_DROP))
 		goto out_drop_cnt;
@@ -185,6 +221,59 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static int nsim_set_ts_config(struct net_device *netdev,
+			      struct kernel_hwtstamp_config *config,
+			      struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = netdev_priv(netdev);
+
+	if (!ns->phc)
+		return -EOPNOTSUPP;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+		ns->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+		break;
+	case HWTSTAMP_TX_ON:
+		ns->tstamp_config.tx_type = HWTSTAMP_TX_ON;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_NTP_ALL:
+	case HWTSTAMP_FILTER_ALL:
+		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+static int nsim_get_ts_config(struct net_device *netdev,
+			      struct kernel_hwtstamp_config *config)
+{
+	struct netdevsim *ns = netdev_priv(netdev);
+
+	*config = ns->tstamp_config;
+	return 0;
+}
+
 static void nsim_set_rx_mode(struct net_device *dev)
 {
 }
@@ -612,6 +701,8 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_open		= nsim_open,
 	.ndo_stop		= nsim_stop,
 	.net_shaper_ops		= &nsim_shaper_ops,
+	.ndo_hwtstamp_get	= nsim_get_ts_config,
+	.ndo_hwtstamp_set	= nsim_set_ts_config,
 };
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index c7de53706ec4..873a81ed6dcd 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -103,6 +103,7 @@ struct netdevsim {
 	struct net_device *netdev;
 	struct nsim_dev *nsim_dev;
 	struct nsim_dev_port *nsim_dev_port;
+	struct kernel_hwtstamp_config tstamp_config;
 	struct mock_phc *phc;
 	struct nsim_rq **rq;
 
-- 
2.53.0


