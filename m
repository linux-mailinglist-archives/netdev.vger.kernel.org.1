Return-Path: <netdev+bounces-245538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09269CD076C
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E43CC300975D
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8F433B6D7;
	Fri, 19 Dec 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="wm0IoaIm"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166633ADB1;
	Fri, 19 Dec 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157157; cv=none; b=civeuxTMF0Bxo+mJoHaK2Qmo6ocCfGMGrVicuMsV8q0SmckFtGmOEOUP1Jz+ri5h8Spjl5YxOu9U1eHdiXyl5li2EpQd1Htz14ew6DGUd26NofIsvUsFUcshAGxycLSeKf9euqS14tFw6EX6B+Qylt1z0BnRaxxdznAzJH0ws4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157157; c=relaxed/simple;
	bh=Q6dvS6rLa9zTnZWky3/oPcsYtbgYMyEXzeIJULhzMZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNO5zZsTsemZtA5tlT6M7k8ZtRYOzO+8aUxMh2oghBipBC6SViB1jOpPINqDiSNSeAoFvwlCnerx0vh1wV5knbBE2xQgrEO3pNQyjAzwpmMahxuLGwKO2LEvC0gxMGv92QkJCklGOTeGIgNmvFYAss5zKEbeQRGSQ7htoXlosQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=wm0IoaIm; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 59B8360568;
	Fri, 19 Dec 2025 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1766157145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dX8+nZRLVwwDiv24ve8i/eYDHt3PXxPAuYMuc5xMJ3E=;
	b=wm0IoaImO2TsqqZTfOp8+YZM929EMAiSw8WCavhjnwokoMcCwEaGTzD5WXYPFxCEzHpLxa
	MiflB094b+ZB6WHeFpmRsstgIMLTwz0773NRpe/6mOTddz+y3L4zo+OvAaVBSTr7lhEgaK
	0AZ+f8aX8sfZwvi/J4cQhCKpwk0T5Do=
Received: from frank-u24.. (fttx-pool-217.61.156.198.bambit.de [217.61.156.198])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 1FAA81226F4;
	Fri, 19 Dec 2025 15:12:25 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC net-next v5 0/3] Add RSS and LRO support
Date: Fri, 19 Dec 2025 16:12:09 +0100
Message-ID: <20251219151219.77115-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

This series add RSS and LRO hardware acceleration for terminating
traffic on MT798x.

It is currently only for discussion to get the upported SDK driver
changes in a good shape.

patches are upported from mtk SDK:
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-08-mtk_eth_soc-add-register-definitions-for-rss-lro-reg.patch
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-09-mtk_eth_soc-add-rss-support.patch
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-10-mtk_eth_soc-add-hw-lro-support.patch
with additional fixes

changes:
v5:
- fix too long lines after macro changes reported by checkpatch

v4:
- drop unrelated file
- rss-changes suggested by andrew
  - fix MTK_HW_LRO_RING_NUM macro (add eth)
  - fix MTK_LRO_CTRL_DW[123]_CFG (add reg_map param)
  - fix MTK_RX_DONE_INT (add eth param)
- fix lro reverse christmas tree and LRO params suggested by andrew
- drop mtk_hwlro_stats_ebl and unused IS_HW_LRO_RING (only used in
  properitary debugfs)

v3:
- readded the change dropped in v2 because it was a fix
  for getting RSS working on mt7986
- changes requested by jakub
- reworked coverletter (dropped instructions for configuration)
- name all PDMA-IRQ the same way
- retested on
  - BPI-R3/mt7986 (RSS needs to be enabled)
  - BPI-R4/mt7988
  - BPI-R64/mt7622 and BPI-R2/mt7623 for not breaking network functionality

v2:
- drop wrong change (MTK_CDMP_IG_CTRL is only netsys v1)
- Fix immutable string IRQ setup (thx to Emilia Schotte)
- drop links to 6.6 patches/commits in sdk in comments

Mason Chang (3):
  net: ethernet: mtk_eth_soc: Add register definitions for RSS and LRO
  net: ethernet: mtk_eth_soc: Add RSS support
  net: ethernet: mtk_eth_soc: Add LRO support

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 812 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 173 +++--
 2 files changed, 778 insertions(+), 207 deletions(-)

-- 
2.43.0


