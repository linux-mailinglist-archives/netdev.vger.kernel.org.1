Return-Path: <netdev+bounces-290886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wElUOPyOEGqcZgYAu9opvQ
	(envelope-from <netdev+bounces-290886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:14:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FFE5B8071
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 679163032070
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CF3A75A1;
	Fri, 22 May 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="ao9Bn1A8"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E557378D7D;
	Fri, 22 May 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469753; cv=none; b=bN8NfCc6uwXKJvUiJAwLRlfbUC144EgJFkISagb6uyx+ycaJKExjnmhxyeMTN8YxTiwfm4gKBHSZYYMi8ygkOWTjn5t0QSd1Jn9QDqDsSsDh9/Mj41ta54VZOtjwNaGVSt0W96iTeCQLQvhUiZVRTOWS6s3/g9TGNhnzJwz3o4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469753; c=relaxed/simple;
	bh=CYbWeSKJCqXiJ2U3Sic6SfFFShLy4GyRv/qjikLjRwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ7k71wzoMcEnSvklwld9Q76e/iKyh+4gHpkHDuNQA/oOeY96MOiuuotlaiQKI5NvSjlqRHdS9hYFkctvzDnKU1UWqqFJ/Z0PxfLEUPz5/W4IwwZwACYrwIFUa95BuMbcjI6ubmOzJ17E15iflrhrj1H5jyJcvWfcgzB8m4JY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=ao9Bn1A8; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1779469745; x=1780074545; i=len.bao@gmx.us;
	bh=LGYeOwSG1iTqDcustC+vKuHflO7MW8KJtJYi7aDWPp8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ao9Bn1A8mFhnhhj/CkET1GJN8yvuRBKUq+JMPt0fyY3XqdZPqoXHtVta/DSteWef
	 ++r4TJTCqa8oS6+b2R8G7sOeS1Hv7VWhzxA/Q2EQb2xwhXBDvA4IJ6oiFhNvmjuMz
	 o7+6dIM2N1DSdlAQGgI+hGmo2YtqWMPGrqpCScy2ep+YjXmBt0GpB56/Qvf7Em6wB
	 NyXR8lvacZ5cqs/LmC8gDQoIthHiR/Q986ngcga5/ux/ZX7EWhpLvRxVBNSkWKEAd
	 WiLpW/9AK9Ok0YCiCjrVBP2UgPA0X3s7xEcgt1Sn5UdJ17O7HbFPqoD5wuhjtMsQE
	 YjACXI+iJvkQAhbqdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowGa-1x7p3n2J26-00l1I8; Fri, 22
 May 2026 19:09:05 +0200
Date: Fri, 22 May 2026 17:08:46 +0000
From: Len Bao <len.bao@gmx.us>
To: Simon Horman <horms@kernel.org>
Cc: len.bao@gmx.us, m.grzeschik@pengutronix.de, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arcnet: com90xx: Mark cards and numcards variables as
 __ro_after_init
Message-ID: <ahCNnuSAr2QpLl37@ubuntu>
References: <20260516134628.30672-1-len.bao@gmx.us>
 <20260520201644.1528107-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520201644.1528107-3-horms@kernel.org>
X-Provags-ID: V03:K1:FkFIbmyWPVErTNKRr2p46/63JcWX0tkcFT7Gv8/lTZDdzA1gtmd
 tUlQ/DNrG5roIOrfMBnYvafxY3soMhVnolx3e9GeUXuTVgPRET9w86iz9E3dbhrYJLc8hdH
 B1F8XdOr35g7eQZ50EH6GqrzmwaqSFddNofrrwrf/g7NqBDoKNK18IuKO9GCyYO4NbGFukh
 OvjGZdAl1DTYE6vLnOgnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j5AmuKzv2O8=;mLFaNuy+APdk1qCEJUJkjkuCdZ2
 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
 +KSPQQYk1IEIQZ4LlQ=
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.us,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.us:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290886-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.us,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[len.bao@gmx.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.us:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmx.us]
X-Rspamd-Queue-Id: 42FFE5B8071
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 09:16:46PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
>=20
> Simon says: This is a driver that doesn't seem to have seen any
>             real attention for some time. I do wonder if we should
> 	    leave it be.
>=20
> 	    But as we are here, I'm passing on the AI generated review
> 	    with some commentary.
>=20
> ---
> arcnet: com90xx: Mark cards and numcards variables as __ro_after_init
>=20
> This commit marks the cards and numcards variables as __ro_after_init si=
nce
> they are only initialized during the init phase and are never changed
> afterward.
>=20
> > diff --git a/drivers/net/arcnet/com90xx.c b/drivers/net/arcnet/com90xx=
.c
> > index b3b287c165617..bdcdccbfb0017 100644
> > --- a/drivers/net/arcnet/com90xx.c
> > +++ b/drivers/net/arcnet/com90xx.c
> > @@ -67,8 +67,8 @@ static void com90xx_copy_from_card(struct net_device=
 *dev, int bufnum,
> > =20
> >  /* Known ARCnet cards */
> > =20
> > -static struct net_device *cards[16];
> > -static int numcards;
> > +static struct net_device *cards[16] __ro_after_init;
> > +static int numcards __ro_after_init;
>=20
> Simon says: I believe this is an existing bug rather than a regression.
>             But I am concerned that this patch may make it worse.
> 	    So I'm wondering if it should be fixed at the same time
> 	    by a series containing:
> 	    1. a patch to fix this overflow
> 	    2. this patch (to set __ro_after_init)
>=20
> Could this change exacerbate an existing regression where we overflow th=
e
> cards array?
>=20
> com90xx_probe() can test up to 32 default I/O ports. For each valid devi=
ce
> found, com90xx_found() unconditionally executes:
>=20
> drivers/net/arcnet/com90xx.c:com90xx_found() {
>     ...
> 	if (register_netdev(dev))
> 		goto err_unmap;
>=20
> 	cards[numcards++] =3D dev;
> 	return 0;
>     ...
> }
>=20
> If more than 16 devices are successfully probed, this writes past the ca=
rds
> array. Since this patch marks these variables as __ro_after_init, they a=
re
> now placed adjacently in memory.
>=20
> Is it possible that the overflow will now clobber numcards with a pointe=
r
> value, leading to an out-of-bounds index on the next iteration?
>=20
> Simon says: The issue flagged below also appears to be an existing bug
>             rather than a regression. And I don't believe it impacts
> 	    this patch or needs to block progress of it.
>=20
> Additionally, while reviewing this code, I noticed a second potential
> regression in com90xx_found(). Are we registering the IRQ handler before
> initializing the function pointers?
>=20
> drivers/net/arcnet/com90xx.c:com90xx_found() {
>     ...
> 	/* reserve the irq */
> 	if (request_irq(airq, arcnet_interrupt, 0, "arcnet (90xx)", dev)) {
> 		arc_printk(D_NORMAL, dev, "Can't get IRQ %d!\n", airq);
> 		goto err_release_mem;
> 	}
> 	dev->irq =3D airq;
>=20
> 	/* Initialize the rest of the device structure. */
> 	lp->card_name =3D "COM90xx";
> 	lp->hw.command =3D com90xx_command;
> 	lp->hw.status =3D com90xx_status;
>     ...
> }
>=20
> If an interrupt triggers immediately after request_irq() completes (e.g.=
, due
> to a spurious interrupt), arcnet_interrupt() will execute, evaluate
> !netif_running(dev) as true, and invoke lp->hw.status(dev).
>=20
> Because alloc_arcdev() zero-allocates the private data, lp->hw.status is=
 NULL
> at this point. Can this lead to a NULL pointer dereference?

Hi Simon,

I'm a newbie in the linux kernel development and I believe I don't have th=
e
experience to fix all the issues showed in this review by myself.

Also, you tell me to leave it be as is because it has no real attention.
So, my question is:

Is it worth that I try to solve the issues mentioned or not?
I am totally confused.

Best regards,

Len

