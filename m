Return-Path: <netdev+bounces-29567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97468783D2F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB8B280FF4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2101ADCE;
	Tue, 22 Aug 2023 09:41:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB54946D
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:41:05 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3EE31A5
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:41:03 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
	by gateway (Coremail) with SMTP id _____8AxZ+isguRkCeAaAA--.18985S3;
	Tue, 22 Aug 2023 17:41:00 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrM6pguRkkDVgAA--.38101S4;
	Tue, 22 Aug 2023 17:40:59 +0800 (CST)
From: Feiyang Chen <chenfeiyang@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	chenhuacai@loongson.cn
Cc: Feiyang Chen <chenfeiyang@loongson.cn>,
	linux@armlinux.org.uk,
	dongbiao@loongson.cn,
	guyinggang@loongson.cn,
	siyanteng@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v4 06/11] net: stmmac: dwmac-loongson: Add LS7A support
Date: Tue, 22 Aug 2023 17:40:55 +0800
Message-Id: <d528fade56b507e4729895afb6d7655695a1c7dd.1692696115.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1692696115.git.chenfeiyang@loongson.cn>
References: <cover.1692696115.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxrM6pguRkkDVgAA--.38101S4
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFy5Kr1kWFWrJw13tF4kXwc_yoWrWFWfpa
	yfAFyaqr95Wry2gan5ZFWUX3WY9rW29348G3y2k34fuFWYvr4Yqr15tryjvFyxAFZ5C3ya
	gryjgFWvgF4Du3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0wqXPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Current dwmac-loongson only support LS2K in the "probed with PCI
and configured with DT" manner. Add LS7A support on which the
devices are fully PCI (non-DT).

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 81 ++++++++++---------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index ff4fa74d2a11..dd7e9f262ca6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -16,8 +16,12 @@ struct stmmac_pci_info {
 static void loongson_default_data(struct pci_dev *pdev,
 				  struct plat_stmmacenet_data *plat)
 {
+	/* Get bus_id, this can be overloaded later */
+	plat->bus_id = (pci_domain_nr(pdev->bus) << 16) |
+		       PCI_DEVID(pdev->bus->number, pdev->devfn);
+
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
-	plat->has_gmac = 1;
+	plat->has_egmac = 1;
 	plat->force_sf_dma_mode = 1;
 
 	/* Set default value for multicast hash bins */
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
 
 	pci_enable_msi(pdev);
 
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
-
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
2.39.3


