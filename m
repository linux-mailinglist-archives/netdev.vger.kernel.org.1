Return-Path: <netdev+bounces-248411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C068AD083E3
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 958613006980
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C86358D1B;
	Fri,  9 Jan 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Vq5AKWOG"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A93332EB8;
	Fri,  9 Jan 2026 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951363; cv=pass; b=CO6jM3mGNlwORX7qrq1Gr7sEqyM/yDcaaL/myTHVbMuRsWKY0lil+PcwuFVLXXzi6mEAzow2/CjDOUjkQNfjvOHnrfWVFEOEQRiwxZWnTqOowDYR2txG2t9Sdeb5TlNZ9rijyfNQKYZZsq8qM5TGtfH1ufzPsZRVmLpNJYQK0Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951363; c=relaxed/simple;
	bh=wMh8HDCFjc9OzCQZWa057pNkEMejymMqbJ9LhrI967w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftkMclLmvsPSND/f3qwnp6yERAP2OJQodGQuc+KNGC/WjEAWpC6SpxyBETcp2X/3UhbuvcLArfCn1Guw1TYRwLLr5os0gtxZ4ua4u7ojCTm2kUQy5YFmyNpvUYLta72D9x5HkYbBn7Sft8lvbdUeL9ExrSuIG18ENRGhXGmuzk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=Vq5AKWOG; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1767951325; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n7wE59zuN9rmHIlDemj5cVMF9kSk8hDtnFNNdvGGLDn6UCktt39fVkNyR1qcvnoTJpQj2XhIetJGJCzkSc/oE6Rl8bw/lJHtpaC7dEo3JB9bu6Utto0BGUJZ6EW9byM2UEMKFhHMnCt1reyw9Z7jIoSgSm0iIfw3aV02LwFLpQ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767951325; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qb0IGAZb6d6nRD5DYtkmSvkOEvCv3nCdj2rlDrf3onI=; 
	b=BRwDwXcGakHXtw8UWn92KKKjjJ0DTR2YCdCQXHMWIIXc8xSPWsMYzfdcpFccH00C8ITPglTY6LQDNAyCHK24G69qCHtWRuWLJzqUDzD2m3wnQbWM/XxPtiEokKkm+C97wNJR7w9OLoHOBJP80kyx4Jfe1I+RAMOaLpWWm/+mJTA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767951325;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qb0IGAZb6d6nRD5DYtkmSvkOEvCv3nCdj2rlDrf3onI=;
	b=Vq5AKWOG0hjaZS4rnW85uxFSYFOg7QtT4hpmukBBKlpjmg4Nr/28LCoOhEvmmGcl
	l/mT4Jy1zROAs7T78JFvd92xybW12AiFBdalcl7cWbNePNtf8lyIP7AAAb3e5+WvnXl
	qiKER26KsgL54nfqfq9FhvhyqMo++qPNWqfxSiyI=
Received: by mx.zohomail.com with SMTPS id 1767951322847204.67387021282582;
	Fri, 9 Jan 2026 01:35:22 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <me@ziyao.cc>,
	Runhua He <hua@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH RESEND net-next v6 2/3] net: stmmac: Add glue driver for Motorcomm YT6801 ethernet controller
Date: Fri,  9 Jan 2026 09:34:45 +0000
Message-ID: <20260109093445.46791-4-me@ziyao.cc>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109093445.46791-2-me@ziyao.cc>
References: <20260109093445.46791-2-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Motorcomm YT6801 is a PCIe ethernet controller based on DWMAC4 IP. It
integrates an GbE phy, supporting WOL, VLAN tagging and various types
of offloading. It ships an on-chip eFuse for storing various vendor
configuration, including MAC address.

This patch adds basic glue code for the controller, allowing it to be
set up and transmit data at a reasonable speed. Features like WOL could
be implemented in the future.

Signed-off-by: Yao Zi <me@ziyao.cc>
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Runhua He <hua@aosc.io>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   9 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-motorcomm.c | 384 ++++++++++++++++++
 3 files changed, 394 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 907fe2e927f0..07088d03dbab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -374,6 +374,15 @@ config DWMAC_LOONGSON
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
 	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
 
+config DWMAC_MOTORCOMM
+	tristate "Motorcomm PCI DWMAC support"
+	depends on PCI
+	select MOTORCOMM_PHY
+	select STMMAC_LIBPCI
+	help
+	  This enables glue driver for Motorcomm DWMAC-based PCI Ethernet
+	  controllers. Currently only YT6801 is supported.
+
 config STMMAC_PCI
 	tristate "STMMAC PCI bus support"
 	depends on PCI
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 7bf528731034..c9263987ef8d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -48,4 +48,5 @@ obj-$(CONFIG_STMMAC_LIBPCI)	+= stmmac_libpci.o
 obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
 obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
 obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
+obj-$(CONFIG_DWMAC_MOTORCOMM)	+= dwmac-motorcomm.o
 stmmac-pci-objs:= stmmac_pci.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
new file mode 100644
index 000000000000..8b45b9cf7202
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DWMAC glue driver for Motorcomm PCI Ethernet controllers
+ *
+ * Copyright (c) 2025-2026 Yao Zi <me@ziyao.cc>
+ */
+
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/stmmac.h>
+
+#include "dwmac4.h"
+#include "stmmac.h"
+#include "stmmac_libpci.h"
+
+#define DRIVER_NAME "dwmac-motorcomm"
+
+#define PCI_VENDOR_ID_MOTORCOMM			0x1f0a
+
+/* Register definition */
+#define EPHY_CTRL				0x1004
+/* Clearing this bit asserts resets for internal MDIO bus and PHY */
+#define  EPHY_MDIO_PHY_RESET			BIT(0)
+#define OOB_WOL_CTRL				0x1010
+#define  OOB_WOL_CTRL_DIS			BIT(0)
+#define MGMT_INT_CTRL0				0x1100
+#define INT_MODERATION				0x1108
+#define  INT_MODERATION_RX			GENMASK(11, 0)
+#define  INT_MODERATION_TX			GENMASK(27, 16)
+#define EFUSE_OP_CTRL_0				0x1500
+#define  EFUSE_OP_MODE				GENMASK(1, 0)
+#define   EFUSE_OP_ROW_READ			0x1
+#define  EFUSE_OP_START				BIT(2)
+#define  EFUSE_OP_ADDR				GENMASK(15, 8)
+#define EFUSE_OP_CTRL_1				0x1504
+#define  EFUSE_OP_DONE				BIT(1)
+#define  EFUSE_OP_RD_DATA			GENMASK(31, 24)
+#define SYS_RESET				0x152c
+#define  SYS_RESET_RESET			BIT(31)
+#define GMAC_OFFSET				0x2000
+
+/* Constants */
+#define EFUSE_READ_TIMEOUT_US			20000
+#define EFUSE_PATCH_REGION_OFFSET		18
+#define EFUSE_PATCH_MAX_NUM			39
+#define EFUSE_ADDR_MACA0LR			0x1520
+#define EFUSE_ADDR_MACA0HR			0x1524
+
+struct motorcomm_efuse_patch {
+	__le16 addr;
+	__le32 data;
+} __packed;
+
+struct dwmac_motorcomm_priv {
+	void __iomem *base;
+};
+
+static int motorcomm_efuse_read_byte(struct dwmac_motorcomm_priv *priv,
+				     u8 offset, u8 *byte)
+{
+	u32 reg;
+	int ret;
+
+	writel(FIELD_PREP(EFUSE_OP_MODE, EFUSE_OP_ROW_READ)	|
+	       FIELD_PREP(EFUSE_OP_ADDR, offset)		|
+	       EFUSE_OP_START, priv->base + EFUSE_OP_CTRL_0);
+
+	ret = readl_poll_timeout(priv->base + EFUSE_OP_CTRL_1,
+				 reg, reg & EFUSE_OP_DONE, 2000,
+				 EFUSE_READ_TIMEOUT_US);
+
+	*byte = FIELD_GET(EFUSE_OP_RD_DATA, reg);
+
+	return ret;
+}
+
+static int motorcomm_efuse_read_patch(struct dwmac_motorcomm_priv *priv,
+				      u8 index,
+				      struct motorcomm_efuse_patch *patch)
+{
+	u8 *p = (u8 *)patch, offset;
+	int i, ret;
+
+	for (i = 0; i < sizeof(*patch); i++) {
+		offset = EFUSE_PATCH_REGION_OFFSET + sizeof(*patch) * index + i;
+
+		ret = motorcomm_efuse_read_byte(priv, offset, &p[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int motorcomm_efuse_get_patch_value(struct dwmac_motorcomm_priv *priv,
+					   u16 addr, u32 *value)
+{
+	struct motorcomm_efuse_patch patch;
+	int i, ret;
+
+	for (i = 0; i < EFUSE_PATCH_MAX_NUM; i++) {
+		ret = motorcomm_efuse_read_patch(priv, i, &patch);
+		if (ret)
+			return ret;
+
+		if (patch.addr == 0) {
+			return -ENOENT;
+		} else if (le16_to_cpu(patch.addr) == addr) {
+			*value = le32_to_cpu(patch.data);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static int motorcomm_efuse_read_mac(struct device *dev,
+				    struct dwmac_motorcomm_priv *priv, u8 *mac)
+{
+	u32 maca0lr, maca0hr;
+	int ret;
+
+	ret = motorcomm_efuse_get_patch_value(priv, EFUSE_ADDR_MACA0LR,
+					      &maca0lr);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to read maca0lr from eFuse\n");
+
+	ret = motorcomm_efuse_get_patch_value(priv, EFUSE_ADDR_MACA0HR,
+					      &maca0hr);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to read maca0hr from eFuse\n");
+
+	mac[0] = FIELD_GET(GENMASK(15, 8), maca0hr);
+	mac[1] = FIELD_GET(GENMASK(7, 0), maca0hr);
+	mac[2] = FIELD_GET(GENMASK(31, 24), maca0lr);
+	mac[3] = FIELD_GET(GENMASK(23, 16), maca0lr);
+	mac[4] = FIELD_GET(GENMASK(15, 8), maca0lr);
+	mac[5] = FIELD_GET(GENMASK(7, 0), maca0lr);
+
+	return 0;
+}
+
+static void motorcomm_deassert_mdio_phy_reset(struct dwmac_motorcomm_priv *priv)
+{
+	u32 reg = readl(priv->base + EPHY_CTRL);
+
+	reg |= EPHY_MDIO_PHY_RESET;
+
+	writel(reg, priv->base + EPHY_CTRL);
+}
+
+static void motorcomm_reset(struct dwmac_motorcomm_priv *priv)
+{
+	u32 reg = readl(priv->base + SYS_RESET);
+
+	reg &= ~SYS_RESET_RESET;
+	writel(reg, priv->base + SYS_RESET);
+
+	reg |= SYS_RESET_RESET;
+	writel(reg, priv->base + SYS_RESET);
+
+	motorcomm_deassert_mdio_phy_reset(priv);
+}
+
+static void motorcomm_init(struct dwmac_motorcomm_priv *priv)
+{
+	writel(0x0, priv->base + MGMT_INT_CTRL0);
+
+	writel(FIELD_PREP(INT_MODERATION_RX, 200) |
+	       FIELD_PREP(INT_MODERATION_TX, 200),
+	       priv->base + INT_MODERATION);
+
+	/*
+	 * OOB WOL must be disabled during normal operation, or DMA interrupts
+	 * cannot be delivered to the host.
+	 */
+	writel(OOB_WOL_CTRL_DIS, priv->base + OOB_WOL_CTRL);
+}
+
+static int motorcomm_resume(struct device *dev, void *bsp_priv)
+{
+	struct dwmac_motorcomm_priv *priv = bsp_priv;
+	int ret;
+
+	ret = stmmac_pci_plat_resume(dev, bsp_priv);
+	if (ret)
+		return ret;
+
+	/*
+	 * When recovering from D3hot, EPHY_MDIO_PHY_RESET is automatically
+	 * asserted, and must be deasserted for normal operation.
+	 */
+	motorcomm_deassert_mdio_phy_reset(priv);
+	motorcomm_init(priv);
+
+	return 0;
+}
+
+static struct plat_stmmacenet_data *
+motorcomm_default_plat_data(struct pci_dev *pdev)
+{
+	struct plat_stmmacenet_data *plat;
+	struct device *dev = &pdev->dev;
+
+	plat = stmmac_plat_dat_alloc(dev);
+	if (!plat)
+		return NULL;
+
+	plat->mdio_bus_data = devm_kzalloc(dev, sizeof(*plat->mdio_bus_data),
+					   GFP_KERNEL);
+	if (!plat->mdio_bus_data)
+		return NULL;
+
+	plat->dma_cfg = devm_kzalloc(dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
+	if (!plat->dma_cfg)
+		return NULL;
+
+	plat->axi = devm_kzalloc(dev, sizeof(*plat->axi), GFP_KERNEL);
+	if (!plat->axi)
+		return NULL;
+
+	plat->dma_cfg->pbl		= DEFAULT_DMA_PBL;
+	plat->dma_cfg->pblx8		= true;
+	plat->dma_cfg->txpbl		= 32;
+	plat->dma_cfg->rxpbl		= 32;
+	plat->dma_cfg->eame		= true;
+	plat->dma_cfg->mixed_burst	= true;
+
+	plat->axi->axi_wr_osr_lmt	= 1;
+	plat->axi->axi_rd_osr_lmt	= 1;
+	plat->axi->axi_mb		= true;
+	plat->axi->axi_blen_regval	= DMA_AXI_BLEN4 | DMA_AXI_BLEN8 |
+					  DMA_AXI_BLEN16 | DMA_AXI_BLEN32;
+
+	plat->bus_id		= pci_dev_id(pdev);
+	plat->phy_interface	= PHY_INTERFACE_MODE_GMII;
+	/*
+	 * YT6801 requires an 25MHz clock input/oscillator to function, which
+	 * is likely the source of CSR clock.
+	 */
+	plat->clk_csr		= STMMAC_CSR_20_35M;
+	plat->tx_coe		= 1;
+	plat->rx_coe		= 1;
+	plat->clk_ref_rate	= 125000000;
+	plat->core_type		= DWMAC_CORE_GMAC4;
+	plat->suspend		= stmmac_pci_plat_suspend;
+	plat->resume		= motorcomm_resume;
+	plat->flags		= STMMAC_FLAG_TSO_EN |
+				  STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
+
+	return plat;
+}
+
+static void motorcomm_free_irq(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	pci_free_irq_vectors(pdev);
+}
+
+static int motorcomm_setup_irq(struct pci_dev *pdev,
+			       struct stmmac_resources *res,
+			       struct plat_stmmacenet_data *plat)
+{
+	int ret;
+
+	ret = pci_alloc_irq_vectors(pdev, 6, 6, PCI_IRQ_MSIX);
+	if (ret > 0) {
+		res->rx_irq[0]	= pci_irq_vector(pdev, 0);
+		res->tx_irq[0]	= pci_irq_vector(pdev, 4);
+		res->irq	= pci_irq_vector(pdev, 5);
+
+		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	} else {
+		dev_info(&pdev->dev, "failed to allocate MSI-X vector: %d\n",
+			 ret);
+		dev_info(&pdev->dev, "try MSI instead\n");
+
+		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to allocate MSI\n");
+
+		res->irq = pci_irq_vector(pdev, 0);
+	}
+
+	return devm_add_action_or_reset(&pdev->dev, motorcomm_free_irq, pdev);
+}
+
+static int motorcomm_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct plat_stmmacenet_data *plat;
+	struct dwmac_motorcomm_priv *priv;
+	struct stmmac_resources res = {};
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	plat = motorcomm_default_plat_data(pdev);
+	if (!plat)
+		return -ENOMEM;
+
+	plat->bsp_priv = priv;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to enable device\n");
+
+	priv->base = pcim_iomap_region(pdev, 0, DRIVER_NAME);
+	if (IS_ERR(priv->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
+				     "failed to map IO region\n");
+
+	pci_set_master(pdev);
+
+	/*
+	 * Some PCIe addons cards based on YT6801 don't deliver MSI(X) with ASPM
+	 * enabled. Sadly there isn't a reliable way to read out OEM of the
+	 * card, so let's disable L1 state unconditionally for safety.
+	 */
+	ret = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
+	if (ret)
+		dev_warn(&pdev->dev, "failed to disable L1 state: %d\n", ret);
+
+	motorcomm_reset(priv);
+
+	ret = motorcomm_efuse_read_mac(&pdev->dev, priv, res.mac);
+	if (ret == -ENOENT) {
+		dev_warn(&pdev->dev, "eFuse contains no valid MAC address\n");
+		dev_warn(&pdev->dev, "fallback to random MAC address\n");
+
+		eth_random_addr(res.mac);
+	} else if (ret) {
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to read MAC address from eFuse\n");
+	}
+
+	ret = motorcomm_setup_irq(pdev, &res, plat);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to setup IRQ\n");
+
+	motorcomm_init(priv);
+
+	res.addr = priv->base + GMAC_OFFSET;
+
+	return stmmac_dvr_probe(&pdev->dev, plat, &res);
+}
+
+static void motorcomm_remove(struct pci_dev *pdev)
+{
+	stmmac_dvr_remove(&pdev->dev);
+}
+
+static const struct pci_device_id dwmac_motorcomm_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOTORCOMM, 0x6801) },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, dwmac_motorcomm_pci_id_table);
+
+static struct pci_driver dwmac_motorcomm_pci_driver = {
+	.name = DRIVER_NAME,
+	.id_table = dwmac_motorcomm_pci_id_table,
+	.probe = motorcomm_probe,
+	.remove = motorcomm_remove,
+	.driver = {
+		.pm = &stmmac_simple_pm_ops,
+	},
+};
+
+module_pci_driver(dwmac_motorcomm_pci_driver);
+
+MODULE_DESCRIPTION("DWMAC glue driver for Motorcomm PCI Ethernet controllers");
+MODULE_AUTHOR("Yao Zi <me@ziyao.cc>");
+MODULE_LICENSE("GPL");
-- 
2.52.0


