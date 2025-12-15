Return-Path: <netdev+bounces-244734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3ACBDC96
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45692303D939
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64212330B31;
	Mon, 15 Dec 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3bvd+uS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5932FA00
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800682; cv=none; b=tP3Ifht+AUcfR17dczenAQltYRCL9f+mygOQ3fj1Px20tv5qm1pRhWRXOcEriQMmesXKiWGYyPm4knY158gCKd7wQqgg/G1HbdLk8Qo72wLOwK2ftt7d4OK5ecGtHDEM0rgZagQ+ge8t4u3r2Ao+9v4JW4j6Xb1jr6IiHY3Ae7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800682; c=relaxed/simple;
	bh=70qHZxOHi97jCdAFDNZjWzFPJb7M58f3lAutVEcRZL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fd+k8MjVL1anSXOOTS1J9D60xlTHqTtvo6B7x/k9PPkMLQcDL2NATDmoRg+qx8Ri0uhKziZROUpeWgAki4+gndBv+DVYorHsntraiaJejjlS9Jrh6l15bbMwBvVHRh0oI4MOExx5OyfHwqdO5fncPAepY3zzlSWwO2k0pxWRnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3bvd+uS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765800680; x=1797336680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70qHZxOHi97jCdAFDNZjWzFPJb7M58f3lAutVEcRZL0=;
  b=N3bvd+uSmzXJhT8BBsPvxJe4EeiHObrwxRPk2nNgaKljVeZ3L6hE7anP
   Jp8ZeQnm/geeucHzddlVmBp0MzujpfSYlXwzqgTNvC8G0LC57SotDsJwg
   PtkXjRXtN7IcExTQJOQKD1LtlUfXc0KagmAIvlZlzQ73zhh6DqBkA4trD
   N3vS7pW0XumtW3a2cTjIrT6hEJfGnnunjbE5CXjlMwTi3qft27ZIajS7M
   wHAsZxDq/HRw542YUfFmpGpioE5cxGnyjIm6M0iBkUI97L6TRRJFyeAi2
   KDjeaE+JQ4BnN0w7JICWF4dcLei4jsYq+TSXJcXveKs0qBkTGccy47VDH
   A==;
X-CSE-ConnectionGUID: eo354uGqR3yCE+28fRQMVA==
X-CSE-MsgGUID: eGE5WhbkR2iPam7pBuEAXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78815409"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="78815409"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:11:16 -0800
X-CSE-ConnectionGUID: y5UZGv3FS+CU09qZJXyAgg==
X-CSE-MsgGUID: nI48duEFTDOc+STCGmvJ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202214172"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 15 Dec 2025 04:11:13 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7E315A1; Mon, 15 Dec 2025 13:11:09 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH net-next v2 5/5] net: thunderbolt: Allow reading link settings
Date: Mon, 15 Dec 2025 13:11:09 +0100
Message-ID: <20251215121109.4042218-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215121109.4042218-1-mika.westerberg@linux.intel.com>
References: <20251215121109.4042218-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian MacDonald <ian@netstatz.com>

In order to use Thunderbolt networking as part of bonding device it
needs to support ->get_link_ksettings() ethtool operation, so that the
bonding driver can read the link speed and the related attributes. Add
support for this to the driver.

Signed-off-by: Ian MacDonald <ian@netstatz.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 20bac55a3e20..74160d14cf46 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/ethtool.h>
 #include <linux/highmem.h>
 #include <linux/if_vlan.h>
 #include <linux/jhash.h>
@@ -1276,6 +1277,53 @@ static const struct net_device_ops tbnet_netdev_ops = {
 	.ndo_change_mtu	= tbnet_change_mtu,
 };
 
+static int tbnet_get_link_ksettings(struct net_device *dev,
+				    struct ethtool_link_ksettings *cmd)
+{
+	const struct tbnet *net = netdev_priv(dev);
+	const struct tb_xdomain *xd = net->xd;
+	int speed;
+
+	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+
+	/* Figure out the current link speed and width */
+	switch (xd->link_speed) {
+	case 40:
+		speed = SPEED_80000;
+		break;
+
+	case 20:
+		if (xd->link_width == 2)
+			speed = SPEED_40000;
+		else
+			speed = SPEED_20000;
+		break;
+
+	case 10:
+		if (xd->link_width == 2) {
+			speed = SPEED_20000;
+			break;
+		}
+		fallthrough;
+
+	default:
+		speed = SPEED_10000;
+		break;
+	}
+
+	cmd->base.speed = speed;
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.autoneg = AUTONEG_DISABLE;
+	cmd->base.port = PORT_OTHER;
+
+	return 0;
+}
+
+static const struct ethtool_ops tbnet_ethtool_ops = {
+	.get_link_ksettings = tbnet_get_link_ksettings,
+};
+
 static void tbnet_generate_mac(struct net_device *dev)
 {
 	const struct tbnet *net = netdev_priv(dev);
@@ -1326,6 +1374,7 @@ static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
 
 	strcpy(dev->name, "thunderbolt%d");
 	dev->netdev_ops = &tbnet_netdev_ops;
+	dev->ethtool_ops = &tbnet_ethtool_ops;
 
 	/* ThunderboltIP takes advantage of TSO packets but instead of
 	 * segmenting them we just split the packet into Thunderbolt
-- 
2.50.1


