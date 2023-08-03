Return-Path: <netdev+bounces-24002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A4476E6EF
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1C928214B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2481A1E539;
	Thu,  3 Aug 2023 11:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CC1ED57
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:30:22 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE95A198A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:30:20 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8AxjuvLj8tkHK0PAA--.34057S3;
	Thu, 03 Aug 2023 19:30:19 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXSPJj8tkgx5HAA--.33765S3;
	Thu, 03 Aug 2023 19:30:18 +0800 (CST)
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
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v3 09/16] net: stmmac: Allow platforms to set irq_flags
Date: Thu,  3 Aug 2023 19:30:03 +0800
Message-Id: <e95caf65942ae71807834a195fc5621b78e4833d.1691047285.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1691047285.git.chenfeiyang@loongson.cn>
References: <cover.1691047285.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXSPJj8tkgx5HAA--.33765S3
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF18Ary3tw1Utr1xZFy8Xrc_yoWrJF17pa
	y7Aas5tFn2qr12gan8AayDZFy5K34xtayfAa4fJw13JFWIyr9avr1rtrySyF1fCrZ5ArWa
	gFWDua18C3WjgrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
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
	cVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0wqXPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some platforms need extra irq flags to request irq multi msi, add
irq_flags variable for them.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 +++++++++-------
 include/linux/stmmac.h                           |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e8619853b6d6..7abe3bb8c626 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3515,7 +3515,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	int_name = priv->int_name_mac;
 	sprintf(int_name, "%s:%s", dev->name, "mac");
 	ret = request_irq(dev->irq, stmmac_mac_interrupt,
-			  0, int_name, dev);
+			  priv->plat->irq_flags, int_name, dev);
 	if (unlikely(ret < 0)) {
 		netdev_err(priv->dev,
 			   "%s: alloc mac MSI %d (error: %d)\n",
@@ -3532,7 +3532,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		sprintf(int_name, "%s:%s", dev->name, "wol");
 		ret = request_irq(priv->wol_irq,
 				  stmmac_mac_interrupt,
-				  0, int_name, dev);
+				  priv->plat->irq_flags, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc wol MSI %d (error: %d)\n",
@@ -3550,7 +3550,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		sprintf(int_name, "%s:%s", dev->name, "lpi");
 		ret = request_irq(priv->lpi_irq,
 				  stmmac_mac_interrupt,
-				  0, int_name, dev);
+				  priv->plat->irq_flags, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc lpi MSI %d (error: %d)\n",
@@ -3568,7 +3568,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		sprintf(int_name, "%s:%s", dev->name, "safety-ce");
 		ret = request_irq(priv->sfty_ce_irq,
 				  stmmac_safety_interrupt,
-				  0, int_name, dev);
+				  priv->plat->irq_flags, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc sfty ce MSI %d (error: %d)\n",
@@ -3586,7 +3586,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		sprintf(int_name, "%s:%s", dev->name, "safety-ue");
 		ret = request_irq(priv->sfty_ue_irq,
 				  stmmac_safety_interrupt,
-				  0, int_name, dev);
+				  priv->plat->irq_flags, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc sfty ue MSI %d (error: %d)\n",
@@ -3607,7 +3607,8 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
 		ret = request_irq(priv->rx_irq[i],
 				  stmmac_msi_intr_rx,
-				  0, int_name, &priv->dma_conf.rx_queue[i]);
+				  priv->plat->irq_flags, int_name,
+				  &priv->dma_conf.rx_queue[i]);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc rx-%d  MSI %d (error: %d)\n",
@@ -3632,7 +3633,8 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
 		ret = request_irq(priv->tx_irq[i],
 				  stmmac_msi_intr_tx,
-				  0, int_name, &priv->dma_conf.tx_queue[i]);
+				  priv->plat->irq_flags, int_name,
+				  &priv->dma_conf.tx_queue[i]);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc tx-%d  MSI %d (error: %d)\n",
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 9f6037b7b5e1..2b59ddbe59ea 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -359,5 +359,6 @@ struct plat_stmmacenet_data {
 	bool fix_channel_num;
 	bool dma_reset_times;
 	u32 control_value;
+	u32 irq_flags;
 };
 #endif
-- 
2.39.3


