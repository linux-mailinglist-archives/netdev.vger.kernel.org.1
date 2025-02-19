Return-Path: <netdev+bounces-167649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA4CA3B53C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3263A49A1
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5B1DE887;
	Wed, 19 Feb 2025 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ajcjz0oL"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61101C175A;
	Wed, 19 Feb 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954405; cv=none; b=J+zzKGaIOBPYpVWMM75hMVlg8ctr6mIKiQKbk9jg5w9mAiaKNTbfq2irGCp4AUlapau6RDh6LWfypXi5wJRTdptIhd4w/mdrRYo2hbalqYRVeROzIwfNM9PZ43GRJxXWZJ9/vM56V8fJpcFxO+l+m/4d8GVAkjmffv65+8YkBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954405; c=relaxed/simple;
	bh=gfEB9dUu0P8qbqEK6PD5UTdLdehzl+1vQlTGayBSSYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTS+DuHCq2Gx+zss9Vs/4lmzVY1zgzWtxtr5qTEg9lG1JFH5DRhpWKVF0KXuw8hjlxhYhFueMW7l3sjfcPMaGOtj6qO9sONAYkTioT6jkZXq4jsFyPvI8YJh1M0mZz/RXIi/5EC/xpI2d2IMm8dhBv9y9TDvHk6oKIo9ond2o40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ajcjz0oL; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 16d8eadaee9d11efaae1fd9735fae912-20250219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GcKseN9Pa+u4rHy7RsMCMoMEvn9EIwsWA1hCUExuTYE=;
	b=Ajcjz0oLQyL7MkIqPycyeF6wp8KkqOGRoTibwIThqHII7vz30+kJt74H4Jb45ve9LPx/sgYa89KEqetIbqo+eTG35hrFyZSs71d4Jq5C88wQ+J+6KYjs/ieHSndMeUAXZm3+IeIjlIyap5C4tDJEmASI+lspb9mLqDC09HfN490=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:3bb1931f-0236-4f0f-8086-45cde44618ab,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:bd73fe28-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 16d8eadaee9d11efaae1fd9735fae912-20250219
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 634113756; Wed, 19 Feb 2025 16:39:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 19 Feb 2025 16:39:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 19 Feb 2025 16:39:52 +0800
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
Subject: [PATCH net-next v2 2/3] dts: mt7988a: Add built-in ethernet phy firmware node
Date: Wed, 19 Feb 2025 16:39:09 +0800
Message-ID: <20250219083910.2255981-3-SkyLake.Huang@mediatek.com>
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

Add built-in ethernet phy firmware node in mt7988a.dtsi.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 88b56a24efca..f2679702c328 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -322,6 +322,12 @@ lvts: lvts@1100a000 {
 			nvmem-cell-names = "lvts-calib-data-1";
 		};
 
+		phyfw: phy-firmware@f000000 {
+			compatible = "mediatek,2p5gphy-fw";
+			reg = <0 0x0f100000 0 0x20000>,
+			      <0 0x0f0f0018 0 0x20>;
+		};
+
 		usb@11190000 {
 			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11190000 0 0x2e00>,
-- 
2.45.2


