Return-Path: <netdev+bounces-172756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF8A55E5C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE671660FD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23476198E65;
	Fri,  7 Mar 2025 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZwOCW8gB"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502518FDDC;
	Fri,  7 Mar 2025 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318369; cv=none; b=HkSP1b60XRg5ge/XIvBiF4f6/MFlRBLnsaNVM9U97FcYXNWYq0x+na+dYEaSZhwoi2micZ2aZ9d0BFKs/I4juRL9CWPcMK1CKP51qXIf+jcairf3id0nQcSbGF10L2nYnh09SXpDLfNhZVi1F3PpM0gBtcT07vnQ1Ee16IK9/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318369; c=relaxed/simple;
	bh=wpq6E8mJ+HQDgGznpYwcqooDL7g30S1ChOrcJWlCGHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSRJFBan/QVV6G9GR36MUTQ5zZd7EqBtcL+rGeHNzJgraQNiwr9SI0+NyWkQI6CluSKVhn8TWj7ndILPJxwELGrfQo7/1DCDv5qDXKYPdcJWrB8eFPSB0Sdwj/9g2oSGVYmDu4Gjo+DKr7YkCpdbRsEAXZRFR/hT4yCm9vKGIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZwOCW8gB; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d105c054fb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=D71vOqtCw/mRR3gP0XDPi0HaNnNXPYZP/W/klHxKajA=;
	b=ZwOCW8gBfzt60KXh/f5hFLgt5jeeEQJqrhXPsTmPgo14a6hEOpX7JBmTpWmpCZXwfgtOPIPFYVrXQv0TAyM/NXMkyDarmGONdbbJBb9B4QIovy3gyCcNCg4k5B8ULmMtFe7BpSKfMTqjGvbglMpPKD/uMNE+IqOCv2vPMf8hhPw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:9771cf64-a81b-45e3-b63c-cc0eaf6abc5e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:96e207c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d105c054fb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 839810782; Fri, 07 Mar 2025 11:32:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:35 +0800
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
Subject: [PATCH 03/26] clk: mediatek: Support voting for mux
Date: Fri, 7 Mar 2025 11:26:59 +0800
Message-ID: <20250307032942.10447-4-guangjie.song@mediatek.com>
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

Add data fields, defines and ops to support voting for mux.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/clk-mux.c | 198 ++++++++++++++++++++++++++++++++-
 drivers/clk/mediatek/clk-mux.h |  79 +++++++++++++
 2 files changed, 275 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 60990296450b..8a2c89cb3cd5 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -15,11 +15,13 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 
+#include "clk-mtk.h"
 #include "clk-mux.h"
 
 struct mtk_clk_mux {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	struct regmap *vote_regmap;
 	const struct mtk_mux *data;
 	spinlock_t *lock;
 	bool reparent;
@@ -30,6 +32,46 @@ static inline struct mtk_clk_mux *to_mtk_clk_mux(struct clk_hw *hw)
 	return container_of(hw, struct mtk_clk_mux, hw);
 }
 
+static int mtk_clk_mux_fenc_enable_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	unsigned long flags = 0;
+	u32 val = 0;
+	int i = 0;
+	int ret = 0;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+	else
+		__acquire(mux->lock);
+
+	regmap_write(mux->regmap, mux->data->clr_ofs, BIT(mux->data->gate_shift));
+
+	while (1) {
+		regmap_read(mux->regmap, mux->data->fenc_sta_mon_ofs, &val);
+
+		if ((val & BIT(mux->data->fenc_shift)) != 0)
+			break;
+
+		if (i < MTK_WAIT_FENC_DONE_CNT) {
+			udelay(MTK_WAIT_FENC_DONE_US);
+		} else {
+			pr_err("%s wait fenc done timeout\n", clk_hw_get_name(hw));
+			ret = -EBUSY;
+			break;
+		}
+
+		i++;
+	}
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+	else
+		__release(mux->lock);
+
+	return ret;
+}
+
 static int mtk_clk_mux_enable_setclr(struct clk_hw *hw)
 {
 	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
@@ -70,6 +112,16 @@ static void mtk_clk_mux_disable_setclr(struct clk_hw *hw)
 			BIT(mux->data->gate_shift));
 }
 
+static int mtk_clk_mux_fenc_is_enabled(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val = 0;
+
+	regmap_read(mux->regmap, mux->data->fenc_sta_mon_ofs, &val);
+
+	return (val & BIT(mux->data->fenc_shift)) != 0;
+}
+
 static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
 {
 	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
@@ -80,6 +132,106 @@ static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
 	return (val & BIT(mux->data->gate_shift)) == 0;
 }
 
+static int mtk_clk_vote_mux_is_enabled(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val = 0;
+
+	regmap_read(mux->vote_regmap, mux->data->vote_set_ofs, &val);
+
+	return (val & BIT(mux->data->gate_shift)) != 0;
+}
+
+static int mtk_clk_vote_mux_is_done(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val = 0;
+
+	regmap_read(mux->vote_regmap, mux->data->vote_sta_ofs, &val);
+
+	return (val & BIT(mux->data->gate_shift)) != 0;
+}
+
+static int mtk_clk_mux_vote_fenc_enable(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val = 0, val2 = 0;
+	bool is_done = false;
+	int i = 0;
+
+	regmap_write(mux->vote_regmap, mux->data->vote_set_ofs, BIT(mux->data->gate_shift));
+
+	while (!mtk_clk_vote_mux_is_enabled(hw)) {
+		if (i < MTK_WAIT_VOTE_PREPARE_CNT) {
+			udelay(MTK_WAIT_VOTE_PREPARE_US);
+		} else {
+			pr_err("%s mux prepare timeout(%x)\n", clk_hw_get_name(hw), val);
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
+			regmap_read(mux->vote_regmap, mux->data->vote_sta_ofs, &val);
+
+		if (((val & BIT(mux->data->gate_shift)) != 0))
+			is_done = true;
+
+		if (is_done) {
+			regmap_read(mux->regmap, mux->data->fenc_sta_mon_ofs, &val2);
+			if ((val2 & BIT(mux->data->fenc_shift)) != 0)
+				break;
+		}
+
+		if (i < MTK_WAIT_VOTE_DONE_CNT) {
+			udelay(MTK_WAIT_VOTE_DONE_US);
+		} else {
+			pr_err("%s mux enable timeout(%x %x)\n", clk_hw_get_name(hw), val, val2);
+			return -EBUSY;
+		}
+
+		i++;
+	}
+
+	return 0;
+}
+
+static void mtk_clk_mux_vote_disable(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	int i = 0;
+
+	regmap_write(mux->vote_regmap, mux->data->vote_clr_ofs, BIT(mux->data->gate_shift));
+
+	while (mtk_clk_vote_mux_is_enabled(hw)) {
+		if (i < MTK_WAIT_VOTE_PREPARE_CNT) {
+			udelay(MTK_WAIT_VOTE_PREPARE_US);
+		} else {
+			pr_err("%s mux unprepare timeout\n", clk_hw_get_name(hw));
+			return;
+		}
+
+		i++;
+	}
+
+	i = 0;
+
+	while (!mtk_clk_vote_mux_is_done(hw)) {
+		if (i < MTK_WAIT_VOTE_DONE_CNT) {
+			udelay(MTK_WAIT_VOTE_DONE_US);
+		} else {
+			pr_err("%s mux disable timeout\n", clk_hw_get_name(hw));
+			return;
+		}
+
+		i++;
+	}
+}
+
 static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
@@ -151,6 +303,12 @@ static int mtk_clk_mux_determine_rate(struct clk_hw *hw,
 	return clk_mux_determine_rate_flags(hw, req, mux->data->flags);
 }
 
+static void mtk_clk_mux_vote_fenc_disable_unused(struct clk_hw *hw)
+{
+	mtk_clk_mux_vote_fenc_enable(hw);
+	mtk_clk_mux_vote_disable(hw);
+}
+
 const struct clk_ops mtk_mux_clr_set_upd_ops = {
 	.get_parent = mtk_clk_mux_get_parent,
 	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
@@ -168,9 +326,31 @@ const struct clk_ops mtk_mux_gate_clr_set_upd_ops  = {
 };
 EXPORT_SYMBOL_GPL(mtk_mux_gate_clr_set_upd_ops);
 
+const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops = {
+	.enable = mtk_clk_mux_fenc_enable_setclr,
+	.disable = mtk_clk_mux_disable_setclr,
+	.is_enabled = mtk_clk_mux_fenc_is_enabled,
+	.get_parent = mtk_clk_mux_get_parent,
+	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
+	.determine_rate = mtk_clk_mux_determine_rate,
+};
+EXPORT_SYMBOL_GPL(mtk_mux_gate_fenc_clr_set_upd_ops);
+
+const struct clk_ops mtk_mux_vote_fenc_ops = {
+	.enable = mtk_clk_mux_vote_fenc_enable,
+	.disable = mtk_clk_mux_vote_disable,
+	.is_enabled = mtk_clk_mux_fenc_is_enabled,
+	.get_parent = mtk_clk_mux_get_parent,
+	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
+	.determine_rate = mtk_clk_mux_determine_rate,
+	.disable_unused = mtk_clk_mux_vote_fenc_disable_unused,
+};
+EXPORT_SYMBOL_GPL(mtk_mux_vote_fenc_ops);
+
 static struct clk_hw *mtk_clk_register_mux(struct device *dev,
 					   const struct mtk_mux *mux,
 					   struct regmap *regmap,
+					   struct regmap *vote_regmap,
 					   spinlock_t *lock)
 {
 	struct mtk_clk_mux *clk_mux;
@@ -185,9 +365,17 @@ static struct clk_hw *mtk_clk_register_mux(struct device *dev,
 	init.flags = mux->flags;
 	init.parent_names = mux->parent_names;
 	init.num_parents = mux->num_parents;
-	init.ops = mux->ops;
+	if (mux->flags & CLK_USE_VOTE) {
+		if (vote_regmap)
+			init.ops = mux->ops;
+		else
+			init.ops = mux->dma_ops;
+	} else {
+		init.ops = mux->ops;
+	}
 
 	clk_mux->regmap = regmap;
+	clk_mux->vote_regmap = vote_regmap;
 	clk_mux->data = mux;
 	clk_mux->lock = lock;
 	clk_mux->hw.init = &init;
@@ -220,6 +408,7 @@ int mtk_clk_register_muxes(struct device *dev,
 			   struct clk_hw_onecell_data *clk_data)
 {
 	struct regmap *regmap;
+	struct regmap *vote_regmap = NULL;
 	struct clk_hw *hw;
 	int i;
 
@@ -238,8 +427,13 @@ int mtk_clk_register_muxes(struct device *dev,
 			continue;
 		}
 
-		hw = mtk_clk_register_mux(dev, mux, regmap, lock);
+		if (mux->vote_comp) {
+			vote_regmap = syscon_regmap_lookup_by_phandle(node, mux->vote_comp);
+			if (IS_ERR(vote_regmap))
+				vote_regmap = NULL;
+		}
 
+		hw = mtk_clk_register_mux(dev, mux, regmap, vote_regmap, lock);
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", mux->name,
 			       hw);
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index 943ad1d7ce4b..c202ad42be16 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -21,6 +21,7 @@ struct mtk_mux {
 	int id;
 	const char *name;
 	const char * const *parent_names;
+	const char *vote_comp;
 	const u8 *parent_index;
 	unsigned int flags;
 
@@ -28,13 +29,19 @@ struct mtk_mux {
 	u32 set_ofs;
 	u32 clr_ofs;
 	u32 upd_ofs;
+	u32 vote_set_ofs;
+	u32 vote_clr_ofs;
+	u32 vote_sta_ofs;
+	u32 fenc_sta_mon_ofs;
 
 	u8 mux_shift;
 	u8 mux_width;
 	u8 gate_shift;
 	s8 upd_shift;
+	u8 fenc_shift;
 
 	const struct clk_ops *ops;
+	const struct clk_ops *dma_ops;
 	signed char num_parents;
 };
 
@@ -77,6 +84,8 @@ struct mtk_mux {
 
 extern const struct clk_ops mtk_mux_clr_set_upd_ops;
 extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
+extern const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops;
+extern const struct clk_ops mtk_mux_vote_fenc_ops;
 
 #define MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
 			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
@@ -118,6 +127,76 @@ extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
 			0, _upd_ofs, _upd, CLK_SET_RATE_PARENT,		\
 			mtk_mux_clr_set_upd_ops)
 
+#define MUX_MULT_VOTE_FENC_FLAGS(_id, _name, _parents,			\
+			 _mux_ofs, _mux_set_ofs, _mux_clr_ofs, _vote_comp,\
+			_vote_sta_ofs, _vote_set_ofs, _vote_clr_ofs,	\
+			_shift, _width, _gate, _upd_ofs, _upd,		\
+			_fenc_sta_mon_ofs, _fenc, _flags) {		\
+		.id = _id,						\
+		.name = _name,						\
+		.mux_ofs = _mux_ofs,					\
+		.set_ofs = _mux_set_ofs,				\
+		.clr_ofs = _mux_clr_ofs,				\
+		.vote_comp = _vote_comp,				\
+		.vote_sta_ofs = _vote_sta_ofs,				\
+		.vote_set_ofs = _vote_set_ofs,				\
+		.vote_clr_ofs = _vote_clr_ofs,				\
+		.upd_ofs = _upd_ofs,					\
+		.fenc_sta_mon_ofs = _fenc_sta_mon_ofs,			\
+		.mux_shift = _shift,					\
+		.mux_width = _width,					\
+		.gate_shift = _gate,					\
+		.upd_shift = _upd,					\
+		.fenc_shift = _fenc,					\
+		.parent_names = _parents,				\
+		.num_parents = ARRAY_SIZE(_parents),			\
+		.flags =  CLK_USE_VOTE | (_flags),			\
+		.ops = &mtk_mux_vote_fenc_ops,				\
+		.dma_ops = &mtk_mux_gate_fenc_clr_set_upd_ops,		\
+	}
+
+#define MUX_MULT_VOTE_FENC(_id, _name, _parents,				\
+			_mux_ofs, _mux_set_ofs, _mux_clr_ofs, _vote_comp,\
+			_vote_sta_ofs, _vote_set_ofs, _vote_clr_ofs,	\
+			_shift, _width, _gate, _upd_ofs, _upd,		\
+			_fenc_sta_mon_ofs, _fenc)			\
+		MUX_MULT_VOTE_FENC_FLAGS(_id, _name, _parents,		\
+			_mux_ofs, _mux_set_ofs, _mux_clr_ofs, _vote_comp,\
+			_vote_sta_ofs, _vote_set_ofs, _vote_clr_ofs,	\
+			_shift, _width, _gate, _upd_ofs, _upd,		\
+			_fenc_sta_mon_ofs, _fenc, 0)
+
+#define MUX_GATE_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents,		\
+			_mux_ofs, _mux_set_ofs, _mux_clr_ofs,		\
+			_shift, _width, _gate, _upd_ofs, _upd,		\
+			_fenc_sta_mon_ofs, _fenc, _flags) {		\
+		.id = _id,						\
+		.name = _name,						\
+		.mux_ofs = _mux_ofs,					\
+		.set_ofs = _mux_set_ofs,				\
+		.clr_ofs = _mux_clr_ofs,				\
+		.upd_ofs = _upd_ofs,					\
+		.fenc_sta_mon_ofs = _fenc_sta_mon_ofs,			\
+		.mux_shift = _shift,					\
+		.mux_width = _width,					\
+		.gate_shift = _gate,					\
+		.upd_shift = _upd,					\
+		.fenc_shift = _fenc,					\
+		.parent_names = _parents,				\
+		.num_parents = ARRAY_SIZE(_parents),			\
+		.flags = _flags,					\
+		.ops = &mtk_mux_gate_fenc_clr_set_upd_ops,		\
+	}
+
+#define MUX_GATE_FENC_CLR_SET_UPD(_id, _name, _parents,			\
+			_mux_ofs, _mux_set_ofs, _mux_clr_ofs,		\
+			_shift, _width, _gate, _upd_ofs, _upd,		\
+			_fenc_sta_mon_ofs, _fenc)			\
+		MUX_GATE_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents,	\
+			_mux_ofs, _mux_set_ofs, _mux_clr_ofs,		\
+			_shift, _width, _gate, _upd_ofs, _upd,		\
+			_fenc_sta_mon_ofs, _fenc, 0)
+
 int mtk_clk_register_muxes(struct device *dev,
 			   const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
-- 
2.45.2


