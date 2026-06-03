Return-Path: <netdev+bounces-294868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XykGHOlrIGra3AAAu9opvQ
	(envelope-from <netdev+bounces-294868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC7663A593
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:01:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=RYRXPyo2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294868-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294868-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F62D3087723
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394132C92D;
	Wed,  3 Jun 2026 18:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599B37D131
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:00:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509626; cv=none; b=fFpHwl5DnIpHEhu9mMzAdiybVHbrvUsHoCfS5ruBR0bVPYtXVK1vKCzGk0ZsoCz+H8VmRN81xPI6L2U+vMgYepbJ2UmLV4lBLOSjf7BwAwc7CgSTCfcKNTGZZ1KcHUCYXoIOa3B2SDLA23Mq7pSE9UnaKKbBhwM+4wvOb4TShHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509626; c=relaxed/simple;
	bh=1wDrtQp866EHEKRXgiZ7r77h79MBAivmZ/r2Pon1rW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXunhVEwNDtDaQ5zwHG77248RdQr1jF7Xs/DYXyw7iwDB6ECK2AGXd2wmISXxZzg1KUYkBqqJ2aY+dN4VDeMHXWdqDE0rwF3fm29W3/VhccVlJ08tuirZr6nfYC1xMTqoJv9EuN65HOpVbpHCvf3VW7PnAODDD4M+FEn01eT1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=RYRXPyo2; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780509608; x=1781114408;
	i=markus.stockhausen@gmx.de;
	bh=6q5y1Rzw/bGau21DgQN+cp+hIQMCKDQ9TCA1azkrr9o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RYRXPyo23nQM4KZCAgCfvUzX6/jAvTkrYTKUpu4HT/CYuPuXWYMbO+WEa7628pk5
	 XCDTWDDShgRRb7vdBAZopTVVmnnMu7Td7pU65cRrbxzTCMKxetqK9uwlt4HrlCIq4
	 1yBapo2jVF5tEJ1TjmL/yhZvXV2j7KokhgGZ8goVJXEyPhKbdtGt2vyP2zBxJstz0
	 TMIF3aH6zlzsHECv39Myr/2rhvp2UkTLLFdrpcrb5oDb3h0PK0cPGiU6vAV4mgQFs
	 quNrQwTInJuVQxW6BV0QXUIhb+KDXg7cWUqm+emCac01cSoRCfKWXBbt8no5ovSpK
	 NYwivVhG0nRbj6aArw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1xRUon1E6n-013fjD; Wed, 03
 Jun 2026 20:00:08 +0200
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
	mensi@mensi.ch
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 3/7] net: mdio: realtek-rtl9300: harden otto_emdio_probe_one()
Date: Wed,  3 Jun 2026 19:59:20 +0200
Message-ID: <20260603175924.123019-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603175924.123019-1-markus.stockhausen@gmx.de>
References: <20260603175924.123019-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MzVaZBoO3thzWLlr3HlVe/tZ0rT0BB/cBoMeBKEpl0H32/EmMxa
 w+7t7xtD6UkrOCl+xqUIKHNmhpVmE8INIieUAZpdsJ75vKirSfWwsXwqGohQcBTLRvn79VF
 Ds9uCO1TfKW0AnmZji/J04oOCRe9h76vLbCkenzxCMjAVOgazHm6tKNOlohsMbxK84RzCAq
 hvpRlHM8Q5cHjPRF/NRGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qYnTLsqGHDc=;EW/+R5Nrkz8yvWIiuKH0CKmlipX
 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
 dBnXq20BHETHkrakY0=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,m:markus.stockhausen@gmx.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294868-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FC7663A593

The bus probing of the MDIO driver uses a two stage approach.

1. The device tree "ethernet-ports" node is scanned to build a mapping
   between ports and PHYs.

2. The children of the device tree "controller" are scanned to create
   the individual MDIO buses.

The first step already checks the consistency of the PHY and bus nodes
that are linked via the ports. But it might miss a dangling bus child
node that is not linked. Step two simply iterates over all bus child
nodes and might read malformed data from nodes not checked in step one.

Harden this and return a meaningful error message.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index ba4151fbae0d..aa45b0e92216 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -380,7 +380,11 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
=20
 	err =3D fwnode_property_read_u32(node, "reg", &mdio_bus);
 	if (err)
-		return err;
+		return dev_err_probe(dev, err, "undefined smi bus number\n");
+
+	if (mdio_bus >=3D priv->info->num_buses)
+		return dev_err_probe(dev, -EINVAL,
+				     "illegal (dangling) smi bus number %d\n", mdio_bus);
=20
 	/* The MDIO accesses from the kernel work with the PHY polling unit in
 	 * the switch. We need to tell the PPU to operate either in GPHY (i.e.
=2D-=20
2.54.0


