Return-Path: <netdev+bounces-296232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fTW+BgpqJWr7HwIAu9opvQ
	(envelope-from <netdev+bounces-296232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 14:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 629DC650912
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 14:54:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=GgkI0z7H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296232-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296232-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2988301039F
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 12:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46F32D45B;
	Sun,  7 Jun 2026 12:54:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BC28CF4A;
	Sun,  7 Jun 2026 12:54:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780836871; cv=none; b=Axv3nanWPzdr9R8haM5NW103q/dFj0nyXQwqsPUdhzh9xlDCba3+zKaUYrpuEQ94Wj6bZ9GmmjTmlsSEpBIh/4vZtAjByEB7bR24rwTG3VJIPeNyOj2ymbpTJ+Orc/XXCRplrupovnT7z/ubdGtW7CqlcVbwki/J8Vwdd/UcRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780836871; c=relaxed/simple;
	bh=+lRvBOp/Dwzk5vV2sYqqF2hEGk5Pwk2bDAgMGR5T0qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUgfPgxI+UbycYETWePP49kV4gAVdtoAN/x9QSOXG9o9Q2G/3mS1zyu/llNyNfFaiohc7W6o8HROv/QycEameuOTcG86hXZUQ+U8Odnt9HTMsVsfoAmOH7WxM02H9xTrIQZ+9uSYS8Y5qZhgkpRi5+9XBXIghiN+V2bVVsvn9GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=GgkI0z7H; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780836867; x=1781441667;
	i=markus.stockhausen@gmx.de;
	bh=Bp9/zefXrRd6X1kk3OzynOOUpcVeF/x2FfMlDe3iDyc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GgkI0z7HLXxLWJEtuJbXZ8FOkT92IAMsE7rcj7cmsrRzsaY1rSsRXbFld7Yk6CMW
	 i34s2j0jBf4G6fXgFdeL8ed8xXjMRH+UA1jbeS/z6tFQnZZYfUk78Y2/v5zTQ4Otj
	 UmUlZM924MhqOiBhU1n7BRAyW+xRdmBTnRmkCr7GIqVTguPOjTvAKmUumFGP1PJCd
	 DzsbqtYqid2XulchTIglKL861p/ROtYb4MlVwtkRZBb6xkpOzoPnmXsk3JIn+idRH
	 iaJ3pqSm6/ZSKktek2a0TiQTreOOV1HIJVLjFCXJ54eGOUObtuHik3o0HiyfnOG7E
	 VqBYDMmNG/pl0o5ICw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwbp-1wPID53VNp-007OZx; Sun, 07
 Jun 2026 14:54:27 +0200
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
Subject: [PATCH net-next 4/5] net: mdio: realtek-rtl9300: Add registers for high port count modes
Date: Sun,  7 Jun 2026 14:54:05 +0200
Message-ID: <20260607125406.2853607-5-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:/YNwyctFQ9dj0VzaNCKvS9lVk5vvHWze6vClF9UwTeYAQXWyy41
 Fm+oKlGzBm9miiNcIjO7etOv/2zZry1BGEq8rpbioCYAA8gAYINdMVZz6QvqzForJQYMWD5
 +LhqcprCRLrPRgHkmrnS4uudurzLkLWdnp7EsdofHAJtfShCT+D6ln1ZaHzDbzOlm0YuWQU
 MXRWNlPfayXlUb+B8YWOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:10oNNGqhRto=;OzJSMSB6s1rTYcWhcMFwl3KeLI7
 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
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
	TAGGED_FROM(0.00)[bounces-296232-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 629DC650912

The high port count models of the Realtek Otto switches have additional
registers to instrument the MDIO controller. These are:

- High port mask: A bitfield that extends the already existing low port
  mask to select ports starting from 32.
- Broadcast: This takes the port number during reads on the RTL931x.
- Extended page: Some additional page info. The SDK does not give much
  information about this. Basically some fixed value must be written
  into it during access.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 0068beff785b..33c00b6ba8f8 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -91,6 +91,10 @@ struct otto_emdio_cmd_regs {
 	u32 c45_data;
 	u32 io_data;
 	u32 port_mask_low;
+	/* additional registers for high port count models RTL839x/RTL931x */
+	u32 port_mask_high;
+	u32 broadcast;
+	u32 ext_page;
 };
=20
 struct otto_emdio_priv {
@@ -164,6 +168,22 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u3=
2 cmd,
 		return ret;
=20
 	/* Fill all registers. Hardware will read only the needed bits depending=
 on command */
+	if (info->cmd_regs.port_mask_high) {
+		/* Fill extra registers for high port count models */
+		ret =3D regmap_write(priv->regmap, info->cmd_regs.broadcast, cmd_data->=
broadcast);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_write(priv->regmap, info->cmd_regs.ext_page, cmd_data->e=
xt_page);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_write(priv->regmap,
+				   info->cmd_regs.port_mask_high, cmd_data->port_mask_high);
+		if (ret)
+			return ret;
+	}
+
 	ret =3D regmap_write(priv->regmap, info->cmd_regs.port_mask_low, cmd_dat=
a->port_mask_low);
 	if (ret)
 		return ret;
=2D-=20
2.54.0


