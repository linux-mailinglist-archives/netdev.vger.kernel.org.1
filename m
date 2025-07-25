Return-Path: <netdev+bounces-210152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E378B122FA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96B34E80BA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960802EF9D6;
	Fri, 25 Jul 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="TwR16l5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1B2EF2AD;
	Fri, 25 Jul 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464470; cv=none; b=b/ypH/RUgJP+btOauWpvB75G5Q5KddclGXBl+EQIY1geWegNtowC4nnZHfNWIyw3txN80Zq5YIbWhmVX2sDcGpNiFfbbk4fY8VXc6Hpd6qqW5e6ef5foxiIYzi4QiX+w1XIs+IgDqw6NYkr+e+gnhmzbspwp6jHunCaPff5b6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464470; c=relaxed/simple;
	bh=JulBuFHYdgKvNoi/Uuf1v9zXL91cqjkYaYHW6vNvzZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5NKIHDnACOVI4TuuZ5ygTr2RQlS/DKuCPQ5gK4pr7J2HNT158QUeeJMHVk6d5k2t3H9LDiwJdkBTK8Q6DbzvLIOpwZzXkEptnED295/o+6gJ2iXnrOIU+hQPv9kgofC2Dv69tHr9xVJPLsFc8ytjfMhqXibyYu3txcvpBKaZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=TwR16l5Z; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 246C610391E80;
	Fri, 25 Jul 2025 19:27:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753464464; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3UlWs5l+oOrBrkVYNeILHZoYkNbA2xQARHEE4h2fbS8=;
	b=TwR16l5ZRojyZ9aw5+k0dhQkwb/1kaLqVhqH2QvioVY0qVECNvy5CTzAUcBxLKHRlYRQjN
	8e2RhplWmYn2pXCnyjXv7Xt3k2NXMrp+y6B/21scJzfPchyJEThoMSyNb5Byw5TBTTd9qs
	arMXYG8ykNZshXDXwpwkvVIsVIxMQ3TWcnVc3IG4Fu3umERajzNZKMfX5tnSHAF0NK4Nos
	nRDGiFbmSzKHPLjnfQ5gyVU6FL+LVM9nVhPcTs2idRcrmLtdmXN7aZqOTYnO5Yo5zGtAMj
	I2rPEdrBela6GoksRl3a/KSW9EYXEeeKue53IHAWNyV11yRaOHXjsoLgjTDAaQ==
Date: Fri, 25 Jul 2025 19:27:38 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>
Subject: Re: [net-next v16 06/12] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250725192738.0fffece9@wsk>
In-Reply-To: <20250725155440.GF1367887@horms.kernel.org>
References: <20250724223318.3068984-1-lukma@denx.de>
	<20250724223318.3068984-7-lukma@denx.de>
	<20250725155440.GF1367887@horms.kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VpCMvLfcku4gQXj7ihFznS1";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/VpCMvLfcku4gQXj7ihFznS1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> On Fri, Jul 25, 2025 at 12:33:12AM +0200, Lukasz Majewski wrote:
> > This patch provides callbacks for struct net_device_ops for MTIP
> > L2 switch.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> ...
>=20
> > +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> > +					struct net_device *dev,
> > int port) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned short status;
> > +	struct cbd_t *bdp;
> > +	void *bufaddr;
> > +
> > +	spin_lock_bh(&fep->hw_lock);
> > +
> > +	if (!fep->link[0] && !fep->link[1]) {
> > +		/* Link is down or autonegotiation is in progress.
> > */
> > +		netif_stop_queue(dev);
> > +		spin_unlock_bh(&fep->hw_lock);
> > +		return NETDEV_TX_BUSY;
> > +	}
> > +
> > +	/* Fill in a Tx ring entry */
> > +	bdp =3D fep->cur_tx;
> > +	status =3D bdp->cbd_sc;
> > +
> > +	if (status & BD_ENET_TX_READY) {
> > +		/* All transmit buffers are full. Bail out.
> > +		 * This should not happen, since dev->tbusy should
> > be set.
> > +		 */
> > +		netif_stop_queue(dev);
> > +		dev_err_ratelimited(&fep->pdev->dev, "%s: tx queue
> > full!.\n",
> > +				    dev->name);
> > +		spin_unlock(&fep->hw_lock); =20
>=20
> Sorry be the one to point out this needle in a haystack,
> but this should be spin_unlock_bh()

I must have overlooked it when working on the code.

Anyway, I need to wait if there are other comments from Jakub or Paolo
- as they had some comments (addressed already by this patch set) for
  previous version.

>=20
> Flagged by Smatch.
>=20
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
> > +	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) {
> > +		unsigned int index;
> > +
> > +		index =3D bdp - fep->tx_bd_base;
> > +		memcpy(fep->tx_bounce[index], skb->data, skb->len);
> > +		bufaddr =3D fep->tx_bounce[index];
> > +	}
> > +
> > +	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> > +		swap_buffer(bufaddr, skb->len);
> > +
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
> > +		dev->stats.tx_dropped++;
> > +		dev_kfree_skb_any(skb);
> > +		goto err;
> > +	}
> > +
> > +	/* Save skb pointer. */
> > +	fep->tx_skbuff[fep->skb_cur] =3D skb;
> > +	fep->skb_cur =3D (fep->skb_cur + 1) & TX_RING_MOD_MASK;
> > +
> > +	/* Send it on its way.  Tell FEC it's ready, interrupt
> > when done,
> > +	 * it's the last BD of the frame, and to put the CRC on
> > the end.
> > +	 */
> > +
> > +	status |=3D (BD_ENET_TX_READY | BD_ENET_TX_INTR |
> > BD_ENET_TX_LAST |
> > +		   BD_ENET_TX_TC);
> > +
> > +	/* Synchronize all descriptor writes */
> > +	wmb();
> > +	bdp->cbd_sc =3D status;
> > +
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
> > +	spin_unlock_bh(&fep->hw_lock);
> > +
> > +	return NETDEV_TX_OK;
> > +} =20
>=20
> ...




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/VpCMvLfcku4gQXj7ihFznS1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmiDvooACgkQAR8vZIA0
zr1bvQgA44ZH/osB57cH3YVOvl8W4ulZu0p5blupZwTqPyhtEWfShe4Gefx2DbBt
Qi87KMsl8a4Z6SIAcgfuGtn1dFzMua0tj/sJ8fY2oyUtexOv2y6tQGiDr1j8DO/k
BSF/t0HZeHfT8iNCM2QHMc/6ffmXu1Db115OJaE8C5eJ8P/vl209TV/KjlLYxeeE
t0k4PpCGy5ek0A1LveQLbn7PAHNDiy3sbSyadvrisQmHBpUcOjpbeIWzafC5KZXN
3XWWzQYYw3s9sL2MMTa4zrEMqdUB3iX2jm09OQJkcI/tZi3PEWHQOIMws/5kr9yq
b01X7Ygc7fueQ3yXYUE3WxIIPCQ8xw==
=jTi0
-----END PGP SIGNATURE-----

--Sig_/VpCMvLfcku4gQXj7ihFznS1--

