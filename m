Return-Path: <netdev+bounces-167647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666FCA3B51F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA04E17B0B9
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3921D7E5C;
	Wed, 19 Feb 2025 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PmF+4QxH"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31171CF5C0;
	Wed, 19 Feb 2025 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954365; cv=none; b=NcKhigZMCGMacW1y9dLfEuvmB1t/rJvnT5BmCk0L3O4mNn+0ZmGl1LnVjZMdPj6O2VMF4i8bP0evOhUj+QFNYPmxyeimOgScFhIH2ASWMoTBQ/nTu8lDojqn/5aM/spWhohAQuCCs0HiGmS8a5eQuYcutuEcqt5PEYyI6SZ/lqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954365; c=relaxed/simple;
	bh=uoIZMkZpsx3vJ0BSu2gWGlEhA5Y4RL6MyxKTTUnZ+ZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=arL2R3KrXZ2EVXjD9Suvddyphru7JbIgVIcGfRywCuEEfmC0gqnqNn7UK1AarkJp+wPcYZ7mbjMJr+XbTdH5dL/D7q9Yqm9ZiGjH0ICTzXE11H6tw/b9EFQ7q4+ir79aGWkcpk0dJpQ2SZLNm0Q9puJDXvUtAKY3YmT5TrgRk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PmF+4QxH; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ff04580eee9c11efaae1fd9735fae912-20250219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=M/94G8XwfehYGMeoQoABmIBqM/+UAgSwp1ee0Ztqu24=;
	b=PmF+4QxHUISPOw9gKJ6U3JSdLP0rHl9YjyHDio0xn+2IM+zYIRFlqZAg5LQ+DiIJer1VP0lUFbn88bhjZ3I8As7dYXrZpZ+7ETUoouJRuE/JigqHSVN+YyW11O29qKEoTJhnTRkXgLIOc2yZkIgqGde04z7H9y7aghnJzOB23rg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:2f87d65b-6c13-4e9b-9ac9-1163d31321b1,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:3ca612dc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: ff04580eee9c11efaae1fd9735fae912-20250219
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 204107481; Wed, 19 Feb 2025 16:39:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 19 Feb 2025 16:39:12 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 19 Feb 2025 16:39:12 +0800
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
Subject: [PATCH net-next v2 0/2] Add 2.5G ethernet phy support on MT7988
Date: Wed, 19 Feb 2025 16:39:07 +0800
Message-ID: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
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

This patchset adds support for built-in 2.5Gphy on MT7988,
corresponding dt-bindings and dts. It's based from previous commit:
https://patchwork.kernel.org/project/linux-mediatek/patch/20250116012159.
3816135-4-SkyLake.Huang@mediatek.com/

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
Change in v2:
- Add missing dt-bindings and dts node.
- Remove mtk_phy_leds_state_init() temporarily. I'm going to add LED support
later.
- Remove "Firmware loading/trigger ok" log.
- Add macro define for 0x800e & 0x800f
---
Sky Huang (3):
  net: phy: mediatek: Add 2.5Gphy firmware dt-bindings and dts node
  dts: mt7988a: Add built-in ethernet phy firmware node
  net: phy: mediatek: add driver for built-in 2.5G ethernet PHY on
    MT7988

 .../bindings/net/mediatek,2p5gphy-fw.yaml     |  37 ++
 MAINTAINERS                                   |   4 +-
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     |   6 +
 drivers/net/phy/mediatek/Kconfig              |  11 +
 drivers/net/phy/mediatek/Makefile             |   1 +
 drivers/net/phy/mediatek/mtk-2p5ge.c          | 346 ++++++++++++++++++
 6 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek,2p5gphy-fw.yaml
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c

-- 
2.45.2


