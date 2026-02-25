Return-Path: <netdev+bounces-261018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOdfO9Qen2lcZAQAu9opvQ
	(envelope-from <netdev+bounces-261018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:09:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0635019A470
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A35513104B32
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945F3D648F;
	Wed, 25 Feb 2026 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="KcHrrffZ"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E43D332F
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033985; cv=pass; b=FgUb5LRGHPiw+IZBRYCSdin/p6FDxUvRYoYp80QJjCDTUJc5uUG0twK2xUaVHWpybunkfPeBt9592q8tAOTRLAsHRXmLBv9+9zBUTW7E/VFpaoeJNYIxkIvB6mb8j8MCL1hzFSme7aE9F+bPzz6F3LwXho6J4mxaa+ZAGZzxy6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033985; c=relaxed/simple;
	bh=BJi7TrwCj3OXWvKYN/LBe169SaGJY1+X4ImqgmY5Yng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vf0ST6nMYpljc35esXyrj4zO/8B0zFj8uRRPmCbrftmxDs7KwG7g1DOuhL2hISrUaVxdduPimfOF7Ysmo/GySp7xg0u95oelljwqmhMr2OW4T02gV9EDnCMZLWLdPOevRPo7IE/xZW8sWoG5XvdrB0XBila8VCXR3SYZ7pmUgDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=KcHrrffZ; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1772033949; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cwuy4TocC/xtSzz1K8G5P/ulVWrbGj/NqthCaSGEvIqu1D+zMHjzN+HqmL9nX267gUrev1ScQR06eEIr8ZhMLatbyW2XJmJ+wwcX/3MSYvpx5w2jIippKGLZzKDnoVElLo7TCSm9rtMgLp83xLGL2U2joCdn/BrMrEaeacw68cU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772033949; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EJBRXoAlv2493l08EnaBFfDXTJB8/3CYAjL1MCv+vno=; 
	b=QQtUEG430jZ3StN/gL/EfSyCzEmtatSD9uR3mLj4c2vcoHSTyOtIrAYZHt2S1fxg2+T+6egc0+d8WEDJFYAcO0VY/0QQzNTldPo3EtVTnQs09k5VxZOCDanEOPuIfEPEqz6B/L584uINc9kv86c8eT9bPStKHF+PkQOroCe45/w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772033949;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EJBRXoAlv2493l08EnaBFfDXTJB8/3CYAjL1MCv+vno=;
	b=KcHrrffZvOh4nbFIrYA7LEt2NESBoHEpNY6cGcY8do/NMCXoClEGtldgmop0lwcD
	waYsyTxlIRv0CQGmi8OF9HVFBpIg7XFftMRL+tvxiPPRiJUOhaxiwsxxDtxN0u2j3ob
	r7OxDosrPAQxOI6r3pI+arwnEBmeHXigU6DLj74hRsZNm3uqSUWEvsSr6cwM4XVjuA+
	UWDsNauIyk36WFSXAfjAHVXZuZTE8qcCq3J9XEaCCT6h/GaKwj3QXUJ+JZUnHL5mUEJ
	ib6oJWUR70N0h2ErHaioGlvICS6a8H/X5jtwFJL74Asn3zL1Zac7vtGUzMZssKCL4BA
	VzRV/crNHQ==
Received: by mx.zohomail.com with SMTPS id 1772033948339708.5928858208522;
	Wed, 25 Feb 2026 07:39:08 -0800 (PST)
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
Subject: [PATCH v3 net-next 2/3] netdevsim: Implement basic ptp support
Date: Wed, 25 Feb 2026 16:38:57 +0100
Message-ID: <20260225153858.29486-3-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225153858.29486-1-maciek@machnikowski.net>
References: <20260225153858.29486-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-261018-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[machnikowski.net:mid,machnikowski.net:dkim,machnikowski.net:email,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0635019A470
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


