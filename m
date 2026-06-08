Return-Path: <netdev+bounces-296678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FQiXDQ38JmrQpAIAu9opvQ
	(envelope-from <netdev+bounces-296678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:29:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F96593F5
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:29:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=BzaFGNe5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296678-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296678-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17A973014348
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D933D300D;
	Mon,  8 Jun 2026 17:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA42EEE82
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:29:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939786; cv=none; b=t2vERRf0vVyc2RgRfe1mowwAqu1mhKUC5VdovCQcW1QeD+e9hrINNVNvH0IXmitf20n8Iml2kR7YV1OgLcT8z4sD0x2/AjEHb/4W8oYjSQnxWOhbZ5Df/zXHnmEnA8r0y1pjvAGFZgR4TkCb9OrCNY2Yk2b6Web0PkL/EwNr53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939786; c=relaxed/simple;
	bh=BQYqg9CdzqyC8CjXbjz4gx2DJnRspYlVy9giIseqtuw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fw+n71cgUJu2P4/0p0/DUXKD051zyAce5QzXu9QRT1NaTa/lUHYHMtg4GRL2p8pdu9Q3jjo1SnqPnFfnYlBmGJyRBvergtl9dp9NBTssW8J8EzeVb7Su65V2bjgbyBVrY2XcLLg5YCqtTlhuj1tHj2ExAyAUHGeYxchRtA5raxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=BzaFGNe5; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780939772; x=1781544572;
	i=markus.stockhausen@gmx.de;
	bh=+4PZomP5PmIASUbcxK7Uoxbv0fcU62vdiTuUiRPWZxA=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BzaFGNe5yn6gRXMP5EfAQbSILi2tRrwijVGj8tOlx0ElaI4UXKcPmc4veiaAGQNk
	 VjTbFCRBH2snoSX0w8seiobHv0f21SG4H280fp0Owu/gqOYOyfVrtfsMhQ8yZxHik
	 JM+k8t3MuYRPnBMNlnYk7lsQoN4E0Deg6l/RuTHXXw2h1y1Kt5jKC2K83x8dWsZFM
	 T+J0BVgtvZ1RcAqDlhQdw4njse5XXEGo8W1OT4EpDi3HtyolapJj1af6aT4g2Pu/X
	 zcZVzM+dah/6c/khRmBlkEGDcPfUAsQI2xMmUDr5/kyPCUuJHcSwU9hSwSOFeo9ij
	 bk9V+8UgtWN+b+qp8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1x4sXp1xuH-00o8Le; Mon, 08
 Jun 2026 19:29:32 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	"'Jonas Jelonek'" <jonas.jelonek@protonmail.ch>
References: <02d001dcf5d4$540aad50$fc2007f0$@gmx.de> <1a025904-4518-4e48-bbe1-c203e409ee4d@lunn.ch>
In-Reply-To: <1a025904-4518-4e48-bbe1-c203e409ee4d@lunn.ch>
Subject: AW: Realtek Otto PHY hardware polling
Date: Mon, 8 Jun 2026 19:29:27 +0200
Message-ID: <05d401dcf76c$5e474550$1ad5cff0$@gmx.de>
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
Thread-Index: AQHzRfPdDyB2lpSYlAw9cnnDcnafjAMu8DzFte7VBVA=
Content-Language: de
X-Provags-ID: V03:K1:Sen+5yb9vzqxHchXc+zHp5W8bVe4XNvCaB9WufdE2tppNWFq3+1
 C+LvJN+7oujDLAo5rtfFTsahbCRTdPa2Wz5Vhabg2k1YYwkcsueeGWYSh01foely7asFdG+
 lbgG6S9JMdPy6RleRuOVaO5OxSpBnIY5pwfRc8C+ddZHksmWlWpwSO3DvfczYZHGLPbftBI
 16uDkp4ew8G9Uo9JB8FBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X96WST04hCQ=;jEmFpuIqGtxMCvQOT+P0bWhdcJ4
 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
 zR3gXpt56ikn1ro9ZZa23rZ0xKihekLXBiL4=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:jonas.jelonek@protonmail.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296678-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C24F96593F5

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Sonntag, 7. Juni 2026 08:39
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Cc: netdev@vger.kernel.org; chris.packham@alliedtelesis.co.nz;
daniel@makrotopia.org; 'Jonas Jelonek' <jonas.jelonek@protonmail.ch>
> Betreff: Re: Realtek Otto PHY hardware polling
>=20
> > Basically there is no need to disable/enable polling for an access.=20
> > We are running OpenWrt with polling enabled all the time without=20
> > major issues.=20
>=20
> > - It is only used for special functions (fiber, EEE, hard reset, SerDe=
s
> >   calibration).
>=20
> One obvious question is, why are these special? Hard reset i can
> understand, you need to know the reset is complete before trying to
> use the registers. But the others?
>=20
> Either we need some documentation from Realtek, or we need to reverse
> engineer the hardware to understand what it does.

Just out of curiosity I ordered a logic analyzer. Lets see
if it tells us more.

Markus


