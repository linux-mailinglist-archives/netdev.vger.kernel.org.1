Return-Path: <netdev+bounces-167648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299A9A3B52F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B808917B4DB
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769391DDA20;
	Wed, 19 Feb 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GAZu8z7n"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36521D8A0D;
	Wed, 19 Feb 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954373; cv=none; b=TC+j4Aqq7NiJxg2TjsJJ9KAfss6bu7aMlK5Y+qgk6wP1xAsZMbrFNMcX8MQxrLzRaUvRJjh/V9Zz21IpJE31M0UhAOKV0BDW8g9UOBeNvi4ZKFmAJVL+K+N1eJuvotN6vAjzcD+pQs21IvB5Y9ic5EwzL67m8JVeAPCJ8vil7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954373; c=relaxed/simple;
	bh=hW7x0f3Ot9Pk9lxiuRgJRpZ4fivJavFRwyJK+rzYiiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=runoZ7wL7Aj/lkXTfr0HR+XnPGdLpwW0tp6oB/MmwvZxn26Ol9dv+asV76Q2V2Q5MrqAcnuiF0wImIlVf2EsZV6keuPf+YRsp31/AJW29Isn48Uqt1k4PvpF4/iZjh3gCrNnng8C4CkMNKwz90X6Hco+Nwj/tuoKQmkkur6MDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GAZu8z7n; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0695997aee9d11efaae1fd9735fae912-20250219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Uzh1JZII0+rs/QTFKIZkFkkjKU4Rv24CssQQiCbSDFc=;
	b=GAZu8z7ndRtKb7AhrI0konYnwdLMSB2GZ+zIx/6h1av7wYprNIoy1yPzbcHWCOLp9hVOXV2tgUEtBhJmIgPZdqIH0+qnF4pY4Y5w62SUcSNqDFc4UNPw5lgR1HMWzU0cZwZI9MK5IQfqAz1BGISDwDkJkVWBdXKy4p8nObZr+dI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:a2a8f74d-9d70-42c3-afc8-75b5a1b7380a,IP:0,U
	RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:2ad850b5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0695997aee9d11efaae1fd9735fae912-20250219
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1451749611; Wed, 19 Feb 2025 16:39:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 19 Feb 2025 16:39:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 19 Feb 2025 16:39:24 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon
 Horman <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, Sky Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware dt-bindings and dts node
Date: Wed, 19 Feb 2025 16:39:08 +0800
Message-ID: <20250219083910.2255981-2-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Sky Huang <skylake.huang@mediatek.com>

Add 2.5Gphy firmware dt-bindings and dts node since mtk-2p5ge
driver requires firmware to run. Also, update MAINTAINERS for
MediaTek's built-in 2.5Gphy dt-bindings and change MAINTAINER's name.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 .../bindings/net/mediatek,2p5gphy-fw.yaml     | 37 +++++++++++++++++++
 MAINTAINERS                                   |  3 +-
 2 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek,2p5gphy-fw.yaml

diff --git a/Documentation/devicetree/bindings/net/mediatek,2p5gphy-fw.yaml b/Documentation/devicetree/bindings/net/mediatek,2p5gphy-fw.yaml
new file mode 100644
index 000000000000..56ebe88b8921
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mediatek,2p5gphy-fw.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/mediatek,2p5gphy-fw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Built-in 2.5G Ethernet PHY
+
+maintainers:
+  - Sky Huang <SkyLake.Huang@mediatek.com>
+
+description: |
+  MediaTek Built-in 2.5G Ethernet PHY needs to load firmware so it can
+  run correctly.
+
+properties:
+  compatible:
+    const: "mediatek,2p5gphy-fw"
+
+  reg:
+    items:
+      - description: pmb firmware load address
+      - description: firmware trigger register
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    phyfw: phy-firmware@f000000 {
+      compatible = "mediatek,2p5gphy-fw";
+      reg = <0 0x0f100000 0 0x20000>,
+            <0 0x0f0f0018 0 0x20>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index de81a3d68396..42ec8b8d03bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14716,9 +14716,10 @@ F:	include/linux/pcs/pcs-mtk-lynxi.h
 MEDIATEK ETHERNET PHY DRIVERS
 M:	Daniel Golle <daniel@makrotopia.org>
 M:	Qingfang Deng <dqfext@gmail.com>
-M:	SkyLake Huang <SkyLake.Huang@mediatek.com>
+M:	Sky Huang <SkyLake.Huang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/mediatek,2p5gphy-fw.yaml
 F:	drivers/net/phy/mediatek/mtk-ge-soc.c
 F:	drivers/net/phy/mediatek/mtk-phy-lib.c
 F:	drivers/net/phy/mediatek/mtk-ge.c
-- 
2.45.2


