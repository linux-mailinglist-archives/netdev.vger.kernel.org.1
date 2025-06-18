Return-Path: <netdev+bounces-198880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29890ADE1D2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 05:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BFC3BE605
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F82121325A;
	Wed, 18 Jun 2025 03:42:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804B1E832A;
	Wed, 18 Jun 2025 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750218124; cv=none; b=AoZQSrbv94fe+I5SHFezq3f1jt0MVXuB6mqRmPmghDhG0lvONS90XMNzkCixsWzlt8slRSx+8q6OmKKN4iBBcKfZdpM33/CDj2BZ2T0jELasDxPfeRV22vH07BgfPI+28r64JHaovOHXEY3hmptV0RP1R+oZZtB6UuJdxUqMvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750218124; c=relaxed/simple;
	bh=EN3lJz92CfpRj/oowOKFTFExyY96ByntV/lF1TqQmCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZGQ7qEq9Y7uFjQfO9/2mjaDrGWIHTwAEiBVOVCEDwpvGKeN8/jsRjhpkATCWLLZUjt4TH37oMAW3NtHLXCHAn9XKLAP/JAOaEFK37R8F9ZZIjJ7MwDekVO/yaNYMa5lXdceU6gakmeojXa/AMl4JlXzyXw551+5j2FZObgoxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowABnFtVpNVJoV95NBw--.6548S4;
	Wed, 18 Jun 2025 11:41:30 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 18 Jun 2025 11:40:47 +0800
Subject: [PATCH net-next v2 2/6] net: spacemit: Add K1 Ethernet MAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-net-k1-emac-v2-2-94f5f07227a8@iscas.ac.cn>
References: <20250618-net-k1-emac-v2-0-94f5f07227a8@iscas.ac.cn>
In-Reply-To: <20250618-net-k1-emac-v2-0-94f5f07227a8@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABnFtVpNVJoV95NBw--.6548S4
X-Coremail-Antispam: 1UD129KBjvAXoWDXryrJF13Jw43XF45Gw1DGFg_yoWxurWfKo
	WxXa9xtr1rJFyxZw4v9r1xXF17ZFnrZr1UGayrAFy8Wa9Fv3Wvk3y5Gw43Aw15ZFW5tFW5
	WF9Yq3ZxArWSyF95n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOD7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
	A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRW380UUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

The Ethernet MACs found on SpacemiT K1 appears to be a custom design
that only superficially resembles some other embedded MACs. SpacemiT
refers to them as "EMAC", so let's just call the driver "k1_emac".

This driver is based on "k1x-emac" in the same directory in the vendor's
tree [1]. Some debugging tunables have been fixed to vendor-recommended
defaults, and PTP support is not included yet.

[1]: https://github.com/spacemit-com/linux-k1x

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 drivers/net/ethernet/Kconfig            |    1 +
 drivers/net/ethernet/Makefile           |    1 +
 drivers/net/ethernet/spacemit/Kconfig   |   29 +
 drivers/net/ethernet/spacemit/Makefile  |    6 +
 drivers/net/ethernet/spacemit/k1_emac.c | 1934 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/spacemit/k1_emac.h |  416 +++++++
 6 files changed, 2387 insertions(+)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index f86d4557d8d7756a5e27bc17578353b5c19ca108..aead145dd91d129b7bb410f2d4d754c744dddbf4 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -188,6 +188,7 @@ source "drivers/net/ethernet/sis/Kconfig"
 source "drivers/net/ethernet/sfc/Kconfig"
 source "drivers/net/ethernet/smsc/Kconfig"
 source "drivers/net/ethernet/socionext/Kconfig"
+source "drivers/net/ethernet/spacemit/Kconfig"
 source "drivers/net/ethernet/stmicro/Kconfig"
 source "drivers/net/ethernet/sun/Kconfig"
 source "drivers/net/ethernet/sunplus/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 67182339469a0d8337cc4e92aa51e498c615156d..998dd628b202ced212748450753fe180f0440c74 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_NET_VENDOR_SOLARFLARE) += sfc/
 obj-$(CONFIG_NET_VENDOR_SGI) += sgi/
 obj-$(CONFIG_NET_VENDOR_SMSC) += smsc/
 obj-$(CONFIG_NET_VENDOR_SOCIONEXT) += socionext/
+obj-$(CONFIG_NET_VENDOR_SPACEMIT) += spacemit/
 obj-$(CONFIG_NET_VENDOR_STMICRO) += stmicro/
 obj-$(CONFIG_NET_VENDOR_SUN) += sun/
 obj-$(CONFIG_NET_VENDOR_SUNPLUS) += sunplus/
diff --git a/drivers/net/ethernet/spacemit/Kconfig b/drivers/net/ethernet/spacemit/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..85ef61a9b4eff4249ad2d32a6e7dbf283b0c180f
--- /dev/null
+++ b/drivers/net/ethernet/spacemit/Kconfig
@@ -0,0 +1,29 @@
+config NET_VENDOR_SPACEMIT
+	bool "SpacemiT devices"
+	default y
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	help
+	  If you have a network (Ethernet) device belonging to this class,
+	  say Y.
+
+	  Note that the answer to this question does not directly affect
+	  the kernel: saying N will just cause the configurator to skip all
+	  the questions regarding SpacemiT devices. If you say Y, you will
+	  be asked for your specific chipset/driver in the following questions.
+
+if NET_VENDOR_SPACEMIT
+
+config SPACEMIT_K1_EMAC
+	tristate "SpacemiT K1 Ethernet MAC driver"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	depends on MFD_SYSCON
+	depends on OF
+	default m if ARCH_SPACEMIT
+	select PHYLIB
+	help
+	  This driver supports the Ethernet MAC in the SpacemiT K1 SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called k1_emac.
+
+endif # NET_VENDOR_SPACEMIT
diff --git a/drivers/net/ethernet/spacemit/Makefile b/drivers/net/ethernet/spacemit/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..d29efd997a4ff5dcb50986e439997df7e3650570
--- /dev/null
+++ b/drivers/net/ethernet/spacemit/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the SpacemiT network device drivers.
+#
+
+obj-$(CONFIG_SPACEMIT_K1_EMAC) += k1_emac.o
diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
new file mode 100644
index 0000000000000000000000000000000000000000..7caa118fe343bd889a0d9cab42f59084bdc4d2a9
--- /dev/null
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -0,0 +1,1934 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SpacemiT K1 Ethernet driver
+ *
+ * Copyright (C) 2023-2025 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (C) 2025 Vivian Wang <wangruikang@iscas.ac.cn>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/rtnetlink.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+
+#include "k1_emac.h"
+
+#define DRIVER_NAME "k1_emac"
+
+#define EMAC_DEFAULT_BUFSIZE		1536
+#define EMAC_RX_BUF_2K			2048
+#define EMAC_RX_BUF_4K			4096
+
+#define MAX_DATA_LEN_TX_DES		2048
+
+/* The sizes (in bytes) of a ethernet packet */
+#define ETHERNET_HEADER_SIZE		14
+#define MINIMUM_ETHERNET_FRAME_SIZE	64 /* Incl. FCS */
+#define ETHERNET_FCS_SIZE		4
+
+/* Tuning parameters from SpacemiT */
+#define EMAC_TX_FRAMES			64
+#define EMAC_TX_COAL_TIMEOUT		40000
+#define EMAC_RX_FRAMES			64
+#define EMAC_RX_COAL_TIMEOUT		(600 * 312)
+
+#define DEFAULT_TX_ALMOST_FULL		0x1f8
+#define DEFAULT_TX_THRESHOLD		1518
+#define DEFAULT_RX_THRESHOLD		12
+#define DEFAULT_TX_RING_NUM		1024
+#define DEFAULT_RX_RING_NUM		1024
+#define DEFAULT_DMA_BURST		MREGBIT_BURST_16WORD
+#define HASH_TABLE_SIZE			64
+
+#define EMAC_DMA_REG_CNT		16
+#define EMAC_MAC_REG_CNT		124
+
+#define EMAC_REG_SPACE_SIZE ((EMAC_DMA_REG_CNT + EMAC_MAC_REG_CNT) * 4)
+
+enum rx_frame_status {
+	RX_FRAME_OK,
+	RX_FRAME_DISCARD,
+};
+
+struct desc_buf {
+	u64 dma_addr;
+	void *buff_addr;
+	u16 dma_len;
+	u8 map_as_page;
+};
+
+struct emac_tx_desc_buffer {
+	struct sk_buff *skb;
+	struct desc_buf buf[2];
+};
+
+struct emac_rx_desc_buffer {
+	struct sk_buff *skb;
+	u64 dma_addr;
+	void *buff_addr;
+	u16 dma_len;
+	u8 map_as_page;
+};
+
+/**
+ * struct emac_desc_ring - Software-side information for one descriptor ring
+ * Same struture used for both RX and TX
+ * @desc_addr: Virtual address to the descriptor ring memory
+ * @desc_dma_addr: DMA address of the descriptor ring
+ * @total_size: Size of ring in bytes
+ * @total_cnt: Number of descriptors
+ * @head: Next descriptor to associate a buffer with
+ * @tail: Next descriptor to check status bit
+ * @rx_desc_buf: Array of descriptors for RX
+ * @tx_desc_buf: Array of descriptors for TX, with max of two buffers each
+ */
+struct emac_desc_ring {
+	void *desc_addr;
+	dma_addr_t desc_dma_addr;
+	u32 total_size;
+	u32 total_cnt;
+	u32 head;
+	u32 tail;
+	union {
+		struct emac_rx_desc_buffer *rx_desc_buf;
+		struct emac_tx_desc_buffer *tx_desc_buf;
+	};
+};
+
+struct emac_priv {
+	void __iomem *iobase;
+	u32 dma_buf_sz;
+	struct emac_desc_ring tx_ring;
+	struct emac_desc_ring rx_ring;
+
+	struct net_device *ndev;
+	struct napi_struct napi;
+	struct platform_device *pdev;
+	struct clk *bus_clk;
+	struct clk *ref_clk;
+	struct regmap *regmap_apmu;
+	u32 regmap_apmu_offset;
+	int irq;
+
+	phy_interface_t phy_interface;
+
+	struct emac_hw_stats *hw_stats;
+
+	u32 tx_count_frames;
+	u32 tx_coal_frames;
+	u32 tx_coal_timeout;
+	struct work_struct tx_timeout_task;
+
+	struct timer_list txtimer;
+
+	u32 tx_delay;
+	u32 rx_delay;
+
+	/* Held when reading statistics counters because of indirect access */
+	spinlock_t stats_lock;
+};
+
+static void emac_wr(struct emac_priv *priv, u32 reg, u32 val)
+{
+	writel(val, priv->iobase + reg);
+}
+
+static int emac_rd(struct emac_priv *priv, u32 reg)
+{
+	return readl(priv->iobase + reg);
+}
+
+#define EMAC_ETHTOOL_STAT(x) \
+	{ #x, offsetof(struct emac_hw_stats, x) / sizeof(u32) }
+
+static const struct emac_ethtool_stats {
+	char str[ETH_GSTRING_LEN];
+	u32 offset;
+} emac_ethtool_stats[] = {
+	EMAC_ETHTOOL_STAT(tx_ok_pkts),
+	EMAC_ETHTOOL_STAT(tx_total_pkts),
+	EMAC_ETHTOOL_STAT(tx_ok_bytes),
+	EMAC_ETHTOOL_STAT(tx_err_pkts),
+	EMAC_ETHTOOL_STAT(tx_singleclsn_pkts),
+	EMAC_ETHTOOL_STAT(tx_multiclsn_pkts),
+	EMAC_ETHTOOL_STAT(tx_lateclsn_pkts),
+	EMAC_ETHTOOL_STAT(tx_excessclsn_pkts),
+	EMAC_ETHTOOL_STAT(tx_unicast_pkts),
+	EMAC_ETHTOOL_STAT(tx_multicast_pkts),
+	EMAC_ETHTOOL_STAT(tx_broadcast_pkts),
+	EMAC_ETHTOOL_STAT(tx_pause_pkts),
+	EMAC_ETHTOOL_STAT(rx_ok_pkts),
+	EMAC_ETHTOOL_STAT(rx_total_pkts),
+	EMAC_ETHTOOL_STAT(rx_crc_err_pkts),
+	EMAC_ETHTOOL_STAT(rx_align_err_pkts),
+	EMAC_ETHTOOL_STAT(rx_err_total_pkts),
+	EMAC_ETHTOOL_STAT(rx_ok_bytes),
+	EMAC_ETHTOOL_STAT(rx_total_bytes),
+	EMAC_ETHTOOL_STAT(rx_unicast_pkts),
+	EMAC_ETHTOOL_STAT(rx_multicast_pkts),
+	EMAC_ETHTOOL_STAT(rx_broadcast_pkts),
+	EMAC_ETHTOOL_STAT(rx_pause_pkts),
+	EMAC_ETHTOOL_STAT(rx_len_err_pkts),
+	EMAC_ETHTOOL_STAT(rx_len_undersize_pkts),
+	EMAC_ETHTOOL_STAT(rx_len_oversize_pkts),
+	EMAC_ETHTOOL_STAT(rx_len_fragment_pkts),
+	EMAC_ETHTOOL_STAT(rx_len_jabber_pkts),
+	EMAC_ETHTOOL_STAT(rx_64_pkts),
+	EMAC_ETHTOOL_STAT(rx_65_127_pkts),
+	EMAC_ETHTOOL_STAT(rx_128_255_pkts),
+	EMAC_ETHTOOL_STAT(rx_256_511_pkts),
+	EMAC_ETHTOOL_STAT(rx_512_1023_pkts),
+	EMAC_ETHTOOL_STAT(rx_1024_1518_pkts),
+	EMAC_ETHTOOL_STAT(rx_1519_plus_pkts),
+	EMAC_ETHTOOL_STAT(rx_drp_fifo_full_pkts),
+	EMAC_ETHTOOL_STAT(rx_truncate_fifo_full_pkts),
+};
+
+static int emac_phy_interface_config(struct emac_priv *priv)
+{
+	u32 val = 0, mask = PHY_INTF_RGMII;
+
+	switch (priv->phy_interface) {
+	case PHY_INTERFACE_MODE_RMII:
+		mask |= REF_CLK_SEL;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= PHY_INTF_RGMII;
+
+		mask |= RGMII_TX_CLK_SEL;
+		break;
+	default:
+		netdev_err(priv->ndev, "Unsupported PHY interface %d",
+			   priv->phy_interface);
+		return -EINVAL;
+	}
+
+	regmap_update_bits(priv->regmap_apmu,
+			   priv->regmap_apmu_offset + APMU_EMAC_CTRL_REG,
+			   mask, val);
+
+	return 0;
+}
+
+static int emac_reset_hw(struct emac_priv *priv)
+{
+	/* Disable all interrupts */
+	emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
+	emac_wr(priv, DMA_INTERRUPT_ENABLE, 0x0);
+
+	/* Disable transmit and receive units */
+	emac_wr(priv, MAC_RECEIVE_CONTROL, 0x0);
+	emac_wr(priv, MAC_TRANSMIT_CONTROL, 0x0);
+
+	/* Disable DMA */
+	emac_wr(priv, DMA_CONTROL, 0x0);
+
+	/* Reset MAC and stats */
+	emac_wr(priv, MAC_GLOBAL_CONTROL,
+		MREGBIT_RESET_RX_STAT_COUNTERS |
+			MREGBIT_RESET_TX_STAT_COUNTERS);
+	emac_wr(priv, MAC_GLOBAL_CONTROL, 0x0);
+
+	return 0;
+}
+
+static int emac_init_hw(struct emac_priv *priv)
+{
+	u32 rxirq = 0, dma = 0;
+
+	regmap_set_bits(priv->regmap_apmu,
+			priv->regmap_apmu_offset + APMU_EMAC_CTRL_REG,
+			AXI_SINGLE_ID);
+
+	/* Disable transmit and receive units */
+	emac_wr(priv, MAC_RECEIVE_CONTROL, 0x0);
+	emac_wr(priv, MAC_TRANSMIT_CONTROL, 0x0);
+
+	/* Enable mac address 1 filtering */
+	emac_wr(priv, MAC_ADDRESS_CONTROL, MREGBIT_MAC_ADDRESS1_ENABLE);
+
+	/* Zero initialize the multicast hash table */
+	emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, 0x0);
+	emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, 0x0);
+	emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, 0x0);
+	emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, 0x0);
+
+	/* Configure Thresholds */
+	emac_wr(priv, MAC_TRANSMIT_FIFO_ALMOST_FULL, DEFAULT_TX_ALMOST_FULL);
+	emac_wr(priv, MAC_TRANSMIT_PACKET_START_THRESHOLD,
+		DEFAULT_TX_THRESHOLD);
+	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
+
+	/* RX IRQ mitigation */
+	rxirq = EMAC_RX_FRAMES & MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MASK;
+	rxirq |= (EMAC_RX_COAL_TIMEOUT
+		  << MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_SHIFT) &
+		 MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_MASK;
+
+	rxirq |= MREGBIT_RECEIVE_IRQ_MITIGATION_ENABLE;
+	emac_wr(priv, DMA_RECEIVE_IRQ_MITIGATION_CTRL, rxirq);
+
+	/* Disable and reset DMA */
+	emac_wr(priv, DMA_CONTROL, 0x0);
+
+	emac_wr(priv, DMA_CONFIGURATION, MREGBIT_SOFTWARE_RESET);
+	usleep_range(9000, 10000);
+	emac_wr(priv, DMA_CONFIGURATION, 0x0);
+	usleep_range(9000, 10000);
+
+	dma |= MREGBIT_STRICT_BURST;
+	dma |= MREGBIT_DMA_64BIT_MODE;
+	dma |= DEFAULT_DMA_BURST;
+
+	emac_wr(priv, DMA_CONFIGURATION, dma);
+
+	return 0;
+}
+
+static void emac_set_mac_addr(struct emac_priv *priv, const unsigned char *addr)
+{
+	emac_wr(priv, MAC_ADDRESS1_HIGH, ((addr[1] << 8) | addr[0]));
+	emac_wr(priv, MAC_ADDRESS1_MED, ((addr[3] << 8) | addr[2]));
+	emac_wr(priv, MAC_ADDRESS1_LOW, ((addr[5] << 8) | addr[4]));
+}
+
+static void emac_dma_start_transmit(struct emac_priv *priv)
+{
+	emac_wr(priv, DMA_TRANSMIT_POLL_DEMAND, 0xFF);
+}
+
+static void emac_enable_interrupt(struct emac_priv *priv)
+{
+	u32 val;
+
+	val = emac_rd(priv, DMA_INTERRUPT_ENABLE);
+	val |= MREGBIT_TRANSMIT_TRANSFER_DONE_INTR_ENABLE;
+	val |= MREGBIT_RECEIVE_TRANSFER_DONE_INTR_ENABLE;
+	emac_wr(priv, DMA_INTERRUPT_ENABLE, val);
+}
+
+static void emac_disable_interrupt(struct emac_priv *priv)
+{
+	u32 val;
+
+	val = emac_rd(priv, DMA_INTERRUPT_ENABLE);
+	val &= ~MREGBIT_TRANSMIT_TRANSFER_DONE_INTR_ENABLE;
+	val &= ~MREGBIT_RECEIVE_TRANSFER_DONE_INTR_ENABLE;
+	emac_wr(priv, DMA_INTERRUPT_ENABLE, val);
+}
+
+static u32 emac_tx_avail(struct emac_priv *priv)
+{
+	struct emac_desc_ring *tx_ring = &priv->tx_ring;
+	u32 avail;
+
+	if (tx_ring->tail > tx_ring->head)
+		avail = tx_ring->tail - tx_ring->head - 1;
+	else
+		avail = tx_ring->total_cnt - tx_ring->head + tx_ring->tail - 1;
+
+	return avail;
+}
+
+static void emac_tx_coal_timer_resched(struct emac_priv *priv)
+{
+	mod_timer(&priv->txtimer,
+		  jiffies + usecs_to_jiffies(priv->tx_coal_timeout));
+}
+
+static void emac_tx_coal_timer(struct timer_list *t)
+{
+	struct emac_priv *priv = timer_container_of(priv, t, txtimer);
+
+	napi_schedule(&priv->napi);
+}
+
+static bool emac_tx_should_interrupt(struct emac_priv *priv, u32 pkt_num)
+{
+	bool should_interrupt;
+
+	/* Manage TX mitigation */
+	priv->tx_count_frames += pkt_num;
+	if (likely(priv->tx_coal_frames > priv->tx_count_frames)) {
+		emac_tx_coal_timer_resched(priv);
+		should_interrupt = false;
+	} else {
+		priv->tx_count_frames = 0;
+		should_interrupt = true;
+	}
+
+	return should_interrupt;
+}
+
+static void emac_free_tx_buf(struct emac_priv *priv, int i)
+{
+	struct emac_tx_desc_buffer *tx_buf;
+	struct emac_desc_ring *tx_ring;
+	struct desc_buf *buf;
+	int j;
+
+	tx_ring = &priv->tx_ring;
+	tx_buf = &tx_ring->tx_desc_buf[i];
+
+	for (j = 0; j < 2; j++) {
+		buf = &tx_buf->buf[j];
+		if (buf->dma_addr) {
+			if (buf->map_as_page)
+				dma_unmap_page(&priv->pdev->dev, buf->dma_addr,
+					       buf->dma_len, DMA_TO_DEVICE);
+			else
+				dma_unmap_single(&priv->pdev->dev,
+						 buf->dma_addr, buf->dma_len,
+						 DMA_TO_DEVICE);
+
+			buf->dma_addr = 0;
+			buf->map_as_page = false;
+			buf->buff_addr = NULL;
+		}
+	}
+
+	if (tx_buf->skb) {
+		dev_kfree_skb_any(tx_buf->skb);
+		tx_buf->skb = NULL;
+	}
+}
+
+static void emac_clean_tx_desc_ring(struct emac_priv *priv)
+{
+	struct emac_desc_ring *tx_ring = &priv->tx_ring;
+	u32 i;
+
+	/* Free all the TX ring skbs */
+	for (i = 0; i < tx_ring->total_cnt; i++)
+		emac_free_tx_buf(priv, i);
+
+	tx_ring->head = 0;
+	tx_ring->tail = 0;
+}
+
+static void emac_clean_rx_desc_ring(struct emac_priv *priv)
+{
+	struct emac_rx_desc_buffer *rx_buf;
+	struct emac_desc_ring *rx_ring;
+	u32 i;
+
+	rx_ring = &priv->rx_ring;
+
+	/* Free all the RX ring skbs */
+	for (i = 0; i < rx_ring->total_cnt; i++) {
+		rx_buf = &rx_ring->rx_desc_buf[i];
+		if (rx_buf->skb) {
+			dma_unmap_single(&priv->pdev->dev, rx_buf->dma_addr,
+					 rx_buf->dma_len, DMA_FROM_DEVICE);
+
+			dev_kfree_skb(rx_buf->skb);
+			rx_buf->skb = NULL;
+		}
+	}
+
+	rx_ring->tail = 0;
+	rx_ring->head = 0;
+}
+
+static int emac_alloc_tx_resources(struct emac_priv *priv)
+{
+	struct emac_desc_ring *tx_ring = &priv->tx_ring;
+	struct platform_device *pdev = priv->pdev;
+	u32 size;
+
+	size = sizeof(struct emac_tx_desc_buffer) * tx_ring->total_cnt;
+
+	tx_ring->tx_desc_buf = kzalloc(size, GFP_KERNEL);
+	if (!tx_ring->tx_desc_buf)
+		return -ENOMEM;
+
+	tx_ring->total_size = tx_ring->total_cnt * sizeof(struct emac_desc);
+	tx_ring->total_size = ALIGN(tx_ring->total_size, PAGE_SIZE);
+
+	tx_ring->desc_addr = dma_alloc_coherent(&pdev->dev, tx_ring->total_size,
+						&tx_ring->desc_dma_addr,
+						GFP_KERNEL);
+	if (!tx_ring->desc_addr) {
+		kfree(tx_ring->tx_desc_buf);
+		return -ENOMEM;
+	}
+
+	tx_ring->head = 0;
+	tx_ring->tail = 0;
+
+	return 0;
+}
+
+static int emac_alloc_rx_resources(struct emac_priv *priv)
+{
+	struct emac_desc_ring *rx_ring = &priv->rx_ring;
+	struct platform_device *pdev = priv->pdev;
+	u32 buf_len;
+
+	buf_len = sizeof(struct emac_rx_desc_buffer) * rx_ring->total_cnt;
+
+	rx_ring->rx_desc_buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!rx_ring->rx_desc_buf)
+		return -ENOMEM;
+
+	rx_ring->total_size = rx_ring->total_cnt * sizeof(struct emac_desc);
+
+	rx_ring->total_size = ALIGN(rx_ring->total_size, PAGE_SIZE);
+
+	rx_ring->desc_addr = dma_alloc_coherent(&pdev->dev, rx_ring->total_size,
+						&rx_ring->desc_dma_addr,
+						GFP_KERNEL);
+	if (!rx_ring->desc_addr) {
+		kfree(rx_ring->rx_desc_buf);
+		return -ENOMEM;
+	}
+
+	rx_ring->head = 0;
+	rx_ring->tail = 0;
+
+	return 0;
+}
+
+static void emac_free_tx_resources(struct emac_priv *priv)
+{
+	struct emac_desc_ring *tr = &priv->tx_ring;
+	struct device *dev = &priv->pdev->dev;
+
+	emac_clean_tx_desc_ring(priv);
+
+	kfree(tr->tx_desc_buf);
+	tr->tx_desc_buf = NULL;
+
+	dma_free_coherent(dev, tr->total_size, tr->desc_addr,
+			  tr->desc_dma_addr);
+	tr->desc_addr = NULL;
+}
+
+static void emac_free_rx_resources(struct emac_priv *priv)
+{
+	struct emac_desc_ring *rr = &priv->rx_ring;
+	struct device *dev = &priv->pdev->dev;
+
+	emac_clean_rx_desc_ring(priv);
+
+	kfree(rr->rx_desc_buf);
+	rr->rx_desc_buf = NULL;
+
+	dma_free_coherent(dev, rr->total_size, rr->desc_addr,
+			  rr->desc_dma_addr);
+	rr->desc_addr = NULL;
+}
+
+static int emac_tx_clean_desc(struct emac_priv *priv)
+{
+	struct net_device *ndev = priv->ndev;
+	struct emac_desc_ring *tx_ring;
+	struct emac_desc *tx_desc;
+	u32 i;
+
+	netif_tx_lock(ndev);
+
+	tx_ring = &priv->tx_ring;
+
+	i = tx_ring->tail;
+
+	while (i != tx_ring->head) {
+		tx_desc = &((struct emac_desc *)tx_ring->desc_addr)[i];
+
+		/* Stop checking if desc still own by DMA */
+		if (READ_ONCE(tx_desc->desc0) & TX_DESC_0_OWN)
+			break;
+
+		emac_free_tx_buf(priv, i);
+		memset(tx_desc, 0, sizeof(struct emac_desc));
+
+		if (++i == tx_ring->total_cnt)
+			i = 0;
+	}
+
+	tx_ring->tail = i;
+
+	if (unlikely(netif_queue_stopped(ndev) &&
+		     emac_tx_avail(priv) > tx_ring->total_cnt / 4))
+		netif_wake_queue(ndev);
+
+	netif_tx_unlock(ndev);
+
+	return 0;
+}
+
+static u32 rx_frame_len(struct emac_desc *desc)
+{
+	return (desc->desc0 & RX_DESC_0_FRAME_PACKET_LENGTH_MASK) >>
+	       RX_DESC_0_FRAME_PACKET_LENGTH_SHIFT;
+}
+
+static int emac_rx_frame_status(struct emac_priv *priv, struct emac_desc *desc)
+{
+	/* Drop if not last descriptor */
+	if (!(desc->desc0 & RX_DESC_0_LAST_DESCRIPTOR)) {
+		netdev_dbg(priv->ndev, "RX not last descriptor\n");
+		return RX_FRAME_DISCARD;
+	}
+
+	if (desc->desc0 & RX_DESC_0_FRAME_RUNT) {
+		netdev_dbg(priv->ndev, "RX runt frame\n");
+		return RX_FRAME_DISCARD;
+	}
+
+	if (desc->desc0 & RX_DESC_0_FRAME_CRC_ERR) {
+		netdev_dbg(priv->ndev, "RX frame CRC error\n");
+		return RX_FRAME_DISCARD;
+	}
+
+	if (desc->desc0 & RX_DESC_0_FRAME_MAX_LEN_ERR) {
+		netdev_dbg(priv->ndev, "RX frame exceeds max length\n");
+		return RX_FRAME_DISCARD;
+	}
+
+	if (desc->desc0 & RX_DESC_0_FRAME_JABBER_ERR) {
+		netdev_dbg(priv->ndev, "RX frame jabber error\n");
+		return RX_FRAME_DISCARD;
+	}
+
+	if (desc->desc0 & RX_DESC_0_FRAME_LENGTH_ERR) {
+		netdev_dbg(priv->ndev, "RX frame length error\n");
+		return RX_FRAME_DISCARD;
+	}
+
+	if (rx_frame_len(desc) <= ETHERNET_FCS_SIZE ||
+	    rx_frame_len(desc) > priv->dma_buf_sz) {
+		netdev_dbg(priv->ndev, "RX frame length unacceptable\n");
+		return RX_FRAME_DISCARD;
+	}
+	return RX_FRAME_OK;
+}
+
+/* RX and TX use the same layout for {RX,TX}_DESC_1_BUFFER_SIZE_{1,2} */
+
+static u32 make_buf_size_1(u32 size)
+{
+	return (size << TX_DESC_1_BUFFER_SIZE_1_SHIFT) &
+	       TX_DESC_1_BUFFER_SIZE_1_MASK;
+}
+
+static u32 make_buf_size_2(u32 size)
+{
+	return (size << TX_DESC_1_BUFFER_SIZE_2_SHIFT) &
+	       TX_DESC_1_BUFFER_SIZE_2_MASK;
+}
+
+static void emac_alloc_rx_desc_buffers(struct emac_priv *priv)
+{
+	struct emac_desc_ring *rx_ring = &priv->rx_ring;
+	struct emac_desc rx_desc, *rx_desc_addr;
+	struct net_device *ndev = priv->ndev;
+	struct emac_rx_desc_buffer *rx_buf;
+	struct sk_buff *skb;
+	u32 i;
+
+	i = rx_ring->head;
+	rx_buf = &rx_ring->rx_desc_buf[i];
+
+	while (!rx_buf->skb) {
+		skb = netdev_alloc_skb_ip_align(ndev, priv->dma_buf_sz);
+		if (!skb)
+			break;
+
+		skb->dev = ndev;
+
+		rx_buf->skb = skb;
+		rx_buf->dma_len = priv->dma_buf_sz;
+		rx_buf->dma_addr = dma_map_single(&priv->pdev->dev, skb->data,
+						  priv->dma_buf_sz,
+						  DMA_FROM_DEVICE);
+		if (dma_mapping_error(&priv->pdev->dev, rx_buf->dma_addr)) {
+			netdev_err(ndev, "dma_mapping_error\n");
+			goto dma_map_err;
+		}
+
+		rx_desc_addr = &((struct emac_desc *)rx_ring->desc_addr)[i];
+
+		memset(&rx_desc, 0, sizeof(rx_desc));
+
+		rx_desc.buffer_addr_1 = rx_buf->dma_addr;
+		rx_desc.desc1 = make_buf_size_1(rx_buf->dma_len);
+
+		if (++i == rx_ring->total_cnt) {
+			rx_desc.desc1 |= RX_DESC_1_END_RING;
+			i = 0;
+		}
+
+		*rx_desc_addr = rx_desc;
+		dma_wmb();
+		WRITE_ONCE(rx_desc_addr->desc0, rx_desc.desc0 | RX_DESC_0_OWN);
+
+		rx_buf = &rx_ring->rx_desc_buf[i];
+	}
+
+	rx_ring->head = i;
+	return;
+
+dma_map_err:
+	dev_kfree_skb_any(skb);
+	rx_buf->skb = NULL;
+}
+
+/* Returns number of packets received */
+static int emac_rx_clean_desc(struct emac_priv *priv, int budget)
+{
+	struct net_device *ndev = priv->ndev;
+	struct emac_rx_desc_buffer *rx_buf;
+	struct emac_desc_ring *rx_ring;
+	struct sk_buff *skb = NULL;
+	struct emac_desc *rx_desc;
+	u32 got = 0, skb_len, i;
+	int status;
+
+	rx_ring = &priv->rx_ring;
+
+	i = rx_ring->tail;
+
+	while (budget--) {
+		rx_desc = &((struct emac_desc *)rx_ring->desc_addr)[i];
+
+		/* Stop checking if rx_desc still owned by DMA */
+		if (READ_ONCE(rx_desc->desc0) & RX_DESC_0_OWN)
+			break;
+
+		dma_rmb();
+
+		rx_buf = &rx_ring->rx_desc_buf[i];
+
+		if (!rx_buf->skb)
+			break;
+
+		got++;
+
+		dma_unmap_single(&priv->pdev->dev, rx_buf->dma_addr,
+				 rx_buf->dma_len, DMA_FROM_DEVICE);
+
+		status = emac_rx_frame_status(priv, rx_desc);
+		if (unlikely(status == RX_FRAME_DISCARD)) {
+			ndev->stats.rx_dropped++;
+			dev_kfree_skb_irq(rx_buf->skb);
+			rx_buf->skb = NULL;
+		} else {
+			skb = rx_buf->skb;
+			skb_len = rx_frame_len(rx_desc) - ETHERNET_FCS_SIZE;
+			skb_put(skb, skb_len);
+			skb->dev = ndev;
+			ndev->hard_header_len = ETH_HLEN;
+
+			skb->protocol = eth_type_trans(skb, ndev);
+
+			skb->ip_summed = CHECKSUM_NONE;
+
+			napi_gro_receive(&priv->napi, skb);
+
+			ndev->stats.rx_packets++;
+			ndev->stats.rx_bytes += skb_len;
+
+			memset(rx_desc, 0, sizeof(struct emac_desc));
+			rx_buf->skb = NULL;
+		}
+
+		if (++i == rx_ring->total_cnt)
+			i = 0;
+	}
+
+	rx_ring->tail = i;
+
+	emac_alloc_rx_desc_buffers(priv);
+
+	return got;
+}
+
+static int emac_rx_poll(struct napi_struct *napi, int budget)
+{
+	struct emac_priv *priv = container_of(napi, struct emac_priv, napi);
+	int work_done;
+
+	emac_tx_clean_desc(priv);
+
+	work_done = emac_rx_clean_desc(priv, budget);
+	if (work_done < budget && napi_complete_done(napi, work_done))
+		emac_enable_interrupt(priv);
+
+	return work_done;
+}
+
+static int emac_tx_mem_map(struct emac_priv *priv, struct sk_buff *skb,
+			   u32 max_tx_len, u32 frag_num)
+{
+	struct emac_desc tx_desc, *tx_desc_addr;
+	u32 skb_linear_len = skb_headlen(skb);
+	struct emac_tx_desc_buffer *tx_buf;
+	u32 len, i, f, first, buf_idx = 0;
+	struct emac_desc_ring *tx_ring;
+	phys_addr_t addr;
+
+	tx_ring = &priv->tx_ring;
+
+	i = tx_ring->head;
+	first = i;
+
+	if (++i == tx_ring->total_cnt)
+		i = 0;
+
+	/* If the data is fragmented */
+	for (f = 0; f < frag_num; f++) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[f];
+
+		len = skb_frag_size(frag);
+
+		buf_idx = (f + 1) % 2;
+
+		/* First frag fill into second buffer of first descriptor */
+		if (f == 0) {
+			tx_buf = &tx_ring->tx_desc_buf[first];
+			tx_desc_addr = &((struct emac_desc *)
+						 tx_ring->desc_addr)[first];
+			memset(&tx_desc, 0, sizeof(tx_desc));
+		} else {
+			/*
+			 * From second frags to more frags,
+			 * we only get new descriptor when frag num is odd.
+			 */
+			if (!buf_idx) {
+				tx_buf = &tx_ring->tx_desc_buf[i];
+				tx_desc_addr = &((struct emac_desc *)
+							 tx_ring->desc_addr)[i];
+				memset(&tx_desc, 0, sizeof(tx_desc));
+			}
+		}
+		tx_buf->buf[buf_idx].dma_len = len;
+
+		addr = skb_frag_dma_map(&priv->pdev->dev, frag, 0,
+					skb_frag_size(frag), DMA_TO_DEVICE);
+
+		if (dma_mapping_error(&priv->pdev->dev, addr)) {
+			netdev_err(priv->ndev, "fail to map dma page: %d\n", f);
+			goto dma_map_err;
+		}
+		tx_buf->buf[buf_idx].dma_addr = addr;
+
+		tx_buf->buf[buf_idx].map_as_page = true;
+
+		/* Every desc has two buffers for packet */
+		if (buf_idx) {
+			tx_desc.buffer_addr_2 = addr;
+			tx_desc.desc1 |= make_buf_size_2(len);
+		} else {
+			tx_desc.buffer_addr_1 = addr;
+			tx_desc.desc1 = make_buf_size_1(len);
+
+			if (++i == tx_ring->total_cnt) {
+				tx_desc.desc1 |= TX_DESC_1_END_RING;
+				i = 0;
+			}
+		}
+
+		if (f == 0) {
+			*tx_desc_addr = tx_desc;
+			continue;
+		}
+
+		if (f == frag_num - 1) {
+			tx_desc.desc1 |= TX_DESC_1_LAST_SEGMENT;
+			tx_buf->skb = skb;
+			if (emac_tx_should_interrupt(priv, frag_num + 1))
+				tx_desc.desc1 |=
+					TX_DESC_1_INTERRUPT_ON_COMPLETION;
+		}
+
+		*tx_desc_addr = tx_desc;
+		dma_wmb();
+		WRITE_ONCE(tx_desc_addr->desc0, tx_desc.desc0 | TX_DESC_0_OWN);
+	}
+
+	/* fill out first descriptor for skb linear data */
+	tx_buf = &tx_ring->tx_desc_buf[first];
+
+	tx_buf->buf[0].dma_len = skb_linear_len;
+
+	addr = dma_map_single(&priv->pdev->dev, skb->data, skb_linear_len,
+			      DMA_TO_DEVICE);
+	if (dma_mapping_error(&priv->pdev->dev, addr)) {
+		netdev_err(priv->ndev, "dma_map_single failed\n");
+		goto dma_map_err;
+	}
+
+	tx_buf->buf[0].dma_addr = addr;
+
+	tx_buf->buf[0].buff_addr = skb->data;
+	tx_buf->buf[0].map_as_page = false;
+
+	/* Fill TX descriptor */
+	tx_desc_addr = &((struct emac_desc *)tx_ring->desc_addr)[first];
+
+	tx_desc = *tx_desc_addr;
+
+	tx_desc.buffer_addr_1 = addr;
+	tx_desc.desc1 |= make_buf_size_1(skb_linear_len);
+	tx_desc.desc1 |= TX_DESC_1_FIRST_SEGMENT;
+
+	/* If last desc for ring, set end ring flag */
+	if (first == tx_ring->total_cnt - 1)
+		tx_desc.desc1 |= TX_DESC_1_END_RING;
+
+	/*
+	 * If frag_num is more than 1, data need another desc, so current
+	 * descriptor isn't last piece of packet data.
+	 */
+	tx_desc.desc1 |= frag_num > 1 ? 0 : TX_DESC_1_LAST_SEGMENT;
+
+	if (frag_num <= 1 && emac_tx_should_interrupt(priv, 1))
+		tx_desc.desc1 |= TX_DESC_1_INTERRUPT_ON_COMPLETION;
+
+	/* Only last descriptor has skb pointer */
+	if (tx_desc.desc1 & TX_DESC_1_LAST_SEGMENT)
+		tx_buf->skb = skb;
+
+	*tx_desc_addr = tx_desc;
+	dma_wmb();
+	WRITE_ONCE(tx_desc_addr->desc0, tx_desc.desc0 | TX_DESC_0_OWN);
+
+	emac_dma_start_transmit(priv);
+
+	tx_ring->head = i;
+
+	return 0;
+
+dma_map_err:
+	dev_kfree_skb_any(skb);
+	priv->ndev->stats.tx_dropped++;
+	return 0;
+}
+
+static int emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct emac_priv *priv = netdev_priv(ndev);
+	int nfrags = skb_shinfo(skb)->nr_frags;
+	struct device *dev = &priv->pdev->dev;
+
+	if (unlikely(emac_tx_avail(priv) < nfrags + 1)) {
+		if (!netif_queue_stopped(ndev)) {
+			netif_stop_queue(ndev);
+			dev_err_ratelimited(dev, "TX ring full, stop TX queue\n");
+		}
+		return NETDEV_TX_BUSY;
+	}
+
+	emac_tx_mem_map(priv, skb, MAX_DATA_LEN_TX_DES, nfrags);
+
+	ndev->stats.tx_packets++;
+	ndev->stats.tx_bytes += skb->len;
+
+	/* Make sure there is space in the ring for the next TX. */
+	if (unlikely(emac_tx_avail(priv) <= MAX_SKB_FRAGS + 2))
+		netif_stop_queue(ndev);
+
+	return NETDEV_TX_OK;
+}
+
+static u32 emac_tx_read_stat_cnt(struct emac_priv *priv, u8 cnt)
+{
+	u32 val, tmp;
+	int ret;
+
+	val = 0x8000 | cnt;
+	emac_wr(priv, MAC_TX_STATCTR_CONTROL, val);
+	val = emac_rd(priv, MAC_TX_STATCTR_CONTROL);
+
+	ret = readl_poll_timeout_atomic(priv->iobase + MAC_TX_STATCTR_CONTROL,
+					val, !(val & 0x8000), 100, 10000);
+
+	if (ret) {
+		netdev_err(priv->ndev, "read TX stat timeout\n");
+		return ret;
+	}
+
+	tmp = emac_rd(priv, MAC_TX_STATCTR_DATA_HIGH);
+	val = tmp << 16;
+	tmp = emac_rd(priv, MAC_TX_STATCTR_DATA_LOW);
+	val |= tmp;
+
+	return val;
+}
+
+static u32 emac_rx_read_stat_cnt(struct emac_priv *priv, u8 cnt)
+{
+	u32 val, tmp;
+	int ret;
+
+	val = 0x8000 | cnt;
+	emac_wr(priv, MAC_RX_STATCTR_CONTROL, val);
+	val = emac_rd(priv, MAC_RX_STATCTR_CONTROL);
+
+	ret = readl_poll_timeout_atomic(priv->iobase + MAC_RX_STATCTR_CONTROL,
+					val, !(val & 0x8000), 100, 10000);
+
+	if (ret) {
+		netdev_err(priv->ndev, "read RX stat timeout\n");
+		return ret;
+	}
+
+	tmp = emac_rd(priv, MAC_RX_STATCTR_DATA_HIGH);
+	val = tmp << 16;
+	tmp = emac_rd(priv, MAC_RX_STATCTR_DATA_LOW);
+	val |= tmp;
+
+	return val;
+}
+
+static int emac_set_mac_address(struct net_device *ndev, void *addr)
+{
+	struct emac_priv *priv = netdev_priv(ndev);
+	int ret = eth_mac_addr(ndev, addr);
+
+	if (ret)
+		return ret;
+
+	/* If running, set now; if not running it will be set in emac_up. */
+	if (netif_running(ndev))
+		emac_set_mac_addr(priv, ndev->dev_addr);
+
+	return 0;
+}
+
+static void emac_mac_multicast_filter_clear(struct emac_priv *priv)
+{
+	emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, 0x0);
+	emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, 0x0);
+	emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, 0x0);
+	emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, 0x0);
+}
+
+/* Configure Multicast and Promiscuous modes */
+static void emac_rx_mode_set(struct net_device *ndev)
+{
+	struct emac_priv *priv = netdev_priv(ndev);
+	u32 crc32, bit, reg, hash, val;
+	struct netdev_hw_addr *ha;
+	u32 mc_filter[4] = { 0 };
+
+	val = emac_rd(priv, MAC_ADDRESS_CONTROL);
+
+	val &= ~MREGBIT_PROMISCUOUS_MODE;
+
+	if (ndev->flags & IFF_PROMISC) {
+		/* Enable promisc mode */
+		val |= MREGBIT_PROMISCUOUS_MODE;
+	} else if ((ndev->flags & IFF_ALLMULTI) ||
+		   (netdev_mc_count(ndev) > HASH_TABLE_SIZE)) {
+		/* Accept all multicast frames by setting every bit */
+		emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, 0xffff);
+		emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, 0xffff);
+		emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, 0xffff);
+		emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, 0xffff);
+	} else if (!netdev_mc_empty(ndev)) {
+		emac_mac_multicast_filter_clear(priv);
+		netdev_for_each_mc_addr(ha, ndev) {
+			/* Calculate the CRC of the MAC address */
+			crc32 = ether_crc(ETH_ALEN, ha->addr);
+
+			/*
+			 * The hash table is an array of 4 16-bit registers. It
+			 * is treated like an array of 64 bits (bits[hash]). Use
+			 * the upper 6 bits of the above CRC as the hash value.
+			 */
+			hash = (crc32 >> 26) & 0x3F;
+			reg = hash / 16;
+			bit = hash % 16;
+			mc_filter[reg] |= BIT(bit);
+		}
+		emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, mc_filter[0]);
+		emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, mc_filter[1]);
+		emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, mc_filter[2]);
+		emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, mc_filter[3]);
+	}
+
+	emac_wr(priv, MAC_ADDRESS_CONTROL, val);
+}
+
+static int emac_change_mtu(struct net_device *ndev, int mtu)
+{
+	struct emac_priv *priv = netdev_priv(ndev);
+	u32 frame_len;
+
+	if (netif_running(ndev)) {
+		netdev_err(ndev, "must be stopped to change MTU\n");
+		return -EBUSY;
+	}
+
+	frame_len = mtu + ETHERNET_HEADER_SIZE + ETHERNET_FCS_SIZE;
+
+	if (frame_len <= EMAC_DEFAULT_BUFSIZE)
+		priv->dma_buf_sz = EMAC_DEFAULT_BUFSIZE;
+	else if (frame_len <= EMAC_RX_BUF_2K)
+		priv->dma_buf_sz = EMAC_RX_BUF_2K;
+	else
+		priv->dma_buf_sz = EMAC_RX_BUF_4K;
+
+	ndev->mtu = mtu;
+
+	return 0;
+}
+
+static void emac_tx_timeout(struct net_device *ndev, unsigned int txqueue)
+{
+	struct emac_priv *priv = netdev_priv(ndev);
+
+	schedule_work(&priv->tx_timeout_task);
+}
+
+static int emac_mii_read(struct mii_bus *bus, int phy_addr, int regnum)
+{
+	struct emac_priv *priv = bus->priv;
+	u32 cmd = 0, val;
+	int ret;
+
+	cmd |= phy_addr & 0x1F;
+	cmd |= (regnum & 0x1F) << 5;
+	cmd |= MREGBIT_START_MDIO_TRANS | MREGBIT_MDIO_READ_WRITE;
+
+	emac_wr(priv, MAC_MDIO_DATA, 0x0);
+	emac_wr(priv, MAC_MDIO_CONTROL, cmd);
+
+	ret = readl_poll_timeout(priv->iobase + MAC_MDIO_CONTROL, val,
+				 !((val >> 15) & 0x1), 100, 10000);
+
+	if (ret)
+		return ret;
+
+	val = emac_rd(priv, MAC_MDIO_DATA);
+	return val;
+}
+
+static int emac_mii_write(struct mii_bus *bus, int phy_addr, int regnum,
+			  u16 value)
+{
+	struct emac_priv *priv = bus->priv;
+	u32 cmd = 0, val;
+	int ret;
+
+	emac_wr(priv, MAC_MDIO_DATA, value);
+
+	cmd |= phy_addr & 0x1F;
+	cmd |= (regnum & 0x1F) << 5;
+	cmd |= MREGBIT_START_MDIO_TRANS;
+
+	emac_wr(priv, MAC_MDIO_CONTROL, cmd);
+
+	ret = readl_poll_timeout(priv->iobase + MAC_MDIO_CONTROL, val,
+				 !((val >> 15) & 0x1), 100, 10000);
+
+	return ret;
+}
+
+static int emac_mdio_init(struct emac_priv *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct device_node *mii_np;
+	struct mii_bus *mii;
+	int ret;
+
+	mii_np = of_get_available_child_by_name(dev->of_node, "mdio-bus");
+	if (!mii_np) {
+		if (of_phy_is_fixed_link(dev->of_node)) {
+			if ((of_phy_register_fixed_link(dev->of_node) < 0))
+				return -ENODEV;
+
+			return 0;
+		}
+
+		dev_info(dev, "No mdio-bus child node found");
+		return 0;
+	}
+
+	mii = devm_mdiobus_alloc(dev);
+
+	if (!mii) {
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
+	mii->priv = priv;
+	mii->name = "emac mii";
+	mii->read = emac_mii_read;
+	mii->write = emac_mii_write;
+	mii->parent = dev;
+	mii->phy_mask = 0xffffffff;
+	snprintf(mii->id, MII_BUS_ID_SIZE, "%s", priv->pdev->name);
+
+	ret = devm_of_mdiobus_register(dev, mii, mii_np);
+	if (ret)
+		dev_err_probe(dev, ret, "Failed to register mdio bus.\n");
+
+err_put_node:
+	of_node_put(mii_np);
+	return ret;
+}
+
+static void emac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < ARRAY_SIZE(emac_ethtool_stats); i++) {
+			memcpy(data, emac_ethtool_stats[i].str,
+			       ETH_GSTRING_LEN);
+			data += ETH_GSTRING_LEN;
+		}
+		break;
+	}
+}
+
+static int emac_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(emac_ethtool_stats);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void emac_stats_update(struct emac_priv *priv)
+{
+	struct emac_hw_stats *hwstats = priv->hw_stats;
+	u32 *stats = (u32 *)hwstats;
+	int i;
+
+	for (i = 0; i < EMAC_TX_STATS_NUM; i++)
+		stats[i] = emac_tx_read_stat_cnt(priv, i);
+
+	for (i = 0; i < EMAC_RX_STATS_NUM; i++)
+		stats[i + EMAC_TX_STATS_NUM] = emac_rx_read_stat_cnt(priv, i);
+}
+
+static void emac_get_ethtool_stats(struct net_device *dev,
+				   struct ethtool_stats *stats, u64 *data)
+{
+	struct emac_priv *priv = netdev_priv(dev);
+	struct emac_hw_stats *hwstats;
+	unsigned long flags;
+	u32 *data_src;
+	u64 *data_dst;
+	int i;
+
+	hwstats = priv->hw_stats;
+
+	if (netif_running(dev) && netif_device_present(dev)) {
+		if (spin_trylock_irqsave(&priv->stats_lock, flags)) {
+			emac_stats_update(priv);
+			spin_unlock_irqrestore(&priv->stats_lock, flags);
+		}
+	}
+
+	data_dst = data;
+
+	for (i = 0; i < ARRAY_SIZE(emac_ethtool_stats); i++) {
+		data_src = (u32 *)hwstats + emac_ethtool_stats[i].offset;
+		*data_dst++ = (u64)(*data_src);
+	}
+}
+
+static int emac_ethtool_get_regs_len(struct net_device *dev)
+{
+	return EMAC_REG_SPACE_SIZE;
+}
+
+static void emac_ethtool_get_regs(struct net_device *dev,
+				  struct ethtool_regs *regs, void *space)
+{
+	struct emac_priv *priv = netdev_priv(dev);
+	u32 *reg_space = space;
+	int i;
+
+	regs->version = 1;
+
+	for (i = 0; i < EMAC_DMA_REG_CNT; i++)
+		reg_space[i] = emac_rd(priv, DMA_CONFIGURATION + i * 4);
+
+	for (i = 0; i < EMAC_MAC_REG_CNT; i++)
+		reg_space[i + EMAC_DMA_REG_CNT] =
+			emac_rd(priv, MAC_GLOBAL_CONTROL + i * 4);
+}
+
+static void emac_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, DRIVER_NAME, sizeof(info->driver));
+	info->n_stats = ARRAY_SIZE(emac_ethtool_stats);
+}
+
+static void emac_tx_timeout_task(struct work_struct *work)
+{
+	struct net_device *ndev;
+	struct emac_priv *priv;
+
+	priv = container_of(work, struct emac_priv, tx_timeout_task);
+	ndev = priv->ndev;
+
+	rtnl_lock();
+
+	/* No need to reset if already down */
+	if (!netif_running(ndev)) {
+		rtnl_unlock();
+		return;
+	}
+
+	netdev_err(ndev, "MAC reset due to TX timeout\n");
+
+	netif_trans_update(ndev); /* prevent tx timeout */
+	dev_close(ndev);
+	dev_open(ndev, NULL);
+
+	rtnl_unlock();
+}
+
+static void emac_sw_init(struct emac_priv *priv)
+{
+	priv->dma_buf_sz = EMAC_DEFAULT_BUFSIZE;
+
+	priv->tx_ring.total_cnt = DEFAULT_TX_RING_NUM;
+	priv->rx_ring.total_cnt = DEFAULT_RX_RING_NUM;
+
+	spin_lock_init(&priv->stats_lock);
+
+	INIT_WORK(&priv->tx_timeout_task, emac_tx_timeout_task);
+
+	priv->tx_coal_frames = EMAC_TX_FRAMES;
+	priv->tx_coal_timeout = EMAC_TX_COAL_TIMEOUT;
+
+	timer_setup(&priv->txtimer, emac_tx_coal_timer, 0);
+}
+
+static int emac_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
+{
+	if (!netif_running(ndev))
+		return -EINVAL;
+
+	return phy_mii_ioctl(ndev->phydev, rq, cmd);
+}
+
+static irqreturn_t emac_interrupt_handler(int irq, void *dev_id)
+{
+	struct net_device *ndev = (struct net_device *)dev_id;
+	struct emac_priv *priv = netdev_priv(ndev);
+	bool should_schedule = false;
+	u32 status;
+	u32 clr = 0;
+
+	status = emac_rd(priv, DMA_STATUS_IRQ);
+
+	if (status & MREGBIT_TRANSMIT_TRANSFER_DONE_IRQ) {
+		clr |= MREGBIT_TRANSMIT_TRANSFER_DONE_IRQ;
+		should_schedule = true;
+	}
+
+	if (status & MREGBIT_TRANSMIT_DES_UNAVAILABLE_IRQ)
+		clr |= MREGBIT_TRANSMIT_DES_UNAVAILABLE_IRQ;
+
+	if (status & MREGBIT_TRANSMIT_DMA_STOPPED_IRQ)
+		clr |= MREGBIT_TRANSMIT_DMA_STOPPED_IRQ;
+
+	if (status & MREGBIT_RECEIVE_TRANSFER_DONE_IRQ) {
+		clr |= MREGBIT_RECEIVE_TRANSFER_DONE_IRQ;
+		should_schedule = true;
+	}
+
+	if (status & MREGBIT_RECEIVE_DES_UNAVAILABLE_IRQ)
+		clr |= MREGBIT_RECEIVE_DES_UNAVAILABLE_IRQ;
+
+	if (status & MREGBIT_RECEIVE_DMA_STOPPED_IRQ)
+		clr |= MREGBIT_RECEIVE_DMA_STOPPED_IRQ;
+
+	if (status & MREGBIT_RECEIVE_MISSED_FRAME_IRQ)
+		clr |= MREGBIT_RECEIVE_MISSED_FRAME_IRQ;
+
+	if (should_schedule) {
+		if (napi_schedule_prep(&priv->napi)) {
+			emac_disable_interrupt(priv);
+			__napi_schedule_irqoff(&priv->napi);
+		}
+	}
+
+	emac_wr(priv, DMA_STATUS_IRQ, clr);
+
+	return IRQ_HANDLED;
+}
+
+static void emac_configure_tx(struct emac_priv *priv)
+{
+	u32 val;
+
+	/* Set base address */
+	val = (u32)(priv->tx_ring.desc_dma_addr);
+
+	emac_wr(priv, DMA_TRANSMIT_BASE_ADDRESS, val);
+
+	/* TX Inter-frame gap value, enable transmit */
+	val = emac_rd(priv, MAC_TRANSMIT_CONTROL);
+	val &= ~MREGBIT_IFG_LEN;
+	val |= MREGBIT_TRANSMIT_ENABLE;
+	val |= MREGBIT_TRANSMIT_AUTO_RETRY;
+	emac_wr(priv, MAC_TRANSMIT_CONTROL, val);
+
+	emac_wr(priv, DMA_TRANSMIT_AUTO_POLL_COUNTER, 0x0);
+
+	/* Start TX DMA */
+	val = emac_rd(priv, DMA_CONTROL);
+	val |= MREGBIT_START_STOP_TRANSMIT_DMA;
+	emac_wr(priv, DMA_CONTROL, val);
+}
+
+static void emac_configure_rx(struct emac_priv *priv)
+{
+	u32 val;
+
+	/* Set base address */
+	val = (u32)(priv->rx_ring.desc_dma_addr);
+	emac_wr(priv, DMA_RECEIVE_BASE_ADDRESS, val);
+
+	/* Enable receive */
+	val = emac_rd(priv, MAC_RECEIVE_CONTROL);
+	val |= MREGBIT_RECEIVE_ENABLE;
+	val |= MREGBIT_STORE_FORWARD;
+	emac_wr(priv, MAC_RECEIVE_CONTROL, val);
+
+	/* Start RX DMA */
+	val = emac_rd(priv, DMA_CONTROL);
+	val |= MREGBIT_START_STOP_RECEIVE_DMA;
+	emac_wr(priv, DMA_CONTROL, val);
+}
+
+static void emac_adjust_link(struct net_device *dev)
+{
+	struct emac_priv *priv = netdev_priv(dev);
+	struct phy_device *phydev = dev->phydev;
+	u32 ctrl;
+
+	if (phydev->link) {
+		ctrl = emac_rd(priv, MAC_GLOBAL_CONTROL);
+
+		/* Update duplex and speed from PHY */
+
+		if (!phydev->duplex)
+			ctrl &= ~MREGBIT_FULL_DUPLEX_MODE;
+		else
+			ctrl |= MREGBIT_FULL_DUPLEX_MODE;
+
+		ctrl &= ~MREGBIT_SPEED;
+
+		switch (phydev->speed) {
+		case SPEED_1000:
+			ctrl |= MREGBIT_SPEED_1000M;
+			break;
+		case SPEED_100:
+			ctrl |= MREGBIT_SPEED_100M;
+			break;
+		case SPEED_10:
+			ctrl |= MREGBIT_SPEED_10M;
+			break;
+		default:
+			netdev_err(dev, "Unknown speed: %d\n", phydev->speed);
+			phydev->speed = SPEED_UNKNOWN;
+			break;
+		}
+
+		emac_wr(priv, MAC_GLOBAL_CONTROL, ctrl);
+	}
+
+	phy_print_status(phydev);
+}
+
+static void emac_update_delay_line(struct emac_priv *priv)
+{
+	u32 mask = 0, val = 0;
+
+	mask |= EMAC_RX_DLINE_EN;
+	mask |= EMAC_RX_DLINE_STEP_MASK | EMAC_RX_DLINE_CODE_MASK;
+	mask |= EMAC_TX_DLINE_EN;
+	mask |= EMAC_TX_DLINE_STEP_MASK | EMAC_TX_DLINE_CODE_MASK;
+
+	switch (priv->phy_interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= EMAC_RX_DLINE_EN;
+		val |= EMAC_DLINE_STEP_15P6 << EMAC_RX_DLINE_STEP_SHIFT;
+		val |= (priv->rx_delay << EMAC_RX_DLINE_CODE_SHIFT) &
+		       EMAC_RX_DLINE_CODE_MASK;
+
+		val |= EMAC_TX_DLINE_EN;
+		val |= EMAC_DLINE_STEP_15P6 << EMAC_TX_DLINE_STEP_SHIFT;
+		val |= (priv->tx_delay << EMAC_TX_DLINE_CODE_SHIFT) &
+		       EMAC_TX_DLINE_CODE_MASK;
+		break;
+	default:
+		break;
+	}
+
+	regmap_update_bits(priv->regmap_apmu,
+			   priv->regmap_apmu_offset + APMU_EMAC_DLINE_REG,
+			   mask, val);
+}
+
+static int emac_phy_connect(struct net_device *ndev)
+{
+	struct emac_priv *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
+	struct phy_device *phydev;
+	struct device_node *np;
+	int ret;
+
+	ret = of_get_phy_mode(dev->of_node, &priv->phy_interface);
+	if (ret) {
+		dev_err(dev, "No phy-mode found");
+		return ret;
+	}
+
+	np = of_parse_phandle(dev->of_node, "phy-handle", 0);
+	if (!np && of_phy_is_fixed_link(dev->of_node))
+		np = of_node_get(dev->of_node);
+	if (!np) {
+		dev_err(dev, "No PHY specified");
+		return -ENODEV;
+	}
+
+	ret = emac_phy_interface_config(priv);
+	if (ret)
+		goto err_node_put;
+
+	phydev = of_phy_connect(ndev, np, &emac_adjust_link, 0,
+				priv->phy_interface);
+	if (IS_ERR_OR_NULL(phydev)) {
+		dev_err(dev, "Could not attach to PHY\n");
+		ret = phydev ? PTR_ERR(phydev) : -ENODEV;
+		goto err_node_put;
+	}
+
+	/* Indicate that the MAC is responsible for PHY PM */
+	phydev->mac_managed_pm = true;
+
+	ndev->phydev = phydev;
+
+	emac_update_delay_line(priv);
+
+err_node_put:
+	of_node_put(np);
+	return ret;
+}
+
+static int emac_up(struct emac_priv *priv)
+{
+	struct platform_device *pdev = priv->pdev;
+	struct net_device *ndev = priv->ndev;
+	int ret;
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	ret = emac_phy_connect(ndev);
+	if (ret) {
+		dev_err(&pdev->dev, "emac_phy_connect failed\n");
+		goto err;
+	}
+
+	emac_init_hw(priv);
+
+	emac_set_mac_addr(priv, ndev->dev_addr);
+	emac_configure_tx(priv);
+	emac_configure_rx(priv);
+
+	emac_alloc_rx_desc_buffers(priv);
+
+	phy_start(ndev->phydev);
+
+	ret = request_irq(priv->irq, emac_interrupt_handler, IRQF_SHARED,
+			  ndev->name, ndev);
+	if (ret) {
+		dev_err(&pdev->dev, "request_irq failed\n");
+		goto request_irq_failed;
+	}
+
+	/* Don't enable MAC interrupts */
+	emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
+
+	/* Enable DMA interrupts */
+	emac_wr(priv, DMA_INTERRUPT_ENABLE,
+		MREGBIT_TRANSMIT_TRANSFER_DONE_INTR_ENABLE |
+			MREGBIT_TRANSMIT_DMA_STOPPED_INTR_ENABLE |
+			MREGBIT_RECEIVE_TRANSFER_DONE_INTR_ENABLE |
+			MREGBIT_RECEIVE_DMA_STOPPED_INTR_ENABLE |
+			MREGBIT_RECEIVE_MISSED_FRAME_INTR_ENABLE);
+
+	napi_enable(&priv->napi);
+
+	netif_start_queue(ndev);
+	return 0;
+
+request_irq_failed:
+	emac_reset_hw(priv);
+	phy_stop(ndev->phydev);
+	phy_disconnect(ndev->phydev);
+
+err:
+	pm_runtime_put_sync(&pdev->dev);
+	return ret;
+}
+
+static int emac_down(struct emac_priv *priv)
+{
+	struct platform_device *pdev = priv->pdev;
+	struct net_device *ndev = priv->ndev;
+
+	netif_stop_queue(ndev);
+
+	phy_stop(ndev->phydev);
+	phy_disconnect(ndev->phydev);
+
+	emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
+	emac_wr(priv, DMA_INTERRUPT_ENABLE, 0x0);
+
+	free_irq(priv->irq, ndev);
+
+	napi_disable(&priv->napi);
+
+	emac_reset_hw(priv);
+
+	pm_runtime_put_sync(&pdev->dev);
+	return 0;
+}
+
+/* Called when net interface is brought up. */
+static int emac_open(struct net_device *ndev)
+{
+	struct emac_priv *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
+
+	int ret;
+
+	ret = emac_alloc_tx_resources(priv);
+	if (ret) {
+		dev_err(dev, "Error when setting up the Tx resources\n");
+		goto emac_alloc_tx_resource_fail;
+	}
+
+	ret = emac_alloc_rx_resources(priv);
+	if (ret) {
+		dev_err(dev, "Error when setting up the Rx resources\n");
+		goto emac_alloc_rx_resource_fail;
+	}
+
+	ret = emac_up(priv);
+	if (ret) {
+		dev_err(dev, "Error when bringing interface up\n");
+		goto emac_up_fail;
+	}
+	return 0;
+
+emac_up_fail:
+	emac_free_rx_resources(priv);
+emac_alloc_rx_resource_fail:
+	emac_free_tx_resources(priv);
+emac_alloc_tx_resource_fail:
+	return ret;
+}
+
+/* Called when interface is brought down. */
+static int emac_close(struct net_device *ndev)
+{
+	struct emac_priv *priv = netdev_priv(ndev);
+
+	emac_down(priv);
+	emac_free_tx_resources(priv);
+	emac_free_rx_resources(priv);
+
+	return 0;
+}
+
+static const struct ethtool_ops emac_ethtool_ops = {
+	.get_link_ksettings     = phy_ethtool_get_link_ksettings,
+	.set_link_ksettings     = phy_ethtool_set_link_ksettings,
+	.get_drvinfo            = emac_get_drvinfo,
+	.nway_reset             = phy_ethtool_nway_reset,
+	.get_link               = ethtool_op_get_link,
+	.get_strings            = emac_get_strings,
+	.get_sset_count         = emac_get_sset_count,
+	.get_ethtool_stats      = emac_get_ethtool_stats,
+	.get_regs		= emac_ethtool_get_regs,
+	.get_regs_len		= emac_ethtool_get_regs_len,
+};
+
+static const struct net_device_ops emac_netdev_ops = {
+	.ndo_open               = emac_open,
+	.ndo_stop               = emac_close,
+	.ndo_start_xmit         = emac_start_xmit,
+	.ndo_set_mac_address    = emac_set_mac_address,
+	.ndo_eth_ioctl          = emac_ioctl,
+	.ndo_change_mtu         = emac_change_mtu,
+	.ndo_tx_timeout         = emac_tx_timeout,
+	.ndo_set_rx_mode        = emac_rx_mode_set,
+};
+
+/* Currently we always use 15.6 ps/step for the delay line */
+
+static u32 delay_ps_to_unit(u32 ps)
+{
+	return DIV_ROUND_CLOSEST(ps * 10, 156);
+}
+
+static u32 delay_unit_to_ps(u32 unit)
+{
+	return DIV_ROUND_CLOSEST(unit * 156, 10);
+}
+
+#define EMAC_MAX_DELAY_UNIT \
+	(EMAC_TX_DLINE_CODE_MASK >> EMAC_TX_DLINE_CODE_SHIFT)
+
+/* Minus one just to be safe from rounding errors */
+#define EMAC_MAX_DELAY_PS	(delay_unit_to_ps(EMAC_MAX_DELAY_UNIT - 1))
+
+static int emac_config_dt(struct platform_device *pdev, struct emac_priv *priv)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	u8 mac_addr[ETH_ALEN] = { 0 };
+	int ret;
+
+	priv->iobase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->iobase))
+		return dev_err_probe(dev, PTR_ERR(priv->iobase),
+				     "ioremap failed\n");
+
+	priv->regmap_apmu =
+		syscon_regmap_lookup_by_phandle_args(np, "spacemit,apmu", 1,
+						     &priv->regmap_apmu_offset);
+
+	if (IS_ERR(priv->regmap_apmu))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap_apmu),
+				     "failed to get syscon\n");
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return -ENXIO;
+
+	ret = of_get_mac_address(np, mac_addr);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			return dev_err_probe(dev, ret,
+					     "Can't get MAC address\n");
+
+		dev_info(&pdev->dev, "Using random MAC address\n");
+		eth_hw_addr_random(priv->ndev);
+	} else {
+		eth_hw_addr_set(priv->ndev, mac_addr);
+	}
+
+	priv->tx_delay = 0;
+	priv->rx_delay = 0;
+
+	of_property_read_u32(np, "tx-internal-delay-ps", &priv->tx_delay);
+	of_property_read_u32(np, "rx-internal-delay-ps", &priv->rx_delay);
+
+	if (priv->tx_delay > EMAC_MAX_DELAY_PS) {
+		dev_err(&pdev->dev,
+			"tx-internal-delay-ps too large: max %d, got %d",
+			EMAC_MAX_DELAY_PS, priv->tx_delay);
+		return -EINVAL;
+	}
+
+	if (priv->rx_delay > EMAC_MAX_DELAY_PS) {
+		dev_err(&pdev->dev,
+			"rx-internal-delay-ps too large: max %d, got %d",
+			EMAC_MAX_DELAY_PS, priv->rx_delay);
+		return -EINVAL;
+	}
+
+	priv->tx_delay = delay_ps_to_unit(priv->tx_delay);
+	priv->rx_delay = delay_ps_to_unit(priv->rx_delay);
+
+	return 0;
+}
+
+static int emac_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control *reset;
+	struct net_device *ndev;
+	struct emac_priv *priv;
+	int ret;
+
+	ndev = devm_alloc_etherdev(dev, sizeof(struct emac_priv));
+	if (!ndev)
+		return -ENOMEM;
+
+	ndev->hw_features = NETIF_F_SG;
+	ndev->features |= ndev->hw_features;
+
+	ndev->min_mtu = ETH_MIN_MTU;
+	ndev->max_mtu =
+		EMAC_RX_BUF_4K - (ETHERNET_HEADER_SIZE + ETHERNET_FCS_SIZE);
+
+	priv = netdev_priv(ndev);
+	priv->ndev = ndev;
+	priv->pdev = pdev;
+	platform_set_drvdata(pdev, priv);
+	priv->hw_stats = devm_kzalloc(dev, sizeof(*priv->hw_stats), GFP_KERNEL);
+	if (!priv->hw_stats) {
+		dev_err(dev, "Failed to allocate memory for stats\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = emac_config_dt(pdev, priv);
+	if (ret < 0) {
+		dev_err(dev, "Configuration failed\n");
+		goto err;
+	}
+
+	ndev->watchdog_timeo = 5 * HZ;
+	ndev->base_addr = (unsigned long)priv->iobase;
+	ndev->irq = priv->irq;
+
+	ndev->ethtool_ops = &emac_ethtool_ops;
+	ndev->netdev_ops = &emac_netdev_ops;
+
+	devm_pm_runtime_enable(&pdev->dev);
+
+	priv->bus_clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(priv->bus_clk)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->bus_clk),
+				    "Failed to get clock\n");
+		goto err;
+	}
+
+	reset = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev,
+								     NULL);
+	if (IS_ERR(reset)) {
+		ret = dev_err_probe(dev, PTR_ERR(reset),
+				    "Failed to get reset\n");
+		goto err;
+	}
+
+	emac_sw_init(priv);
+
+	ret = emac_mdio_init(priv);
+	if (ret) {
+		dev_err(dev, "Failed to init mdio.\n");
+		goto err_timer_delete;
+	}
+
+	SET_NETDEV_DEV(ndev, &pdev->dev);
+
+	ret = devm_register_netdev(dev, ndev);
+	if (ret) {
+		dev_err(dev, "devm_register_netdev failed\n");
+		goto err_timer_delete;
+	}
+
+	netif_napi_add(ndev, &priv->napi, emac_rx_poll);
+	netif_carrier_off(ndev);
+
+	return 0;
+
+err_timer_delete:
+	timer_delete_sync(&priv->txtimer);
+err:
+	return ret;
+}
+
+static void emac_remove(struct platform_device *pdev)
+{
+	struct emac_priv *priv = platform_get_drvdata(pdev);
+
+	emac_reset_hw(priv);
+}
+
+static int emac_resume(struct device *dev)
+{
+	struct emac_priv *priv = dev_get_drvdata(dev);
+	struct net_device *ndev = priv->ndev;
+	int ret;
+
+	ret = clk_prepare_enable(priv->bus_clk);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
+		return ret;
+	}
+
+	if (!netif_running(ndev))
+		return 0;
+
+	emac_open(ndev);
+	netif_device_attach(ndev);
+	return 0;
+}
+
+static int emac_suspend(struct device *dev)
+{
+	struct emac_priv *priv = dev_get_drvdata(dev);
+	struct net_device *ndev = priv->ndev;
+
+	if (!ndev || !netif_running(ndev)) {
+		clk_disable_unprepare(priv->bus_clk);
+		return 0;
+	}
+
+	emac_close(ndev);
+	clk_disable_unprepare(priv->bus_clk);
+	netif_device_detach(ndev);
+	return 0;
+}
+
+static const struct dev_pm_ops emac_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(emac_suspend, emac_resume)
+};
+
+static const struct of_device_id emac_of_match[] = {
+	{ .compatible = "spacemit,k1-emac" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, emac_of_match);
+
+static struct platform_driver emac_driver = {
+	.probe = emac_probe,
+	.remove = emac_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = of_match_ptr(emac_of_match),
+		.pm = &emac_pm_ops,
+	},
+};
+module_platform_driver(emac_driver);
+
+MODULE_DESCRIPTION("SpacemiT K1 Ethernet driver");
+MODULE_AUTHOR("Vivian Wang <wangruikang@iscas.ac.cn>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/spacemit/k1_emac.h b/drivers/net/ethernet/spacemit/k1_emac.h
new file mode 100644
index 0000000000000000000000000000000000000000..7fa801877448b9299e9349626bcf2c999e059948
--- /dev/null
+++ b/drivers/net/ethernet/spacemit/k1_emac.h
@@ -0,0 +1,416 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SpacemiT K1 Ethernet hardware definitions
+ *
+ * Copyright (C) 2023-2025 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (C) 2025 Vivian Wang <wangruikang@iscas.ac.cn>
+ */
+
+#ifndef _K1_EMAC_H_
+#define _K1_EMAC_H_
+
+/* APMU syscon registers */
+
+#define APMU_EMAC_CTRL_REG				0x0
+
+#define PHY_INTF_RGMII					BIT(2)
+
+/*
+ * Only valid for RMII mode
+ * 0: Ref clock from External PHY
+ * 1: Ref clock from SoC
+ */
+#define REF_CLK_SEL					BIT(3)
+
+/*
+ * Function clock select
+ * 0: 208 MHz
+ * 1: 312 MHz
+ */
+#define FUNC_CLK_SEL					BIT(4)
+
+/* Only valid for RMII, invert TX clk */
+#define RMII_TX_CLK_SEL					BIT(6)
+
+/* Only valid for RMII, invert RX clk */
+#define RMII_RX_CLK_SEL					BIT(7)
+
+/*
+ * Only valid for RGMII
+ * 0: TX clk from RX clk
+ * 1: TX clk from SoC
+ */
+#define RGMII_TX_CLK_SEL				BIT(8)
+
+#define PHY_IRQ_EN					BIT(12)
+#define AXI_SINGLE_ID					BIT(13)
+
+#define RMII_TX_PHASE_SHIFT				16
+#define RMII_TX_PHASE_MASK				GENMASK(18, 16)
+#define RMII_RX_PHASE_SHIFT				20
+#define RMII_RX_PHASE_MASK				GENMASK(22, 20)
+
+#define RGMII_TX_PHASE_SHIFT				24
+#define RGMII_TX_PHASE_MASK				GENMASK(26, 24)
+#define RGMII_RX_PHASE_SHIFT				28
+#define RGMII_RX_PHASE_MASK				GENMASK(30, 28)
+
+#define APMU_EMAC_DLINE_REG				0x4
+
+#define EMAC_RX_DLINE_EN				BIT(0)
+#define EMAC_RX_DLINE_STEP_SHIFT			4
+#define EMAC_RX_DLINE_STEP_MASK				GENMASK(5, 4)
+#define EMAC_RX_DLINE_CODE_SHIFT			8
+#define EMAC_RX_DLINE_CODE_MASK				GENMASK(15, 8)
+
+#define EMAC_TX_DLINE_EN				BIT(16)
+#define EMAC_TX_DLINE_STEP_SHIFT			20
+#define EMAC_TX_DLINE_STEP_MASK				GENMASK(21, 20)
+#define EMAC_TX_DLINE_CODE_SHIFT			24
+#define EMAC_TX_DLINE_CODE_MASK				GENMASK(31, 24)
+
+#define EMAC_DLINE_STEP_15P6				0  /* 15.6 ps/step */
+#define EMAC_DLINE_STEP_24P4				1  /* 24.4 ps/step */
+#define EMAC_DLINE_STEP_29P7				2  /* 29.7 ps/step */
+#define EMAC_DLINE_STEP_35P1				3  /* 35.1 ps/step */
+
+/* DMA register set */
+#define DMA_CONFIGURATION				0x0000
+#define DMA_CONTROL					0x0004
+#define DMA_STATUS_IRQ					0x0008
+#define DMA_INTERRUPT_ENABLE				0x000c
+
+#define DMA_TRANSMIT_AUTO_POLL_COUNTER			0x0010
+#define DMA_TRANSMIT_POLL_DEMAND			0x0014
+#define DMA_RECEIVE_POLL_DEMAND				0x0018
+
+#define DMA_TRANSMIT_BASE_ADDRESS			0x001c
+#define DMA_RECEIVE_BASE_ADDRESS			0x0020
+#define DMA_MISSED_FRAME_COUNTER			0x0024
+#define DMA_STOP_FLUSH_COUNTER				0x0028
+
+#define DMA_RECEIVE_IRQ_MITIGATION_CTRL			0x002c
+
+#define DMA_CURRENT_TRANSMIT_DESCRIPTOR_POINTER		0x0030
+#define DMA_CURRENT_TRANSMIT_BUFFER_POINTER		0x0034
+#define DMA_CURRENT_RECEIVE_DESCRIPTOR_POINTER		0x0038
+#define DMA_CURRENT_RECEIVE_BUFFER_POINTER		0x003c
+
+/* MAC Register set */
+#define MAC_GLOBAL_CONTROL				0x0100
+#define MAC_TRANSMIT_CONTROL				0x0104
+#define MAC_RECEIVE_CONTROL				0x0108
+#define MAC_MAXIMUM_FRAME_SIZE				0x010c
+#define MAC_TRANSMIT_JABBER_SIZE			0x0110
+#define MAC_RECEIVE_JABBER_SIZE				0x0114
+#define MAC_ADDRESS_CONTROL				0x0118
+#define MAC_MDIO_CLK_DIV				0x011c
+#define MAC_ADDRESS1_HIGH				0x0120
+#define MAC_ADDRESS1_MED				0x0124
+#define MAC_ADDRESS1_LOW				0x0128
+#define MAC_ADDRESS2_HIGH				0x012c
+#define MAC_ADDRESS2_MED				0x0130
+#define MAC_ADDRESS2_LOW				0x0134
+#define MAC_ADDRESS3_HIGH				0x0138
+#define MAC_ADDRESS3_MED				0x013c
+#define MAC_ADDRESS3_LOW				0x0140
+#define MAC_ADDRESS4_HIGH				0x0144
+#define MAC_ADDRESS4_MED				0x0148
+#define MAC_ADDRESS4_LOW				0x014c
+#define MAC_MULTICAST_HASH_TABLE1			0x0150
+#define MAC_MULTICAST_HASH_TABLE2			0x0154
+#define MAC_MULTICAST_HASH_TABLE3			0x0158
+#define MAC_MULTICAST_HASH_TABLE4			0x015c
+#define MAC_FC_CONTROL					0x0160
+#define MAC_FC_PAUSE_FRAME_GENERATE			0x0164
+#define MAC_FC_SOURCE_ADDRESS_HIGH			0x0168
+#define MAC_FC_SOURCE_ADDRESS_MED			0x016c
+#define MAC_FC_SOURCE_ADDRESS_LOW			0x0170
+#define MAC_FC_DESTINATION_ADDRESS_HIGH			0x0174
+#define MAC_FC_DESTINATION_ADDRESS_MED			0x0178
+#define MAC_FC_DESTINATION_ADDRESS_LOW			0x017c
+#define MAC_FC_PAUSE_TIME_VALUE				0x0180
+#define MAC_MDIO_CONTROL				0x01a0
+#define MAC_MDIO_DATA					0x01a4
+#define MAC_RX_STATCTR_CONTROL				0x01a8
+#define MAC_RX_STATCTR_DATA_HIGH			0x01ac
+#define MAC_RX_STATCTR_DATA_LOW				0x01b0
+#define MAC_TX_STATCTR_CONTROL				0x01b4
+#define MAC_TX_STATCTR_DATA_HIGH			0x01b8
+#define MAC_TX_STATCTR_DATA_LOW				0x01bc
+#define MAC_TRANSMIT_FIFO_ALMOST_FULL			0x01c0
+#define MAC_TRANSMIT_PACKET_START_THRESHOLD		0x01c4
+#define MAC_RECEIVE_PACKET_START_THRESHOLD		0x01c8
+#define MAC_STATUS_IRQ					0x01e0
+#define MAC_INTERRUPT_ENABLE				0x01e4
+
+/* DMA_CONFIGURATION (0x0000) */
+
+/*
+ * 0-DMA controller in normal operation mode,
+ * 1-DMA controller reset to default state,
+ * clearing all internal state information
+ */
+#define MREGBIT_SOFTWARE_RESET				BIT(0)
+
+#define MREGBIT_BURST_1WORD				BIT(1)
+#define MREGBIT_BURST_2WORD				BIT(2)
+#define MREGBIT_BURST_4WORD				BIT(3)
+#define MREGBIT_BURST_8WORD				BIT(4)
+#define MREGBIT_BURST_16WORD				BIT(5)
+#define MREGBIT_BURST_32WORD				BIT(6)
+#define MREGBIT_BURST_64WORD				BIT(7)
+#define MREGBIT_BURST_LENGTH				GENMASK(7, 1)
+#define MREGBIT_DESCRIPTOR_SKIP_LENGTH			GENMASK(12, 8)
+
+/* For Receive and Transmit DMA operate in Big-Endian mode for Descriptors. */
+#define MREGBIT_DESCRIPTOR_BYTE_ORDERING		BIT(13)
+
+#define MREGBIT_BIG_LITLE_ENDIAN			BIT(14)
+#define MREGBIT_TX_RX_ARBITRATION			BIT(15)
+#define MREGBIT_WAIT_FOR_DONE				BIT(16)
+#define MREGBIT_STRICT_BURST				BIT(17)
+#define MREGBIT_DMA_64BIT_MODE				BIT(18)
+
+/* DMA_CONTROL (0x0004) */
+#define MREGBIT_START_STOP_TRANSMIT_DMA			BIT(0)
+#define MREGBIT_START_STOP_RECEIVE_DMA			BIT(1)
+
+/* DMA_STATUS_IRQ (0x0008) */
+#define MREGBIT_TRANSMIT_TRANSFER_DONE_IRQ		BIT(0)
+#define MREGBIT_TRANSMIT_DES_UNAVAILABLE_IRQ		BIT(1)
+#define MREGBIT_TRANSMIT_DMA_STOPPED_IRQ		BIT(2)
+#define MREGBIT_RECEIVE_TRANSFER_DONE_IRQ		BIT(4)
+#define MREGBIT_RECEIVE_DES_UNAVAILABLE_IRQ		BIT(5)
+#define MREGBIT_RECEIVE_DMA_STOPPED_IRQ			BIT(6)
+#define MREGBIT_RECEIVE_MISSED_FRAME_IRQ		BIT(7)
+#define MREGBIT_MAC_IRQ					BIT(8)
+#define MREGBIT_TRANSMIT_DMA_STATE			GENMASK(18, 16)
+#define MREGBIT_RECEIVE_DMA_STATE			GENMASK(23, 20)
+
+/* DMA_INTERRUPT_ENABLE (0x000c) */
+#define MREGBIT_TRANSMIT_TRANSFER_DONE_INTR_ENABLE	BIT(0)
+#define MREGBIT_TRANSMIT_DES_UNAVAILABLE_INTR_ENABLE	BIT(1)
+#define MREGBIT_TRANSMIT_DMA_STOPPED_INTR_ENABLE	BIT(2)
+#define MREGBIT_RECEIVE_TRANSFER_DONE_INTR_ENABLE	BIT(4)
+#define MREGBIT_RECEIVE_DES_UNAVAILABLE_INTR_ENABLE	BIT(5)
+#define MREGBIT_RECEIVE_DMA_STOPPED_INTR_ENABLE		BIT(6)
+#define MREGBIT_RECEIVE_MISSED_FRAME_INTR_ENABLE	BIT(7)
+#define MREGBIT_MAC_INTR_ENABLE				BIT(8)
+
+/* DMA_RECEIVE_IRQ_MITIGATION_CTRL (0x002c) */
+#define MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MASK		GENMASK(7, 0)
+#define MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_SHIFT	8
+#define MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_MASK	GENMASK(27, 8)
+#define MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MODE		BIT(30)
+#define MREGBIT_RECEIVE_IRQ_MITIGATION_ENABLE		BIT(31)
+
+/* MAC_GLOBAL_CONTROL (0x0100) */
+#define MREGBIT_SPEED					GENMASK(1, 0)
+#define MREGBIT_SPEED_10M				0x0
+#define MREGBIT_SPEED_100M				BIT(0)
+#define MREGBIT_SPEED_1000M				BIT(1)
+#define MREGBIT_FULL_DUPLEX_MODE			BIT(2)
+#define MREGBIT_RESET_RX_STAT_COUNTERS			BIT(3)
+#define MREGBIT_RESET_TX_STAT_COUNTERS			BIT(4)
+#define MREGBIT_UNICAST_WAKEUP_MODE			BIT(8)
+#define MREGBIT_MAGIC_PACKET_WAKEUP_MODE		BIT(9)
+
+/* MAC_TRANSMIT_CONTROL (0x0104) */
+#define MREGBIT_TRANSMIT_ENABLE				BIT(0)
+#define MREGBIT_INVERT_FCS				BIT(1)
+#define MREGBIT_DISABLE_FCS_INSERT			BIT(2)
+#define MREGBIT_TRANSMIT_AUTO_RETRY			BIT(3)
+#define MREGBIT_IFG_LEN					GENMASK(6, 4)
+#define MREGBIT_PREAMBLE_LENGTH				GENMASK(9, 7)
+
+/* MAC_RECEIVE_CONTROL (0x0108) */
+#define MREGBIT_RECEIVE_ENABLE				BIT(0)
+#define MREGBIT_DISABLE_FCS_CHECK			BIT(1)
+#define MREGBIT_STRIP_FCS				BIT(2)
+#define MREGBIT_STORE_FORWARD				BIT(3)
+#define MREGBIT_STATUS_FIRST				BIT(4)
+#define MREGBIT_PASS_BAD_FRAMES				BIT(5)
+#define MREGBIT_ACOOUNT_VLAN				BIT(6)
+
+/* MAC_MAXIMUM_FRAME_SIZE (0x010c) */
+#define MREGBIT_MAX_FRAME_SIZE				GENMASK(13, 0)
+
+/* MAC_TRANSMIT_JABBER_SIZE (0x0110) */
+#define MREGBIT_TRANSMIT_JABBER_SIZE			GENMASK(15, 0)
+
+/* MAC_RECEIVE_JABBER_SIZE (0x0114) */
+#define MREGBIT_RECEIVE_JABBER_SIZE			GENMASK(15, 0)
+
+/* MAC_ADDRESS_CONTROL (0x0118) */
+#define MREGBIT_MAC_ADDRESS1_ENABLE			BIT(0)
+#define MREGBIT_MAC_ADDRESS2_ENABLE			BIT(1)
+#define MREGBIT_MAC_ADDRESS3_ENABLE			BIT(2)
+#define MREGBIT_MAC_ADDRESS4_ENABLE			BIT(3)
+#define MREGBIT_INVERSE_MAC_ADDRESS1_ENABLE		BIT(4)
+#define MREGBIT_INVERSE_MAC_ADDRESS2_ENABLE		BIT(5)
+#define MREGBIT_INVERSE_MAC_ADDRESS3_ENABLE		BIT(6)
+#define MREGBIT_INVERSE_MAC_ADDRESS4_ENABLE		BIT(7)
+#define MREGBIT_PROMISCUOUS_MODE			BIT(8)
+
+/* MAC_FC_CONTROL (0x0160) */
+#define MREGBIT_FC_DECODE_ENABLE			BIT(0)
+#define MREGBIT_FC_GENERATION_ENABLE			BIT(1)
+#define MREGBIT_AUTO_FC_GENERATION_ENABLE		BIT(2)
+#define MREGBIT_MULTICAST_MODE				BIT(3)
+#define MREGBIT_BLOCK_PAUSE_FRAMES			BIT(4)
+
+/* MAC_FC_PAUSE_FRAME_GENERATE (0x0164) */
+#define MREGBIT_GENERATE_PAUSE_FRAME			BIT(0)
+
+/* MAC_FC_PAUSE_TIME_VALUE (0x0180) */
+#define MREGBIT_MAC_FC_PAUSE_TIME			GENMASK(15, 0)
+
+/* MAC_MDIO_CONTROL (0x01a0) */
+#define MREGBIT_PHY_ADDRESS				GENMASK(4, 0)
+#define MREGBIT_REGISTER_ADDRESS			GENMASK(9, 5)
+#define MREGBIT_MDIO_READ_WRITE				BIT(10)
+#define MREGBIT_START_MDIO_TRANS			BIT(15)
+
+/* MAC_MDIO_DATA (0x01a4) */
+#define MREGBIT_MDIO_DATA				GENMASK(15, 0)
+
+/* MAC_RX_STATCTR_CONTROL (0x01a8) */
+#define MREGBIT_RX_COUNTER_NUMBER			GENMASK(4, 0)
+#define MREGBIT_START_RX_COUNTER_READ			BIT(15)
+
+/* MAC_RX_STATCTR_DATA_HIGH (0x01ac) */
+#define MREGBIT_RX_STATCTR_DATA_HIGH			GENMASK(15, 0)
+/* MAC_RX_STATCTR_DATA_LOW (0x01b0) */
+#define MREGBIT_RX_STATCTR_DATA_LOW			GENMASK(15, 0)
+
+/* MAC_TX_STATCTR_CONTROL (0x01b4) */
+#define MREGBIT_TX_COUNTER_NUMBER			GENMASK(4, 0)
+#define MREGBIT_START_TX_COUNTER_READ			BIT(15)
+
+/* MAC_TX_STATCTR_DATA_HIGH (0x01b8) */
+#define MREGBIT_TX_STATCTR_DATA_HIGH			GENMASK(15, 0)
+/* MAC_TX_STATCTR_DATA_LOW (0x01bc) */
+#define MREGBIT_TX_STATCTR_DATA_LOW			GENMASK(15, 0)
+
+/* MAC_TRANSMIT_FIFO_ALMOST_FULL (0x01c0) */
+#define MREGBIT_TX_FIFO_AF				GENMASK(13, 0)
+
+/* MAC_TRANSMIT_PACKET_START_THRESHOLD (0x01c4) */
+#define MREGBIT_TX_PACKET_START_THRESHOLD		GENMASK(13, 0)
+
+/* MAC_RECEIVE_PACKET_START_THRESHOLD (0x01c8) */
+#define MREGBIT_RX_PACKET_START_THRESHOLD		GENMASK(13, 0)
+
+/* MAC_STATUS_IRQ (0x01e0) */
+#define MREGBIT_MAC_UNDERRUN_IRQ			BIT(0)
+#define MREGBIT_MAC_JABBER_IRQ				BIT(1)
+
+/* MAC_INTERRUPT_ENABLE (0x01e4) */
+#define MREGBIT_MAC_UNDERRUN_INTERRUPT_ENABLE		BIT(0)
+#define MREGBIT_JABBER_INTERRUPT_ENABLE			BIT(1)
+
+/* RX DMA descriptor */
+
+#define RX_DESC_0_FRAME_PACKET_LENGTH_SHIFT		0
+#define RX_DESC_0_FRAME_PACKET_LENGTH_MASK		GENMASK(13, 0)
+#define RX_DESC_0_FRAME_ALIGN_ERR			BIT(14)
+#define RX_DESC_0_FRAME_RUNT				BIT(15)
+#define RX_DESC_0_FRAME_ETHERNET_TYPE			BIT(16)
+#define RX_DESC_0_FRAME_VLAN				BIT(17)
+#define RX_DESC_0_FRAME_MULTICAST			BIT(18)
+#define RX_DESC_0_FRAME_BROADCAST			BIT(19)
+#define RX_DESC_0_FRAME_CRC_ERR				BIT(20)
+#define RX_DESC_0_FRAME_MAX_LEN_ERR			BIT(21)
+#define RX_DESC_0_FRAME_JABBER_ERR			BIT(22)
+#define RX_DESC_0_FRAME_LENGTH_ERR			BIT(23)
+#define RX_DESC_0_FRAME_MAC_ADDR1_MATCH			BIT(24)
+#define RX_DESC_0_FRAME_MAC_ADDR2_MATCH			BIT(25)
+#define RX_DESC_0_FRAME_MAC_ADDR3_MATCH			BIT(26)
+#define RX_DESC_0_FRAME_MAC_ADDR4_MATCH			BIT(27)
+#define RX_DESC_0_FRAME_PAUSE_CTRL			BIT(28)
+#define RX_DESC_0_LAST_DESCRIPTOR			BIT(29)
+#define RX_DESC_0_FIRST_DESCRIPTOR			BIT(30)
+#define RX_DESC_0_OWN					BIT(31)
+
+#define RX_DESC_1_BUFFER_SIZE_1_SHIFT			0
+#define RX_DESC_1_BUFFER_SIZE_1_MASK			GENMASK(11, 0)
+#define RX_DESC_1_BUFFER_SIZE_2_SHIFT			12
+#define RX_DESC_1_BUFFER_SIZE_2_MASK			GENMASK(23, 12)
+							/* [24] reserved */
+#define RX_DESC_1_SECOND_ADDRESS_CHAINED		BIT(25)
+#define RX_DESC_1_END_RING				BIT(26)
+							/* [29:27] reserved */
+#define RX_DESC_1_RX_TIMESTAMP				BIT(30)
+#define RX_DESC_1_PTP_PKT				BIT(31)
+
+/* TX DMA descriptor */
+
+							/* [29:0] unused */
+#define TX_DESC_0_TX_TIMESTAMP				BIT(30)
+#define TX_DESC_0_OWN					BIT(31)
+
+#define TX_DESC_1_BUFFER_SIZE_1_SHIFT			0
+#define TX_DESC_1_BUFFER_SIZE_1_MASK			GENMASK(11, 0)
+#define TX_DESC_1_BUFFER_SIZE_2_SHIFT			12
+#define TX_DESC_1_BUFFER_SIZE_2_MASK			GENMASK(23, 12)
+#define TX_DESC_1_FORCE_EOP_ERROR			BIT(24)
+#define TX_DESC_1_SECOND_ADDRESS_CHAINED		BIT(25)
+#define TX_DESC_1_END_RING				BIT(26)
+#define TX_DESC_1_DISABLE_PADDING			BIT(27)
+#define TX_DESC_1_ADD_CRC_DISABLE			BIT(28)
+#define TX_DESC_1_FIRST_SEGMENT				BIT(29)
+#define TX_DESC_1_LAST_SEGMENT				BIT(30)
+#define TX_DESC_1_INTERRUPT_ON_COMPLETION		BIT(31)
+
+struct emac_desc {
+	u32 desc0;
+	u32 desc1;
+	u32 buffer_addr_1;
+	u32 buffer_addr_2;
+};
+
+struct emac_hw_stats {
+	u32 tx_ok_pkts;
+	u32 tx_total_pkts;
+	u32 tx_ok_bytes;
+	u32 tx_err_pkts;
+	u32 tx_singleclsn_pkts;
+	u32 tx_multiclsn_pkts;
+	u32 tx_lateclsn_pkts;
+	u32 tx_excessclsn_pkts;
+	u32 tx_unicast_pkts;
+	u32 tx_multicast_pkts;
+	u32 tx_broadcast_pkts;
+	u32 tx_pause_pkts;
+	u32 rx_ok_pkts;
+	u32 rx_total_pkts;
+	u32 rx_crc_err_pkts;
+	u32 rx_align_err_pkts;
+	u32 rx_err_total_pkts;
+	u32 rx_ok_bytes;
+	u32 rx_total_bytes;
+	u32 rx_unicast_pkts;
+	u32 rx_multicast_pkts;
+	u32 rx_broadcast_pkts;
+	u32 rx_pause_pkts;
+	u32 rx_len_err_pkts;
+	u32 rx_len_undersize_pkts;
+	u32 rx_len_oversize_pkts;
+	u32 rx_len_fragment_pkts;
+	u32 rx_len_jabber_pkts;
+	u32 rx_64_pkts;
+	u32 rx_65_127_pkts;
+	u32 rx_128_255_pkts;
+	u32 rx_256_511_pkts;
+	u32 rx_512_1023_pkts;
+	u32 rx_1024_1518_pkts;
+	u32 rx_1519_plus_pkts;
+	u32 rx_drp_fifo_full_pkts;
+	u32 rx_truncate_fifo_full_pkts;
+};
+
+#define EMAC_TX_STATS_NUM				12
+#define EMAC_RX_STATS_NUM				25
+
+#endif /* _K1_EMAC_H_ */

-- 
2.49.0


