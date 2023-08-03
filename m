Return-Path: <netdev+bounces-23998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4388576E6E2
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07077282108
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A81ED3B;
	Thu,  3 Aug 2023 11:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1677C8C0F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:29:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1E1F19A0
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:29:37 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8Cxh+igj8tk+qwPAA--.452S3;
	Thu, 03 Aug 2023 19:29:36 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxzM6dj8tkKx5HAA--.52441S4;
	Thu, 03 Aug 2023 19:29:35 +0800 (CST)
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
Subject: [PATCH v3 06/16] net: stmmac: dwmac1000: Fix channel numbers for Loongson
Date: Thu,  3 Aug 2023 19:29:26 +0800
Message-Id: <35c5c4f3f0c7036470922a4c875253db2568959e.1691047285.git.chenfeiyang@loongson.cn>
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
X-CM-TRANSID:AQAAf8DxzM6dj8tkKx5HAA--.52441S4
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF13AFWfWFWDWr48JFW7WrX_yoW8Zr4kpF
	ZrJa45CFy0kF4fA3WkJw4kXr98Ga4FkrW7ZF40k3yfAanrtFyYqrn0y3yjkFy5Xan7XF12
	yF1Uur15uF98X3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6rWY6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUI0eHUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some Loongson platforms cannot obtain the TX and RX number of channels.
Add the fix_channel_num flag for them and specify that the number of
channels is 8.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 10 ++++++++--
 include/linux/stmmac.h                              |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 4773779b7be5..f7a9559817a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -344,8 +344,14 @@ static int dwmac1000_get_hw_feature(struct stmmac_priv *priv,
 	dma_cap->rx_coe_type2 = (hw_cap & DMA_HW_FEAT_RXTYP2COE) >> 18;
 	dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;
 	/* TX and RX number of channels */
-	dma_cap->number_rx_channel = (hw_cap & DMA_HW_FEAT_RXCHCNT) >> 20;
-	dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
+	if (priv->plat->fix_channel_num &&
+	    ((hw_cap & (DMA_HW_FEAT_RXCHCNT | DMA_HW_FEAT_TXCHCNT)) >> 20) == 0) {
+		dma_cap->number_rx_channel = 8;
+		dma_cap->number_tx_channel = 8;
+	} else {
+		dma_cap->number_rx_channel = (hw_cap & DMA_HW_FEAT_RXCHCNT) >> 20;
+		dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
+	}
 	/* Alternate (enhanced) DESC mode */
 	dma_cap->enh_desc = (hw_cap & DMA_HW_FEAT_ENHDESSEL) >> 24;
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 7aca9171b3a8..e1b9ddf83fe5 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -356,5 +356,6 @@ struct plat_stmmacenet_data {
 	const struct dwmac4_addrs *dwmac4_addrs;
 	bool has_integrated_pcs;
 	const struct dwmac_regs *dwmac_regs;
+	bool fix_channel_num;
 };
 #endif
-- 
2.39.3


