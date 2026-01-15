Return-Path: <netdev+bounces-249985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20190D21ED5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 02:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4C8C304C924
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B21E834B;
	Thu, 15 Jan 2026 00:57:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831B1D6DB5;
	Thu, 15 Jan 2026 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768438674; cv=none; b=RtdyAfShL+15weyA99zRlU3bkum4Q9CfZ7qBur2YDEwFkBPYnlRREhxHJ2hNi3I6gt5YbU/T6CKbJBEnTykjD3gmLXOyjhfFLdQ5Ebs5PKQKoWu5TujODyrgIfDyfrzWcKngt/EJ3NB7FOYsTyB76so6sFemKBwglXWQ0RFXVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768438674; c=relaxed/simple;
	bh=2LqJIdefRaNXJiIQo+30IbBciuqMp20axNcumVRmTtg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLMREUYkv5VZRrX+ec3cCmGG8T6z+rX9ks56sAB7bHjgVFR0VEs3o3zmUs1MzKn+oA2ektFV9nInkLE3X7K8ETyqoWwzUyBc80FV/UvB99/3avQDBt91vuVXINo0y34ARGl94xNkmKTBh3W5au5mTCxZG+IHcbVjgEWTMtGpkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgBgK-00000000237-2JHx;
	Thu, 15 Jan 2026 00:57:48 +0000
Date: Thu, 15 Jan 2026 00:57:45 +0000
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
Subject: [PATCH net-next v2 4/6] net: dsa: lantiq: clean up phylink_get_caps
 switch statement
Message-ID: <898d542a0adee121ae779c0baa464fe8cee0166f.1768438019.git.daniel@makrotopia.org>
References: <cover.1768438019.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768438019.git.daniel@makrotopia.org>

Use case ranges for phylink_get_caps and remove the redundant "port N:"
from the comments.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: new patch

 drivers/net/dsa/lantiq/lantiq_gswip.c | 12 +++---------
 drivers/net/dsa/lantiq/mxl-gsw1xx.c   | 11 +++++------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 4a1be6a1df6fe..8d42758e5d2ba 100644
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
index b74edb85e6d8e..718837bf1c1ef 100644
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

