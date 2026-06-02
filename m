Return-Path: <netdev+bounces-294214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MUbhEBDVHmprVgAAu9opvQ
	(envelope-from <netdev+bounces-294214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:05:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC38062E44C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:05:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=HWwuRcBw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294214-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294214-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A71593013032
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404839891F;
	Tue,  2 Jun 2026 13:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88E2EBB84
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 13:01:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405310; cv=none; b=AJ2grBXFHpvAqTfpR8uU7RyjTi1ujFJHUJUTxowGi36xjkV8T3bqBFAgqoTGsuZkpe9380OJzGl8tBEOsgxGU3Gw2KERLZFThlkEWB1DqzL4K3rNJnwomYFuZ5lHiPtdFJtJfFQbaOhSgqfB3w4z6TZTeSPZJfqib9teE+utjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405310; c=relaxed/simple;
	bh=he7zLR9q84NAAGS3KolrgGO5CzYdp5X7EpXwmG1iB6s=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TKPR8C0gG3L9SWLDPklzlVsGp39j54YPx/d5HHEI4IrM6EQsr+Xxr5r6jGnBhz8AEdRPrGtcrzPd9PsesODKL7JKZiK2USO8eWHS/WSMzgl4hqtaE5gqBz1OA4PflE9XqAsxtlU1tc8KUhzFxJABSEhuvrBjF/9Tq12SGUiwvrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=HWwuRcBw; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780405274; x=1781010074;
	i=markus.stockhausen@gmx.de;
	bh=he7zLR9q84NAAGS3KolrgGO5CzYdp5X7EpXwmG1iB6s=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HWwuRcBwujuWlTxwBZ0idkOoPLbGiU+V/VNRVbyNiFlN+SySVd9Y1gYiVZIud7qw
	 dh2GvlJkXHO4CdziYJgSd21bNaM+zCxd/JNZPLPa5ZPxnEhf2hsrDK9G6R+F7LgCo
	 dK4GZSxy3UqlWWM/Edy4bRMXTCalgAAIT+hP8eV3wrTUSazXtJ3uHY/TwLtUix4bG
	 7eRyrXPAqKZbYnOhziwaFqZPxIm5+QDJuYwiP11I+bs/zBad0g34VagarF0HaLKzh
	 GfDJONgYvxnHB+8PAop3KL5vUyc9bwX/uF9E59zHIyY5Re2HAtELpg6x7rhrap7oT
	 cP1IJdE9whnkd+ugeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1xA6M60niy-00ebtK; Tue, 02
 Jun 2026 15:01:14 +0200
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
References: <20260602052640.93083-1-markus.stockhausen@gmx.de> <20260602052640.93083-7-markus.stockhausen@gmx.de> <d56efb0d-c288-43d5-b3c4-922a164fd29e@lunn.ch>
In-Reply-To: <d56efb0d-c288-43d5-b3c4-922a164fd29e@lunn.ch>
Subject: AW: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate topology setup
Date: Tue, 2 Jun 2026 15:01:08 +0200
Message-ID: <02b201dcf28f$e4794470$ad6bcd50$@gmx.de>
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
Thread-Index: AQCd5JwkUMOmloq9EQ3T8rs5/ndXAgFzUwJSAcESFFm4j6wv0A==
Content-Language: de
X-Provags-ID: V03:K1:iPNwbx8m1C4D94KHN/HWl6QL/7lDb8L2eZ3mEN5cZ7zi/OBjk8h
 E+hu7lZaN88CalMk3yDQ9fi3LLLCVHWgrGDlINf+we5138orHqqHqiF3GsrdO0KpizIGrUc
 o9Y4+LLpkqFLsaz5mfUrB4pHZ0wf9WfA9mVlkUvwZo2L0SDU/GJnZ2s67jfqgOXS4Ochelf
 EGfDFVMltLSPo4RUU/g8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X+PGY/GaD1k=;n/IL1sC5D/Xts5l3g8msGIdvReK
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294214-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmx.de];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC38062E44C

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Dienstag, 2. Juni 2026 14:24
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate
topology setup
>=20
> On Tue, Jun 02, 2026 at 07:26:38AM +0200, Markus Stockhausen wrote:
> > Until now the driver sets up the port to bus/address topology of the
> > controller after all buses are set up via otto_emdio_probe_one(). This
> > does not work for devices where U-Boot skips this setup. It is not
> > only needed for the hardware internal background PHY polling engine
> > but essential for access to the PHYs during probing.
>
> Talking about polling, when do the locking issues around polling get
> solved? How many more patchsets before that appears?

This series relocates all hardware setup before bus registration.
- It avoids wrong PHY access before topology setup.=20
- Side effect: setup does not interfere with concurrent bus reads/writes

With the next series I want to deactivate/activate hardware polling=20
during the whole probing process (besides other things). This avoids
that hardware polling fills wrong MAC register states during
bus/PHY setup.

Are you thinking about this? If yes I can add that to this series.

Markus


