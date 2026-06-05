Return-Path: <netdev+bounces-295492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id th5uA7IYImrLSQEAu9opvQ
	(envelope-from <netdev+bounces-295492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:30:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BDF6441DF
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:30:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="fvgfrF/0";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295492-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295492-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AEEA3057D68
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8BE246768;
	Fri,  5 Jun 2026 00:29:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F223AE62
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619381; cv=none; b=aenkHQAn1XqP7zqzCf9eYaie6x15RKcXptk78MnfsgIna8osRui1jbpwg5CR1EvsWMpJFgOV/j+KGAzM1guLyZIlm/pISIk8lQZgyJ9e+7g5kW3NIBAxFm82RcRFsylwjMNy9JAN3GRpcCfcVhiCG1Fd85EIRzjUovCSUSg3Nfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619381; c=relaxed/simple;
	bh=XDxbBTmRR/zPkdhPFp5rC9c9fWhDwoidxDmiLRmfFV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeF62bLlyArqY0z7LU+TAATcF7YLQJxFLhlo4e0xzY0kFIqe1KzS79m1ynJGo2k7b1I1feVfmp8C1xQjFXTj6FNX1s/x8x33lJXWz+XXP17WeZH0+iomL18KWXzglLCZYV9TAmTL1gdvYteYiZlIker1vBEDfK8g+kNzeCzspxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvgfrF/0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E837D1F00899;
	Fri,  5 Jun 2026 00:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619379;
	bh=e0uA99w5FsMO9Ap4wce3KM2SxbeOqTNB0Qd/WCOs43k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fvgfrF/0aj8T+fCPa1ZF/3NYaWHgujCLF7XKzRaEEbSMkodexgE6csfRcWxYry1AM
	 3DXlbYZHqCgoAnkQSox3g/NJD5GSUHQSzzzeHvLhoB/IAInVUtINIYqS9mJ7pbGEsm
	 AftGwRfJbZIUTHBeE9NsMfl6c0g/6NWeNBOquRcjhbWockTyVipdFfLFNU9k7NASTh
	 gxvu+WCzcd5OjsyrbzV9FlztZHYowH0yQBzB/fnM7XKAVP2E6C74eAI5PXkxMP1xDY
	 CNqV2s9S+r7/HHX1N73uKiG2D5KjAQsdRjvJUQyv1FFTET6NXCzSo1DAKM7xQ/X8r8
	 r9Y110mA0UCrg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	alexanderduyck@fb.com,
	willemb@google.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	sdf.kernel@gmail.com,
	jakub@cloudflare.com,
	nb@tipi-net.de,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 04/12] net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops
Date: Thu,  4 Jun 2026 17:29:04 -0700
Message-ID: <20260605002912.3456868-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:kuba@kernel.org,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75BDF6441DF

ethnl_default_doit() and ethnl_default_dump_one() are both used
exclusively for GET callbacks (former to get info for a single
device or get global strings). ops-locked devices don't need
rtnl_lock for GET callbacks, stop taking it.

Introduce an opt-out mechanism for devices which use phylink (fbnic)
since phylink currently depends on rtnl_lock protection. Subsequent
patches will add more exceptions, anyway. Practically the new helpers
for judging if command needs rtnl_lock could also call
netdev_need_ops_lock() but I find that it makes the code in the callers
slightly less obvious.

Add a helper for IOCTLs already, even tho it's unused so that
we can keep them in sync as the series progresses.

This is the first user-visible step of moving ethtool ops out
from under rtnl. Subsequent patches do the same for SET ops,
as well as the ioctl path.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - replace ASSERT_RTNL() with netdev_assert_locked() in gve (Stan)
   I said I will remove it but I see that there are reset paths
   which explicitly take rtnl_lock, which I suspect may be the
   reason for the assert?
---
 include/linux/ethtool.h                       | 18 +++++++-
 net/ethtool/common.h                          | 46 +++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  4 +-
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  2 +
 net/ethtool/mm.c                              |  5 +-
 net/ethtool/netlink.c                         | 19 ++++++--
 6 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f51346a6a686..1da49161d36f 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -930,6 +930,13 @@ struct kernel_ethtool_ts_info {
 	u32 rx_filters;
 };
 
+/* Bits for ethtool_ops::op_needs_rtnl
+ * LINKSETTINGS cover a number of commands, but in most cases we want to keep
+ * these bits separate, per GET and SET. GET is much easier to "unlock".
+ */
+#define ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS	BIT(0)
+#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(1)
+
 /**
  * struct ethtool_ops - optional netdev operations
  * @supported_input_xfrm: supported types of input xfrm from %RXH_XFRM_*.
@@ -956,6 +963,14 @@ struct kernel_ethtool_ts_info {
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
  * @supported_hwtstamp_qualifiers: bitfield of supported hwtstamp qualifier.
+ * @op_needs_rtnl: mask of %ETHTOOL_OP_NEEDS_RTNL_* bits.
+ *	For use with ops-locked drivers (ignored otherwise). Selects which
+ *	ethtool callbacks driver needs to still be executed under rtnl_lock
+ *	(in addition to the netdev instance lock).
+ *	The following commonly used core APIs currently require rtnl_lock
+ *	(this list may not be exhaustive):
+ *	 - phylink helpers (note that phydev is currently unsupported!)
+ *
  * @get_drvinfo: Report driver/device information. Modern drivers no
  *	longer have to implement this callback. Most fields are
  *	correctly filled in by the core using system information, or
@@ -1155,7 +1170,7 @@ struct kernel_ethtool_ts_info {
  *
  * All operations are optional (i.e. the function pointer may be set
  * to %NULL) and callers must take this into account.  Callers must
- * hold the RTNL lock.
+ * hold the RTNL lock or netdev instance lock (see @op_needs_rtnl).
  *
  * See the structures used by these operations for further documentation.
  * Note that for all operations using a structure ending with a zero-
@@ -1178,6 +1193,7 @@ struct ethtool_ops {
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
 	u32	supported_hwtstamp_qualifiers;
+	u32	op_needs_rtnl;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
 	int	(*get_regs_len)(struct net_device *);
 	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 1609cf4e53eb..391c41ca56be 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -80,6 +80,52 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 
 bool __ethtool_dev_mm_supported(struct net_device *dev);
 
+/**
+ * ethtool_nl_msg_needs_rtnl() - does this Netlink cmd need rtnl_lock?
+ * @dev: target device
+ * @cmd: ETHTOOL_MSG_* Netlink command value
+ *
+ * Return: true if @cmd is a command for which @dev has opted-in to
+ * keeping rtnl_lock held across the call (via op_needs_rtnl).
+ */
+static inline bool
+ethtool_nl_msg_needs_rtnl(const struct net_device *dev, u8 cmd)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	switch (cmd) {
+	case ETHTOOL_MSG_LINKINFO_GET:
+	case ETHTOOL_MSG_LINKMODES_GET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS;
+	case ETHTOOL_MSG_PAUSE_GET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM;
+	}
+	return false;
+}
+
+/**
+ * ethtool_ioctl_needs_rtnl() - does this legacy ioctl cmd need rtnl_lock?
+ * @dev: target device
+ * @ethcmd: ETHTOOL_* ioctl command value
+ *
+ * Return: true if @ethcmd is a command for which @dev has opted-in to
+ * keeping rtnl_lock held across the call (via op_needs_rtnl).
+ */
+static inline bool
+ethtool_ioctl_needs_rtnl(const struct net_device *dev, u32 ethcmd)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	switch (ethcmd) {
+	case ETHTOOL_GLINKSETTINGS:
+	case ETHTOOL_GSET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS;
+	case ETHTOOL_GPAUSEPARAM:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM;
+	}
+	return false;
+}
+
 #if IS_ENABLED(CONFIG_ETHTOOL_NETLINK)
 void ethtool_rss_notify(struct net_device *dev, u32 type, u32 rss_context);
 #else
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index dc2213b5ce24..7cd43e082b2a 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2015-2024 Google LLC
  */
 
-#include <linux/rtnetlink.h>
+#include <net/netdev_lock.h>
 #include "gve.h"
 #include "gve_adminq.h"
 #include "gve_dqo.h"
@@ -171,7 +171,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	int ring;
 	int i, j;
 
-	ASSERT_RTNL();
+	netdev_assert_locked(netdev);
 
 	priv = netdev_priv(netdev);
 	num_tx_queues = gve_num_tx_queues(priv);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index f14de2366854..a2c16d599389 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -2020,6 +2020,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 					  ETHTOOL_RING_USE_HDS_THRS,
 	.rxfh_max_num_contexts		= FBNIC_RPC_RSS_TBL_COUNT,
+	.op_needs_rtnl			= ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS |
+					  ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM,
 	.get_drvinfo			= fbnic_get_drvinfo,
 	.get_regs_len			= fbnic_get_regs_len,
 	.get_regs			= fbnic_get_regs,
diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
index 29bbbc149375..2d10e2a1393f 100644
--- a/net/ethtool/mm.c
+++ b/net/ethtool/mm.c
@@ -246,8 +246,9 @@ const struct ethnl_request_ops ethnl_mm_request_ops = {
 };
 
 /* Returns whether a given device supports the MAC merge layer
- * (has an eMAC and a pMAC). Must be called under rtnl_lock() and
- * ethnl_ops_begin().
+ * (has an eMAC and a pMAC). Must be called under whichever lock
+ * netdev_assert_locked_ops_compat() accepts (rtnl for traditional drivers,
+ * the netdev instance lock for ops-locked ones) and ethnl_ops_begin().
  */
 bool __ethtool_dev_mm_supported(struct net_device *dev)
 {
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index afafed738584..2c30eb1f4666 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -7,6 +7,7 @@
 #include <linux/phy_link_topology.h>
 #include <linux/pm_runtime.h>
 
+#include "common.h"
 #include "module_fw.h"
 #include "netlink.h"
 
@@ -509,6 +510,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	struct ethnl_req_info *req_info = NULL;
 	const u8 cmd = info->genlhdr->cmd;
 	const struct ethnl_request_ops *ops;
+	bool need_rtnl = false;
 	int hdr_len, reply_len;
 	struct sk_buff *rskb;
 	void *reply_payload;
@@ -535,13 +537,17 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	ethnl_init_reply_data(reply_data, ops, req_info->dev);
 
 	if (req_info->dev) {
-		rtnl_lock();
+		need_rtnl = !netdev_need_ops_lock(req_info->dev) ||
+			    ethtool_nl_msg_needs_rtnl(req_info->dev, cmd);
+		if (need_rtnl)
+			rtnl_lock();
 		netdev_lock_ops(req_info->dev);
 	}
 	ret = ops->prepare_data(req_info, reply_data, info);
 	if (req_info->dev) {
 		netdev_unlock_ops(req_info->dev);
-		rtnl_unlock();
+		if (need_rtnl)
+			rtnl_unlock();
 	}
 	if (ret < 0)
 		goto err_dev;
@@ -589,6 +595,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 				  const struct ethnl_dump_ctx *ctx,
 				  const struct genl_info *info)
 {
+	bool need_rtnl;
 	void *ehdr;
 	int ret;
 
@@ -599,11 +606,15 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 		return -EMSGSIZE;
 
 	ethnl_init_reply_data(ctx->reply_data, ctx->ops, dev);
-	rtnl_lock();
+	need_rtnl = !netdev_need_ops_lock(dev) ||
+		    ethtool_nl_msg_needs_rtnl(dev, ctx->ops->request_cmd);
+	if (need_rtnl)
+		rtnl_lock();
 	netdev_lock_ops(dev);
 	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
 	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	if (need_rtnl)
+		rtnl_unlock();
 	if (ret < 0)
 		goto out_cancel;
 	ret = ethnl_fill_reply_header(skb, dev, ctx->ops->hdr_attr);
-- 
2.54.0


