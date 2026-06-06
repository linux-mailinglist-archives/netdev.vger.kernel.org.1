Return-Path: <netdev+bounces-296044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k8MQMHazI2r/xAEAu9opvQ
	(envelope-from <netdev+bounces-296044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:43:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B364C99B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:43:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ltEDzHKH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296044-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296044-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBDB0302E7B5
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 05:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43703093DF;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE62F8EA3;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780724569; cv=none; b=YX9he+lY1gLMkyL7YF7E5NuNO0d1l7dH1q1z9I2zk5wTRsmFdNW/PXgRte9/D6t5rBfCyVqc+bSH+3mAnsub7gw1+H8P6LqXJ7t9FxlQ8CHwQ6RSNnaUudFKEfVFmLzByyE7EFBaAFiXsQyj8JxGLOY45PlOtQTEY7bcf8Q90l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780724569; c=relaxed/simple;
	bh=SmYwTrh69xadUhUcelpIIAfDK+nVXETKXpTKd0NEGsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTnrdBQD0XE/pSuBUCJ8V0U0L7Mi1NFV6qEQC4VZIl61g4jqttoltlsURsmdvs2IpsD3i8Ke9RTxWUSoasLEUhNeo0ywXCbgKv80t9YOc245rG2WoRS8k2UPxOi5F9FqH5rNAGpE5o1a21ol8LTc/2ZLvD1zqzhsJZmSrPNk/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltEDzHKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FED9C4AF0C;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780724569;
	bh=SmYwTrh69xadUhUcelpIIAfDK+nVXETKXpTKd0NEGsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ltEDzHKHhilnURIxH9O4Zwlj4G+ce8sW9L4i4q1T0mO9yi484FhzhiULTxW+MEAc0
	 RfCC13d3bf1jRcDyWc8ZbPty8tiyvnDzCDJSbPFUcCWCOtXhBhXMZHX8nK17rSlDF2
	 4PgqLFM2n6BIlJHIcVKtR/+r0dCghaYOlLCT0kajNGUdUHU3S0DeMUqKdgzjdMQc85
	 KbXau/VnXzW38gy3TnajACTEeDmRK9q6bN3pUyIGA26uDpFidOPMa4EW2+132YSUj5
	 Gj3Gc1apyINVSCJjj39+BHz7HNErDTM9sk4KGZ3VgEE+5HEDrtGlAauwtXb2MU58Or
	 wzd5PVmrGF+Kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517BFCD8C8E;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 05 Jun 2026 22:42:35 -0700
Subject: [PATCH net-next v4 04/16] net: phy: microchip_t1s: Use generic
 APIs for C45 read and write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-s2500-mac-phy-support-v4-4-de0fbc13c6d8@onsemi.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
In-Reply-To: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780724562; l=2443;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=6sTUcccS7JT5OwyvQOGywuignQ32VFAFjNX0fljOxUI=;
 b=itPmpMHWoPWnso/Qb9QuMMu3T6jnObSBOWOdQYubTo9lEaCWR4sEp24QGd3dC7wQXbUd3CyNC
 Cq6XtW7R34ABTMB+YMKyJsbxyNkRtUUvA4wnS9vHc0/5/3yVvG81sV3
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296044-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A7B364C99B

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Replace vendor implementation with generic API to read and write
PHY registers using C45 bus protocol.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
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



