Return-Path: <netdev+bounces-144593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38BF9C7D70
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 22:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720672857F3
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767032123EA;
	Wed, 13 Nov 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AYFhRL6o"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C420C33B;
	Wed, 13 Nov 2024 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532350; cv=none; b=JdFqdPrzoMQjijF/Zeo7yFppzPFqvd6SwiUmEfJ0e7MyCo0HZxo4fIaMB5rpPm/lfwnV2AOkOYs97jacVy0TwbHH1aMM2HWjMPmbVB704JvXKpQssy3KY0j4nf2O69XhltNTMRH80vWSgGUkiy0rT2pw6zgfkzBf3ornVjCHmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532350; c=relaxed/simple;
	bh=2qCjpEJYShIx/sj1pC5fR56LXn0Fxs6FgjIMYfk/Txk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rYUHjKYSIRygGkF9qqlJnkFLcz5FQV03EQxo4D8BZUlue3wOHVcyKL9ymjWJSmGltSqvEUfGQHyyHT7NKGtaOwC1L1xMhtlT87vTNID6IPF1SK9yUdSNFc03h0xgp/BwznMb7iF3iMD42ACxOXtYdBVphox0wCAkkiytu6xftpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AYFhRL6o; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731532348; x=1763068348;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2qCjpEJYShIx/sj1pC5fR56LXn0Fxs6FgjIMYfk/Txk=;
  b=AYFhRL6ofWxPqy8Zj7Vc0yLIJaHvL1MYNrp9RjhF5bfPFuHfcGvW1X7L
   SxRMwPw0hSdjpw+GTiW/g1fiRGxz27gz3ObHEuTINcBMm97/pxGXduKwM
   uVRmMx9Bzh0yWRCx1j13yO6VbZxWveRA5OHOTiUlqReElS/UOGk5jBTiv
   9GcIrR+knbghBp+7Cc19oOqMQCeqs9+uxcstM38aqIWHKCCU2w1MTptoU
   JHlXZ/Qm43Qcyi+QIBC318NCstgF9uxLjoi3KHazYWNRFpbvruCKnMUGJ
   iHmyI2SLrCRZIdZreK9eBJSPXVFQLUpcwzxQCFmZpB+9TWtXJy4KCsRVy
   A==;
X-CSE-ConnectionGUID: vQdPcQJhS0S1px+vMo5fhw==
X-CSE-MsgGUID: 1RTdRI1nTPmDpstT58ipgA==
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="37813508"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2024 14:12:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Nov 2024 14:11:56 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 13 Nov 2024 14:11:53 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 13 Nov 2024 22:11:15 +0100
Subject: [PATCH net-next v2 7/8] net: lan969x: add RGMII implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241113-sparx5-lan969x-switch-driver-4-v2-7-0db98ac096d1@microchip.com>
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
In-Reply-To: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

The lan969x switch device includes two RGMII interfaces (port 28 and 29)
supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps. MAC level delays
are configurable through the HSIO_WRAP target, by choosing a phase shift
selector, corresponding to a certain time delay in nano seconds.

Add new file: lan969x_rgmii.c that contains the implementation for
configuring the RGMII port devices. MAC level delays are configured
using the "{rx,tx}-internal-delay-ps" properties. These properties are
required (documented in dt-bindings in a subsequent patch), and must be
specified independently of the phy-mode (e.g. regardless of what the
RGMII phy-mode is set to).

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan969x/Makefile    |   2 +-
 drivers/net/ethernet/microchip/lan969x/lan969x.c   |   1 +
 drivers/net/ethernet/microchip/lan969x/lan969x.h   |   5 +
 .../net/ethernet/microchip/lan969x/lan969x_rgmii.c | 237 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   2 +
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   6 +
 6 files changed, 252 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan969x/Makefile b/drivers/net/ethernet/microchip/lan969x/Makefile
index 9a2351b4f111..d405234488b3 100644
--- a/drivers/net/ethernet/microchip/lan969x/Makefile
+++ b/drivers/net/ethernet/microchip/lan969x/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_LAN969X_SWITCH) += lan969x-switch.o
 
 lan969x-switch-y := lan969x_regs.o lan969x.o lan969x_calendar.o \
- lan969x_vcap_ag_api.o lan969x_vcap_impl.o
+ lan969x_vcap_ag_api.o lan969x_vcap_impl.o lan969x_rgmii.o
 
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
index 4dce88e23a24..aaa5d4dc1d52 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
@@ -340,6 +340,7 @@ static const struct sparx5_ops lan969x_ops = {
 	.set_port_mux            = &lan969x_port_mux_set,
 	.ptp_irq_handler         = &lan969x_ptp_irq_handler,
 	.dsm_calendar_calc       = &lan969x_dsm_calendar_calc,
+	.port_config_rgmii       = &lan969x_port_config_rgmii,
 };
 
 const struct sparx5_match_data lan969x_desc = {
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.h b/drivers/net/ethernet/microchip/lan969x/lan969x.h
index 4b91c47d6d21..9a7ddebecf1e 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.h
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.h
@@ -67,4 +67,9 @@ static inline bool lan969x_port_is_rgmii(int portno)
 /* lan969x_calendar.c */
 int lan969x_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
 			      struct sparx5_calendar_data *data);
+
+/* lan969x_rgmii.c */
+int lan969x_port_config_rgmii(struct sparx5_port *port,
+			      struct sparx5_port_config *conf);
+
 #endif
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x_rgmii.c b/drivers/net/ethernet/microchip/lan969x/lan969x_rgmii.c
new file mode 100644
index 000000000000..b2d6e2d54fdb
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x_rgmii.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip lan969x Switch driver
+ *
+ * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include "lan969x.h"
+
+/* Tx clock selectors */
+#define LAN969X_RGMII_TX_CLK_SEL_125MHZ 1  /* 1000Mbps */
+#define LAN969X_RGMII_TX_CLK_SEL_25MHZ  2  /* 100Mbps */
+#define LAN969X_RGMII_TX_CLK_SEL_2M5MHZ 3  /* 10Mbps */
+
+/* Port speed selectors */
+#define LAN969X_RGMII_SPEED_SEL_10 0   /* Select 10Mbps speed */
+#define LAN969X_RGMII_SPEED_SEL_100 1  /* Select 100Mbps speed */
+#define LAN969X_RGMII_SPEED_SEL_1000 2 /* Select 1000Mbps speed */
+
+/* Clock delay selectors */
+#define LAN969X_RGMII_CLK_DELAY_SEL_1_0_NS 2  /* Phase shift 45deg */
+#define LAN969X_RGMII_CLK_DELAY_SEL_1_7_NS 3  /* Phase shift 77deg */
+#define LAN969X_RGMII_CLK_DELAY_SEL_2_0_NS 4  /* Phase shift 90deg */
+#define LAN969X_RGMII_CLK_DELAY_SEL_2_5_NS 5  /* Phase shift 112deg */
+#define LAN969X_RGMII_CLK_DELAY_SEL_3_0_NS 6  /* Phase shift 135deg */
+#define LAN969X_RGMII_CLK_DELAY_SEL_3_3_NS 7  /* Phase shift 147deg */
+
+#define LAN969X_RGMII_PORT_START_IDX 28 /* Index of the first RGMII port */
+#define LAN969X_RGMII_IFG_TX 4          /* TX Inter Frame Gap value */
+#define LAN969X_RGMII_IFG_RX1 5         /* RX1 Inter Frame Gap value */
+#define LAN969X_RGMII_IFG_RX2 1         /* RX2 Inter Frame Gap value */
+
+#define RGMII_PORT_IDX(port) ((port)->portno - LAN969X_RGMII_PORT_START_IDX)
+
+/* Get the tx clock selector based on the port speed. */
+static int lan969x_rgmii_get_clk_sel(int speed)
+{
+	return (speed == SPEED_10  ? LAN969X_RGMII_TX_CLK_SEL_2M5MHZ :
+		speed == SPEED_100 ? LAN969X_RGMII_TX_CLK_SEL_25MHZ :
+				     LAN969X_RGMII_TX_CLK_SEL_125MHZ);
+}
+
+/* Get the port speed selector based on the port speed. */
+static int lan969x_rgmii_get_speed_sel(int speed)
+{
+	return (speed == SPEED_10  ? LAN969X_RGMII_SPEED_SEL_10 :
+		speed == SPEED_100 ? LAN969X_RGMII_SPEED_SEL_100 :
+				     LAN969X_RGMII_SPEED_SEL_1000);
+}
+
+/* Get the clock delay selector based on the clock delay in picoseconds. */
+static int lan969x_rgmii_get_clk_delay_sel(struct sparx5_port *port,
+					   u32 delay_ps, u32 *clk_delay_sel)
+{
+	switch (delay_ps) {
+	case 0:
+		/* Hardware default selector. */
+		*clk_delay_sel = LAN969X_RGMII_CLK_DELAY_SEL_2_5_NS;
+		break;
+	case 1000:
+		*clk_delay_sel = LAN969X_RGMII_CLK_DELAY_SEL_1_0_NS;
+		break;
+	case 1700:
+		*clk_delay_sel = LAN969X_RGMII_CLK_DELAY_SEL_1_7_NS;
+		break;
+	case 2000:
+		*clk_delay_sel = LAN969X_RGMII_CLK_DELAY_SEL_2_0_NS;
+		break;
+	case 2500:
+		*clk_delay_sel = LAN969X_RGMII_CLK_DELAY_SEL_2_5_NS;
+		break;
+	case 3000:
+		*clk_delay_sel = LAN969X_RGMII_CLK_DELAY_SEL_3_0_NS;
+		break;
+	case 3300:
+		*clk_delay_sel = LAN969X_RGMII_CLK_DELAY_SEL_3_3_NS;
+		break;
+	default:
+		dev_err(port->sparx5->dev, "Invalid RGMII delay: %u", delay_ps);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Configure the RGMII tx clock frequency. */
+static void lan969x_rgmii_tx_clk_config(struct sparx5_port *port,
+					struct sparx5_port_config *conf)
+{
+	u32 clk_sel = lan969x_rgmii_get_clk_sel(conf->speed);
+	u32 idx = RGMII_PORT_IDX(port);
+
+	/* Take the RGMII clock domain out of reset and set tx clock
+	 * frequency.
+	 */
+	spx5_rmw(HSIO_WRAP_RGMII_CFG_TX_CLK_CFG_SET(clk_sel) |
+		 HSIO_WRAP_RGMII_CFG_RGMII_TX_RST_SET(0) |
+		 HSIO_WRAP_RGMII_CFG_RGMII_RX_RST_SET(0),
+		 HSIO_WRAP_RGMII_CFG_TX_CLK_CFG |
+		 HSIO_WRAP_RGMII_CFG_RGMII_TX_RST |
+		 HSIO_WRAP_RGMII_CFG_RGMII_RX_RST,
+		 port->sparx5, HSIO_WRAP_RGMII_CFG(idx));
+}
+
+/* Configure the RGMII port device. */
+static void lan969x_rgmii_port_device_config(struct sparx5_port *port,
+					     struct sparx5_port_config *conf)
+{
+	u32 dtag, dotag, etype, speed_sel, idx = RGMII_PORT_IDX(port);
+
+	speed_sel = lan969x_rgmii_get_speed_sel(conf->speed);
+
+	etype = (port->vlan_type == SPX5_VLAN_PORT_TYPE_S_CUSTOM ?
+		 port->custom_etype :
+		 port->vlan_type == SPX5_VLAN_PORT_TYPE_C ?
+		 ETH_P_8021Q : ETH_P_8021AD);
+
+	dtag = port->max_vlan_tags == SPX5_PORT_MAX_TAGS_TWO;
+	dotag = port->max_vlan_tags != SPX5_PORT_MAX_TAGS_NONE;
+
+	/* Enable the MAC. */
+	spx5_wr(DEVRGMII_MAC_ENA_CFG_RX_ENA_SET(1) |
+		DEVRGMII_MAC_ENA_CFG_TX_ENA_SET(1),
+		port->sparx5, DEVRGMII_MAC_ENA_CFG(idx));
+
+	/* Configure the Inter Frame Gap. */
+	spx5_wr(DEVRGMII_MAC_IFG_CFG_TX_IFG_SET(LAN969X_RGMII_IFG_TX) |
+		DEVRGMII_MAC_IFG_CFG_RX_IFG1_SET(LAN969X_RGMII_IFG_RX1) |
+		DEVRGMII_MAC_IFG_CFG_RX_IFG2_SET(LAN969X_RGMII_IFG_RX2),
+		port->sparx5, DEVRGMII_MAC_IFG_CFG(idx));
+
+	/* Configure port data rate. */
+	spx5_wr(DEVRGMII_DEV_RST_CTRL_SPEED_SEL_SET(speed_sel),
+		port->sparx5, DEVRGMII_DEV_RST_CTRL(idx));
+
+	/* Configure VLAN awareness. */
+	spx5_wr(DEVRGMII_MAC_TAGS_CFG_TAG_ID_SET(etype) |
+		DEVRGMII_MAC_TAGS_CFG_PB_ENA_SET(dtag) |
+		DEVRGMII_MAC_TAGS_CFG_VLAN_AWR_ENA_SET(dotag) |
+		DEVRGMII_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA_SET(dotag),
+		port->sparx5,
+		DEVRGMII_MAC_TAGS_CFG(idx));
+}
+
+/* Configure the RGMII delay lines in the MAC.
+ *
+ * We use the rx-internal-delay-ps" and "tx-internal-delay-ps" properties to
+ * configure the rx and tx delays for the MAC. These properties are required
+ * so we bail out if they are missing. If set to zero, the MAC will not apply
+ * any delay.
+ *
+ * The PHY side delays are determined by the PHY mode
+ * (e.g. PHY_INTERFACE_MODE_RGMII_{ID, RXID, TXID}), and ignored by the MAC side
+ * entirely.
+ */
+static int lan969x_rgmii_delay_config(struct sparx5_port *port,
+				      struct sparx5_port_config *conf)
+{
+	u32 tx_clk_sel, rx_clk_sel, tx_delay_ps, rx_delay_ps;
+	u32 idx = RGMII_PORT_IDX(port);
+	int err;
+
+	err = of_property_read_u32(port->of_node,
+				   "rx-internal-delay-ps",
+				   &rx_delay_ps);
+	if (err) {
+		dev_err(port->sparx5->dev,
+			"Missing or invalid property: rx-internal-delay-ps");
+		return err;
+	}
+
+	err = of_property_read_u32(port->of_node,
+				   "tx-internal-delay-ps",
+				   &tx_delay_ps);
+	if (err) {
+		dev_err(port->sparx5->dev,
+			"Missing or invalid property: tx-internal-delay-ps");
+		return err;
+	}
+
+	err = lan969x_rgmii_get_clk_delay_sel(port, rx_delay_ps, &rx_clk_sel);
+	if (err)
+		return err;
+
+	err = lan969x_rgmii_get_clk_delay_sel(port, tx_delay_ps, &tx_clk_sel);
+	if (err)
+		return err;
+
+	/* Configure rx delay. */
+	spx5_rmw(HSIO_WRAP_DLL_CFG_DLL_RST_SET(0) |
+		 HSIO_WRAP_DLL_CFG_DLL_ENA_SET(1) |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_ENA_SET(!!rx_delay_ps) |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_SEL_SET(rx_clk_sel),
+		 HSIO_WRAP_DLL_CFG_DLL_RST |
+		 HSIO_WRAP_DLL_CFG_DLL_ENA |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_ENA |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_SEL,
+		 port->sparx5, HSIO_WRAP_DLL_CFG(idx, 0));
+
+	/* Configure tx delay. */
+	spx5_rmw(HSIO_WRAP_DLL_CFG_DLL_RST_SET(0) |
+		 HSIO_WRAP_DLL_CFG_DLL_ENA_SET(1) |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_ENA_SET(!!tx_delay_ps) |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_SEL_SET(tx_clk_sel),
+		 HSIO_WRAP_DLL_CFG_DLL_RST |
+		 HSIO_WRAP_DLL_CFG_DLL_ENA |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_ENA |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_SEL,
+		 port->sparx5, HSIO_WRAP_DLL_CFG(idx, 1));
+
+	return 0;
+}
+
+/* Configure GPIO's to be used as RGMII interface. */
+static void lan969x_rgmii_gpio_config(struct sparx5_port *port)
+{
+	u32 idx = RGMII_PORT_IDX(port);
+
+	/* Enable the RGMII on the GPIOs. */
+	spx5_wr(HSIO_WRAP_XMII_CFG_GPIO_XMII_CFG_SET(1), port->sparx5,
+		HSIO_WRAP_XMII_CFG(!idx));
+}
+
+int lan969x_port_config_rgmii(struct sparx5_port *port,
+			      struct sparx5_port_config *conf)
+{
+	int err;
+
+	err = lan969x_rgmii_delay_config(port, conf);
+	if (err)
+		return err;
+
+	lan969x_rgmii_tx_clk_config(port, conf);
+	lan969x_rgmii_gpio_config(port);
+	lan969x_rgmii_port_device_config(port, conf);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index c58d7841638e..3ae760da17e2 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -324,6 +324,8 @@ struct sparx5_ops {
 	irqreturn_t (*ptp_irq_handler)(int irq, void *args);
 	int (*dsm_calendar_calc)(struct sparx5 *sparx5, u32 taxi,
 				 struct sparx5_calendar_data *data);
+	int (*port_config_rgmii)(struct sparx5_port *port,
+				 struct sparx5_port_config *conf);
 };
 
 struct sparx5_main_io_resource {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 9f0f687bd994..3d5026460e94 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -1012,6 +1012,12 @@ int sparx5_port_config(struct sparx5 *sparx5,
 	if (err)
 		return err;
 
+	if (rgmii) {
+		err = ops->port_config_rgmii(port, conf);
+		if (err)
+			return err;
+	}
+
 	/* high speed device is already configured */
 	if (!rgmii && !high_speed_dev)
 		sparx5_port_config_low_set(sparx5, port, conf);

-- 
2.34.1


