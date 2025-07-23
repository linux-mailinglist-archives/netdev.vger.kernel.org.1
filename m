Return-Path: <netdev+bounces-209488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7AB0FB41
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F151AA3826
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5522222B4;
	Wed, 23 Jul 2025 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="SyBtKbQt"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C11EE7B7;
	Wed, 23 Jul 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301127; cv=none; b=roAerfgwNBBuyVJxehbod07NEYRGD/fCKgchEO7Zk5T10KVYMIZhRI6qn/JpfF4qqWLvPi1GOetIqyNcrRKPd9y2/aZ/WNV2NK5RD1bHDhBrGixGGM7fnDpeVHlbqfAnhcC42WRO4iPShSilVrVoy0LdXqa4IeoRHJzPhbMavfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301127; c=relaxed/simple;
	bh=H7nBYB1X2440pJpSoN1Wn0N9DqqtQ4gh2JSuvy/9Oa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grbexL086FGFSchJH353MqPeKuA+2fD2jPuBG3B53ouQKQ2g4p+e+gOaE1pfCBf88UAQ3Mn3/Aw3PoZp5oSJH9sSRf8ECad6+Jfm3nbqULnzYYsjGgnwtGhlUvqghE5IVpudPAGUhvbThopTSF6/glcMUCJ/75Z7a4PnmTf0M9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=SyBtKbQt; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DE3810272359;
	Wed, 23 Jul 2025 22:05:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753301122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JRu1eEhqQTWRrM+V9siD8r1BXrfWDxNfwR7uGPU++GM=;
	b=SyBtKbQtFJsJr8BbMMF4N8L0uuZ0w/k99K9Lgwo26BBDMWchLQ3FZDnWWOq3pb6F2H+WtB
	IH+nJS/DzMJAuwGcepsegNzfGd+UQw22MHZhJhknKZ/tRgAoe1M/xgOHeRLGFKRwdYXD2r
	95E75LHIK/XQR7g4vKwLJC+4XmCd5557t59okh64ES41tuBaHxSMNEiUjOH17vuxdAoBRs
	/dO5I6YGCmlA9RA2dm6eFwf1/wYrat3uHsPR4y4rH7sW2HHPWRh/llRKP00X3Mc/lRYll3
	XfBrBSFn3P805Vkju6oKOWmp5MwvuyFOmTq+xOE8v2pQOekag46+iKswvcWOIA==
Date: Wed, 23 Jul 2025 22:05:17 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v15 06/12] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250723220517.063c204b@wsk>
In-Reply-To: <20250722111639.3a53b450@wsk>
References: <20250716214731.3384273-1-lukma@denx.de>
	<20250716214731.3384273-7-lukma@denx.de>
	<20250718182840.7ab7e202@kernel.org>
	<20250722111639.3a53b450@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TD4of5q5UnstYcIEUgvkE=c";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/TD4of5q5UnstYcIEUgvkE=c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub, Paolo,

Do you have more comments and questions regarding this driver after my
explanation?

Shall I do something more?

Thanks in advance for you feedback.

> Hi Jakub,
>=20
> > On Wed, 16 Jul 2025 23:47:25 +0200 Lukasz Majewski wrote: =20
> > > +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> > > +					struct net_device *dev,
> > > int port) +{
> > > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > > +	struct switch_enet_private *fep =3D priv->fep;
> > > +	unsigned short status;
> > > +	struct cbd_t *bdp;
> > > +	void *bufaddr;
> > > +
> > > +	spin_lock(&fep->hw_lock);   =20
> >=20
> > I see some inconsistencies in how you take this lock.
> > Bunch of bare spin_lock() calls from BH context, but there's also
> > a _irqsave() call in mtip_adjust_link(). =20
>=20
> In the legacy NXP (Freescale) code for this IP block (i.e. MTIP
> switch) the recommended way to re-setup it, when link or duplex
> changes, is to reset and reconfigure it.
>=20
> It requires setting up interrupts as well... In that situation, IMHO
> disabling system interrupts is required to avoid some undefined
> behaviour.
>=20
> > Please align to the strictest
> > context (not sure if the irqsave is actually needed, at a glance,
> > IOW whether the lock is taken from an IRQ) =20
>=20
> The spin_lock() for xmit port is similar to what is done for
> fec_main.c. As this switch uses single uDMA for both ports as well as
> there is no support (and need) for multiple queues it can be omitted.
>=20
> >  =20
> > > +	if (!fep->link[0] && !fep->link[1]) {
> > > +		/* Link is down or autonegotiation is in
> > > progress. */
> > > +		netif_stop_queue(dev);
> > > +		spin_unlock(&fep->hw_lock);
> > > +		return NETDEV_TX_BUSY;
> > > +	}
> > > +
> > > +	/* Fill in a Tx ring entry */
> > > +	bdp =3D fep->cur_tx;
> > > +
> > > +	/* Force read memory barier on the current transmit
> > > description */   =20
> >=20
> > Barrier are between things. What is this barrier separating, and
> > what write barrier does it pair with? As far as I can tell cur_tx
> > is just a value in memory, and accesses are under ->hw_lock, so
> > there should be no ordering concerns. =20
>=20
> The bdp is the uDMA descritptor (memory allocated in the coherent dma
> area). It is used by the uDMA when data is transferred to MTIP switch
> internal buffer.
>=20
> The bdp->cbd_sc is a half word, which is modified by uDMA engine, to
> indicate if there are errors or transfer has ended.
>=20
> The rmb() shall improve robustness - it assures that the status
> corresponds to what was set by uDMA. On the other hand dma coherent
> allocation shall do this as well.
>=20
> The fec_main.c places the rmb() in similar places, so I followed their
> approach.
>=20
> >  =20
> > > +	rmb();
> > > +	status =3D bdp->cbd_sc;
> > > +
> > > +	if (status & BD_ENET_TX_READY) {
> > > +		/* All transmit buffers are full. Bail out.
> > > +		 * This should not happen, since dev->tbusy
> > > should be set.
> > > +		 */
> > > +		netif_stop_queue(dev);
> > > +		dev_err(&fep->pdev->dev, "%s: tx queue full!.\n",
> > > dev->name);   =20
> >=20
> > This needs to be rate limited, we don't want to flood the logs in
> > case there's a bug. =20
>=20
> +1
>=20
> >=20
> > Also at a glance it seems like you have one fep for multiple
> > netdevs. =20
>=20
> Yes.
>=20
> > So stopping one netdev's Tx queue when fep fills up will not stop
> > the other ports from pushing frames, right? =20
>=20
> This is a bit more complicated...
>=20
> Other solutions - like cpsw_new - are conceptually simple; there are
> two DMAs to two separate eth IP blocks.
> During startup two separate devices are created. When one wants to
> enable bridge (i.e. start in-hw offloading) - just single bit is setup
> and ... that's it.
>=20
> With vf610 / imx287 and MTIP it is a bit different (imx287 is even
> worse as second ETH interface has incomplete functionality by design).
>=20
> When switch is not active - you have two uDMA ports to two ENET IP
> blocks. Full separation. That is what is done with fec_main.c driver.
>=20
> When you enable MTIP switch - then you have just a single uDMA0 active
> for "both" ports. In fact you "bridge" two ports into a single one -
> that is why Freescale/NXP driver (for 2.6.y) just had eth0 to "model"
> bridged interfaces. That was "simpler" (PHY management was done in the
> driver as well).
>=20
> Now, in this driver, we do have two network devices, which are
> "bridged" (so there is br0). And of course there must be separation
> between lan0/1 when this driver is used, but bridge is not (yet)
> created. This works :-)
>=20
>=20
> So I do have - 2x netdevs (handled by single uDMA0) + 2PHYS + br0 +
> NAPI + switchdev (to avoid broadcast frame storms + {R}STP + FDB -
> WIP).
>=20
>=20
> Just pure fun :-) to model it all ... and make happy all maintainers
> :-)
>=20
> >  =20
> > > +		spin_unlock(&fep->hw_lock);
> > > +		return NETDEV_TX_BUSY;
> > > +	}
> > > +
> > > +	/* Clear all of the status flags */
> > > +	status &=3D ~BD_ENET_TX_STATS;
> > > +
> > > +	/* Set buffer length and buffer pointer */
> > > +	bufaddr =3D skb->data;
> > > +	bdp->cbd_datlen =3D skb->len;
> > > +
> > > +	/* On some FEC implementations data must be aligned on
> > > +	 * 4-byte boundaries. Use bounce buffers to copy data
> > > +	 * and get it aligned.spin
> > > +	 */
> > > +	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) {   =20
> >=20
> > I think you should add=20
> >=20
> > 	if ... ||
> >            fep->quirks & FEC_QUIRK_SWAP_FRAME)
> >=20
> > here. You can't modify skb->data without calling skb_cow_data()
> > but you already have buffers allocated so can as well use them. =20
>=20
> The vf610 doesn't need the frame to be swapped, but has requirements
> for alignment as well.
>=20
> I would keep things as they are now - as they just improve
> readability.
>=20
> Please keep in mind that this version only supports imx287, but the
> plan is to add vf610 as well (to be more specific - this driver also
> works on vf610, but I plan to add those patches after this one is
> accepted and pulled).=20
>=20
> >  =20
> > > +		unsigned int index;
> > > +
> > > +		index =3D bdp - fep->tx_bd_base;
> > > +		memcpy(fep->tx_bounce[index],
> > > +		       (void *)skb->data, skb->len);   =20
> >=20
> > this fits on one 80 char line BTW, quite easily:
> >=20
> > 		memcpy(fep->tx_bounce[index], (void *)skb->data,
> > skb->len);
> >=20
> > Also the cast to void * is not necessary in C. =20
>=20
> +1
>=20
> >  =20
> > > +		bufaddr =3D fep->tx_bounce[index];
> > > +	}
> > > +
> > > +	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> > > +		swap_buffer(bufaddr, skb->len);
> > > +
> > > +	/* Save skb pointer. */
> > > +	fep->tx_skbuff[fep->skb_cur] =3D skb;
> > > +
> > > +	fep->skb_cur =3D (fep->skb_cur + 1) & TX_RING_MOD_MASK;   =20
> >=20
> > Not sure if this is buggy, but maybe delay updating things until the
> > mapping succeeds? Fewer things to unwind. =20
>=20
> Yes, the skb storage as well as ring buffer modification can be done
> after dma mapping code.
>=20
> >  =20
> > > +	/* Push the data cache so the CPM does not get stale
> > > memory
> > > +	 * data.
> > > +	 */
> > > +	bdp->cbd_bufaddr =3D dma_map_single(&fep->pdev->dev,
> > > bufaddr,
> > > +					  MTIP_SWITCH_TX_FRSIZE,
> > > +					  DMA_TO_DEVICE);
> > > +	if (unlikely(dma_mapping_error(&fep->pdev->dev,
> > > bdp->cbd_bufaddr))) {
> > > +		dev_err(&fep->pdev->dev,
> > > +			"Failed to map descriptor tx buffer\n");
> > > +		dev->stats.tx_errors++;
> > > +		dev->stats.tx_dropped++;   =20
> >=20
> > dropped and errors are two different counters
> > I'd stick to dropped =20
>=20
> Ok.
>=20
> >  =20
> > > +		dev_kfree_skb_any(skb);
> > > +		goto err;
> > > +	}
> > > +
> > > +	/* Send it on its way.  Tell FEC it's ready, interrupt
> > > when done,
> > > +	 * it's the last BD of the frame, and to put the CRC on
> > > the end.
> > > +	 */
> > > +
> > > +	status |=3D (BD_ENET_TX_READY | BD_ENET_TX_INTR
> > > +			| BD_ENET_TX_LAST | BD_ENET_TX_TC);   =20
> >=20
> > The | goes at the end of the previous line, start of new line
> > adjusts to the opening brackets..
> >  =20
>=20
> I've refactored it.
>=20
> > > +
> > > +	/* Synchronize all descriptor writes */
> > > +	wmb();
> > > +	bdp->cbd_sc =3D status;
> > > +
> > > +	netif_trans_update(dev);   =20
> >=20
> > Is this call necessary? =20
>=20
> I've added it when I was forward porting the old driver. It can be
> removed.
>=20
> >  =20
> > > +	skb_tx_timestamp(skb);
> > > +
> > > +	/* Trigger transmission start */
> > > +	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR);
> > > +
> > > +	dev->stats.tx_bytes +=3D skb->len;
> > > +	/* If this was the last BD in the ring,
> > > +	 * start at the beginning again.
> > > +	 */
> > > +	if (status & BD_ENET_TX_WRAP)
> > > +		bdp =3D fep->tx_bd_base;
> > > +	else
> > > +		bdp++;
> > > +
> > > +	if (bdp =3D=3D fep->dirty_tx) {
> > > +		fep->tx_full =3D 1;
> > > +		netif_stop_queue(dev);
> > > +	}
> > > +
> > > +	fep->cur_tx =3D bdp;
> > > + err:
> > > +	spin_unlock(&fep->hw_lock);
> > > +
> > > +	return NETDEV_TX_OK;
> > > +}   =20
>=20
>=20
> Thanks for the feedback.
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH, Managing Director: Johanna Denk,
> Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
> Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/TD4of5q5UnstYcIEUgvkE=c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmiBQH0ACgkQAR8vZIA0
zr1Utgf6Ard+NJXd0ZSwPbQGeReeiTVtyyTnWcReC90yLPoHeAp0XlMJjBDXKjd4
UB7FYVTELP+NVWQFhAutUrWMlMaiAetWXTwiYgxmCa5O05HuHATTkaN7dRZ3iVQc
lvPpoTZfRXf2QPEJ7PaoPsvqoVew1GINeqqKmqodBbDvOz7ykY7ixvjbrw/CLFXM
q/3gN2TzXmKS1sTiM0y05r/V7XunIzrV4eZVcEJAy1p7WuE56VqHssJVf33FOCU8
WJHa9x6eli6qVbdsU6EbtX5yI3cJpTJtqi55COBtFAd1h7EahG44/wtJ6Hjfzh7+
zH/lEkH06w5PbB/+xFJag5+KwzvlcQ==
=EEYc
-----END PGP SIGNATURE-----

--Sig_/TD4of5q5UnstYcIEUgvkE=c--

