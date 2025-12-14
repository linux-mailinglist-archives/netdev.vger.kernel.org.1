Return-Path: <netdev+bounces-244621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA189CBB9D2
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 12:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 960F3300C2BA
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949412C026F;
	Sun, 14 Dec 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="WyZYqHMY"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73C1C84D7;
	Sun, 14 Dec 2025 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765710653; cv=none; b=FOCZQK4u73/q0HA8Vp3mapEsxIflR9Y6amnarT7+LORvZQVdq6iePZCs+KHR1nEwVOqugbqKXWDNaEVwlgD09dkACAZLcGdVN65SO7Vz6vqqU8DA8Zo3pNRkFgV7juLHvTAlHZZISZ/KTIeJXE2CpQzVTkpNY9xF5OI5bwRMUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765710653; c=relaxed/simple;
	bh=dGRdX8DTmSA7qRJBTSuVigQrLZNFCMS2zS6f/BJ/DD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwOJ46tvrEsk6VRBgIO2jTiYKAdzhr71vw2AlYpS03TDxuQUue/lWljkBiaQ77gJp3TBdPN+avOfmS2zgvdFh3Gc0LOxwfAcC7vUQy5/djVbCtmbhN4vXpHuF/jbGNH2KBSNu1oMCgDisTaAp+6RCEIHbrjDOAlNgOS8G03X2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=WyZYqHMY; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id F058310032F;
	Sun, 14 Dec 2025 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1765710198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OmqjiyOxiK3k5ibOXuc5+y3BAzCAtxHcZycrogYzkSo=;
	b=WyZYqHMYdSuQA96MjjKro0k4DYuMcsY0IffRDyV+SPMLlPPu+GMIhJ6PA+lxXEV2W7yede
	qz2sMNN/lXjEf2pmW5DF7c/p9tkmgxFhHj2Nqy8yFo4izbuKc7fj3mrY9CqcOpicSQEcL0
	rRXCchEL2fHyRRvTFT+XtfVe2dtNVJY=
Received: from frank-u24.. (fttx-pool-194.15.85.205.bambit.de [194.15.85.205])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id AC4871226B1;
	Sun, 14 Dec 2025 11:03:17 +0000 (UTC)
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
Subject: [RFC net-next v3 0/3] Add RSS and LRO support
Date: Sun, 14 Dec 2025 12:03:01 +0100
Message-ID: <20251214110310.7009-1-linux@fw-web.de>
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

 bpi-r4.its                                  |  16 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 762 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 171 +++--
 3 files changed, 757 insertions(+), 192 deletions(-)

-- 
2.43.0


