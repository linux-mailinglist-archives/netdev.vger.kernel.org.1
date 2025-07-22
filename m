Return-Path: <netdev+bounces-208838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC769B0D5A6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798BE1889460
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1992DAFC1;
	Tue, 22 Jul 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LjIbbUbJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80B28A726;
	Tue, 22 Jul 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175812; cv=none; b=YAJ1h9dkSH29DI6RbogyuEuR5nfJQM4M2ek8BXSJW3/1TIHcrxS17cvaAIoMgj/7c2HBlxiBYLt0NiebjVPaCb7kEKaIqaMeXfkDEtXOFWov/O3/YEIpvdFpwkspyMDxClaj16c5HqX/N2wvr2GxZZx6j0AVc3KvknNqP8d+4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175812; c=relaxed/simple;
	bh=5+4IEnUDH3MfCtlep0Aiyd/brnRqsZn5r0qKrEkJN88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujVd2LEtKpcUZGfT3vINA3+QeH5UFodwUoV8I/Vmg0yG1hhvwJTkddhxnsVCVrz7XPZr4TGptavO/GNCXvrvROAfGFF9WouSZjjoCd+WO3ictKFDvubok0a6CmZB0Kb6OKpXnoJx+W198SoU/XgLAYfIhZhAHzK49bsUelFtb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LjIbbUbJ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 529FC1026E02C;
	Tue, 22 Jul 2025 11:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753175806; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4nY9hNH8Xulfxtod44cCabgUPMOownby6PT6DFrz5lQ=;
	b=LjIbbUbJbG2EhihBKkxwPGR29XItOid1lgo5AYyInQTAhh+5DuxFeZGRqnhC9o6cS/qwfG
	fuUPlRKJga3Ujq45JSB74KI5S35BWjlox4tLdVQPgxj+qR49/+LHsntQNaW8uRNjSX9jZS
	L6T7euknFsOZyFWvGs3duEpnVoewPiPzPZ5XiSyNQfgkn8WObJumJgYsBiuyq3PdvOswzf
	b4NNteNWy7NlZ9OLeQJSGZcNR+1HZsV5sdmAeJL85/apZep1P9YtI5HfdIehos1eBBABwp
	0W/JEWaj0OGyZoATbfVYsVBrVKV8KEaTcf2Ta96KI4g4s9M2aFWAaO/0/TlPtQ==
Date: Tue, 22 Jul 2025 11:16:39 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v15 06/12] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250722111639.3a53b450@wsk>
In-Reply-To: <20250718182840.7ab7e202@kernel.org>
References: <20250716214731.3384273-1-lukma@denx.de>
	<20250716214731.3384273-7-lukma@denx.de>
	<20250718182840.7ab7e202@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m4ErR0/Y681iJgWNOq_wn4J";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/m4ErR0/Y681iJgWNOq_wn4J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Wed, 16 Jul 2025 23:47:25 +0200 Lukasz Majewski wrote:
> > +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> > +					struct net_device *dev,
> > int port) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned short status;
> > +	struct cbd_t *bdp;
> > +	void *bufaddr;
> > +
> > +	spin_lock(&fep->hw_lock); =20
>=20
> I see some inconsistencies in how you take this lock.
> Bunch of bare spin_lock() calls from BH context, but there's also
> a _irqsave() call in mtip_adjust_link().

In the legacy NXP (Freescale) code for this IP block (i.e. MTIP switch)
the recommended way to re-setup it, when link or duplex changes, is to
reset and reconfigure it.

It requires setting up interrupts as well... In that situation, IMHO
disabling system interrupts is required to avoid some undefined
behaviour.

> Please align to the strictest
> context (not sure if the irqsave is actually needed, at a glance, IOW
> whether the lock is taken from an IRQ)

The spin_lock() for xmit port is similar to what is done for
fec_main.c. As this switch uses single uDMA for both ports as well as
there is no support (and need) for multiple queues it can be omitted.

>=20
> > +	if (!fep->link[0] && !fep->link[1]) {
> > +		/* Link is down or autonegotiation is in progress.
> > */
> > +		netif_stop_queue(dev);
> > +		spin_unlock(&fep->hw_lock);
> > +		return NETDEV_TX_BUSY;
> > +	}
> > +
> > +	/* Fill in a Tx ring entry */
> > +	bdp =3D fep->cur_tx;
> > +
> > +	/* Force read memory barier on the current transmit
> > description */ =20
>=20
> Barrier are between things. What is this barrier separating, and what
> write barrier does it pair with? As far as I can tell cur_tx is just
> a value in memory, and accesses are under ->hw_lock, so there should
> be no ordering concerns.

The bdp is the uDMA descritptor (memory allocated in the coherent dma
area). It is used by the uDMA when data is transferred to MTIP switch
internal buffer.

The bdp->cbd_sc is a half word, which is modified by uDMA engine, to
indicate if there are errors or transfer has ended.

The rmb() shall improve robustness - it assures that the status
corresponds to what was set by uDMA. On the other hand dma coherent
allocation shall do this as well.

The fec_main.c places the rmb() in similar places, so I followed their
approach.

>=20
> > +	rmb();
> > +	status =3D bdp->cbd_sc;
> > +
> > +	if (status & BD_ENET_TX_READY) {
> > +		/* All transmit buffers are full. Bail out.
> > +		 * This should not happen, since dev->tbusy should
> > be set.
> > +		 */
> > +		netif_stop_queue(dev);
> > +		dev_err(&fep->pdev->dev, "%s: tx queue full!.\n",
> > dev->name); =20
>=20
> This needs to be rate limited, we don't want to flood the logs in case
> there's a bug.

+1

>=20
> Also at a glance it seems like you have one fep for multiple netdevs.

Yes.

> So stopping one netdev's Tx queue when fep fills up will not stop the
> other ports from pushing frames, right?

This is a bit more complicated...

Other solutions - like cpsw_new - are conceptually simple; there are
two DMAs to two separate eth IP blocks.
During startup two separate devices are created. When one wants to
enable bridge (i.e. start in-hw offloading) - just single bit is setup
and ... that's it.

With vf610 / imx287 and MTIP it is a bit different (imx287 is even
worse as second ETH interface has incomplete functionality by design).

When switch is not active - you have two uDMA ports to two ENET IP
blocks. Full separation. That is what is done with fec_main.c driver.

When you enable MTIP switch - then you have just a single uDMA0 active
for "both" ports. In fact you "bridge" two ports into a single one -
that is why Freescale/NXP driver (for 2.6.y) just had eth0 to "model"
bridged interfaces. That was "simpler" (PHY management was done in the
driver as well).

Now, in this driver, we do have two network devices, which are "bridged"
(so there is br0). And of course there must be separation between
lan0/1 when this driver is used, but bridge is not (yet) created. This
works :-)


So I do have - 2x netdevs (handled by single uDMA0) + 2PHYS + br0 +
NAPI + switchdev (to avoid broadcast frame storms + {R}STP + FDB -
WIP).


Just pure fun :-) to model it all ... and make happy all maintainers :-)

>=20
> > +		spin_unlock(&fep->hw_lock);
> > +		return NETDEV_TX_BUSY;
> > +	}
> > +
> > +	/* Clear all of the status flags */
> > +	status &=3D ~BD_ENET_TX_STATS;
> > +
> > +	/* Set buffer length and buffer pointer */
> > +	bufaddr =3D skb->data;
> > +	bdp->cbd_datlen =3D skb->len;
> > +
> > +	/* On some FEC implementations data must be aligned on
> > +	 * 4-byte boundaries. Use bounce buffers to copy data
> > +	 * and get it aligned.spin
> > +	 */
> > +	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) { =20
>=20
> I think you should add=20
>=20
> 	if ... ||
>            fep->quirks & FEC_QUIRK_SWAP_FRAME)
>=20
> here. You can't modify skb->data without calling skb_cow_data()
> but you already have buffers allocated so can as well use them.

The vf610 doesn't need the frame to be swapped, but has requirements
for alignment as well.

I would keep things as they are now - as they just improve readability.

Please keep in mind that this version only supports imx287, but the
plan is to add vf610 as well (to be more specific - this driver also
works on vf610, but I plan to add those patches after this one is
accepted and pulled).=20

>=20
> > +		unsigned int index;
> > +
> > +		index =3D bdp - fep->tx_bd_base;
> > +		memcpy(fep->tx_bounce[index],
> > +		       (void *)skb->data, skb->len); =20
>=20
> this fits on one 80 char line BTW, quite easily:
>=20
> 		memcpy(fep->tx_bounce[index], (void *)skb->data,
> skb->len);
>=20
> Also the cast to void * is not necessary in C.

+1

>=20
> > +		bufaddr =3D fep->tx_bounce[index];
> > +	}
> > +
> > +	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> > +		swap_buffer(bufaddr, skb->len);
> > +
> > +	/* Save skb pointer. */
> > +	fep->tx_skbuff[fep->skb_cur] =3D skb;
> > +
> > +	fep->skb_cur =3D (fep->skb_cur + 1) & TX_RING_MOD_MASK; =20
>=20
> Not sure if this is buggy, but maybe delay updating things until the
> mapping succeeds? Fewer things to unwind.

Yes, the skb storage as well as ring buffer modification can be done
after dma mapping code.

>=20
> > +	/* Push the data cache so the CPM does not get stale memory
> > +	 * data.
> > +	 */
> > +	bdp->cbd_bufaddr =3D dma_map_single(&fep->pdev->dev, bufaddr,
> > +					  MTIP_SWITCH_TX_FRSIZE,
> > +					  DMA_TO_DEVICE);
> > +	if (unlikely(dma_mapping_error(&fep->pdev->dev,
> > bdp->cbd_bufaddr))) {
> > +		dev_err(&fep->pdev->dev,
> > +			"Failed to map descriptor tx buffer\n");
> > +		dev->stats.tx_errors++;
> > +		dev->stats.tx_dropped++; =20
>=20
> dropped and errors are two different counters
> I'd stick to dropped

Ok.

>=20
> > +		dev_kfree_skb_any(skb);
> > +		goto err;
> > +	}
> > +
> > +	/* Send it on its way.  Tell FEC it's ready, interrupt
> > when done,
> > +	 * it's the last BD of the frame, and to put the CRC on
> > the end.
> > +	 */
> > +
> > +	status |=3D (BD_ENET_TX_READY | BD_ENET_TX_INTR
> > +			| BD_ENET_TX_LAST | BD_ENET_TX_TC); =20
>=20
> The | goes at the end of the previous line, start of new line adjusts=20
> to the opening brackets..
>=20

I've refactored it.

> > +
> > +	/* Synchronize all descriptor writes */
> > +	wmb();
> > +	bdp->cbd_sc =3D status;
> > +
> > +	netif_trans_update(dev); =20
>=20
> Is this call necessary?

I've added it when I was forward porting the old driver. It can be
removed.

>=20
> > +	skb_tx_timestamp(skb);
> > +
> > +	/* Trigger transmission start */
> > +	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR);
> > +
> > +	dev->stats.tx_bytes +=3D skb->len;
> > +	/* If this was the last BD in the ring,
> > +	 * start at the beginning again.
> > +	 */
> > +	if (status & BD_ENET_TX_WRAP)
> > +		bdp =3D fep->tx_bd_base;
> > +	else
> > +		bdp++;
> > +
> > +	if (bdp =3D=3D fep->dirty_tx) {
> > +		fep->tx_full =3D 1;
> > +		netif_stop_queue(dev);
> > +	}
> > +
> > +	fep->cur_tx =3D bdp;
> > + err:
> > +	spin_unlock(&fep->hw_lock);
> > +
> > +	return NETDEV_TX_OK;
> > +} =20


Thanks for the feedback.

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/m4ErR0/Y681iJgWNOq_wn4J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmh/VvcACgkQAR8vZIA0
zr0EkQf+OKA9kVy9T6DLsGgkcx0n/BaQWjeHYKKNdbWFdsYqtJ+1WK0SgmlnezPx
6W/7JzwKVM1DBH3Nw8iJUpUT7K5t4WIQTuL8amoncPzpQq3WZPf0gcRNyEKZUH9A
zsXc5Z1KcU4B9RqSz/cBQbqezZYeDUZOgJYzttjZhL51F865oe8BIOUaJIBf+WJQ
zyYcPqREs61l4QsBonzuLECUW5Ps6oUWPPOVWg6EX4YrDm01gZlkVgKr3m4lEu2F
taQChqtcKHfRbEoZ4l2tVh5kIqt2zDtqhe5bKg69fLwv3aTqly+aUlQ1QA1P3ec9
1EFyQFEyRxedvE+CctCupZGB1v0y0Q==
=VUW3
-----END PGP SIGNATURE-----

--Sig_/m4ErR0/Y681iJgWNOq_wn4J--

