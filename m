Return-Path: <netdev+bounces-305919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LgonOPSGTmqOOgIAu9opvQ
	(envelope-from <netdev+bounces-305919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:20:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2C72921A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:20:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=n9Ho44o8;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305919-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305919-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDF1530D4C08
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BBE4D2EE6;
	Wed,  8 Jul 2026 17:12:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40734BCAAA;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530757; cv=none; b=CxwoypWiXi0u0BCUMcZGOE7u6AUYDkreZcGWp1mSmOhUbBWnXFC05B/Mzvl7ewNg1ZNdbz6xpa9RJTgLaeAWx73EEY4RieUt2QJ0PIBLkBq1kfiDvSb/9zFN90VBC0ZOBSSyAqGDSUq1vaOChULf3hZ6aZzejyC8agDQGHFp4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530757; c=relaxed/simple;
	bh=8c3366Ur5iOCUpzOiMdAzPh4t4p/bcjrlzBHiJzpm3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpoF1FopALywXDRudLvb55vABaFa9GAllP7MrERAYVXvVY5MJ9Yw1Jf/DYKLhO58hd7tM98tm9AyAOp2AViHMXIvlyKBa96ZXFb8YrODvyFwBnNjmDwE1T/AhhmG/vDkTy3R151uNgpgIr1HXx7j1zKd0WM+UQWTwwVi3ew0Vfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9Ho44o8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B87EEC4AF12;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783530756;
	bh=8c3366Ur5iOCUpzOiMdAzPh4t4p/bcjrlzBHiJzpm3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n9Ho44o8fui1OEYCk/FvhEUf0yQNElO91tZZEVaUy4hcN7QHyw7foWVCmkYr28Tdk
	 Sagb8NK+d0SM3jpXmbq4maRrZrybJApInVsr35a1sW0vkjk273uUVKnqa1hXtOMl7D
	 Kf3XNBkpfLxDYlRMXPto/QSZMJnBQenF7qkS0nwlxIk2G1jeh0LwYANBwaZC+dN4zS
	 T/pazcEKRVynol78EzhILyTE7vlcx2iViT+Hyfu9SwosKGXOoRF5u2FkFWAyAuDSJC
	 u2p3nSkxQuEyHj9okddJApHpcgAlpLnm5RYzD5+x67eCLMPsOIF3Us0DwvYuj4EZMr
	 jXA8uyi1elKig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B4C44506;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 08 Jul 2026 10:12:36 -0700
Subject: [PATCH net-next v7 06/15] net: phy: microchip_t1s: Use generic
 APIs for C45 read and write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-s2500-mac-phy-support-v7-6-478c877aa1a9@onsemi.com>
References: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
In-Reply-To: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783530757; l=2765;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=8moYwEcxY3B1RM6hXptlRwq3ElyA1bvdbX/EWvZfMNA=;
 b=LmxLQoutvXF9SWBBNwa6MtmBJBXJa1YUN98JMGyM9ncamZIwV7+MWyfELg1/QNmVTbIsBwgU4
 6wrlC5ITVWpCoDy7NBQObk9/evYftYRHkNpOgVvfWODiOOALAXV1m/6
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305919-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74C2C72921A

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Replace vendor implementation with generic API to read and write
PHY registers using C45 bus protocol.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - no change
changes in v4
  - no change
changes in v3
  - Updated vendor specific phy_read_mmd/phy_write_mmd functions to
    use genphy read/write APIs that is introduced
  - First patch
---
 drivers/net/phy/microchip_t1s.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index e601d56b2507..0c4dc70641d8 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -506,34 +506,6 @@ static int lan86xx_read_status(struct phy_device *phydev)
 	return 0;
 }
 
-/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
- * C45 registers space. If the PHY is discovered via C22 bus protocol it assumes
- * it uses C22 protocol and always uses C22 registers indirect access to access
- * C45 registers. This is because, we don't have a clean separation between
- * C22/C45 register space and C22/C45 MDIO bus protocols. Resulting, PHY C45
- * registers direct access can't be used which can save multiple SPI bus access.
- * To support this feature, set .read_mmd/.write_mmd in the PHY driver to call
- * .read_c45/.write_c45 in the OPEN Alliance framework
- * drivers/net/ethernet/oa_tc6.c
- */
-static int lan865x_phy_read_mmd(struct phy_device *phydev, int devnum,
-				u16 regnum)
-{
-	struct mii_bus *bus = phydev->mdio.bus;
-	int addr = phydev->mdio.addr;
-
-	return __mdiobus_c45_read(bus, addr, devnum, regnum);
-}
-
-static int lan865x_phy_write_mmd(struct phy_device *phydev, int devnum,
-				 u16 regnum, u16 val)
-{
-	struct mii_bus *bus = phydev->mdio.bus;
-	int addr = phydev->mdio.addr;
-
-	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
-}
-
 static struct phy_driver microchip_t1s_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
@@ -584,8 +556,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan865x_revb_config_init,
 		.read_status        = lan86xx_read_status,
-		.read_mmd           = lan865x_phy_read_mmd,
-		.write_mmd          = lan865x_phy_write_mmd,
+		.read_mmd           = genphy_phy_read_mmd,
+		.write_mmd          = genphy_phy_write_mmd,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,

-- 
2.43.0



