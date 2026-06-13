Return-Path: <netdev+bounces-298956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rmLZH4Y/LWoveQQAu9opvQ
	(envelope-from <netdev+bounces-298956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:31:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ADF67E786
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:31:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=qXstrwVv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298956-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298956-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54BB030464A9
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393AB3DFC6C;
	Sat, 13 Jun 2026 11:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457923DCDB4;
	Sat, 13 Jun 2026 11:30:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350226; cv=none; b=bvhAEKFg957hKhPEYXR0ilhHXATOdepNdd86I+JqkZSjrmiAgc1zcfx1Q21vNPm9DloEARr2xlKqhJaRJVRGcr8V9HhOzF510vbR0zdx7ROM6UgjOvkyhrXkwNF2OJRJlGTab5Y5pEpyKMdVi0oazqGWMeVIZnRv9N7gzEUZgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350226; c=relaxed/simple;
	bh=W81ZTzQG/AZdoNbNXJw756mFpr6NFb63rgngg7CEOsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2lBgO0fTrhoe31v22zUJJ1wHLoASn87JfzqfOb2CQ6ttufZqLa1WWFGakJo+rdW+xcOPvVTpyEQp5ubDBI7F2PAu2HIQlpcJOEa8NgWqEjxkTKKAw26lGeCdgAMEPNbGAczRUWZnPNLvkBdOxMa9BA2YmPXRAK/SOKyXX63jjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=qXstrwVv; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781350201; x=1781955001;
	i=markus.stockhausen@gmx.de;
	bh=7ky6lhjbR66Qd9/plkYFHUdknOC/EmYASYQG6qGpp8g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qXstrwVvEGpc7QvKUg+W+bv8oeH0v2VQQhN/SP8P7BvuyMYokOfUFT3NylKks6H/
	 y757IH6XuZBu58/BC77lOk+E0v5chpwcGNdde1deKxSx3fIhipN1N6ScByvYxCCOt
	 jshPrQKOihIbhd4rixhSf0N+HV+7JaC2EzUd1WrZ5RXtvprRTgSmRweiOoQ1ZBRgR
	 /2UrrAgsywAMEL08/illQp/JVDfmOyYKyxdrhyqzqTO3AjOpbpFb4cI7cazhy6e9T
	 T7FijEzZrkXIcTCrd5BECLfc8yVwvuJffnP12zLz2XjL75VBVbiLPxuJn7ievYkpk
	 GDCvfuU5i6wTruywIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MirjS-1xAydB2vJc-00fqE5; Sat, 13
 Jun 2026 13:30:01 +0200
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
Subject: [PATCH net-next 2/8] net: mdio: realtek-rtl9300: Add polling documentation
Date: Sat, 13 Jun 2026 13:29:40 +0200
Message-ID: <20260613112946.1071411-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RQSEoEFOZVUoXU/qo9o2Mw0wae0UUFSaPhVVHJOX3s7vxFSGeBM
 Rl8fe6QUMBOM/ubMHzqNdG8pGvmlUS6pCc+s9YxCYcwgzRm1xwXl2bU7rrb43DSB85G9E3P
 StWCS92y9itEULvTUFj7U53ek9bVk8j/Z32wxFOordUz48zqXzZI+hfK81+7YxJsTUGWy6D
 aAUR48lAva6OckbmOjMXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jkura1ZkKHU=;lysL8PNk7grfkDSGZVldlZo1YKH
 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
 I7j0EZVlJuXoWa51zY=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-298956-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8ADF67E786

Add a detailed explanation how the hardware polling unit in the
Realtek Otto switches works. This simplifies developing future
patches and reviewing them.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 66 +++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 892ed3780a65..da2864c94d2c 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -35,6 +35,72 @@
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
+ * The c22 over c45 register 13/14 sequences read MDIO_AN_EEE_ADV and MDI=
O_AN_EEE_LPABLE. As soon
+ * as one PHY status is read, the polling engine goes over to the next PH=
Y. Basically the bus is
+ * always busy and the MAC status is updated in realtime.
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
. On the RTL838x it is
+ *   simply reset. Other devices have hardware mitigations for this in pl=
ace.
+ * - A c45 over c22 kernel access sequence is most likely to fail because=
 chances are high that
+ *   the polling engine overwrites registers 13/14 in between.
+ * - PHY firmware loading can have issues. Especially if a PHY is designe=
d to expect a clean
+ *   sequence of registers and values without deviation.
+ * - An access to one PHY will need to wait for the next free slot of the=
 polling engine.
+ *
+ * Conclusion: Kernel access to the PHYs must know and handle any interfe=
rence that arises from
+ * the above described hardware polling.
  */
=20
 #include <linux/bitfield.h>
=2D-=20
2.54.0


