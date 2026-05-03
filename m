Return-Path: <netdev+bounces-283567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJxNGt/99mkabAIAu9opvQ
	(envelope-from <netdev+bounces-283567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:48:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E13C14B4D34
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B3443002F97
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 07:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF463A9622;
	Sun,  3 May 2026 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="WDGX+bNv"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF4358D32
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777794512; cv=pass; b=rL9JmaOEYvWDwsGuIDvuFIOACppPRqMo0TxZYLz/lpdSKiLW6/N2FF1NPBikUpBYBybEi59KMfuczjmPM/1cWfG5pKr7+TP7s7zGax88wYZhSNNSDAnO0N6oCPwTahrm7N6FKSjHLSHCV8igZPk3kc7ZYp4pN6h2pDilxjgbZ18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777794512; c=relaxed/simple;
	bh=1XRYlzOC/ZRhcJvxdudk21etwe/qkfGoyC6hQrxq/GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBXosEE+SYMf5iPO/EY/ftyyq3nFQsSKMBsv7rV2nGeYTAwCngxa3BsGJhMm9VtjQ3gIFyEe5UMN+0xNWOvqfsT25vmz39DpSulfZZD9nIpUw2blgwhEAiEEiOphO3aBOkXP4R+DyBHVvp2wuA2aI5LyrQhUH9JhtYmVXtOXfOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=WDGX+bNv; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1777794481; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cwFAVwWMPyiB8oFyW538niNt3mOiyVBCck7oLvgR0jVOUz5B4FcHp81/XdN5JGI0eXJ6mB9r23oHq8jKnuhFZVYJtZmou2UAXfizXvMX/Siej3RlO8+dJLvlBbm/lhEV8jqTltf7GwIB6oX//BjjbyLaBqDus/ZvznfkiTfpMg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777794481; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xFHQoZ6fuNGVjAvhtHH5TmCGgL7aT227IsmVOiqAfmw=; 
	b=Mae0nbe19VYQA8d4wX2Zno8Q+cHxusSt+VlfvL2LXNDehtgrnIz6f87vpBr+WKqDWinzWle5vxONIVE9TcSaTTlZIKtm4kxv96Gi/Ue97Tl7PD8Bb3ztLpE+7DAGh5LYCj64pCfQJHE0+9GH0qThkiO392z6X21LNqRjYHuGKnI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777794481;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xFHQoZ6fuNGVjAvhtHH5TmCGgL7aT227IsmVOiqAfmw=;
	b=WDGX+bNvXJMDV+0S25tJObny9urM4qGLIWmX2ubeEYnb9UBgSxGeMT1CjlN1mHRA
	QdRlmsboBjJt04GFRd6y3xRBelk9golGGjTq1MRSndY05cf2frfYyfkAtRFfmOcij+C
	mgDIWvxin6Bxo/5NNTdFZMknOM6/JTg4/o0YN8x7QkzQn8AD6+am45g3GHQ+ZV4j7u3
	Ofp0r0WHX71ZBT6lmWB5sWUynNWKnfPUOrn669+e08dvR9VBEExOWJqk0jhHoiFsnnV
	5gtqw6YASa9jdDVjia/dKMTthyY0vmU7KXCE8PpeAOpyzqEnl6obl+OHp5Q/ewIHzxM
	9+w204eL7w==
Received: by mx.zohomail.com with SMTPS id 1777794478574970.4195197562548;
	Sun, 3 May 2026 00:47:58 -0700 (PDT)
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
Subject: [PATCH v5 net-next 2/3] netdevsim: Implement basic ptp support
Date: Sun,  3 May 2026 09:47:46 +0200
Message-ID: <20260503074747.1321-3-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503074747.1321-1-maciek@machnikowski.net>
References: <20260503074747.1321-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: E13C14B4D34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-283567-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[machnikowski.net:email,machnikowski.net:dkim,machnikowski.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

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
index a05af192caf3..66493c94df94 100644
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
 static void nsim_set_rx_mode(struct net_device *dev,
 			     struct netdev_hw_addr_list *uc,
 			     struct netdev_hw_addr_list *mc)
@@ -646,6 +735,8 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_vlan_rx_add_vid	= nsim_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= nsim_vlan_rx_kill_vid,
 	.net_shaper_ops		= &nsim_shaper_ops,
+	.ndo_hwtstamp_get	= nsim_get_ts_config,
+	.ndo_hwtstamp_set	= nsim_set_ts_config,
 };
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 7e129dddbbe7..dade677448bc 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -109,6 +109,7 @@ struct netdevsim {
 	struct net_device *netdev;
 	struct nsim_dev *nsim_dev;
 	struct nsim_dev_port *nsim_dev_port;
+	struct kernel_hwtstamp_config tstamp_config;
 	struct mock_phc *phc;
 	struct nsim_rq **rq;
 
-- 
2.53.0


