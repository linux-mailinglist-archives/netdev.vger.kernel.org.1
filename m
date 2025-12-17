Return-Path: <netdev+bounces-245117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5DFCC7201
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E853E3110AFB
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B95346FA7;
	Wed, 17 Dec 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="t6N85lDf"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886738F229;
	Wed, 17 Dec 2025 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765967232; cv=none; b=lUtE/bKMTJT7gdgqUWzCYmjI4711MZVhKRmjZRFAjW1HwvvvJyT3Ifb46n9/op36pZ6wEKuDyzQETD3ZKmIXSl1FJ3COOSMUgMH12vsrLUDHIxLwWj0QZFibaNlbUzM2sqV7NwJoqwFhen6eqhcTTzg/ZTukHMwS1wO+6LZS01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765967232; c=relaxed/simple;
	bh=lIuDemj+Ulk5ye74XjpqgubGl7Wcou/FrlnXtvXv/Po=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYKDHDhWZ7KwbDfHZpMipwKqndsNoIZ/sHKmSPKLgucmi2Jkxrq8DzCurYJwhsrnIDv8fZQyyVBExF3lq2SueKz3/5okJkHiyvYNvyTK+4Cdtp43hNmjhlj/PZ0gXG9i7/dzVOAL08C8ehne893xqyYMEGZJjXQ0cK+yTZUeBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=t6N85lDf; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id 91D5140805;
	Wed, 17 Dec 2025 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1765967215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J+Tdb+DQVnaI8wgW/gooNMMH6avHcs+q+RO2MST1bXQ=;
	b=t6N85lDfMLiKYuG9hIj9COUzeqZR3nzZAVVw+CcekH9PVsGAWj60FsyhGDBcagqKAOp4/y
	KTFyjwxhfQe+qQSWwbLjlNZvOF2BtLmK0XdBcEG9zHyzmMgmZlaW/rtM9geQ73PqGioKOx
	x3QPCN9ZB6qeT4qwh6uyrgSWnigqyeY=
Received: from frank-u24.. (fttx-pool-217.61.152.85.bambit.de [217.61.152.85])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 50B951226AF;
	Wed, 17 Dec 2025 10:26:55 +0000 (UTC)
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
Subject: [RFC net-next v4 0/3] Add RSS and LRO support
Date: Wed, 17 Dec 2025 11:26:41 +0100
Message-ID: <20251217102648.47093-1-linux@fw-web.de>
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

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 809 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 168 ++--
 2 files changed, 770 insertions(+), 207 deletions(-)

-- 
2.43.0


