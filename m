Return-Path: <netdev+bounces-248488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13368D09AA2
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66B26305862A
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813935BDA5;
	Fri,  9 Jan 2026 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PppC3PHH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881935B139
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961575; cv=none; b=OWCbiFQGkor5WUEjhSvfkPHQ9pf1N/93UvamO+paA4pKllM0/zmQ2c8xcodzC/mMY+saSO2tARPL1yanToK4zaNtGn7e87GWWKD3odVBR9iHL4jPGNouKgboXhbzIfXC6G0IA4w4q5l8JB0rrEl7IW60G8C+XI+3J47desxxuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961575; c=relaxed/simple;
	bh=70qHZxOHi97jCdAFDNZjWzFPJb7M58f3lAutVEcRZL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJURNK3YrhOsUP0XsFzqzU6syy7eabfRjIrHyrUVLi8ncsIQ8emTgeb/rO+HttEFkrK+j604lFY9PIpBYRwKrXJcaufgV0ZhLU+43e3pVvB6d9PjmaMnpy7KM5keqnwOcti55n+0nfGB7cM9Iw07cnpVnldoZ65VXCVgx1mfYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PppC3PHH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767961574; x=1799497574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70qHZxOHi97jCdAFDNZjWzFPJb7M58f3lAutVEcRZL0=;
  b=PppC3PHHxqD2TQquh4s80BL7JwMzuSdtzgKUMWxFb5zvQaJ/XGgAQB3o
   lvenATR9ZRuuwxfn8blJ82TZyv9R6q66966KVgjPAewnJjsS6YR5aF5V2
   hvWcyKO/jO1Qjg2uQlCeCxrOs/yVdM5IGe18AmVVQoNgXvv6gWCGzcG0g
   r5/ChNtpPWor57kGqEkf2sg2IiLwNwo8IHIuGqMLYL4GkY1ChvdYki/ZC
   p0uMNLdwDsGQTp8UVXAKuSI0EPbmdMA4PYygty3+sfpKXpUgjjPX6fwfN
   lSiWiCY8D0sB6zS9KDhTbXqeiS/Vx3ilgCi6gO42sDhSNeYPPiF+p9oUX
   Q==;
X-CSE-ConnectionGUID: 6bFyOMhxRtCnFz4oCSca/Q==
X-CSE-MsgGUID: tM8+54eeSHydqfA03WbF8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="73188995"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="73188995"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 04:26:14 -0800
X-CSE-ConnectionGUID: LiPF+wUZR22OqBchV91ong==
X-CSE-MsgGUID: M4lYObbPTQ26S1TEi54mIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="234169186"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 09 Jan 2026 04:26:12 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id E97C5A1; Fri, 09 Jan 2026 13:26:06 +0100 (CET)
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
	Simon Horman <horms@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH RESEND net-next v2 5/5] net: thunderbolt: Allow reading link settings
Date: Fri,  9 Jan 2026 13:26:06 +0100
Message-ID: <20260109122606.3586895-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
References: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
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


