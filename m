Return-Path: <netdev+bounces-45018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7117DA8B2
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 20:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179C31C209DD
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805B217721;
	Sat, 28 Oct 2023 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wGd6Q/WL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EAF15AE4
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 18:45:22 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83912F1
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U+uzaEQH9y7sirDfubp47dXKZL8jUyBu7ck/rpdSwcg=; b=wGd6Q/WL1f36hecTHwOGbpVQY3
	3/Ffd/9ymJHwdq06Oo7U8ijvz/OTy/cZwEA4KxM6axmXmnb5lYRxhTNMkd9wIF9Uv3NzlA6ab4ikr
	g/ZhM1iViicSxuape6GZgpDd3wYxhV1K1clorsdJZQy2v6rLkgWgfVleBYODyGBNrTlk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwoJ8-000PsG-Ox; Sat, 28 Oct 2023 20:45:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v1 net-next 1/2] net: phy: fill in missing MODULE_DESCRIPTION()s
Date: Sat, 28 Oct 2023 20:44:57 +0200
Message-Id: <20231028184458.99448-2-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231028184458.99448-1-andrew@lunn.ch>
References: <20231028184458.99448-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if a module is built without a
MODULE_DESCRIPTION(). Fill them in based on the Kconfig text, or
similar.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/bcm-phy-ptp.c | 1 +
 drivers/net/phy/bcm87xx.c     | 1 +
 drivers/net/phy/phylink.c     | 1 +
 drivers/net/phy/sfp.c         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index ef00d6163061..cb4b91af5e17 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -942,3 +942,4 @@ struct bcm_ptp_private *bcm_ptp_probe(struct phy_device *phydev)
 EXPORT_SYMBOL_GPL(bcm_ptp_probe);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Broadcom PHY PTP driver");
diff --git a/drivers/net/phy/bcm87xx.c b/drivers/net/phy/bcm87xx.c
index cc2858107668..e81404bf8994 100644
--- a/drivers/net/phy/bcm87xx.c
+++ b/drivers/net/phy/bcm87xx.c
@@ -223,3 +223,4 @@ static struct phy_driver bcm87xx_driver[] = {
 module_phy_driver(bcm87xx_driver);
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Broadcom BCM87xx PHY driver");
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6712883498bb..6fdc6ba294d5 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3726,3 +3726,4 @@ static int __init phylink_init(void)
 module_init(phylink_init);
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("phylink models the MAC to optional PHY connection");
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index b8c0961daf53..5468bd209fab 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -3153,3 +3153,4 @@ module_exit(sfp_exit);
 MODULE_ALIAS("platform:sfp");
 MODULE_AUTHOR("Russell King");
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("SFP cage support");
-- 
2.42.0


