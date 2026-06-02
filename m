Return-Path: <netdev+bounces-294390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gLgVAoM3H2pKiwAAu9opvQ
	(envelope-from <netdev+bounces-294390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:05:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC6B6319FC
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:05:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=TdoWxdUC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294390-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294390-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A3FB30290A8
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9B2350A35;
	Tue,  2 Jun 2026 20:02:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6C2E173B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:02:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430533; cv=none; b=HekE8okN8HbU797kkrzHlBxXiMoPUDOMOoNsEspdl1fi6vpMIqB/qo4AaKJ0sNFF0gPcs8OwTAtayWCMu5HgLBRvVwAf1bigg3lds6UHoTsjRwiz3SJQxdQ5izoOCoLzytV9TDIpyHk1jhCIO1/iwEUKGAJY0K5/L+ML60eOIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430533; c=relaxed/simple;
	bh=/KgGslFpRIkKLUg0bNPR5Y77PcoABFoqOhKg/7kxl/0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GDB9wihkEzW2QBvEKBS6lLmgV0ALldg/dODjI1YmPpFYt2Dakw1Ob/pu30imIqXnm1tuhgCF/8j2mVGbU6XwGTIY5DqMsAFycvsQdRIH3ausXqY4XhEpPN05QI9Z4sNuq6A+TD2ub8xgPrR0JYYfz0Gu5XkDn8uJBWQcGhsfaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=TdoWxdUC; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780430528; x=1781035328;
	i=markus.stockhausen@gmx.de;
	bh=KeLN091uqpBOu0JJGf78fo/VFDKq44kG5jPZMAau6gw=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TdoWxdUCu4OlPKpS2f17yetmOj6cg3YLvuk9J7hGu0Am49E3deS+ozdaJkbILBvk
	 PxzZ4elIRTUJ/JF/fb4wmY9Cy4eR0+2kcOGnGykZ1RFqFFkHiU6i6ztEUXxsd75wS
	 Llm7Gilibrrc0kSp/Ke4MMKQ5qD5dPIBW5aM2k62IgWZ09N5gO77AJnIiZlfDeP8/
	 izgAky+YO+1gN9k6yW/asbDds6Clhj8vSm5qWP3W5NxQa60lYbt110/cPRfk6pM5L
	 bmJQ5k8dqSAdKyn/imT+Fm85lha6fkWsLFZunccrXcvlCiqhoOjJ8ci0COOdoAmw5
	 uteb4Et6ArLUbUUgOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1wuNtq1qJ0-00MTCH; Tue, 02
 Jun 2026 22:02:08 +0200
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
	<mensi@mensi.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de> <20260602052640.93083-9-markus.stockhausen@gmx.de> <6ae0d4c1-bc9a-4972-8d4d-b1580a4565e2@lunn.ch>
In-Reply-To: <6ae0d4c1-bc9a-4972-8d4d-b1580a4565e2@lunn.ch>
Subject: AW: [PATCH net-next 8/8] net: mdio: realtek-rtl9300: Convert port lookup from O(n) to O(1)
Date: Tue, 2 Jun 2026 22:02:06 +0200
Message-ID: <013001dcf2ca$b1b188f0$15149ad0$@gmx.de>
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
Thread-Index: AQCd5JwkUMOmloq9EQ3T8rs5/ndXAgFAwMTnATh1A7C4lf2rUA==
Content-Language: de
X-Provags-ID: V03:K1:V7Oi3HNLJAiMUg+KzUzdN6Fo6OeCqsGVL6GE0zQDPvmROVw9fBY
 wKzVaA7G3UqgBc+9AHLmimHedyzTFQCi1IQ/LB7kf6P7OR3N6y3Gr6xk0kX4B7/9FugmxDP
 tmxkQ0Lbbu1UE2IhKm+f+55XgY5XkJzFLSA0dmZPrsfRW22M73uOJEjB5zHAEFLG2leJegR
 2gvKxqViVwAJwYYnNN60A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rt/ZzfSJktw=;LMuksM03pHI+/VIoS3g/fgVjgwX
 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
 2Yil8g==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	TAGGED_FROM(0.00)[bounces-294390-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFC6B6319FC

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Dienstag, 2. Juni 2026 14:30
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next 8/8] net: mdio: realtek-rtl9300: Convert po=
rt
lookup from O(n) to O(1)
>...
> > Create a reverse lookup table per channel during setup. This stores=20
> > the
> > (overall) port number per PHY (on that channel). Take special care=20
> > about absent ports that are missing from device tree because of hardwa=
re
design.
> > Save memory by using s8 type for the table (-1 =3D absent, 0..56 =3D p=
ort).
> > Convert the lookup in otto_emdio_phy_to_port() from loop-based to=20
> > table-based.
>
> Generally, for performance patches, you would include some benchmark
numbers.
>
> What percentage of the time of an MDIO transaction is doing the lookup, =
vs
shifting bits out the hardware and polling for completion?
> A 2.5MHz bus is not very fast, compared to a 500MHz CPU.

IIRC I saved 100us per polling loop over all 52 ports of a RTL839x switch.
But this was too long ago and I will need to verify this once again.  It i=
s
not critical for now so I will drop the patch for v2.

Markus


