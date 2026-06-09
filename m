Return-Path: <netdev+bounces-296979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tRh8BULUJ2oo3AIAu9opvQ
	(envelope-from <netdev+bounces-296979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:52:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B0965DFB3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:52:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=RPiYH9VX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296979-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296979-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2307E3010F09
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BB43EEAD0;
	Tue,  9 Jun 2026 08:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2EE3EE1DB;
	Tue,  9 Jun 2026 08:37:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994248; cv=none; b=XKQM2AR6TT6/tXBb6zORlQ8hsZ9tXGeh5rOTpISTvHhnkQvnoeofjq2FYYps1n3fR248mieYjrCnqD6byxRRSSh2kvQZK+k9rAMafv2EDoSoKJ2hIlWDVzgdQlHY23rR+M0RxF+jWj8u9XoqxKTh0AMvQ2hYn2xRWfTUJjXFsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994248; c=relaxed/simple;
	bh=l7Exmz9p/uIitXB5p6TW0/WOEv3+e2EoOmnpCMBj2wc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fD6URl120PZWMavrFWIEplW6hXrCyrufglnyjOVOERPcl5W3ff3QRahfMtsCGnB0VF2XlEzob/edLq1CZm7LsE6x1Vp4YPSsesVyHdf2AifK9mry8zrfwV7MtblpV/Qb/rxxsTLmzVbnkRcwfOUS0v8PYwMBAQfkLeoeUUC7DnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RPiYH9VX; arc=none smtp.client-ip=80.241.56.172
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gZMj80rBzz9tXD;
	Tue,  9 Jun 2026 10:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780994236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeflN5T28HahSSS6B50cN92fDni13v9ufrgZcj6h5yI=;
	b=RPiYH9VXQKDM42/5vsxxIwbqpWCXmAWSGRa5js/gMS3D6qSjYnJ1RphKo0vO7Iyifj32qI
	f9m7KUqHr7kFocN4TPV49/mA+WI9nN2Mtr4WBW0TMkSb6Z18jJGf/nxBGKNaCUY/0kVCpa
	bC1OeNR1BAHN2zrmQrj98yrglCDOcYKzP+qAFY0uqzVBearFclMNMAZ1AvpLovt0NPtLVp
	zyKCLX2SB5jeL/SnhwsPXJPuegPBoLNUPm83mK+ZpaLTDQvHfF6cercjXYM4DxL0un+A+k
	QADS4O4H13SfmIZq/wryfYCVRtHQnsecuO20gRXkGSPSUxQ8CdtOXDIO/1AEAQ==
Date: Tue, 9 Jun 2026 10:37:04 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, lgirdwood@gmail.com,
 nathan@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 krzk+dt@kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, robh@kernel.org, Andrew Lunn 
 <andrew@lunn.ch>
Subject: Re: [net-next v24 3/7] net: mtip: Add buffers management functions
 to the L2 switch driver
Message-ID: <20260609103704.443c0b57@wsk>
In-Reply-To: <20260605021853.3594553-1-kuba@kernel.org>
References: <20260601112437.2216043-4-lukasz.majewski@mailbox.org>
	<20260605021853.3594553-1-kuba@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: 44354306cdec518454b
X-MBO-RS-META: bmemnt9kx546q4uk8kkttrrnxxn5ua5h
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296979-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:lgirdwood@gmail.com,m:nathan@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk+dt@kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:robh@kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1B0965DFB3

Hi Jakub,

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: mtip: Add buffers management functions to the L2 switch driver
>=20
> This patch fills in mtip_alloc_buffers() and mtip_free_buffers() for
> the MTIP L2 switch driver, replacing the previously empty stubs with
> real page_pool setup/teardown and tx_bounce buffer allocation/free.
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c index
> > 1d1005a42306..5b5229ee411d 100644 ---
> > a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c +++
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c @@ -892,11
> > +892,101 @@ static void mtip_get_drvinfo(struct net_device *dev,=20
> >  static void mtip_free_buffers(struct net_device *dev)
> >  {
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	int i;
> > +
> > +	for (i =3D 0; i < RX_RING_SIZE; i++) {
> > +		if (!fep->page[i])
> > +			continue;
> > +
> > +		page_pool_put_full_page(fep->page_pool,
> > +					fep->page[i], false);
> > +		fep->page[i] =3D NULL;
> > +	}
> > +
> > +	page_pool_destroy(fep->page_pool);
> > +	fep->page_pool =3D NULL;
> > +
> > +	for (i =3D 0; i < TX_RING_SIZE; i++) {
> > +		kfree(fep->tx_bounce[i]);
> > +		fep->tx_bounce[i] =3D NULL;
> > +	}
> > +} =20
>=20
> [High]
> Now that mtip_free_buffers() is no longer an empty stub, can the
> mtip_open() error path tear down buffers that another active port is
> still using?
>=20
> Looking at mtip_open():
>=20
> 	if (fep->usage_count =3D=3D 0) {
> 		...
> 		ret =3D mtip_alloc_buffers(dev);
> 		if (ret)
> 			goto mtip_alloc_buffers_err;
> 	}
> 	...
> 	ret =3D mtip_mii_probe(dev);
> 	if (ret)
> 		goto mtip_mii_probe_err;
> 	...
>  mtip_mii_probe_err:
> 	mtip_free_buffers(dev);
>  mtip_alloc_buffers_err:
> 	if (fep->usage_count =3D=3D 0) {
> 		netif_napi_del(&fep->napi);
> 		clk_disable(fep->clk_ipg);
> 	}
> 	return ret;
>=20
> mtip_alloc_buffers() only runs when fep->usage_count =3D=3D 0, so the
> page_pool, fep->page[] and fep->tx_bounce[] are shared across switch
> ports and only allocated on first open. mtip_close() reflects this and
> only calls mtip_free_buffers() when fep->usage_count =3D=3D 1.
>=20
> When a second port is opened (fep->usage_count > 0) and
> mtip_mii_probe() fails, the mtip_mii_probe_err label still calls
> mtip_free_buffers() unconditionally, which destroys the page_pool and
> frees the tx_bounce buffers that the first, still-active port is
> using.
>=20
> Should the mtip_mii_probe_err teardown also be guarded by
> fep->usage_count =3D=3D 0 (or the labels reordered) so buffers are only
> freed for the last user, similar to mtip_close()?
>=20
> After this change the previously harmless call becomes a real
> teardown, so the surviving port's NAPI path (mtip_switch_rx() and the
> later mtip_update_cbd() refill) would dereference a freed
> fep->page_pool and NULL fep->page[] / fep->tx_bounce[] entries
> whenever the second port's PHY probe fails while the first port is up.
>=20
> > =20
> > +static int mtip_create_page_pool(struct switch_enet_private *fep,
> > int size) +{ =20
> [ ... ]
> > +}
> > =20
> >  static int mtip_alloc_buffers(struct net_device *dev)
> >  { =20
> [ ... ]
> >  	return 0;
> > +
> > + err:
> > +	mtip_free_buffers(dev);
> > +	return -ENOMEM;
> >  }
> > =20

Thank you for sending the AI review.

Please find my comments:

- I've gone through them and yes, there are a few issues found.
  However, those are IMHO not critical ones.

- Some issues are not valid at all - like concern what happens when the
  switch is run on multi processor chip - both imx287 and vf610 are
  single core chips.

- It seems like the AI review is "progressing" - i.e. there were no
  issues found with v23 for this particular patch. I do guess that the
  new Orc Mode from [1] has found it.

- I do guess that different AI agent would generate different review

- The aforementioned issues could be addressed with a fix patches -
  dragging along (and preparing for upstream) patch set with ~3400
  LOC (which is rejected by non-deterministic AI review) takes too much
  resources now.


To sum up:
----------

The MTIP driver for v6.6 kernel (YPRR Scarthgap) with and without
PREEMPT_RT for vf610 and imx287 as well as the v24 for net-next can be
found at [2].


Links:

[1] - https://netdev-ai.bots.linux.dev/ai-local.html
[2] - https://github.com/lmajewski/linux-imx28-l2switch/branches



--=20
Best regards,

=C5=81ukasz Majewski

