Return-Path: <netdev+bounces-56805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A3810E20
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B7F1C20B22
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA7224DB;
	Wed, 13 Dec 2023 10:15:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7211411B
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 02:15:10 -0800 (PST)
Received: from loongson.cn (unknown [112.20.109.254])
	by gateway (Coremail) with SMTP id _____8DxyegrhHllwKEAAA--.3875S3;
	Wed, 13 Dec 2023 18:15:07 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.254])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXeEnhHllQjQCAA--.14860S3;
	Wed, 13 Dec 2023 18:15:04 +0800 (CST)
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
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v6 8/9] net: stmmac: dwmac-loongson: Disable flow control for GMAC
Date: Wed, 13 Dec 2023 18:15:01 +0800
Message-Id: <b286f5f9ced51c72e9e33941a95f2986ca6902a2.1702458672.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1702458672.git.siyanteng@loongson.cn>
References: <cover.1702458672.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxXeEnhHllQjQCAA--.14860S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArWkuF1rXF43JF1ftw4rCrX_yoW8KF1Dpw
	srZa409r9rKF17Jan5Aw4kZFy5Wa47KFW7uayIkwsa9an2k34qqr1YqFWjyF17urWDWFWa
	qr1UCr1UCFnxJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxNeODUUUU

Loongson GMAC does not support Flow Control feature. Set flags to
disable it.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 6 +++---
 include/linux/stmmac.h                               | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 9e4953c7e4e0..77c9bcb66a8e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -160,6 +160,8 @@ static int loongson_gmac_config(struct pci_dev *pdev,
 		break;
 	}
 
+	plat->flags |= FIELD_PREP(STMMAC_FLAG_DISABLE_FLOW_CONTROL, 1);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9764d2ab7e46..d94f61742772 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1236,9 +1236,9 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		xpcs_get_interfaces(priv->hw->xpcs,
 				    priv->phylink_config.supported_interfaces);
 
-	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-						MAC_10FD | MAC_100FD |
-						MAC_1000FD;
+	priv->phylink_config.mac_capabilities = MAC_10FD | MAC_100FD | MAC_1000FD;
+	if (!FIELD_GET(STMMAC_FLAG_DISABLE_FLOW_CONTROL, priv->plat->flags))
+		priv->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
 	stmmac_set_half_duplex(priv);
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 067030cdb60f..5ece92e4d8c3 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -224,6 +224,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_HAS_LGMAC			BIT(13)
 #define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
 #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(15)
+#define STMMAC_FLAG_DISABLE_FLOW_CONTROL	BIT(16)
 
 struct plat_stmmacenet_data {
 	int bus_id;
-- 
2.31.4


