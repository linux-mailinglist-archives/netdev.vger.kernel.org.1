Return-Path: <netdev+bounces-106885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7230D917EF4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952401C236FA
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D691802A1;
	Wed, 26 Jun 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tO8Miky4"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28017F397;
	Wed, 26 Jun 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399168; cv=none; b=mXZ9LU7JoEQty4XCHfbadO5QfibBOES0a6MKLDfnHS54ajVtrYRYEGAaINLJGzmYHZeRClrntkxywDSjQ8ciUzgTuXiPNj3fAcxazQciGTmfgU42E4veZVXc4YESQjfqcVLQxZnO7xmqlmAZyc69POqG/hsRZKyPMBMnwHCfD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399168; c=relaxed/simple;
	bh=nQwajZYy8XJCa7tJ3Rjisd87KIIHBRFjPNXN4odLpcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwzLueES7pdpmFMMWK17WyaDeipyQpJlVO+2ZSG5TZOwUYyNWgLhr6QFby7OOqHv4i9sfGLkreywg47PKumJg+J3nZljb2KkhjPZMQXn7TPnyN9P/5NEIAl6XP3UxnW6Zzxts3/zAnRxPzD8GSFgLecU16ZYNFR1kgCGux2TOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tO8Miky4; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3612249c33aa11ef99dc3f8fac2c3230-20240626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YDAYvV/XFqqbwzkucvvhD6M3ybBfweUzERktggMsxRA=;
	b=tO8Miky4uAoQOdRPNs+hAFjDJ1+DOOSK1C4lsKqYywqERT8D0i9OY18npkc2Nr+jM4YTtZV3r5xajNkeZBK5Kp6pXHV+Jf2ZY83LoPXaKl0n3wcxgnp2m8gjr1yuHu2geMVUZtB2+tPsD94St3TEjpPU5hRand0//DOKhccb8jA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:1fdabd5f-60e4-4196-8c19-b05d609a9ff8,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:393d96e,CLOUDID:60510c45-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3612249c33aa11ef99dc3f8fac2c3230-20240626
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 864593642; Wed, 26 Jun 2024 18:52:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jun 2024 18:52:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jun 2024 18:52:39 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v9 13/13] net: phy: mediatek: Remove unnecessary outer parens of "supported_triggers" var
Date: Wed, 26 Jun 2024 18:43:29 +0800
Message-ID: <20240626104329.11426-14-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240626104329.11426-1-SkyLake.Huang@mediatek.com>
References: <20240626104329.11426-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.009600-8.000000
X-TMASE-MatchedRID: BIV06Js6OJN00I3rWKbGqx+WEMjoO9WWTJDl9FKHbrkKogmGusPLbx8+
	XHETeZCzky2SP4enkne5cURAloITPh8TzIzimOwPC24oEZ6SpSmb4wHqRpnaDic8CJM0GmQ5RHg
	qdyMQoaGMdMDWzIU2SbY/pOXB9c6UPJCjmiSVfxvh8KGVTfNHVHPx3vy+AFy6CufKYQ8uaEouT9
	8QLmnDW0ma3zYT97IFAYfQIAUhBayZvmCbKVb49sZL6x5U/HridGByp+zdaDg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.009600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0BDA4BC6CCBC2266010878D2C0ACC8CA026B3F044D6E861DD73D69AB949564242000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch removes unnecessary outer parens of "supported_triggers" vars
in mtk-ge.c & mtk-ge-soc.c to improve readability.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 16 ++++++++--------
 drivers/net/phy/mediatek/mtk-ge.c     | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 6d95e7d..6fc989d 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1224,14 +1224,14 @@ static int mt798x_phy_led_brightness_set(struct phy_device *phydev,
 }
 
 static const unsigned long supported_triggers =
-	(BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
-	 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
-	 BIT(TRIGGER_NETDEV_LINK)        |
-	 BIT(TRIGGER_NETDEV_LINK_10)     |
-	 BIT(TRIGGER_NETDEV_LINK_100)    |
-	 BIT(TRIGGER_NETDEV_LINK_1000)   |
-	 BIT(TRIGGER_NETDEV_RX)          |
-	 BIT(TRIGGER_NETDEV_TX));
+	BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+	BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
+	BIT(TRIGGER_NETDEV_LINK)        |
+	BIT(TRIGGER_NETDEV_LINK_10)     |
+	BIT(TRIGGER_NETDEV_LINK_100)    |
+	BIT(TRIGGER_NETDEV_LINK_1000)   |
+	BIT(TRIGGER_NETDEV_RX)          |
+	BIT(TRIGGER_NETDEV_TX);
 
 static int mt798x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					  unsigned long rules)
diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 90f3990..050a4f7 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -152,14 +152,14 @@ static int mt753x_phy_led_brightness_set(struct phy_device *phydev,
 }
 
 static const unsigned long supported_triggers =
-	(BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
-	 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
-	 BIT(TRIGGER_NETDEV_LINK)        |
-	 BIT(TRIGGER_NETDEV_LINK_10)     |
-	 BIT(TRIGGER_NETDEV_LINK_100)    |
-	 BIT(TRIGGER_NETDEV_LINK_1000)   |
-	 BIT(TRIGGER_NETDEV_RX)          |
-	 BIT(TRIGGER_NETDEV_TX));
+	BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+	BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
+	BIT(TRIGGER_NETDEV_LINK)        |
+	BIT(TRIGGER_NETDEV_LINK_10)     |
+	BIT(TRIGGER_NETDEV_LINK_100)    |
+	BIT(TRIGGER_NETDEV_LINK_1000)   |
+	BIT(TRIGGER_NETDEV_RX)          |
+	BIT(TRIGGER_NETDEV_TX);
 
 static int mt753x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					  unsigned long rules)
-- 
2.18.0


