Return-Path: <netdev+bounces-24007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D00C76E6F9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6D31C2152F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC811F92A;
	Thu,  3 Aug 2023 11:30:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD31E501
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:30:53 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE3401982
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:30:51 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8Cx7+vqj8tkaa0PAA--.35388S3;
	Thu, 03 Aug 2023 19:30:50 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTSPoj8tkyR5HAA--.34056S3;
	Thu, 03 Aug 2023 19:30:50 +0800 (CST)
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
Subject: [PATCH v3 14/16] net: stmmac: dwmac-loongson: Disable flow control for GMAC
Date: Thu,  3 Aug 2023 19:30:35 +0800
Message-Id: <021e4047c3b0f2c462e1aa891e25ae710705ed29.1691047285.git.chenfeiyang@loongson.cn>
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
X-CM-TRANSID:AQAAf8AxTSPoj8tkyR5HAA--.34056S3
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyrWrWDCFy3Ww13WrWxuFX_yoW8Aw4Up3
	9rAa429rykXF47Jan8Aw4DZFy5Xay7trZrWayIkw4fWa97Kr9aqryYqayYvFy7ArZ8XFya
	qr4Uur4UCF1DJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Gryq6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07b3iihUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Loongson GMAC does not support Flow Control feature. Use
disable_flow_control flag to disable it.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 5 +++++
 include/linux/stmmac.h                               | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 18bca996e1cb..40eddadd0bd2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -95,6 +95,7 @@ static int loongson_gmac_config(struct pci_dev *pdev,
 	}
 
 	plat->dma_reset_times = 5;
+	plat->disable_flow_control = true;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5eafb08e2332..65ee5a681dcf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3827,6 +3827,11 @@ static int __stmmac_open(struct net_device *dev,
 				   __func__, ret);
 			goto init_phy_error;
 		}
+
+		if (priv->plat->disable_flow_control) {
+			phy_support_sym_pause(dev->phydev);
+			phy_set_sym_pause(dev->phydev, false, false, true);
+		}
 	}
 
 	/* Extra statistics */
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 2b59ddbe59ea..07570d808edb 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -360,5 +360,6 @@ struct plat_stmmacenet_data {
 	bool dma_reset_times;
 	u32 control_value;
 	u32 irq_flags;
+	bool disable_flow_control;
 };
 #endif
-- 
2.39.3


