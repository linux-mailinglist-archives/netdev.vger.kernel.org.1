Return-Path: <netdev+bounces-105694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0206C912506
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A7C1C20C85
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B427D14F9EF;
	Fri, 21 Jun 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sEANFxcH"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17428399;
	Fri, 21 Jun 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972455; cv=none; b=qUyT5JqFcvwLsiqo4O5KZ2cKjGzwvsPNELSxaHvxpVWzlKHOkRXSvFO7pWv0jwes7KK3cU5WPtiKfFC6zH+Puq4KcbFNoObZbpkwTlGQZdIn+JFAsBIk6zEGjgP5wdHQo8f3pqOR9pfi3ygj3Bf+5aiubq+xo5w1kvXUj1hW6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972455; c=relaxed/simple;
	bh=dQoOlj8Bz8XBhC4T6rNLpKthfWKOWdiWW4Kw5zR7cIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H8Utp2gPGNQn3tEVfqqCLuKf+I0S/qVSSREbI5guUrSKcYXfCNLr5RVAvg3JwviIuigQRTfUKtUG4VRh0Nj5+Qf5Qh1LR8ktM9LgV3187NH8O8WYWMUELlduwL4Xkp4MKBPs35ZTj/2pQY+T0jPxOyj+vPRe8cv0voCYCLtxGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sEANFxcH; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b197fa002fc811ef99dc3f8fac2c3230-20240621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hNmF01T9unLy963u5HNbA6cknYUNnZWmn0zV8aZMrFo=;
	b=sEANFxcHsdl7woom886eqrNcnSxC4LarvDDngTNsyoRy9fOk5p6Ub+qlx51QM2ziP7AX7viQBitiwte3LEEQWgrlOioKr1q51gj/v4ATUf78Lf9ZqvwKrNyB1nbdSq2zkxb7ti8r555qM6H5t8SO1BfVmjnp5MzQ4xgMB5JFaE8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:e6689d74-c25b-4bce-9371-70b0d4bb6992,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:30e85f85-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b197fa002fc811ef99dc3f8fac2c3230-20240621
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 883874129; Fri, 21 Jun 2024 20:20:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jun 2024 20:20:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jun 2024 20:20:46 +0800
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
Subject: [PATCH net-next v8 00/13] net: phy: mediatek: Introduce mtk-phy-lib and add 2.5Gphy support
Date: Fri, 21 Jun 2024 20:20:32 +0800
Message-ID: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.234600-8.000000
X-TMASE-MatchedRID: bM2zebKlBHuGeTbGWdRz1qUebN0FQAbYvtVce6w5+K9xUZeguPBDQcbK
	+pu0ZYwR6NJ1g8TkaiY/4sXBdVnb/U2VnXMRzIBj4bl1FkKDELchotH7bEpEMmecrqZc3vabN1L
	b3d91KD/symnxq9L1AixzufF6vmDubw8f/jlV5scdxBAG5/hkW1sChor7BLiN10wPNIuvyi/Akt
	gDJtZ0AmMl2fVuI+54nGl+g77/qoc/REwOA9OGte7KTDtx8CggLE3mrqeLTCsOUs4CTUgKy0MHU
	R1yMHZ62JwKrFIIzlEaMs2ZphvTvQRCoiooUu1OlGudLLtRO1uJR25cPm3I20a+7cKvw60WZvo+
	mFW19mCeBkpYbYReF1XT0RXHi3kTDPIzF4wRfrAURSScn+QSXq0hbOeGOMG1+gtHj7OwNO1zbSW
	8HZ+hqOCO+cVwqp0PHpCnHOrKy+PYIygoI/7U3assTEHFLGNoVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.234600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DBA03053F6AECD7387BA6EBFC4F063D130442F5D1CB6F12AB8978352E54603EE2000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch series integrate MediaTek's built-in Ethernet PHY helper functions
into mtk-phy-lib and add more functions into it. Also, add support for 2.5Gphy
on MT7988 SoC.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
Changes in v2:
- Apply correct PATCH tag.
- Break LED/Token ring/Extend-link-pulse-time features into 3 patches.
- Fix contents according to v1 comments.

Changes in v3:
- Rebase code and now this patch series can apply to net-next tree.
[PATCH 4/5]
Refactor mtk_gphy_cl22_read_status() with genphy_read_status().
[PATCH 5/5]
1. Add range check for firmware.
2. Fix c45_ids.mmds_present in probe function.
3. Still use genphy_update_link() in read_status because
genphy_c45_read_link() can't correct detect link on this phy.

Changes in v4:
[PATCH 4/5]
1. Change extend_an_new_lp_cnt_limit()'s return type and all return values
2. Refactor comments in extend_an_new_lp_cnt_limit()
[PATCH 5/5]
1. Move firmware loading function to mt798x_2p5ge_phy_load_fw()
2. Add AN disable warning in mt798x_2p5ge_phy_config_aneg()
3. Clarify the HDX comments in mt798x_2p5ge_phy_get_features()

Changes in v5:
- Fix syntax errors of comments in drivers/net/phy/mediatek/*
[PATCH 1/5]
- Change MEDIATEK_GE_SOC_PHY from bool back to tristate.
[PATCH 5/5]
1. Move md32_en_cfg_base & pmb_addr to local variables to achieve
symmetric code.
2. Print out firmware date code & version.
3. Don't return error if LED pinctrl switching fails. Also, add
comments to this unusual operations.
4. Return -EOPNOTSUPP for AN off case in config_aneg().

Changes in v6:
- Re-arrange patch and changes description in cover letter.
- Contraint code inside 80 columns wide.
[PATCH 4/5]
1. Add LP_DETECTED so extend_an_new_lp_cnt_limit() won't be called every
time we poll the PHY for its status. It'll be called only when cable is
plugged in and 1G training starts.
2. Call phy_read_paged() instead of calling phy_select_page() &
phy_restore_page() pair.
[PATCH 5/5]
1. Force casting (fw->data + MT7988_2P5GE_PMB_SIZE - 8) with __be16.
2. Remove parens on RHS of "phydev->c45_ids.mmds_present |=".
3. Add PHY_INTERFACE_MODE_INTERNAL check in
mt798x_2p5ge_phy_get_rate_matching()
4. Arrange local variables in reverse Xmas tree order.

Changes in v7:
[PATCH 5/5]
1. Add phy mode check(PHY_INTERFACE_MODE_INTERNAL) in config_init().
2. Always return RATE_MATCH_PAUSE in get_rate_matching().

Changes in v8:
- Make sure that each variables in drivers/net/phy/mediatek/* follows reverse
Xmas tree order.
- Split v7 patches in this way:
[PATCH net-next v7 1/5] net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
  -> [PATCH net-next v8 01/13] net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
  -> [PATCH net-next v8 02/13] net: phy: mediatek: Fix spelling errors and rearrange variables
[PATCH net-next v7 2/5] net: phy: mediatek: Move LED and read/write page helper functions into mtk phy lib
  -> [PATCH net-next v8 03/13] net: phy: mediatek: Move LED helper functions into mtk phy lib
  -> [PATCH net-next v8 04/13] net: phy: mediatek: Improve readability of mtk-phy-lib.c's mtk_phy_led_hw_ctrl_set()
  -> [PATCH net-next v8 05/13] net: phy: mediatek: Integrate read/write page helper functions
  -> [PATCH net-next v8 06/13] net: phy: mediatek: Hook LED helper functions in mtk-ge.c
  -> [PATCH net-next v8 07/13] net: phy: mediatek: add MT7530 & MT7531's PHY ID macros
  -> [PATCH net-next v8 08/13] net: phy: mediatek: Change mtk-ge-soc.c line wrapping
[PATCH net-next v7 3/5] net: phy: mediatek: Add token ring access helper functions in mtk-phy-lib
  -> [PATCH net-next v8 09/13] net: phy: mediatek: Add token ring access helper functions in mtk-phy-lib
[PATCH net-next v7 4/5] net: phy: mediatek: Extend 1G TX/RX link pulse time
  -> [PATCH net-next v8 10/13] net: phy: mediatek: Extend 1G TX/RX link pulse time
[PATCH net-next v7 5/5] net: phy: add driver for built-in 2.5G ethernet PHY on MT7988
  -> [PATCH net-next v8 11/13] net: phy: add driver for built-in 2.5G ethernet PHY on MT7988
- Create another 2 patches to:
  - fix alignment in callback functions declarations in mtk-ge.c & mtk-ge-soc.c
  - Remove unnecessary outer parens of "supported_triggers" var
- Replace token ring API, tr* & __tr* with mtk_tr* & __mtk_tr* and fix
alignment.
---
SkyLake.Huang (13):
  net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
  net: phy: mediatek: Fix spelling errors and rearrange variables
  net: phy: mediatek: Move LED helper functions into mtk phy lib
  net: phy: mediatek: Improve readability of mtk-phy-lib.c's
    mtk_phy_led_hw_ctrl_set()
  net: phy: mediatek: Integrate read/write page helper functions
  net: phy: mediatek: Hook LED helper functions in mtk-ge.c
  net: phy: mediatek: add MT7530 & MT7531's PHY ID macros
  net: phy: mediatek: Change mtk-ge-soc.c line wrapping
  net: phy: mediatek: Add token ring access helper functions in
    mtk-phy-lib
  net: phy: mediatek: Extend 1G TX/RX link pulse time
  net: phy: add driver for built-in 2.5G ethernet PHY on MT7988
  net: phy: mediatek: Fix alignment in callback functions' hook
  net: phy: mediatek: Remove unnecessary outer parens of
    "supported_triggers" var

 MAINTAINERS                                   |   7 +-
 drivers/net/phy/Kconfig                       |  17 +-
 drivers/net/phy/Makefile                      |   3 +-
 drivers/net/phy/mediatek-ge.c                 | 111 ---
 drivers/net/phy/mediatek/Kconfig              |  38 +
 drivers/net/phy/mediatek/Makefile             |   5 +
 drivers/net/phy/mediatek/mtk-2p5ge.c          | 436 +++++++++++
 .../mtk-ge-soc.c}                             | 682 ++++++++----------
 drivers/net/phy/mediatek/mtk-ge.c             | 249 +++++++
 drivers/net/phy/mediatek/mtk-phy-lib.c        | 434 +++++++++++
 drivers/net/phy/mediatek/mtk.h                | 117 +++
 11 files changed, 1575 insertions(+), 524 deletions(-)
 delete mode 100644 drivers/net/phy/mediatek-ge.c
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
 rename drivers/net/phy/{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c} (73%)
 create mode 100644 drivers/net/phy/mediatek/mtk-ge.c
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

-- 
2.34.1


