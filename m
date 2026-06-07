Return-Path: <netdev+bounces-296236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CMZlAR5qJWoEIAIAu9opvQ
	(envelope-from <netdev+bounces-296236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 14:54:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A863765092A
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 14:54:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=WTPSZ4yD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296236-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296236-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22DEB3004908
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7C13A718D;
	Sun,  7 Jun 2026 12:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D923A641D;
	Sun,  7 Jun 2026 12:54:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780836889; cv=none; b=ANZ4ShGxiFpp3dX9L+9Y8Xy5QkKjg4bi77hjbLyoKR8RGRVP14rbJqhtqmFLCsR7Jgj93PH+YPnzngRsjeLJVAv7tjigQtVmZ5GkKkeee8Nn0uXYyC00nq17LN3Qo8sa1Ld6Etr3yZCxwPP3GU3AFfN1t0fxT5ZrtVOG8lbZ1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780836889; c=relaxed/simple;
	bh=4B/Ose09lmoJLvvvnNOqln2GVp6hsAwQVqpPsz5RqM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4jxU61ihOkY3D1bF+ANd7KqBMil9/o6FITHqTjDhjmaqY0MPi3zFkg1S1xntoiCCtttxBvgWLqnDLdBzW2Qh30G7d3IT1jScEHXtLQLbqIY/Bh+Y8zuY05i9XWp1FNuy6YKns6JbZwjpH7cbUMm2FjFq/49pTAKARBs9BCPF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=WTPSZ4yD; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780836866; x=1781441666;
	i=markus.stockhausen@gmx.de;
	bh=/AOnDc1UEdpysSemoZYwTYPyWj1r7QfZql6uLoFrssE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WTPSZ4yDQ/RiuNGzk2YVFjm+EMYzW2AIAigTVrblc/mCPMP4Xgol8lMvo1wuyCrA
	 G6k9VWpF6m+R6wXH5VmELeKpuH1TQ1vtgIGbsTjp+Br+EzScIdAUQq9DczmjqvDfa
	 Th8tiAjSs20vpeUUkTEwdkbz6Nq9LSpeojxgk7jGtIflQO7MK5qK+Tl/bcpU+J5B0
	 t/R7G82uASiAOfbNCUjHwAARBG2TXmkRhF/MxHIjtBd3sJ0xrTuxhjfWz68oBwIcu
	 ZCcVcZqcDk/4k7Xp0P70TA8JjxwH/cvtQiCSzp7lFCRNilagZr9RDPFydS6w1O68m
	 zEapuNokMgq1oC0OAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1x3aqP0IpP-00bWb1; Sun, 07
 Jun 2026 14:54:26 +0200
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
Subject: [PATCH net-next 3/5] net: mdio: realtek-rtl9300: Make otto_emdio_read_cmd() generic
Date: Sun,  7 Jun 2026 14:54:04 +0200
Message-ID: <20260607125406.2853607-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607125406.2853607-1-markus.stockhausen@gmx.de>
References: <20260607125406.2853607-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CixZUpynG6uQKaWbUzrpxccMSOIDjfO3gi35VyDr0+pKr/HX4bV
 7vvdJUfazvWQjLfVnxFNL84YK9KJ174aP0MS8yaYxpkbIqqQn9IdmwaAnEVs2Fo07TSdoBL
 uAHXOelJzZ/cyjJ63+Y+5Q1nGWia3OaxY168MdvdXtJ/QiuXHAKfwviTxW2Pwfhi4QFUlmb
 d40pX4LjAHzD6JmfuwNlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oKNf3bIfFuE=;GpBprzF1RklRAyUx9NWj6EwM1YF
 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
 nJT76R+h+vrK2OdrLEzxYV8raf/0hNH5gUWnqNF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-296236-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A863765092A

The otto_emdio_read_cmd() helper still uses RTL9300 specific properties.
This cannot be made generic as the I/O register has different layouts for
the different SoCs. E.g.

- RTL930x: data in bits 31-16, data out bits 15-0
- RTL931x: data in bits 15-0, data out bits 31-16

Add a mask parameter to the function signature and fill it properly
in the callers. As the masks will always have bits set from constant
defines, there is no need for a consistency check.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 007a07136fa1..0068beff785b 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -191,7 +191,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 }
=20
 static int otto_emdio_read_cmd(struct mii_bus *bus, u32 cmd,
-			       struct otto_emdio_cmd_regs *cmd_data, u32 *value)
+			       struct otto_emdio_cmd_regs *cmd_data, u32 mask, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	int ret;
@@ -205,7 +205,7 @@ static int otto_emdio_read_cmd(struct mii_bus *bus, u3=
2 cmd,
 	if (ret)
 		return ret;
=20
-	*value =3D FIELD_GET(RTL9300_PHY_CTRL_DATA, *value);
+	*value =3D (*value & mask) >> __ffs(mask);
=20
 	return 0;
 }
@@ -230,7 +230,8 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
-	return otto_emdio_read_cmd(bus, RTL9300_PHY_CTRL_TYPE_C22, &cmd_data, va=
lue);
+	return otto_emdio_read_cmd(bus, RTL9300_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL9300_PHY_CTRL_DATA, value);
 }
=20
 static int otto_emdio_9300_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
@@ -256,7 +257,8 @@ static int otto_emdio_9300_read_c45(struct mii_bus *bu=
s, int port,
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
-	return otto_emdio_read_cmd(bus, RTL9300_PHY_CTRL_TYPE_C45, &cmd_data, va=
lue);
+	return otto_emdio_read_cmd(bus, RTL9300_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL9300_PHY_CTRL_DATA, value);
 }
=20
 static int otto_emdio_9300_write_c45(struct mii_bus *bus, int port,
=2D-=20
2.54.0


