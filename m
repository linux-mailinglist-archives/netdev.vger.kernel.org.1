Return-Path: <netdev+bounces-278698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFo5K9NL32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:26:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A5401EF0
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9376530E1CBA
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9F3CD8B3;
	Wed, 15 Apr 2026 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AONyaUvI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A4281357;
	Wed, 15 Apr 2026 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241389; cv=none; b=BBU/n3xUMcefp00ih98686ELHIGs0fFQABx73pIKV2HkykM2Isni6omihYkuUdv2iGgG/cvlIvOVYo6udcV6AkciYOrTQil6rZs51QFwC8rnT1ilq3/y3Jbd9mNFyBXamt5qCGUpCleMUoQh8aWhUlowXcF8NiKsyFqA0BOXSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241389; c=relaxed/simple;
	bh=3DyY5qFY/rpSAhU/PhLx5NVmyoKwVo6Z1F6ecideiAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4EOVkWybtRqBzbd8UUlVmve+r76KF7bXTFDZOeBLqnW55Rnoksb9LEToRrdDFr9nFx8Ez8QIKBkgr68T8rCOg4756EKz2WMwk1bKhdUA63UA4MfcQqodjc57Fuuo8W9ZB7gYVKeEIMXt5T7bFX14LNbm0NJgg+U7BNSl6bwrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AONyaUvI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 15EBB4E42A02;
	Wed, 15 Apr 2026 08:23:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C52BA60420;
	Wed, 15 Apr 2026 08:23:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AD9010451363;
	Wed, 15 Apr 2026 10:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776241383; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=73jB6kP6oLfnikYXhLaIjAKVa3wSd1KY4xPN73cfF3w=;
	b=AONyaUvIsHgZI9NmdvwrKsormOjDH92KkgBhAFLUxqRcBq9CK5VJO980FrZ6bhGJNp7H8X
	YwjpjBdSaeYhKNz25KRJ0aVaTwYm7iXe6E0KuUSxeWpTGNNIXWztNdla1dwLHjtugBngpG
	mv+X7u7eK3YvqLeKggEVXEW9Z7pRkEoCz4hutFLwmuseyYUjr6eEc1AwlEB1mS3UbY3y3d
	Zit2Rg4z0IMoFi26FA++EsdTtvSX/H3VBuB9VMa5puvZucQB5KThGxt4VmQrqUhnCsWqPU
	fq6I8UrI47K9uX2hRoFSqiCj1mSXeTdWu0LhI7ZDBKmDLSkcWVBgAMscejbrLQ==
Date: Wed, 15 Apr 2026 10:22:57 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carlo Szelinsky <github@szelinsky.de>,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: fix out-of-bounds bitmap access in
 pse_isr() on 32-bit
Message-ID: <20260415102257.5cb6bd5e@kmaincent-XPS-13-7390>
In-Reply-To: <ad6LqkKrXwNJfN0B@pengutronix.de>
References: <20260414151331.745552-1-kory.maincent@bootlin.com>
	<ad6LqkKrXwNJfN0B@pengutronix.de>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278698-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 2E7A5401EF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 20:47:06 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Kory,
>=20
> On Tue, Apr 14, 2026 at 05:13:30PM +0200, Kory Maincent wrote:
> > @@ -1340,6 +1341,11 @@ int devm_pse_irq_helper(struct pse_controller_dev
> > *pcdev, int irq, if (!h->notifs)
> >  		return -ENOMEM;
> > =20
> > +	h->notifs_mask =3D devm_kcalloc(dev, BITS_TO_LONGS(pcdev->nr_lines),
> > +				      sizeof(*h->notifs_mask),
> > GFP_KERNEL); =20
>=20
> May be better devm_bitmap_zalloc() instead of devm_kcalloc()?

Oh didn't know this one. Yes that's better. I will send v2 with it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

