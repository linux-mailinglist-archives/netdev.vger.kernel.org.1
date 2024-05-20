Return-Path: <netdev+bounces-97181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1E8C9C1F
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B431C21B9C
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 11:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C06535B8;
	Mon, 20 May 2024 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fCgfjmhn"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495D468E;
	Mon, 20 May 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716204918; cv=none; b=nFTeoMMlx7GiLi3EcvzYZZjn6yj7BAA+qq/SGBEvTO4QUZrSbuTBAyuOUedOcgeJ8DPveUeDNG5h5QtDJSHFaN+ggJhiEjiV6L3MvNTGXRz7EYmsJa+SgTuEs9m82YJc0P1VEeXQe0HsGlRy7BJQagXQ7CSewfQcUO79rn5Vpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716204918; c=relaxed/simple;
	bh=pKP8NOt65mH4AFG5qSydk0KnrJeSEyCWy72smZCql5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M33IBfEe9agbc9ZwaTs7R1Q+IgN4vkLFuQOeop9IkpELCzh3ygngJhptdGS6muDxfr715ZrDsu/Tt7dfbSkiN5HVsPc4H12AqzRET3fxz2k4pihFAKQKCWC3ARB2gZu+Uh8FZhMRjdnEysci+6+ed+rJ23AIoB+62a/xEVbk+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fCgfjmhn; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 01737242169d11ef8065b7b53f7091ad-20240520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=41BoO/0oSNU14FXHAgFu9sgOALvaX/cVdFsNjBnzhvU=;
	b=fCgfjmhnRipGiA/N8GqkQuC7Tu0q7+IuiICkiAGvY3C2MM16/PtBYEvY8yatYbJ/nN0XcWP+SC7MOF8fmZz4Zlni7Vyc33Ecga1ZBEaSeYV/6qtWcTEq8dCv7fTkuQBiIxQtpqlZp+eNg5hE0YndsyYWvtCHMVtuCE51h64O6sM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:1689790c-013c-42d0-b33d-c7f2c99fd0c7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:9b30fb92-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 01737242169d11ef8065b7b53f7091ad-20240520
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1750447997; Mon, 20 May 2024 19:35:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 May 2024 19:35:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 May 2024 19:35:03 +0800
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
Subject: [PATCH net-next v3 0/5] net: phy: mediatek: Introduce mtk-phy-lib and add 2.5Gphy support
Date: Mon, 20 May 2024 19:34:51 +0800
Message-ID: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.424200-8.000000
X-TMASE-MatchedRID: 4fFTSfMxvyafF/fARRyav1z+axQLnAVBy1QrRDj0t5k0QmmUihPzrBt2
	yH4n8B60waC5iVSuufM2WW7gEIXLDSoLG8HLfjNfR/j040fRFpJMjQ19j30wyd9RlPzeVuQQRfq
	h9aVhZzMspKJBx9J3JAaPhd2pC2rRDPIzF4wRfrAURSScn+QSXt0H8LFZNFG7CKFCmhdu5cWA3Z
	lveDUmFMPsg8ixjBz19/+I3qb6/Tl6Sfnd7oraJIFwZy1JJ1gdpkIdIQjCyPS1EhpDMa3ec4RLY
	jIoobSxpJffzNbU/bEXRoPmWO3jekxwdkPqCq7vDEyN+J8hd+jCS9WgDXVPCp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.424200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7FC075519B7CEA76510A47A21B12332DFE29F04406F82C8AAE198775C7738F382000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

Re-organize MTK ethernet phy drivers and integrate common manipulations
into mtk-phy-lib. Also, add support for build-in 2.5Gphy on MT7988.

v2:
- Apply correct PATCH tag.
- Break LED/Token ring/Extend-link-pulse-time features into 3 patches.
- Fix contents according to v1 comments.

v3:
- Fix patch 4/5 & 5/5 according to v2 comments.
- Rebase code and now this patch series can apply to net-next tree.

SkyLake.Huang (5):
  net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
  net: phy: mediatek: Move LED and read/write page helper functions into
    mtk phy lib
  net: phy: mediatek: Add token ring access helper functions in
    mtk-phy-lib
  net: phy: mediatek: Extend 1G TX/RX link pulse time
  net: phy: add driver for built-in 2.5G ethernet PHY on MT7988

 MAINTAINERS                                   |   7 +-
 drivers/net/phy/Kconfig                       |  17 +-
 drivers/net/phy/Makefile                      |   3 +-
 drivers/net/phy/mediatek-ge.c                 | 111 ----
 drivers/net/phy/mediatek/Kconfig              |  38 ++
 drivers/net/phy/mediatek/Makefile             |   5 +
 drivers/net/phy/mediatek/mtk-2p5ge.c          | 398 +++++++++++++
 .../mtk-ge-soc.c}                             | 528 ++++++------------
 drivers/net/phy/mediatek/mtk-ge.c             | 244 ++++++++
 drivers/net/phy/mediatek/mtk-phy-lib.c        | 377 +++++++++++++
 drivers/net/phy/mediatek/mtk.h                | 108 ++++
 11 files changed, 1358 insertions(+), 478 deletions(-)
 delete mode 100644 drivers/net/phy/mediatek-ge.c
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
 rename drivers/net/phy/{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c} (77%)
 create mode 100644 drivers/net/phy/mediatek/mtk-ge.c
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

-- 
2.18.0


