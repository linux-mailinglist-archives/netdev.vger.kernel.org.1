Return-Path: <netdev+bounces-165873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB05A3399A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792B63A5D4A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B3120B20E;
	Thu, 13 Feb 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q7v9Q4TR"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1703204C1E;
	Thu, 13 Feb 2025 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433963; cv=none; b=F/efLAQn1XjdIcypFyqVVb0zRid4m6YXXfiGfoKu0Mtr/WB818qAt6rp5lGrSQhJ6S7coAfmpONmAFLxaxvKYGymTrILEHmc1n2uFkVnYWJE41O/mGxsKL03doAtpcAnurclaSTxaZjaPGJsyyFM9Sj8jYOW1KW/n6gAEhM6mOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433963; c=relaxed/simple;
	bh=1qIISGiDU7YmvZo2knZ0BXhvTL7eD74tAQXTEnPD3tE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F67rNO+pD+21QMx+TKpqUOFAKRgIuDH3piTifvkcpTx4GBacESQJ6YR5MVB5+SlUmNiXYRgiJxswZ9sCUI/p9ri0Dgfdz62lfAAGqZORpgNKRIzqtjli4oRdVqOCUKJNWKqujDAZx53F4KEcpbZ2vYJGkUWxMdtFJ9WBDyM2e6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=q7v9Q4TR; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5ac43d46e9e111efb8f9918b5fc74e19-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZmAkLzA0ppT9ciqOn3hKY6nSAB9ytOhlS9TDTri4luo=;
	b=q7v9Q4TRLKWsP3E1FIi0jxskqwJFgAYiqbyZt9H0nj9mW/RJEWnDrIutIBQNOwSBWxIKUNXf30GN95enk/m0s79EPCzw4IDBugFLhsG08Fy8ETqGUhM7WAYXorpNay/VwLgDBz2YkIcdUwRgQPUTH44kSRf7M7o8lEoXRe6dzvQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:73d3ad06-2c53-485d-a036-3151b4cc4947,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:392c8227-6332-4494-ac76-ecdca2a41930,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 5ac43d46e9e111efb8f9918b5fc74e19-20250213
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1315383023; Thu, 13 Feb 2025 16:05:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 16:05:55 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 16:05:55 +0800
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
Subject: [PATCH net-next v2 0/5] net: phy: mediatek: Add token-ring helper functions
Date: Thu, 13 Feb 2025 16:05:48 +0800
Message-ID: <20250213080553.921434-1-SkyLake.Huang@mediatek.com>
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

This patchset add token-ring helper functions and moves some macros from
mtk-ge.c into mtk-phy-lib.c.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
Change in v2:
- Split the patch:
https://patchwork.kernel.org/project/linux-mediatek/patch/
20250116012159.3816135-2-SkyLake.Huang@mediatek.com/
into 4 patches
- Get rid of mtk-2p5ge.c patch temporarily so that this patchset can be
reviewed individually.
---
Sky Huang (5):
  net: phy: mediatek: Change to more meaningful macros
  net: phy: mediatek: Add token ring access helper functions in
    mtk-phy-lib
  net: phy: mediatek: Add token ring set bit operation support
  net: phy: mediatek: Add token ring clear bit operation support
  net: phy: mediatek: Move some macros to phy-lib for later use

 drivers/net/phy/mediatek/mtk-ge-soc.c  | 296 ++++++++++++++++---------
 drivers/net/phy/mediatek/mtk-ge.c      |  78 +++++--
 drivers/net/phy/mediatek/mtk-phy-lib.c |  77 +++++++
 drivers/net/phy/mediatek/mtk.h         |  15 ++
 4 files changed, 341 insertions(+), 125 deletions(-)

-- 
2.18.0


