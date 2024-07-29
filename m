Return-Path: <netdev+bounces-113625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D693F53D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BE9B2025F
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800E91482F4;
	Mon, 29 Jul 2024 12:24:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652F147C98
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255844; cv=none; b=pXjXjOG0H9ZeN03hB7eBeAzQm85njg8OY/ChpeGC4pg/zuiCd4RvE0FgIVfRBKP8blYK4cz3L1Zew60Ix4NR1jCaY5ei5UgVXyPQIyeOFgCHAhZZc3TsLQxJjBX5HNBnK3+fu0c79WmnFNB8FUjDehMg7ShLzRkGoB1HY5m5ACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255844; c=relaxed/simple;
	bh=vxv57H2+PtQDj7Ebt0IBow56iZURRhNNfsdvmnk03XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAbcXMh49ybhwdzJATgzcE75UuompkMXed2mV+adKxrkzQR5RKScBGP5QIrLGF5NwWdZvJDeqAZsNBXYy52I2sN3SwSc9oQUSZaKUpNYmnU0KXuveYXsD95pmLQT4ixu+r5wmXn0MJuRHwhcG8DEkvjESS+XBXgZxYS24aiJFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.124])
	by gateway (Coremail) with SMTP id _____8AxnOrgiadmK50DAA--.12849S3;
	Mon, 29 Jul 2024 20:24:00 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.124])
	by front1 (Coremail) with SMTP id qMiowMAxysXciadm+7QEAA--.22687S4;
	Mon, 29 Jul 2024 20:23:59 +0800 (CST)
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
Subject: [PATCH net-next v15 11/14] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
Date: Mon, 29 Jul 2024 20:23:55 +0800
Message-Id: <359b2c226e7b18d4af8bb827ca26a2e7869d5f85.1722253726.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1722253726.git.siyanteng@loongson.cn>
References: <cover.1722253726.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxysXciadm+7QEAA--.22687S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFWkZr4UtFW7AF4kXF15Jrc_yoW3Ar1kpr
	WfCasIgrZ3KryIga1kZrWUZF1YkrWjv3yUKF42y3s3Ca90yr1aqF10qFWjyFyfAFZ5Cw13
	Xr4UtF48uF4DGFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxkF7I0En4kS14v26r1q6r43MxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUgc_-DUUUU

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
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 159 +++++++++++-------
 1 file changed, 100 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 10b49bea8e3c..010821fb6474 100644
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
@@ -65,20 +70,83 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
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
@@ -90,17 +158,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
@@ -109,6 +169,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		goto err_put_node;
 	}
 
+	pci_set_master(pdev);
+
 	/* Get the base address of device */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
@@ -119,57 +181,33 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
+	return ret;
 err_put_node:
 	of_node_put(plat->mdio_node);
 	return ret;
@@ -184,6 +222,9 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 	of_node_put(priv->plat->mdio_node);
 	stmmac_dvr_remove(&pdev->dev);
 
+	if (dev_of_node(&pdev->dev))
+		loongson_dwmac_dt_clear(pdev, priv->plat);
+
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
 			continue;
-- 
2.31.4


