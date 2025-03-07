Return-Path: <netdev+bounces-172753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01001A55E52
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C333B7A9DD4
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2574156678;
	Fri,  7 Mar 2025 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pWfwwFg/"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9825DDC5;
	Fri,  7 Mar 2025 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318364; cv=none; b=PWo/ZaxhBsPZH/dLygNssFRYtF6ArQVYWJUkTltujv0elpOYN6aIPfrDQsAHzlGzh7cq5e7Ty4KPLMMYt1484qtVAwR01VFHsOKPDVSuVgUcuYvp16wfr1NYkdx+DMz1P8fb7FgfDCcDQsG1U7hshirfF3y74pS/+ClI3DOdOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318364; c=relaxed/simple;
	bh=/RJtb/VzbTlQOvtbvIrscXix/q5r+40SX6GaaJe2prk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ya05gU34rHf8shEYePPtlkfsqcRth9nfoWnQ3qtbUDcbWGIeaRu8vXqT+/JbHRNW+3QKN/je0SVaDJsIuS4Hmx9Q3v6AIcxOcm1/C4oYQz996ch2iB2mlRyh4oxMUvI5fj4W/+71ssldEDxyK1PvBNP5u0omE8UgJFbRhlnF66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pWfwwFg/; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d07ec5fefb0411efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tk0turHFIeC13cgasmUCQzEa1bXnerEPc4/fIrq5wQ0=;
	b=pWfwwFg/VknxF5bQcSD6bArZQDCx/0g5UvXyFwsJkdLOpY8Q8JVl1wQ1K84YVDv06enN7Glsma5/8U8FvmyK8e/L0AXqJ7U+VWgrrquHm5dJ5AJScZptbCmV6DaALcSjP5Lf1ncwkIw8x5eRl51xOh37ubzFS7fhvEXeXUB/8Ww=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:21241436-137d-492f-ac46-f8b41a0e2585,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:81e207c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d07ec5fefb0411efaae1fd9735fae912-20250307
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2072946514; Fri, 07 Mar 2025 11:32:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:35 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:34 +0800
From: Guangjie Song <guangjie.song@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>, Guangjie Song
	<guangjie.song@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 02/26] clk: mediatek: Support voting for pll
Date: Fri, 7 Mar 2025 11:26:58 +0800
Message-ID: <20250307032942.10447-3-guangjie.song@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250307032942.10447-1-guangjie.song@mediatek.com>
References: <20250307032942.10447-1-guangjie.song@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add data fields and ops to support voting for pll.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/clk-pll.c | 51 +++++++++++++++++++++++++++++++++-
 drivers/clk/mediatek/clk-pll.h |  5 ++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index ce453e1718e5..fdaa4ee74608 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -13,6 +13,7 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 
+#include "clk-mtk.h"
 #include "clk-pll.h"
 
 #define MHZ			(1000 * 1000)
@@ -37,6 +38,13 @@ int mtk_pll_is_prepared(struct clk_hw *hw)
 	return (readl(pll->en_addr) & BIT(pll->data->pll_en_bit)) != 0;
 }
 
+static int mtk_pll_fenc_is_prepared(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	return  (((readl(pll->fenc_addr) & pll->fenc_mask) != 0) || (pll->onoff_cnt != 0));
+}
+
 static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
 		u32 pcw, int postdiv)
 {
@@ -274,6 +282,30 @@ void mtk_pll_unprepare(struct clk_hw *hw)
 	writel(r, pll->pwr_addr);
 }
 
+static int mtk_pll_fenc_prepare(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	if (pll->onoff_cnt == 1) {
+		pr_err("%s: %s is already prepared\n", __func__, clk_hw_get_name(hw));
+		return -EPERM;
+	}
+
+	pll->onoff_cnt = 1;
+
+	return 0;
+}
+
+static void mtk_pll_fenc_unprepare(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	if (pll->onoff_cnt == 0)
+		pr_err("%s: %s is not prepared\n", __func__, clk_hw_get_name(hw));
+	else
+		pll->onoff_cnt = 0;
+}
+
 const struct clk_ops mtk_pll_ops = {
 	.is_prepared	= mtk_pll_is_prepared,
 	.prepare	= mtk_pll_prepare,
@@ -283,6 +315,15 @@ const struct clk_ops mtk_pll_ops = {
 	.set_rate	= mtk_pll_set_rate,
 };
 
+static const struct clk_ops mtk_pll_fenc_ops = {
+	.is_prepared	= mtk_pll_fenc_is_prepared,
+	.prepare	= mtk_pll_fenc_prepare,
+	.unprepare	= mtk_pll_fenc_unprepare,
+	.recalc_rate	= mtk_pll_recalc_rate,
+	.round_rate	= mtk_pll_round_rate,
+	.set_rate	= mtk_pll_set_rate,
+};
+
 struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 					const struct mtk_pll_data *data,
 					void __iomem *base,
@@ -313,6 +354,11 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 
 	init.name = data->name;
 	init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
+	if (data->flags & CLK_FENC_ENABLE) {
+		pll->fenc_addr = base + data->fenc_sta_ofs;
+		pll->fenc_mask = BIT(data->fenc_sta_bit);
+	}
+
 	init.ops = pll_ops;
 	if (data->parent_name)
 		init.parent_names = &data->parent_name;
@@ -338,7 +384,10 @@ struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
-	hw = mtk_clk_register_pll_ops(pll, data, base, &mtk_pll_ops);
+	if (data->flags & CLK_FENC_ENABLE)
+		hw = mtk_clk_register_pll_ops(pll, data, base, &mtk_pll_fenc_ops);
+	else
+		hw = mtk_clk_register_pll_ops(pll, data, base, &mtk_pll_ops);
 	if (IS_ERR(hw))
 		kfree(pll);
 
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index 285c8db958b3..3a1e48006e34 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -29,6 +29,7 @@ struct mtk_pll_data {
 	u32 reg;
 	u32 pwr_reg;
 	u32 en_mask;
+	u32 fenc_sta_ofs;
 	u32 pd_reg;
 	u32 tuner_reg;
 	u32 tuner_en_reg;
@@ -49,6 +50,7 @@ struct mtk_pll_data {
 	u32 en_reg;
 	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
 	u8 pcw_chg_bit;
+	u8 fenc_sta_bit;
 };
 
 /*
@@ -69,6 +71,9 @@ struct mtk_clk_pll {
 	void __iomem	*pcw_chg_addr;
 	void __iomem	*en_addr;
 	const struct mtk_pll_data *data;
+	void __iomem	*fenc_addr;
+	u32		fenc_mask;
+	u32		onoff_cnt;
 };
 
 int mtk_clk_register_plls(struct device_node *node,
-- 
2.45.2


