Return-Path: <netdev+bounces-302746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id unWTILmrQmr9/QkAu9opvQ
	(envelope-from <netdev+bounces-302746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:30:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 163096DDBC6
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:30:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=DlknxXen;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302746-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302746-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8447F302A4C9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7573346AEC5;
	Mon, 29 Jun 2026 17:26:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9646AF1B;
	Mon, 29 Jun 2026 17:26:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753981; cv=none; b=WC/oNdxL5MaxR0JoHggFDFgyN8fMG45WRQiqYu7VGZGLaLkW0XdeDgFaag8jED6+uKwaCekv+9oaiGH/dwnStKcyFYj3erTw5c4sRcY4vYSBl5ikW+cInCWjvyO6HgrdU2Ij86hFF3JIrzKkIvIHy4K9tVcOil0prVppZfBPBO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753981; c=relaxed/simple;
	bh=87wtZrcK1lDe1l6jGSt8sARWsY1ldhw3+AP+qA5H/IU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ghTxmIbleDz993ZxJ2SjSQGQuZFsM5Gt1rbaGTodZFlyOLmZaHxCi4wI+fBZIs+kKmQsRi4H3N77woGTYIDlZfBkVrNBQmSsbCnuhDhrq6GDk8H+A6gc7BREkaNAZWx59gyluvihYJ6cqASlPf6BBB8nMWyGYRUuUgOjKaYPTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=DlknxXen; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782753956; x=1783358756;
	i=markus.stockhausen@gmx.de;
	bh=MhXDa0AjoX+NG5+ntWtzhc5s9BFcxFwhzmcp1V6neFM=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DlknxXenFrWfiZ8q/VSP/z+zb6rPWA7+q9FR1ecWvpuGfx0Pi70nyXhC3Fa/otgg
	 BGOk2tIC+1rElVp41LB5MWSPwc5nkegDPHhyqgLhA8H8QJJzqVyl0NywwsWQfRc7V
	 wau2lkNSBM2XLjG3kz6MSN2VC4QgTjqX6PeHzZTkg8kKFlrU9LXFuvLat2GqY8M+p
	 jDdxv48OnjsGb6AB6KUd7D6Dr3dh2V+a7kv4W3Ce5KNJGVqtX4B/W3xfha11Tq3vN
	 y6B0xf/hb+jbeaw6NaO6SUcF+fPisvMZ39I+emEAyjPCEyJUAf/77wNQggt0YSeob
	 bx5WIKVsJvmXDBbLLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1wrzFa2tQU-007H0Z; Mon, 29
 Jun 2026 19:25:56 +0200
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
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de> <20260629152336.2239826-3-markus.stockhausen@gmx.de> <f3b0ddab-372a-49c5-977e-59c7a104d0a8@lunn.ch>
In-Reply-To: <f3b0ddab-372a-49c5-977e-59c7a104d0a8@lunn.ch>
Subject: AW: [PATCH net-next v2 2/8] net: mdio: realtek-rtl9300: Add page tracking
Date: Mon, 29 Jun 2026 19:25:52 +0200
Message-ID: <004201dd07ec$585a6ba0$090f42e0$@gmx.de>
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
Thread-Index: AQGLWj2oQThrBp+2CfDhF4qpCxunlgDPFPhbAZqHJLm25dYLoA==
Content-Language: de
X-Provags-ID: V03:K1:qusDnO7wJM5Yxpd9IcA9feiTCyFU45PVlIKRKxYe1wEkLA3thhg
 KmKVKTc/qzjWdvWrTKBR1U8vtQPe7TC9Zzh5gg+OBeSdDfbJ1lWeGneHD5e2IKHY8ZWXHea
 lAsmmJ5Yad1oUHsKx1OaSOvTHlGrTdMkqEkUBBvLIgeZCV2dqQ/SfC8+yTzLEw97k81hCla
 psZg2/w+7hj4LOwYTIZ2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XPV4yASqAVM=;XbWyogRj067m+rD1PaAs+ZegdWV
 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
 keF5giNOB1dE8ob/3U=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302746-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:email,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 163096DDBC6

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Montag, 29. Juni 2026 18:29
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next v2 2/8] net: mdio: realtek-rtl9300: Add pag=
e
tracking
> ...
> > Intercept access to register 31 and store the desired value for each
port
> > in the driver. When issuing access to other registers add the saved
page.
> > This given, the hardware will run two consecutive c22 commands that ar=
e
> > not interrupted by polling.
> >=20
> >   ... hardware poll ...
> >   phy_write(phy, 31, page)
> >   phy_write(phy, reg, value)
> >   ... hardware poll ...
>
> How do you guarantee the polling will not get between?

The page is part of a single command towards the controller.
If a page is given the hardware will make the above two MDIO=20
commands out of this without any polling in between.

I will clarify this in the next version.

Markus=20


