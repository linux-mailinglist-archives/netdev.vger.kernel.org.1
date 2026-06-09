Return-Path: <netdev+bounces-296905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VYvcE8ekJ2pI0AIAu9opvQ
	(envelope-from <netdev+bounces-296905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B8F65C6E3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:29:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=F189J4Cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296905-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296905-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73B02306EB0C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 05:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B291F3C1F47;
	Tue,  9 Jun 2026 05:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0F217723;
	Tue,  9 Jun 2026 05:29:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982973; cv=none; b=fKSj0SWLFiR5F/jlz0gVgzjfeJQ1T13NjZN33zh89V8PWLvq1uYR2NZ9NvVGYHVDT9uFDCQO0ApQ7WnMJtibI81cRZz/HNJQdOeSpzIlV43qXn41z84cpmq87bACLqgEttFBvOb9iMJVTLVWOd1mfQY8GMs8K3PFv009fACaiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982973; c=relaxed/simple;
	bh=4B/Ose09lmoJLvvvnNOqln2GVp6hsAwQVqpPsz5RqM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJVYApru2puCnhk5L7/WcAnizQXDV4OQN362AhO1i4ubyTFwwaArl3EnrmwFSX5HZ2LCNd2SxCqTBSBzFPcuCe92Azf85gPkm9BEDQg9QEpK8N1wxUBwNU553Doi/E8cvnhxpBX28FxQPEqU/WzXe2HuZpaZbM7t4HGIEG+XhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=F189J4Cn; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780982963; x=1781587763;
	i=markus.stockhausen@gmx.de;
	bh=/AOnDc1UEdpysSemoZYwTYPyWj1r7QfZql6uLoFrssE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F189J4CnZpR2dFEanAhSLKvW957PCSKhCRrzlWi5wjNnJbhIrnBBCoFwXN67xdGg
	 d2Q0XRtQb/QqwG6DJouN+oJdH6IzP9Nc1fEdpWBf6Sa0XJ3dtFhqLb4Bcvfa05mS4
	 poFh9f0comKR/rEOMb5SAB9o0XDYY0RX6ERR7z/VBnMCaeBEWKBtVNkA/DrZItR3a
	 DDHAS0a92cBOeeQAse+QtOQvZNHaCIsi9/yPZMREKojQfkKh2W216dAhHSAeqNdp3
	 shi7kD+9Gej26ian9F8J/ixoOGG/9PXVPdoXfCqn/1JpIVObVXo++VsSps7JH97bv
	 vlnM4vsR9IPP5O648A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1wglCB0ez6-00VPtO; Tue, 09
 Jun 2026 07:29:23 +0200
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
Subject: [PATCH net-next v2 3/5] net: mdio: realtek-rtl9300: Make otto_emdio_read_cmd() generic
Date: Tue,  9 Jun 2026 07:28:54 +0200
Message-ID: <20260609052856.3142922-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
References: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C279sYbLsVV4aDQDKuOF/GHiP80yi/ZZPCnBtZlTQa9r381i6Ce
 wXveTSljf01kwQehpL8b3xz75CdmKIXhWLGYufFhDIgWow/LxA4+FA3UBr95VohhGyLnTtw
 02zZ1FddERmn4vP4gqv/SvvB9zSomfDgIEX4EJ0+wrlYVJrsaJ+nkBy/IUPJkBG6Nf9Ml1z
 mKc9jLLpOPUJY9b47oBEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E2cwdbu+0Qs=;WkUMaNHzJAz30CoXxIvZeCRH3CQ
 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
 Jb0d7wmI0y5bTpAQW1k81gAiGMF51nJGywHpf3m
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-296905-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3B8F65C6E3

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


