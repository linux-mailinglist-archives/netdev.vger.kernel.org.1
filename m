Return-Path: <netdev+bounces-190995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C0AB9A08
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4467A1C03
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FAD233140;
	Fri, 16 May 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A4GHYsis"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE021ABDA;
	Fri, 16 May 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391021; cv=none; b=YyHuTR1/7VYBQsvH6kc5YxduBEl0whXr3ZUM2roNCgsJdEExtiY6/wBiCqw6GapWQhI2LeCo+RRfscRbODhLmTxLg9jizI4tLPCeDJBMS3y/kIfRXTKDQC/cwQi2TN/N6U0LW+zEK9TNgM43GNGtpdEvmjxZVWtGujZwyl+EhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391021; c=relaxed/simple;
	bh=AiPFTaJrhAiGkYXJX72S5B/ZRNWocm/sW3wwau58c4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ogtX8BxpwJ2yncrhJvMV/j1rQANKD3TO6n9XaLL1tbYWYq6nC5a1Vvy22EA+bYFr0hIGYLryzYwkivheFL8LYhRrN7zOg/jA4z/rifWDJYdwT/eWTMvQOzrqnXNwESOx/sNSiDubbteaJLla6OvGnMSh6bmt6YmVOT46A0qECr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=A4GHYsis; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d0da6586323f11f082f7f7ac98dee637-20250516
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5cquuIZpHytMyZf4vzmIyMUUPn8YhG4lR+d2ACxt+Cc=;
	b=A4GHYsishyCXFURaxdQg4Fs7SKj5vbuB8Xazt8y/RIacgoLthR6Fjx5k6Aq5cH6GfgkmxFLjvvdjR1UlRflBxX1R0UoZWMQE5gBrP7xYg1pi38Dd0cqBsksIXtQXNEO8ND+Qwb5i2JrqOHLHEUD0p4hug2o7zW1VbcCiBavbrZU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:12c7237f-0290-4f06-bb2a-75c9c95fd092,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:acfdcd97-7410-4084-8094-24619d975b02,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d0da6586323f11f082f7f7ac98dee637-20250516
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 941995746; Fri, 16 May 2025 18:23:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 16 May 2025 18:23:30 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 16 May 2025 18:23:30 +0800
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
CC: Steven Liu <Steven.Liu@mediatek.com>, Sky Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v4 0/2] Add built-in 2.5G ethernet phy support on MT7988
Date: Fri, 16 May 2025 18:23:25 +0800
Message-ID: <20250516102327.2014531-1-SkyLake.Huang@mediatek.com>
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

This patchset adds support for built-in 2.5Gphy on MT7988, sort file
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

Change in v4:
1. Sort file and config in alphabetical order.
2. Remove unncessary parens around macros.
3. Arrange vars in reversed Christmas tree.
4. Move LED settings and pinctrl request to .probe to avoid
managed-dev structure reallocation.
5. Replace "return __genphy_config_aneg(phydev, changed);" with
"return genphy_c45_check_and_restart_aneg(phydev, changed);" in
mt798x_2p5ge_phy_config_aneg()
---
Sky Huang (2):
  net: phy: mediatek: Sort config and file names in Kconfig and Makefile
  net: phy: mediatek: add driver for built-in 2.5G ethernet PHY on
    MT7988

 MAINTAINERS                          |   1 +
 drivers/net/phy/mediatek/Kconfig     |  15 +-
 drivers/net/phy/mediatek/Makefile    |   3 +-
 drivers/net/phy/mediatek/mtk-2p5ge.c | 321 +++++++++++++++++++++++++++
 4 files changed, 337 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c

-- 
2.45.2


