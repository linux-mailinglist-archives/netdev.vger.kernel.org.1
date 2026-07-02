Return-Path: <netdev+bounces-304001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KHHcELoLRmoZIQsAu9opvQ
	(envelope-from <netdev+bounces-304001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:56:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA16F3F4E
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:56:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=Hd4w6cAe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304001-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304001-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F29E313AF96
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC6138F646;
	Thu,  2 Jul 2026 06:46:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3238E8D8;
	Thu,  2 Jul 2026 06:46:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974787; cv=none; b=N5BmkbSOCFqZlv5uaFjQh8ksyt/+3Qn/uLIF4DOB7B74ix7J9HuKBlPIIZWId7dbPMq1CtgpkJ+Qbq8sFObag/zfOsTTie1puSaYxcbbUXS+sansogFG7eTEIIY9WLERMZVIEVAvHXQtqYkCpf4nMLVWVYAtr8PH6g5wi3DqY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974787; c=relaxed/simple;
	bh=x+gnWE00AtU6QpGcKRstzN/VHYghzYIc3sOnepuv4KA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hpjL1Cx67RzCAFaZgf2NqYTKk7a6ViCfBsrYU0bvzYCbEMjGikAMG67o2oHePnqqZ7pXEBwUWz5L8Hx8wLDZoAsHu6vwHhlERFwzZF6luRlp1f4+FuxL2i1q1r13zHg1tGmiii81TaLmfCn6KsudHJ4taPAjxzDxSd9dVfPiZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Hd4w6cAe; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782974786; x=1814510786;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=x+gnWE00AtU6QpGcKRstzN/VHYghzYIc3sOnepuv4KA=;
  b=Hd4w6cAeKhDhI6FM/518hJZzIPbj7bS4QPXkip/i36wvrJ4t9JoDIDaW
   5TdGbhhA2tTN1txMXc3YZzfwYUSANLFEF9j0YJnZIIanSgQl4YmyliKjD
   k8GHaSQO9NCGq9hU7HmWBLRpi4ku2IcIAZQuMdcuu4t9vXY0z5hjEqVk9
   t0XN6LDgr1JIzVqdYFACiojX5RwddiL6nXc+QD/PBN77HMwbjgT68V5xV
   vavfDPj1SPNHR5AhL9gJXJ4ErVz/ejyeBE/L8PrPs+FnFFUAkrsNd71pq
   YB/JO6Sl4aKQuNETwDjxUj+7RTtsU/KDkI9kEY7hay4ENDdIFMulaZJgg
   w==;
X-CSE-ConnectionGUID: pmYDen0JR+W1McNznKAuWQ==
X-CSE-MsgGUID: X52H4ZtLRq2mYhF3cj2yTw==
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="69265289"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:46:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 1 Jul 2026 23:46:22 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 1 Jul 2026 23:46:19 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Thu, 2 Jul 2026 08:45:20 +0200
Subject: [PATCH net-next v8 9/9] net: dsa: lan9645x: add port statistics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260702-dsa_lan9645x_switch_driver_base-v8-9-90228d8bba58@microchip.com>
References: <20260702-dsa_lan9645x_switch_driver_base-v8-0-90228d8bba58@microchip.com>
In-Reply-To: <20260702-dsa_lan9645x_switch_driver_base-v8-0-90228d8bba58@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Russell King
	<linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304001-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:woojung.huh@microchip.com,m:linux@armlinux.org.uk,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:jensemil.schulzostergaard@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CBA16F3F4E

Add statistics support for the port counters. Chip registers are 32 bit,
so this unit is responsible maintaining a 64bit software cache, and
updating it frequently to handle overflows in hardware.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v5:
- make lan9645x_stats_init void
- add SCNT_TX_BUFDROP to tx_dropped
- change rmon range {0,64} -> {64, 64}. Runt frames counted elsewhere.
- remove rx_crc, rx_symbol_err from rx_packets, as they are already
  counted in SZ_* buckets.
- add defensive cancel_delayed_work_sync in stats_free

Changes in v4:
- remove rx_uc and tx_uc from ethtool stats list, as they are derivable
  from the eth-mac group
- split stats_init into stats_alloc and stats_init, use alloc in probe
  and init in dsa_setup

Changes in v3:
- No changes

Changes in v2:
- introduce spinlock sw_lock protecting software counters and region
  buffer.
- ran Ioana's selftest for standard counters
        drivers/net/hw/ethtool_std_stats.sh
  along with
        selftests/drivers/net/hw/ethtool_rmon.sh
  they pass except for software injected pause frames.
- remove strings/counters covered by standard counters from
  get_strings/get_ethtool_stats.
- fix proper use of 'src' in standard counters
- remove static region table, and use stats_prepare_regions for dynamic
  region calculation inspired by ocelot.
- fix queue leak in error path.
---
 drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  87 +-
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |   3 +
 .../net/dsa/microchip/lan9645x/lan9645x_stats.c    | 929 +++++++++++++++++++++
 .../net/dsa/microchip/lan9645x/lan9645x_stats.h    | 279 +++++++
 5 files changed, 1298 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
index 2413d11fe849..cd994943c1c0 100644
--- a/drivers/net/dsa/microchip/lan9645x/Makefile
+++ b/drivers/net/dsa/microchip/lan9645x/Makefile
@@ -8,4 +8,5 @@ mchp-lan9645x-objs := \
 	lan9645x_npi.o \
 	lan9645x_phylink.o \
 	lan9645x_port.o \
+	lan9645x_stats.o \
 	lan9645x_vlan.o \
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index ba954440b0b0..2e97178a416f 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -5,6 +5,7 @@
 #include <linux/platform_device.h>
 
 #include "lan9645x_main.h"
+#include "lan9645x_stats.h"
 
 static const char *lan9645x_resource_names[NUM_TARGETS + 1] = {
 	[TARGET_GCB]          = "gcb",
@@ -71,6 +72,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
 	lan9645x_mac_deinit(lan9645x);
 	lan9645x_mdb_deinit(lan9645x);
+	lan9645x_stats_deinit(lan9645x);
 	mutex_destroy(&lan9645x->port_mux_lock);
 	mutex_destroy(&lan9645x->fwd_domain_lock);
 }
@@ -287,6 +289,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
 		goto err_mac;
 	}
 
+	lan9645x_stats_init(lan9645x);
+
 	ds->mtu_enforcement_ingress = true;
 	ds->assisted_learning_on_cpu_port = true;
 	ds->fdb_isolation = true;
@@ -766,6 +770,68 @@ static int lan9645x_mdb_del(struct dsa_switch *ds, int port,
 	return err;
 }
 
+static void lan9645x_get_strings(struct dsa_switch *ds, int port, u32 stringset,
+				 uint8_t *data)
+{
+	lan9645x_stats_get_strings(ds->priv, port, stringset, data);
+}
+
+static void lan9645x_get_ethtool_stats(struct dsa_switch *ds, int port,
+				       uint64_t *data)
+{
+	lan9645x_stats_get_ethtool_stats(ds->priv, port, data);
+}
+
+static int lan9645x_get_sset_count(struct dsa_switch *ds, int port, int sset)
+{
+	return lan9645x_stats_get_sset_count(ds->priv, port, sset);
+}
+
+static void lan9645x_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				       struct ethtool_eth_mac_stats *mac_stats)
+{
+	lan9645x_stats_get_eth_mac_stats(ds->priv, port, mac_stats);
+}
+
+static void
+lan9645x_get_rmon_stats(struct dsa_switch *ds, int port,
+			struct ethtool_rmon_stats *rmon_stats,
+			const struct ethtool_rmon_hist_range **ranges)
+{
+	lan9645x_stats_get_rmon_stats(ds->priv, port, rmon_stats, ranges);
+}
+
+static void lan9645x_get_stats64(struct dsa_switch *ds, int port,
+				 struct rtnl_link_stats64 *s)
+{
+	lan9645x_stats_get_stats64(ds->priv, port, s);
+}
+
+static void lan9645x_get_pause_stats(struct dsa_switch *ds, int port,
+				     struct ethtool_pause_stats *pause_stats)
+{
+	lan9645x_stats_get_pause_stats(ds->priv, port, pause_stats);
+}
+
+static void lan9645x_get_mm_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_mm_stats *stats)
+{
+	lan9645x_stats_get_mm_stats(ds->priv, port, stats);
+}
+
+static void lan9645x_get_eth_phy_stats(struct dsa_switch *ds, int port,
+				       struct ethtool_eth_phy_stats *phy_stats)
+{
+	lan9645x_stats_get_eth_phy_stats(ds->priv, port, phy_stats);
+}
+
+static void
+lan9645x_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+			    struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	lan9645x_stats_get_eth_ctrl_stats(ds->priv, port, ctrl_stats);
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 
@@ -803,6 +869,18 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
 	/* Multicast database */
 	.port_mdb_add			= lan9645x_mdb_add,
 	.port_mdb_del			= lan9645x_mdb_del,
+
+	/* Port statistics counters. */
+	.get_strings			= lan9645x_get_strings,
+	.get_ethtool_stats		= lan9645x_get_ethtool_stats,
+	.get_sset_count			= lan9645x_get_sset_count,
+	.get_eth_mac_stats		= lan9645x_get_eth_mac_stats,
+	.get_rmon_stats			= lan9645x_get_rmon_stats,
+	.get_stats64			= lan9645x_get_stats64,
+	.get_pause_stats		= lan9645x_get_pause_stats,
+	.get_mm_stats			= lan9645x_get_mm_stats,
+	.get_eth_phy_stats		= lan9645x_get_eth_phy_stats,
+	.get_eth_ctrl_stats		= lan9645x_get_eth_ctrl_stats,
 };
 
 static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
@@ -903,9 +981,15 @@ static int lan9645x_probe(struct platform_device *pdev)
 
 	lan9645x_set_feat_dis(lan9645x);
 
-	err = dsa_register_switch(ds);
+	err = lan9645x_stats_alloc(lan9645x);
 	if (err)
+		return dev_err_probe(dev, err, "Failed to allocate stats");
+
+	err = dsa_register_switch(ds);
+	if (err) {
+		lan9645x_stats_free(lan9645x);
 		return dev_err_probe(dev, err, "Failed to register DSA switch");
+	}
 
 	return 0;
 }
@@ -919,6 +1003,7 @@ static void lan9645x_remove(struct platform_device *pdev)
 
 	/* Calls lan9645x DSA .teardown */
 	dsa_unregister_switch(lan9645x->ds);
+	lan9645x_stats_free(lan9645x);
 	dev_set_drvdata(&pdev->dev, NULL);
 }
 
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index 902636f06c14..7c6cad0da4f1 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -219,6 +219,9 @@ struct lan9645x {
 	 */
 	struct mutex mdb_lock;
 
+	/* Statistics  */
+	struct lan9645x_stats *stats;
+
 	int num_port_dis;
 };
 
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
new file mode 100644
index 000000000000..e38f510eb8f6
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
@@ -0,0 +1,929 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "lan9645x_main.h"
+#include "lan9645x_stats.h"
+
+#define LAN9645X_STATS_CHECK_DELAY	(3 * HZ)
+
+static const u32 lan9645x_port_stats_layout[] = {
+	[SCNT_RX_OCT]              = 0x0,
+	[SCNT_RX_UC]               = 0x1,
+	[SCNT_RX_MC]               = 0x2,
+	[SCNT_RX_BC]               = 0x3,
+	[SCNT_RX_SHORT]            = 0x4,
+	[SCNT_RX_FRAG]             = 0x5,
+	[SCNT_RX_JABBER]           = 0x6,
+	[SCNT_RX_CRC]              = 0x7,
+	[SCNT_RX_SYMBOL_ERR]       = 0x8,
+	[SCNT_RX_SZ_64]            = 0x9,
+	[SCNT_RX_SZ_65_127]        = 0xa,
+	[SCNT_RX_SZ_128_255]       = 0xb,
+	[SCNT_RX_SZ_256_511]       = 0xc,
+	[SCNT_RX_SZ_512_1023]      = 0xd,
+	[SCNT_RX_SZ_1024_1526]     = 0xe,
+	[SCNT_RX_SZ_JUMBO]         = 0xf,
+	[SCNT_RX_PAUSE]            = 0x10,
+	[SCNT_RX_CONTROL]          = 0x11,
+	[SCNT_RX_LONG]             = 0x12,
+	[SCNT_RX_CAT_DROP]         = 0x13,
+	[SCNT_RX_RED_PRIO_0]       = 0x14,
+	[SCNT_RX_RED_PRIO_1]       = 0x15,
+	[SCNT_RX_RED_PRIO_2]       = 0x16,
+	[SCNT_RX_RED_PRIO_3]       = 0x17,
+	[SCNT_RX_RED_PRIO_4]       = 0x18,
+	[SCNT_RX_RED_PRIO_5]       = 0x19,
+	[SCNT_RX_RED_PRIO_6]       = 0x1a,
+	[SCNT_RX_RED_PRIO_7]       = 0x1b,
+	[SCNT_RX_YELLOW_PRIO_0]    = 0x1c,
+	[SCNT_RX_YELLOW_PRIO_1]    = 0x1d,
+	[SCNT_RX_YELLOW_PRIO_2]    = 0x1e,
+	[SCNT_RX_YELLOW_PRIO_3]    = 0x1f,
+	[SCNT_RX_YELLOW_PRIO_4]    = 0x20,
+	[SCNT_RX_YELLOW_PRIO_5]    = 0x21,
+	[SCNT_RX_YELLOW_PRIO_6]    = 0x22,
+	[SCNT_RX_YELLOW_PRIO_7]    = 0x23,
+	[SCNT_RX_GREEN_PRIO_0]     = 0x24,
+	[SCNT_RX_GREEN_PRIO_1]     = 0x25,
+	[SCNT_RX_GREEN_PRIO_2]     = 0x26,
+	[SCNT_RX_GREEN_PRIO_3]     = 0x27,
+	[SCNT_RX_GREEN_PRIO_4]     = 0x28,
+	[SCNT_RX_GREEN_PRIO_5]     = 0x29,
+	[SCNT_RX_GREEN_PRIO_6]     = 0x2a,
+	[SCNT_RX_GREEN_PRIO_7]     = 0x2b,
+	[SCNT_RX_ASSEMBLY_ERR]     = 0x2c,
+	[SCNT_RX_SMD_ERR]          = 0x2d,
+	[SCNT_RX_ASSEMBLY_OK]      = 0x2e,
+	[SCNT_RX_MERGE_FRAG]       = 0x2f,
+	[SCNT_RX_PMAC_OCT]         = 0x30,
+	[SCNT_RX_PMAC_UC]          = 0x31,
+	[SCNT_RX_PMAC_MC]          = 0x32,
+	[SCNT_RX_PMAC_BC]          = 0x33,
+	[SCNT_RX_PMAC_SHORT]       = 0x34,
+	[SCNT_RX_PMAC_FRAG]        = 0x35,
+	[SCNT_RX_PMAC_JABBER]      = 0x36,
+	[SCNT_RX_PMAC_CRC]         = 0x37,
+	[SCNT_RX_PMAC_SYMBOL_ERR]  = 0x38,
+	[SCNT_RX_PMAC_SZ_64]       = 0x39,
+	[SCNT_RX_PMAC_SZ_65_127]   = 0x3a,
+	[SCNT_RX_PMAC_SZ_128_255]  = 0x3b,
+	[SCNT_RX_PMAC_SZ_256_511]  = 0x3c,
+	[SCNT_RX_PMAC_SZ_512_1023] = 0x3d,
+	[SCNT_RX_PMAC_SZ_1024_1526] = 0x3e,
+	[SCNT_RX_PMAC_SZ_JUMBO]    = 0x3f,
+	[SCNT_RX_PMAC_PAUSE]       = 0x40,
+	[SCNT_RX_PMAC_CONTROL]     = 0x41,
+	[SCNT_RX_PMAC_LONG]        = 0x42,
+	[SCNT_TX_OCT]              = 0x80,
+	[SCNT_TX_UC]               = 0x81,
+	[SCNT_TX_MC]               = 0x82,
+	[SCNT_TX_BC]               = 0x83,
+	[SCNT_TX_COL]              = 0x84,
+	[SCNT_TX_DROP]             = 0x85,
+	[SCNT_TX_PAUSE]            = 0x86,
+	[SCNT_TX_SZ_64]            = 0x87,
+	[SCNT_TX_SZ_65_127]        = 0x88,
+	[SCNT_TX_SZ_128_255]       = 0x89,
+	[SCNT_TX_SZ_256_511]       = 0x8a,
+	[SCNT_TX_SZ_512_1023]      = 0x8b,
+	[SCNT_TX_SZ_1024_1526]     = 0x8c,
+	[SCNT_TX_SZ_JUMBO]         = 0x8d,
+	[SCNT_TX_YELLOW_PRIO_0]    = 0x8e,
+	[SCNT_TX_YELLOW_PRIO_1]    = 0x8f,
+	[SCNT_TX_YELLOW_PRIO_2]    = 0x90,
+	[SCNT_TX_YELLOW_PRIO_3]    = 0x91,
+	[SCNT_TX_YELLOW_PRIO_4]    = 0x92,
+	[SCNT_TX_YELLOW_PRIO_5]    = 0x93,
+	[SCNT_TX_YELLOW_PRIO_6]    = 0x94,
+	[SCNT_TX_YELLOW_PRIO_7]    = 0x95,
+	[SCNT_TX_GREEN_PRIO_0]     = 0x96,
+	[SCNT_TX_GREEN_PRIO_1]     = 0x97,
+	[SCNT_TX_GREEN_PRIO_2]     = 0x98,
+	[SCNT_TX_GREEN_PRIO_3]     = 0x99,
+	[SCNT_TX_GREEN_PRIO_4]     = 0x9a,
+	[SCNT_TX_GREEN_PRIO_5]     = 0x9b,
+	[SCNT_TX_GREEN_PRIO_6]     = 0x9c,
+	[SCNT_TX_GREEN_PRIO_7]     = 0x9d,
+	[SCNT_TX_AGED]             = 0x9e,
+	[SCNT_TX_LLCT]             = 0x9f,
+	[SCNT_TX_CT]               = 0xa0,
+	[SCNT_TX_BUFDROP]          = 0xa1,
+	[SCNT_TX_MM_HOLD]          = 0xa2,
+	[SCNT_TX_MERGE_FRAG]       = 0xa3,
+	[SCNT_TX_PMAC_OCT]         = 0xa4,
+	[SCNT_TX_PMAC_UC]          = 0xa5,
+	[SCNT_TX_PMAC_MC]          = 0xa6,
+	[SCNT_TX_PMAC_BC]          = 0xa7,
+	[SCNT_TX_PMAC_PAUSE]       = 0xa8,
+	[SCNT_TX_PMAC_SZ_64]       = 0xa9,
+	[SCNT_TX_PMAC_SZ_65_127]   = 0xaa,
+	[SCNT_TX_PMAC_SZ_128_255]  = 0xab,
+	[SCNT_TX_PMAC_SZ_256_511]  = 0xac,
+	[SCNT_TX_PMAC_SZ_512_1023] = 0xad,
+	[SCNT_TX_PMAC_SZ_1024_1526] = 0xae,
+	[SCNT_TX_PMAC_SZ_JUMBO]    = 0xaf,
+	[SCNT_DR_LOCAL]            = 0x100,
+	[SCNT_DR_TAIL]             = 0x101,
+	[SCNT_DR_YELLOW_PRIO_0]    = 0x102,
+	[SCNT_DR_YELLOW_PRIO_1]    = 0x103,
+	[SCNT_DR_YELLOW_PRIO_2]    = 0x104,
+	[SCNT_DR_YELLOW_PRIO_3]    = 0x105,
+	[SCNT_DR_YELLOW_PRIO_4]    = 0x106,
+	[SCNT_DR_YELLOW_PRIO_5]    = 0x107,
+	[SCNT_DR_YELLOW_PRIO_6]    = 0x108,
+	[SCNT_DR_YELLOW_PRIO_7]    = 0x109,
+	[SCNT_DR_GREEN_PRIO_0]     = 0x10a,
+	[SCNT_DR_GREEN_PRIO_1]     = 0x10b,
+	[SCNT_DR_GREEN_PRIO_2]     = 0x10c,
+	[SCNT_DR_GREEN_PRIO_3]     = 0x10d,
+	[SCNT_DR_GREEN_PRIO_4]     = 0x10e,
+	[SCNT_DR_GREEN_PRIO_5]     = 0x10f,
+	[SCNT_DR_GREEN_PRIO_6]     = 0x110,
+	[SCNT_DR_GREEN_PRIO_7]     = 0x111,
+};
+
+struct lan9645x_ethtool_stat {
+	char name[ETH_GSTRING_LEN];
+	u16 idx;
+};
+
+static const struct lan9645x_ethtool_stat lan9645x_port_ethtool_stats[] = {
+	{ "rx_cat_drop",        SCNT_RX_CAT_DROP },
+	{ "rx_red_prio_0",      SCNT_RX_RED_PRIO_0 },
+	{ "rx_red_prio_1",      SCNT_RX_RED_PRIO_1 },
+	{ "rx_red_prio_2",      SCNT_RX_RED_PRIO_2 },
+	{ "rx_red_prio_3",      SCNT_RX_RED_PRIO_3 },
+	{ "rx_red_prio_4",      SCNT_RX_RED_PRIO_4 },
+	{ "rx_red_prio_5",      SCNT_RX_RED_PRIO_5 },
+	{ "rx_red_prio_6",      SCNT_RX_RED_PRIO_6 },
+	{ "rx_red_prio_7",      SCNT_RX_RED_PRIO_7 },
+	{ "rx_yellow_prio_0",   SCNT_RX_YELLOW_PRIO_0 },
+	{ "rx_yellow_prio_1",   SCNT_RX_YELLOW_PRIO_1 },
+	{ "rx_yellow_prio_2",   SCNT_RX_YELLOW_PRIO_2 },
+	{ "rx_yellow_prio_3",   SCNT_RX_YELLOW_PRIO_3 },
+	{ "rx_yellow_prio_4",   SCNT_RX_YELLOW_PRIO_4 },
+	{ "rx_yellow_prio_5",   SCNT_RX_YELLOW_PRIO_5 },
+	{ "rx_yellow_prio_6",   SCNT_RX_YELLOW_PRIO_6 },
+	{ "rx_yellow_prio_7",   SCNT_RX_YELLOW_PRIO_7 },
+	{ "rx_green_prio_0",    SCNT_RX_GREEN_PRIO_0 },
+	{ "rx_green_prio_1",    SCNT_RX_GREEN_PRIO_1 },
+	{ "rx_green_prio_2",    SCNT_RX_GREEN_PRIO_2 },
+	{ "rx_green_prio_3",    SCNT_RX_GREEN_PRIO_3 },
+	{ "rx_green_prio_4",    SCNT_RX_GREEN_PRIO_4 },
+	{ "rx_green_prio_5",    SCNT_RX_GREEN_PRIO_5 },
+	{ "rx_green_prio_6",    SCNT_RX_GREEN_PRIO_6 },
+	{ "rx_green_prio_7",    SCNT_RX_GREEN_PRIO_7 },
+	{ "tx_drop",            SCNT_TX_DROP },
+	{ "tx_yellow_prio_0",   SCNT_TX_YELLOW_PRIO_0 },
+	{ "tx_yellow_prio_1",   SCNT_TX_YELLOW_PRIO_1 },
+	{ "tx_yellow_prio_2",   SCNT_TX_YELLOW_PRIO_2 },
+	{ "tx_yellow_prio_3",   SCNT_TX_YELLOW_PRIO_3 },
+	{ "tx_yellow_prio_4",   SCNT_TX_YELLOW_PRIO_4 },
+	{ "tx_yellow_prio_5",   SCNT_TX_YELLOW_PRIO_5 },
+	{ "tx_yellow_prio_6",   SCNT_TX_YELLOW_PRIO_6 },
+	{ "tx_yellow_prio_7",   SCNT_TX_YELLOW_PRIO_7 },
+	{ "tx_green_prio_0",    SCNT_TX_GREEN_PRIO_0 },
+	{ "tx_green_prio_1",    SCNT_TX_GREEN_PRIO_1 },
+	{ "tx_green_prio_2",    SCNT_TX_GREEN_PRIO_2 },
+	{ "tx_green_prio_3",    SCNT_TX_GREEN_PRIO_3 },
+	{ "tx_green_prio_4",    SCNT_TX_GREEN_PRIO_4 },
+	{ "tx_green_prio_5",    SCNT_TX_GREEN_PRIO_5 },
+	{ "tx_green_prio_6",    SCNT_TX_GREEN_PRIO_6 },
+	{ "tx_green_prio_7",    SCNT_TX_GREEN_PRIO_7 },
+	{ "tx_aged",            SCNT_TX_AGED },
+	{ "tx_bufdrop",         SCNT_TX_BUFDROP },
+	{ "dr_local",           SCNT_DR_LOCAL },
+	{ "dr_tail",            SCNT_DR_TAIL },
+	{ "dr_yellow_prio_0",   SCNT_DR_YELLOW_PRIO_0 },
+	{ "dr_yellow_prio_1",   SCNT_DR_YELLOW_PRIO_1 },
+	{ "dr_yellow_prio_2",   SCNT_DR_YELLOW_PRIO_2 },
+	{ "dr_yellow_prio_3",   SCNT_DR_YELLOW_PRIO_3 },
+	{ "dr_yellow_prio_4",   SCNT_DR_YELLOW_PRIO_4 },
+	{ "dr_yellow_prio_5",   SCNT_DR_YELLOW_PRIO_5 },
+	{ "dr_yellow_prio_6",   SCNT_DR_YELLOW_PRIO_6 },
+	{ "dr_yellow_prio_7",   SCNT_DR_YELLOW_PRIO_7 },
+	{ "dr_green_prio_0",    SCNT_DR_GREEN_PRIO_0 },
+	{ "dr_green_prio_1",    SCNT_DR_GREEN_PRIO_1 },
+	{ "dr_green_prio_2",    SCNT_DR_GREEN_PRIO_2 },
+	{ "dr_green_prio_3",    SCNT_DR_GREEN_PRIO_3 },
+	{ "dr_green_prio_4",    SCNT_DR_GREEN_PRIO_4 },
+	{ "dr_green_prio_5",    SCNT_DR_GREEN_PRIO_5 },
+	{ "dr_green_prio_6",    SCNT_DR_GREEN_PRIO_6 },
+	{ "dr_green_prio_7",    SCNT_DR_GREEN_PRIO_7 },
+};
+
+static const struct lan9645x_view_stats lan9645x_view_stat_cfgs[] = {
+	[LAN9645X_STAT_PORTS] = {
+		.name = "ports",
+		.type = LAN9645X_STAT_PORTS,
+		.layout = lan9645x_port_stats_layout,
+		.num_cnts = ARRAY_SIZE(lan9645x_port_stats_layout),
+		.num_indexes = NUM_PHYS_PORTS,
+	},
+};
+
+static int __lan9645x_stats_view_idx_hw_read(struct lan9645x *lan9645x,
+					     enum lan9645x_view_stat_type vtype,
+					     int idx)
+{
+	struct lan9645x_stat_region region;
+	struct lan9645x_view_stats *vstats;
+	u32 *region_buf;
+	int err;
+
+	lockdep_assert_held(&lan9645x->stats->hw_lock);
+
+	vstats = lan9645x_get_vstats(lan9645x, vtype);
+	if (!vstats || idx < 0 || idx >= vstats->num_indexes)
+		return -EINVAL;
+
+	lan_wr(SYS_STAT_CFG_STAT_VIEW_SET(idx), lan9645x, SYS_STAT_CFG);
+
+	region_buf = &vstats->buf[vstats->num_cnts * idx];
+
+	/* Each region for this index contains counters which are at sequential
+	 * addresses, so we can use bulk reads to ease lock pressure a bit.
+	 */
+	for (int r = 0; r < vstats->num_regions; r++) {
+		region = vstats->regions[r];
+		err = lan_bulk_rd(&region_buf[region.cnts_base_idx], region.cnt,
+				  lan9645x, SYS_CNT(region.base_offset));
+		if (err) {
+			dev_err(lan9645x->dev,
+				"stats bulk read err vtype=%d idx=%d err=%d\n",
+				vtype, idx, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static void
+__lan9645x_stats_view_idx_transfer(struct lan9645x *lan9645x,
+				   enum lan9645x_view_stat_type vtype, int idx)
+{
+	struct lan9645x_view_stats *vstats;
+	u64 *idx_counters;
+	u32 *region_buf;
+	int cntr;
+
+	lockdep_assert_held(&lan9645x->stats->sw_lock);
+
+	vstats = lan9645x_get_vstats(lan9645x, vtype);
+	if (!vstats || idx < 0 || idx >= vstats->num_indexes)
+		return;
+
+	idx_counters = STATS_INDEX(vstats, idx);
+	region_buf = &vstats->buf[vstats->num_cnts * idx];
+
+	for (cntr = 0; cntr < vstats->num_cnts; cntr++)
+		lan9645x_stats_add_cnt(&idx_counters[cntr], region_buf[cntr]);
+}
+
+static void __lan9645x_stats_view_idx_update(struct lan9645x *lan9645x,
+					     enum lan9645x_view_stat_type vtype,
+					     int idx)
+{
+	struct lan9645x_stats *s = lan9645x->stats;
+
+	lockdep_assert_held(&s->hw_lock);
+
+	if (!__lan9645x_stats_view_idx_hw_read(lan9645x, vtype, idx)) {
+		spin_lock(&s->sw_lock);
+		__lan9645x_stats_view_idx_transfer(lan9645x, vtype, idx);
+		spin_unlock(&s->sw_lock);
+	}
+}
+
+static u64 *lan9645x_stats_view_idx_update(struct lan9645x *lan9645x,
+					   enum lan9645x_view_stat_type vtype,
+					   int idx)
+{
+	struct lan9645x_stats *s = lan9645x->stats;
+
+	mutex_lock(&s->hw_lock);
+	__lan9645x_stats_view_idx_update(lan9645x, vtype, idx);
+	mutex_unlock(&s->hw_lock);
+
+	return STAT_COUNTERS(lan9645x, vtype, idx);
+}
+
+static void lan9645x_stats_view_update(struct lan9645x *lan9645x,
+				       enum lan9645x_view_stat_type vtype)
+{
+	struct lan9645x_stats *s = lan9645x->stats;
+	struct lan9645x_view_stats *vstats;
+	int idx;
+
+	vstats = lan9645x_get_vstats(lan9645x, vtype);
+	if (!vstats)
+		return;
+
+	switch (vtype) {
+	case LAN9645X_STAT_PORTS:
+		mutex_lock(&s->hw_lock);
+		for (idx = 0; idx < vstats->num_indexes; idx++) {
+			if (dsa_is_unused_port(lan9645x->ds, idx))
+				continue;
+			__lan9645x_stats_view_idx_update(lan9645x, vtype, idx);
+		}
+		mutex_unlock(&s->hw_lock);
+		return;
+	default:
+		return;
+	}
+}
+
+static void lan9645x_stats_update(struct lan9645x *lan9645x)
+{
+	for (int vtype = 0; vtype < LAN9645X_STAT_NUM; vtype++)
+		lan9645x_stats_view_update(lan9645x, vtype);
+}
+
+void lan9645x_stats_get_strings(struct lan9645x *lan9645x, int port,
+				u32 stringset, u8 *data)
+{
+	int i;
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(lan9645x_port_ethtool_stats); i++)
+		memcpy(data + i * ETH_GSTRING_LEN,
+		       lan9645x_port_ethtool_stats[i].name, ETH_GSTRING_LEN);
+}
+
+int lan9645x_stats_get_sset_count(struct lan9645x *lan9645x, int port, int sset)
+{
+	if (sset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	return ARRAY_SIZE(lan9645x_port_ethtool_stats);
+}
+
+void lan9645x_stats_get_ethtool_stats(struct lan9645x *lan9645x, int port,
+				      u64 *data)
+{
+	struct lan9645x_stats *stats = lan9645x->stats;
+	u64 *c;
+	int i;
+
+	c = lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, port);
+
+	spin_lock(&stats->sw_lock);
+	for (i = 0; i < ARRAY_SIZE(lan9645x_port_ethtool_stats); i++)
+		*data++ = c[lan9645x_port_ethtool_stats[i].idx];
+	spin_unlock(&stats->sw_lock);
+}
+
+static u64 *lan9645x_stats_port_update(struct lan9645x *lan9645x, int port)
+{
+	return lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS,
+					      port);
+}
+
+void lan9645x_stats_get_eth_mac_stats(struct lan9645x *lan9645x, int port,
+				      struct ethtool_eth_mac_stats *m)
+{
+	struct lan9645x_stats *s = lan9645x->stats;
+	u64 *c;
+
+	c = lan9645x_stats_port_update(lan9645x, port);
+
+	spin_lock(&s->sw_lock);
+
+	switch (m->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		m->FramesTransmittedOK = c[SCNT_TX_UC] +
+					 c[SCNT_TX_MC] +
+					 c[SCNT_TX_BC];
+		m->SingleCollisionFrames = c[SCNT_TX_COL];
+		m->FramesReceivedOK = c[SCNT_RX_UC] +
+				      c[SCNT_RX_MC] +
+				      c[SCNT_RX_BC];
+		m->FrameCheckSequenceErrors = c[SCNT_RX_CRC];
+		m->OctetsTransmittedOK = c[SCNT_TX_OCT];
+		m->OctetsReceivedOK = c[SCNT_RX_OCT];
+		m->MulticastFramesXmittedOK = c[SCNT_TX_MC];
+		m->BroadcastFramesXmittedOK = c[SCNT_TX_BC];
+		m->MulticastFramesReceivedOK = c[SCNT_RX_MC];
+		m->BroadcastFramesReceivedOK = c[SCNT_RX_BC];
+		m->InRangeLengthErrors = c[SCNT_RX_FRAG] +
+					 c[SCNT_RX_JABBER] +
+					 c[SCNT_RX_CRC];
+		m->OutOfRangeLengthField = c[SCNT_RX_SHORT] +
+					   c[SCNT_RX_LONG];
+		m->FrameTooLongErrors = c[SCNT_RX_LONG];
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		m->FramesTransmittedOK = c[SCNT_TX_PMAC_UC] +
+					 c[SCNT_TX_PMAC_MC] +
+					 c[SCNT_TX_PMAC_BC];
+		m->FramesReceivedOK = c[SCNT_RX_PMAC_UC] +
+				      c[SCNT_RX_PMAC_MC] +
+				      c[SCNT_RX_PMAC_BC];
+		m->FrameCheckSequenceErrors = c[SCNT_RX_PMAC_CRC];
+		m->OctetsTransmittedOK = c[SCNT_TX_PMAC_OCT];
+		m->OctetsReceivedOK = c[SCNT_RX_PMAC_OCT];
+		m->MulticastFramesXmittedOK = c[SCNT_TX_PMAC_MC];
+		m->BroadcastFramesXmittedOK = c[SCNT_TX_PMAC_BC];
+		m->MulticastFramesReceivedOK = c[SCNT_RX_PMAC_MC];
+		m->BroadcastFramesReceivedOK = c[SCNT_RX_PMAC_BC];
+		m->InRangeLengthErrors = c[SCNT_RX_PMAC_FRAG] +
+					 c[SCNT_RX_PMAC_JABBER] +
+					 c[SCNT_RX_PMAC_CRC];
+		m->OutOfRangeLengthField = c[SCNT_RX_PMAC_SHORT] +
+					   c[SCNT_RX_PMAC_LONG];
+		m->FrameTooLongErrors = c[SCNT_RX_PMAC_LONG];
+		break;
+	default:
+		m->FramesTransmittedOK = c[SCNT_TX_UC] +
+					 c[SCNT_TX_MC] +
+					 c[SCNT_TX_BC] +
+					 c[SCNT_TX_PMAC_UC] +
+					 c[SCNT_TX_PMAC_MC] +
+					 c[SCNT_TX_PMAC_BC];
+		m->SingleCollisionFrames = c[SCNT_TX_COL];
+		m->FramesReceivedOK = c[SCNT_RX_UC] +
+				      c[SCNT_RX_MC] +
+				      c[SCNT_RX_BC] +
+				      c[SCNT_RX_PMAC_UC] +
+				      c[SCNT_RX_PMAC_MC] +
+				      c[SCNT_RX_PMAC_BC];
+		m->FrameCheckSequenceErrors = c[SCNT_RX_CRC] +
+					      c[SCNT_RX_PMAC_CRC];
+		m->OctetsTransmittedOK = c[SCNT_TX_OCT] +
+					 c[SCNT_TX_PMAC_OCT];
+		m->OctetsReceivedOK = c[SCNT_RX_OCT] +
+				      c[SCNT_RX_PMAC_OCT];
+		m->MulticastFramesXmittedOK = c[SCNT_TX_MC] +
+					      c[SCNT_TX_PMAC_MC];
+		m->BroadcastFramesXmittedOK = c[SCNT_TX_BC] +
+					      c[SCNT_TX_PMAC_BC];
+		m->MulticastFramesReceivedOK = c[SCNT_RX_MC] +
+					       c[SCNT_RX_PMAC_MC];
+		m->BroadcastFramesReceivedOK = c[SCNT_RX_BC] +
+					       c[SCNT_RX_PMAC_BC];
+		m->InRangeLengthErrors = c[SCNT_RX_FRAG] +
+					 c[SCNT_RX_JABBER] +
+					 c[SCNT_RX_CRC] +
+					 c[SCNT_RX_PMAC_FRAG] +
+					 c[SCNT_RX_PMAC_JABBER] +
+					 c[SCNT_RX_PMAC_CRC];
+		m->OutOfRangeLengthField = c[SCNT_RX_SHORT] +
+					   c[SCNT_RX_LONG] +
+					   c[SCNT_RX_PMAC_SHORT] +
+					   c[SCNT_RX_PMAC_LONG];
+		m->FrameTooLongErrors = c[SCNT_RX_LONG] +
+					c[SCNT_RX_PMAC_LONG];
+		break;
+	}
+
+	spin_unlock(&s->sw_lock);
+}
+
+static const struct ethtool_rmon_hist_range lan9645x_rmon_ranges[] = {
+	{    64,     64 },
+	{   65,    127 },
+	{  128,    255 },
+	{  256,    511 },
+	{  512,   1023 },
+	{ 1024,   1526 },
+	{ 1527, 0xffff },
+	{}
+};
+
+void
+lan9645x_stats_get_rmon_stats(struct lan9645x *lan9645x, int port,
+			      struct ethtool_rmon_stats *r,
+			      const struct ethtool_rmon_hist_range **ranges)
+{
+	struct lan9645x_stats *s = lan9645x->stats;
+	u64 *c;
+
+	c = lan9645x_stats_port_update(lan9645x, port);
+
+	spin_lock(&s->sw_lock);
+
+	switch (r->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		r->undersize_pkts = c[SCNT_RX_SHORT];
+		r->oversize_pkts = c[SCNT_RX_LONG];
+		r->fragments = c[SCNT_RX_FRAG];
+		r->jabbers = c[SCNT_RX_JABBER];
+		r->hist[0] = c[SCNT_RX_SZ_64];
+		r->hist[1] = c[SCNT_RX_SZ_65_127];
+		r->hist[2] = c[SCNT_RX_SZ_128_255];
+		r->hist[3] = c[SCNT_RX_SZ_256_511];
+		r->hist[4] = c[SCNT_RX_SZ_512_1023];
+		r->hist[5] = c[SCNT_RX_SZ_1024_1526];
+		r->hist[6] = c[SCNT_RX_SZ_JUMBO];
+		r->hist_tx[0] = c[SCNT_TX_SZ_64];
+		r->hist_tx[1] = c[SCNT_TX_SZ_65_127];
+		r->hist_tx[2] = c[SCNT_TX_SZ_128_255];
+		r->hist_tx[3] = c[SCNT_TX_SZ_256_511];
+		r->hist_tx[4] = c[SCNT_TX_SZ_512_1023];
+		r->hist_tx[5] = c[SCNT_TX_SZ_1024_1526];
+		r->hist_tx[6] = c[SCNT_TX_SZ_JUMBO];
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		r->undersize_pkts = c[SCNT_RX_PMAC_SHORT];
+		r->oversize_pkts = c[SCNT_RX_PMAC_LONG];
+		r->fragments = c[SCNT_RX_PMAC_FRAG];
+		r->jabbers = c[SCNT_RX_PMAC_JABBER];
+		r->hist[0] = c[SCNT_RX_PMAC_SZ_64];
+		r->hist[1] = c[SCNT_RX_PMAC_SZ_65_127];
+		r->hist[2] = c[SCNT_RX_PMAC_SZ_128_255];
+		r->hist[3] = c[SCNT_RX_PMAC_SZ_256_511];
+		r->hist[4] = c[SCNT_RX_PMAC_SZ_512_1023];
+		r->hist[5] = c[SCNT_RX_PMAC_SZ_1024_1526];
+		r->hist[6] = c[SCNT_RX_PMAC_SZ_JUMBO];
+		r->hist_tx[0] = c[SCNT_TX_PMAC_SZ_64];
+		r->hist_tx[1] = c[SCNT_TX_PMAC_SZ_65_127];
+		r->hist_tx[2] = c[SCNT_TX_PMAC_SZ_128_255];
+		r->hist_tx[3] = c[SCNT_TX_PMAC_SZ_256_511];
+		r->hist_tx[4] = c[SCNT_TX_PMAC_SZ_512_1023];
+		r->hist_tx[5] = c[SCNT_TX_PMAC_SZ_1024_1526];
+		r->hist_tx[6] = c[SCNT_TX_PMAC_SZ_JUMBO];
+		break;
+	default:
+		r->undersize_pkts = c[SCNT_RX_SHORT] +
+				    c[SCNT_RX_PMAC_SHORT];
+		r->oversize_pkts = c[SCNT_RX_LONG] +
+				   c[SCNT_RX_PMAC_LONG];
+		r->fragments = c[SCNT_RX_FRAG] +
+			       c[SCNT_RX_PMAC_FRAG];
+		r->jabbers = c[SCNT_RX_JABBER] +
+			     c[SCNT_RX_PMAC_JABBER];
+		r->hist[0] = c[SCNT_RX_SZ_64] +
+			     c[SCNT_RX_PMAC_SZ_64];
+		r->hist[1] = c[SCNT_RX_SZ_65_127] +
+			     c[SCNT_RX_PMAC_SZ_65_127];
+		r->hist[2] = c[SCNT_RX_SZ_128_255] +
+			     c[SCNT_RX_PMAC_SZ_128_255];
+		r->hist[3] = c[SCNT_RX_SZ_256_511] +
+			     c[SCNT_RX_PMAC_SZ_256_511];
+		r->hist[4] = c[SCNT_RX_SZ_512_1023] +
+			     c[SCNT_RX_PMAC_SZ_512_1023];
+		r->hist[5] = c[SCNT_RX_SZ_1024_1526] +
+			     c[SCNT_RX_PMAC_SZ_1024_1526];
+		r->hist[6] = c[SCNT_RX_SZ_JUMBO] +
+			     c[SCNT_RX_PMAC_SZ_JUMBO];
+		r->hist_tx[0] = c[SCNT_TX_SZ_64] +
+				c[SCNT_TX_PMAC_SZ_64];
+		r->hist_tx[1] = c[SCNT_TX_SZ_65_127] +
+				c[SCNT_TX_PMAC_SZ_65_127];
+		r->hist_tx[2] = c[SCNT_TX_SZ_128_255] +
+				c[SCNT_TX_PMAC_SZ_128_255];
+		r->hist_tx[3] = c[SCNT_TX_SZ_256_511] +
+				c[SCNT_TX_PMAC_SZ_256_511];
+		r->hist_tx[4] = c[SCNT_TX_SZ_512_1023] +
+				c[SCNT_TX_PMAC_SZ_512_1023];
+		r->hist_tx[5] = c[SCNT_TX_SZ_1024_1526] +
+				c[SCNT_TX_PMAC_SZ_1024_1526];
+		r->hist_tx[6] = c[SCNT_TX_SZ_JUMBO] +
+				c[SCNT_TX_PMAC_SZ_JUMBO];
+		break;
+	}
+
+	spin_unlock(&s->sw_lock);
+
+	*ranges = lan9645x_rmon_ranges;
+}
+
+/* Called in atomic context */
+void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
+				struct rtnl_link_stats64 *stats)
+{
+	struct lan9645x_stats *s = lan9645x->stats;
+	u64 *c;
+
+	c = STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
+
+	spin_lock(&s->sw_lock);
+
+	stats->rx_bytes = c[SCNT_RX_OCT] + c[SCNT_RX_PMAC_OCT];
+
+	stats->rx_packets = c[SCNT_RX_SHORT] +
+			    c[SCNT_RX_FRAG] +
+			    c[SCNT_RX_JABBER] +
+			    c[SCNT_RX_SZ_64] +
+			    c[SCNT_RX_SZ_65_127] +
+			    c[SCNT_RX_SZ_128_255] +
+			    c[SCNT_RX_SZ_256_511] +
+			    c[SCNT_RX_SZ_512_1023] +
+			    c[SCNT_RX_SZ_1024_1526] +
+			    c[SCNT_RX_SZ_JUMBO] +
+			    c[SCNT_RX_LONG] +
+			    c[SCNT_RX_PMAC_SHORT] +
+			    c[SCNT_RX_PMAC_FRAG] +
+			    c[SCNT_RX_PMAC_JABBER] +
+			    c[SCNT_RX_PMAC_SZ_64] +
+			    c[SCNT_RX_PMAC_SZ_65_127] +
+			    c[SCNT_RX_PMAC_SZ_128_255] +
+			    c[SCNT_RX_PMAC_SZ_256_511] +
+			    c[SCNT_RX_PMAC_SZ_512_1023] +
+			    c[SCNT_RX_PMAC_SZ_1024_1526] +
+			    c[SCNT_RX_PMAC_SZ_JUMBO];
+
+	stats->multicast = c[SCNT_RX_MC] + c[SCNT_RX_PMAC_MC];
+
+	stats->rx_errors = c[SCNT_RX_SHORT] +
+			   c[SCNT_RX_FRAG] +
+			   c[SCNT_RX_JABBER] +
+			   c[SCNT_RX_CRC] +
+			   c[SCNT_RX_SYMBOL_ERR] +
+			   c[SCNT_RX_LONG] +
+			   c[SCNT_RX_PMAC_SHORT] +
+			   c[SCNT_RX_PMAC_FRAG] +
+			   c[SCNT_RX_PMAC_JABBER] +
+			   c[SCNT_RX_PMAC_CRC] +
+			   c[SCNT_RX_PMAC_SYMBOL_ERR] +
+			   c[SCNT_RX_PMAC_LONG];
+
+	stats->rx_dropped = c[SCNT_RX_LONG] +
+			    c[SCNT_DR_LOCAL] +
+			    c[SCNT_DR_TAIL] +
+			    c[SCNT_RX_CAT_DROP] +
+			    c[SCNT_RX_RED_PRIO_0] +
+			    c[SCNT_RX_RED_PRIO_1] +
+			    c[SCNT_RX_RED_PRIO_2] +
+			    c[SCNT_RX_RED_PRIO_3] +
+			    c[SCNT_RX_RED_PRIO_4] +
+			    c[SCNT_RX_RED_PRIO_5] +
+			    c[SCNT_RX_RED_PRIO_6] +
+			    c[SCNT_RX_RED_PRIO_7];
+
+	for (int i = 0; i < LAN9645X_NUM_TC; i++) {
+		stats->rx_dropped += c[SCNT_DR_YELLOW_PRIO_0 + i] +
+				     c[SCNT_DR_GREEN_PRIO_0 + i];
+	}
+
+	stats->tx_bytes = c[SCNT_TX_OCT] + c[SCNT_TX_PMAC_OCT];
+
+	stats->tx_packets = c[SCNT_TX_SZ_64] +
+			    c[SCNT_TX_SZ_65_127] +
+			    c[SCNT_TX_SZ_128_255] +
+			    c[SCNT_TX_SZ_256_511] +
+			    c[SCNT_TX_SZ_512_1023] +
+			    c[SCNT_TX_SZ_1024_1526] +
+			    c[SCNT_TX_SZ_JUMBO] +
+			    c[SCNT_TX_PMAC_SZ_64] +
+			    c[SCNT_TX_PMAC_SZ_65_127] +
+			    c[SCNT_TX_PMAC_SZ_128_255] +
+			    c[SCNT_TX_PMAC_SZ_256_511] +
+			    c[SCNT_TX_PMAC_SZ_512_1023] +
+			    c[SCNT_TX_PMAC_SZ_1024_1526] +
+			    c[SCNT_TX_PMAC_SZ_JUMBO];
+
+	stats->tx_dropped = c[SCNT_TX_DROP] +
+			    c[SCNT_TX_AGED] +
+			    c[SCNT_TX_BUFDROP];
+
+	stats->collisions = c[SCNT_TX_COL];
+
+	spin_unlock(&s->sw_lock);
+}
+
+void lan9645x_stats_get_eth_phy_stats(struct lan9645x *lan9645x, int port,
+				      struct ethtool_eth_phy_stats *p)
+{
+	struct lan9645x_stats *s = lan9645x->stats;
+	u64 *c;
+
+	c = lan9645x_stats_port_update(lan9645x, port);
+
+	spin_lock(&s->sw_lock);
+
+	switch (p->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		p->SymbolErrorDuringCarrier = c[SCNT_RX_SYMBOL_ERR];
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		p->SymbolErrorDuringCarrier = c[SCNT_RX_PMAC_SYMBOL_ERR];
+		break;
+	default:
+		p->SymbolErrorDuringCarrier = c[SCNT_RX_SYMBOL_ERR] +
+					      c[SCNT_RX_PMAC_SYMBOL_ERR];
+		break;
+	}
+
+	spin_unlock(&s->sw_lock);
+}
+
+void
+lan9645x_stats_get_eth_ctrl_stats(struct lan9645x *lan9645x, int port,
+				  struct ethtool_eth_ctrl_stats *ctrl)
+{
+	struct lan9645x_stats *s = lan9645x->stats;
+	u64 *c;
+
+	c = lan9645x_stats_port_update(lan9645x, port);
+
+	spin_lock(&s->sw_lock);
+
+	switch (ctrl->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		ctrl->MACControlFramesReceived = c[SCNT_RX_CONTROL];
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		ctrl->MACControlFramesReceived = c[SCNT_RX_PMAC_CONTROL];
+		break;
+	default:
+		ctrl->MACControlFramesReceived = c[SCNT_RX_CONTROL] +
+						 c[SCNT_RX_PMAC_CONTROL];
+		break;
+	}
+
+	spin_unlock(&s->sw_lock);
+}
+
+void lan9645x_stats_get_pause_stats(struct lan9645x *lan9645x, int port,
+				    struct ethtool_pause_stats *ps)
+{
+	struct lan9645x_stats *s = lan9645x->stats;
+	u64 *c;
+
+	c = lan9645x_stats_port_update(lan9645x, port);
+
+	spin_lock(&s->sw_lock);
+
+	switch (ps->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		ps->tx_pause_frames = c[SCNT_TX_PAUSE];
+		ps->rx_pause_frames = c[SCNT_RX_PAUSE];
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		ps->tx_pause_frames = c[SCNT_TX_PMAC_PAUSE];
+		ps->rx_pause_frames = c[SCNT_RX_PMAC_PAUSE];
+		break;
+	default:
+		ps->tx_pause_frames = c[SCNT_TX_PAUSE] + c[SCNT_TX_PMAC_PAUSE];
+		ps->rx_pause_frames = c[SCNT_RX_PAUSE] + c[SCNT_RX_PMAC_PAUSE];
+		break;
+	}
+
+	spin_unlock(&s->sw_lock);
+}
+
+void lan9645x_stats_get_mm_stats(struct lan9645x *lan9645x, int port,
+				 struct ethtool_mm_stats *stats)
+{
+	struct lan9645x_stats *s = lan9645x->stats;
+	u64 *c;
+
+	c = lan9645x_stats_port_update(lan9645x, port);
+
+	spin_lock(&s->sw_lock);
+
+	stats->MACMergeFrameAssErrorCount = c[SCNT_RX_ASSEMBLY_ERR];
+	stats->MACMergeFrameSmdErrorCount = c[SCNT_RX_SMD_ERR];
+	stats->MACMergeFrameAssOkCount = c[SCNT_RX_ASSEMBLY_OK];
+	stats->MACMergeFragCountRx = c[SCNT_RX_MERGE_FRAG];
+	stats->MACMergeFragCountTx = c[SCNT_TX_MERGE_FRAG];
+	stats->MACMergeHoldCount = c[SCNT_TX_MM_HOLD];
+
+	spin_unlock(&s->sw_lock);
+}
+
+static void lan9645x_check_stats_work(struct work_struct *work)
+{
+	struct delayed_work *del_work = to_delayed_work(work);
+	struct lan9645x_stats *stats;
+
+	stats = container_of(del_work, struct lan9645x_stats, work);
+
+	lan9645x_stats_update(stats->lan9645x);
+
+	queue_delayed_work(stats->queue, &stats->work,
+			   LAN9645X_STATS_CHECK_DELAY);
+}
+
+static int lan9645x_stats_prepare_regions(struct lan9645x *lan9645x,
+					  struct lan9645x_view_stats *vstat)
+{
+	struct lan9645x_stat_region *regions;
+	const u32 *layout = vstat->layout;
+	size_t num_regions = 1;
+	int i;
+
+	for (i = 1; i < vstat->num_cnts; i++)
+		if (layout[i] != layout[i - 1] + 1)
+			num_regions++;
+
+	regions = devm_kcalloc(lan9645x->dev, num_regions, sizeof(*regions),
+			       GFP_KERNEL);
+	if (!regions)
+		return -ENOMEM;
+
+	vstat->num_regions = num_regions;
+	vstat->regions = regions;
+
+	regions[0].base_offset = layout[0];
+	regions[0].cnts_base_idx = 0;
+	regions[0].cnt = 1;
+
+	for (i = 1, num_regions = 0; i < vstat->num_cnts; i++) {
+		if (layout[i] != layout[i - 1] + 1) {
+			num_regions++;
+			regions[num_regions].base_offset = layout[i];
+			regions[num_regions].cnts_base_idx = i;
+			regions[num_regions].cnt = 1;
+		} else {
+			regions[num_regions].cnt++;
+		}
+	}
+
+	return 0;
+}
+
+static int lan9645x_view_stat_init(struct lan9645x *lan9645x,
+				   struct lan9645x_view_stats *vstat,
+				   const struct lan9645x_view_stats *cfg)
+{
+	size_t total = cfg->num_cnts * cfg->num_indexes;
+	int err;
+
+	memcpy(vstat, cfg, sizeof(*cfg));
+
+	vstat->cnts = devm_kcalloc(lan9645x->dev, total, sizeof(u64),
+				   GFP_KERNEL);
+	if (!vstat->cnts)
+		return -ENOMEM;
+
+	vstat->buf = devm_kcalloc(lan9645x->dev, total, sizeof(u32),
+				  GFP_KERNEL);
+	if (!vstat->buf)
+		return -ENOMEM;
+
+	err = lan9645x_stats_prepare_regions(lan9645x, vstat);
+	if (err)
+		return err;
+
+	vstat->stats = lan9645x->stats;
+
+	return 0;
+}
+
+int lan9645x_stats_alloc(struct lan9645x *lan9645x)
+{
+	const struct lan9645x_view_stats *vs;
+	struct lan9645x_stats *stats;
+	int err, i;
+
+	lan9645x->stats = devm_kzalloc(lan9645x->dev, sizeof(*stats),
+				       GFP_KERNEL);
+	if (!lan9645x->stats)
+		return -ENOMEM;
+
+	stats = lan9645x->stats;
+	stats->lan9645x = lan9645x;
+
+	for (i = 0; i < ARRAY_SIZE(lan9645x_view_stat_cfgs); i++) {
+		vs = &lan9645x_view_stat_cfgs[i];
+
+		if (!vs->num_cnts)
+			continue;
+
+		err = lan9645x_view_stat_init(lan9645x, &stats->view[vs->type],
+					      vs);
+		if (err)
+			return err;
+	}
+
+	stats->queue = alloc_ordered_workqueue("%s-stats", 0,
+					       dev_name(lan9645x->dev));
+	if (!stats->queue)
+		return -ENOMEM;
+
+	mutex_init(&stats->hw_lock);
+	spin_lock_init(&stats->sw_lock);
+	INIT_DELAYED_WORK(&stats->work, lan9645x_check_stats_work);
+
+	return 0;
+}
+
+void lan9645x_stats_free(struct lan9645x *lan9645x)
+{
+	cancel_delayed_work_sync(&lan9645x->stats->work);
+	destroy_workqueue(lan9645x->stats->queue);
+	mutex_destroy(&lan9645x->stats->hw_lock);
+}
+
+void lan9645x_stats_init(struct lan9645x *lan9645x)
+{
+	struct lan9645x_stats *stats = lan9645x->stats;
+
+	queue_delayed_work(stats->queue, &stats->work,
+			   LAN9645X_STATS_CHECK_DELAY);
+}
+
+void lan9645x_stats_deinit(struct lan9645x *lan9645x)
+{
+	cancel_delayed_work_sync(&lan9645x->stats->work);
+}
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.h
new file mode 100644
index 000000000000..cd5db16258a0
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.h
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#ifndef _LAN9645X_STATS_H_
+#define _LAN9645X_STATS_H_
+
+#include "lan9645x_main.h"
+
+#define STATS_INDEX(vstats, idx) (&(vstats)->cnts[(vstats)->num_cnts * (idx)])
+
+#define STAT_COUNTERS(lan9645x, type, idx) \
+	STATS_INDEX(lan9645x_get_vstats(lan9645x, type), idx)
+
+/* Counter indices into stat layout structs */
+#define SCNT_FRER_SID_IN_PKT             0
+#define SCNT_ISDX_GREEN_OCT              1
+#define SCNT_ISDX_GREEN_PKT              2
+#define SCNT_ISDX_YELLOW_OCT             3
+#define SCNT_ISDX_YELLOW_PKT             4
+#define SCNT_ISDX_RED_OCT                5
+#define SCNT_ISDX_RED_PKT                6
+#define SCNT_ISDX_DROP_GREEN_OCT         7
+#define SCNT_ISDX_DROP_GREEN_PKT         8
+#define SCNT_ISDX_DROP_YELLOW_OCT        9
+#define SCNT_ISDX_DROP_YELLOW_PKT        10
+
+#define SCNT_SF_MATCHING_FRAMES_COUNT    0
+#define SCNT_SF_NOT_PASSING_FRAMES_COUNT 1
+#define SCNT_SF_NOT_PASSING_SDU_COUNT    2
+#define SCNT_SF_RED_FRAMES_COUNT         3
+#define SCNT_SF_STREAM_BLOCK_COUNT       4
+
+#define SCNT_ESDX_GREEN_OCT              0
+#define SCNT_ESDX_GREEN_PKT              1
+#define SCNT_ESDX_YELLOW_OCT             2
+#define SCNT_ESDX_YELLOW_PKT             3
+
+#define SCNT_RX_OCT                      0
+#define SCNT_RX_UC                       1
+#define SCNT_RX_MC                       2
+#define SCNT_RX_BC                       3
+#define SCNT_RX_SHORT                    4
+#define SCNT_RX_FRAG                     5
+#define SCNT_RX_JABBER                   6
+#define SCNT_RX_CRC                      7
+#define SCNT_RX_SYMBOL_ERR               8
+#define SCNT_RX_SZ_64                    9
+#define SCNT_RX_SZ_65_127                10
+#define SCNT_RX_SZ_128_255               11
+#define SCNT_RX_SZ_256_511               12
+#define SCNT_RX_SZ_512_1023              13
+#define SCNT_RX_SZ_1024_1526             14
+#define SCNT_RX_SZ_JUMBO                 15
+#define SCNT_RX_PAUSE                    16
+#define SCNT_RX_CONTROL                  17
+#define SCNT_RX_LONG                     18
+#define SCNT_RX_CAT_DROP                 19
+#define SCNT_RX_RED_PRIO_0               20
+#define SCNT_RX_RED_PRIO_1               21
+#define SCNT_RX_RED_PRIO_2               22
+#define SCNT_RX_RED_PRIO_3               23
+#define SCNT_RX_RED_PRIO_4               24
+#define SCNT_RX_RED_PRIO_5               25
+#define SCNT_RX_RED_PRIO_6               26
+#define SCNT_RX_RED_PRIO_7               27
+#define SCNT_RX_YELLOW_PRIO_0            28
+#define SCNT_RX_YELLOW_PRIO_1            29
+#define SCNT_RX_YELLOW_PRIO_2            30
+#define SCNT_RX_YELLOW_PRIO_3            31
+#define SCNT_RX_YELLOW_PRIO_4            32
+#define SCNT_RX_YELLOW_PRIO_5            33
+#define SCNT_RX_YELLOW_PRIO_6            34
+#define SCNT_RX_YELLOW_PRIO_7            35
+#define SCNT_RX_GREEN_PRIO_0             36
+#define SCNT_RX_GREEN_PRIO_1             37
+#define SCNT_RX_GREEN_PRIO_2             38
+#define SCNT_RX_GREEN_PRIO_3             39
+#define SCNT_RX_GREEN_PRIO_4             40
+#define SCNT_RX_GREEN_PRIO_5             41
+#define SCNT_RX_GREEN_PRIO_6             42
+#define SCNT_RX_GREEN_PRIO_7             43
+#define SCNT_RX_ASSEMBLY_ERR             44
+#define SCNT_RX_SMD_ERR                  45
+#define SCNT_RX_ASSEMBLY_OK              46
+#define SCNT_RX_MERGE_FRAG               47
+#define SCNT_RX_PMAC_OCT                 48
+#define SCNT_RX_PMAC_UC                  49
+#define SCNT_RX_PMAC_MC                  50
+#define SCNT_RX_PMAC_BC                  51
+#define SCNT_RX_PMAC_SHORT               52
+#define SCNT_RX_PMAC_FRAG                53
+#define SCNT_RX_PMAC_JABBER              54
+#define SCNT_RX_PMAC_CRC                 55
+#define SCNT_RX_PMAC_SYMBOL_ERR          56
+#define SCNT_RX_PMAC_SZ_64               57
+#define SCNT_RX_PMAC_SZ_65_127           58
+#define SCNT_RX_PMAC_SZ_128_255          59
+#define SCNT_RX_PMAC_SZ_256_511          60
+#define SCNT_RX_PMAC_SZ_512_1023         61
+#define SCNT_RX_PMAC_SZ_1024_1526        62
+#define SCNT_RX_PMAC_SZ_JUMBO            63
+#define SCNT_RX_PMAC_PAUSE               64
+#define SCNT_RX_PMAC_CONTROL             65
+#define SCNT_RX_PMAC_LONG                66
+#define SCNT_TX_OCT                      67
+#define SCNT_TX_UC                       68
+#define SCNT_TX_MC                       69
+#define SCNT_TX_BC                       70
+#define SCNT_TX_COL                      71
+#define SCNT_TX_DROP                     72
+#define SCNT_TX_PAUSE                    73
+#define SCNT_TX_SZ_64                    74
+#define SCNT_TX_SZ_65_127                75
+#define SCNT_TX_SZ_128_255               76
+#define SCNT_TX_SZ_256_511               77
+#define SCNT_TX_SZ_512_1023              78
+#define SCNT_TX_SZ_1024_1526             79
+#define SCNT_TX_SZ_JUMBO                 80
+#define SCNT_TX_YELLOW_PRIO_0            81
+#define SCNT_TX_YELLOW_PRIO_1            82
+#define SCNT_TX_YELLOW_PRIO_2            83
+#define SCNT_TX_YELLOW_PRIO_3            84
+#define SCNT_TX_YELLOW_PRIO_4            85
+#define SCNT_TX_YELLOW_PRIO_5            86
+#define SCNT_TX_YELLOW_PRIO_6            87
+#define SCNT_TX_YELLOW_PRIO_7            88
+#define SCNT_TX_GREEN_PRIO_0             89
+#define SCNT_TX_GREEN_PRIO_1             90
+#define SCNT_TX_GREEN_PRIO_2             91
+#define SCNT_TX_GREEN_PRIO_3             92
+#define SCNT_TX_GREEN_PRIO_4             93
+#define SCNT_TX_GREEN_PRIO_5             94
+#define SCNT_TX_GREEN_PRIO_6             95
+#define SCNT_TX_GREEN_PRIO_7             96
+#define SCNT_TX_AGED                     97
+#define SCNT_TX_LLCT                     98
+#define SCNT_TX_CT                       99
+#define SCNT_TX_BUFDROP                  100
+#define SCNT_TX_MM_HOLD                  101
+#define SCNT_TX_MERGE_FRAG               102
+#define SCNT_TX_PMAC_OCT                 103
+#define SCNT_TX_PMAC_UC                  104
+#define SCNT_TX_PMAC_MC                  105
+#define SCNT_TX_PMAC_BC                  106
+#define SCNT_TX_PMAC_PAUSE               107
+#define SCNT_TX_PMAC_SZ_64               108
+#define SCNT_TX_PMAC_SZ_65_127           109
+#define SCNT_TX_PMAC_SZ_128_255          110
+#define SCNT_TX_PMAC_SZ_256_511          111
+#define SCNT_TX_PMAC_SZ_512_1023         112
+#define SCNT_TX_PMAC_SZ_1024_1526        113
+#define SCNT_TX_PMAC_SZ_JUMBO            114
+#define SCNT_DR_LOCAL                    115
+#define SCNT_DR_TAIL                     116
+#define SCNT_DR_YELLOW_PRIO_0            117
+#define SCNT_DR_YELLOW_PRIO_1            118
+#define SCNT_DR_YELLOW_PRIO_2            119
+#define SCNT_DR_YELLOW_PRIO_3            120
+#define SCNT_DR_YELLOW_PRIO_4            121
+#define SCNT_DR_YELLOW_PRIO_5            122
+#define SCNT_DR_YELLOW_PRIO_6            123
+#define SCNT_DR_YELLOW_PRIO_7            124
+#define SCNT_DR_GREEN_PRIO_0             125
+#define SCNT_DR_GREEN_PRIO_1             126
+#define SCNT_DR_GREEN_PRIO_2             127
+#define SCNT_DR_GREEN_PRIO_3             128
+#define SCNT_DR_GREEN_PRIO_4             129
+#define SCNT_DR_GREEN_PRIO_5             130
+#define SCNT_DR_GREEN_PRIO_6             131
+#define SCNT_DR_GREEN_PRIO_7             132
+
+enum lan9645x_view_stat_type {
+	LAN9645X_STAT_PORTS = 0,
+	LAN9645X_STAT_ISDX,
+	LAN9645X_STAT_ESDX,
+	LAN9645X_STAT_SFID,
+
+	LAN9645X_STAT_NUM,
+};
+
+struct lan9645x_stat_region {
+	u32 base_offset;
+	u32 cnt;
+	u32 cnts_base_idx;
+};
+
+/* Counters are organized by indices/views such as
+ *
+ * - physical ports
+ * - isdx
+ * - esdx
+ * - frer
+ * - sfid
+ *
+ * Each view contains regions, which is a linear address range of related
+ * stats. I.e. the ports index has RX, TX and Drop regions.
+ *
+ *
+ * and you have a given counter replicated per index.
+ */
+struct lan9645x_view_stats {
+	/* HW register offsets indexed by SCNT_*, used for bulk reading */
+	const u32 *layout;
+	/* Region description for this view, used for bulk reading */
+	struct lan9645x_stat_region *regions;
+	struct lan9645x_stats *stats;
+	char name[16];
+	/* 64bit software counters with the same addr layout hw */
+	u64 *cnts;
+	/* Buffer for bulk reading counter regions from hw */
+	u32 *buf;
+	/* Number of counters per index in view */
+	u32 num_cnts;
+	/* Number of indexes in view */
+	u32 num_indexes;
+	/* Number of counter regions with counters at sequential addresses */
+	size_t num_regions;
+	enum lan9645x_view_stat_type type;
+};
+
+struct lan9645x_stats {
+	struct lan9645x *lan9645x;
+	struct mutex hw_lock; /* lock r/w to stat registers and u32 buf */
+	spinlock_t sw_lock; /* lock access to u64 software counters */
+	struct delayed_work work;
+	struct workqueue_struct *queue;
+
+	struct lan9645x_view_stats view[LAN9645X_STAT_NUM];
+};
+
+static inline struct lan9645x_view_stats *
+lan9645x_get_vstats(struct lan9645x *lan9645x,
+		    enum lan9645x_view_stat_type type)
+{
+	if (WARN_ON(!(type < LAN9645X_STAT_NUM)))
+		return NULL;
+
+	return &lan9645x->stats->view[type];
+}
+
+/* Add a possibly wrapping 32 bit value to a 64 bit counter */
+static inline void lan9645x_stats_add_cnt(u64 *cnt, u32 val)
+{
+	if (val < (*cnt & U32_MAX))
+		*cnt += (u64)1 << 32; /* value has wrapped */
+
+	*cnt = (*cnt & ~(u64)U32_MAX) + val;
+}
+
+int lan9645x_stats_alloc(struct lan9645x *lan9645x);
+void lan9645x_stats_free(struct lan9645x *lan9645x);
+void lan9645x_stats_init(struct lan9645x *lan9645x);
+void lan9645x_stats_deinit(struct lan9645x *lan9645x);
+void lan9645x_stats_get_strings(struct lan9645x *lan9645x, int port,
+				u32 stringset, u8 *data);
+int lan9645x_stats_get_sset_count(struct lan9645x *lan9645x, int port,
+				  int sset);
+void lan9645x_stats_get_ethtool_stats(struct lan9645x *lan9645x, int port,
+				      uint64_t *data);
+void lan9645x_stats_get_eth_mac_stats(struct lan9645x *lan9645x, int port,
+				      struct ethtool_eth_mac_stats *mac_stats);
+void
+lan9645x_stats_get_rmon_stats(struct lan9645x *lan9645x, int port,
+			      struct ethtool_rmon_stats *rmon_stats,
+			      const struct ethtool_rmon_hist_range **ranges);
+void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
+				struct rtnl_link_stats64 *s);
+void lan9645x_stats_get_mm_stats(struct lan9645x *lan9645x, int port,
+				 struct ethtool_mm_stats *stats);
+void lan9645x_stats_get_pause_stats(struct lan9645x *lan9645x, int port,
+				    struct ethtool_pause_stats *ps);
+void
+lan9645x_stats_get_eth_ctrl_stats(struct lan9645x *lan9645x, int port,
+				  struct ethtool_eth_ctrl_stats *ctrl_stats);
+void lan9645x_stats_get_eth_phy_stats(struct lan9645x *lan9645x, int port,
+				      struct ethtool_eth_phy_stats *phy_stats);
+
+#endif

-- 
2.52.0


