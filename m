Return-Path: <netdev+bounces-172755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB638A55E58
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EEE175553
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA01922C6;
	Fri,  7 Mar 2025 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sFR18x0l"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590015E5AE;
	Fri,  7 Mar 2025 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318367; cv=none; b=sMqKqnbzASpjv9SgszIEwOFtKlCsdIELl+UOGMEjANsFJSL2Vj6+PuShdjrpX2bPd9xomrZrRR/pOxl3WSJvN9ZSfZz6PcjjIWOOxyppYoS80gmRtKStrINzD/n2u+l/X3W8gjIUU5kjVff9B4CSIPdoa84uRf/q6oSx5TK0ZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318367; c=relaxed/simple;
	bh=AUSmsJSpwnvJGKKcuAIGtU6BQYo+2TX+XUGxleo0CEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poVPc9SaDtxxrXg72WSaKbS2FkAl070dci1OoKJmMvvHHV91fYwhVGeJP22aZ+zaIdUwTJxQKZc14Gd7MgIv4b8nikCUXak1HWshfDCgtWvT0IpRT/ASd1/Yj7X0WBX7zmXh+iE7WWsmYYLilmKFfql/wkG695u97XZzO4Scmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sFR18x0l; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d1a085eefb0411efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xlhPBaPDQlxN4mEBmcB22vZGGR0wheXIAp+lo36yNd4=;
	b=sFR18x0lb953eoDeq/26gIZOSW7z1/rTpiGrjHv2QPqnuN65XG4MJxmZMQlPEYT5K9am8omZBeVxqeNNCSMzPGxEu/8HNjc9tih4zW6zTsVXbgiac13Cxby/qs/HpB0KBDo23DiT9OwOhs/M6vFX0iSBxPMlUnni23peM6EQVJY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:f89dc8ec-8af2-48f9-99c2-3471dafaa89d,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:a4e207c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d1a085eefb0411efaae1fd9735fae912-20250307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 76155204; Fri, 07 Mar 2025 11:32:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:37 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:36 +0800
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
Subject: [PATCH 04/26] clk: mediatek: Support voting for gate
Date: Fri, 7 Mar 2025 11:27:00 +0800
Message-ID: <20250307032942.10447-5-guangjie.song@mediatek.com>
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

Add data fields and ops to support voting for gate.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/clk-gate.c | 230 +++++++++++++++++++++++++++++++-
 drivers/clk/mediatek/clk-gate.h |   5 +
 2 files changed, 228 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 67d9e741c5e7..be6cf4a6d246 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -12,14 +12,19 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include "clk-mtk.h"
 #include "clk-gate.h"
 
 struct mtk_clk_gate {
 	struct clk_hw	hw;
 	struct regmap	*regmap;
+	struct regmap	*vote_regmap;
 	int		set_ofs;
 	int		clr_ofs;
 	int		sta_ofs;
+	int		vote_set_ofs;
+	int		vote_clr_ofs;
+	int		vote_sta_ofs;
 	u8		bit;
 };
 
@@ -100,6 +105,143 @@ static void mtk_cg_disable_inv(struct clk_hw *hw)
 	mtk_cg_clr_bit(hw);
 }
 
+static int mtk_cg_vote_is_set(struct clk_hw *hw)
+{
+	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
+	u32 val = 0;
+
+	regmap_read(cg->vote_regmap, cg->vote_set_ofs, &val);
+
+	val &= BIT(cg->bit);
+
+	return val != 0;
+}
+
+static int mtk_cg_vote_is_done(struct clk_hw *hw)
+{
+	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
+	u32 val = 0;
+
+	regmap_read(cg->vote_regmap, cg->vote_sta_ofs, &val);
+
+	val &= BIT(cg->bit);
+
+	return val != 0;
+}
+
+static int __cg_vote_enable(struct clk_hw *hw, bool inv)
+{
+	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
+	u32 val = 0, val2 = 0;
+	bool is_done = false;
+	int i = 0;
+
+	regmap_write(cg->vote_regmap, cg->vote_set_ofs, BIT(cg->bit));
+
+	while (!mtk_cg_vote_is_set(hw)) {
+		if (i < MTK_WAIT_VOTE_PREPARE_CNT) {
+			udelay(MTK_WAIT_VOTE_PREPARE_US);
+		} else {
+			pr_err("%s cg prepare timeout\n", clk_hw_get_name(hw));
+			return -EBUSY;
+		}
+
+		i++;
+	}
+
+	i = 0;
+
+	while (1) {
+		if (!is_done)
+			regmap_read(cg->vote_regmap, cg->vote_sta_ofs, &val);
+
+		if ((val & BIT(cg->bit)) != 0)
+			is_done = true;
+
+		if (is_done) {
+			regmap_read(cg->regmap, cg->sta_ofs, &val2);
+			if ((inv && (val2 & BIT(cg->bit)) != 0) ||
+			    (!inv && (val2 & BIT(cg->bit)) == 0))
+				break;
+		}
+
+		if (i < MTK_WAIT_VOTE_DONE_CNT) {
+			udelay(MTK_WAIT_VOTE_DONE_US);
+		} else {
+			pr_err("%s cg enable timeout(%x %x)\n", clk_hw_get_name(hw), val, val2);
+
+			if (inv)
+				regmap_write(cg->regmap, cg->set_ofs, BIT(cg->bit));
+			else
+				regmap_write(cg->regmap, cg->clr_ofs, BIT(cg->bit));
+
+			return -EBUSY;
+		}
+
+		i++;
+	}
+
+	return 0;
+}
+
+static int mtk_cg_vote_enable(struct clk_hw *hw)
+{
+	return __cg_vote_enable(hw, false);
+}
+
+static int mtk_cg_vote_enable_inv(struct clk_hw *hw)
+{
+	return __cg_vote_enable(hw, true);
+}
+
+static void mtk_cg_vote_disable(struct clk_hw *hw)
+{
+	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
+	u32 val;
+	int i = 0;
+
+	/* dummy read to clr idle signal of hw voter bus */
+	regmap_read(cg->vote_regmap, cg->vote_clr_ofs, &val);
+
+	regmap_write(cg->vote_regmap, cg->vote_clr_ofs, BIT(cg->bit));
+
+	while (mtk_cg_vote_is_set(hw)) {
+		if (i < MTK_WAIT_VOTE_PREPARE_CNT) {
+			udelay(MTK_WAIT_VOTE_PREPARE_US);
+		} else {
+			pr_err("%s cg unprepare timeout\n", clk_hw_get_name(hw));
+			return;
+		}
+
+		i++;
+	}
+
+	i = 0;
+
+	while (!mtk_cg_vote_is_done(hw)) {
+		if (i < MTK_WAIT_VOTE_DONE_CNT) {
+			udelay(MTK_WAIT_VOTE_DONE_US);
+		} else {
+			pr_err("%s cg disable timeout\n", clk_hw_get_name(hw));
+			return;
+		}
+
+		i++;
+	}
+}
+
+static void mtk_cg_vote_disable_unused(struct clk_hw *hw)
+{
+	mtk_cg_vote_enable(hw);
+	mtk_cg_vote_disable(hw);
+}
+
+static void mtk_cg_vote_disable_unused_inv(struct clk_hw *hw)
+{
+	mtk_cg_vote_enable_inv(hw);
+	mtk_cg_vote_disable(hw);
+}
+
 static int mtk_cg_enable_no_setclr(struct clk_hw *hw)
 {
 	mtk_cg_clr_bit_no_setclr(hw);
@@ -138,6 +280,22 @@ const struct clk_ops mtk_clk_gate_ops_setclr_inv = {
 };
 EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_setclr_inv);
 
+const struct clk_ops mtk_clk_gate_ops_vote = {
+	.is_enabled	= mtk_cg_bit_is_cleared,
+	.enable		= mtk_cg_vote_enable,
+	.disable	= mtk_cg_vote_disable,
+	.disable_unused	= mtk_cg_vote_disable_unused,
+};
+EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_vote);
+
+const struct clk_ops mtk_clk_gate_ops_vote_inv = {
+	.is_enabled	= mtk_cg_bit_is_set,
+	.enable		= mtk_cg_vote_enable_inv,
+	.disable	= mtk_cg_vote_disable,
+	.disable_unused	= mtk_cg_vote_disable_unused_inv,
+};
+EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_vote_inv);
+
 const struct clk_ops mtk_clk_gate_ops_no_setclr = {
 	.is_enabled	= mtk_cg_bit_is_cleared,
 	.enable		= mtk_cg_enable_no_setclr,
@@ -190,6 +348,53 @@ static struct clk_hw *mtk_clk_register_gate(struct device *dev, const char *name
 	return &cg->hw;
 }
 
+static struct clk_hw *mtk_clk_register_gate_vote(struct device *dev,
+						 const struct mtk_gate *gate,
+						 struct regmap *regmap,
+						 struct regmap *vote_regmap)
+{
+	struct mtk_clk_gate *cg;
+	int ret;
+	struct clk_init_data init = {};
+
+	cg = kzalloc(sizeof(*cg), GFP_KERNEL);
+	if (!cg)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = gate->name;
+	init.flags = gate->flags | CLK_SET_RATE_PARENT;
+	init.parent_names = gate->parent_name ? &gate->parent_name : NULL;
+	init.num_parents = gate->parent_name ? 1 : 0;
+	if (vote_regmap)
+		init.ops = gate->ops;
+	else
+		init.ops = gate->dma_ops;
+
+	cg->regmap = regmap;
+	cg->vote_regmap = vote_regmap;
+	if (gate->regs) {
+		cg->set_ofs = gate->regs->set_ofs;
+		cg->clr_ofs = gate->regs->clr_ofs;
+		cg->sta_ofs = gate->regs->sta_ofs;
+	}
+	if (gate->vote_regs) {
+		cg->vote_set_ofs = gate->vote_regs->set_ofs;
+		cg->vote_clr_ofs = gate->vote_regs->clr_ofs;
+		cg->vote_sta_ofs = gate->vote_regs->sta_ofs;
+	}
+	cg->bit = gate->shift;
+
+	cg->hw.init = &init;
+
+	ret = clk_hw_register(dev, &cg->hw);
+	if (ret) {
+		kfree(cg);
+		return ERR_PTR(ret);
+	}
+
+	return &cg->hw;
+}
+
 static void mtk_clk_unregister_gate(struct clk_hw *hw)
 {
 	struct mtk_clk_gate *cg;
@@ -209,6 +414,7 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 	int i;
 	struct clk_hw *hw;
 	struct regmap *regmap;
+	struct regmap  *vote_regmap = NULL;
 
 	if (!clk_data)
 		return -ENOMEM;
@@ -228,13 +434,23 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 			continue;
 		}
 
-		hw = mtk_clk_register_gate(dev, gate->name, gate->parent_name,
-					    regmap,
-					    gate->regs->set_ofs,
-					    gate->regs->clr_ofs,
-					    gate->regs->sta_ofs,
-					    gate->shift, gate->ops,
-					    gate->flags);
+		if (gate->flags & CLK_USE_VOTE) {
+			if (gate->vote_comp) {
+				vote_regmap = syscon_regmap_lookup_by_phandle(node, gate->vote_comp);
+				if (IS_ERR(vote_regmap))
+					vote_regmap = NULL;
+			}
+
+			hw = mtk_clk_register_gate_vote(dev, gate, regmap, vote_regmap);
+		} else {
+			hw = mtk_clk_register_gate(dev, gate->name, gate->parent_name,
+						   regmap,
+						   gate->regs->set_ofs,
+						   gate->regs->clr_ofs,
+						   gate->regs->sta_ofs,
+						   gate->shift, gate->ops,
+						   gate->flags);
+		}
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", gate->name,
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 1a46b4c56fc5..7d93fc84ad51 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -19,6 +19,8 @@ extern const struct clk_ops mtk_clk_gate_ops_setclr;
 extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
 extern const struct clk_ops mtk_clk_gate_ops_no_setclr;
 extern const struct clk_ops mtk_clk_gate_ops_no_setclr_inv;
+extern const struct clk_ops mtk_clk_gate_ops_vote;
+extern const struct clk_ops mtk_clk_gate_ops_vote_inv;
 
 struct mtk_gate_regs {
 	u32 sta_ofs;
@@ -30,9 +32,12 @@ struct mtk_gate {
 	int id;
 	const char *name;
 	const char *parent_name;
+	const char *vote_comp;
 	const struct mtk_gate_regs *regs;
+	const struct mtk_gate_regs *vote_regs;
 	int shift;
 	const struct clk_ops *ops;
+	const struct clk_ops *dma_ops;
 	unsigned long flags;
 };
 
-- 
2.45.2


