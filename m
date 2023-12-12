Return-Path: <netdev+bounces-56252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4287C80E3E4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 06:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BA41C21AFF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD414F8B;
	Tue, 12 Dec 2023 05:42:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07025D2
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 21:42:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rCvWd-00060z-3x; Tue, 12 Dec 2023 06:41:47 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rCvWb-00FGUx-Ns; Tue, 12 Dec 2023 06:41:45 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rCvWb-000Mm7-2A;
	Tue, 12 Dec 2023 06:41:45 +0100
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
Subject: [PATCH net-next v2 0/2] add support for DP83TG720S PHY
Date: Tue, 12 Dec 2023 06:41:42 +0100
Message-Id: <20231212054144.87527-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

changes v2:
- reorder DP83TG720_PHY in Kconfig in Makefile
- use dp83tg720_config_aneg() directly
- add Reviewed-by to the first patch

Oleksij Rempel (2):
  net: phy: c45: add genphy_c45_pma_read_ext_abilities() function
  net: phy: Add support for the DP83TG720S Ethernet PHY

 drivers/net/phy/Kconfig     |  13 +++
 drivers/net/phy/Makefile    |   1 +
 drivers/net/phy/dp83tg720.c | 188 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy-c45.c   | 129 ++++++++++++++-----------
 include/linux/phy.h         |   1 +
 5 files changed, 277 insertions(+), 55 deletions(-)
 create mode 100644 drivers/net/phy/dp83tg720.c

-- 
2.39.2


