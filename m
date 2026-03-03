Return-Path: <netdev+bounces-263182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI3FDy/WpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:38:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4301EF908
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A6D31A5B53
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015A346771;
	Tue,  3 Mar 2026 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uPcbL5+i"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C934166B;
	Tue,  3 Mar 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540635; cv=none; b=aDuEQ/S/9ap42rcY749vaSH+aZ0kz9FokS0XpQCcDfz1t4UB0DrX8UQUsvQUhVVgauU77x7rO3q/QMSSV0TPYcPhDalZApQfceY5CIVSP/O6YwYB37ln3xMuuwQ1jnFlG+G05YMUDXR+ujHqpvbxCR2gN6VyNxTo37syL4HG6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540635; c=relaxed/simple;
	bh=6gY/3GJ71nC/t7X/f+/yO24DwoyDakN/VEsJUd2APaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jbxNkU8Q98LidvoETYrAPf+5mVlm/OYjRoCtri1OFh2RstAi9QXlL5KKQzINVoOMl1yny/+QlAp+ac6p2V6vAsB1Z5J4PQYp313DJL6GliDqtsDdXms8oL9nvJDETTarWdiymvAaV4+GJaYWG2vXcNTOHxUbCoDlVEgjgd0dzO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uPcbL5+i; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772540632; x=1804076632;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6gY/3GJ71nC/t7X/f+/yO24DwoyDakN/VEsJUd2APaw=;
  b=uPcbL5+iNVMne1nA0sAOxiIrrfWwe//0SlA9SnnNyx0Ol+UjfKdHfanB
   ZKlQbfJqZ+aolMEvWi+YgedAyYgC8bNFFxFjQOnid7DSxsMJM0yvwCF/X
   GYk7PVooUIAQUsjGH6y2m3jUqDP+ylJUIAqDjoiZPhCaza7a6vV5pB6Ju
   WLGrrxCtqXg9Az4a16zRM515ZSNXcI1ol/NOmlXMaHdzYm6tLA3sQTVtl
   LvHEq3jdNt4Nnt0AWvO07UpMHa6dj9IsZolqAJcluas7KNtznGmY2PY7N
   OJBf+mKAAODFc5Wuo78n9fyZNYupeIzUo7s1yzAb8aef8mcsq0mJSBUFo
   g==;
X-CSE-ConnectionGUID: kEh2OTZzQEmVJ8+VJRukVw==
X-CSE-MsgGUID: 31EdL1SjQdipESAi9qrG1A==
X-IronPort-AV: E=Sophos;i="6.21,321,1763449200"; 
   d="scan'208";a="54568220"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 05:23:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 3 Mar 2026 05:23:33 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Mar 2026 05:23:30 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 3 Mar 2026 13:22:30 +0100
Subject: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver for
 LAN9645X
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260303-dsa_lan9645x_switch_driver_base-v1-4-bff8ca1396f5@microchip.com>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
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
X-Rspamd-Queue-Id: 6B4301EF908
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263182-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add the LAN9645X basic DSA driver with initialization, parent regmap
requests, port module initialization for NPI, CPU ports and front ports,
and phylink integration for MAC side configuration.

IPv6 is disabled on the conduit. When enabled, the RFC 4861 frames are
dispatched directly on the conduit bypassing the tag driver. The switch
parses these frames as if they have an IFH prepended, leading to a
garbage in garbage out situation. Therefore, IPv6 on the conduit is not
a sensible configuration.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/dsa/microchip/Makefile                 |   1 +
 drivers/net/dsa/microchip/lan9645x/Kconfig         |  12 +
 drivers/net/dsa/microchip/lan9645x/Makefile        |   7 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 435 +++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h | 396 +++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c  |  99 ++++
 .../net/dsa/microchip/lan9645x/lan9645x_phylink.c  | 537 +++++++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c | 289 +++++++++++
 drivers/net/ethernet/microchip/Kconfig             |   1 +
 9 files changed, 1777 insertions(+)

diff --git a/drivers/net/dsa/microchip/Makefile b/drivers/net/dsa/microchip/Makefile
index 9347cfb3d0b5..e75f17888f75 100644
--- a/drivers/net/dsa/microchip/Makefile
+++ b/drivers/net/dsa/microchip/Makefile
@@ -12,3 +12,4 @@ endif
 obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C)	+= ksz9477_i2c.o
 obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ_SPI)		+= ksz_spi.o
 obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ8863_SMI)	+= ksz8863_smi.o
+obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X)	+= lan9645x/
diff --git a/drivers/net/dsa/microchip/lan9645x/Kconfig b/drivers/net/dsa/microchip/lan9645x/Kconfig
new file mode 100644
index 000000000000..8cbac1f9875d
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NET_DSA_MICROCHIP_LAN9645X
+	tristate "Microchip Lan9645x switch support"
+	depends on NET_DSA
+	depends on NET_VENDOR_MICROCHIP
+	select NET_DSA_TAG_LAN9645X
+	help
+	  This driver adds DSA support for Microchip Lan9645x switch chips.
+	  The lan9645x switch is a multi-port Gigabit AVB/TSN Ethernet Switch
+	  with five integrated 10/100/1000Base-T PHYs. In addition to the
+	  integrated PHYs, it supports up to 2 RGMII/RMII, up to 2
+	  BASE-X/SERDES/2.5GBASE-X and one Quad-SGMII/Quad-USGMII interfaces.
diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
new file mode 100644
index 000000000000..eea1edc5c0e3
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X) += mchp-lan9645x.o
+
+mchp-lan9645x-objs := lan9645x_main.o \
+	lan9645x_npi.o \
+	lan9645x_port.o \
+	lan9645x_phylink.o \
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
new file mode 100644
index 000000000000..739013f049d0
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+
+#include "lan9645x_main.h"
+
+static const char *lan9645x_resource_names[NUM_TARGETS + 1] = {
+	[TARGET_GCB]          = "gcb",
+	[TARGET_QS]           = "qs",
+	[TARGET_CHIP_TOP]     = "chip_top",
+	[TARGET_REW]          = "rew",
+	[TARGET_SYS]          = "sys",
+	[TARGET_HSIO]         = "hsio",
+	[TARGET_DEV]          = "dev",
+	[TARGET_DEV + 1]      = "dev1",
+	[TARGET_DEV + 2]      = "dev2",
+	[TARGET_DEV + 3]      = "dev3",
+	[TARGET_DEV + 4]      = "dev4",
+	[TARGET_DEV + 5]      = "dev5",
+	[TARGET_DEV + 6]      = "dev6",
+	[TARGET_DEV + 7]      = "dev7",
+	[TARGET_DEV + 8]      = "dev8",
+	[TARGET_QSYS]         = "qsys",
+	[TARGET_AFI]          = "afi",
+	[TARGET_ANA]          = "ana",
+	[NUM_TARGETS]         = NULL,
+};
+
+static int lan9645x_tag_npi_setup(struct dsa_switch *ds)
+{
+	struct dsa_port *dp, *first_cpu_dp = NULL;
+	struct lan9645x *lan9645x = ds->priv;
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		if (first_cpu_dp && dp->cpu_dp != first_cpu_dp) {
+			dev_err(ds->dev, "Multiple NPI ports not supported\n");
+			return -EINVAL;
+		}
+
+		first_cpu_dp = dp->cpu_dp;
+	}
+
+	if (!first_cpu_dp)
+		return -EINVAL;
+
+	lan9645x_npi_port_init(lan9645x, first_cpu_dp);
+
+	return 0;
+}
+
+static enum dsa_tag_protocol lan9645x_get_tag_protocol(struct dsa_switch *ds,
+						       int port,
+						       enum dsa_tag_protocol tp)
+{
+	struct lan9645x *lan9645x = ds->priv;
+
+	return lan9645x->tag_proto;
+}
+
+static int lan9645x_connect_tag_protocol(struct dsa_switch *ds,
+					 enum dsa_tag_protocol proto)
+{
+	switch (proto) {
+	case DSA_TAG_PROTO_LAN9645X:
+		return 0;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+}
+
+static void lan9645x_teardown(struct dsa_switch *ds)
+{
+	struct lan9645x *lan9645x = ds->priv;
+
+	debugfs_remove_recursive(lan9645x->debugfs_root);
+	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
+}
+
+static int lan9645x_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
+{
+	return lan9645x_port_set_maxlen(ds->priv, port, new_mtu);
+}
+
+static int lan9645x_get_max_mtu(struct dsa_switch *ds, int port)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	int max_mtu;
+
+	/* Actual MAC max MTU is around 16KB. We set 10000 - overhead which
+	 * should be sufficient for all jumbo frames. Larger frames can cause
+	 * problems especially with flow control, since we only have 160K queue
+	 * buffer.
+	 */
+	max_mtu = 10000 - ETH_HLEN - ETH_FCS_LEN;
+
+	if (port == lan9645x->npi) {
+		max_mtu -= LAN9645X_IFH_LEN;
+		max_mtu -= LAN9645X_LONG_PREFIX_LEN;
+	}
+
+	return max_mtu;
+}
+
+static int lan9645x_reset_switch(struct lan9645x *lan9645x)
+{
+	int val = 0;
+	int err;
+
+	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan9645x, SYS_RESET_CFG);
+	lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan9645x, SYS_RAM_INIT);
+	err = lan9645x_rd_poll_timeout(lan9645x, SYS_RAM_INIT, val,
+				       SYS_RAM_INIT_RAM_INIT_GET(val) == 0);
+	if (err) {
+		dev_err(lan9645x->dev, "Lan9645x setup: failed to init chip RAM.");
+		return err;
+	}
+	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(1), lan9645x, SYS_RESET_CFG);
+
+	return 0;
+}
+
+static int lan9645x_setup(struct dsa_switch *ds)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct device *dev = lan9645x->dev;
+	struct dsa_port *dp;
+	u32 all_phys_ports;
+	int err = 0;
+
+	lan9645x->num_phys_ports = ds->num_ports;
+	all_phys_ports = GENMASK(lan9645x->num_phys_ports - 1, 0);
+
+	err = lan9645x_reset_switch(lan9645x);
+	if (err)
+		return err;
+
+	lan9645x->debugfs_root = debugfs_create_dir("lan9645x_sw", NULL);
+
+	lan9645x->ports = devm_kcalloc(lan9645x->dev, lan9645x->num_phys_ports,
+				       sizeof(struct lan9645x_port *),
+				       GFP_KERNEL);
+	if (!lan9645x->ports)
+		return -ENOMEM;
+
+	for (int port = 0; port < lan9645x->num_phys_ports; port++) {
+		struct lan9645x_port *p;
+
+		p = devm_kzalloc(lan9645x->dev,
+				 sizeof(struct lan9645x_port), GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+
+		p->lan9645x = lan9645x;
+		p->chip_port = port;
+		lan9645x->ports[port] = p;
+	}
+
+	err = lan9645x_port_parse_ports_node(lan9645x);
+	if (err) {
+		dev_err(dev, "Lan9645x setup: failed to parse ports node.");
+		return err;
+	}
+
+	err = lan9645x_tag_npi_setup(ds);
+	if (err) {
+		dev_err(dev, "Lan9645x setup: failed to setup NPI port.\n");
+		return err;
+	}
+
+	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
+	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
+	       ANA_AGGR_CFG_AC_DMAC_ENA,
+	       lan9645x, ANA_AGGR_CFG);
+
+	/* Flush queues */
+	lan_wr(GENMASK(1, 0), lan9645x, QS_XTR_FLUSH);
+
+	/* Allow to drain */
+	mdelay(1);
+
+	/* All Queues normal */
+	lan_wr(0x0, lan9645x, QS_XTR_FLUSH);
+
+	/* Set MAC age time to default value, the entry is aged after
+	 * 2 * AGE_PERIOD
+	 */
+	lan_wr(ANA_AUTOAGE_AGE_PERIOD_SET(BR_DEFAULT_AGEING_TIME / 2 / HZ),
+	       lan9645x, ANA_AUTOAGE);
+
+	/* Disable learning for frames discarded by VLAN ingress filtering */
+	lan_rmw(ANA_ADVLEARN_VLAN_CHK_SET(1),
+		ANA_ADVLEARN_VLAN_CHK,
+		lan9645x, ANA_ADVLEARN);
+
+	/* Queue system frame ageing. We target 2s ageing.
+	 *
+	 * Register unit is 1024 cycles.
+	 *
+	 * ASIC: 165.625 Mhz  ~ 6.0377 ns period
+	 *
+	 * 1024 * 6.0377 ns =~ 6182 ns
+	 * val = 2000000000ns / 6182ns
+	 */
+	lan_wr(SYS_FRM_AGING_AGE_TX_ENA_SET(1) |
+	       SYS_FRM_AGING_MAX_AGE_SET((2000000000 / 6182)),
+	       lan9645x,  SYS_FRM_AGING);
+
+	/* Setup flooding PGIDs for IPv4/IPv6 multicast. Control and dataplane
+	 * use the same masks. Control frames are redirected to CPU, and
+	 * the network stack is responsible for forwarding these.
+	 * The dataplane is forwarding according to the offloaded MDB entries.
+	 */
+	lan_wr(ANA_FLOODING_IPMC_FLD_MC4_DATA_SET(PGID_MCIPV4) |
+	       ANA_FLOODING_IPMC_FLD_MC4_CTRL_SET(PGID_MC) |
+	       ANA_FLOODING_IPMC_FLD_MC6_DATA_SET(PGID_MCIPV6) |
+	       ANA_FLOODING_IPMC_FLD_MC6_CTRL_SET(PGID_MC),
+	       lan9645x, ANA_FLOODING_IPMC);
+
+	/* There are 8 priorities */
+	for (int prio = 0; prio < 8; ++prio)
+		lan_wr(ANA_FLOODING_FLD_MULTICAST_SET(PGID_MC) |
+		       ANA_FLOODING_FLD_UNICAST_SET(PGID_UC) |
+		       ANA_FLOODING_FLD_BROADCAST_SET(PGID_BC),
+		       lan9645x, ANA_FLOODING(prio));
+
+	/* Set all the entries to obey VLAN. */
+	for (int i = 0; i < PGID_ENTRIES; ++i)
+		lan_wr(ANA_PGID_CFG_OBEY_VLAN_SET(1),
+		       lan9645x, ANA_PGID_CFG(i));
+
+	/* Disable bridging by default */
+	for (int p = 0; p < lan9645x->num_phys_ports; p++) {
+		lan_wr(0, lan9645x, ANA_PGID(PGID_SRC + p));
+
+		/* Do not forward BPDU frames to the front ports and copy them
+		 * to CPU
+		 */
+		lan_wr(ANA_CPU_FWD_BPDU_CFG_BPDU_REDIR_ENA,
+		       lan9645x, ANA_CPU_FWD_BPDU_CFG(p));
+	}
+
+	/* Set source buffer size for each priority and port to ~1700 bytes */
+	for (int i = 0; i <= QSYS_Q_RSRV; ++i) {
+		lan_wr(QS_SRC_BUF_RSV / 64, lan9645x, QSYS_RES_CFG(i));
+		lan_wr(QS_SRC_BUF_RSV / 64, lan9645x, QSYS_RES_CFG(512 + i));
+	}
+
+	/* Configure and enable the CPU port */
+	lan9645x_port_cpu_init(lan9645x);
+
+	/* Multicast to all front ports */
+	lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MC));
+
+	/* IP multicast to all front ports */
+	lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MCIPV4));
+	lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MCIPV6));
+
+	/* Unicast to all front ports */
+	lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_UC));
+
+	/* Broadcast to all ports */
+	lan_wr(BIT(CPU_PORT) | all_phys_ports, lan9645x, ANA_PGID(PGID_BC));
+
+	dsa_switch_for_each_available_port(dp, ds)
+		lan9645x_port_init(lan9645x, dp->index);
+
+	lan9645x_port_set_tail_drop_wm(lan9645x);
+
+	ds->mtu_enforcement_ingress = true;
+	ds->assisted_learning_on_cpu_port = true;
+	ds->fdb_isolation = true;
+
+	dev_info(lan9645x->dev,
+		 "Setup complete. SKU features: tsn_dis=%d hsr_dis=%d max_ports=%d",
+		 lan9645x->tsn_dis, lan9645x->dd_dis,
+		 lan9645x->num_phys_ports - lan9645x->num_port_dis);
+
+	return 0;
+}
+
+static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
+					   struct phylink_config *config)
+{
+	lan9645x_phylink_get_caps(ds->priv, port, config);
+}
+
+static const struct dsa_switch_ops lan9645x_switch_ops = {
+	.get_tag_protocol		= lan9645x_get_tag_protocol,
+	.connect_tag_protocol		= lan9645x_connect_tag_protocol,
+
+	.setup				= lan9645x_setup,
+	.teardown			= lan9645x_teardown,
+
+	/* Phylink integration */
+	.phylink_get_caps		= lan9645x_port_phylink_get_caps,
+
+	/* MTU  */
+	.port_change_mtu		= lan9645x_change_mtu,
+	.port_max_mtu			= lan9645x_get_max_mtu,
+};
+
+static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
+{
+	const char *resource_name;
+	struct regmap *tgt_map;
+
+	for (int i = 0; i < NUM_TARGETS; i++) {
+		resource_name = lan9645x_resource_names[i];
+		if (!resource_name)
+			continue;
+
+		tgt_map = dev_get_regmap(lan9645x->dev->parent, resource_name);
+		if (IS_ERR_OR_NULL(tgt_map)) {
+			dev_err(lan9645x->dev, "Failed to get regmap=%d", i);
+			return -ENODEV;
+		}
+
+		lan9645x->rmap[i] = tgt_map;
+	}
+
+	return 0;
+}
+
+static void lan9645x_set_feat_dis(struct lan9645x *lan9645x)
+{
+	u32 feat_dis;
+
+	/* The features which can be physically disabled on some SKUs are:
+	 * 1) Number of ports can be 5, 7 or 9. Any ports can be used, the chip
+	 *    tracks how many are active.
+	 * 2) HSR/PRP. The duplicate discard table can be disabled.
+	 * 3) TAS, frame preemption and PSFP can be disabled.
+	 */
+	feat_dis = lan_rd(lan9645x, GCB_FEAT_DISABLE);
+
+	lan9645x->num_port_dis =
+		GCB_FEAT_DISABLE_FEAT_NUM_PORTS_DIS_GET(feat_dis);
+	lan9645x->dd_dis = GCB_FEAT_DISABLE_FEAT_DD_DIS_GET(feat_dis);
+	lan9645x->tsn_dis = GCB_FEAT_DISABLE_FEAT_TSN_DIS_GET(feat_dis);
+}
+
+static int lan9645x_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lan9645x *lan9645x;
+	struct dsa_switch *ds;
+	int err = 0;
+
+	lan9645x = devm_kzalloc(dev, sizeof(*lan9645x), GFP_KERNEL);
+	if (!lan9645x)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed to allocate LAN9645X");
+
+	dev_set_drvdata(dev, lan9645x);
+	lan9645x->dev = dev;
+
+	err = lan9645x_request_target_regmaps(lan9645x);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to request regmaps");
+
+	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
+	if (!ds)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed to allocate DSA switch");
+
+	ds->dev = dev;
+	ds->num_ports = NUM_PHYS_PORTS;
+	ds->num_tx_queues = NUM_PRIO_QUEUES;
+	ds->dscp_prio_mapping_is_global = true;
+
+	ds->ops = &lan9645x_switch_ops;
+	ds->phylink_mac_ops = &lan9645x_phylink_mac_ops;
+	ds->priv = lan9645x;
+
+	lan9645x->ds = ds;
+	lan9645x->tag_proto = DSA_TAG_PROTO_LAN9645X;
+	lan9645x->shared_queue_sz = LAN9645X_BUFFER_MEMORY;
+
+	lan9645x_set_feat_dis(lan9645x);
+
+	err = dsa_register_switch(ds);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register DSA switch");
+
+	return 0;
+}
+
+static void lan9645x_remove(struct platform_device *pdev)
+{
+	struct lan9645x *lan9645x = dev_get_drvdata(&pdev->dev);
+
+	if (!lan9645x)
+		return;
+
+	/* Calls lan9645x DSA .teardown */
+	dsa_unregister_switch(lan9645x->ds);
+	dev_set_drvdata(&pdev->dev, NULL);
+}
+
+static void lan9645x_shutdown(struct platform_device *pdev)
+{
+	struct lan9645x *lan9645x = dev_get_drvdata(&pdev->dev);
+
+	if (!lan9645x)
+		return;
+
+	dsa_switch_shutdown(lan9645x->ds);
+
+	dev_set_drvdata(&pdev->dev, NULL);
+}
+
+static const struct of_device_id lan9645x_switch_of_match[] = {
+	{ .compatible = "microchip,lan96455s-switch" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, lan9645x_switch_of_match);
+
+static struct platform_driver lan9645x_switch_driver = {
+	.driver = {
+		.name = "lan96455s-switch",
+		.of_match_table = lan9645x_switch_of_match,
+	},
+	.probe = lan9645x_probe,
+	.remove = lan9645x_remove,
+	.shutdown = lan9645x_shutdown,
+};
+module_platform_driver(lan9645x_switch_driver);
+
+MODULE_DESCRIPTION("Lan9645x Switch Driver");
+MODULE_AUTHOR("Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
new file mode 100644
index 000000000000..a51b637f28bf
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -0,0 +1,396 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#ifndef __LAN9645X_MAIN_H__
+#define __LAN9645X_MAIN_H__
+
+#include <linux/dsa/lan9645x.h>
+#include <linux/regmap.h>
+#include <net/dsa.h>
+
+#include "lan9645x_regs.h"
+
+#define lan9645x_for_each_chipport(_lan9645x, _i) \
+	for ((_i) = 0; (_i) < (_lan9645x)->num_phys_ports; (_i)++)
+
+/* Ports 0-8 are front ports
+ * Ports 9-10 are CPU ports
+ *
+ * CPU ports are logical ports in the chip intended for management. The frame
+ * delivery mechanism can vary: direct register injection/extraction or one can
+ * use a front port as CPU port, called a Node Processor Interface (NPI).
+ *
+ * This is the approach used by LAN9645X.
+ */
+#define NUM_PHYS_PORTS		9
+#define CPU_PORT		9
+#define NUM_PRIO_QUEUES		8
+#define LAN9645X_NUM_TC		8
+
+#define QS_SRC_BUF_RSV		1700
+
+/* Reserved amount for (SRC, PRIO) at index 8*SRC + PRIO
+ * See QSYS:RES_CTRL[*]:RES_CFG description
+ */
+#define QSYS_Q_RSRV			95
+
+#define LAN9645X_ISDX_MAX		128
+#define LAN9645X_ESDX_MAX		128
+#define LAN9645X_SFID_MAX		128
+
+/* Reserved VLAN IDs. */
+#define UNAWARE_PVID			0
+#define HOST_PVID			4095
+#define VLAN_HSR_PRP			4094
+#define VLAN_MAX			(VLAN_HSR_PRP - 1)
+
+/* VLAN flags for VLAN table defined in ANA_VLANTIDX */
+#define VLAN_SRC_CHK		0x01
+#define VLAN_MIR		0x02
+#define VLAN_LRN_DIS		0x04
+#define VLAN_PRV_VLAN		0x08
+#define VLAN_FLD_DIS		0x10
+#define VLAN_S_FWD_ENA		0x20
+
+/* 160KiB / 1.25Mbit */
+#define LAN9645X_BUFFER_MEMORY	(160 * 1024)
+
+/* Port Group Identifiers (PGID) are port-masks applied to all frames.
+ * The replicated registers are organized like so in HW:
+ *
+ * 0-63:         Destination analysis
+ * 64-79:        Aggregation analysis
+ * 80-(80+10-1): Source port analysis
+ *
+ * Destination: By default the first 9 port masks == BIT(port_num). Never change
+ * these except for aggregation. Remaining dst masks are for L2 MC and
+ * flooding. (See FLOODING and FLOODING_IPMC).
+ *
+ * Aggregation: Used to pick a port within an aggregation group. If no
+ * aggregation is configured, these are all-ones.
+ *
+ * Source: Control which ports a given source port can forward to. A frame that
+ * is received on port n, uses mask 80+n as a mask to filter out destination
+ * ports. The default values are that all bits are set except for the index
+ * number (no loopback).
+ *
+ * We reserve destination PGIDs at the end of the range.
+ */
+
+#define PGID_AGGR			64
+#define PGID_SRC			80
+#define PGID_ENTRIES			89
+
+#define PGID_AGGR_NUM			(PGID_SRC - PGID_AGGR)
+
+/* General purpose PGIDs. */
+#define PGID_GP_START			CPU_PORT
+#define PGID_GP_END			PGID_MRP
+
+/* Reserved PGIDs.
+ * PGID_MRP is a blackhole PGID
+ */
+#define PGID_MRP			(PGID_AGGR - 7)
+#define PGID_CPU			(PGID_AGGR - 6)
+#define PGID_UC				(PGID_AGGR - 5)
+#define PGID_BC				(PGID_AGGR - 4)
+#define PGID_MC				(PGID_AGGR - 3)
+#define PGID_MCIPV4			(PGID_AGGR - 2)
+#define PGID_MCIPV6			(PGID_AGGR - 1)
+
+/* Flooding PGIDS:
+ * PGID_UC
+ * PGID_MC*
+ * PGID_BC
+ *
+ */
+
+#define RD_SLEEP_US			3
+#define RD_SLEEPTIMEOUT_US		100000
+#define SLOW_RD_SLEEP_US		1000
+#define SLOW_RD_SLEEPTIMEOUT_US		2000000
+
+#define lan9645x_rd_poll_timeout(_lan9645x, _reg_macro, _val, _cond)     \
+	regmap_read_poll_timeout(lan_rmap((_lan9645x), _reg_macro),	\
+				 lan_rel_addr(_reg_macro), (_val),	\
+				 (_cond), RD_SLEEP_US, RD_SLEEPTIMEOUT_US)
+
+#define lan9645x_rd_poll_slow(_lan9645x, _reg_macro, _val, _cond)	\
+	regmap_read_poll_timeout(lan_rmap((_lan9645x), _reg_macro),	\
+				 lan_rel_addr(_reg_macro), (_val),	\
+				 (_cond), SLOW_RD_SLEEP_US,		\
+				 SLOW_RD_SLEEPTIMEOUT_US)
+
+/* NPI port prefix config encoding
+ *
+ * 0: No CPU extraction header (normal frames)
+ * 1: CPU extraction header without prefix
+ * 2: CPU extraction header with short prefix
+ * 3: CPU extraction header with long prefix
+ */
+enum lan9645x_tag_prefix {
+	LAN9645X_TAG_PREFIX_DISABLED = 0,
+	LAN9645X_TAG_PREFIX_NONE = 1,
+	LAN9645X_TAG_PREFIX_SHORT = 2,
+	LAN9645X_TAG_PREFIX_LONG = 3,
+};
+
+enum {
+	LAN9645X_SPEED_DISABLED = 0,
+	LAN9645X_SPEED_10 = 1,
+	LAN9645X_SPEED_100 = 2,
+	LAN9645X_SPEED_1000 = 3,
+	LAN9645X_SPEED_2500 = 4,
+};
+
+/* Rewriter VLAN port tagging encoding for REW:PORT[0-10]:TAG_CFG.TAG_CFG
+ *
+ * 0: Port tagging disabled.
+ * 1: Tag all frames, except when VID=PORT_VLAN_CFG.PORT_VID or VID=0.
+ * 2: Tag all frames, except when VID=0.
+ * 3: Tag all frames.
+ */
+enum lan9645x_vlan_port_tag {
+	LAN9645X_TAG_DISABLED = 0,
+	LAN9645X_TAG_NO_PVID_NO_UNAWARE = 1,
+	LAN9645X_TAG_NO_UNAWARE = 2,
+	LAN9645X_TAG_ALL = 3,
+};
+
+struct lan9645x {
+	struct device *dev;
+	struct dsa_switch *ds;
+	enum dsa_tag_protocol tag_proto;
+	struct regmap *rmap[NUM_TARGETS];
+
+	int shared_queue_sz;
+
+	/* NPI chip_port */
+	int npi;
+
+	u8 num_phys_ports;
+	struct lan9645x_port **ports;
+
+	/* debugfs */
+	struct dentry *debugfs_root;
+
+	int num_port_dis;
+	bool dd_dis;
+	bool tsn_dis;
+};
+
+struct lan9645x_port {
+	struct lan9645x *lan9645x;
+	const char *name;
+
+	u16 pvid;
+	u16 untagged_vid;
+	u8 chip_port;
+	u8 stp_state;
+	bool vlan_aware;
+	bool learn_ena;
+
+	phy_interface_t phy_mode;
+
+	int speed; /* internal speed value LAN9645X_SPEED_* */
+	u8 duplex;
+	struct list_head path_delays;
+	u32 rx_delay;
+};
+
+struct lan9645x_path_delay {
+	struct list_head list;
+	u32 rx_delay;
+	u32 tx_delay;
+	u32 speed;
+};
+
+extern const struct phylink_mac_ops lan9645x_phylink_mac_ops;
+
+/* PFC_CFG.FC_LINK_SPEED encoding */
+static inline int lan9645x_speed_fc_enc(int speed)
+{
+	switch (speed) {
+	case LAN9645X_SPEED_10:
+		return 3;
+	case LAN9645X_SPEED_100:
+		return 2;
+	case LAN9645X_SPEED_1000:
+		return 1;
+	case LAN9645X_SPEED_2500:
+		return 0;
+	default:
+		WARN_ON_ONCE(1);
+		return 1;
+	}
+}
+
+/* Watermark encode. See QSYS:RES_CTRL[*]:RES_CFG.WM_HIGH for details.
+ * Returns lowest encoded number which will fit request/ is larger than request.
+ * Or the maximum representable value, if request is too large.
+ */
+static inline u32 lan9645x_wm_enc(u32 value)
+{
+#define GWM_MULTIPLIER_BIT BIT(8)
+#define LAN9645X_BUFFER_CELL_SZ 64
+	value = DIV_ROUND_UP(value, LAN9645X_BUFFER_CELL_SZ);
+
+	if (value >= GWM_MULTIPLIER_BIT) {
+		value = DIV_ROUND_UP(value, 16);
+		if (value >= GWM_MULTIPLIER_BIT)
+			value = (GWM_MULTIPLIER_BIT - 1);
+		value |= GWM_MULTIPLIER_BIT;
+	}
+
+	return value;
+}
+
+static inline struct lan9645x_port *lan9645x_to_port(struct lan9645x *lan9645x,
+						     int port)
+{
+	if (WARN_ON(!(port >= 0 && port < lan9645x->num_phys_ports)))
+		return NULL;
+
+	return lan9645x->ports[port];
+}
+
+static inline struct net_device *lan9645x_port_to_ndev(struct lan9645x_port *p)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(lan9645x->ds, p->chip_port);
+	if (dp && dp->type == DSA_PORT_TYPE_USER)
+		return dp->user;
+
+	return NULL;
+}
+
+static inline struct net_device *
+lan9645x_chipport_to_ndev(struct lan9645x *lan9645x, int port)
+{
+	return lan9645x_port_to_ndev(lan9645x_to_port(lan9645x, port));
+}
+
+static inline bool lan9645x_port_is_used(struct lan9645x *lan9645x, int port)
+{
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(lan9645x->ds, port);
+	if (!dp)
+		return false;
+
+	return dp->type != DSA_PORT_TYPE_UNUSED;
+}
+
+static inline struct regmap *lan_tgt2rmap(struct lan9645x *lan9645x,
+					  enum lan9645x_target t, int tinst)
+{
+	WARN_ON_ONCE(!lan9645x->rmap[t + tinst]);
+	return lan9645x->rmap[t + tinst];
+}
+
+static inline u32 __lan_rel_addr(int gbase, int ginst, int gcnt,
+				 int gwidth, int raddr, int rinst,
+				 int rcnt, int rwidth)
+{
+	WARN_ON(ginst >= gcnt);
+	WARN_ON(rinst >= rcnt);
+	return gbase + ginst * gwidth + raddr + rinst * rwidth;
+}
+
+/* Get register address relative to target instance */
+static inline u32 lan_rel_addr(enum lan9645x_target t, int tinst, int tcnt,
+			       int gbase, int ginst, int gcnt, int gwidth,
+			       int raddr, int rinst, int rcnt, int rwidth)
+{
+	WARN_ON(tinst >= tcnt);
+	return __lan_rel_addr(gbase, ginst, gcnt, gwidth, raddr, rinst,
+			      rcnt, rwidth);
+}
+
+static inline u32 lan_rd(struct lan9645x *lan9645x, enum lan9645x_target t,
+			 int tinst, int tcnt, int gbase, int ginst,
+			 int gcnt, int gwidth, int raddr, int rinst,
+			 int rcnt, int rwidth)
+{
+	u32 addr, val = 0;
+
+	addr = lan_rel_addr(t, tinst, tcnt, gbase, ginst, gcnt, gwidth,
+			    raddr, rinst, rcnt, rwidth);
+
+	WARN_ON_ONCE(regmap_read(lan_tgt2rmap(lan9645x, t, tinst), addr, &val));
+
+	return val;
+}
+
+static inline int lan_bulk_rd(void *val, size_t val_count,
+			      struct lan9645x *lan9645x,
+			      enum lan9645x_target t, int tinst, int tcnt,
+			      int gbase, int ginst, int gcnt, int gwidth,
+			      int raddr, int rinst, int rcnt, int rwidth)
+{
+	u32 addr;
+
+	addr = lan_rel_addr(t, tinst, tcnt, gbase, ginst, gcnt, gwidth,
+			    raddr, rinst, rcnt, rwidth);
+
+	return regmap_bulk_read(lan_tgt2rmap(lan9645x, t, tinst), addr, val,
+				val_count);
+}
+
+static inline struct regmap *lan_rmap(struct lan9645x *lan9645x,
+				      enum lan9645x_target t, int tinst,
+				      int tcnt, int gbase, int ginst,
+				      int gcnt, int gwidth, int raddr,
+				      int rinst, int rcnt, int rwidth)
+{
+	return lan_tgt2rmap(lan9645x, t, tinst);
+}
+
+static inline void lan_wr(u32 val, struct lan9645x *lan9645x,
+			  enum lan9645x_target t, int tinst, int tcnt,
+			  int gbase, int ginst, int gcnt, int gwidth,
+			  int raddr, int rinst, int rcnt, int rwidth)
+{
+	u32 addr;
+
+	addr = lan_rel_addr(t, tinst, tcnt, gbase, ginst, gcnt, gwidth,
+			    raddr, rinst, rcnt, rwidth);
+
+	WARN_ON_ONCE(regmap_write(lan_tgt2rmap(lan9645x, t, tinst), addr, val));
+}
+
+static inline void lan_rmw(u32 val, u32 mask, struct lan9645x *lan9645x,
+			   enum lan9645x_target t, int tinst, int tcnt,
+			   int gbase, int ginst, int gcnt, int gwidth,
+			   int raddr, int rinst, int rcnt, int rwidth)
+{
+	u32 addr;
+
+	addr = lan_rel_addr(t, tinst, tcnt, gbase, ginst, gcnt, gwidth,
+			    raddr, rinst, rcnt, rwidth);
+
+	WARN_ON_ONCE(regmap_update_bits(lan_tgt2rmap(lan9645x, t, tinst),
+					addr, mask, val));
+}
+
+/* lan9645x_npi.c */
+void lan9645x_npi_port_init(struct lan9645x *lan9645x,
+			    struct dsa_port *cpu_port);
+void lan9645x_npi_port_deinit(struct lan9645x *lan9645x, int port);
+
+/* lan9645x_port.c */
+int lan9645x_port_init(struct lan9645x *lan9645x, int port);
+void lan9645x_port_cpu_init(struct lan9645x *lan9645x);
+void lan9645x_port_set_tail_drop_wm(struct lan9645x *lan9645x);
+int lan9645x_port_set_maxlen(struct lan9645x *lan9645x, int port, size_t sdu);
+int lan9645x_port_parse_ports_node(struct lan9645x *lan9645x);
+
+/* lan9645x_phylink.c */
+void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
+			       struct phylink_config *c);
+void lan9645x_phylink_port_down(struct lan9645x *lan9645x, int port);
+
+#endif /* __LAN9645X_MAIN_H__ */
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
new file mode 100644
index 000000000000..0ae8b9acb916
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+#include <net/addrconf.h>
+
+#include "lan9645x_main.h"
+
+static void disable_conduit_ipv6(struct lan9645x *lan9645x,
+				 struct net_device *conduit)
+{
+	struct inet6_dev *dev_v6;
+
+	if (!conduit)
+		return;
+
+	/* IPv6 on the conduit will generate frames bypassing our tag driver, so
+	 * they lack an IFH. This will be garbage in garbage out and we want to
+	 * avoid this.
+	 */
+	rtnl_lock();
+	dev_v6 = __in6_dev_get(conduit);
+	if (dev_v6) {
+		WRITE_ONCE(dev_v6->cnf.disable_ipv6, 1);
+		dev_warn(lan9645x->dev, "Disabled IPv6 on conduit device: %s\n",
+			 netdev_name(conduit));
+	}
+	rtnl_unlock();
+}
+
+void lan9645x_npi_port_init(struct lan9645x *lan9645x,
+			    struct dsa_port *cpu_port)
+{
+	int port = cpu_port->index;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+	lan9645x->npi = port;
+
+	dev_dbg(lan9645x->dev, "NPI port=%d\n", port);
+
+	/* Enabling IPv6 on the conduit will send frames directly on the
+	 * interface, without being intercepted by our tag driver. This causes a
+	 * GIGO situation.
+	 */
+	disable_conduit_ipv6(lan9645x, cpu_port->conduit);
+
+	/* Any CPU extraction queue frames, are sent to external CPU on given
+	 * port. Never send injected frames back to cpu.
+	 */
+	lan_wr(QSYS_EXT_CPU_CFG_EXT_CPUQ_MSK |
+	       QSYS_EXT_CPU_CFG_EXT_CPU_PORT_SET(p->chip_port) |
+	       QSYS_EXT_CPU_CFG_EXT_CPU_KILL_ENA_SET(1) |
+	       QSYS_EXT_CPU_CFG_INT_CPU_KILL_ENA_SET(1),
+	       lan9645x, QSYS_EXT_CPU_CFG);
+
+	/* Configure IFH prefix mode for NPI port. */
+	lan_rmw(SYS_PORT_MODE_INCL_XTR_HDR_SET(LAN9645X_TAG_PREFIX_LONG) |
+		SYS_PORT_MODE_INCL_INJ_HDR_SET(LAN9645X_TAG_PREFIX_NONE),
+		SYS_PORT_MODE_INCL_XTR_HDR |
+		SYS_PORT_MODE_INCL_INJ_HDR,
+		lan9645x,
+		SYS_PORT_MODE(p->chip_port));
+
+	/* Rewriting and extraction with IFH does not play nice together. A VLAN
+	 * tag pushed into the frame by REW will cause 4 bytes at the end of the
+	 * extraction header to be overwritten with the top 4 bytes of the DMAC.
+	 *
+	 * We can not use REW_PORT_CFG_NO_REWRITE=1 as that disabled RTAGD
+	 * setting in the IFH
+	 */
+	lan_rmw(REW_TAG_CFG_TAG_CFG_SET(LAN9645X_TAG_DISABLED),
+		REW_TAG_CFG_TAG_CFG, lan9645x, REW_TAG_CFG(port));
+
+	/* Make sure frames with src_port=CPU_PORT are not reflected back via
+	 * the NPI port. This could happen if a frame is flooded for instance.
+	 * The *_CPU_KILL_ENA flags above only have an effect when a frame is
+	 * output due to a CPU forwarding decision such as trapping or cpu copy.
+	 */
+	lan_rmw(0, BIT(port), lan9645x, ANA_PGID(PGID_SRC + CPU_PORT));
+}
+
+void lan9645x_npi_port_deinit(struct lan9645x *lan9645x, int port)
+{
+	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
+
+	lan9645x->npi = -1;
+
+	lan_wr(QSYS_EXT_CPU_CFG_EXT_CPU_PORT_SET(0x1f) |
+	       QSYS_EXT_CPU_CFG_EXT_CPU_KILL_ENA_SET(1) |
+	       QSYS_EXT_CPU_CFG_INT_CPU_KILL_ENA_SET(1),
+	       lan9645x, QSYS_EXT_CPU_CFG);
+
+	lan_rmw(SYS_PORT_MODE_INCL_XTR_HDR_SET(LAN9645X_TAG_PREFIX_DISABLED) |
+		SYS_PORT_MODE_INCL_INJ_HDR_SET(LAN9645X_TAG_PREFIX_DISABLED),
+		SYS_PORT_MODE_INCL_XTR_HDR |
+		SYS_PORT_MODE_INCL_INJ_HDR,
+		lan9645x,
+		SYS_PORT_MODE(p->chip_port));
+}
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
new file mode 100644
index 000000000000..3acc48f12fae
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+
+#include "lan9645x_main.h"
+
+void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
+			       struct phylink_config *c)
+{
+	c->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
+			      MAC_100 | MAC_1000FD | MAC_2500FD;
+
+	switch (port) {
+	case 0 ... 3:
+		__set_bit(PHY_INTERFACE_MODE_GMII, c->supported_interfaces);
+		break;
+	case 4:
+		__set_bit(PHY_INTERFACE_MODE_GMII, c->supported_interfaces);
+		phy_interface_set_rgmii(c->supported_interfaces);
+		break;
+	case 5 ... 6:
+		/* SerDes ports: QSGMII/SGMII/1000BASEX/2500BASEX modes
+		 * require PCS support which is not yet implemented.
+		 */
+		break;
+	case 7 ... 8:
+		/* QSGMII mode on ports 7-8 requires SerDes PCS support,
+		 * which is not yet implemented.
+		 */
+		phy_interface_set_rgmii(c->supported_interfaces);
+		break;
+	default:
+		break;
+	}
+}
+
+static int lan9645x_rgmii_setup(struct lan9645x *lan9645x, int port, int speed,
+				phy_interface_t mode)
+{
+	bool tx_delay = false, rx_delay = false;
+	u32 rx_idx, tx_idx;
+	u8 tx_clk;
+	int idx;
+
+	/* Port 4 or 7 is RGMII_0 and port 8 is RGMII_1 */
+	idx = port == 8 ? 1 : 0;
+
+	if (!phy_interface_mode_is_rgmii(mode))
+		return 0;
+
+	tx_clk = speed == SPEED_1000 ? 1 :
+		 speed == SPEED_100  ? 2 :
+		 speed == SPEED_10   ? 3 : 0;
+
+	lan_rmw(HSIO_RGMII_CFG_RGMII_RX_RST_SET(0) |
+		HSIO_RGMII_CFG_RGMII_TX_RST_SET(0) |
+		HSIO_RGMII_CFG_TX_CLK_CFG_SET(tx_clk),
+		HSIO_RGMII_CFG_RGMII_RX_RST |
+		HSIO_RGMII_CFG_RGMII_TX_RST |
+		HSIO_RGMII_CFG_TX_CLK_CFG,
+		lan9645x, HSIO_RGMII_CFG(idx));
+
+	/* We configure delays on the MAC side. When the PHY is not responsible
+	 * for delays, the MAC is, which is why RGMII_TXID results in
+	 * rx_delay=true.
+	 */
+	if (mode == PHY_INTERFACE_MODE_RGMII ||
+	    mode == PHY_INTERFACE_MODE_RGMII_TXID)
+		rx_delay = true;
+
+	if (mode == PHY_INTERFACE_MODE_RGMII ||
+	    mode == PHY_INTERFACE_MODE_RGMII_RXID)
+		tx_delay = true;
+
+	/* Setup DLL configuration. Register layout:
+	 * 0:        RGMII_0_RX
+	 * 1:        RGMII_0_TX
+	 * 2:        RGMII_1_RX
+	 * 3:        RGMII_1_TX
+	 * ...
+	 * (N<<1)    RGMII_N_RX,
+	 * (N<<1)+1: RGMII_N_TX,
+	 */
+	rx_idx = idx << 1;
+	tx_idx = rx_idx + 1;
+
+	/* Enable DLL in RGMII clock paths, deassert DLL reset, and start the
+	 * delay tune FSM.
+	 */
+	lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
+		HSIO_DLL_CFG_DLL_RST_SET(0) |
+		HSIO_DLL_CFG_DLL_ENA_SET(rx_delay) |
+		HSIO_DLL_CFG_DELAY_ENA_SET(rx_delay),
+		HSIO_DLL_CFG_DLL_CLK_ENA |
+		HSIO_DLL_CFG_DLL_RST |
+		HSIO_DLL_CFG_DLL_ENA |
+		HSIO_DLL_CFG_DELAY_ENA,
+		lan9645x, HSIO_DLL_CFG(rx_idx));
+
+	lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
+		HSIO_DLL_CFG_DLL_RST_SET(0) |
+		HSIO_DLL_CFG_DLL_ENA_SET(tx_delay) |
+		HSIO_DLL_CFG_DELAY_ENA_SET(tx_delay),
+		HSIO_DLL_CFG_DLL_CLK_ENA |
+		HSIO_DLL_CFG_DLL_RST |
+		HSIO_DLL_CFG_DLL_ENA |
+		HSIO_DLL_CFG_DELAY_ENA,
+		lan9645x, HSIO_DLL_CFG(tx_idx));
+
+	return 0;
+}
+
+static void lan9645x_phylink_mac_config(struct lan9645x *lan9645x, int port,
+					unsigned int mode,
+					const struct phylink_link_state *state)
+{
+	if (phy_interface_mode_is_rgmii(state->interface))
+		lan9645x_rgmii_setup(lan9645x, port, state->speed,
+				     state->interface);
+}
+
+static int lan9645x_phylink_mac_prepare(struct lan9645x *lan9645x, int port,
+					unsigned int mode,
+					phy_interface_t iface)
+{
+	switch (port) {
+	case 0 ... 3:
+		lan_rmw(HSIO_HW_CFG_GMII_ENA_SET(BIT(port)),
+			HSIO_HW_CFG_GMII_ENA_SET(BIT(port)), lan9645x,
+			HSIO_HW_CFG);
+		break;
+	case 4:
+		lan_rmw(HSIO_HW_CFG_GMII_ENA_SET(BIT(port)),
+			HSIO_HW_CFG_GMII_ENA_SET(BIT(port)), lan9645x,
+			HSIO_HW_CFG);
+
+		if (phy_interface_mode_is_rgmii(iface))
+			lan_rmw(HSIO_HW_CFG_RGMII_0_CFG_SET(1),
+				HSIO_HW_CFG_RGMII_0_CFG,
+				lan9645x, HSIO_HW_CFG);
+
+		break;
+	case 7 ... 8:
+		lan_rmw(HSIO_HW_CFG_GMII_ENA_SET(BIT(port)),
+			HSIO_HW_CFG_GMII_ENA_SET(BIT(port)), lan9645x,
+			HSIO_HW_CFG);
+		break;
+	default:
+		/* Ports 5-6 are SerDes-only and need PCS support (not yet
+		 * implemented). They are excluded from phylink_get_caps.
+		 */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int lan9645x_port_is_cuphy(struct lan9645x *lan9645x, int port,
+				  phy_interface_t interface)
+{
+	return port >= 0 && port <= 4 && interface == PHY_INTERFACE_MODE_GMII;
+}
+
+static void lan9645x_phylink_mac_link_up(struct lan9645x *lan9645x, int port,
+					 unsigned int link_an_mode,
+					 phy_interface_t interface,
+					 struct phy_device *phydev, int speed,
+					 int duplex, bool tx_pause,
+					 bool rx_pause)
+{
+	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
+	int rx_ifg1, rx_ifg2, tx_ifg, gtx_clk = 0;
+	struct lan9645x_path_delay *path_delay;
+	int gspeed = LAN9645X_SPEED_DISABLED;
+	int mode = 0;
+	int fc_spd;
+
+	/* Configure speed for RGMII modules. */
+	if (phy_interface_mode_is_rgmii(interface))
+		lan9645x_rgmii_setup(lan9645x, port, speed, interface);
+
+	if (duplex == DUPLEX_FULL) {
+		mode |= DEV_MAC_MODE_CFG_FDX_ENA_SET(1);
+		rx_ifg2 = DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
+		tx_ifg = DEV_MAC_IFG_CFG_TX_IFG_SET(0x5);
+
+	} else {
+		rx_ifg2 = DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
+		tx_ifg = DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
+	}
+
+	switch (speed) {
+	case SPEED_10:
+		rx_ifg1 = DEV_MAC_IFG_CFG_RX_IFG1_SET(0x2);
+		gspeed = LAN9645X_SPEED_10;
+		break;
+	case SPEED_100:
+		rx_ifg1 = DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1);
+		gspeed = LAN9645X_SPEED_100;
+		break;
+	case SPEED_1000:
+		gspeed = LAN9645X_SPEED_1000;
+		mode |= DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
+		mode |= DEV_MAC_MODE_CFG_FDX_ENA_SET(1);
+		rx_ifg1 = DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1);
+		rx_ifg2 = DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
+		tx_ifg = DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
+		gtx_clk = 1;
+		break;
+	case SPEED_2500:
+		gspeed = LAN9645X_SPEED_2500;
+		mode |= DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
+		mode |= DEV_MAC_MODE_CFG_FDX_ENA_SET(1);
+		rx_ifg1 = DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1);
+		rx_ifg2 = DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
+		tx_ifg = DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
+		break;
+	default:
+		dev_err(lan9645x->dev, "Unsupported speed on port %d: %d\n",
+			p->chip_port, speed);
+		return;
+	}
+
+	p->speed = gspeed;
+	p->duplex = duplex;
+	fc_spd = lan9645x_speed_fc_enc(p->speed);
+
+	if (phy_interface_num_ports(interface) == 4 ||
+	    interface == PHY_INTERFACE_MODE_SGMII)
+		mode |= DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
+
+	lan_rmw(mode,
+		DEV_MAC_MODE_CFG_FDX_ENA |
+		DEV_MAC_MODE_CFG_GIGA_MODE_ENA,
+		lan9645x, DEV_MAC_MODE_CFG(p->chip_port));
+
+	lan_rmw(tx_ifg | rx_ifg1 | rx_ifg2,
+		DEV_MAC_IFG_CFG_TX_IFG |
+		DEV_MAC_IFG_CFG_RX_IFG1 |
+		DEV_MAC_IFG_CFG_RX_IFG2,
+		lan9645x, DEV_MAC_IFG_CFG(p->chip_port));
+
+	lan_rmw(DEV_MAC_HDX_CFG_SEED_SET(p->chip_port) |
+		DEV_MAC_HDX_CFG_SEED_LOAD_SET(1),
+		DEV_MAC_HDX_CFG_SEED |
+		DEV_MAC_HDX_CFG_SEED_LOAD, lan9645x,
+		DEV_MAC_HDX_CFG(p->chip_port));
+
+	if (lan9645x_port_is_cuphy(lan9645x, port, interface)) {
+		lan_rmw(CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA_SET(gtx_clk),
+			CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA, lan9645x,
+			CHIP_TOP_CUPHY_PORT_CFG(p->chip_port));
+	}
+
+	lan_rmw(DEV_MAC_HDX_CFG_SEED_LOAD_SET(0),
+		DEV_MAC_HDX_CFG_SEED_LOAD, lan9645x,
+		DEV_MAC_HDX_CFG(p->chip_port));
+
+	/* Set PFC link speed and enable map */
+	lan_rmw(ANA_PFC_CFG_FC_LINK_SPEED_SET(fc_spd) |
+		ANA_PFC_CFG_RX_PFC_ENA_SET(0),
+		ANA_PFC_CFG_FC_LINK_SPEED |
+		ANA_PFC_CFG_RX_PFC_ENA,
+		lan9645x, ANA_PFC_CFG(p->chip_port));
+
+	lan_rmw(DEV_PCS1G_CFG_PCS_ENA_SET(1),
+		DEV_PCS1G_CFG_PCS_ENA, lan9645x,
+		DEV_PCS1G_CFG(p->chip_port));
+
+	lan_rmw(DEV_PCS1G_SD_CFG_SD_ENA_SET(0),
+		DEV_PCS1G_SD_CFG_SD_ENA,
+		lan9645x, DEV_PCS1G_SD_CFG(p->chip_port));
+
+	lan_rmw(SYS_PAUSE_CFG_PAUSE_ENA_SET(1),
+		SYS_PAUSE_CFG_PAUSE_ENA,
+		lan9645x, SYS_PAUSE_CFG(p->chip_port));
+
+	/* Set SMAC of Pause frame (00:00:00:00:00:00) */
+	lan_wr(0, lan9645x, DEV_FC_MAC_LOW_CFG(p->chip_port));
+	lan_wr(0, lan9645x, DEV_FC_MAC_HIGH_CFG(p->chip_port));
+
+	/* Flow control */
+	lan_rmw(SYS_MAC_FC_CFG_FC_LINK_SPEED_SET(fc_spd) |
+		SYS_MAC_FC_CFG_FC_LATENCY_CFG_SET(0x7) |
+		SYS_MAC_FC_CFG_ZERO_PAUSE_ENA_SET(1) |
+		SYS_MAC_FC_CFG_PAUSE_VAL_CFG_SET(0xffff) |
+		SYS_MAC_FC_CFG_RX_FC_ENA_SET(rx_pause ? 1 : 0) |
+		SYS_MAC_FC_CFG_TX_FC_ENA_SET(tx_pause ? 1 : 0),
+		SYS_MAC_FC_CFG_FC_LINK_SPEED |
+		SYS_MAC_FC_CFG_FC_LATENCY_CFG |
+		SYS_MAC_FC_CFG_ZERO_PAUSE_ENA |
+		SYS_MAC_FC_CFG_PAUSE_VAL_CFG |
+		SYS_MAC_FC_CFG_RX_FC_ENA |
+		SYS_MAC_FC_CFG_TX_FC_ENA,
+		lan9645x, SYS_MAC_FC_CFG(p->chip_port));
+
+	list_for_each_entry(path_delay, &p->path_delays, list) {
+		if (path_delay->speed == speed) {
+			lan_wr(path_delay->rx_delay + p->rx_delay,
+			       lan9645x, SYS_PTP_RXDLY_CFG(p->chip_port));
+			lan_wr(path_delay->tx_delay,
+			       lan9645x, SYS_PTP_TXDLY_CFG(p->chip_port));
+		}
+	}
+
+	/* Enable MAC module */
+	lan_wr(DEV_MAC_ENA_CFG_RX_ENA_SET(1) |
+	       DEV_MAC_ENA_CFG_TX_ENA_SET(1),
+	       lan9645x, DEV_MAC_ENA_CFG(p->chip_port));
+
+	/* port _must_ be taken out of reset before MAC. */
+	lan_rmw(DEV_CLOCK_CFG_PORT_RST_SET(0),
+		DEV_CLOCK_CFG_PORT_RST,
+		lan9645x, DEV_CLOCK_CFG(p->chip_port));
+
+	/* Take out the clock from reset. Note this write will set all these
+	 * fields to zero:
+	 *
+	 * DEV_CLOCK_CFG[*].MAC_TX_RST
+	 * DEV_CLOCK_CFG[*].MAC_RX_RST
+	 * DEV_CLOCK_CFG[*].PCS_TX_RST
+	 * DEV_CLOCK_CFG[*].PCS_RX_RST
+	 * DEV_CLOCK_CFG[*].PORT_RST
+	 * DEV_CLOCK_CFG[*].PHY_RST
+	 *
+	 * Note link_down will assert PORT_RST, MAC_RX_RST and MAC_TX_RST, so
+	 * we are effectively taking the mac tx/rx clocks out of reset.
+	 *
+	 * This linkspeed field has a slightly different encoding from others:
+	 *
+	 * - 0 is no-link
+	 * - 1 is both 2500/1000
+	 * - 2 is 100mbit
+	 * - 3 is 10mbit
+	 *
+	 */
+	lan_wr(DEV_CLOCK_CFG_LINK_SPEED_SET(fc_spd == 0 ? 1 : fc_spd),
+	       lan9645x,
+	       DEV_CLOCK_CFG(p->chip_port));
+
+	/* Core: Enable port for frame transfer */
+	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(1) |
+		QSYS_SW_PORT_MODE_SCH_NEXT_CFG_SET(1) |
+		QSYS_SW_PORT_MODE_INGRESS_DROP_MODE_SET(1) |
+		QSYS_SW_PORT_MODE_TX_PFC_ENA_SET(0),
+		QSYS_SW_PORT_MODE_PORT_ENA |
+		QSYS_SW_PORT_MODE_SCH_NEXT_CFG |
+		QSYS_SW_PORT_MODE_INGRESS_DROP_MODE |
+		QSYS_SW_PORT_MODE_TX_PFC_ENA,
+		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
+
+	lan_rmw(AFI_PORT_CFG_FC_SKIP_TTI_INJ_SET(0) |
+		AFI_PORT_CFG_FRM_OUT_MAX_SET(16),
+		AFI_PORT_CFG_FC_SKIP_TTI_INJ |
+		AFI_PORT_CFG_FRM_OUT_MAX,
+		lan9645x, AFI_PORT_CFG(p->chip_port));
+}
+
+void lan9645x_phylink_port_down(struct lan9645x *lan9645x, int port)
+{
+	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
+	u32 val;
+
+	/* 0.5: Disable any AFI */
+	lan_rmw(AFI_PORT_CFG_FC_SKIP_TTI_INJ_SET(1) |
+		AFI_PORT_CFG_FRM_OUT_MAX_SET(0),
+		AFI_PORT_CFG_FC_SKIP_TTI_INJ |
+		AFI_PORT_CFG_FRM_OUT_MAX,
+		lan9645x, AFI_PORT_CFG(p->chip_port));
+
+	/* wait for reg afi_port_frm_out to become 0 for the port */
+	if (lan9645x_rd_poll_slow(lan9645x, AFI_PORT_FRM_OUT(p->chip_port),
+				  val,
+				  !AFI_PORT_FRM_OUT_FRM_OUT_CNT_GET(val)))
+		dev_err(lan9645x->dev, "AFI timeout chip port %u",
+			p->chip_port);
+
+	/* 2: Disable MAC frame reception */
+	lan_rmw(DEV_MAC_ENA_CFG_RX_ENA_SET(0),
+		DEV_MAC_ENA_CFG_RX_ENA,
+		lan9645x, DEV_MAC_ENA_CFG(p->chip_port));
+
+	/* 1: Reset the PCS Rx clock domain  */
+	lan_rmw(DEV_CLOCK_CFG_PCS_RX_RST_SET(1),
+		DEV_CLOCK_CFG_PCS_RX_RST,
+		lan9645x, DEV_CLOCK_CFG(p->chip_port));
+
+	p->speed = LAN9645X_SPEED_DISABLED;
+	p->duplex = DUPLEX_UNKNOWN;
+
+	/* 3: Disable traffic being sent to or from switch port */
+	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(0),
+		QSYS_SW_PORT_MODE_PORT_ENA,
+		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
+
+	/* 4: Disable dequeuing from the egress queues  */
+	lan_rmw(QSYS_PORT_MODE_DEQUEUE_DIS_SET(1),
+		QSYS_PORT_MODE_DEQUEUE_DIS,
+		lan9645x, QSYS_PORT_MODE(p->chip_port));
+
+	/* 5: Disable Flowcontrol */
+	lan_rmw(SYS_PAUSE_CFG_PAUSE_ENA_SET(0),
+		SYS_PAUSE_CFG_PAUSE_ENA,
+		lan9645x, SYS_PAUSE_CFG(p->chip_port));
+
+	/* 5.1: Disable PFC */
+	lan_rmw(QSYS_SW_PORT_MODE_TX_PFC_ENA_SET(0),
+		QSYS_SW_PORT_MODE_TX_PFC_ENA,
+		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
+
+	/* 6: Wait a worst case time 8ms (10K jumbo/10Mbit) */
+	usleep_range(8 * USEC_PER_MSEC, 9 * USEC_PER_MSEC);
+
+	/* 7: Disable HDX backpressure. */
+	lan_rmw(SYS_FRONT_PORT_MODE_HDX_MODE_SET(0),
+		SYS_FRONT_PORT_MODE_HDX_MODE,
+		lan9645x, SYS_FRONT_PORT_MODE(p->chip_port));
+
+	/* 8: Flush the queues associated with the port */
+	lan_rmw(QSYS_SW_PORT_MODE_AGING_MODE_SET(3),
+		QSYS_SW_PORT_MODE_AGING_MODE,
+		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
+
+	/* 9: Enable dequeuing from the egress queues */
+	lan_rmw(QSYS_PORT_MODE_DEQUEUE_DIS_SET(0),
+		QSYS_PORT_MODE_DEQUEUE_DIS,
+		lan9645x, QSYS_PORT_MODE(p->chip_port));
+
+	/* 10: Wait until flushing is complete */
+	if (lan9645x_rd_poll_slow(lan9645x, QSYS_SW_STATUS(p->chip_port),
+				  val, !QSYS_SW_STATUS_EQ_AVAIL_GET(val)))
+		dev_err(lan9645x->dev, "Flush timeout chip port %u", port);
+
+	/* 11: Disable MAC tx */
+	lan_rmw(DEV_MAC_ENA_CFG_TX_ENA_SET(0),
+		DEV_MAC_ENA_CFG_TX_ENA,
+		lan9645x, DEV_MAC_ENA_CFG(p->chip_port));
+
+	/* 12: Reset the Port and MAC clock domains */
+	lan_rmw(DEV_CLOCK_CFG_PORT_RST_SET(1),
+		DEV_CLOCK_CFG_PORT_RST,
+		lan9645x, DEV_CLOCK_CFG(p->chip_port));
+
+	/* Wait before resetting MAC clock domains. */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+
+	lan_rmw(DEV_CLOCK_CFG_MAC_TX_RST_SET(1) |
+		DEV_CLOCK_CFG_MAC_RX_RST_SET(1) |
+		DEV_CLOCK_CFG_PORT_RST_SET(1),
+		DEV_CLOCK_CFG_MAC_TX_RST |
+		DEV_CLOCK_CFG_MAC_RX_RST |
+		DEV_CLOCK_CFG_PORT_RST,
+		lan9645x, DEV_CLOCK_CFG(p->chip_port));
+
+	/* 13: Clear flushing */
+	lan_rmw(QSYS_SW_PORT_MODE_AGING_MODE_SET(1),
+		QSYS_SW_PORT_MODE_AGING_MODE,
+		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
+}
+
+static void lan9645x_phylink_mac_link_down(struct lan9645x *lan9645x, int port,
+					   unsigned int link_an_mode,
+					   phy_interface_t interface)
+{
+	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
+
+	lan9645x_phylink_port_down(lan9645x, port);
+
+	/* 14: Take PCS out of reset */
+	lan_rmw(DEV_CLOCK_CFG_PCS_RX_RST_SET(0) |
+		DEV_CLOCK_CFG_PCS_TX_RST_SET(0),
+		DEV_CLOCK_CFG_PCS_RX_RST |
+		DEV_CLOCK_CFG_PCS_TX_RST,
+		lan9645x, DEV_CLOCK_CFG(p->chip_port));
+}
+
+static struct lan9645x_port *
+lan9645x_phylink_config_to_port(struct phylink_config *config)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+
+	return lan9645x_to_port(dp->ds->priv, dp->index);
+}
+
+static void
+lan9645x_port_phylink_mac_config(struct phylink_config *config,
+				 unsigned int mode,
+				 const struct phylink_link_state *state)
+{
+	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
+
+	lan9645x_phylink_mac_config(p->lan9645x, p->chip_port, mode, state);
+}
+
+static void lan9645x_port_phylink_mac_link_up(struct phylink_config *config,
+					      struct phy_device *phydev,
+					      unsigned int link_an_mode,
+					      phy_interface_t interface,
+					      int speed, int duplex,
+					      bool tx_pause, bool rx_pause)
+{
+	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
+
+	lan9645x_phylink_mac_link_up(p->lan9645x, p->chip_port, link_an_mode,
+				     interface, phydev, speed, duplex, tx_pause,
+				     rx_pause);
+}
+
+static void lan9645x_port_phylink_mac_link_down(struct phylink_config *config,
+						unsigned int link_an_mode,
+						phy_interface_t interface)
+{
+	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
+
+	lan9645x_phylink_mac_link_down(p->lan9645x, p->chip_port, link_an_mode,
+				       interface);
+}
+
+static int lan9645x_port_phylink_mac_prepare(struct phylink_config *config,
+					     unsigned int mode,
+					     phy_interface_t iface)
+{
+	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
+
+	return lan9645x_phylink_mac_prepare(p->lan9645x, p->chip_port, mode,
+					    iface);
+}
+
+const struct phylink_mac_ops lan9645x_phylink_mac_ops = {
+	.mac_config			= lan9645x_port_phylink_mac_config,
+	.mac_link_up			= lan9645x_port_phylink_mac_link_up,
+	.mac_link_down			= lan9645x_port_phylink_mac_link_down,
+	.mac_prepare			= lan9645x_port_phylink_mac_prepare,
+};
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
new file mode 100644
index 000000000000..038868ae0a32
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include "lan9645x_main.h"
+
+int lan9645x_port_init(struct lan9645x *lan9645x, int port)
+{
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	/* Disable learning on port */
+	lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(0),
+		ANA_PORT_CFG_LEARN_ENA,
+		lan9645x, ANA_PORT_CFG(p->chip_port));
+
+	lan9645x_port_set_maxlen(lan9645x, port, ETH_DATA_LEN);
+
+	lan9645x_phylink_port_down(lan9645x, port);
+
+	if (phy_interface_num_ports(p->phy_mode) == 4)
+		lan_rmw(DEV_CLOCK_CFG_PCS_RX_RST_SET(0) |
+			DEV_CLOCK_CFG_PCS_TX_RST_SET(0),
+			DEV_CLOCK_CFG_PCS_RX_RST |
+			DEV_CLOCK_CFG_PCS_TX_RST,
+			lan9645x, DEV_CLOCK_CFG(p->chip_port));
+
+	/* Drop frames with multicast source address */
+	lan_rmw(ANA_DROP_CFG_DROP_MC_SMAC_ENA_SET(1),
+		ANA_DROP_CFG_DROP_MC_SMAC_ENA, lan9645x,
+		ANA_DROP_CFG(p->chip_port));
+
+	/* Enable receiving frames on the port, and activate auto-learning of
+	 * MAC addresses.
+	 */
+	lan_rmw(ANA_PORT_CFG_LEARNAUTO_SET(1) |
+		ANA_PORT_CFG_RECV_ENA_SET(1) |
+		ANA_PORT_CFG_PORTID_VAL_SET(p->chip_port),
+		ANA_PORT_CFG_LEARNAUTO |
+		ANA_PORT_CFG_RECV_ENA |
+		ANA_PORT_CFG_PORTID_VAL,
+		lan9645x, ANA_PORT_CFG(p->chip_port));
+
+	return 0;
+}
+
+void lan9645x_port_cpu_init(struct lan9645x *lan9645x)
+{
+	/* Map the 8 CPU extraction queues to CPU port 9 (datasheet is wrong) */
+	lan_wr(0, lan9645x, QSYS_CPU_GROUP_MAP);
+
+	/* Configure second cpu port (chip_port 10) for manual frame injection.
+	 * The AFI can not inject frames via the NPI port, unless frame aging is
+	 * disabled on frontports, so we use manual injection for AFI frames.
+	 */
+
+	/* Set min-spacing of EOF to SOF on injected frames to 0, on cpu device
+	 * 1. This is required when injecting with IFH.
+	 * Default values emulates delay of std preamble/IFG setting on a front
+	 * port.
+	 */
+	lan_rmw(QS_INJ_CTRL_GAP_SIZE_SET(0),
+		QS_INJ_CTRL_GAP_SIZE,
+		lan9645x, QS_INJ_CTRL(1));
+
+	/* Injection: Mode: manual injection | Byte_swap */
+	lan_wr(QS_INJ_GRP_CFG_MODE_SET(1) |
+	       QS_INJ_GRP_CFG_BYTE_SWAP_SET(1),
+	       lan9645x, QS_INJ_GRP_CFG(1));
+
+	lan_rmw(QS_INJ_CTRL_GAP_SIZE_SET(0),
+		QS_INJ_CTRL_GAP_SIZE,
+		lan9645x, QS_INJ_CTRL(1));
+
+	lan_wr(SYS_PORT_MODE_INCL_INJ_HDR_SET(1),
+	       lan9645x, SYS_PORT_MODE(CPU_PORT + 1));
+
+	/* The CPU will only use its reserved buffer in the shared queue system
+	 * and none of the shared buffer space, therefore we disable resource
+	 * sharing in egress direction. We must not disable resource sharing in
+	 * the ingress direction, because some traffic test scenarios require
+	 * loads of buffer memory for frames initiated by the CPU.
+	 */
+	lan_rmw(QSYS_EGR_NO_SHARING_EGR_NO_SHARING_SET(BIT(CPU_PORT)),
+		QSYS_EGR_NO_SHARING_EGR_NO_SHARING_SET(BIT(CPU_PORT)),
+		lan9645x, QSYS_EGR_NO_SHARING);
+
+	/* The CPU should also discard frames forwarded to it if it has run
+	 * out of the reserved buffer space. Otherwise they will be held back
+	 * in the ingress queues with potential head-of-line blocking effects.
+	 */
+	lan_rmw(QSYS_EGR_DROP_MODE_EGRESS_DROP_MODE_SET(BIT(CPU_PORT)),
+		QSYS_EGR_DROP_MODE_EGRESS_DROP_MODE_SET(BIT(CPU_PORT)),
+		lan9645x, QSYS_EGR_DROP_MODE);
+
+	lan_wr(BIT(CPU_PORT), lan9645x, ANA_PGID(PGID_CPU));
+
+	lan_rmw(ANA_PORT_CFG_PORTID_VAL_SET(CPU_PORT) |
+		ANA_PORT_CFG_RECV_ENA_SET(1),
+		ANA_PORT_CFG_PORTID_VAL |
+		ANA_PORT_CFG_RECV_ENA, lan9645x,
+		ANA_PORT_CFG(CPU_PORT));
+
+	/* Enable switching to/from cpu port. Keep default aging-mode. */
+	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(1) |
+		QSYS_SW_PORT_MODE_SCH_NEXT_CFG_SET(1) |
+		QSYS_SW_PORT_MODE_INGRESS_DROP_MODE_SET(1),
+		QSYS_SW_PORT_MODE_PORT_ENA |
+		QSYS_SW_PORT_MODE_SCH_NEXT_CFG |
+		QSYS_SW_PORT_MODE_INGRESS_DROP_MODE,
+		lan9645x, QSYS_SW_PORT_MODE(CPU_PORT));
+
+	/* Transmit cpu frames as received without any tagging, timing or other
+	 * updates. This does not affect CPU-over-NPI, only manual extraction.
+	 * On the NPI port we need NO_REWRITE=0 for HSR/PRP.
+	 */
+	lan_wr(REW_PORT_CFG_NO_REWRITE_SET(1),
+	       lan9645x, REW_PORT_CFG(CPU_PORT));
+}
+
+void lan9645x_port_set_tail_drop_wm(struct lan9645x *lan9645x)
+{
+	int shared_per_port;
+	int port;
+
+	/* Configure tail dropping watermark */
+	shared_per_port =
+		lan9645x->shared_queue_sz / (lan9645x->num_phys_ports + 1);
+
+	/* The total memory size is diveded by number of front ports plus CPU
+	 * port.
+	 */
+	lan9645x_for_each_chipport(lan9645x, port)
+		lan_wr(lan9645x_wm_enc(shared_per_port), lan9645x,
+		       SYS_ATOP(port));
+
+	/* Tail dropping active based only on per port ATOP wm */
+	lan_wr(lan9645x_wm_enc(lan9645x->shared_queue_sz), lan9645x,
+	       SYS_ATOP_TOT_CFG);
+}
+
+int lan9645x_port_set_maxlen(struct lan9645x *lan9645x, int port, size_t sdu)
+{
+	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
+
+	int maxlen = sdu + ETH_HLEN + ETH_FCS_LEN;
+
+	if (port == lan9645x->npi) {
+		maxlen += LAN9645X_IFH_LEN;
+		maxlen += LAN9645X_LONG_PREFIX_LEN;
+	}
+
+	lan_wr(DEV_MAC_MAXLEN_CFG_MAX_LEN_SET(maxlen), lan9645x,
+	       DEV_MAC_MAXLEN_CFG(p->chip_port));
+
+	/* Set Pause WM hysteresis */
+	lan_rmw(SYS_PAUSE_CFG_PAUSE_STOP_SET(lan9645x_wm_enc(4 * maxlen)) |
+		SYS_PAUSE_CFG_PAUSE_START_SET(lan9645x_wm_enc(6 * maxlen)),
+		SYS_PAUSE_CFG_PAUSE_START |
+		SYS_PAUSE_CFG_PAUSE_STOP,
+		lan9645x,
+		SYS_PAUSE_CFG(p->chip_port));
+
+	return 0;
+}
+
+static int lan9645x_port_setup_leds(struct lan9645x *lan9645x,
+				    struct fwnode_handle *portnp, int port)
+{
+	u32 drive_mode;
+	int err;
+
+	err = fwnode_property_read_u32(portnp, "microchip,led-drive-mode",
+				       &drive_mode);
+	if (err)
+		return err;
+
+	lan_rmw(CHIP_TOP_CUPHY_LED_CFG_LED_DRIVE_MODE_SET(drive_mode),
+		CHIP_TOP_CUPHY_LED_CFG_LED_DRIVE_MODE, lan9645x,
+		CHIP_TOP_CUPHY_LED_CFG(port));
+
+	return 0;
+}
+
+static int lan9645x_port_parse_delays(struct lan9645x_port *port,
+				      struct fwnode_handle *portnp)
+{
+	struct fwnode_handle *delay;
+	int err;
+
+	INIT_LIST_HEAD(&port->path_delays);
+
+	fwnode_for_each_available_child_node(portnp, delay) {
+		struct lan9645x_path_delay *path_delay;
+		s32 tx_delay;
+		s32 rx_delay;
+		u32 speed;
+
+		err = fwnode_property_read_u32(delay, "speed", &speed);
+		if (err)
+			return err;
+
+		err = fwnode_property_read_u32(delay, "rx_delay", &rx_delay);
+		if (err)
+			return err;
+
+		err = fwnode_property_read_u32(delay, "tx_delay", &tx_delay);
+		if (err)
+			return err;
+
+		path_delay = devm_kzalloc(port->lan9645x->dev,
+					  sizeof(*path_delay), GFP_KERNEL);
+		if (!path_delay)
+			return -ENOMEM;
+
+		path_delay->rx_delay = rx_delay;
+		path_delay->tx_delay = tx_delay;
+		path_delay->speed = speed;
+		list_add_tail(&path_delay->list, &port->path_delays);
+	}
+
+	return 0;
+}
+
+int lan9645x_port_parse_ports_node(struct lan9645x *lan9645x)
+{
+	struct fwnode_handle *ports, *portnp;
+	struct device *dev = lan9645x->dev;
+	int max_ports, num_ports = 0;
+	int err = 0;
+
+	max_ports = NUM_PHYS_PORTS - lan9645x->num_port_dis;
+
+	ports = device_get_named_child_node(dev, "ethernet-ports");
+	if (!ports)
+		ports = device_get_named_child_node(dev, "ports");
+	if (!ports) {
+		dev_err(dev, "no ethernet-ports or ports child found\n");
+		return -ENODEV;
+	}
+
+	fwnode_for_each_available_child_node(ports, portnp) {
+		int phy_mode;
+		u32 p;
+
+		num_ports++;
+
+		if (num_ports > max_ports) {
+			dev_err(dev,
+				"Too many ports in device tree. Max ports supported by SKU: %d\n",
+				max_ports);
+			err = -ENODEV;
+			goto err_free_ports;
+		}
+
+		if (fwnode_property_read_u32(portnp, "reg", &p)) {
+			dev_err(dev, "Port number not defined in device tree (property \"reg\")\n");
+			err = -ENODEV;
+			fwnode_handle_put(portnp);
+			goto err_free_ports;
+		}
+
+		if (p >= lan9645x->num_phys_ports) {
+			dev_err(dev,
+				"Port number in device tree is invalid %u (property \"reg\")\n",
+				p);
+			err = -ENODEV;
+			fwnode_handle_put(portnp);
+			goto err_free_ports;
+		}
+
+		phy_mode = fwnode_get_phy_mode(portnp);
+		if (phy_mode < 0) {
+			dev_err(dev, "Failed to read phy-mode for port %u", p);
+			err = -ENODEV;
+			fwnode_handle_put(portnp);
+			goto err_free_ports;
+		}
+
+		lan9645x->ports[p]->phy_mode = phy_mode;
+		lan9645x_port_parse_delays(lan9645x->ports[p], portnp);
+		lan9645x_port_setup_leds(lan9645x, portnp, p);
+	}
+
+err_free_ports:
+	fwnode_handle_put(ports);
+	return err;
+}
diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index ee046468652c..740f3c2e8199 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -62,5 +62,6 @@ source "drivers/net/ethernet/microchip/lan966x/Kconfig"
 source "drivers/net/ethernet/microchip/sparx5/Kconfig"
 source "drivers/net/ethernet/microchip/vcap/Kconfig"
 source "drivers/net/ethernet/microchip/fdma/Kconfig"
+source "drivers/net/dsa/microchip/lan9645x/Kconfig"
 
 endif # NET_VENDOR_MICROCHIP

-- 
2.52.0


