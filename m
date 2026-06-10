Return-Path: <netdev+bounces-297815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZSAaLy2+KWp7cgMAu9opvQ
	(envelope-from <netdev+bounces-297815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:42:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F08366C8D4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:42:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=d89jDEXC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297815-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297815-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6B9A303E6FD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5237B011;
	Wed, 10 Jun 2026 19:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903937B40A;
	Wed, 10 Jun 2026 19:42:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120540; cv=none; b=E6NYSpBWw/ZkQEFJsemMig2SBLGd6hzZ3JlCjjoTaJXf/yCGeDt8QneFhFX40IpNf+debkTWLWxIUH9mx3ZJtQ4thO0NQSJPzSR00ak91NlK62Dv3/0cEW5+ObyFNtW05afw5qMLEZ8YN4IZJRyU5fO53Q5ir2nlW0BQWSONnqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120540; c=relaxed/simple;
	bh=FANWzy49pns/6ar1htvvpBONB9idG2b7xA/cLas8mDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhIid8uKDONaISEJQZXyQEKMbc4niXRBSilXkPNcYGWmL+jLPUUlLHMEDKnV5ucODEvja4YhfPi9kUgScpJyUiOA4ZwpjySkcUNwOmw9XxnTvAQuqjiwg3mDBoZBzYRfCVQRkprJSpSAYRbCV1ZSWh6xQde6g4O6sUDiF/uF6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=d89jDEXC; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781120525; x=1781725325;
	i=markus.stockhausen@gmx.de;
	bh=1UbEuHThuWAeWQYqUOOiukoY7wVTsJbze3Ezz1q9Jsw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d89jDEXCe2WegJrk5Z+6mAYcOxajLasfXxdVb4CQ9okC8Cmq9m3g5gdQYX6kFe0z
	 Lq3uASDbsaF8wQ9Yg4S//9saRCwinM6dhBhRfObWCYszXHa+QgLTAKKZ/ZDjX6fjB
	 gFxI7UuE31Eq8hpylN+TSanEqXfW2BpiNVYV3Y8XYrZXnnUCEgBuwLr/MUAEE0Mqi
	 v172BMJ3VKC2Si1BtL1j5oGcHwcARzTcwjAf6OvC+iowCbEngN3/emz5j91phd59L
	 NYJ1w1ga2Xrs18lMcPbdYLgCqvVT4fsQUo1N2ZeuLTS1bjMJqPi4QtoOlgMmCf7TG
	 TALqEVnnESUsGaaHrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGN2-1wqi783SKM-00KcTR; Wed, 10
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
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v3 4/5] net: mdio: realtek-rtl9300: Add registers for high port count models
Date: Wed, 10 Jun 2026 21:41:44 +0200
Message-ID: <20260610194145.4153668-5-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:w9K5d5eLm1YBZguazrCliXvZh2E2xOs0Zll9r1YvTV+2zx8uWpn
 aM/nkTKpp9g0DOCQ03etCLndGwznZc6L6468T2gQ9T//rj5xF2IHYSPtxRTvrI5NSU83Lkl
 wSkEfRaUPfgBvnXngS6PxrMuM+W7eRWDl4pvSzV6jiGgKLOcmrS5DVbxjn44lJiPfCae9LT
 kl1S3sRbgyPBaJlspq1kQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XaGawlReK48=;kPe5oJz7WLoBSwrV8NpE7y/fGTc
 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
 p6wQl+zLFcQ6dWwvtIa/FpIf0V7jso/Qdujg52E
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
	TAGGED_FROM(0.00)[bounces-297815-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F08366C8D4

The high port count models of the Realtek Otto switches have additional
registers to instrument the MDIO controller. These are:

- High port mask: A bitfield that extends the already existing low port
  mask to select ports starting from 32.
- Broadcast: This takes the port number during reads on the RTL931x.
- Extended page: Some additional page info. The SDK does not give much
  information about this. Basically some fixed value must be written
  into it during access.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 5aa447ed6424..1cdf2049cfa5 100644
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


