Return-Path: <netdev+bounces-295491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OtsfC4IYImrFSQEAu9opvQ
	(envelope-from <netdev+bounces-295491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:29:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1906441C7
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:29:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lva3WDt3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295491-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295491-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78C2E302E905
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76024113D;
	Fri,  5 Jun 2026 00:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57F22D7A9
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619380; cv=none; b=YhoNtMHKkXLS2jLb595+FuxhgfRmFoXGnmnxPRnPcLZR2ge+lun6GFf8n0ejVqsFW+mpyC3adioypr1MO2p7PbRGv5gxnHfd6kazCBaB5M8PE3Df7Em6F5cpV8vx6+2+P2bXYPawqv9U89ICzSOicAq8ewh7+MsRqET4QEvGES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619380; c=relaxed/simple;
	bh=Of/pg5O4719c1MJ3wlehh4RYPokYxrqkQKfkw0qioOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlVwCyVRBQcaiFEsDZV/T9otoIVHYe0XLdvAChOA7PZDXy0YwJ2Qx4oEiKsHzz4D4TwipXT++2CxXIKwBXwTUsgYk5kQolxYst4cVYHPju0/nVXp4sXrrVEOr6ZaZvUNdxZp+uFxakSWanuycKbSF/E06Ni12Ymj5mNhKOjMWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lva3WDt3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED231F00898;
	Fri,  5 Jun 2026 00:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619378;
	bh=6YMFRBDeEz7BFsWSVFp8xKrafpIXHILLW4SAdJetNac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lva3WDt3TD2eEifzG7dYT+Uomor2TzxjT5cPeX3GjTTHjmCuirAgbk5eTk+uGOIWQ
	 ndXVdd1aE4r+Fax3E6Nl0wPfdywUyy0o78wbrC0lvg6xG6fChUcIzP/SKp/+H+k3sD
	 k0Xz/CQafi76v3yniAzM5UPnJ620GYe5o3636MJjd97c3FeF0bei/BGUk74RMq7yUs
	 ceN/vJshGFSHgW1iXR7Rt+j1dO9dwXsfqTVzT/v1aeK0ILh9TyVNcxWnWBN8mzQWcF
	 s2sVV5WiHb7l77wgSsL74OQcNxh4Mob4Kmx4qolZeJhHsftxzKwq1mBzRshX7f9h9H
	 5Xoxp+lNGNAew==
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
Subject: [PATCH net-next v2 03/12] net: ethtool: make dev->hwprov ops-protected
Date: Thu,  4 Jun 2026 17:29:03 -0700
Message-ID: <20260605002912.3456868-4-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295491-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:kuba@kernel.org,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD1906441C7

dev->hwprov tracks the active hwtstamp provider for the device.
Make it ops protected (instance lock if the netdev driver opts
into holding instance lock around callbacks, otherwise rtnl_lock).

hwprov is written and read in:
 - drivers/net/phy/phy_device.c
    phydev and ops protection don't currently mix, add a comment
 - net/ethtool/
    as of now holds both rtnl lock and ops lock, this one will
    soon only hold one lock or the other

read in:
 - net/core/dev_ioctl.c
    holds both rtnl lock and ops lock
 - net/core/timestamping.c
    RCU reader

The new netdev_ops_lock_dereference() helper does not have
"compat" in the name. The name would be quite long and I think
in this case it should be obvious that we need _a_ lock.
netdev_lock_dereference() already exists and means dev->lock
is always expected.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h           |  3 +++
 include/net/netdev_lock.h           | 11 +++++++++++
 drivers/net/phy/phy_device.c        |  3 +++
 drivers/net/phy/phy_link_topology.c |  4 +++-
 net/core/dev_ioctl.c                |  4 ++--
 net/ethtool/tsconfig.c              | 10 ++++++----
 6 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 74507c006490..a8709d0cc8d4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2583,6 +2583,9 @@ struct net_device {
 	 * Double protects:
 	 *	@up, @moving_ns, @nd_net, @xdp_features
 	 *
+	 * Ops protects:
+	 *	@hwprov
+	 *
 	 * Double ops protects:
 	 *	@real_num_rx_queues, @real_num_tx_queues
 	 *
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index d3daec4e93f3..9fb3e93857c3 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -102,6 +102,14 @@ static inline void netdev_unlock_ops_compat(struct net_device *dev)
 		rtnl_unlock();
 }
 
+/* Matching "ops protected" category from netdevice.h */
+static inline int netdev_is_locked_ops_compat(const struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		return lockdep_is_held(&dev->lock);
+	return lockdep_rtnl_is_held();
+}
+
 static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				     const struct lockdep_map *b)
 {
@@ -138,6 +146,9 @@ static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 #define netdev_lock_dereference(p, dev)				\
 	rcu_dereference_protected(p, lockdep_is_held(&(dev)->lock))
 
+#define netdev_ops_lock_dereference(p, dev)				\
+	rcu_dereference_protected(p, netdev_is_locked_ops_compat(dev))
+
 int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 		       void *ptr);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3370eb822017..ea53e477465d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1935,6 +1935,9 @@ void phy_detach(struct phy_device *phydev)
 	if (dev) {
 		struct hwtstamp_provider *hwprov;
 
+		/* hwprov may technically be protected by ops lock but
+		 * not for devices with a phydev, see phy_link_topo_add_phy()
+		 */
 		hwprov = rtnl_dereference(dev->hwprov);
 		/* Disable timestamp if it is the one selected */
 		if (hwprov && hwprov->phydev == phydev) {
diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index aed3b26c1674..4134de7ae313 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -38,7 +38,9 @@ int phy_link_topo_add_phy(struct net_device *dev,
 
 	/* ethtool ops may run without rtnl_lock, and rtnl_lock is what
 	 * currently protects the PHY topology. No driver currently mixes
-	 * the two, flag if someone tries. See also ethnl_req_get_phydev().
+	 * the two, flag if someone tries. See also:
+	 *  - ethnl_req_get_phydev()
+	 *  - phy_detach()
 	 */
 	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
 		return -EOPNOTSUPP;
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index f3979b276090..a320e264eaaf 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -260,7 +260,7 @@ int dev_get_hwtstamp_phylib(struct net_device *dev,
 {
 	struct hwtstamp_provider *hwprov;
 
-	hwprov = rtnl_dereference(dev->hwprov);
+	hwprov = netdev_ops_lock_dereference(dev->hwprov, dev);
 	if (hwprov) {
 		cfg->qualifier = hwprov->desc.qualifier;
 		if (hwprov->source == HWTSTAMP_SOURCE_PHYLIB &&
@@ -337,7 +337,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 	bool phy_ts;
 	int err;
 
-	hwprov = rtnl_dereference(dev->hwprov);
+	hwprov = netdev_ops_lock_dereference(dev->hwprov, dev);
 	if (hwprov) {
 		if (hwprov->source == HWTSTAMP_SOURCE_PHYLIB &&
 		    hwprov->phydev) {
diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 664c3fe49b5b..24b64862011f 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -2,6 +2,7 @@
 
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
+#include <net/netdev_lock.h>
 
 #include "bitset.h"
 #include "common.h"
@@ -57,7 +58,7 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 	data->hwtst_config.flags = cfg.flags;
 
 	data->hwprov_desc.index = -1;
-	hwprov = rtnl_dereference(dev->hwprov);
+	hwprov = netdev_ops_lock_dereference(dev->hwprov, dev);
 	if (hwprov) {
 		data->hwprov_desc.index = hwprov->desc.index;
 		data->hwprov_desc.qualifier = hwprov->desc.qualifier;
@@ -213,7 +214,7 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
 		return -ENOMEM;
 	}
 
-	ASSERT_RTNL();
+	netdev_assert_locked_ops_compat(dev);
 	reply_data->base.dev = dev;
 	ret = tsconfig_prepare_data(&req_info->base, &reply_data->base, info);
 	if (ret < 0)
@@ -316,7 +317,7 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 		struct hwtstamp_provider_desc __hwprov_desc = {.index = -1};
 		struct hwtstamp_provider *__hwprov;
 
-		__hwprov = rtnl_dereference(dev->hwprov);
+		__hwprov = netdev_ops_lock_dereference(dev->hwprov, dev);
 		if (__hwprov) {
 			__hwprov_desc.index = __hwprov->desc.index;
 			__hwprov_desc.qualifier = __hwprov->desc.qualifier;
@@ -414,7 +415,8 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 			goto err_free_hwprov;
 
 		/* Change the selected hwtstamp source */
-		__hwprov = rcu_replace_pointer_rtnl(dev->hwprov, hwprov);
+		__hwprov = rcu_replace_pointer(dev->hwprov, hwprov,
+					       netdev_is_locked_ops_compat(dev));
 		if (__hwprov)
 			kfree_rcu(__hwprov, rcu_head);
 	}
-- 
2.54.0


