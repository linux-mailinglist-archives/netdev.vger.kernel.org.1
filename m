Return-Path: <netdev+bounces-135049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A14399BFC1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0FB283033
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 06:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D113CFB6;
	Mon, 14 Oct 2024 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="g+BpLFZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7DA2B9A6;
	Mon, 14 Oct 2024 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885982; cv=none; b=Q5JX8KDZKp4JM6aSeGiK1XgnhpynzMQ2mhQv5J/jfId2UP5OkD5DTRAEM3BA+7Q53SKl8aMN+cFAaoGMQEh70x+l5IwWfTe+6Bsro1iPXjC7EqItVgZiEAweujXIZLKXlS1914defbq7+kenpkDXnVMWHbKd7Olw/N+GuAs4QKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885982; c=relaxed/simple;
	bh=sNjJpZs/AXmHgdHozMgXsndo2NdM6J2FNMZb2BVpV0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DDRtPmA4hTp9b28a6ESwz2mPigOfwqwhkOmzmJ5CHC4RD/NAawH7eeA2Kcg8hajdGtKnbXlu0fGwjqyy8L+zdjvAek4iSluvglglug8LbLs11ko+4yl7BqYUrf1fCesBdu+PiujVQtvsx/g6ZhHYPuRwb6dheinniXQqhC6hhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=g+BpLFZZ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6706e69889f211ef8b96093e013ec31c-20241014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Yds5XsztjRetd0eY+2gfotwVU2fKNh8j54ZoUQ3yI+4=;
	b=g+BpLFZZGuLU85enMvoYdtDjfavdzDqx+7BiTB2PuPh8s0xCacKetlu2azX6p5SHIcKlU/lsZ0gmreqYhijDRs1ogYzO1TkWjDJ+7dlVk50Lo9XltAx1U0C3QYaA31Cwql5rLHGgYDPTIotvHrDgTPGMIU84qb8NJpslAJ3cnOw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:72ba451e-7a81-4136-9399-69b391773ffb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:79e9bc06-3d5c-41f6-8d90-a8be388b5b5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6706e69889f211ef8b96093e013ec31c-20241014
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1314852581; Mon, 14 Oct 2024 14:06:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 13 Oct 2024 23:06:06 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 14 Oct 2024 14:06:06 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sky Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [RFC PATCH net-next 1/1] net: phy: Add capability to enable/disable 2.5G/5G/10G AN in ethtool
Date: Mon, 14 Oct 2024 14:06:03 +0800
Message-ID: <20241014060603.29878-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

For phy loopback test, we need to disable AN. In this way,
users can disable/enable phy AN more conveniently.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/phy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 14224e0..10772f8 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1085,7 +1085,10 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 		return -EINVAL;
 
 	if (autoneg == AUTONEG_DISABLE &&
-	    ((speed != SPEED_1000 &&
+	    ((speed != SPEED_10000 &&
+	      speed != SPEED_5000 &&
+	      speed != SPEED_2500 &&
+	      speed != SPEED_1000 &&
 	      speed != SPEED_100 &&
 	      speed != SPEED_10) ||
 	     (duplex != DUPLEX_HALF &&
-- 
2.45.2


