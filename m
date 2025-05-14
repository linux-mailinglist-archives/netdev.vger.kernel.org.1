Return-Path: <netdev+bounces-190375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D04A7AB6946
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104743B3C0D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663F270ECD;
	Wed, 14 May 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r9Mau5Q0"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B620F079;
	Wed, 14 May 2025 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220272; cv=none; b=UmZGYdcp1HtYbWYITEOrc45Fjrq1PRrGFQkJP6txn8YIb0i3KSHi+JTFkQW9Touf8IbzsO5b/BRRwQOvmKXR7YJ+a4DLLyfIh/y/RxddC4c3ZyJTBgu+gCsyw/uVFpdvFnNwd0TDaoEzNxKVuKoaKCHhNQ6iVVIxR0vWJc0zd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220272; c=relaxed/simple;
	bh=v3UaeziQ9iWm0SzOtTXjOYc6QJZ7OWv9cuGAmZwuNeY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HmP9PPeXqAj3JSrOveJmIdGv5ElCnTfY4j1Kc/tdvwDR4OYrcktLYa1zckJBBxeVSsTXkDp/KQZ8f9W5ks4vX5Chnm02byTIT8yTbUfUW3zvkBotkuk49x5sBlvYmgsi2oj0pXhmB3U1u6C+mXh36SW9S1C2pMiYmdX3vNsSbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r9Mau5Q0; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 43292bfc30b211f082f7f7ac98dee637-20250514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=t5BczD62lnpqa0ma5zM61wuTG/WMMoKoipb4gYjC294=;
	b=r9Mau5Q0bJsLSbLlhJgW2UZhJEtiBHhccw7mTkCherPwXVB90XbuwgmENiBTHNUXx/gkg0OAU4DnJGNg+sfD5oc4cWCLvxDbvbc0wjE1a9HQwOVFmPA/CB4Lu1sHdPZw6sKt9ZWsIGz0iADk3f9KRyK4VK1E/doqeS9ZES3kq6s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:809faf4b-1fc8-4a1a-a400-e60a63a3bdbe,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:dc1bc173-805e-40ad-809d-9cec088f3bd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 43292bfc30b211f082f7f7ac98dee637-20250514
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1662059587; Wed, 14 May 2025 18:57:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 14 May 2025 18:57:41 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 14 May 2025 18:57:41 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	balika011 <balika011@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, Sky Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v3 0/2] Add built-in 2.5G ethernet phy support on MT7988
Date: Wed, 14 May 2025 18:57:36 +0800
Message-ID: <20250514105738.1438421-1-SkyLake.Huang@mediatek.com>
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

This patchset adds support for built-in 2.5Gphy on MT7988, change file
and config sequence in related Kconfig and Makefile.

---
Change in v2:
- Add missing dt-bindings and dts node.
- Remove mtk_phy_leds_state_init() temporarily. I'm going to add LED support
later.
- Remove "Firmware loading/trigger ok" log.
- Add macro define for 0x800e & 0x800f

Change in v3:
1. Remove unnecessary headers and unnecessary print log.
2. ioremap IO space (MT7988_2P5GE_PMB_FW_BASE/MTK_2P5GPHY_MCU_CSR_BASE)
directly instead of of_iomap() compatible node (mediatek,2p5gphy-fw) from dtsi
3. Call mt798x_2p5ge_phy_load_fw() from .probe instead of .config_init. This is
tested ok with openWRT-24.10 and "mediatek/mt7988/i2p5ge-phy-pmb.bin" firmware
is embedded into kernel image instead of rootfs image.
4. Use request_firmware_direct instead of request_firmware. We don't want sysfs
fallback in this driver to avoid blocking.
5. Remove mtk_i2p5ge_phy_priv sturct since it's not used anymore.
---
Sky Huang (2):
  net: phy: mediatek: Sort config and file names in Kconfig and Makefile
  net: phy: mediatek: add driver for built-in 2.5G ethernet PHY on
    MT7988

 MAINTAINERS                          |   1 +
 drivers/net/phy/mediatek/Kconfig     |  31 ++-
 drivers/net/phy/mediatek/Makefile    |   3 +-
 drivers/net/phy/mediatek/mtk-2p5ge.c | 322 +++++++++++++++++++++++++++
 4 files changed, 346 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c

-- 
2.45.2


