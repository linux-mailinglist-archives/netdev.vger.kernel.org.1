Return-Path: <netdev+bounces-250792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A65D39262
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D79AA301103F
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89402BEFE7;
	Sun, 18 Jan 2026 03:26:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B729B781;
	Sun, 18 Jan 2026 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768706766; cv=none; b=jqkMH0NX39MEATNhOF4VhZBUwErJDzWGJmt9n2hwz/UcqgxrGqvTrt5ESfaDT0fs+ZZlrOBghaOg5g8/v58eDMd6p/4M3nagDCJnLd+YY5okVKw6Dst17OlYT6CKiYFyQwQUM3gO32uIgIZMZzTXZvNZm2wJON06y82QcLzVct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768706766; c=relaxed/simple;
	bh=HlveOumcfPoONGjV+vGVyA2m8heqKAhXa7Z9D9n8XCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL16U0jK6XVoVHNaA9i+BtaOZ8g9IDcI2OXBAV2L4A/2P17et87ArwH2/lwN60yKRCuZTQIGUuJZ/4wEZ0gjzm5NC05j6nhOTAZTJoxnAZ561FAvhml89peMwiKcXmNY7ECtK9gPNhgomP6VbfkscOUUn96PZHmYXJcYXPS2cKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhJQP-000000000fC-00eu;
	Sun, 18 Jan 2026 03:26:01 +0000
Date: Sun, 18 Jan 2026 03:25:52 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v5 4/6] net: dsa: lantiq: clean up phylink_get_caps
 switch statement
Message-ID: <6265374bee6b8eadccb873b903a366f44ea5be43.1768704116.git.daniel@makrotopia.org>
References: <cover.1768704116.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768704116.git.daniel@makrotopia.org>

Use case ranges for phylink_get_caps and remove the redundant "port N:"
from the comments.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5: no changes
v4: no changes
v3: no changes
v2: new patch

 drivers/net/dsa/lantiq/lantiq_gswip.c | 12 +++---------
 drivers/net/dsa/lantiq/mxl-gsw1xx.c   | 11 +++++------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 0377fc0079b54..4d699d8c16f91 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -33,8 +33,7 @@ static void gswip_xrx200_phylink_get_caps(struct dsa_switch *ds, int port,
 					  struct phylink_config *config)
 {
 	switch (port) {
-	case 0:
-	case 1:
+	case 0 ... 1:
 		phy_interface_set_rgmii(config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_MII,
 			  config->supported_interfaces);
@@ -44,9 +43,7 @@ static void gswip_xrx200_phylink_get_caps(struct dsa_switch *ds, int port,
 			  config->supported_interfaces);
 		break;
 
-	case 2:
-	case 3:
-	case 4:
+	case 2 ... 4:
 	case 6:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
@@ -75,10 +72,7 @@ static void gswip_xrx300_phylink_get_caps(struct dsa_switch *ds, int port,
 			  config->supported_interfaces);
 		break;
 
-	case 1:
-	case 2:
-	case 3:
-	case 4:
+	case 1 ... 4:
 	case 6:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index e2df6a3fd2dcc..6a2d4bd5ded08 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -511,14 +511,12 @@ static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
 				   MAC_10 | MAC_100 | MAC_1000;
 
 	switch (port) {
-	case 0:
-	case 1:
-	case 2:
-	case 3:
+	case 0 ... 3: /* built-in PHYs */
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
 		break;
-	case 4: /* port 4: SGMII */
+
+	case 4: /* SGMII */
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
@@ -529,7 +527,8 @@ static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
 			config->mac_capabilities |= MAC_2500FD;
 		}
 		return; /* no support for EEE on SGMII port */
-	case 5: /* port 5: RGMII or RMII */
+
+	case 5: /* RGMII or RMII */
 		__set_bit(PHY_INTERFACE_MODE_RMII,
 			  config->supported_interfaces);
 		phy_interface_set_rgmii(config->supported_interfaces);
-- 
2.52.0

