Return-Path: <netdev+bounces-302757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fzwcEiyuQmp1/gkAu9opvQ
	(envelope-from <netdev+bounces-302757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:41:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B076DDCF5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:40:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="KiN1/xUm";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302757-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302757-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB0530D564E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92E4657F3;
	Mon, 29 Jun 2026 17:29:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23C4418E3;
	Mon, 29 Jun 2026 17:29:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754194; cv=none; b=DhVzCWrubqODTx84+PtSgUL5ucYG322zBGFU7Rq7LzIFdmkcR3IKFRvlsb66B1SS7Z+VtBLzj3+6s12+oSwPDxrdutFyXhG/N4XtrBLcMIuvZwfH+iF8vDhoM9VqclEPfru4G7YLV7a1wzdkOjNoozdmjVMZBaHpZIiuI8KZgk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754194; c=relaxed/simple;
	bh=3VAyzXNRFVIW0UFkvirrH4gHGduCRf1oHAuxOzgSmto=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=i2/oD8d9dulnejWeqEACrUwegOLT2rE8aAWzz9dE4ITlgxtfjtDpoTRQq4lRto/DZ3EyvGvrlxxeM6gg/UOnp9fskSyc7fNPqDDKJPSqwrJhgeuZ/lb6V+S3OjIfUR614m+h9pGNqdsZ0KNfA1kx60XA4JdECHoBmGd2Vn/UsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=KiN1/xUm; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782754177; x=1783358977;
	i=markus.stockhausen@gmx.de;
	bh=3VAyzXNRFVIW0UFkvirrH4gHGduCRf1oHAuxOzgSmto=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KiN1/xUm1cjQBkeyb6oi6OX5yVcYuP9CY2dhGsidhFTU7EAdoO1oj4HGfq12ywGV
	 PSEe9wZB9fw43jjuJpFIUEBlwhxFmZUxVyzaTqkjwxY2GQ/N6AAGvBO4e24IUUyd1
	 5kUEGdUMWO2eyvQZreaR658XOHaUb9U5ZkCZQvcBVWazqEhG5l6gIXUnjYSeCAU5K
	 XToUv38zAwRn+B+C0OCxdE2N6Kb8IpGJuCv2XGF1mVWugxDnC/BiUqugsKoMy9vgH
	 UPNJqv7iYghRRev6EfRcFhqI4a8q1Vh0YHmhGQo4UykF8joV/x3it/Zo1XY0TIyHX
	 /B7n3KYUeFk5FBReyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1x0TU93RhJ-017oN7; Mon, 29
 Jun 2026 19:29:36 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de> <20260629152336.2239826-6-markus.stockhausen@gmx.de> <af7ba89b-bac6-4e04-b606-8e51a61d4be0@lunn.ch>
In-Reply-To: <af7ba89b-bac6-4e04-b606-8e51a61d4be0@lunn.ch>
Subject: AW: [PATCH net-next v2 5/8] net: mdio: realtek-rtl9300: Add c45 over c22 mitigation
Date: Mon, 29 Jun 2026 19:29:31 +0200
Message-ID: <004401dd07ec$db8f70b0$92ae5210$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGLWj2oQThrBp+2CfDhF4qpCxunlgKkR+9CAraA/bC2zk36cA==
Content-Language: de
X-Provags-ID: V03:K1:L4I2Rl6X0y7r3sM1ZdNTQYM/rJBdZ9eVC0mIGRQiZbg8fqkQYEO
 q6w8tQ1XLMjBdVh8UOtwO2CY/9MEz56MsMjMqZhSt1254Rr2OtbIdMPmyne3HGyTP0e1bxJ
 2Wo0YcB7CGOSpN5xDlzNRH499Hk4lvazlJeobNo8VgAxQzWn07R21epJC57XMALLZEp2EgY
 JwRUvnFxKIjJNb6geRVMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SeQCQuYozag=;eELQRvV+xEi7QjcGM2JcOXmRAHo
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302757-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3B076DDCF5

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Montag, 29. Juni 2026 18:40
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next v2 5/8] net: mdio: realtek-rtl9300: Add c45
over c22 mitigation
>=20
> > Enhance the driver to detect this register 13/14/13/14 access sequence=
.
>=20
> I still think this is the wrong way to do this, and you should look at
> MDIO bus lock/unlock.

C45 over C22 interception only tried to mitigate a downstream nit
that is no show stopper. We already live perfectly without it. I will=20
drop that part.

Markus=20


