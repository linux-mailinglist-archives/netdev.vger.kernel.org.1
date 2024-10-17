Return-Path: <netdev+bounces-136389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 848FB9A1946
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 05:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0487DB23392
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956141C6C;
	Thu, 17 Oct 2024 03:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A9tS89uK"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634B8F6C;
	Thu, 17 Oct 2024 03:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729135348; cv=none; b=Evqi95gK+r7DFcI9P8S0EST2V9iVOpvXwUzvhEa/qXl/YU2Oe5xMRKRiAU1/BzuMclLThfVHrAeCkYRHvNspjw9osbwVR6yGT0J13drUOtUDvrNZQyXJJzZJrEDZfJvJza4+J+hYUpizVrpDYIJcCS1OxTZiSqGVV7c1QkUC890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729135348; c=relaxed/simple;
	bh=+FfOI+6NdKQeHVzhoSsNoT6JFv7rnLMQOOT6MbdQ/xc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WFESSWBBtllGLKkRmrC1c4Ao8s9IDW4nFtz0B6H83ibuwKypBBdbNVuwviFOV2DMBBnI2N2i6mYhLSXa7aPqn7S+Id+infrNijXcEgftPXVvmjVSD5HEiDPx1gp/drpCn50kFX1CytdxIswRe5y427/X9PBwdQhPySFMjMBM3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=A9tS89uK; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 040e814e8c3711efbd192953cf12861f-20241017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xEZ+LwBUCV79LCq35La2F6jUeHl/a28MFnYkiN7pkkQ=;
	b=A9tS89uKRi1DuY0tMXKh5a4818i3z7gSqxPJUzNXAZ2HgrREmYEZ+JfUuC7J3qG4Jo2BJF4hmFy5JR6SfXGskdDrLgP2bUodabWbq2LOkxBdRkdNeoiR8qN2sYvTeSeIHn3Cm7Qrw1ie5KgiocXtBkP8nVdk4QmlPlYMhv9gAgg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:258c7b4d-646b-469c-81a6-5e2c3b935365,IP:0,U
	RL:0,TC:0,Content:41,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:41
X-CID-META: VersionHash:6dc6a47,CLOUDID:6bac6241-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 040e814e8c3711efbd192953cf12861f-20241017
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 477280595; Thu, 17 Oct 2024 11:22:19 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Oct 2024 11:22:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Oct 2024 11:22:15 +0800
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
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v2 0/3] net: phy: Refactor mediatek-ge-soc.c for clarity and correctness
Date: Thu, 17 Oct 2024 11:22:10 +0800
Message-ID: <20241017032213.22256-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.424900-8.000000
X-TMASE-MatchedRID: NJitR9TboxyxxK6sBu9wbjPDkSOzeDWWpmFKNfn3zvqvloAnGr4qhgsp
	V4Rw6UcDTyYk6EbjbakrQIMF24cmclxxDx5qbkR9FEUknJ/kEl5jFT88f69nG/oLR4+zsDTt9xS
	3mVzWUuCMx6OO8+QGvo0CcEBNsKjT7Jh/mb/5GwpZ2gLfD/Jnn00q3uacyXFBeAj59SFC260HRR
	KnqfqqUZkyQcsvHZ56x8NgR4aMEWtB+RoVxwyzrnmVKZusLp922v9OjYWA2uMMswg45VMfPadst
	5iAforfVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.424900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DDE2CE34B4A85491DA0C020F95E0AF2C4B528F136A20B9556CB3D39366A7E3E12000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch is derived from patch 8/9 of Message ID:
20241004102413.5838-9-SkyLake.Huang@mediatek.com.
This patch does some simple clean-ups, however, this is necessary
because the rest patches in
"20241004102413.5838-9-SkyLake.Huang@mediatek.com" rely on this.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
Changes in v2:
Split into 3 patches for reviewing.
---
SkyLake.Huang (3):
  net: phy: mediatek-ge-soc: Fix coding style
  net: phy: mediatek-ge-soc: Shrink line wrapping to 80 characters
  net: phy: mediatek-ge-soc: Propagate error code correctly in
    cal_cycle()

 drivers/net/phy/mediatek-ge-soc.c | 169 ++++++++++++++++++++----------
 1 file changed, 112 insertions(+), 57 deletions(-)

-- 
2.45.2


