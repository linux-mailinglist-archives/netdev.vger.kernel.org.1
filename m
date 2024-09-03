Return-Path: <netdev+bounces-124494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC41969AC4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7428D2858B5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378221C9857;
	Tue,  3 Sep 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2YCIL1R9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE511B985C;
	Tue,  3 Sep 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360607; cv=none; b=ZMkeQhREc6eNL2TR1yv6K/+3oN5t+bDr+O32r1qlWrIt3Sq7Q81dCJWqMwuLM8BiW8+Ix23wq9WO46fFmOyNhlP40wUyCXursJtjrn4bBDBq7l/H4A6B30mJGhV7C7vhHYk1CNy6HJ5AONjepAFGaQv6mb6ISVi8/OhJrnZup6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360607; c=relaxed/simple;
	bh=fv6FDMX8fe9kTe5hDtVBJCePEbnK+SHetD5ZLDEX41Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVA+WK0HTqTktMOJ8qN9/xcLDcjj/F4royp2Q6IpS+BHGumoaaY/zktXbZWqblCTdzmeBddRdmFIzrhyjsYOTomEWOh7jR+7KKndQItBf7ptoNZGdW2Jl4xrCBi+lIBK18WHmtG7fsjqRzPb3o6Kz/GCLBRSVHEGV/q51Ow3h4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2YCIL1R9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725360605; x=1756896605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fv6FDMX8fe9kTe5hDtVBJCePEbnK+SHetD5ZLDEX41Y=;
  b=2YCIL1R9fiFrxVoQzxNarxr3nfRcpWttz0M6vGRXmVkVAV9tibTRnp/k
   7JsHYEqlF9vHcEYKP0Z8iC2tjgGNm7WPK97LatNy6nnfw+3sC/szklZdm
   WEryUgovz3gE7EzFwzs6rS+LX6B/YN/lrL0NpVbdH3dfNPvrPdUim/bHQ
   GiWF3QDcR5mdqhkUC4+muKm4PIYlB7ZJunI2bqzkAClIpn0/J0bkAesMY
   A3BDv648yE5uS+ZOXcbsfk6Ljt17kWolNNiazaruACG3088v5M2mHcnnP
   RaxsqXHFTfGbNogjC05bVfl6D0gmDOZBKwqKIfd0jjlBUSkDClYJx82hT
   Q==;
X-CSE-ConnectionGUID: /L46bepbTPyfYHrKhIsMng==
X-CSE-MsgGUID: wgXzihcsSIiVYCYBO4MukQ==
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="34314908"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 03:50:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 03:49:44 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 03:49:34 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v7 13/14] microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY
Date: Tue, 3 Sep 2024 16:17:04 +0530
Message-ID: <20240903104705.378684-14-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
References: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE-T1x
MAC-PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
MAC integration provides the low pin count standard SPI interface to any
microcontroller therefore providing Ethernet functionality without
requiring MAC integration within the microcontroller. The LAN8650/1
operates as an SPI client supporting SCLK clock rates up to a maximum of
25 MHz. This SPI interface supports the transfer of both data (Ethernet
frames) and control (register access).

By default, the chunk data payload is 64 bytes in size. The Ethernet
Media Access Controller (MAC) module implements a 10 Mbps half duplex
Ethernet MAC, compatible with the IEEE 802.3 standard. 10BASE-T1S
physical layer transceiver integrated is into the LAN8650/1. The PHY and
MAC are connected via an internal Media Independent Interface (MII).

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 MAINTAINERS                                   |   6 +
 drivers/net/ethernet/microchip/Kconfig        |   1 +
 drivers/net/ethernet/microchip/Makefile       |   1 +
 .../net/ethernet/microchip/lan865x/Kconfig    |  19 +
 .../net/ethernet/microchip/lan865x/Makefile   |   6 +
 .../net/ethernet/microchip/lan865x/lan865x.c  | 429 ++++++++++++++++++
 6 files changed, 462 insertions(+)
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Kconfig
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Makefile
 create mode 100644 drivers/net/ethernet/microchip/lan865x/lan865x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 425cf537095e..934a81151530 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14965,6 +14965,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
+M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/microchip/lan865x/lan865x.c
+
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
 M:	Arun Ramadoss <arun.ramadoss@microchip.com>
 R:	UNGLinuxDriver@microchip.com
diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 43ba71e82260..06ca79669053 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -56,6 +56,7 @@ config LAN743X
 	  To compile this driver as a module, choose M here. The module will be
 	  called lan743x.
 
+source "drivers/net/ethernet/microchip/lan865x/Kconfig"
 source "drivers/net/ethernet/microchip/lan966x/Kconfig"
 source "drivers/net/ethernet/microchip/sparx5/Kconfig"
 source "drivers/net/ethernet/microchip/vcap/Kconfig"
diff --git a/drivers/net/ethernet/microchip/Makefile b/drivers/net/ethernet/microchip/Makefile
index bbd349264e6f..15dfbb321057 100644
--- a/drivers/net/ethernet/microchip/Makefile
+++ b/drivers/net/ethernet/microchip/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_LAN743X) += lan743x.o
 
 lan743x-objs := lan743x_main.o lan743x_ethtool.o lan743x_ptp.o
 
+obj-$(CONFIG_LAN865X) += lan865x/
 obj-$(CONFIG_LAN966X_SWITCH) += lan966x/
 obj-$(CONFIG_SPARX5_SWITCH) += sparx5/
 obj-$(CONFIG_VCAP) += vcap/
diff --git a/drivers/net/ethernet/microchip/lan865x/Kconfig b/drivers/net/ethernet/microchip/lan865x/Kconfig
new file mode 100644
index 000000000000..7f2a4e7e1915
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan865x/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Microchip LAN865x Driver Support
+#
+
+if NET_VENDOR_MICROCHIP
+
+config LAN865X
+	tristate "LAN865x support"
+	depends on SPI
+	select OA_TC6
+	help
+	  Support for the Microchip LAN8650/1 Rev.B0/B1 MACPHY Ethernet chip. It
+	  uses OPEN Alliance 10BASE-T1x Serial Interface specification.
+
+	  To compile this driver as a module, choose M here. The module will be
+	  called lan865x.
+
+endif # NET_VENDOR_MICROCHIP
diff --git a/drivers/net/ethernet/microchip/lan865x/Makefile b/drivers/net/ethernet/microchip/lan865x/Makefile
new file mode 100644
index 000000000000..9f5dd89c1eb8
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan865x/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the Microchip LAN865x Driver
+#
+
+obj-$(CONFIG_LAN865X) += lan865x.o
diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
new file mode 100644
index 000000000000..dd436bdff0f8
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Microchip's LAN865x 10BASE-T1S MAC-PHY driver
+ *
+ * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/phy.h>
+#include <linux/oa_tc6.h>
+
+#define DRV_NAME			"lan8650"
+
+/* MAC Network Control Register */
+#define LAN865X_REG_MAC_NET_CTL		0x00010000
+#define MAC_NET_CTL_TXEN		BIT(3) /* Transmit Enable */
+#define MAC_NET_CTL_RXEN		BIT(2) /* Receive Enable */
+
+/* MAC Network Configuration Reg */
+#define LAN865X_REG_MAC_NET_CFG		0x00010001
+#define MAC_NET_CFG_PROMISCUOUS_MODE	BIT(4)
+#define MAC_NET_CFG_MULTICAST_MODE	BIT(6)
+#define MAC_NET_CFG_UNICAST_MODE	BIT(7)
+
+/* MAC Hash Register Bottom */
+#define LAN865X_REG_MAC_L_HASH		0x00010020
+/* MAC Hash Register Top */
+#define LAN865X_REG_MAC_H_HASH		0x00010021
+/* MAC Specific Addr 1 Bottom Reg */
+#define LAN865X_REG_MAC_L_SADDR1	0x00010022
+/* MAC Specific Addr 1 Top Reg */
+#define LAN865X_REG_MAC_H_SADDR1	0x00010023
+
+struct lan865x_priv {
+	struct work_struct multicast_work;
+	struct net_device *netdev;
+	struct spi_device *spi;
+	struct oa_tc6 *tc6;
+};
+
+static int lan865x_set_hw_macaddr_low_bytes(struct oa_tc6 *tc6, const u8 *mac)
+{
+	u32 regval;
+
+	regval = (mac[3] << 24) | (mac[2] << 16) | (mac[1] << 8) | mac[0];
+
+	return oa_tc6_write_register(tc6, LAN865X_REG_MAC_L_SADDR1, regval);
+}
+
+static int lan865x_set_hw_macaddr(struct lan865x_priv *priv, const u8 *mac)
+{
+	int restore_ret;
+	u32 regval;
+	int ret;
+
+	/* Configure MAC address low bytes */
+	ret = lan865x_set_hw_macaddr_low_bytes(priv->tc6, mac);
+	if (ret)
+		return ret;
+
+	/* Prepare and configure MAC address high bytes */
+	regval = (mac[5] << 8) | mac[4];
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_SADDR1,
+				    regval);
+	if (!ret)
+		return 0;
+
+	/* Restore the old MAC address low bytes from netdev if the new MAC
+	 * address high bytes setting failed.
+	 */
+	restore_ret = lan865x_set_hw_macaddr_low_bytes(priv->tc6,
+						       priv->netdev->dev_addr);
+	if (restore_ret)
+		return restore_ret;
+
+	return ret;
+}
+
+static const struct ethtool_ops lan865x_ethtool_ops = {
+	.get_link_ksettings = phy_ethtool_get_link_ksettings,
+	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+};
+
+static int lan865x_set_mac_address(struct net_device *netdev, void *addr)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	struct sockaddr *address = addr;
+	int ret;
+
+	ret = eth_prepare_mac_addr_change(netdev, addr);
+	if (ret < 0)
+		return ret;
+
+	if (ether_addr_equal(address->sa_data, netdev->dev_addr))
+		return 0;
+
+	ret = lan865x_set_hw_macaddr(priv, address->sa_data);
+	if (ret)
+		return ret;
+
+	eth_commit_mac_addr_change(netdev, addr);
+
+	return 0;
+}
+
+static u32 get_address_bit(u8 addr[ETH_ALEN], u32 bit)
+{
+	return ((addr[bit / 8]) >> (bit % 8)) & 1;
+}
+
+static u32 lan865x_hash(u8 addr[ETH_ALEN])
+{
+	u32 hash_index = 0;
+
+	for (int i = 0; i < 6; i++) {
+		u32 hash = 0;
+
+		for (int j = 0; j < 8; j++)
+			hash ^= get_address_bit(addr, (j * 6) + i);
+
+		hash_index |= (hash << i);
+	}
+
+	return hash_index;
+}
+
+static int lan865x_set_specific_multicast_addr(struct lan865x_priv *priv)
+{
+	struct netdev_hw_addr *ha;
+	u32 hash_lo = 0;
+	u32 hash_hi = 0;
+	int ret;
+
+	netdev_for_each_mc_addr(ha, priv->netdev) {
+		u32 bit_num = lan865x_hash(ha->addr);
+
+		if (bit_num >= BIT(5))
+			hash_hi |= (1 << (bit_num - BIT(5)));
+		else
+			hash_lo |= (1 << bit_num);
+	}
+
+	/* Enabling specific multicast addresses */
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH, hash_hi);
+	if (ret) {
+		netdev_err(priv->netdev, "Failed to write reg_hashh: %d\n",
+			   ret);
+		return ret;
+	}
+
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH, hash_lo);
+	if (ret)
+		netdev_err(priv->netdev, "Failed to write reg_hashl: %d\n",
+			   ret);
+
+	return ret;
+}
+
+static int lan865x_set_all_multicast_addr(struct lan865x_priv *priv)
+{
+	int ret;
+
+	/* Enabling all multicast addresses */
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH,
+				    0xffffffff);
+	if (ret) {
+		netdev_err(priv->netdev, "Failed to write reg_hashh: %d\n",
+			   ret);
+		return ret;
+	}
+
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH,
+				    0xffffffff);
+	if (ret)
+		netdev_err(priv->netdev, "Failed to write reg_hashl: %d\n",
+			   ret);
+
+	return ret;
+}
+
+static int lan865x_clear_all_multicast_addr(struct lan865x_priv *priv)
+{
+	int ret;
+
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH, 0);
+	if (ret) {
+		netdev_err(priv->netdev, "Failed to write reg_hashh: %d\n",
+			   ret);
+		return ret;
+	}
+
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH, 0);
+	if (ret)
+		netdev_err(priv->netdev, "Failed to write reg_hashl: %d\n",
+			   ret);
+
+	return ret;
+}
+
+static void lan865x_multicast_work_handler(struct work_struct *work)
+{
+	struct lan865x_priv *priv = container_of(work, struct lan865x_priv,
+						 multicast_work);
+	u32 regval = 0;
+	int ret;
+
+	if (priv->netdev->flags & IFF_PROMISC) {
+		/* Enabling promiscuous mode */
+		regval |= MAC_NET_CFG_PROMISCUOUS_MODE;
+		regval &= (~MAC_NET_CFG_MULTICAST_MODE);
+		regval &= (~MAC_NET_CFG_UNICAST_MODE);
+	} else if (priv->netdev->flags & IFF_ALLMULTI) {
+		/* Enabling all multicast mode */
+		if (lan865x_set_all_multicast_addr(priv))
+			return;
+
+		regval &= (~MAC_NET_CFG_PROMISCUOUS_MODE);
+		regval |= MAC_NET_CFG_MULTICAST_MODE;
+		regval &= (~MAC_NET_CFG_UNICAST_MODE);
+	} else if (!netdev_mc_empty(priv->netdev)) {
+		/* Enabling specific multicast mode */
+		if (lan865x_set_specific_multicast_addr(priv))
+			return;
+
+		regval &= (~MAC_NET_CFG_PROMISCUOUS_MODE);
+		regval |= MAC_NET_CFG_MULTICAST_MODE;
+		regval &= (~MAC_NET_CFG_UNICAST_MODE);
+	} else {
+		/* Enabling local mac address only */
+		if (lan865x_clear_all_multicast_addr(priv))
+			return;
+	}
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CFG, regval);
+	if (ret)
+		netdev_err(priv->netdev, "Failed to enable promiscuous/multicast/normal mode: %d\n",
+			   ret);
+}
+
+static void lan865x_set_multicast_list(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+
+	schedule_work(&priv->multicast_work);
+}
+
+static netdev_tx_t lan865x_send_packet(struct sk_buff *skb,
+				       struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+
+	return oa_tc6_start_xmit(priv->tc6, skb);
+}
+
+static int lan865x_hw_disable(struct lan865x_priv *priv)
+{
+	u32 regval;
+
+	if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, &regval))
+		return -ENODEV;
+
+	regval &= ~(MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN);
+
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int lan865x_net_close(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	netif_stop_queue(netdev);
+	phy_stop(netdev->phydev);
+	ret = lan865x_hw_disable(priv);
+	if (ret) {
+		netdev_err(netdev, "Failed to disable the hardware: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lan865x_hw_enable(struct lan865x_priv *priv)
+{
+	u32 regval;
+
+	if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, &regval))
+		return -ENODEV;
+
+	regval |= MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN;
+
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int lan865x_net_open(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	ret = lan865x_hw_enable(priv);
+	if (ret) {
+		netdev_err(netdev, "Failed to enable hardware: %d\n", ret);
+		return ret;
+	}
+
+	phy_start(netdev->phydev);
+
+	return 0;
+}
+
+static const struct net_device_ops lan865x_netdev_ops = {
+	.ndo_open		= lan865x_net_open,
+	.ndo_stop		= lan865x_net_close,
+	.ndo_start_xmit		= lan865x_send_packet,
+	.ndo_set_rx_mode	= lan865x_set_multicast_list,
+	.ndo_set_mac_address	= lan865x_set_mac_address,
+};
+
+static int lan865x_probe(struct spi_device *spi)
+{
+	struct net_device *netdev;
+	struct lan865x_priv *priv;
+	int ret;
+
+	netdev = alloc_etherdev(sizeof(struct lan865x_priv));
+	if (!netdev)
+		return -ENOMEM;
+
+	priv = netdev_priv(netdev);
+	priv->netdev = netdev;
+	priv->spi = spi;
+	spi_set_drvdata(spi, priv);
+	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
+
+	priv->tc6 = oa_tc6_init(spi, netdev);
+	if (!priv->tc6) {
+		ret = -ENODEV;
+		goto free_netdev;
+	}
+
+	/* As per the point s3 in the below errata, SPI receive Ethernet frame
+	 * transfer may halt when starting the next frame in the same data block
+	 * (chunk) as the end of a previous frame. The RFA field should be
+	 * configured to 01b or 10b for proper operation. In these modes, only
+	 * one receive Ethernet frame will be placed in a single data block.
+	 * When the RFA field is written to 01b, received frames will be forced
+	 * to only start in the first word of the data block payload (SWO=0). As
+	 * recommended, enable zero align receive frame feature for proper
+	 * operation.
+	 *
+	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/Errata/LAN8650-1-Errata-80001075.pdf
+	 */
+	ret = oa_tc6_zero_align_receive_frame_enable(priv->tc6);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to set ZARFE: %d\n", ret);
+		goto oa_tc6_exit;
+	}
+
+	/* Get the MAC address from the SPI device tree node */
+	if (device_get_ethdev_address(&spi->dev, netdev))
+		eth_hw_addr_random(netdev);
+
+	ret = lan865x_set_hw_macaddr(priv, netdev->dev_addr);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to configure MAC: %d\n", ret);
+		goto oa_tc6_exit;
+	}
+
+	netdev->if_port = IF_PORT_10BASET;
+	netdev->irq = spi->irq;
+	netdev->netdev_ops = &lan865x_netdev_ops;
+	netdev->ethtool_ops = &lan865x_ethtool_ops;
+
+	ret = register_netdev(netdev);
+	if (ret) {
+		dev_err(&spi->dev, "Register netdev failed (ret = %d)", ret);
+		goto oa_tc6_exit;
+	}
+
+	return 0;
+
+oa_tc6_exit:
+	oa_tc6_exit(priv->tc6);
+free_netdev:
+	free_netdev(priv->netdev);
+	return ret;
+}
+
+static void lan865x_remove(struct spi_device *spi)
+{
+	struct lan865x_priv *priv = spi_get_drvdata(spi);
+
+	cancel_work_sync(&priv->multicast_work);
+	unregister_netdev(priv->netdev);
+	oa_tc6_exit(priv->tc6);
+	free_netdev(priv->netdev);
+}
+
+static const struct spi_device_id spidev_spi_ids[] = {
+	{ .name = "lan8650" },
+	{},
+};
+
+static const struct of_device_id lan865x_dt_ids[] = {
+	{ .compatible = "microchip,lan8650" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
+
+static struct spi_driver lan865x_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = lan865x_dt_ids,
+	 },
+	.probe = lan865x_probe,
+	.remove = lan865x_remove,
+	.id_table = spidev_spi_ids,
+};
+module_spi_driver(lan865x_driver);
+
+MODULE_DESCRIPTION(DRV_NAME " 10Base-T1S MACPHY Ethernet Driver");
+MODULE_AUTHOR("Parthiban Veerasooran <parthiban.veerasooran@microchip.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1


