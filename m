Return-Path: <netdev+bounces-297819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nz+bG3i+KWqQcgMAu9opvQ
	(envelope-from <netdev+bounces-297819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB8C66C8FE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:43:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=X5ztV0D2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297819-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297819-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 072933208C6F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA2A374E71;
	Wed, 10 Jun 2026 19:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90B3793BF;
	Wed, 10 Jun 2026 19:42:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120555; cv=none; b=FTkW5jtWlqPsszIuqtzIBp3FckwvFiXlHUJw/ozqmUzbc84xvSBmf0QJhUjT2fKUAOX8Ix6obLnu2ZZWREnekuZEi2H9TQdIKtPOOcNsnw6DbdhhP4pFN4dx92Ls3vuV3JvE9Bt3zKwR2YkFBE/w3U5t0GEa462poCiSkLH70R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120555; c=relaxed/simple;
	bh=9iFvjJ2PJ/Jac0i+t1AF2VXApCbG1WRZTP8GuKtN9Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjnDdmrVBm1MHUzetZwWvM9B3Ry03qDFB1QVIQiyDrbMjGqqyjKYS9VpWdRxfgblyx7B28ZtFGnkRJAGO88y8Sf2/nc1JtvNQeQzlWcbdPfxVaL+JXvMFHiPrRHclQ8Bf24RzXHPxiT/7gxz324m6L1x+bTrwompQFafbjVkuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=X5ztV0D2; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781120524; x=1781725324;
	i=markus.stockhausen@gmx.de;
	bh=ni0ttP217i84F4X2nAN9r76/QQ77c4cSyqiQ5/uyHgk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X5ztV0D2X8FmHlnuLFvpfMvgXb+01fNfkTdfqZv7c4KQwqxIfeBG1DmNv0I6YLRy
	 oSX8MTB2ZTjH49v3gyVGkfUQ3YeMw3ycJmbDzFLYC8hi8FmDLwZS0ueJoMK7mLPku
	 GVhY6nCnmk3zxHr8I1jJQhCtuMsMi1J+zcN4QDpJd36c8ToFr6h+wzCk/OGxu374V
	 IrUiX9WUmVGC4m8vNlQyJPe7fSWdZeHtO4B/iolGpM5jblNLPGNXJtZRsFlFgzJKM
	 34+pJMl9cBU6Eo9dP37kVtDBgLMwu+KNqmFay5mk6RqP16KwMkoKgHE8OVK0BLddN
	 Q1jrSs8YLBGXS6Eyhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiHl-1wsbvX1tAV-00N4F6; Wed, 10
 Jun 2026 21:42:04 +0200
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
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v3 3/5] net: mdio: realtek-rtl9300: Make otto_emdio_read_cmd() generic
Date: Wed, 10 Jun 2026 21:41:43 +0200
Message-ID: <20260610194145.4153668-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610194145.4153668-1-markus.stockhausen@gmx.de>
References: <20260610194145.4153668-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oYhGrbPaY1TkHbKPCy2r1sO5EkVGRSuKMIkHWP2n452rXD1t08K
 MRd2D/TAdvhbE+aKRXkIQHGONDPXlJlhuZpoVZ6BvN9+/u4v27dV1DkhMzphtx3wDoGmB9t
 w6eLEgY/Zdk9/Kfc6N7XO5gvwYFwAVlEaFkEYiG1JxR3nY3BMguowOPdkDGXAdBVcJ6YxdF
 +apytcoNkDvqlfNn3DCSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WgJG+beXqAA=;RifoAogJzZ9Hn/FVHUz1Bi0B+1z
 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
 +5cafJz+bzTrSxvPfnzzFrpWuyeuPJhvzBp4+hY
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:maxime.chevallier@bootlin.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297819-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,bootlin.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFB8C66C8FE

The otto_emdio_read_cmd() helper still uses RTL9300 specific properties.
This cannot be made generic as the I/O register has different layouts for
the different SoCs. E.g.

- RTL930x: data in bits 31-16, data out bits 15-0
- RTL931x: data in bits 15-0, data out bits 31-16

Add a mask parameter to the function signature and fill it properly
in the callers. As the masks will always have bits set from constant
defines, there is no need for a consistency check.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 007a07136fa1..5aa447ed6424 100644
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
+	*value =3D field_get(mask, *value);
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


