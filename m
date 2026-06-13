Return-Path: <netdev+bounces-298958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HRU0Jp8/LWo8eQQAu9opvQ
	(envelope-from <netdev+bounces-298958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:31:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2191567E796
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:31:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=g0PaciK9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298958-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298958-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED637304B92F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684BE3E009A;
	Sat, 13 Jun 2026 11:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67C3DCDB4;
	Sat, 13 Jun 2026 11:30:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350229; cv=none; b=IGTyerDl0t9JJXRwAW6XNW36RvfgIjAsDL+jFrH1tairDXw7xG82k4oCYSp4GElOoGoI1ddndUicm99bO0wb1/pE1o7Z8SZatbCZGd3apw0EFzBQdksYtX6bz3Iuoqef2NKhci1mWW4miCdNu0XRPC5EO0goObex2D0RCQYugik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350229; c=relaxed/simple;
	bh=DeSBOBHdJ+JhEvZHVlub9uSu/2ekyd9ANd5D/aJxbqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQf1AtSJtr/zCK8u0jMeiQhGcM9cSNYWO+40qTrI7ufOQFrwxJ5KeCAq13KF6Ynm94fkGZmboY48aEtsyR6DhwBIBkqiZntpLgMC9tjjdVND4DWTAfLkCIIcJdOga25tKcDIQA1memLDrj5NMTeWdkuTxHboKoxrCZNzF6p9LMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=g0PaciK9; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781350203; x=1781955003;
	i=markus.stockhausen@gmx.de;
	bh=avEC3/tK6npv0W+IKpcRD67BpcJ7zbhtPpKyKOeRIcc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g0PaciK9/F07baBzQgHoymoH85AMoj0MHsQdieJeO08XKf+/zT93TEmNPZVscetK
	 dIcPA3/fhfk6LP6FZlfXoi6YzXNbvrFsTrg/RRbC67TqQhVETSMtkt30woVeSRYG1
	 DrWsLiKHGhi8a2JseIGxnXHi4ess8SZD4wqSSkJiVucOsIuvBgrS1I0SvScPRWf3Z
	 GWshz5O6VV9EMJLrkaayNdrrTDxqWCFbhiPsVTsRg/r0w8mn3XlPqiptcDd7RK+qR
	 FbwBMjjhrY0q+nbNP1fJ0rg8ceicHg0G9K15c1y3D09AAXh/s+WukDm2I3yF/SXgX
	 D+UDZSPlOBXROhG2Ww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1waXLf008e-005fzx; Sat, 13
 Jun 2026 13:30:03 +0200
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
Subject: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Sat, 13 Jun 2026 13:29:44 +0200
Message-ID: <20260613112946.1071411-7-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:RyTOJAVhQbolkEQhSy3g09Ses6g+qU6R0AlLdjk48vSUwZ1oMMA
 74V9CrHHKH8G2xh31W9D0RAptEepeOdwsDR3SM+lvdaGqh4Ed14afXmHYSEPq0WQNgLebHV
 AWfB3bcNd5vToc2o1Bi/Hk763OaECWkFxIgjV0TU97F7h+DjTN29N6Mx51uAZHMt9udAgqc
 L2cGERw3Dd3OXxwcHVxIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Npg9w4ccFXs=;3Ddwf5N3VDnSJ4e/0HNkIulC8rQ
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
	TAGGED_FROM(0.00)[bounces-298958-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2191567E796

Access to the Realtek Otto ethernet MDIO bus must wait for a free slot
between two hardware polls. The polling sequence consists of at least
17 commands on the RTL8380 devices. This delay can be nicely seen when
disabling polling completely. The following times are measured from the
last register write that sets the command bit until hardware responds
with the command finished bit set.

- average c22 read with polling enabled on all ports: ~380us
- average c22 read with polling enabled on one port: ~380us
- average c22 read with polling completely disabled: ~180us

With a default MDIO bus frequency of 2.5Mhz the bare hardware runtime
for a single command (32 bit preamble + 32 bit data) is ~25us. So the
hardware adds quite some overhead. On top of this comes the fact that
especially the RTL838x devices are low on resources (500Mhz 4Kec core
with 16K cache).

Analysis on a RTL838x device with 28 ports gives PHY access timeouts
during one of three boots while waiting for command completion. This is
currently set to 1ms. From the above explanation one can see that there
is not much headroom left.

Increase the timeout to 5ms.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index e206ee3e2b1c..244af5fdeaf3 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -302,9 +302,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 	u32 cmdstate;
 	int ret;
=20
-	/* Defensive pre check just in case something goes horrible wrong */
+	/* Defensive pre check just in case something goes horribly wrong */
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 5000);
 	if (ret)
 		return ret;
=20
@@ -344,7 +344,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 		return ret;
=20
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 5000);
 	if (ret)
 		return ret;
=20
=2D-=20
2.54.0


