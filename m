Return-Path: <netdev+bounces-302694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TetAKDGQQmo79wkAu9opvQ
	(envelope-from <netdev+bounces-302694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:33:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 142736DCB97
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:33:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="ReZXB/kS";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302694-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302694-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE48530CE480
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2B142B72A;
	Mon, 29 Jun 2026 15:24:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDB429817;
	Mon, 29 Jun 2026 15:24:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746646; cv=none; b=achXdMYrJ2DxYvWjIYVM0DJ1hbmz1sA5ggF4VILORLOrCaAeh+vfqJWT+qymb7rSCAWJCUPkUSHKedJkjScJfipK3ZnX6UwCYpEwUkSDEQJmow+av3A22mHGizqfDrgMOEyp8/xyMLeD4SWKL3oIZN+UvAgcre+boWEKfBz+un4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746646; c=relaxed/simple;
	bh=Oq/l+OFFrhG7Q8vPt5q4kolKbBAXqlPK51Qx+bIJvuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBizRsAwLnTH0EX7xbQ5pO4BNQjDYqUELLDNRydaOH6cTYUSjN/xi48TjmoaZR6pmXfsMBQbi33yGzGjg2wLarcMdg42mCUF1klAi/FKHByZZIEXKziSqSrSNamESG0cP9QnYKDN+fr+T07kpfNmGF8+zv7XvsyYFIcF6clAssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ReZXB/kS; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782746631; x=1783351431;
	i=markus.stockhausen@gmx.de;
	bh=YTOJ3qaqKe0yZ4n/G3xBHtMvvgVq1rBumZUZKIjbFdQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ReZXB/kSS5Nz8VIvFbWB5sqgGxmacCSqqR3ulUkpsEZp1cmh3CU6I2EqHurgtWI9
	 jASiGr+t5nUZs0vWv/GvJaauTQKuhuteQALUjv2oh7deFrMLVhkuhHO58ZY4yIpZ6
	 x6xIPcLkktDnC853XmBgCt8WHFcR387eJUJg8VXRcQqOxHqpDrUJMurRqrT86/xgg
	 c07eRbbkpLKk3n16u9dU0pJxzTZTbrFEhKEo5ee4OjC8jMybp6TJ5G9tOzh/EGCkC
	 va4wKeH7vzywtlvbe9J2bU0zenRICNjzo2DVrBWs6C4iuofURIiroUnR7VlixkmNw
	 nGdc2jrPQW56BaFBcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1x9p7g2MuV-00yROf; Mon, 29
 Jun 2026 17:23:51 +0200
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
Subject: [PATCH net-next v2 1/8] net: mdio: realtek-rtl9300: Add polling documentation
Date: Mon, 29 Jun 2026 17:23:29 +0200
Message-ID: <20260629152336.2239826-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TByqUupP4bZPAvVrGpoaW5VGSDy/NsIYapC0J0g9EumlFOhofli
 AMPO1RuA/F1596mO9enWlPJ32DDY8fmrf22V3Yiuo/m/7z6UtHUiQxMlV9v5L3nqI+9Qg4W
 z56Rhd+habNiYaxPmy3QV+KfIovf2o/eXCr3pL7KJn+mw84TfFZnZmue5wD+4Y2+sFbOPST
 NQOHjrhp2cZxjQvPB8Hfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x4ghZ+0i4nQ=;W76ba/o+DDylu/PXxkqA1792oH0
 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
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
	TAGGED_FROM(0.00)[bounces-302694-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 142736DCB97

Add a detailed explanation how the hardware polling unit in the
Realtek Otto switches works. This simplifies developing future
patches and reviewing them.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 66 +++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 892ed3780a65..6ece095d7e97 100644
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
+ * The c45 over c22 register 13/14 sequences read MDIO_AN_EEE_ADV and MDI=
O_AN_EEE_LPABLE. As soon
+ * as one PHY status is read, the polling engine goes over to the next PH=
Y. Basically the bus is
+ * always busy and the MAC status is updated in real-time.
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


