Return-Path: <netdev+bounces-260020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF5PFb1JnGmODAQAu9opvQ
	(envelope-from <netdev+bounces-260020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:36:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE031176290
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0806430672D9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08C93659EA;
	Mon, 23 Feb 2026 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="iAnLI1tu"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5185F343D8F
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850125; cv=pass; b=GVjSp1ZYv74B/TpbwSxmSSNVrwAjQD2ogQtY/Beb+Vwfww7/eBJ2ljEokh58m4ui0hyxaIQQ5r2eEmktbQMdlVKAOMQdSrrc1FjMzUdMViBaU61lZYzwsQ864wuDAFhHQWXUMSceo1J5gLYekoYyrVS304/0DYclwkre7fEXC0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850125; c=relaxed/simple;
	bh=WQMxaW28f7S5K9XYy7Nbqya318k3SQQ+iW2OM3Yd8sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOg5QPHk0gHMeUmCWRvLXwZd5DGaUoNVeXYXsz/GTbJTbGtItokt3WPVmNyfRwqv0Fj4Or7qXjST5IqSxbHQ8gtrIlkNSF1YfUm8ZaSEjYo0n31VjtpENDhC1urpDKEfz6P5EYBMaQbbFGjL2gERWrtWhhEM6VpYJyQ2v+Agfkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=iAnLI1tu; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1771850081; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ACoE8Xa9BHOJ15sm0B74D9RKQVZD2MwsTfkrjYGLDT5wUGAtJG+Q/Ey2/+I4YhP2y1qMMGRT6cNp8VhBlLwe/Pm8/wx9i5n888Y+b8LFjfrZLyB6w3GlDlNIoOA5IUPCbD4sJSOxsYjOppEe6mKxMJJkhfjAZrjx7UpklJiXVZ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771850081; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NtHcM4ZG2IGZqO43QDB373uo/vl2oPkFP/V8OBm+9Vo=; 
	b=Rwe5bRpBkJVaYBORh5Ar/PD1vb6QMtp9UYhmWgi4owdN2ZMNALmJ8ENcQHtitodjB9WPgLqKEdXfwDQbwFTeQynjuiFb0uu8Vuhm7z0sc5hjIX3RWCj2oYDMLl2UrwHCSNJeWHfw/GfFRKnEOxI4t8GIirvK0FrSkDF8AhFkK1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771850081;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NtHcM4ZG2IGZqO43QDB373uo/vl2oPkFP/V8OBm+9Vo=;
	b=iAnLI1tuCzwHTr6ziySVfLsaM1ZpDH0luCf72HOYPe7rkt4Kfj75ncJEmMU4LWPd
	PtXlgUzcuKv/N1DW5oUsRN9M6lYz6oYxk6yhm+8Xz6DxON2A4eXB8X8ktNUDDvOVCCr
	ZOdaw7fdNjptD2AqQhoGaPx1ExbtnkfJPxBYKyTYJ7buVvpmvsrE+8MtiHhV770dQBw
	7wchy7qbMASxBudkZseDheKzEH76u6kgidylVMiWTm0Gy7frocTqR+q2uzuviu9bhYK
	lT4OJJFlnOjMJC33yXIjpmq+wyzSooXHorhQSn/pznQEU8gnwhzXKNOudvNbqon66SR
	LBO5lpiDHA==
Received: by mx.zohomail.com with SMTPS id 1771850079544406.04068507624334;
	Mon, 23 Feb 2026 04:34:39 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev
Subject: [PATCH v2 net-next 2/3] netdevsim: Implement basic ptp support
Date: Sun, 22 Feb 2026 10:41:09 +0100
Message-ID: <20260222094110.127927-3-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222094110.127927-1-maciek@machnikowski.net>
References: <20260222094110.127927-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[26];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	TAGGED_FROM(0.00)[bounces-260020-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[machnikowski.net];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,machnikowski.net:mid,machnikowski.net:dkim,machnikowski.net:email,cursor.com:email]
X-Rspamd-Queue-Id: AE031176290
X-Rspamd-Action: no action

Add support for virtual timestamping inside the netdevsim driver.
The implementation uses two attached ptp_mock clocks, reads the timestamps
of the ones attached either to the netdevsim or its peer and returns
timestamps using standard timestamps APIs.

This implementation enables running ptp4l on netdevsim adapters and
introduces a new ptp selftest.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/net/netdevsim/ethtool.c   | 11 ++++
 drivers/net/netdevsim/netdev.c    | 90 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 3 files changed, 102 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 36a201533..5b709033c 100644
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
index 6285fbefe..b1161c1ca 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -30,6 +30,8 @@
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
 #include <net/busy_poll.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
 
 #include "netdevsim.h"
 
@@ -119,12 +121,17 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 
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
 	struct netdevsim *peer_ns;
 	struct netdev_config *cfg;
+	bool gen_tx_tstamp = false;
 	struct nsim_rq *rq;
 	int rxq;
 	int dr;
@@ -161,6 +168,27 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_linearize(skb);
 
 	skb_tx_timestamp(skb);
+	gen_tx_tstamp = skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP;
+	if (gen_tx_tstamp) {
+		ptp_info = mock_phc_get_ptp_info(ns->phc);
+
+		/* Create a copy of tx skb to keep the tx reference */
+		skb_orig = skb;
+		skb = skb_copy(skb_orig, GFP_ATOMIC);
+		skb_shinfo(skb_orig)->tx_flags |= SKBTX_IN_PROGRESS;
+
+		/* Timestamp as late as possible */
+		if (ptp_info)
+			ptp_info->gettime64(ptp_info, &tx_ts);
+	}
+
+	/* Generate Rx tstamp based on the peer clock */
+	ptp_info = mock_phc_get_ptp_info(peer_ns->phc);
+	if (ptp_info) {
+		ptp_info->gettime64(ptp_info, &rx_ts);
+		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);
+	}
+
 	if (unlikely(nsim_forward_skb(dev, peer_dev,
 				      skb, rq, psp_ext) == NET_RX_DROP))
 		goto out_drop_cnt;
@@ -168,6 +196,13 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (!hrtimer_active(&rq->napi_timer))
 		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
 
+	/* only timestamp the outbound packet if user requested it */
+	if (gen_tx_tstamp) {
+		shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
+		skb_tstamp_tx(skb_orig, &shhwtstamps);
+		dev_kfree_skb_any(skb_orig);
+	}
+
 	rcu_read_unlock();
 	dev_dstats_tx_add(dev, len);
 	return NETDEV_TX_OK;
@@ -182,6 +217,59 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -660,6 +748,8 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_open		= nsim_open,
 	.ndo_stop		= nsim_stop,
 	.net_shaper_ops		= &nsim_shaper_ops,
+	.ndo_hwtstamp_get	= nsim_get_ts_config,
+	.ndo_hwtstamp_set	= nsim_set_ts_config,
 };
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7..6d3e8700c 100644
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


