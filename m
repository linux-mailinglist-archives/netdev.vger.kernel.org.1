Return-Path: <netdev+bounces-108087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2780191DD24
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9DF1C216D0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8D412C52E;
	Mon,  1 Jul 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ski3Pk9X"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860247F60;
	Mon,  1 Jul 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831270; cv=none; b=Eh6MkTk6xD/QFHNgN6sWXqUxrUFLw3Wa+6b7xQABP3v3iEuS40K9IJ51X827m+zhQ2C7eVRPo58p4unL7wB3y82HUppVy59LBr4k4OGMERsuEU+AjXd6iSyXpjNs7MFJEk+rNzz3WuCwjcCo/OEKGgkjhTjraUD+DF67YGkQDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831270; c=relaxed/simple;
	bh=ppjLdLHzuDEHm6NdeIXTJFSDTtTDjSGnoLGD+kUffWo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l2xYCUVrfdju7ReTH5qm+MHJDaLuBajPaCTSObBYJkzED4ZlesmicezNqL5qoKF5iM43gAzZIEHp6N/4XU6T53B/xW3Jc8pZH8TFSZLc6LyuVQF+HdDMvXGwlz+Xb6XEVsjvbJrsOnvkSJqLgXyYYLQNVuYV9YfjmYMHuSqClJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ski3Pk9X; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 44e862e6379811ef8b8f29950b90a568-20240701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gauL88KDzWToD5vjFViYG5yAMCDPPSVlJzlI5pS04mo=;
	b=Ski3Pk9XO7kE3sPWrg9jhcqnYPmsWQ3bZlu8qZ49cK8LaxAKm9XoTJ3n0FI+qJ6nCVc0ZHAGR7T34Uh5EU8X5aT9MJACAjcBx3N3Ogc+CKvVWsfd0lamTr+yl2xCWPgZ1VkRIvDGSqFvXbBTQsw08hbU7v53k+7fZSrekPbDl7Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:d6b3156c-a7df-4326-9e64-b7cf608949f4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:eef6c444-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 44e862e6379811ef8b8f29950b90a568-20240701
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2064660307; Mon, 01 Jul 2024 18:54:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 1 Jul 2024 18:54:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 1 Jul 2024 18:54:18 +0800
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
Subject: [PATCH net-next v10 00/13] net: phy: mediatek: Introduce mtk-phy-lib and add 2.5Gphy support
Date: Mon, 1 Jul 2024 18:54:04 +0800
Message-ID: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
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

Changes in v9:
[PATCH 03/13][PATCH 06/13][PATCH 11/13]
- Add mtk_phy_led_num_dly_cfg helper function to check led number & set
  delay on/off time.
[PATCH 07/13][PATCH 12/13]
- Remove "mt753x_phy_led_hw_is_supported," callback function hook in MT7530
  part of mtk-ge.c
[PATCH 09/13]
- Replace EEE1000_SELECT_SIGNEL_DETECTION_FROM_DFE with
  EEE1000_SELECT_SIGNAL_DETECTION_FROM_DFE. SIGNEL->SIGNAL.
[PATCH 11/13]
- Add MODULE_FIRMARE()
- Replace "MT7988_2P5GE_PMB" with "MT7988_2P5GE_PMB_FW" so we can recognize
  it literally.
- Remove unused macro names:
  1. BASE100T_STATUS_EXTEND
  2. BASE1000T_STATUS_EXTEND
  3. EXTEND_CTRL_AND_STATUS
  4. PHY_AUX_DPX_MASK

Changes in v10:
[PATCH 11/13]
- Move release_firmware() to correct position.
- Return ret directly in mt798x_2p5ge_phy_load_fw().
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
 drivers/net/phy/mediatek/mtk-2p5ge.c          | 432 +++++++++++
 .../mtk-ge-soc.c}                             | 693 ++++++++----------
 drivers/net/phy/mediatek/mtk-ge.c             | 243 ++++++
 drivers/net/phy/mediatek/mtk-phy-lib.c        | 450 ++++++++++++
 drivers/net/phy/mediatek/mtk.h                | 119 +++
 11 files changed, 1586 insertions(+), 532 deletions(-)
 delete mode 100644 drivers/net/phy/mediatek-ge.c
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
 rename drivers/net/phy/{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c} (73%)
 create mode 100644 drivers/net/phy/mediatek/mtk-ge.c
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

-- 
2.18.0


