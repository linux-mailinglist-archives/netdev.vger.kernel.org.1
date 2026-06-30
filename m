Return-Path: <netdev+bounces-303002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l7piB8VrQ2rBYAoAu9opvQ
	(envelope-from <netdev+bounces-303002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:09:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ED96E0FD1
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:09:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Tb5CWwQV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303002-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303002-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F54A3013692
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA5B395AC3;
	Tue, 30 Jun 2026 07:09:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8E381AEA;
	Tue, 30 Jun 2026 07:09:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803393; cv=none; b=F8FHolzq44y+nRcoh8eOFRXnvloJYPbTfXb6ifhyMMuu0wcs6QF4OhpmSKpne3LDVex9fpPGVljvd7/kEtlixXB7KKv+F+EmNOLhIIjwYnoWgM4FpmE3/HOMtlLomrp5lLOg1EQCdRIx5lRX/cwHVfpt3P/8DgOOMFlv/XN35MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803393; c=relaxed/simple;
	bh=HSNV9k7GdpwNxUpmLTuu36JNu5wZ8x7nU1zf/Qcc/m0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cz0yCNpFUJb8ndbHCPY/VZMm71RIVkYLZ1WmOgGi2ZWtGSUqFV1WWcxBELgp9haPU958HQLDQ88/SSTRc2Tf6w/En7cPxQWw9NpSUsbuSgU5pWjnB0Q6q8qcPFdtUDLlCHSXPuLRax0MAS8fKHj3nuKSjvnqqK8Bl1lLTOaUVtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Tb5CWwQV; arc=none smtp.client-ip=80.241.56.151
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gqDmW2GKlz8tvP;
	Tue, 30 Jun 2026 09:09:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782803387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0zjs9iwqtrc2J/ztqSJU4UXG4YZ0TfZmlMj54ld8hs=;
	b=Tb5CWwQVBN8ShO5Nyks160IuESTvOkdDXRJAbLORDvP3ovNPzwgeBUyPR06opUyC3V3qHF
	l7qwHpyWwV6CdxbqKN/l/xjz2YSy38iS74uT2CJ/wZwrEHxHaR24g04mlOQJZ76E7sUUPw
	0xsBi0I960LsPjRzFyM/3TIIsrH2all43z661x6wwH9wMK2m/cwTKTOss8qnFyhKna3hzi
	tbzSRsQBbTlzqyVjl93NimG8H3MqyGs9Jf4Bf4xRqpCjoHek+C1OA22/LN+eSg0CSQOdDX
	aR/hsV/NiypxvxJssLHT6+GQxMxMFzesYISmcLkvdADvH3VWNN4/qo0W+bdv7A==
Date: Tue, 30 Jun 2026 09:09:39 +0200
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
Message-ID: <20260630090939.078b7d6c@wsk>
In-Reply-To: <20260609103704.443c0b57@wsk>
References: <20260601112437.2216043-4-lukasz.majewski@mailbox.org>
	<20260605021853.3594553-1-kuba@kernel.org>
	<20260609103704.443c0b57@wsk>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: f9fe1692ed39a6225db
X-MBO-RS-META: 6xr347yciixekcd1193dniyh79nd461i
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303002-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:lgirdwood@gmail.com,m:nathan@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk+dt@kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:robh@kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:dkim,mailbox.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64ED96E0FD1

Hi Jakub,

> Hi Jakub,
>=20
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > net: mtip: Add buffers management functions to the L2 switch driver
> >=20
> > This patch fills in mtip_alloc_buffers() and mtip_free_buffers() for
> > the MTIP L2 switch driver, replacing the previously empty stubs with
> > real page_pool setup/teardown and tx_bounce buffer allocation/free.
> >  =20
> > > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> > > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c index
> > > 1d1005a42306..5b5229ee411d 100644 ---
> > > a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c +++
> > > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c @@ -892,11
> > > +892,101 @@ static void mtip_get_drvinfo(struct net_device *dev,=20
> > >  static void mtip_free_buffers(struct net_device *dev)
> > >  {
> > > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > > +	struct switch_enet_private *fep =3D priv->fep;
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < RX_RING_SIZE; i++) {
> > > +		if (!fep->page[i])
> > > +			continue;
> > > +
> > > +		page_pool_put_full_page(fep->page_pool,
> > > +					fep->page[i], false);
> > > +		fep->page[i] =3D NULL;
> > > +	}
> > > +
> > > +	page_pool_destroy(fep->page_pool);
> > > +	fep->page_pool =3D NULL;
> > > +
> > > +	for (i =3D 0; i < TX_RING_SIZE; i++) {
> > > +		kfree(fep->tx_bounce[i]);
> > > +		fep->tx_bounce[i] =3D NULL;
> > > +	}
> > > +}   =20
> >=20
> > [High]
> > Now that mtip_free_buffers() is no longer an empty stub, can the
> > mtip_open() error path tear down buffers that another active port is
> > still using?
> >=20
> > Looking at mtip_open():
> >=20
> > 	if (fep->usage_count =3D=3D 0) {
> > 		...
> > 		ret =3D mtip_alloc_buffers(dev);
> > 		if (ret)
> > 			goto mtip_alloc_buffers_err;
> > 	}
> > 	...
> > 	ret =3D mtip_mii_probe(dev);
> > 	if (ret)
> > 		goto mtip_mii_probe_err;
> > 	...
> >  mtip_mii_probe_err:
> > 	mtip_free_buffers(dev);
> >  mtip_alloc_buffers_err:
> > 	if (fep->usage_count =3D=3D 0) {
> > 		netif_napi_del(&fep->napi);
> > 		clk_disable(fep->clk_ipg);
> > 	}
> > 	return ret;
> >=20
> > mtip_alloc_buffers() only runs when fep->usage_count =3D=3D 0, so the
> > page_pool, fep->page[] and fep->tx_bounce[] are shared across switch
> > ports and only allocated on first open. mtip_close() reflects this
> > and only calls mtip_free_buffers() when fep->usage_count =3D=3D 1.
> >=20
> > When a second port is opened (fep->usage_count > 0) and
> > mtip_mii_probe() fails, the mtip_mii_probe_err label still calls
> > mtip_free_buffers() unconditionally, which destroys the page_pool
> > and frees the tx_bounce buffers that the first, still-active port is
> > using.
> >=20
> > Should the mtip_mii_probe_err teardown also be guarded by
> > fep->usage_count =3D=3D 0 (or the labels reordered) so buffers are only
> > freed for the last user, similar to mtip_close()?
> >=20
> > After this change the previously harmless call becomes a real
> > teardown, so the surviving port's NAPI path (mtip_switch_rx() and
> > the later mtip_update_cbd() refill) would dereference a freed
> > fep->page_pool and NULL fep->page[] / fep->tx_bounce[] entries
> > whenever the second port's PHY probe fails while the first port is
> > up.=20
> > > =20
> > > +static int mtip_create_page_pool(struct switch_enet_private *fep,
> > > int size) +{   =20
> > [ ... ] =20
> > > +}
> > > =20
> > >  static int mtip_alloc_buffers(struct net_device *dev)
> > >  {   =20
> > [ ... ] =20
> > >  	return 0;
> > > +
> > > + err:
> > > +	mtip_free_buffers(dev);
> > > +	return -ENOMEM;
> > >  }
> > >   =20
>=20
> Thank you for sending the AI review.
>=20
> Please find my comments:
>=20
> - I've gone through them and yes, there are a few issues found.
>   However, those are IMHO not critical ones.
>=20
> - Some issues are not valid at all - like concern what happens when
> the switch is run on multi processor chip - both imx287 and vf610 are
>   single core chips.
>=20
> - It seems like the AI review is "progressing" - i.e. there were no
>   issues found with v23 for this particular patch. I do guess that the
>   new Orc Mode from [1] has found it.
>=20
> - I do guess that different AI agent would generate different review
>=20
> - The aforementioned issues could be addressed with a fix patches -
>   dragging along (and preparing for upstream) patch set with ~3400
>   LOC (which is rejected by non-deterministic AI review) takes too
> much resources now.
>=20

Could you provide some guidelines about how to proceed?

The series was sent shortly before the net-next being open (and then it
was closed because of the new merge window).

Now it is open again, so maybe you would find some more time for this
patch set discussion?

Thanks in advance.

>=20
> To sum up:
> ----------
>=20
> The MTIP driver for v6.6 kernel (YPRR Scarthgap) with and without
> PREEMPT_RT for vf610 and imx287 as well as the v24 for net-next can be
> found at [2].
>=20
>=20
> Links:
>=20
> [1] - https://netdev-ai.bots.linux.dev/ai-local.html
> [2] - https://github.com/lmajewski/linux-imx28-l2switch/branches
>=20
>=20
>=20



--=20
Best regards,

=C5=81ukasz Majewski

