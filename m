Return-Path: <netdev+bounces-179665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5FBA7E08E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6963C163CC0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265BF1C5486;
	Mon,  7 Apr 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fkmmYR1V"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8B1C173D;
	Mon,  7 Apr 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034591; cv=none; b=K0kLz4+JLiQkRc7gnw6y3QtZ5QpS7x1cf1qv/clhcGDNc+EwTKn101afydXfuVOey9eMkIl0wju2ewWZ1g7KkFrU0na4kwjPcYtHUzlj4O6eYxacrTEz3EfqLt6dwusG41c5lSwo8pDm7ph82MtGGDNd9CfQWa0mdKWVKo1Wmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034591; c=relaxed/simple;
	bh=wyGke769uy1CsWiOJwBHtnnnk4uzJD4kOwYyrEmR9ds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSbLSslYOfpGfbDT2qGG4v90nCImcq0PC3ZRybBkUDI6UMN8+Sm6rz1zij63kBh7Id7s0XvOBwi1cCnrawi797bbqOG5V8qTYzG9fUhPecnn1rPNwo5DdO4+va25HgrBFiejuwQyRoy2HYS/X1BM+JHOMsOdPvPWDznfNmTiyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fkmmYR1V; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B117F442A8;
	Mon,  7 Apr 2025 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744034587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+PHNByw2cn7xbawLNyS6CYRVwN26TmJKdUjFoSmwWo=;
	b=fkmmYR1ViMF2Q/JnA5ETMrttAuLzLfyloDXjgMiRO5+dohok88XXO1MRxL8IpzYTBTUGGV
	/AEZiwc4lsKm8/8iX78ofAwmay10MWcHkukNVF1wzI5/Qfm3H4rsqXIs4CqNYWT1aJOOEw
	Yz8rLCSFha+UwG5ioBnyc6Dbtd5qmCi60LypqdcLkRfGtg8JjVa7G4+znLZwn0PAu05rhw
	lxEf5ksGg/BlUNadCfYDl7aia7sWuHzuxAsFUaWfMqEGwr5V8FVnR6wthsx5ph6ft2LscQ
	pOnHlMzgFB8+6sQvQ7Y1YRuwoU7gwpFuNjUOkFAH8fR2wyR3150HSb1VeeoTig==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 07 Apr 2025 16:03:00 +0200
Subject: [PATCH net-next v2 1/2] net: phy: Move Marvell PHY drivers to its
 own subdirectory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-feature_marvell_ptp-v2-1-a297d3214846@bootlin.com>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
In-Reply-To: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeikefgjedvkedugfeiheffgeeflefgteduleeuvdeitdfgtddvleetieekffffkeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpt
 hhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgutghotghhrhgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Move the Marvell PHY drivers to a dedicated directory to improve
organization and maintainability.

As part of this cleanup, and in preparation for adding PTP support in
the marvell driver, rename marvell.c to marvell_main.c.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 MAINTAINERS                                        |  2 +-
 drivers/net/phy/Kconfig                            | 23 +---------------------
 drivers/net/phy/Makefile                           |  5 +----
 drivers/net/phy/marvell/Kconfig                    | 23 ++++++++++++++++++++++
 drivers/net/phy/marvell/Makefile                   |  6 ++++++
 drivers/net/phy/{ => marvell}/marvell-88q2xxx.c    |  0
 drivers/net/phy/{ => marvell}/marvell-88x2222.c    |  0
 drivers/net/phy/{ => marvell}/marvell10g.c         |  0
 .../net/phy/{marvell.c => marvell/marvell_main.c}  |  0
 9 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c5c2e2c127877a8283793637b0e935ceec27aff..b57df9a87de798c2eab139214f01253ddc1d2708 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14302,7 +14302,7 @@ M:	Russell King <linux@armlinux.org.uk>
 M:	Marek Behún <kabel@kernel.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/phy/marvell10g.c
+F:	drivers/net/phy/marvell/marvell10g.c
 
 MARVELL MVEBU THERMAL DRIVER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index d29f9f7fd2e110415496f322b2936c903cbc4d9c..bccffa3a48fc88ca08c26753e12645bd824e9ff4 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -235,28 +235,7 @@ config LSI_ET1011C_PHY
 	help
 	  Supports the LSI ET1011C PHY.
 
-config MARVELL_PHY
-	tristate "Marvell Alaska PHYs"
-	help
-	  Currently has a driver for the 88E1XXX
-
-config MARVELL_10G_PHY
-	tristate "Marvell Alaska 10Gbit PHYs"
-	help
-	  Support for the Marvell Alaska MV88X3310 and compatible PHYs.
-
-config MARVELL_88Q2XXX_PHY
-	tristate "Marvell 88Q2XXX PHY"
-	depends on HWMON || HWMON=n
-	help
-	  Support for the Marvell 88Q2XXX 100/1000BASE-T1 Automotive Ethernet
-	  PHYs.
-
-config MARVELL_88X2222_PHY
-	tristate "Marvell 88X2222 PHY"
-	help
-	  Support for the Marvell 88X2222 Dual-port Multi-speed Ethernet
-	  Transceiver.
+source "drivers/net/phy/marvell/Kconfig"
 
 config MAXLINEAR_GPHY
 	tristate "Maxlinear Ethernet PHYs"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 23ce205ae91d88ef28fa24ec3689bed1be16a0be..1c0f271b26bee2abb965640b41865bb0f4fda6b6 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -70,10 +70,7 @@ obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
 obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
 obj-$(CONFIG_LXT_PHY)		+= lxt.o
-obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
-obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
-obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
-obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
+obj-y				+= marvell/
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
 obj-y				+= mediatek/
 obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
diff --git a/drivers/net/phy/marvell/Kconfig b/drivers/net/phy/marvell/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..a85bc9e4311e6bedd4a89db9527aca82d55a0762
--- /dev/null
+++ b/drivers/net/phy/marvell/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+config MARVELL_PHY
+	tristate "Marvell Alaska PHYs"
+	help
+	  Currently has a driver for the 88E1XXX
+
+config MARVELL_10G_PHY
+	tristate "Marvell Alaska 10Gbit PHYs"
+	help
+	  Support for the Marvell Alaska MV88X3310 and compatible PHYs.
+
+config MARVELL_88Q2XXX_PHY
+	tristate "Marvell 88Q2XXX PHY"
+	depends on HWMON || HWMON=n
+	help
+	  Support for the Marvell 88Q2XXX 100/1000BASE-T1 Automotive Ethernet
+	  PHYs.
+
+config MARVELL_88X2222_PHY
+	tristate "Marvell 88X2222 PHY"
+	help
+	  Support for the Marvell 88X2222 Dual-port Multi-speed Ethernet
+	  Transceiver.
diff --git a/drivers/net/phy/marvell/Makefile b/drivers/net/phy/marvell/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..2c3622b053d1f54eba518b06730b797fb103ee06
--- /dev/null
+++ b/drivers/net/phy/marvell/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
+marvell-y			:= marvell_main.o
+obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
+obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
+obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell/marvell-88q2xxx.c
similarity index 100%
rename from drivers/net/phy/marvell-88q2xxx.c
rename to drivers/net/phy/marvell/marvell-88q2xxx.c
diff --git a/drivers/net/phy/marvell-88x2222.c b/drivers/net/phy/marvell/marvell-88x2222.c
similarity index 100%
rename from drivers/net/phy/marvell-88x2222.c
rename to drivers/net/phy/marvell/marvell-88x2222.c
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell/marvell10g.c
similarity index 100%
rename from drivers/net/phy/marvell10g.c
rename to drivers/net/phy/marvell/marvell10g.c
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell/marvell_main.c
similarity index 100%
rename from drivers/net/phy/marvell.c
rename to drivers/net/phy/marvell/marvell_main.c

-- 
2.34.1


