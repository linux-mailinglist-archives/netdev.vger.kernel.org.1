Return-Path: <netdev+bounces-305179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u0hjEe3qS2pNcwEAu9opvQ
	(envelope-from <netdev+bounces-305179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:50:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593C714177
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:50:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=OR8R0tzL;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305179-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305179-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 633B23022EB7
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD793AF678;
	Mon,  6 Jul 2026 17:36:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5863B19D8
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:36:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359401; cv=none; b=C6agsO0S71MMgD1xJvpuabFzOHOVcd3XJyaVrmuwX+dDMCj1fUNqyThqD6CTnB599ck/w//pv/jpzHeYS+WBAlPFJUfu2mQIKhKT8YY0O5VK7PHdAS/fEKnrJN3p9jFcNZPPHZ02bENLSXel8aZ4b8ooHPTw9ubTVvypBe+qnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359401; c=relaxed/simple;
	bh=zP7JOOFboasOwFbiRUkzRxrvEmhOT3lpDbyv0ZaSASY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=JBdg63fTclCU2Vmb/FtqO4ZXqr8vr7AKFCeZ4+Xi5ZExzPdz/ibNgnRHoDd5ZRWzw8jFcMYdjk4HAh2mIprm6Mz0nKqvZYMlqGHt+cSUeWRqtsMICJ7QYhhKV2vH8YrLJI6/XjtKeCf+sVU/JDGtRpZTTv5O15XXnFCf5t1QOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=OR8R0tzL; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783359379; x=1783964179;
	i=markus.stockhausen@gmx.de;
	bh=zP7JOOFboasOwFbiRUkzRxrvEmhOT3lpDbyv0ZaSASY=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OR8R0tzLQ814QppFrZLoIMyzS62GuGhhhZJfHK+frufuNllYbjjXvYttKLcVVRSe
	 Y1jv0RkljzTjSefjIFrXYnAEbbM6CnZDmElkwY8NDXESy1pCc6YJpph8MbyUparPz
	 ZMj7IcfPiz2viY7XevDbD4OqCSGJzSi7wUDsg649Hofw/3Zhvu+5twLun20bQW+Ro
	 ubIpH4x6vqYxVPLj2/B+ZzXxDuwp0HeYxHLuxMgA6I9lDxRpksdBLgt1/VI6Rf1x8
	 DnF/pSu9qxqWzlyPsVYzACEFBBDvypklcD+QcZSzeyseAdOgZoSnth1CaFzwSpYMp
	 xfvY8tiLQEsLKmJfNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbRm-1wsKMv0yQ2-00BzeA; Mon, 06
 Jul 2026 19:36:19 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<kuba@kernel.org>
References: <20260705163532.2853959-1-markus.stockhausen@gmx.de> <20260705163532.2853959-4-markus.stockhausen@gmx.de> <20260706163627.A22DC1F000E9@smtp.kernel.org>
In-Reply-To: <20260706163627.A22DC1F000E9@smtp.kernel.org>
Subject: AW: [PATCH net-next v3 3/8] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Mon, 6 Jul 2026 19:36:11 +0200
Message-ID: <008601dd0d6d$f3b143e0$db13cba0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDrdme0fnGqWA9FAxM51ksX3telUgHBFedyAOYEQL24LrJhEA==
Content-Language: de
X-Provags-ID: V03:K1:K7bx8P1QlSxnUuEIZIZwRf0sYLxsCGbj7GHos4WfNf0od1L2rji
 qdEUFVIRNwtlRFBgRT4CZHhvaVMnqk0U6EmLJ0ohxD7NzJHzAQk3mo+REj1QPSYxl925Vd7
 1+n+XufaA9p64+UQ3TqO3RdCEfBLz7CR61dot/aUBjJPcoCoZE6xsktgWCUBBqEOhC4FNi+
 PoocEtBt6En65nPrQtzeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5iPo/9SpQZY=;isHHQtSOmCeXKEHN1fQqIHdAmgb
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305179-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kuba@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3593C714177

Hi Andrew,

I need some guidance on these Sashiko findings [1].

> Von: sashiko-bot@kernel.org <sashiko-bot@kernel.org>=20
> Gesendet: Montag, 6. Juli 2026 18:36
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Cc: robh@kernel.org; conor+dt@kernel.org; devicetree@vger.kernel.org
> Betreff: Re: [PATCH net-next v3 3/8] net: phy: add =
(*notify_phy_attach/detach)() hooks to struct mii_bus
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
>=20
> New issues:
> [Medium] The newly added `notify_phy_detach` callback is invoked =
unconditionally=20
> during `phy_detach()`, violating attach/detach symmetry if attachment =
fails.

Is this accepted or should I add an bus_notified boolean attribute=20
for state tracking to struct phy_device?

> Pre-existing issues:
> [High] Calling `phy_attach_direct` on an already-attached PHY =
destructively removes=20
> ist existing attachment.

Is this even possible?

Thanks in advance.

Markus

[1] =
https://sashiko.dev/#/message/20260706163627.A22DC1F000E9%40smtp.kernel.o=
rg



