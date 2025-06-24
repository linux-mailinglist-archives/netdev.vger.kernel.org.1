Return-Path: <netdev+bounces-200721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8477AE6979
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478B13B9949
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38232EE60D;
	Tue, 24 Jun 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GYKYuzqp"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153D2ECD29;
	Tue, 24 Jun 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775644; cv=none; b=skrG0aST6tulPNTwI6cBBJqXVx10YEjTdWjFFEHGj6JTVuWaW5xOmoOdbo/vxyg7Uzl7dq36+Ve2sjOQghiT31SV65Q9Gz17HmnNhkboGjpq3o03nV4VZOvw98zrJROnOLtT2lyujpzBTI2KUOuznfrqr5a94Lv2MW7AtOrpxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775644; c=relaxed/simple;
	bh=BD8vaYX+YaB7vDlV1Vs/z5OUWTtjOO6ZQwZ57ymSD6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ktgnjuWQ94g2nVXvbLtrLOsgYrF1ooLLcMPZKQP1lh/JwhORzJToOcaHiJ6y3VsLXSvwyY3DotsIPgjiFKCkr7AaH7vIA7jo1U8qSHu2l+Wcz7ShR9JySTiUGII6X+B8yWoXSimdjTF5CjcV7RaRisUt39WSYzovKPsEc0U/FmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GYKYuzqp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750775640;
	bh=BD8vaYX+YaB7vDlV1Vs/z5OUWTtjOO6ZQwZ57ymSD6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYKYuzqpg+oTxqOtTt2wiK//YdpmrussF5pu5Tt3PU4QPOCFSPrlnJJ6XaJ5Wn4cb
	 PLC2aS8Z3/03uXADsRm4vi26EG3/Y4y+GMJzEJFhj2b8WJZImxiBRkoyFlBS6a2jf9
	 4tJcW8a3WWuIVnF3dNhbWOLigLVICszfy+NKQjhLhpcL1QBOxZbwjJoP2v9a5c6fPl
	 ShoDUYINv4nL3G+O02WsArkyLMCsQCSps1JC7VIDcdK1tEtP9uEyHAjRRZUqTkIS4F
	 CZ5C7Wq3xdgKh5dCMFL0nxYTQE56gjOX/9d4gWEjSiASzPh8D6TEb/RudKKgH/njVv
	 zIxWXu4uNu6Gg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d2c7:2075:2c3c:38e5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4E5B317E1067;
	Tue, 24 Jun 2025 16:33:59 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com
Cc: guangjie.song@mediatek.com,
	wenst@chromium.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v2 22/29] clk: mediatek: Add MT8196 mfg clock support
Date: Tue, 24 Jun 2025 16:32:13 +0200
Message-Id: <20250624143220.244549-23-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624143220.244549-1-laura.nao@collabora.com>
References: <20250624143220.244549-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MT8196 mfg clock controller, which provides PLL
control for the GPU.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig          |   7 ++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8196-mfg.c | 150 ++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mfg.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index c193295d4136..9735f37f1e09 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1096,6 +1096,13 @@ config COMMON_CLK_MT8196_MDPSYS
 	help
 	  This driver supports MediaTek MT8196 mdpsys clocks.
 
+config COMMON_CLK_MT8196_MFGCFG
+	tristate "Clock driver for MediaTek MT8196 mfgcfg"
+	depends on COMMON_CLK_MT8196
+	default m
+	help
+	  This driver supports MediaTek MT8196 mfgcfg clocks.
+
 config COMMON_CLK_MT8196_PEXTPSYS
 	tristate "Clock driver for MediaTek MT8196 pextpsys"
 	depends on COMMON_CLK_MT8196
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index b9a54d65e27c..31436c8e2a80 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -167,6 +167,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_ADSP) += clk-mt8196-adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-mfg.c b/drivers/clk/mediatek/clk-mt8196-mfg.c
new file mode 100644
index 000000000000..77e5d76f5d90
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-mfg.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Guangjie Song <guangjie.song@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    Laura Nao <laura.nao@collabora.com>
+ */
+#include <dt-bindings/clock/mediatek,mt8196-clock.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#define MFGPLL_CON0	0x008
+#define MFGPLL_CON1	0x00c
+#define MFGPLL_CON2	0x010
+#define MFGPLL_CON3	0x014
+#define MFGPLL_SC0_CON0	0x008
+#define MFGPLL_SC0_CON1	0x00c
+#define MFGPLL_SC0_CON2	0x010
+#define MFGPLL_SC0_CON3	0x014
+#define MFGPLL_SC1_CON0	0x008
+#define MFGPLL_SC1_CON1	0x00c
+#define MFGPLL_SC1_CON2	0x010
+#define MFGPLL_SC1_CON3	0x014
+
+#define MT8196_PLL_FMAX		(3800UL * MHZ)
+#define MT8196_PLL_FMIN		(1500UL * MHZ)
+#define MT8196_INTEGER_BITS	8
+
+#define PLL(_id, _name, _reg, _en_reg, _en_mask, _pll_en_bit,	\
+	    _flags, _rst_bar_mask,				\
+	    _pd_reg, _pd_shift, _tuner_reg,			\
+	    _tuner_en_reg, _tuner_en_bit,			\
+	    _pcw_reg, _pcw_shift, _pcwbits) {			\
+		.id = _id,					\
+		.name = _name,					\
+		.reg = _reg,					\
+		.en_reg = _en_reg,				\
+		.en_mask = _en_mask,				\
+		.pll_en_bit = _pll_en_bit,			\
+		.flags = _flags,				\
+		.rst_bar_mask = _rst_bar_mask,			\
+		.fmax = MT8196_PLL_FMAX,			\
+		.fmin = MT8196_PLL_FMIN,			\
+		.pd_reg = _pd_reg,				\
+		.pd_shift = _pd_shift,				\
+		.tuner_reg = _tuner_reg,			\
+		.tuner_en_reg = _tuner_en_reg,			\
+		.tuner_en_bit = _tuner_en_bit,			\
+		.pcw_reg = _pcw_reg,				\
+		.pcw_shift = _pcw_shift,			\
+		.pcwbits = _pcwbits,				\
+		.pcwibits = MT8196_INTEGER_BITS,		\
+	}
+
+static const struct mtk_pll_data mfg_ao_plls[] = {
+	PLL(CLK_MFG_AO_MFGPLL, "mfgpll", MFGPLL_CON0, MFGPLL_CON0, 0, 0, 0,
+	    BIT(0), MFGPLL_CON1, 24, 0, 0, 0,
+	    MFGPLL_CON1, 0, 22),
+};
+
+static const struct mtk_pll_data mfgsc0_ao_plls[] = {
+	PLL(CLK_MFGSC0_AO_MFGPLL_SC0, "mfgpll-sc0", MFGPLL_SC0_CON0,
+	    MFGPLL_SC0_CON0, 0, 0, 0, BIT(0), MFGPLL_SC0_CON1, 24, 0, 0, 0,
+	    MFGPLL_SC0_CON1, 0, 22),
+};
+
+static const struct mtk_pll_data mfgsc1_ao_plls[] = {
+	PLL(CLK_MFGSC1_AO_MFGPLL_SC1, "mfgpll-sc1", MFGPLL_SC1_CON0,
+	    MFGPLL_SC1_CON0, 0, 0, 0, BIT(0), MFGPLL_SC1_CON1, 24, 0, 0, 0,
+	    MFGPLL_SC1_CON1, 0, 22),
+};
+
+static const struct of_device_id of_match_clk_mt8196_mfg[] = {
+	{ .compatible = "mediatek,mt8196-mfgpll-pll-ctrl",
+	  .data = &mfg_ao_plls },
+	{ .compatible = "mediatek,mt8196-mfgpll-sc0-pll-ctrl",
+	  .data = &mfgsc0_ao_plls },
+	{ .compatible = "mediatek,mt8196-mfgpll-sc1-pll-ctrl",
+	  .data = &mfgsc1_ao_plls },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_mfg);
+
+static int clk_mt8196_mfg_probe(struct platform_device *pdev)
+{
+	const struct mtk_pll_data *plls;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	const int num_plls = 1;
+	int r;
+
+	plls = of_device_get_match_data(&pdev->dev);
+	if (!plls)
+		return -EINVAL;
+
+	clk_data = mtk_alloc_clk_data(num_plls);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_plls(node, plls, num_plls, clk_data);
+	if (r)
+		goto free_clk_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_plls;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return r;
+
+unregister_plls:
+	mtk_clk_unregister_plls(plls, num_plls, clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+
+	return r;
+}
+
+static void clk_mt8196_mfg_remove(struct platform_device *pdev)
+{
+	const struct mtk_pll_data *plls = of_device_get_match_data(&pdev->dev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_plls(plls, 1, clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static struct platform_driver clk_mt8196_mfg_drv = {
+	.probe = clk_mt8196_mfg_probe,
+	.remove = clk_mt8196_mfg_remove,
+	.driver = {
+		.name = "clk-mt8196-mfg",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_clk_mt8196_mfg,
+	},
+};
+module_platform_driver(clk_mt8196_mfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 GPU mfg clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


