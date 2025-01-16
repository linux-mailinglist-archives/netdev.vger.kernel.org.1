Return-Path: <netdev+bounces-158709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057A1A130B2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AEC81888CC2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 01:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE32282F0;
	Thu, 16 Jan 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TJPeFUJy"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774366F30C;
	Thu, 16 Jan 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990532; cv=none; b=oUOy6uhm9f1eswX6c82AmOW7+2TQ9ujC662be01VTtbCRuewflJARpu3PsB+L1q3tAuvVKkSw5Em0VYqBrCJwHOTopLh4mQzcCB29KB9G04+QFIgAw4LoeRFXNw/y3/m4WYtItJQhZH6LMQvnpHXTCev0nvzsdlBvU+8Tz/BUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990532; c=relaxed/simple;
	bh=YQEP35h+FkVcMOLGZdxS33flgeaOs4uF4dJ+h/eHPLU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lc0EY98/b85Ao7/MfEUEqYw9Kg/tk+Mr5gyTlSGlD20EFH902rRZU/ud10OzxyzqPYMdNhTd4hOO3HD7VaRcvz/x4NWtWdA+K5XCnjp2TFEP6QkuWJlw+0GFrceLWUc8LUMTd8kOMNEu4K73ReJVKEjbaWvlBRkaZA19hnws4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TJPeFUJy; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 49a08276d3a811efbd192953cf12861f-20250116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eSHmQM8NATK6SZ+a/IRk6MOrqMnMNmxZlWOSIrLuWAw=;
	b=TJPeFUJyRE3CSIis570PGm9UUWgBBlSpSYSrpOBnFhsrus2ODSILJ6lxTwN6EZqSSvUqzTIkvsY2d7kpZcEf+LP2adTN3WwxFRD5OguSY7oTZ64uwMs3ecbrr8zdsBK75hkY3+DzwjMaQ8FviR0LT4kWNLnBi4NRlA4PEFYBFfg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:cd1acd00-8274-41e8-b6b1-c79d0d92de5e,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:0c95f50e-078a-483b-8929-714244d25c49,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1|19,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 49a08276d3a811efbd192953cf12861f-20250116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 266821136; Thu, 16 Jan 2025 09:22:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 Jan 2025 09:22:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 16 Jan 2025 09:22:00 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Simon
 Horman" <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, Sky Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next 0/3] net: phy: mediatek: Add token-ring ops
Date: Thu, 16 Jan 2025 09:21:55 +0800
Message-ID: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.45.2
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

This patchset add token-ring ops and moves some macros from mtk-ge.c
into mtk-phy-lib.c. Also, MediaTek's built-in 2.5Gphy driver is added.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
Sky Huang (2):
  net: phy: mediatek: Move some macros to phy-lib for later use
  net: phy: mediatek: add driver for built-in 2.5G ethernet PHY on
    MT7988

SkyLake.Huang (1):
  net: phy: mediatek: Add token ring access helper functions in
    mtk-phy-lib

 MAINTAINERS                            |   1 +
 drivers/net/phy/mediatek/Kconfig       |  11 +
 drivers/net/phy/mediatek/Makefile      |   1 +
 drivers/net/phy/mediatek/mtk-2p5ge.c   | 343 +++++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk-ge-soc.c  | 297 +++++++++++++--------
 drivers/net/phy/mediatek/mtk-ge.c      |  78 ++++--
 drivers/net/phy/mediatek/mtk-phy-lib.c |  91 +++++++
 drivers/net/phy/mediatek/mtk.h         |  17 ++
 8 files changed, 714 insertions(+), 125 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c

-- 
2.45.2


