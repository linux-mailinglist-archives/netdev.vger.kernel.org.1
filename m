Return-Path: <netdev+bounces-280966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJC+NLkr62mBJgAAu9opvQ
	(envelope-from <netdev+bounces-280966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:37:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB83B45B96B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EE283009FAC
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7181731A7F6;
	Fri, 24 Apr 2026 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IGi8crrt"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED729ACF6;
	Fri, 24 Apr 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019792; cv=none; b=d68As199DmXtL5i5LcigN4ETO3g+yBjbtDo2/yKjzWZhOxmx95lQnGG4VtKnIx9PrRiCPTrO0hjSf4l4aM1X2wC2S5Kg0a8DvJwTCAU7ZAXEE6kgozHCV9pRBIiw27tkz8aw8ghKaNsX/4m8L5+MuTIIXUtUaBp1fMgHuulniDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019792; c=relaxed/simple;
	bh=Osjn5zIzItASdIK1vVSsoI77bcq+prIokLTVS9iqMd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELx9XY4X2Sa4jxd1lpUp6mK2GJkmHhwQd/24ivdLOErNFWraTsAiODw0QaC9SZGiSj16m1UFwGQhQqAfK4kiXbzLkNWl+XK06nyHEwHZO/86ixILN4rVK81U7yxnWcnpixjbR5BjjIKN2Ga0emquQDYEyXN3x4O/uU6XC4wvG3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IGi8crrt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4799C4E42AE9;
	Fri, 24 Apr 2026 08:36:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BFAF604EB;
	Fri, 24 Apr 2026 08:36:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9B6110720009;
	Fri, 24 Apr 2026 10:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777019787; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Osjn5zIzItASdIK1vVSsoI77bcq+prIokLTVS9iqMd8=;
	b=IGi8crrtSad5zHLVdymz0NZ51Iu6mHyBW10vScIf0bRAmt/H1B/doVIZGVI9w/jC9FMeGJ
	W3aPDtOqQdqsB3m2XEsbWI6VnQfioxsr6TbF0Ga6C0Xe3sEIsvq1rNRM6uGa/oe2ixfpIs
	d9CYG+fdEd0cIKjm8vz5aiFDQ2mb79vP5ZU+ZhhiL6gSMgYZOle4HF+j34il26U1x9AeUT
	tD5j4H76TT/GR54UhLfVdN26TMj0f+TmWtQQyNMILLpeUfYkHh2NzRUA9TBeodyEvtL1xN
	8b0Ia30CWVThHsIHL+y2ShAXne1gzKcx+BXURkA2z8SxiqjRKQ97thHSxi7vyw==
Date: Fri, 24 Apr 2026 10:36:18 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Corey Leavitt via B4 Relay <devnull+corey.leavitt.info@kernel.org>
Cc: corey@leavitt.info, Oleksij Rempel <o.rempel@pengutronix.de>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/4] net: pse-pd: scope pse_control
 regulator handle to kref lifetime
Message-ID: <20260424103618.4c6ee35e@kmaincent-XPS-13-7390>
In-Reply-To: <20260423-pse-notifier-decouple-v1-1-86ed750a9d62@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
	<20260423-pse-notifier-decouple-v1-1-86ed750a9d62@leavitt.info>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: BB83B45B96B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280966-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[leavitt.info,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,corey.leavitt.info];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leavitt.info:email]

On Thu, 23 Apr 2026 01:42:14 -0600
Corey Leavitt via B4 Relay <devnull+corey.leavitt.info@kernel.org> wrote:

> From: Corey Leavitt <corey@leavitt.info>
>=20
> __pse_control_release() drops psec->ps via devm_regulator_put(), which
> only succeeds if the devres entry added by the matching
> devm_regulator_get_exclusive() is still present on pcdev->dev at the
> time the pse_control's kref hits zero.
>=20
> In practice that assumption does not hold when the controller is
> unbound while any pse_control still has consumers: pcdev->dev's
> devres list is released LIFO, so every per-attach regulator-GET
> devres runs (and regulator_put()s the underlying regulator) before
> pse_controller_unregister() itself is invoked. Any later
> pse_control_put() from that unbind path then reads psec->ps as a
> dangling pointer inside devm_regulator_put() and WARNs at
> drivers/regulator/devres.c:232 (devres_release() fails to find the
> already-released match).
>=20
> The pse_control's consumer handle is logically scoped to the
> pse_control's refcount, not to pcdev->dev's devres lifetime. Switch
> to the plain regulator_get_exclusive() / regulator_put() pair so
> __pse_control_release() does the right put regardless of whether
> the controller's devres has already been unwound.
>=20
> No change to the regulator-framework-visible refcount or lifetime of
> the underlying regulator: a single get paired with a single put. The
> existing devm_regulator_register() for the per-PI rails is unchanged
> (those ARE correctly scoped to the controller's lifetime).

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

