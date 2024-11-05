Return-Path: <netdev+bounces-142006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C487E9BCF08
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9FE1F23725
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091E1D8DE2;
	Tue,  5 Nov 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P4nyIybG"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0C1D6DB9;
	Tue,  5 Nov 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816367; cv=none; b=Ykl29lG0XEnrlPjiP5tRnh6JTkdT/8/VsO2FL4dM1N/G83Ok6mJTdeu3hry0Lu0lxMLHSe846kWD1d3GQYtlBs2Giv8F9NNn09n4a90GlXRWnb6v829LbKWSLeOhQplxlIJwrUQinfwwRMZct94JkaQ6N/JkJvRWS6W9WxC/k/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816367; c=relaxed/simple;
	bh=BvzjOz1PN0LE/ByiE0yqTBlhHDwXhyVi4S8NWVzOKE8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kXWMIEROWQVJVOV1fOYngwwS6X9OC+1oJhpYxlJ5gx1q69SbuykOe9SsmXADqqINdwBwxYm+fvkIIwvi6scRH4d/uhDeyPc7ps1hOopB7KLyOJxrmr1RINNGmRL4agfpNLfE/hgM1Nmk5uP6Cvrp4bTNV2Hzo6jYQ/mzge7xp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=P4nyIybG; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f200b1089b8011efbd192953cf12861f-20241105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HBLsfZDP9XEHM79ztSmUAr63z/6xw7Kd0kuMacswMm0=;
	b=P4nyIybGLfxxN0YskyS2g11CBN7q3n0WdIGMc+5E5t7l+VLfigaNdLF69U1Tuh6/8k/Isgm/olzquSyLzWhwMjRwd+PDDRgKx9sf824xPFjOd1akAGO80ZXMo8tUJDOLHF+pwPtsH8OZ8N1x52e2qdXHQlTr9HoImFhxpKXYR/k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:694e092f-8841-40f4-912a-41c7cbe5b948,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:b6dc9507-7990-429c-b1a0-768435f03014,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: f200b1089b8011efbd192953cf12861f-20241105
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 920175025; Tue, 05 Nov 2024 22:19:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Nov 2024 22:19:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Nov 2024 22:19:17 +0800
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
Subject: [PATCH net-next v2 0/5] Re-organize MediaTek ethernet phy drivers and propose mtk-phy-lib
Date: Tue, 5 Nov 2024 22:19:06 +0800
Message-ID: <20241105141911.13326-1-SkyLake.Huang@mediatek.com>
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
 drivers/net/phy/mediatek/Kconfig              |  26 ++
 drivers/net/phy/mediatek/Makefile             |   4 +
 .../mtk-ge-soc.c}                             | 298 ++----------------
 .../phy/{mediatek-ge.c => mediatek/mtk-ge.c}  |  31 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c        | 270 ++++++++++++++++
 drivers/net/phy/mediatek/mtk.h                |  89 ++++++
 9 files changed, 437 insertions(+), 307 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 rename drivers/net/phy/{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c} (83%)
 rename drivers/net/phy/{mediatek-ge.c => mediatek/mtk-ge.c} (82%)
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

-- 
2.45.2


