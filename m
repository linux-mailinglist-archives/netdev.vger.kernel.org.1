Return-Path: <netdev+bounces-153695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B6A9F93AF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB710188C5AC
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A883215F75;
	Fri, 20 Dec 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="enFiyGkf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92963215F72;
	Fri, 20 Dec 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702591; cv=none; b=bPP4S6kLmmF9yeJb47aicG7WSpZaPTa7lWpRmG7zgY12zdq0r5MF+3+MABSy3zQ7g+LkNl4QIG215cr/A7viT+SI6r/ppTvKG8esaJelaNFqy2HZ1kdp6tLDJl88eFV7ojGa8MOYKc9czazSj7vIApytwGZA7ilUnQ/Pf8J+y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702591; c=relaxed/simple;
	bh=/AAlOWqXJvyCKnhQKihQ9kRL2oD8o7tsFWsH8vmeVfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NIbiixwwklRxxsvwLalBmO703SE+Hh4el5dJGpEIEdD4NPMgvNVeZzdy2GWYZvHZ/K1QfFcAGHUAC52S8y3UWl+SVTKZeQ2Wra3/MQr6SHenBS8sZHltJbChNmef+SCKwGH06S2Xee31m+Mn7vIU40opehOZD0XjQrFpfc8ugIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=enFiyGkf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734702590; x=1766238590;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/AAlOWqXJvyCKnhQKihQ9kRL2oD8o7tsFWsH8vmeVfs=;
  b=enFiyGkf4f1nJuerJVK+06YudARZzTyljpP/aVuctR7HOJs4d792Mce4
   fuAZmd6sdoVIgKb87fV9X4T3CK0DB2ZMoSHLmOEpAQFCGf/JjuEtLU5C3
   SJzjPMKNbFQ1WnqO7wTOp1AY0GJYbos7QXOAiaE5CmeKP4Lqjo6tojVq7
   bO/iDbe69p/2dLu6fAbt7IcX6+k4KmvEXtZqYPCQvTrtyVTwnxUXxyK0i
   leEvToMjxxafyV7Cl/WNW/bhg9eEYqzwLf0VQIoV3s5jH7GkW8TuBq0/Q
   nikMt5bY5VD0gtO819B8mOxTyIcdsHctQd2K/V6DKibMttEG9jlVZeBeG
   g==;
X-CSE-ConnectionGUID: Lq5BqadMRMm7eOW5EpI9IQ==
X-CSE-MsgGUID: tnrVELYJS7a2kpAh4YFyYg==
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="35794896"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 06:49:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 06:49:18 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 06:49:15 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Dec 2024 14:48:47 +0100
Subject: [PATCH net-next v5 8/9] net: lan969x: add RGMII implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241220-sparx5-lan969x-switch-driver-4-v5-8-fa8ba5dff732@microchip.com>
References: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
In-Reply-To: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<robert.marko@sartura.hr>
X-Mailer: b4 0.14-dev

The lan969x switch device includes two RGMII port interfaces (port 28
and 29) supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps. MAC
level delays are configurable through the HSIO_WRAP target, by choosing
a phase shift selector, corresponding to a certain time delay in nano
seconds.

Add new file: lan969x_rgmii.c that contains the implementation for
configuring the RGMII port devices. MAC level delays are configured
using the "{rx,tx}-internal-delay-ps" properties. These properties must
be specified independently of the phy-mode. If missing, or set to zero,
the MAC will not apply any delay.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Tested-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/Makefile     |   3 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   1 +
 .../ethernet/microchip/sparx5/lan969x/lan969x.h    |   5 +
 .../microchip/sparx5/lan969x/lan969x_rgmii.c       | 224 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   2 +
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   6 +
 6 files changed, 240 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
index 4bf2a885a9da..3f34e83246a0 100644
--- a/drivers/net/ethernet/microchip/sparx5/Makefile
+++ b/drivers/net/ethernet/microchip/sparx5/Makefile
@@ -20,7 +20,8 @@ sparx5-switch-$(CONFIG_LAN969X_SWITCH) += lan969x/lan969x_regs.o \
 					  lan969x/lan969x.o \
 					  lan969x/lan969x_calendar.o \
 					  lan969x/lan969x_vcap_ag_api.o \
-					  lan969x/lan969x_vcap_impl.o
+					  lan969x/lan969x_vcap_impl.o \
+					  lan969x/lan969x_rgmii.o
 
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index be49a99556fe..396f76b6eea5 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -340,6 +340,7 @@ static const struct sparx5_ops lan969x_ops = {
 	.set_port_mux            = &lan969x_port_mux_set,
 	.ptp_irq_handler         = &lan969x_ptp_irq_handler,
 	.dsm_calendar_calc       = &lan969x_dsm_calendar_calc,
+	.port_config_rgmii       = &lan969x_port_config_rgmii,
 };
 
 const struct sparx5_match_data lan969x_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
index 4b91c47d6d21..9a7ddebecf1e 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
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
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
new file mode 100644
index 000000000000..4e422ca50828
--- /dev/null
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
@@ -0,0 +1,224 @@
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
+ * configure the rx and tx delays for the MAC. If these properties are missing
+ * or set to zero, the MAC will not apply any delay.
+ *
+ * The PHY side delays are determined by the PHY mode
+ * (e.g. PHY_INTERFACE_MODE_RGMII_{ID, RXID, TXID}), and ignored by the MAC side
+ * entirely.
+ */
+static int lan969x_rgmii_delay_config(struct sparx5_port *port,
+				      struct sparx5_port_config *conf)
+{
+	u32 tx_clk_sel, rx_clk_sel, tx_delay_ps = 0, rx_delay_ps = 0;
+	u32 idx = RGMII_PORT_IDX(port);
+	int err;
+
+	of_property_read_u32(port->of_node, "rx-internal-delay-ps",
+			     &rx_delay_ps);
+
+	of_property_read_u32(port->of_node, "tx-internal-delay-ps",
+			     &tx_delay_ps);
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
index 86d6c9e9ec7c..04bc8fffaf96 100644
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


