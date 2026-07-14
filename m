Return-Path: <netdev+bounces-307451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iGGrBigxVmqG1AAAu9opvQ
	(envelope-from <netdev+bounces-307451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:52:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC3754BD7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:52:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YlU+5xTh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307451-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307451-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64F3E3011102
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0CD3AA1A7;
	Tue, 14 Jul 2026 12:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368783655EA;
	Tue, 14 Jul 2026 12:50:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033418; cv=none; b=EGaFPrwzhWy+JUtx34JQwVkvbYuehg2hN8NEJqIuWxv5/0wicjtw5FGpm2SrVe1xWMDs97H3pLGWAqEWexAzJ7THM95V9Ywzt2yhcw9GAqKj6lVh4UAzWHiLrcr7okczR8KCnN/ZM0DXG8X/9wq1OmzNUfff+KIOIxEaaIH82Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033418; c=relaxed/simple;
	bh=PqG7oS3Z/lV6BaYYg8l7cJd+xyFoKnA7xPcaifwbyKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5o8CtZknY7skZuEei8O59PhRWBjenWmFHyyi5TqEFtwo6SoNJPvj4ssG/c61F+gKWWFeS8poebYw51rQAj73BzKhWRG+1LJBv3oguFHleqbjkG0HGe9PbwAMv6WKq4pgZiIlU2IJ00wOQJwL2nrAs4W+B1z4vrRhYylINVJPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlU+5xTh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84771F000E9;
	Tue, 14 Jul 2026 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033416;
	bh=8mH0j9ii9oCrYiLOBac28i1RSeNAyFN6+6Ihbf0VC8M=;
	h=From:To:Cc:Subject:Date;
	b=YlU+5xThoIRK+XjhKF0UUDOeiSkO8wvGChH0uj3Jx9x1laPsu3jJ4bu65WNukqtCe
	 ZGpXFaEBvdiZRtInlqg9FTqx2bAvi2majmn6l0Cj9c+gZDTqqJVJ/RJz9ZLDvJOhkT
	 CWPUBhrsOZdOlbvBQJW9DWNnR1l6cPZ0SlWU0d8K4z+qmWS6lPNH538+1WAgrsoARU
	 1DZn1gn464fbu2biYUHYkhkW2fO3Jxd6b5AW5UioF/uzbHirKdzTZ8sRL+JDb2SaeV
	 BOXmZkg81Yoz3MbfYxJJRMzEqWXdafj1GXRvtD/STYjyzHWFBiA1hnaMT0erVaHnG7
	 70KxCO1ebZJQg==
From: Michael Walle <mwalle@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH RFC net-next] net: phy: sfp: drop 1000Base-T support for FCLF8521P2BTL
Date: Tue, 14 Jul 2026 14:49:34 +0200
Message-ID: <20260714125008.2466023-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307451-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mwalle@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mwalle@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,coherent.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58EC3754BD7

The FCLF8521P2BTL is marketed as a drop in replacement for fiber
modules using 1000Base-X autoneg towards the host as default. See the
referenced application note, esp. question #11. Drop the 1000baseT
capability, so 1000Base-X will eventually be used.

This is esp. important if the TX_DISABLE pin is not connected on a
board. Usually, pin is used as a reset line to the PHY on the copper
SFP. If a bootloader expects the default mode and doesn't do any
reconfiguration of the SFP module, a link might not be established.

Link: https://www.coherent.com/resources/application-note/networking/1000base-t-sfp-faq-an-2036.pdf
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
I'm not sure, this is the correct place for the fix, nor if it goes in
the right direction. There is a comment in

/*
 * Clause 22 copper SFP modules normally operate in Cisco SGMII mode with
 * negotiation enabled, but some may be in 1000base-X - which is for the
 * PHY driver to determine.
 */

I haven't found any traces of that though. So any pointers, what flags
have to be modified is appreciated (phydev->supported?
phydev->possible_interfaces?).

I also compared the EEPROMs of both a FCLF-8520-3 and a FCLF-8521-3 (I
don't have a FCLF8520P2BTL) and they are the same except for the P/N and
the serial number. So they both advertise the same capabilites. Although
I'd suspect that the power-on strapping is different and could be read
by the PHY driver.
---
 drivers/net/phy/sfp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index b9d84612ac6f..387753cb5c62 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -478,6 +478,16 @@ static void sfp_quirk_2500basex(const struct sfp_eeprom_id *id,
 	__set_bit(PHY_INTERFACE_MODE_2500BASEX, caps->interfaces);
 }
 
+static void sfp_quirk_no_sgmii(const struct sfp_eeprom_id *id,
+			       struct sfp_module_caps *caps)
+{
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+			   caps->link_modes);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			   caps->link_modes);
+	__clear_bit(PHY_INTERFACE_MODE_SGMII, caps->interfaces);
+}
+
 static void sfp_quirk_disable_autoneg(const struct sfp_eeprom_id *id,
 				      struct sfp_module_caps *caps)
 {
@@ -539,6 +549,10 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
 
+	// These are sold as 1000base-X compatible. Thus, make sure we don't
+	// use SGMII.
+	SFP_QUIRK_S("FINISAR CORP.", "FCLF8521P2BTL", sfp_quirk_no_sgmii),
+
 	// Fiberstore SFP-2.5G-T and SFP-10GM-T uses Rollball protocol to talk
 	// to the PHY and needs 4 sec wait before probing the PHY.
 	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_rollball_wait4s),
-- 
2.47.3


