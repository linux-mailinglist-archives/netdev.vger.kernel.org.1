Return-Path: <netdev+bounces-295490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id roUsCJEYImrJSQEAu9opvQ
	(envelope-from <netdev+bounces-295490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:30:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EF06441D5
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:30:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZVg8+xji;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295490-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295490-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7534E3048F19
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113D122F388;
	Fri,  5 Jun 2026 00:29:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73321D590
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619379; cv=none; b=VGDd8Lhw7bHAsuT8KrAjY80BKyMPIpKJ4eX0pKzg+17dbnvZqO+zJ2hT/BBnvAd1fbn42WnC8J4eTn/4ZKPKn1GBeYM3ZzWBzMq08pF8M2azFfjaCDNUwNzTpwg8tBCE/RPnvfLmHyJd/3a2vNGtYFFxtMkeIwmdsMdxj4VN7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619379; c=relaxed/simple;
	bh=LhOipWLyIL16aAHnZKXYQf0FHpVI9M1sJpQUrZ2D4zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaYTkGEn1CFOfWcRTk+Hw9/DdwsGojzXYx5b+IHWvw9pOEGdffRQb44emusIxJxeXjYQmrK5lYko8HqQMnn8TvXIjkuv3WR0P3gOnYMShHm3iEvIO9Dnf4pZWYxx6i18a04FG7fJ17qrx5zTxPWX/s33UXU95VI2dQA/OjNO4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVg8+xji; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098871F0089F;
	Fri,  5 Jun 2026 00:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619377;
	bh=K+kvyxmoyQvXACCh5Um7BBQUeSgk4xO8YEaQOZYZgqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZVg8+xjiDlCb5gibMLKjEp55wq1AbSUnEVmjr27gQHuBkhw66i3S1qfAqVb8MsLvl
	 njMxjAPP6UTeWI+d2inEQpNyMNW8tZK+7xmoNv6pUrhuBvGH+wEIuo3MesqId3/C+E
	 WZ8a7zn0TNym43zsC0k2E3KgT0WpGFDGFEPc7c/nD++RqIM0fPN5bYPeFVl8mnuppd
	 xEFKDMwlQMWVDrbuNroAQiiXlewJ9ZG1LgxxtG23MahQd4Z0hNfb3x6oACcssvODpW
	 AQ/E18Sdf8xLP4++FU2fWwEa6tIHy5nk0DA0R8TB0s0xEmZKvhqh9vlw9XFfiUB1xN
	 3cHoS6bCslSdw==
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
Subject: [PATCH net-next v2 02/12] net: ethtool: relax ethnl_req_get_phydev() locking assertion
Date: Thu,  4 Jun 2026 17:29:02 -0700
Message-ID: <20260605002912.3456868-3-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295490-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tipi-net.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4EF06441D5

phydev <> netdev linking and lifecycle depends on rtnl_lock.
We want to switch to instance locks for most ethtool ops.
Let's add an assert that ops locked devices don't use phydev
today. If one does we can either opt the phy ops out of
being purely ops locked, or do deeper surgery to make phy
locking ops-compatible. I don't think there's any fundamental
challenge to make that work.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/phy_link_topology.h   | 5 +++++
 net/ethtool/netlink.h               | 7 ++++---
 drivers/net/phy/phy_link_topology.c | 8 ++++++++
 net/ethtool/netlink.c               | 6 ++++--
 net/ethtool/phy.c                   | 1 -
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 68a59e25821c..95575f68d5bc 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -36,6 +36,11 @@ struct phy_device_node {
 	struct phy_device *phy;
 };
 
+static inline bool phy_link_topo_empty(struct net_device *dev)
+{
+	return !dev->link_topo;
+}
+
 #if IS_ENABLED(CONFIG_PHYLIB)
 int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index f94aaa66379c..4ca2eca2e94b 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -275,14 +275,15 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
 
 /**
  * ethnl_req_get_phydev() - Gets the phy_device targeted by this request,
- *			    if any. Must be called under rntl_lock().
+ *			    if any.
  * @req_info:	The ethnl request to get the phy from.
  * @tb:		The netlink attributes array, for error reporting.
  * @header:	The netlink header index, used for error reporting.
  * @extack:	The netlink extended ACK, for error reporting.
  *
- * The caller must hold RTNL, until it's done interacting with the returned
- * phy_device.
+ * If a phy_device is returned the caller must hold rtnl_lock when calling
+ * this function, and until it's done interacting with the returned phy_device.
+ * IOW caller must hold rtnl_lock unless they know netdev has no phy_device.
  *
  * Return: A phy_device pointer corresponding either to the passed phy_index
  *	   if one is provided. If not, the phy_device attached to the
diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 1f1eb5d59b38..aed3b26c1674 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -10,6 +10,7 @@
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/xarray.h>
+#include <net/netdev_lock.h>
 
 static int netdev_alloc_phy_link_topology(struct net_device *dev)
 {
@@ -35,6 +36,13 @@ int phy_link_topo_add_phy(struct net_device *dev,
 	struct phy_device_node *pdn;
 	int ret;
 
+	/* ethtool ops may run without rtnl_lock, and rtnl_lock is what
+	 * currently protects the PHY topology. No driver currently mixes
+	 * the two, flag if someone tries. See also ethnl_req_get_phydev().
+	 */
+	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
+		return -EOPNOTSUPP;
+
 	if (!topo) {
 		ret = netdev_alloc_phy_link_topology(dev);
 		if (ret)
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index c4054a9795ff..afafed738584 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -226,11 +226,13 @@ struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
 {
 	struct phy_device *phydev;
 
-	ASSERT_RTNL();
-
 	if (!req_info->dev)
 		return NULL;
 
+	/* If there is no PHY in sight there's no need for assert locking */
+	if (!phy_link_topo_empty(req_info->dev))
+		ASSERT_RTNL();
+
 	if (!req_info->phy_index)
 		return req_info->dev->phydev;
 
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index ddc6eab701ed..018b0412be86 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -78,7 +78,6 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 	struct phy_device *phydev;
 	int ret;
 
-	/* RTNL is held by the caller */
 	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PHY_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev))
-- 
2.54.0


