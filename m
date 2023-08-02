Return-Path: <netdev+bounces-23771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB8176D78E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B400281E32
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB510965;
	Wed,  2 Aug 2023 19:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8EA10956
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:13:55 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F9B26AB;
	Wed,  2 Aug 2023 12:13:54 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0EAB1201074;
	Wed,  2 Aug 2023 21:13:53 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C247E201B1B;
	Wed,  2 Aug 2023 21:13:52 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
	by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id B7BF0405DF;
	Wed,  2 Aug 2023 12:13:51 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Bauer <mail@david-bauer.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v4 2/2] net: phy: at803x: remove set/get wol callbacks for AR8032
Date: Wed,  2 Aug 2023 14:13:47 -0500
Message-Id: <20230802191347.6886-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20230802191347.6886-1-leoyang.li@nxp.com>
References: <20230802191347.6886-1-leoyang.li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since the AR8032 part does not support wol, remove related callbacks
from it.

Fixes: 5800091a2061 ("net: phy: at803x: add support for AR8032 PHY")
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Cc: David Bauer <mail@david-bauer.net>
---
 drivers/net/phy/at803x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 9c2c2e2ee94b..8a77ec33b417 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2064,8 +2064,6 @@ static struct phy_driver at803x_driver[] = {
 	.flags			= PHY_POLL_CABLE_TEST,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
-	.set_wol		= at803x_set_wol,
-	.get_wol		= at803x_get_wol,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	/* PHY_BASIC_FEATURES */
-- 
2.25.1.377.g2d2118b


