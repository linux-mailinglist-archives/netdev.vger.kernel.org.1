Return-Path: <netdev+bounces-296908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k3axC/WkJ2pW0AIAu9opvQ
	(envelope-from <netdev+bounces-296908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:30:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D265C6FF
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:30:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=FisScLhT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296908-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296908-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A768C309D622
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 05:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0D3C3C11;
	Tue,  9 Jun 2026 05:29:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD983C1F4F;
	Tue,  9 Jun 2026 05:29:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982990; cv=none; b=gtAsjlaDQTKi+hg6vFMcVTKUUM3DAMpXT8fR3oyVrZ7bkaomrD7Ba/02kRXD6rV4NLmZDpmtd4WuQ66cCtcQ1el209+p+483DOlCGl4H1k+DVRRql2xKdEbQoAj1jLhpaU+SXMqVW5UnpE7fYnDWI7Ka9viURcCWK1E59jXYjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982990; c=relaxed/simple;
	bh=+lRvBOp/Dwzk5vV2sYqqF2hEGk5Pwk2bDAgMGR5T0qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu65zE0CqDNsHxsbRxTkxcro+NnO46ZDEnwu1GFpShy16FHHVygMRLGBydzK+t8Ke+FlD3KTrXjYB+vVLrqTLbnQiagPAg/78n1tZi0FFofsPiZWrCS5QUySESDmhy4FS5pYQcnL/CABnm+KO+IwtwJuSotUr8I3QXXZ6TijsIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=FisScLhT; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780982963; x=1781587763;
	i=markus.stockhausen@gmx.de;
	bh=Bp9/zefXrRd6X1kk3OzynOOUpcVeF/x2FfMlDe3iDyc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FisScLhTVy6szl+fDbZLbjP/rdg6u1Fwe/sQpFDC4tiQ64/l94ySbu3FBBoWWhYS
	 L6nsdP5q2d4fgdKfeVkW9V8uGydQdSXcXRbrdnftVPNPsszFwS80JLmcPJ+K5Iztw
	 6w5gz36t8mVOc7ig+mVJ40Kg0giQrE4H9NzRXGp0OTUyWc+DR+tqTAJH4/i2Omfxo
	 mU/hI/sTFk5i0I3uP1wykTJ7tjKCl83JxRsujBvsJwRPJr6WifWRSw1VOEBnulu1R
	 YXi8pDyhWbsupsAyaxNPjbUarTpLdgEFYORx231abWKRY/RrTT8JbjSVPp1cCj68j
	 mrnUCZNquB6zw5l51w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bWr-1xDtU82SId-017nBJ; Tue, 09
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
Subject: [PATCH net-next v2 4/5] net: mdio: realtek-rtl9300: Add registers for high port count modes
Date: Tue,  9 Jun 2026 07:28:55 +0200
Message-ID: <20260609052856.3142922-5-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:5oVnhpwi7i7Yb8UnLCbZm3jv7XIWwvRmFSuqlj9VGlRfMbj42bB
 mHSxTrbS3lEeRloMhgJZHqkKTBz4/sXM/adaFtxeXjD6vaccRXsmg8YXEO16ZJ0ZDVfj1Ys
 IijyyCheoaxEGt5QWvy1e161lRqxNFx4Ai21JSu3vvyn47uurMxsdXxet2MfVk/r0smLrP+
 +n6vmmh7eOtt72HNCZv6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LxovfYLGo5I=;0Wce/Lzd91PTz+MWSFoQKQ2Tcj6
 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
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
	TAGGED_FROM(0.00)[bounces-296908-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 9A7D265C6FF

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


