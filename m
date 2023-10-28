Return-Path: <netdev+bounces-45017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D57DA8B3
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 20:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AE6B20F0D
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431C168CD;
	Sat, 28 Oct 2023 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OsehjT8T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671738E
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 18:45:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3BBED
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BaUsEdmEkQI+C5F2OhzCkM50XzbZ4NjjHQ81nBzVNoM=; b=OsehjT8TQ8RFpmHDV3yI3GLzCP
	xKuxH+QutouiUWYvfBj6zshiQC3FSrg23F2JR4BfJ/DYIXrCvVafiJzqEz9wNO0xYgXDWik3rCDwE
	EUH3yFJUv6Q5bRLPO2T5+M6SSxBgKDEZ/nAUBI6JT3xLFReXgMo/Q2ksKttbekFIcEbM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwoJ8-000PsK-Q0; Sat, 28 Oct 2023 20:45:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v1 net-next 2/2] net: mdio: fill in missing MODULE_DESCRIPTION()s
Date: Sat, 28 Oct 2023 20:44:58 +0200
Message-Id: <20231028184458.99448-3-andrew@lunn.ch>
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
 drivers/net/mdio/acpi_mdio.c    | 1 +
 drivers/net/mdio/fwnode_mdio.c  | 1 +
 drivers/net/mdio/mdio-aspeed.c  | 1 +
 drivers/net/mdio/mdio-bitbang.c | 1 +
 drivers/net/mdio/of_mdio.c      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/net/mdio/acpi_mdio.c b/drivers/net/mdio/acpi_mdio.c
index 4630dde01974..5d0f11f280cf 100644
--- a/drivers/net/mdio/acpi_mdio.c
+++ b/drivers/net/mdio/acpi_mdio.c
@@ -16,6 +16,7 @@
 
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ACPI MDIO bus (Ethernet PHY) accessors");
 
 /**
  * __acpi_mdiobus_register - Register mii_bus and create PHYs from the ACPI ASL.
diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 1183ef5e203e..fd02f5cbc853 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -14,6 +14,7 @@
 
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
 
 static struct pse_control *
 fwnode_find_pse_control(struct fwnode_handle *fwnode)
diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index 70edeeb7771e..c2170650415c 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -205,3 +205,4 @@ module_platform_driver(aspeed_mdio_driver);
 
 MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ASPEED MDIO bus controller");
diff --git a/drivers/net/mdio/mdio-bitbang.c b/drivers/net/mdio/mdio-bitbang.c
index 81b7748c10ce..f88639297ff2 100644
--- a/drivers/net/mdio/mdio-bitbang.c
+++ b/drivers/net/mdio/mdio-bitbang.c
@@ -263,3 +263,4 @@ void free_mdio_bitbang(struct mii_bus *bus)
 EXPORT_SYMBOL(free_mdio_bitbang);
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Bitbanged MDIO buses");
diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 7eb32ebb846d..64ebcb6d235c 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -25,6 +25,7 @@
 
 MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("OpenFirmware MDIO bus (Ethernet PHY) accessors");
 
 /* Extract the clause 22 phy ID from the compatible string of the form
  * ethernet-phy-idAAAA.BBBB */
-- 
2.42.0


