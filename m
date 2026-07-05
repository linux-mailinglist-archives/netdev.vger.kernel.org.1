Return-Path: <netdev+bounces-304792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kiFfMXmISmq7EQEAu9opvQ
	(envelope-from <netdev+bounces-304792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:38:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E270A93F
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:38:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=FXBXm6YD;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304792-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304792-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A12FD3024159
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421202F8EA2;
	Sun,  5 Jul 2026 16:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B726E173;
	Sun,  5 Jul 2026 16:36:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269364; cv=none; b=EhbqbZo6TBM2IqDWZKqsQTnXQFb3cOcmCl5l5lL9yGJ0D83BXE3leAzo6kjK8roYYqdDdsJIbLyyZlKHJknFJhuCf/hT1O7CWeYmu6TmPJ1DiT2aHxXhDE1xol4VNCL57e91YZZac22suA3aC4REOYj0BJZGzHJD7rI17uCz35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269364; c=relaxed/simple;
	bh=6nVhYKEjftzPGc+vl70x685/qRDHctF9PiFblq/Y+08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjHYXO5nOZNC9O3j3JtVvZ/QWUqVgvGthLWqcyVP8iiN1ncJjLXkzF4OZ+OF2kaXyQgw6G11iKu6UKGjT6em/+9m/sXyBXhhqgFRBU3aExi8C7/RMSpLzZcOY8mjUKaZsob0f0zE1jcx0Fp4viWiJNBYqrQ6VH3WE8IMW7mVwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=FXBXm6YD; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783269349; x=1783874149;
	i=markus.stockhausen@gmx.de;
	bh=QpLXBaDLKsW6yUs0Ct6ohW/WCkfIdIaqvOWhcV+bPzc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FXBXm6YDiacJ5AJjch6BEgwa7/9aKlw1QOaYVEq0VYlEeKJ7i2tPIYeJSIeqcqNm
	 D48iiAYGfg3DYRhBaUUdvLW1UZXI2+P58KaIw4hJi7sE5+HVtXI2TrJSOBCCN5Qqj
	 M7zTLmqJSh4UcVq5Dg4C8niyxqx2E6pjSRIJ2CtHffgzM7Fqw+0lnfhzj38L5cfrA
	 4aS8PJMUvMsY4s+kT6f8CSeLbleJe23hPp9CsIhK1CqFvI52uV3NwHj46xnOLIT98
	 rShnLhQSZlsYNbmkwUV0QbK/zPGGO7lTnwMi46E6e2jU8fVHtXdllkOB673M0oJK6
	 LCctqcTiL3EsOEfQDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1wiunU17CT-00803J; Sun, 05
 Jul 2026 18:35:49 +0200
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
Subject: [PATCH net-next v3 6/8] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Sun,  5 Jul 2026 18:35:30 +0200
Message-ID: <20260705163532.2853959-7-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:x+b7ihYHt1qk92jMBQfWU0r49S9TyCKPcs+K9y1KrOdRyNrvBUD
 52aFWZTpkWRbmMXvMFQaLKet43g7GcCKd6HDZPLDfEA8HAFdO6nzUu/fia4A3mrQ+Q0NoRr
 bhu/RGJCF5vmGfzFjzpnRIBE/nM0D72TBNNgRFs5EvDGaERSuT+K6tb/3gP24LYwlcmKydP
 Q1KDioGmfpeqOFu3Q9p2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7d7IK/FSRT4=;XMNLMp6xnrTDhFV2+NcKLZM3TxI
 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
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
	TAGGED_FROM(0.00)[bounces-304792-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 227E270A93F

RTL838x devices with 28 ports produce PHY access timeout errors during
one of three boots while waiting for MDIO command completion. This is
currently set to 1ms.

Background: Access to the Realtek Otto ethernet MDIO bus must wait for
a free slot between two hardware polls. The polling sequence consists
of at least 17 commands on the RTL838x devices. This delay can be nicely
seen when disabling polling completely. The following times are measured
on a bus running on the default 2.5MHz. Time measured is from the last
register write that sets the command-start-bit until the hardware
responds with the command-finished-bit set.

- average c22 read with polling enabled on all ports: ~380us
- average c22 read with polling enabled on one port: ~380us
- average c22 read with polling completely disabled: ~180us

For this bus frequency the bare hardware runtime for a single command
(32 bit preamble + 32 bit data) is ~25us. So the hardware adds quite
some overhead. On top of this comes the fact that the RTL838x devices
are low on resources (500Mhz 4Kec core with 16K cache).

Increase the timeout to 10ms to be on the safe side.

Remark! In a future patch the bus clock frequency will be made
configurable with a minimum frequency of 1.25MHz. Setting this
(e.g. for debugging purposes) doubles the command run times but
will safely stay below 10ms.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index a5cac0d04114..c73e370d912a 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -268,9 +268,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 	u32 cmdstate;
 	int ret;
=20
-	/* Defensive pre check just in case something goes horrible wrong */
+	/* Defensive pre check just in case something goes horribly wrong */
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 10000);
 	if (ret)
 		return ret;
=20
@@ -310,7 +310,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 		return ret;
=20
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 10000);
 	if (ret)
 		return ret;
=20
=2D-=20
2.54.0


