Return-Path: <netdev+bounces-297133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ZUyOko0KGp1AAMAu9opvQ
	(envelope-from <netdev+bounces-297133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:42:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65524661E7C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:42:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=FIf423Uv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297133-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297133-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AC1E31A2CA6
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466848C401;
	Tue,  9 Jun 2026 15:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ECB466B69;
	Tue,  9 Jun 2026 15:28:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018890; cv=none; b=QrTzT4thEA48NYOif3o5JxMh2NMngNMd4uUEmplkN5/m9g5jK1UV/sUWuQRL80XGYPuphOpk8xe2k7tZQ+ps+Zss/GeaDp95OqId1dU8676jvz0cZUKtV/I3/TWGbn1IkOXHD/uoN8Bhdy+qstfYfv87TZOv7jQi3QjInsUAgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018890; c=relaxed/simple;
	bh=q44Iu0JD9n6afnbk7ZMzlUMAgycaKTOj3h8gQuXruJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTb9nuzH19rZHOrFSEevpFUOeoxXdU6JThD67no+EeZMvSB2K1SjXMc8uWk5UFS+ewlpH7amq9Ljh3vbdG5zSGiav/vOmTFufeh+lRdVoPDRhMkGC1wsVToLbFEGWrUrJOZ5ELbOlcywbMiBYdGToLtv0wH49SQHe4xJpZzRVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIf423Uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEBCAC4AF11;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781018890;
	bh=q44Iu0JD9n6afnbk7ZMzlUMAgycaKTOj3h8gQuXruJ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FIf423UvbWtsFPEhQYlNfD0HH/0b5YMxtdFV7ulDcS9oDgzAUquGkqtdG6L5zdgbT
	 aYZfZAhf2YWlEE71Vye3H0yAYWb+Kt4r01MrdVmLH9cTwVXauw80bkzWuuHll25o9H
	 0y/W4AZSbofzrJeypygV2eXRVWr2FCfaGkw+NidISMS9+9ty5WaiXmbDPk+2qHxviy
	 cKCV7CV5LjKvezomBzjsFnv9T852j4HxQ8sasBCXlRMNSZkKKH1dAQUr6wufxDQk3I
	 21nr5ea0P2m6oF8iX9pPZucZ5AM2vLwtXNRT+jqbN79NWDo1VxxPspbJUCDYeQ82Oq
	 MpJOF5IT7evdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E616FCD98C6;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 18:28:10 +0300
Subject: [PATCH net-next v4 11/13] net: phy: microchip-t1s: use generic C45
 MMD access helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-adin1140-driver-v4-11-0753e28ee004@analog.com>
References: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
In-Reply-To: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781018886; l=2642;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=3Aiei7ngCFKSnU+5iJX1Auxf1Rr03CQY3tkR46GUZiw=;
 b=N/wRQCu3xr/pv+zbDDTHCfD/hEJ2i3TpDq4PHprUNAj7D2tsK1Ps2zE2M98GVdgBX1gZdkg2N
 oNUr5mWQRV3CKRtwnFNF3bi0RM/W748snSC/X7yfka4wthjXw6exuSV
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297133-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:ciprian.regus@analog.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:email,analog.com:replyto,analog.com:email,analog.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65524661E7C

From: Ciprian Regus <ciprian.regus@analog.com>

Replace the driver specific lan865x_phy_read_mmd() and
lan865x_phy_write_mmd() with the shared genphy_read_mmd_c45() and
genphy_write_mmd_c45() helpers.

No functional change.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v4 changelog:
 - no change
v3 changelog:
 - no change
v2 changelog:
 - New patch
---
 drivers/net/phy/microchip_t1s.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index e601d56b2507..73c23d311d72 100644
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
+		.read_mmd           = genphy_read_mmd_c45,
+		.write_mmd          = genphy_write_mmd_c45,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,

-- 
2.43.0



