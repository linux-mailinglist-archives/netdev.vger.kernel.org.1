Return-Path: <netdev+bounces-116486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD58294A8F6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844D3288749
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D3205E01;
	Wed,  7 Aug 2024 13:48:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5792201246
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038506; cv=none; b=kugwXjZqaYY3Pfa+cNsk29htz1ZX9Jg/GhTkEsNmd6ECY3EmGAbIQumi1fOOQsAUyS7Tun1avatJmM3VNtGZeCKk2IL8p9yWsX1JmqwViF75I1FqivQC+JBVQ0qNOExGtBLtnuDV4i5aDzsT57+ZIJdFyhBwCNyZj+zvSqIwM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038506; c=relaxed/simple;
	bh=CvE0nkxVilyUv42eEuEC/Negykm1WNHpBJtWkQgNsgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myQlNyCL2rkQXswP8lbg7dXlPJGbH+O1YoSVdM70qVyrag8kSwVkm05fLfOdMCnT40hBB2XSOUtei7L+SGdbm3panZJjZtfrbK1dd/CJNvNHJaaUzyCyD1D4r6XJWnw+HOhJBjEUbxY9F8AXv1+P4VVVNymu5p2nbptPh+4q+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.71])
	by gateway (Coremail) with SMTP id _____8DxyOkme7NmDXcKAA--.32332S3;
	Wed, 07 Aug 2024 21:48:22 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.71])
	by front1 (Coremail) with SMTP id qMiowMCxwuEfe7NmXx4IAA--.41332S5;
	Wed, 07 Aug 2024 21:48:20 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com,
	diasyzhang@tencent.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH net-next v17 11/14] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
Date: Wed,  7 Aug 2024 21:48:05 +0800
Message-Id: <b13292f1bb64e335663d5929c81369da88fa2c13.1723014611.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1723014611.git.siyanteng@loongson.cn>
References: <cover.1723014611.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxwuEfe7NmXx4IAA--.41332S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFWkZr4UtFW7CF45uw13KFX_yoW3AF47p3
	yfCasIgrZ3KryIgan5ZrWUZF1YkrWjvay8KF42k3s3Ca90yr1aqF10qFWjyFWfAFZ5Cw13
	Xr4UtF48uF4DGFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07bYoGQUUUUU=

The Loongson GMAC driver currently supports the network controllers
installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
devices are required to be defined in the platform device tree source.
But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
(implies FDT) as the system bootloaders. In order to have both system
configurations support let's extend the driver functionality with the
case of having the Loongson GMAC probed on the PCI bus with no device
tree node defined for it. That requires to make the device DT-node
optional, to rely on the IRQ line detected by the PCI core and to
have the MDIO bus ID calculated using the PCIe Domain+BDF numbers.

In order to have the device probe() and remove() methods less
complicated let's move the DT- and ACPI-specific code to the
respective sub-functions.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 165 +++++++++++-------
 1 file changed, 102 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 10b49bea8e3c..c0740a41025b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -12,11 +12,15 @@
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
 
 struct stmmac_pci_info {
-	int (*setup)(struct plat_stmmacenet_data *plat);
+	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
 };
 
-static void loongson_default_data(struct plat_stmmacenet_data *plat)
+static void loongson_default_data(struct pci_dev *pdev,
+				  struct plat_stmmacenet_data *plat)
 {
+	/* Get bus_id, this can be overwritten later */
+	plat->bus_id = pci_dev_id(pdev);
+
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->has_gmac = 1;
 	plat->force_sf_dma_mode = 1;
@@ -49,9 +53,10 @@ static void loongson_default_data(struct plat_stmmacenet_data *plat)
 	plat->dma_cfg->pblx8 = true;
 }
 
-static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
+static int loongson_gmac_data(struct pci_dev *pdev,
+			      struct plat_stmmacenet_data *plat)
 {
-	loongson_default_data(plat);
+	loongson_default_data(pdev, plat);
 
 	plat->tx_queues_to_use = 1;
 	plat->rx_queues_to_use = 1;
@@ -65,20 +70,85 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.setup = loongson_gmac_data,
 };
 
+static int loongson_dwmac_dt_config(struct pci_dev *pdev,
+				    struct plat_stmmacenet_data *plat,
+				    struct stmmac_resources *res)
+{
+	struct device_node *np = dev_of_node(&pdev->dev);
+	int ret;
+
+	plat->mdio_node = of_get_child_by_name(np, "mdio");
+	if (plat->mdio_node) {
+		dev_info(&pdev->dev, "Found MDIO subnode\n");
+		plat->mdio_bus_data->needs_reset = true;
+	}
+
+	ret = of_alias_get_id(np, "ethernet");
+	if (ret >= 0)
+		plat->bus_id = ret;
+
+	res->irq = of_irq_get_byname(np, "macirq");
+	if (res->irq < 0) {
+		dev_err(&pdev->dev, "IRQ macirq not found\n");
+		ret = -ENODEV;
+		goto err_put_node;
+	}
+
+	res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
+	if (res->wol_irq < 0) {
+		dev_info(&pdev->dev,
+			 "IRQ eth_wake_irq not found, using macirq\n");
+		res->wol_irq = res->irq;
+	}
+
+	res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
+	if (res->lpi_irq < 0) {
+		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
+		ret = -ENODEV;
+		goto err_put_node;
+	}
+
+	ret = device_get_phy_mode(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "phy_mode not found\n");
+		ret = -ENODEV;
+		goto err_put_node;
+	}
+
+	plat->phy_interface = ret;
+
+	return 0;
+
+err_put_node:
+	of_node_put(plat->mdio_node);
+
+	return ret;
+}
+
+static void loongson_dwmac_dt_clear(struct pci_dev *pdev,
+				    struct plat_stmmacenet_data *plat)
+{
+	of_node_put(plat->mdio_node);
+}
+
+static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
+				      struct plat_stmmacenet_data *plat,
+				      struct stmmac_resources *res)
+{
+	if (!pdev->irq)
+		return -EINVAL;
+
+	res->irq = pdev->irq;
+
+	return 0;
+}
+
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
-	struct device_node *np;
-	int ret, i, phy_mode;
-
-	np = dev_of_node(&pdev->dev);
-
-	if (!np) {
-		pr_info("dwmac_loongson_pci: No OF node\n");
-		return -ENODEV;
-	}
+	int ret, i;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
@@ -90,25 +160,19 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (!plat->mdio_bus_data)
 		return -ENOMEM;
 
-	plat->mdio_node = of_get_child_by_name(np, "mdio");
-	if (plat->mdio_node) {
-		dev_info(&pdev->dev, "Found MDIO subnode\n");
-		plat->mdio_bus_data->needs_reset = true;
-	}
-
 	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
-	if (!plat->dma_cfg) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
+	if (!plat->dma_cfg)
+		return -ENOMEM;
 
 	/* Enable pci device */
 	ret = pci_enable_device(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n", __func__);
-		goto err_put_node;
+		return ret;
 	}
 
+	pci_set_master(pdev);
+
 	/* Get the base address of device */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
@@ -119,59 +183,32 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		break;
 	}
 
-	plat->bus_id = of_alias_get_id(np, "ethernet");
-	if (plat->bus_id < 0)
-		plat->bus_id = pci_dev_id(pdev);
-
-	phy_mode = device_get_phy_mode(&pdev->dev);
-	if (phy_mode < 0) {
-		dev_err(&pdev->dev, "phy_mode not found\n");
-		ret = phy_mode;
-		goto err_disable_device;
-	}
-
-	plat->phy_interface = phy_mode;
-
-	pci_set_master(pdev);
-
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
 
 	info = (struct stmmac_pci_info *)id->driver_data;
-	ret = info->setup(plat);
+	ret = info->setup(pdev, plat);
 	if (ret)
 		goto err_disable_device;
 
-	res.irq = of_irq_get_byname(np, "macirq");
-	if (res.irq < 0) {
-		dev_err(&pdev->dev, "IRQ macirq not found\n");
-		ret = -ENODEV;
-		goto err_disable_device;
-	}
-
-	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
-	if (res.wol_irq < 0) {
-		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
-		res.wol_irq = res.irq;
-	}
-
-	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
-	if (res.lpi_irq < 0) {
-		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
-		ret = -ENODEV;
+	if (dev_of_node(&pdev->dev))
+		ret = loongson_dwmac_dt_config(pdev, plat, &res);
+	else
+		ret = loongson_dwmac_acpi_config(pdev, plat, &res);
+	if (ret)
 		goto err_disable_device;
-	}
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
-		goto err_disable_device;
+		goto err_plat_clear;
 
-	return ret;
+	return 0;
 
+err_plat_clear:
+	if (dev_of_node(&pdev->dev))
+		loongson_dwmac_dt_clear(pdev, plat);
 err_disable_device:
 	pci_disable_device(pdev);
-err_put_node:
-	of_node_put(plat->mdio_node);
 	return ret;
 }
 
@@ -181,9 +218,11 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	int i;
 
-	of_node_put(priv->plat->mdio_node);
 	stmmac_dvr_remove(&pdev->dev);
 
+	if (dev_of_node(&pdev->dev))
+		loongson_dwmac_dt_clear(pdev, priv->plat);
+
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
 			continue;
-- 
2.31.4


