Return-Path: <netdev+bounces-58907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA40818997
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB59C28928D
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDAE1BDDE;
	Tue, 19 Dec 2023 14:17:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8021BDC0
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8BxK+n9pYFlxqICAA--.13405S3;
	Tue, 19 Dec 2023 22:17:33 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzuTypYFlAnIAAA--.3411S5;
	Tue, 19 Dec 2023 22:17:29 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	fancer.lancer@gmail.com,
	Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: [PATCH net-next v7 3/9] net: stmmac: dwmac-loongson: Add full PCI support
Date: Tue, 19 Dec 2023 22:17:06 +0800
Message-Id: <b43293919f4ddb869a795e41266f7c3107f79faf.1702990507.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1702990507.git.siyanteng@loongson.cn>
References: <cover.1702990507.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxzuTypYFlAnIAAA--.3411S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFyruw4rur1fGryUuFyrKrX_yoWrWFy7pa
	yfAFyaqr95Wry2gan5XFWUX3WY9rW2v348G3y2k34fuFWYvr4Yqr15tryjvFyxAFZ5u3ya
	gryjgFWvgF4DuFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU

Current dwmac-loongson only support LS2K in the "probed with PCI and
configured with DT" manner. Add LS7A support on which the devices are
fully PCI (non-DT).

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79 ++++++++++---------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 56d1fd8c61e1..0d79104d7fd3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -16,6 +16,10 @@ struct stmmac_pci_info {
 static void loongson_default_data(struct pci_dev *pdev,
 				  struct plat_stmmacenet_data *plat)
 {
+	/* Get bus_id, this can be overloaded later */
+	plat->bus_id = (pci_domain_nr(pdev->bus) << 16) |
+		       PCI_DEVID(pdev->bus->number, pdev->devfn);
+
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->has_gmac = 1;
 	plat->force_sf_dma_mode = 1;
@@ -56,6 +60,9 @@ static int loongson_gmac_data(struct pci_dev *pdev,
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
 
+	plat->clk_ref_rate = 125000000;
+	plat->clk_ptp_rate = 125000000;
+
 	return 0;
 }
 
@@ -72,13 +79,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
 	struct stmmac_resources res;
 	struct device_node *np;
 
-	np = dev_of_node(&pdev->dev);
-
-	if (!np) {
-		pr_info("dwmac_loongson_pci: No OF node\n");
-		return -ENODEV;
-	}
-
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
 		return -ENOMEM;
@@ -94,6 +94,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
 	if (!plat->dma_cfg)
 		return -ENOMEM;
 
+	np = dev_of_node(&pdev->dev);
 	plat->mdio_node = of_get_child_by_name(np, "mdio");
 	if (plat->mdio_node) {
 		dev_info(&pdev->dev, "Found MDIO subnode\n");
@@ -125,42 +126,48 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_disable_device;
 
-	bus_id = of_alias_get_id(np, "ethernet");
-	if (bus_id >= 0)
-		plat->bus_id = bus_id;
+	if (np) {
+		bus_id = of_alias_get_id(np, "ethernet");
+		if (bus_id >= 0)
+			plat->bus_id = bus_id;
 
-	phy_mode = device_get_phy_mode(&pdev->dev);
-	if (phy_mode < 0) {
-		dev_err(&pdev->dev, "phy_mode not found\n");
-		ret = phy_mode;
-		goto err_disable_device;
+		phy_mode = device_get_phy_mode(&pdev->dev);
+		if (phy_mode < 0) {
+			dev_err(&pdev->dev, "phy_mode not found\n");
+			ret = phy_mode;
+			goto err_disable_device;
+		}
+		plat->phy_interface = phy_mode;
 	}
 
-	plat->phy_interface = phy_mode;
-
 	pci_enable_msi(pdev);
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
 
-	res.irq = of_irq_get_byname(np, "macirq");
-	if (res.irq < 0) {
-		dev_err(&pdev->dev, "IRQ macirq not found\n");
-		ret = -ENODEV;
-		goto err_disable_msi;
-	}
-
-	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
-	if (res.wol_irq < 0) {
-		dev_info(&pdev->dev,
-			 "IRQ eth_wake_irq not found, using macirq\n");
-		res.wol_irq = res.irq;
-	}
-
-	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
-	if (res.lpi_irq < 0) {
-		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
-		ret = -ENODEV;
-		goto err_disable_msi;
+	if (np) {
+		res.irq = of_irq_get_byname(np, "macirq");
+		if (res.irq < 0) {
+			dev_err(&pdev->dev, "IRQ macirq not found\n");
+			ret = -ENODEV;
+			goto err_disable_msi;
+		}
+
+		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
+		if (res.wol_irq < 0) {
+			dev_info(&pdev->dev,
+				 "IRQ eth_wake_irq not found, using macirq\n");
+			res.wol_irq = res.irq;
+		}
+
+		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
+		if (res.lpi_irq < 0) {
+			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
+			ret = -ENODEV;
+			goto err_disable_msi;
+		}
+	} else {
+		res.irq = pdev->irq;
+		res.wol_irq = pdev->irq;
 	}
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
-- 
2.31.4


