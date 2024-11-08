Return-Path: <netdev+bounces-143348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 649599C222E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B7E1C24BC6
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF2191F8A;
	Fri,  8 Nov 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H1tQKaOp"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0A1BD9DB;
	Fri,  8 Nov 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083717; cv=none; b=LNEoeSCC1yLGTHAGKocy5uch+ilKzD/8X1Zsb/aL989Ifcjlh0tQmHrYc6Xbz8REC51FRbvfWRFgq2H+5SNywzZ6ySqJtTve0jYIsrAXEWuKtf0gmHRpMikU+kTzfCeOYpALCQcnDbEt9rOXWGKJ2xXKEvD9Uv6rOp2VYtFNGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083717; c=relaxed/simple;
	bh=VwbcpWn+FUl+U6LVMR0lDN+4MVBJctlXXq8lB1peqok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e0DaxikrswFihrlbuFxksjegyre+hRh+tLOMvPLjHaZCiFQZdb/eYtgKBnNOBjajCam+iqcUoJNu/lEKYG0leEfCR8xl0EUcHgzAY307G9Ghh2lTu590830bQVs5No7DTCEbg075TVBi/+RbOnmEmZbGuUIpHPtT9QnjBaT33UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H1tQKaOp; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 66cea34e9def11efbd192953cf12861f-20241109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HJdxrHqrC5kEMbapK+RIRyuzCDjboqt8Pz02wTDuMpE=;
	b=H1tQKaOpvb99NH2gs2KeXotcnS71Gp2C5T3QYofz7qfiJ6nv93JOa+Dfsp4qw4Yi6GJKxrjFQsTIh8DsHYQg7VLYR6YEb6447nxxqhqaCkoqAeB9oHPlNVZmJNGGcxMaGTJSTboWxz9On1GT0TcwXzj1XEny/hbfbPNwUujLsA0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:6fd52581-8899-4827-989e-b42dc089d80e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:18f9d91b-4f51-4e1d-bb6a-1fd98b6b19d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 66cea34e9def11efbd192953cf12861f-20241109
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1550831705; Sat, 09 Nov 2024 00:35:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Nov 2024 08:35:00 -0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 9 Nov 2024 00:35:00 +0800
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
Subject: [PATCH net-next v3 0/5] Re-organize MediaTek ethernet phy drivers and propose mtk-phy-lib
Date: Sat, 9 Nov 2024 00:34:50 +0800
Message-ID: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Sky Huang <skylake.huang@mediatek.com>

This patchset comes from patch 1/9, 3/9, 4/9, 5/9 and 7/9 of:
https://lore.kernel.org/netdev/20241004102413.5838-1-SkyLake.Huang@mediatek.com/

This patchset changes MediaTek's ethernet phy's folder structure and
integrates helper functions, including LED & token ring manipulation,
into mtk-phy-lib.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
Change in v2:
- Add correct Reviewed-by tag in each patch.

Change in v3:
[patch 4/5]
- Fix kernel test robot error by adding missing MTK_NET_PHYLIB.
---

SkyLake.Huang (5):
  net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
  net: phy: mediatek: Move LED helper functions into mtk phy lib
  net: phy: mediatek: Improve readability of mtk-phy-lib.c's
    mtk_phy_led_hw_ctrl_set()
  net: phy: mediatek: Integrate read/write page helper functions
  net: phy: mediatek: add MT7530 & MT7531's PHY ID macros

 MAINTAINERS                                   |   6 +-
 drivers/net/phy/Kconfig                       |  17 +-
 drivers/net/phy/Makefile                      |   3 +-
 drivers/net/phy/mediatek/Kconfig              |  27 ++
 drivers/net/phy/mediatek/Makefile             |   4 +
 .../mtk-ge-soc.c}                             | 298 ++----------------
 .../phy/{mediatek-ge.c => mediatek/mtk-ge.c}  |  31 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c        | 270 ++++++++++++++++
 drivers/net/phy/mediatek/mtk.h                |  89 ++++++
 9 files changed, 438 insertions(+), 307 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 rename drivers/net/phy/{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c} (83%)
 rename drivers/net/phy/{mediatek-ge.c => mediatek/mtk-ge.c} (82%)
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

-- 
2.45.2


