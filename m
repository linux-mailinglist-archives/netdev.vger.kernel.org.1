Return-Path: <netdev+bounces-98979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD098D3476
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B448F1C2417A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6929F17B511;
	Wed, 29 May 2024 10:20:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06AB178CE8
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978048; cv=none; b=uKbNeGRelHQpcWpR84nn5AHc+QFyle19jK3eZ0aUjgwsfakeWaS5qR9Z+Tfd5hswgPA4PY9EXe6R684oaI7TwPITsDFNEgxKQqMFhCrWsO2smDWMUzywbrucMNrkrWYHQAxGKdDjMa+hD+glLTFS4LupU6+BGuB0yVc9sV0BZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978048; c=relaxed/simple;
	bh=wRbtMFoCkCw71MH+yVd4IGioGubeLgFh0kqqxCvYH6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=De56Rdp1cjGdCgH9siO0TiyQWHU8I34ld/EI3SxV5M5EbtczK00v2qgBIgMlQbIkusEt1nIrdEPkxqD6HqczccNggjQ8jd76MFc2btPoPv8TwlQjG0SeUNmLiuwwAPyps5Mn39y8kinFyXzwUqb50prYTFGTA2R9aGeETDtaxck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8Dxi+p7AVdmKBkBAA--.4619S3;
	Wed, 29 May 2024 18:20:43 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqsZ2AVdmwt4MAA--.33803S3;
	Wed, 29 May 2024 18:20:42 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev
Subject: [PATCH net-next v13 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_dt_config
Date: Wed, 29 May 2024 18:20:27 +0800
Message-Id: <b7dbb5c3cc6beef74a5d8df193394a8a8a2b46a1.1716973237.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1716973237.git.siyanteng@loongson.cn>
References: <cover.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxqsZ2AVdmwt4MAA--.33803S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF15Kr45XrWrCFWUurWUJrc_yoWrJF17p3
	yfAa4avr95Gr1xW395XFWUXa4Y9rW2v348Ga12kr1Skay5tr1Yqr13tryjyFyxAFZ5C3ya
	gr1jgFWkuF4Du3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E
	87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU04SoJUUUUU==

While at it move the np initialization procedure into a dedicated
method. It will be useful in one of the subsequent commit adding the
Loongson GNET device support.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 90 ++++++++++---------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 8bcf9d522781..fdd25ff33d02 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -67,16 +67,60 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
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
+		return -ENODEV;
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
+		return -ENODEV;
+	}
+
+	ret = device_get_phy_mode(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "phy_mode not found\n");
+		return -ENODEV;
+	}
+
+	plat->phy_interface = ret;
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
 	int ret, i;
 
-	np = dev_of_node(&pdev->dev);
-
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
 		return -ENOMEM;
@@ -115,44 +159,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	pci_set_master(pdev);
 
-	if (np) {
-		plat->mdio_node = of_get_child_by_name(np, "mdio");
-		if (plat->mdio_node) {
-			dev_info(&pdev->dev, "Found MDIO subnode\n");
-			plat->mdio_bus_data->needs_reset = true;
-		}
-
-		ret = of_alias_get_id(np, "ethernet");
-		if (ret >= 0)
-			plat->bus_id = ret;
-
-		ret = device_get_phy_mode(&pdev->dev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "phy_mode not found\n");
+	if (dev_of_node(&pdev->dev)) {
+		ret = loongson_dwmac_dt_config(pdev, plat, &res);
+		if (ret)
 			goto err_disable_device;
-		}
-
-		plat->phy_interface = ret;
-
-		res.irq = of_irq_get_byname(np, "macirq");
-		if (res.irq < 0) {
-			dev_err(&pdev->dev, "IRQ macirq not found\n");
-			ret = -ENODEV;
-			goto err_disable_msi;
-		}
-
-		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
-		if (res.wol_irq < 0) {
-			dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
-			res.wol_irq = res.irq;
-		}
-
-		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
-		if (res.lpi_irq < 0) {
-			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
-			ret = -ENODEV;
-			goto err_disable_msi;
-		}
 	} else {
 		res.irq = pdev->irq;
 	}
-- 
2.31.4


