Return-Path: <netdev+bounces-193006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D68AC2206
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9834C3AE6DA
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C9E22D7B7;
	Fri, 23 May 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a7fis9FR"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0285D8F0;
	Fri, 23 May 2025 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748000171; cv=none; b=XHiF6nC52k/S5Zs+ZnmhEOWt1LRvOaIeYlp19N5u6ThHFh1gTcNIqCH0uUiPEEvzwwgKzJPD77bjBy7FlrEOlFm7Pb8GmG/06leDYwK7sTS3RN1ONhISUAwx/7NGlQnepRBAF3tesLFNItPzQNBHRjOkwFkGrBtszMoVmLhIeY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748000171; c=relaxed/simple;
	bh=uXNU0NtsMBAb+zFHnNSWxwAJ193VCHniibeEdiXy4NM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ak5xDTIxIgfy5xORnHJXkI+ZTltt8vQ3W2xTgbzRX1IbBX6FfeHe6rxtW8WPx2HkbDRSpoUMFIQ0J9Atavb/JZ/gJigzmaBBtpeZJCD+bjvhOls21g2ZUtkmrY4N12U173kLw2E94kqUEcLlkPSb2FUTlaIJE+GDO87+rWXz/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=a7fis9FR; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1bf7466237ca11f082f7f7ac98dee637-20250523
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bpH39SBux/FnTvU2Mj/izFWlhWacqOVNUYyzk61rexs=;
	b=a7fis9FRrkmHg6cxiVXIDFOphGPXDIcxhvHWITARDHzV/QOkHFIHTOu29gvhD8o6vA2WE+utiCO7b/XQpLfiDgnUW6/L9ENMZeV23ZNJJ7iNQx2YYWHTFRyr+nb+wer9PEuLrMbzIobRFLLaf6xJMnLUP8GeaSQ3qkGBgU4u+/w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:b6088f32-e915-4281-9970-10dc072fc477,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:c029e757-abad-4ac2-9923-3af0a8a9a079,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1bf7466237ca11f082f7f7ac98dee637-20250523
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 524666907; Fri, 23 May 2025 19:36:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 23 May 2025 19:36:01 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 23 May 2025 19:36:01 +0800
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
CC: Sky Huang <skylake.huang@mediatek.com>
Subject: [PATCH net-next 0/2] Add LED support/fix to MediaTek 2.5Gphy & Gphy
Date: Fri, 23 May 2025 19:35:59 +0800
Message-ID: <20250523113601.3627781-1-SkyLake.Huang@mediatek.com>
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

This patchset adds LED support to MediaTek's built-in 2.5G phy, which
basically hooks the same helper function with built-in Gphy. Also, fix
LED behavior when blinking(delay_on & delay_off are both zero) is not set.

Sky Huang (2):
  net: phy: mtk-2p5ge: Add LED support for MT7988
  net: phy: mtk-ge-soc: Fix LED behavior if blinking is not set.

 drivers/net/phy/mediatek/mtk-2p5ge.c  | 104 ++++++++++++++++++++++++--
 drivers/net/phy/mediatek/mtk-ge-soc.c |   7 +-
 2 files changed, 103 insertions(+), 8 deletions(-)

-- 
2.45.2


