Return-Path: <netdev+bounces-263024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBMLGBlTpmkbOAAAu9opvQ
	(envelope-from <netdev+bounces-263024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:18:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8AF1E86D7
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B8393006F0E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EAE37CD2E;
	Tue,  3 Mar 2026 03:17:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E40248F57;
	Tue,  3 Mar 2026 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507875; cv=none; b=KxiRCOmTPHK6WNYuclFPe7l6a6A2LKvqp2DL2rQhIGsso+5DEyyXHFhcz4YJPKHy6/r46aziyVRAvPZKHrT/xF7L2Z4/2GLXnf9oor4Hth9E2PwPe3AxjkaP6QA0aG0XqsRFyNz2ShvIFjBflmW2VKMhTvLEUDuCKwYZxPbW0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507875; c=relaxed/simple;
	bh=aLwLV5D6RqPYowtE65kJT13yA6cxhhE5SMAi6T6SqkU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y/GDsP6pThW4zNpRomns5/I+W6HOX19wTcjelcJ3M5NfOTtmgMXNMtSCvBLvjzZPboE48uWFjLM2nEl/6k3/y4BMWeGxLd1iwMHTkqeUV336YwIM32H5hZyUPtlM6v1hq6+OXDIcPs+8zPjioCL/FUWJCKMIa8UMnKFlNHR0Tpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vxGGc-000000001hz-3S7h;
	Tue, 03 Mar 2026 03:17:50 +0000
Date: Tue, 3 Mar 2026 03:17:43 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: mxl862xx: rename MDIO op arguments
Message-ID: <e1f4cb3bcffc7df9af0f2c9b673b14c7e1201c9a.1772507674.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: CA8AF1E86D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263024-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.090];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The use of the 'port' argument name for functions implementing the MDIO
bus operations is misleading as the port address isn't equal to the
PHY address.

Rename the MDIO operation argument name to match the prototypes of
mdiobus_write, mdiobus_read, mdiobus_c45_read and mdiobus_c45_write.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 32 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index b1e2094b58165..8281c749967af 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -44,13 +44,13 @@ static enum dsa_tag_protocol mxl862xx_get_tag_protocol(struct dsa_switch *ds,
 }
 
 /* PHY access via firmware relay */
-static int mxl862xx_phy_read_mmd(struct mxl862xx_priv *priv, int port,
-				 int devadd, int reg)
+static int mxl862xx_phy_read_mmd(struct mxl862xx_priv *priv, int addr,
+				 int devadd, int regnum)
 {
 	struct mdio_relay_data param = {
-		.phy = port,
+		.phy = addr,
 		.mmd = devadd,
-		.reg = cpu_to_le16(reg),
+		.reg = cpu_to_le16(regnum),
 	};
 	int ret;
 
@@ -61,40 +61,40 @@ static int mxl862xx_phy_read_mmd(struct mxl862xx_priv *priv, int port,
 	return le16_to_cpu(param.data);
 }
 
-static int mxl862xx_phy_write_mmd(struct mxl862xx_priv *priv, int port,
-				  int devadd, int reg, u16 data)
+static int mxl862xx_phy_write_mmd(struct mxl862xx_priv *priv, int addr,
+				  int devadd, int regnum, u16 data)
 {
 	struct mdio_relay_data param = {
-		.phy = port,
+		.phy = addr,
 		.mmd = devadd,
-		.reg = cpu_to_le16(reg),
+		.reg = cpu_to_le16(regnum),
 		.data = cpu_to_le16(data),
 	};
 
 	return MXL862XX_API_WRITE(priv, INT_GPHY_WRITE, param);
 }
 
-static int mxl862xx_phy_read_mii_bus(struct mii_bus *bus, int port, int regnum)
+static int mxl862xx_phy_read_mii_bus(struct mii_bus *bus, int addr, int regnum)
 {
-	return mxl862xx_phy_read_mmd(bus->priv, port, 0, regnum);
+	return mxl862xx_phy_read_mmd(bus->priv, addr, 0, regnum);
 }
 
-static int mxl862xx_phy_write_mii_bus(struct mii_bus *bus, int port,
+static int mxl862xx_phy_write_mii_bus(struct mii_bus *bus, int addr,
 				      int regnum, u16 val)
 {
-	return mxl862xx_phy_write_mmd(bus->priv, port, 0, regnum, val);
+	return mxl862xx_phy_write_mmd(bus->priv, addr, 0, regnum, val);
 }
 
-static int mxl862xx_phy_read_c45_mii_bus(struct mii_bus *bus, int port,
+static int mxl862xx_phy_read_c45_mii_bus(struct mii_bus *bus, int addr,
 					 int devadd, int regnum)
 {
-	return mxl862xx_phy_read_mmd(bus->priv, port, devadd, regnum);
+	return mxl862xx_phy_read_mmd(bus->priv, addr, devadd, regnum);
 }
 
-static int mxl862xx_phy_write_c45_mii_bus(struct mii_bus *bus, int port,
+static int mxl862xx_phy_write_c45_mii_bus(struct mii_bus *bus, int addr,
 					  int devadd, int regnum, u16 val)
 {
-	return mxl862xx_phy_write_mmd(bus->priv, port, devadd, regnum, val);
+	return mxl862xx_phy_write_mmd(bus->priv, addr, devadd, regnum, val);
 }
 
 static int mxl862xx_wait_ready(struct dsa_switch *ds)
-- 
2.53.0

