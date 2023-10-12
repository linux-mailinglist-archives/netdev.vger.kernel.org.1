Return-Path: <netdev+bounces-40242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA07C65ED
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CBE28287A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 06:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5ADDCE;
	Thu, 12 Oct 2023 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDDADDC1
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 06:55:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6BAD7
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:55:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qqpb7-0000qY-JB; Thu, 12 Oct 2023 08:55:05 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qqpb6-0015L0-Gh; Thu, 12 Oct 2023 08:55:04 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qqpb6-00CHlw-1S;
	Thu, 12 Oct 2023 08:55:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH net-next v2 1/3] net: phy: micrel: Extend KSZ886X PHY Special Ctrl/Status Reg definitions
Date: Thu, 12 Oct 2023 08:55:00 +0200
Message-Id: <20231012065502.2928220-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012065502.2928220-1-o.rempel@pengutronix.de>
References: <20231012065502.2928220-1-o.rempel@pengutronix.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend 'micrel_phy.h' with additional definitions for KSZ886X PHY
Special Control/Status Register (Reg 31), for upcoming usage in
subsequent patches.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/micrel_phy.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 4e27ca7c49de..591bf5b5e8dc 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -64,6 +64,10 @@
 #define KSZ886X_BMCR_DISABLE_TRANSMIT		BIT(1)
 #define KSZ886X_BMCR_DISABLE_LED		BIT(0)
 
+/* PHY Special Control/Status Register (Reg 31) */
 #define KSZ886X_CTRL_MDIX_STAT			BIT(4)
+#define KSZ886X_CTRL_FORCE_LINK			BIT(3)
+#define KSZ886X_CTRL_PWRSAVE			BIT(2)
+#define KSZ886X_CTRL_REMOTE_LOOPBACK		BIT(1)
 
 #endif /* _MICREL_PHY_H */
-- 
2.39.2


