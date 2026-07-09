Return-Path: <netdev+bounces-306057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0yfJM+BCT2pOdAIAu9opvQ
	(envelope-from <netdev+bounces-306057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:42:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB51E72D47D
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:42:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="MKYalw/w";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306057-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306057-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 149CC3012541
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC093D79FB;
	Thu,  9 Jul 2026 06:42:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5713D903C;
	Thu,  9 Jul 2026 06:42:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579346; cv=none; b=b5JHcg2gTf0MW0YEeXzfy98xiFOCfQgmINJ29M+XIsJCGPyEY1opz52WpD1PcPuvwWiOg/KMwypqu2qzqgI5CA6jbXzC/wsnAUi1gHf+sq2HNFPITbErccb0TE57nNWITLh4P3c987CJIskM2rXx8PpdXKFSBVxt/mLyh2dDDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579346; c=relaxed/simple;
	bh=udE+wqWDUwbhJJ8eoFcvIu5txH8yCshYEwVihKeA76E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcaOnq9e/FQYFpUspmbGeC0p0xoKKBbnnVE6YK9l3At9vh9Ay0H9PHlEYZNZoKp7Z2YMrZaFVXP2QSKZwNNVSMS2HPieQBAumJMozr/2fq9oQ8TbX5I/SE2DlRvGM2mzbp5q5g+jER782ct8mqkm0g+/3/QQqVM5+CXL9X4i3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=MKYalw/w; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783579333; x=1784184133;
	i=markus.stockhausen@gmx.de;
	bh=sXPfSkNRF+22Kh6QivjbJfLFsq0FOBxuGjccam4KOcs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MKYalw/w5KPC/O5GADAUohJHdnXNNCLs1NxAPuXaz7jKgE+B6gX2X5TGQddY8zhK
	 h3y2TZWK0yQRec5aUxIRhO9x/748Q7XkBnoeLnwnIiGSMvmtmJdDp33Krw8xhijv1
	 y7FZ4l42mpQsyBv5e/tVmF8gA3WlSLfE/CN254+ej2wcJ0Qgzv7zHmp2mYv64IhMp
	 d1wjLqy2H6iZdEfdvLK8zG9EV5BaSHU4fCEYZNCSDE1riQD5TDMxEnY7/K/JeEbhb
	 9UrW30o1k0dSGVKElFpCyiazKFvor5FF4z4QTaB4fG/9IfLdL2sMkwgfcq3POzkxQ
	 b1TAAEmiFS4apbfP3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1x5kfU09qj-017QbH; Thu, 09
 Jul 2026 08:42:13 +0200
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
Subject: [PATCH net-next v4 2/8] net: mdio: realtek-rtl9300: Add polling documentation
Date: Thu,  9 Jul 2026 08:41:51 +0200
Message-ID: <20260709064157.2865063-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
References: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gR82gJt446+GBH6eDpXurdnb9PZhbrHRfMnvMInMG//1wsvg7yV
 TY2ThJaNX4YMOtFrhMQSyMDr4TawC9SFVpDDrXgFGjByvvX5KXooU14Q204K/+t3GKvD/kJ
 DdH8fV3iQLxEXyYoVok9pScWQEe045HqlBDoF2MpyrxWR/Uk0QY/g9ZAlL1X+zw2EPOtVVN
 54gc1OGvFBanHeIRx8BGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uiiLnSbNQ+M=;68/OYnKeuTXf8W7p5AIjv7/ZSSR
 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
 ASY49pMgZv9Z2/MuBmj4LupjhBU5v/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-306057-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB51E72D47D

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


