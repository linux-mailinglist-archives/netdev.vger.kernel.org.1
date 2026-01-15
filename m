Return-Path: <netdev+bounces-250152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398ACD24560
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C02B301D317
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B50C389E0E;
	Thu, 15 Jan 2026 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeRIPVYF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DB392C29
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478216; cv=none; b=NTmkFkyVvoOknafoNrEmBuej1Nkow0CLGW7axBtzyH71xcyN9wuh3v+3aFpY5tKiw21NKbtVcR52yCtyxygya9TFFVv2ivvBhJQitTU6PE/lr/REUT7Waxi482ECstuZF00Qm69wd2E2VtgH8A46ujaGwVDj+UHgXP3rf5odqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478216; c=relaxed/simple;
	bh=i2T839sokiRR1UJPW7zAE4k62RMfCG0//yOoXZbeNYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idOaH8iIYACVFU7aC1DW4JIx8bpjBDCpuQlRmtQTZoE2kzDVKFYsDzfvrRBwC2fPPHaUHqXRgYQsUyK1xCaptolg/8PUc/StDkBAmqnaYsz8iFyrfEBRxg6+ZuiMWX9q+RJQ05uCHGOuaoUqGfEh9ZpufRb5tFN07LfheUK2e2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeRIPVYF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768478214; x=1800014214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2T839sokiRR1UJPW7zAE4k62RMfCG0//yOoXZbeNYo=;
  b=eeRIPVYFMu354BBx1E9fVY1+nOgQBVCOLHmk207fLdaefr1yrjMsbz8n
   bR+m5PmiQp/RTcxOowBi4bU0RENQq9Y3/ThmiUnX7NfDvqaCAYxshJ2at
   cnjWS00eOder/8FmDvRcL3Wtiedvji8d1EnSbpdl1nlbjFY88lMaOUfEk
   4yi1hEysRtyEhBw9xTvc+XPgbh/8zMFHVBK7Mo3EGNUtzB+vZx7cH7fcc
   dvtLMBmFN2xLo/fJqi7m6Z7QyNSxFC/a9Sv0bDE5NbKzE9IO/opHRdekc
   UTAG4yhIwuUczcZC/uPnavH4jZ8ifE30qYUdXtQZi22wkJjhxo2iKZbps
   g==;
X-CSE-ConnectionGUID: BhRgootFQTO5s3As+Txb1w==
X-CSE-MsgGUID: mp8z6qtdSN+uQ/ACR+Bm9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80503321"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="80503321"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 03:56:52 -0800
X-CSE-ConnectionGUID: kbwwbzNmQfmqUFJ3yakjzQ==
X-CSE-MsgGUID: CxY8+2djQu2a7SwA+9mvHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="204078625"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 15 Jan 2026 03:56:49 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0694C9E; Thu, 15 Jan 2026 12:56:47 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Ian MacDonald <ian@netstatz.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH net-next v3 4/4] net: thunderbolt: Allow reading link settings
Date: Thu, 15 Jan 2026 12:56:46 +0100
Message-ID: <20260115115646.328898-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
References: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 57b226afeb84..7aae5d915a1e 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/ethtool.h>
 #include <linux/highmem.h>
 #include <linux/if_vlan.h>
 #include <linux/jhash.h>
@@ -1265,6 +1266,53 @@ static const struct net_device_ops tbnet_netdev_ops = {
 	.ndo_get_stats64 = tbnet_get_stats64,
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
@@ -1315,6 +1363,7 @@ static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
 
 	strcpy(dev->name, "thunderbolt%d");
 	dev->netdev_ops = &tbnet_netdev_ops;
+	dev->ethtool_ops = &tbnet_ethtool_ops;
 
 	/* ThunderboltIP takes advantage of TSO packets but instead of
 	 * segmenting them we just split the packet into Thunderbolt
-- 
2.50.1


