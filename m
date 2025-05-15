Return-Path: <netdev+bounces-190641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2482AB803E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEA93A6886
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDD42882BD;
	Thu, 15 May 2025 08:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17128688B
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297268; cv=none; b=YM6dQIUh8TLp3N0/kqBON3wn3ZmcMsvLYCo4IoWCvTuz2wrSfjinYq22ElPkEz5GULb4sgELU23rGJFDle5QLdbTiGCPENztIqBb4MoGSsNW8SqdE7GuQr/vpQRzIAXTh7M1XKg2skbaRRu2ZAgN6hjIMpYOdTt77nkiNhZ+DJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297268; c=relaxed/simple;
	bh=trPgxOzC3uBhx/jjBBkfCAGr8L3X3EGZFCMDd258s1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B3t0BztB4sP9vZZf2XiPxxHmt1JG8i4pk1nGmZCC3YXKyY7ODzxKdsaCrph0be75Tm3psN2917wXUOcsdPHDc1VcftozTEKk1/d2ecNZJg912PNQD/TLvDibfhtt5esvospC00DltI29cDOOS1EcWP9dmTTFZMXLJxlU5i+ngZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uFTpl-0006ax-AB; Thu, 15 May 2025 10:20:53 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uFTpj-002qNa-2l;
	Thu, 15 May 2025 10:20:52 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uFTpk-00B5zQ-0k;
	Thu, 15 May 2025 10:20:52 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 1/1] net: phy: microchip: document where the LAN88xx PHYs are used
Date: Thu, 15 May 2025 10:20:51 +0200
Message-Id: <20250515082051.2644450-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The driver uses the name LAN88xx for PHYs with phy_id = 0x0007c132. But
with this placeholder name no documentation can be found on the net.

Document the fact that these PHYs are build into the LAN7800 and LAN7850
USB/Ethernet controllers.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/microchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 93de88c1c8fd..13570f628aa5 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -474,6 +474,8 @@ static struct phy_driver microchip_phy_driver[] = {
 	/* This mask (0xfffffff2) is to differentiate from
 	 * LAN8742 (phy_id 0x0007c130 and 0x0007c131)
 	 * and allows future phy_id revisions.
+	 * These PHYs are integrated in LAN7800 and LAN7850 USB/Ethernet
+	 * controllers.
 	 */
 	.phy_id_mask	= 0xfffffff2,
 	.name		= "Microchip LAN88xx",
-- 
2.39.5


