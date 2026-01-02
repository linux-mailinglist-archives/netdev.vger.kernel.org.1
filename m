Return-Path: <netdev+bounces-246565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E36A8CEE5E3
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 12:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4BB7300A364
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693830DD25;
	Fri,  2 Jan 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="nScZ4ps7"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821E2F39A3
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767353551; cv=none; b=LMoh8wBd0jTZF/en1Qefugsqv5zsDBnQhnqPDu2FOeTKVfS9nipkMyipQIVf6qNHfKjfo/gYEQ98OSp5c20577GHIeebZyJApGzB1iXbScolPIYzRbD0A/pSIXzx39LKdvoRo3nQYYTboH/mBV03WyimXwVmAUdYRsknJjAAkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767353551; c=relaxed/simple;
	bh=PbwUlVSTPTrbQf0IaalMVCYxoIIX5GbB4ss0oKcuHTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DIhm1qxct4jh/lbhJXNF4H7tIo5gUiCsJysLbl8KDEe7EvO5FovzFNNgIc/MhEywT1dUjbB4MG1aF5wsEv+17KdANu6sqEVZNA1FsVOpLcbG8VtnmD7Xq8Z5bRGAc2DY+LYfm37VQSnAvSTJCAeADqitMLNU+DbZ3zlzvdsLZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=nScZ4ps7; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 4911 invoked from network); 2 Jan 2026 12:32:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1767353544; bh=jHe9aC1y+9UHk+XDFJvLFz8bqA/OnFcRkg7KkBp46PM=;
          h=From:To:Cc:Subject;
          b=nScZ4ps7gWb1pX7hQcGnjkpRyryaJ+DB65fAyWxlcl/84x8FjHjqqNWZy1N1Wj7tH
           a5DjXfdWGSGlHV6GHHuPxJoMVD5LQIG5+wVHGM98Y5R74wbzu3yuhHiHUHhHskkUX+
           OsJlQKfkAV1+t7aAKrYhUGX1nvrwhu7PIgj+sqM/cILE813ZF2PlMUmtjtRgTU8Jl1
           ORKZwnuffBGE5maUz26TJlCJYhReZf/rngNCeY0yhiLvJsHp7u2H/0GgpHEN2gX2He
           XoKv6p8U989n2yiYfD4bn1aJgfms2rRluov/rgaoawMdhxKrYgFmvHIFNEfb6VoGTw
           HsHwgqhF8nKSw==
Received: from 83.5.157.18.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.157.18])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 2 Jan 2026 12:32:24 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: daniel@makrotopia.org,
	dqfext@gmail.com,
	SkyLake.Huang@mediatek.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH net-next] net: phy: mediatek: enable interrupts on AN7581
Date: Fri,  2 Jan 2026 12:30:06 +0100
Message-ID: <20260102113222.3519900-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 48e403bdea1000ce78166cbd4ce3ce3e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [IWPU]                               

Interrupts work just like on MT7988.

Suggested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 2c4bbc236202..9a54949644d5 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1508,6 +1508,8 @@ static struct phy_driver mtk_socphy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7581),
 		.name		= "Airoha AN7581 PHY",
+		.config_intr	= genphy_no_config_intr,
+		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.probe		= an7581_phy_probe,
 		.led_blink_set	= mt798x_phy_led_blink_set,
 		.led_brightness_set = mt798x_phy_led_brightness_set,
-- 
2.47.3


