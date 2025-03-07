Return-Path: <netdev+bounces-172757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E80A55E66
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33D67AA25B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3712199EBB;
	Fri,  7 Mar 2025 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N0xQ3eZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0011925A6;
	Fri,  7 Mar 2025 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318369; cv=none; b=e6zen4mQSAPuUxiTqGTxXfdCamMQsI6lPNcrLrjy0Tg2iuprm5odNnbUB2X0JqNwIZsgxmnKsYzpaHNTYBytaWwLofz0FY/L8FFShCeAe84VxnTiUnaRS3bRDKclJ9h1mcfg1hHrwQtdfMlfOjRaJp+SMhVQ6O2ZAqVDjQZEJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318369; c=relaxed/simple;
	bh=+IccVHOFvRcS+brMTLxwhSbVJskjqbCBXQOVSZjsP9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocH7UPIe+nhhYVmR3mQkRLLr618vO8X2FXk188nycMaz1HUQgRWOJtd8wtP5oYcjU3IbFPv3g9D7r1VQQN+fee9SFp6xXYGamGfmdzLg+3C7BqcXQ/OSR6cVyE6cBX4JKm7SfUsgEe0QEP/Cr6fmi1vdbn09zGKavrlGzkIu83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N0xQ3eZ0; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d227c464fb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eKZz4jFOoMUJdddEXwNyOM0T7oSXWk16nCWyBfGInKI=;
	b=N0xQ3eZ0FtoTW8IDvwbJaqotaua9cHmJPy/XYgXkxHOtjIoiDPA/OpKR3TK08Ox3bHQZvNz7HTGlrRLlw4Le7y9WaFdcxbgq+3raf+rR0UcjhMriRcxoh1Wi/gGOrPEvUtyDhusVtgB7jTorrK8IOrSzEUlPU11LLnLXNx9iYY4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:d6d3eda3-e39e-4111-a574-9b50b1d1ff22,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:df6d108c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d227c464fb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 521014008; Fri, 07 Mar 2025 11:32:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:38 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:37 +0800
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
Subject: [PATCH 05/26] clk: mediatek: Add gate ops without disable
Date: Fri, 7 Mar 2025 11:27:01 +0800
Message-ID: <20250307032942.10447-6-guangjie.song@mediatek.com>
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

Add gate ops without .disable and the ops is used for gate which is not
allowed to disable but cannot affect its parent clock to disable.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/clk-gate.c | 6 ++++++
 drivers/clk/mediatek/clk-gate.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index be6cf4a6d246..a36136c61252 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -273,6 +273,12 @@ const struct clk_ops mtk_clk_gate_ops_setclr = {
 };
 EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_setclr);
 
+const struct clk_ops mtk_clk_gate_ops_setclr_enable = {
+	.is_enabled	= mtk_cg_bit_is_cleared,
+	.enable		= mtk_cg_enable,
+};
+EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_setclr_enable);
+
 const struct clk_ops mtk_clk_gate_ops_setclr_inv = {
 	.is_enabled	= mtk_cg_bit_is_set,
 	.enable		= mtk_cg_enable_inv,
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 7d93fc84ad51..d992e3edd457 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -16,6 +16,7 @@ struct device;
 struct device_node;
 
 extern const struct clk_ops mtk_clk_gate_ops_setclr;
+extern const struct clk_ops mtk_clk_gate_ops_setclr_enable;
 extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
 extern const struct clk_ops mtk_clk_gate_ops_no_setclr;
 extern const struct clk_ops mtk_clk_gate_ops_no_setclr_inv;
-- 
2.45.2


