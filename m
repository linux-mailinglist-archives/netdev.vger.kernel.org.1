Return-Path: <netdev+bounces-300780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UsCuFy03Nmpw8gYAu9opvQ
	(envelope-from <netdev+bounces-300780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 08:46:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC956A86FA
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 08:46:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=KZTC8pw1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300780-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300780-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23BEF3009141
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 06:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753EE33260D;
	Sat, 20 Jun 2026 06:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735454A32;
	Sat, 20 Jun 2026 06:46:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781937962; cv=none; b=gRwo0CnGLor3RFoE5qjUoIB/ZhTWS/lXwf5u5AEd86oBRUaPP5H4GWTOckyRLGxSrlSQUBzBa0qdMv+fdTxZ1jkroJqvRdo2HaBuJM8DNOEmQd1j0gY48qdiCBy16rD8AnKtR3ol7bh8UUJ+IwPSfJtzDHtaqoKaFteDsCPI2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781937962; c=relaxed/simple;
	bh=fbQcWSUj/hgt2pzfw8L8iuhaTZhpnUbEFvHpJgX1uRc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=mYit2CY8An6W0odAOMqD2iECEPpQO+o0NeKRwhEdgvOZBwRyq8WS5/nA4ZLiGCr9wc6KW9VaHXHeyQDJCaK0MSLCK/kFPKo1c5EZ+dRfT/NuFeUpeW4nySjBQMmZDlSW4gJCqZM/DmUXnrfU2m8zFPUhSvybkIpV943ZyJtBE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=KZTC8pw1; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781937925; x=1782542725;
	i=markus.stockhausen@gmx.de;
	bh=fbQcWSUj/hgt2pzfw8L8iuhaTZhpnUbEFvHpJgX1uRc=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KZTC8pw1xAPW6rNftRyKRKR5pJ1yfR6ecRHg7cC1bXNBdQ4UhHJylFg2YRPsjLCd
	 riE0epfklITqyyA0c1M5mRvYhzzF+PIT5YLgrm7GXOCDRqfNPLEVQHsF2ID5y0Igu
	 caWJwP8F+dFBkxW7DH9PK8OD4LUYPd7uHMtc61/fSUK2YykrYwgOVWOtBzOOUrBBx
	 ldy2HFRI4wzZAJPa8PfP1DpTqlimoxuQgHrpoRiGAc8N3/+Xr6mU1+T1Ws1goQzhc
	 hK3WtEHMvAx6heLHWdjp9VfFAAAar+eItiXv3QBRCouTVtABzKP+Oon6KLVsyGgox
	 ZMQXfhEJQv+xNU5xlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dwj-1xDkfY2MJJ-00x8Xy; Sat, 20
 Jun 2026 08:45:25 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Jan Klos'" <honza.klos@gmail.com>,
	"'Heiner Kallweit'" <hkallweit1@gmail.com>,
	"'Andrew Lunn'" <andrew@lunn.ch>,
	"'Russell King'" <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>
Cc: "'Maxime Chevallier'" <maxime.chevallier@bootlin.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Daniel Golle'" <daniel@makrotopia.org>,
	"'Vladimir Oltean'" <vladimir.oltean@nxp.com>,
	"'Aleksander Jan Bajkowski'" <olek2@wp.pl>,
	"'Jan Hoffmann'" <jan@3e8.eu>,
	"'Issam Hamdi'" <ih@simonwunderlich.de>,
	"'Chukun Pan'" <amadeus@jmu.edu.cn>,
	"'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>,
	"'ChunHao Lin'" <hau@realtek.com>,
	<linux-kernel@vger.kernel.org>
References: <20260620011956.37181-1-honza.klos@gmail.com>
In-Reply-To: <20260620011956.37181-1-honza.klos@gmail.com>
Subject: AW: [PATCH net v2] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit
Date: Sat, 20 Jun 2026 08:45:18 +0200
Message-ID: <008101dd0080$5feb6860$1fc23920$@gmx.de>
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
Thread-Index: AQHHA9BNY+hrp2niKxE/7CPdhQ7mWrZy9RvA
Content-Language: de
X-Provags-ID: V03:K1:R5LFuyQgDTraWzf7cbWgWdx4GTY87fvQ0JNM7oU5SNqy767IGTv
 orWR2TUuSOzEbB3eUEWFE1FjRKRYfabcit6iE6s4oJaKgSBIVxyxq6mTR0mtGCQhryisS63
 Dlcck5QTAJgo0xCcfsipubZJQ0dcf0RjF6Pybi7sXx1dITBC55M2f87N64Y+GaPEQVGz2fo
 Ad6LaZBuQ2nkvHmstX0Xw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3D/uKAukkws=;mcQxiWTSZGSqWnf5Qii05S0XVev
 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
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:honza.klos@gmail.com,m:hkallweit1@gmail.com,m:andrew@lunn.ch,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:olek2@wp.pl,m:jan@3e8.eu,m:ih@simonwunderlich.de,m:amadeus@jmu.edu.cn,m:rmk+kernel@armlinux.org.uk,m:hau@realtek.com,m:linux-kernel@vger.kernel.org,m:honzaklos@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300780-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bootlin.com,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,nxp.com,wp.pl,3e8.eu,simonwunderlich.de,jmu.edu.cn,armlinux.org.uk,realtek.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:mid,gmx.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBC956A86FA

> Von: Jan Klos <honza.klos@gmail.com>=20
> Gesendet: Samstag, 20. Juni 2026 03:20
> Betreff: [PATCH net v2] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV1=
0G
bit
>
> On RTL8127A connected to a link partner that advertises 10000baseT
> speed cannot be changed to anything other than 10000baseT as 10GbE
> is always advertised regardless of any setting. Fix this by
> clearing MDIO_AN_10GBT_CTRL_ADV10G bit in rtl822x_config_aneg()'s
> call to phy_modify_mmd_changed().

As you are enhancing the mask, shouldn't this be "... by respecting ..."?

Markus


