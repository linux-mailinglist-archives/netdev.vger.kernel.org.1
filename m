Return-Path: <netdev+bounces-304797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 26xgCjSJSmrfEQEAu9opvQ
	(envelope-from <netdev+bounces-304797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:41:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD83770A97E
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:41:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=dDXTAzG6;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304797-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304797-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A78B1300CBEE
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF0A2F7EE5;
	Sun,  5 Jul 2026 16:36:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9975184524;
	Sun,  5 Jul 2026 16:36:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269381; cv=none; b=s85GG1OIzlokWj7mQc9nf4SW++9Hq9wkHzRfwsvgu1LKp9QF9lEgml9jCYVd1befxFqPAtX14aKN8Sw/mftHhiX3Csfp+2t+ZxKNtapYfg+OS7E0O0i6uCnxypJqLBryWTkA12qQ8SI096kHQK0gFbkQotNJVV05VmHPvt6OHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269381; c=relaxed/simple;
	bh=udE+wqWDUwbhJJ8eoFcvIu5txH8yCshYEwVihKeA76E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ7+FPk7zDeQD35MPw1YCITkeF8nvVBooQaXevOn78Vr+sQj6VZKfKcYwL2rTCjNQrdI15Ge14uM6yq9j7yvynLi6lLDGvUEtvnQ01CsP0OQ1il54vatOYO6jrPR028zf0xdolYRed+W3DooUmGJ1grwkPOjZz9iit0UW09bJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=dDXTAzG6; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783269347; x=1783874147;
	i=markus.stockhausen@gmx.de;
	bh=sXPfSkNRF+22Kh6QivjbJfLFsq0FOBxuGjccam4KOcs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dDXTAzG6fa2XSMV4/IDjAlrR4I/oeyXFz6vLHsHWPZqakNvdj2hsnV2qpx4jAUNg
	 rcrLwCE9zRVnBZB1TZpo+lblqJW8C1NMaOTq5VYb0R6J3KzNuNfb95D+MfoMKY0zt
	 Yc5qnva9GJ4k1ly8+ucFTrXxTYifrlms3VKi/p17kTuy55NW/YQyhRRioWu6oseP/
	 GV/JezYOENGGkbUvUXTYiCpF3Kx5WBNwD6FYDyZ1R3X8U9N9O7/xcLdfTVtzjcyIo
	 mCNq9jw63sJumie9LzaBtG+4mww0DDMOH0rGs7YayFqGnH/vSSoVetZay7oqVeBU9
	 bNnNjjmU4JTY1fKbOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjjCF-1xLq6S2JIJ-00mItb; Sun, 05
 Jul 2026 18:35:47 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v3 2/8] net: mdio: realtek-rtl9300: Add polling documentation
Date: Sun,  5 Jul 2026 18:35:26 +0200
Message-ID: <20260705163532.2853959-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
References: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3nb5+kdUwfQyvEITbcMVunr5xRkNVRylOL0dvkaDTHbtuWSuvNQ
 22Wrsjb9REHnP7l/TfE5BCJ4EryeyTQhNUOXtwyCC3kd9X99I87LGK0+rUR/23pRMuiDgXn
 uBDLSxY+8klri3LokS1JOaTVLX0eNYNnhKgblXA966KKvXTNTNH3fV2q8BYdLI+39SEaRJe
 A1oynVZVUVEdMXVyq6vZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ckn3Z8g4PU8=;L+xvr0vhu49bb1maD40ZycVrhpA
 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
 NSwdb7ZXOjss8EJ+Zs=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304797-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD83770A97E

Add a detailed explanation how the hardware polling unit in the
Realtek Otto switches works. This simplifies developing future
patches and reviewing them.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 68 +++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 892ed3780a65..562f9c7f2895 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -35,6 +35,74 @@
  *
  * The driver works out the mapping based on the MDIO bus described in de=
vice tree and phandles on
  * the ethernet-ports property.
+ *
+ * The devices have a hardware polling unit that runs in the background w=
ithout any CPU load. It
+ * constantly scans the MDIO bus and the attached PHYs and updates the MA=
C status registers.
+ *
+ * How does the polling work?
+ *
+ * Each device has a SMI_POLL_CTRL register. A per-port bitmask decides i=
f the hardware polling of
+ * the associated bus/address is active or not. The hardware runs a tight=
 loop over this and for
+ * each set polling bit it issues a status check for the PHY. Attaching a=
 logic analyzer to the
+ * MDIO bus of an RTL8380 and RTL8393 gives the following commands (in ke=
rnel notation):
+ *
+ *	RTL8380				RTL8393
+ *	---------------------------	---------------------------
+ *	phy_write(phy, 31, 0x0);	phy_read(phy, 0);
+ *	phy_write(phy, 13, 0x7);	phy_read(phy, 1);
+ *	phy_write(phy, 14, 0x3c);	phy_read(phy, 4);
+ *	phy_write(phy, 13, 0x8007);	phy_read(phy, 5);
+ *	phy_read(phy, 14);		phy_read(phy, 6);
+ *	phy_write(phy, 13, 0x7);	phy_read(phy, 9);
+ *	phy_write(phy, 14, 0x3d);	phy_read(phy, 10);
+ *	phy_write(phy, 13, 0x8007);	phy_read(phy, 15);
+ *	phy_read(phy, 14);		phy_write(phy, 13, 0x7);
+ *	phy_read(phy, 9);		phy_write(phy, 14, 0x3c);
+ *	phy_read(phy, 10);		phy_write(phy, 13, 0x4007);
+ *	phy_read(phy, 15);		phy_read(phy, 14);
+ *	phy_read(phy, 0);		phy_write(phy, 13, 0x7);
+ *	phy_read(phy, 1);		phy_write(phy, 14, 0x3d);
+ *	phy_read(phy, 4);		phy_write(phy, 13, 0x4007);
+ *	phy_read(phy, 5);		phy_read(phy, 14);
+ *	phy_read(phy, 6);
+ *
+ * From the above snippets it polls MDIO_AN_EEE_ADV and MDIO_AN_EEE_LPABL=
E via C45 over C22. As
+ * of now it is unclear how the hardware decides if a PHY supports these =
registers. After one PHY
+ * status is read, the polling engine goes over to the next PHY. Basicall=
y the bus is always busy
+ * and the MAC status is updated in real-time.
+ *
+ * How does MDIO access from kernel work?
+ *
+ * When issuing MDIO accesses via an MMIO based interface the final write=
 to the command register
+ * sets a "run command now" bit. Between two polling sequences for differ=
ent PHYs the hardware
+ * checks if a user command needs to run and sends it onto the bus. After=
wards it simply continues
+ * its polling work. Inspecting the command sequence for a paged read on =
the logic analyzer gives:
+ *
+ *	RTL8380				RTL8393
+ *	---------------------------	---------------------------
+ *	phy_write(phy, 31, page);	phy_write(phy, 31, page);
+ *	phy_write(phy, reg, value);	phy_write(phy, reg, value);
+ *					phy_write(phy, 31, 0);
+ *
+ * What does this mean?
+ *
+ * There are slight differences in polling and PHY access between the mod=
els but the challenge
+ * stays the same. On the one hand that greatly simplifies the MAC layer,=
 on the other hand it
+ * has some implications for the kernel PHY subsystem.
+ *
+ * - Without the polling and a proper MAC status, some of the link handli=
ng features do not work.
+ *   Especially an unpopulated MAC_LINK_STS register cancels operations t=
o other MAC registers.
+ * - The Realtek page register 31 is magically modified in the background=
 so that polling will
+ *   read the right data. On the RTL838x polling simply resets it to zero=
. Other devices seem
+ *   to track the page access "magically" in the background.
+ * - A C45 over C22 kernel access sequence is most likely to fail because=
 chances are high that
+ *   the polling engine overwrites registers 13/14 in between.
+ * - PHY firmware loading can have issues. Especially if a PHY is designe=
d to expect a clean
+ *   sequence of registers and values without deviation.
+ * - An access to one PHY will need to wait for the next free slot of the=
 polling engine.
+ *
+ * Conclusion: The Realtek MDIO bus driver PHY access must know and handl=
e any interference that
+ * arises from the above described hardware polling.
  */
=20
 #include <linux/bitfield.h>
=2D-=20
2.54.0


