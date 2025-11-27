Return-Path: <netdev+bounces-242290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46409C8E63A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5930D4E7BD0
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5602417D9;
	Thu, 27 Nov 2025 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJZUeKHA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E8313A244
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249328; cv=none; b=je2d1llWeOKOBE1gwgm0s1GnI5ta5+hiTkjz72IwAycpOy37rBkfju90RW7172hvA5Ixm5ipT7h6KkQHiLaBlkeRQdVQC02sL1JQmLegIU1Tb/AXax75IMi8zNcetIKAjSuHxnRxe1W8lFarl6YKuwM8QvYDKZrTNIHYBq723D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249328; c=relaxed/simple;
	bh=Skm7K/dIrPMAbBA2uQ9rZcLHG04QPXkiqk8NG0TYs30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMAXrWJ0ix5RBaQZaAPHvOooSAZR2wNNAIJ1zX9u1rZWn3mWYcYjyKK2rMdkOYXVeRbu33mu9aKToaGfH8+E0QikLttYk+d28X8BOLCky8R6URoFR3yAMk6xo42xGLtVnMSrTxrA3OvUZPjPD4cFkNNzgg9pjF7VvB05FbyOb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJZUeKHA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764249327; x=1795785327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Skm7K/dIrPMAbBA2uQ9rZcLHG04QPXkiqk8NG0TYs30=;
  b=iJZUeKHA9d6I1xZ1m9dGhlQ7CFP+lbhAbjmtfnUWdlUuu6kefZlRlbOd
   RANGmVWUZz+hJb2EYaMyj22gjEZjusPSE+ML5t1ZYfHwIovs4lXbjqWgk
   YsUiPXvoKxKlstfdG6+XqNQCYIEJ4SG4BJAfCnpfihX55QuGS0MFwm9LD
   tl1wBtZ020L18oMr3XKF6erJ7jtwsI2dj0DVbOuJZJrEoJG5iGKoQQGtx
   Q0v1++5RgJcmqHilTP++Da+77pXXDwzt/GPXnd7emy/z3+5ugUCK+QokK
   AxZqny0jXRVMLeX5AhPaaBCzO5llfmEt+7D3M0NA6oA8V+/gsSQkf41CM
   A==;
X-CSE-ConnectionGUID: 3ct9bJeSTKmBSge5x7qUXQ==
X-CSE-MsgGUID: KZmD1SxnRMWQqWtvrKU21A==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="70157520"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="70157520"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 05:15:24 -0800
X-CSE-ConnectionGUID: n6NhTIkLTfWeofTQL9kCOA==
X-CSE-MsgGUID: tdeuWFwQQIiCFvfxL5vhow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="192892760"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 27 Nov 2025 05:15:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4C41AA3; Thu, 27 Nov 2025 14:15:21 +0100 (CET)
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
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH net-next 3/3] net: thunderbolt: Allow reading link settings
Date: Thu, 27 Nov 2025 14:15:21 +0100
Message-ID: <20251127131521.2580237-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251127131521.2580237-1-mika.westerberg@linux.intel.com>
References: <20251127131521.2580237-1-mika.westerberg@linux.intel.com>
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
 drivers/net/thunderbolt/main.c | 73 ++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 20bac55a3e20..b056c22ad129 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/ethtool.h>
 #include <linux/highmem.h>
 #include <linux/if_vlan.h>
 #include <linux/jhash.h>
@@ -1276,6 +1277,77 @@ static const struct net_device_ops tbnet_netdev_ops = {
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
+		/* For Gen 4 80G symmetric link the closest one
+		 * available is 56G so we report that.
+		 */
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     56000baseKR4_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     56000baseKR4_Full);
+		speed = SPEED_56000;
+		break;
+
+	case 20:
+		if (xd->link_width == 2) {
+			ethtool_link_ksettings_add_link_mode(cmd, supported,
+							     40000baseKR4_Full);
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     40000baseKR4_Full);
+			speed = SPEED_40000;
+		} else {
+			ethtool_link_ksettings_add_link_mode(cmd, supported,
+							     20000baseKR2_Full);
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     20000baseKR2_Full);
+			speed = SPEED_20000;
+		}
+		break;
+
+	case 10:
+		if (xd->link_width == 2) {
+			ethtool_link_ksettings_add_link_mode(cmd, supported,
+							     20000baseKR2_Full);
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     20000baseKR2_Full);
+			speed = SPEED_20000;
+			break;
+		}
+		fallthrough;
+
+	default:
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     10000baseT_Full);
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
@@ -1326,6 +1398,7 @@ static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
 
 	strcpy(dev->name, "thunderbolt%d");
 	dev->netdev_ops = &tbnet_netdev_ops;
+	dev->ethtool_ops = &tbnet_ethtool_ops;
 
 	/* ThunderboltIP takes advantage of TSO packets but instead of
 	 * segmenting them we just split the packet into Thunderbolt
-- 
2.50.1


