Return-Path: <netdev+bounces-140333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3BD9B604A
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3438DB2324D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E281E3779;
	Wed, 30 Oct 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KBWd1fxi"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207DE1E2016;
	Wed, 30 Oct 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284566; cv=none; b=Ob6OFkPfMoBhJDLLIiDFLJZ+yhZpdZveRVxG/IEyThe6WKoQESj3zusbF8JtmFEo5LeWmmb65iBlMz7c6uAZ1inmMFrnORsDcOHbExxvlHzd9x4c9JBXRWragDb55xxGcxcH46yAZVPc9qdtyEk+QHBSlIOZLIowYRCR7FNToXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284566; c=relaxed/simple;
	bh=U+REpOqvLjENyA0XU1vPiQWu1XnEWzydVJhUPOOIkuU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=clwg8QOdkJx9hJt1Prwi0JRwEwxnuan+zfKNM+U7ZXo2/h2+g7wUctDZ4zscfU2M14bKJLVcPDdkYNRjimZ8wiXJaLHnGCQqytHubywVU/3++5sZr8axf4zvJAsrGG6D1wgR9sJLZTgUOed5qxYdnc1x1mmjRi+aHeQZnM+5cPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KBWd1fxi; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c009435c96aa11efb88477ffae1fc7a5-20241030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PMCqO+Kb6KUAaZnkRTfDMbBZG7qEWSk59mysfqC4sPA=;
	b=KBWd1fxikSDUho47LLeCjSPvZrin22+5dJPBlNON2gd2JbbR6x1bY8uF1793FgAao5cRg/ViFcg1W3//s7lxJFFV7HgfDii4rof1gpZh/8gxUroNQuTUY2M7rgUokWucDHdhkS8Wwqs95eJq9gf3iypDl/bVtV//CpDN+88N4KY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:d6ff2fb4-6340-4715-8a5c-4492f5968784,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:4b054807-7990-429c-b1a0-768435f03014,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: c009435c96aa11efb88477ffae1fc7a5-20241030
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1329595114; Wed, 30 Oct 2024 18:35:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Oct 2024 03:35:57 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 30 Oct 2024 18:35:56 +0800
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
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next 0/5] Re-organize MediaTek ethernet phy drivers and propose mtk-phy-lib
Date: Wed, 30 Oct 2024 18:35:49 +0800
Message-ID: <20241030103554.29218-1-SkyLake.Huang@mediatek.com>
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

This patchset comes from patch 1/9, 3/9, 4/9, 5/9 and 7/9 of:
https://lore.kernel.org/netdev/20241004102413.5838-1-SkyLake.Huang@mediatek.com/

This patchset changes MediaTek's ethernet phy's folder structure and
integrates helper functions, including LED & token ring manipulation,
into mtk-phy-lib.

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


