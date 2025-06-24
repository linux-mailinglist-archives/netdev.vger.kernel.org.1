Return-Path: <netdev+bounces-200850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C74CAE719A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AA117D6B5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9654325A2B5;
	Tue, 24 Jun 2025 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BhtecKHF"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC05230270;
	Tue, 24 Jun 2025 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750800832; cv=none; b=nvZKCWOox2bTmxnCZPR6qRWSPZa5jGcc7+Tx+rutjZI+FGdGVkZO/In8u/zlnG37AhR9+G8TTHOxhoE8nOVyA0FOFNsWB2nDL5V5bxOUwZUZyfQeTdSaH+Pz80rasFG0pLsBbGME0mB8Asx/uLuyj4QSXrkWJ8gLWY5/ZF20/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750800832; c=relaxed/simple;
	bh=XvV2LFwwGDVCD40N53CynB35B7zAILqG5eY1mC/1fLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6J/dNnhkVHoM9Ch13C7+gcZsQpTfmIlTDWNp0N8k5rX2ancKg1GoD9WzwC7/JMjzYrm7gv1/GbTz0kS1f0U8qoT1/fzVn1H8/J2fLdr9/cQZQx1atBTSOYwENRWcRrXBrAsAA0rD2c9onJNf0D+WN921uRKmCbJboU04a8FXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BhtecKHF; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 813B0101DC30D;
	Tue, 24 Jun 2025 23:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750800826; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4UhNAC3lKdYVhIoChsWVA+SRZl7G6DDkisMf4TzuHdo=;
	b=BhtecKHFSH40sq5dBlZLZSkAGauBEg3kEus/1IipfnwaDjZu3QDaNMxlbQJV2bOLttJivj
	7qsER9CSOEEC+QIH4qDqBcFgCnG2Dkykui8GOkUjvQHhr9z+yFkw5eJlXMmA4mb/TxnNfI
	FH4uSgDuaUwm/zX0NCVeN9r6+Wo9DvNpwWnJNWWGnE+w2ULZHPnSvB2h84fwVg7rkUm+eK
	blREfwEWax3TCwtFSTs55KLhW6Bjvo44vTOlPgdFLbHdbabb7XqcuwQaHo9Uh13vQFSbel
	C+h3F6hw2krNjW3lZsoeogcpPoQuuEwOhrIqGtqUtdzq236ivTUwd1Gky8OAig==
Date: Tue, 24 Jun 2025 23:33:42 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v13 05/11] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250624233342.5fdb37af@wsk>
In-Reply-To: <c82c19a6-fd0f-4efe-9d93-838b52102ff4@redhat.com>
References: <20250622093756.2895000-1-lukma@denx.de>
	<20250622093756.2895000-6-lukma@denx.de>
	<c82c19a6-fd0f-4efe-9d93-838b52102ff4@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CJrMgWIo4Z=lmZ0vE4F4UWW";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/CJrMgWIo4Z=lmZ0vE4F4UWW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 6/22/25 11:37 AM, Lukasz Majewski wrote:
> > This patch provides callbacks for struct net_device_ops for MTIP
> > L2 switch.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >=20
> > ---
> > Changes for v13:
> > - New patch - created by excluding some code from large (i.e. v12
> > and earlier) MTIP driver
> > ---
> >  .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 273
> > ++++++++++++++++++ 1 file changed, 273 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c index
> > 5142f647d939..813cd39d6d56 100644 ---
> > a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c +++
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c @@ -43,6 +43,15
> > @@=20
> >  #include "mtipl2sw.h"
> > =20
> > +static void swap_buffer(void *bufaddr, int len)
> > +{
> > +	int i;
> > +	unsigned int *buf =3D bufaddr;
> > +
> > +	for (i =3D 0; i < len; i +=3D 4, buf++)
> > +		swab32s(buf);
> > +}
> > +
> >  /* Set the last buffer to wrap */
> >  static void mtip_set_last_buf_to_wrap(struct cbd_t *bdp)
> >  {
> > @@ -444,6 +453,128 @@ static void mtip_config_switch(struct
> > switch_enet_private *fep) fep->hwp + ESW_IMR);
> >  }
> > =20
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
> > +
> > +	status =3D bdp->cbd_sc;
> > +
> > +	if (status & BD_ENET_TX_READY) {
> > +		/* All transmit buffers are full. Bail out.
> > +		 * This should not happen, since dev->tbusy should
> > be set.
> > +		 */
> > +		netif_stop_queue(dev);
> > +		dev_err(&fep->pdev->dev, "%s: tx queue full!.\n",
> > dev->name);
> > +		spin_unlock_bh(&fep->hw_lock);
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
> > +		memcpy(fep->tx_bounce[index],
> > +		       (void *)skb->data, skb->len);
> > +		bufaddr =3D fep->tx_bounce[index];
> > +	}
> > +
> > +	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> > +		swap_buffer(bufaddr, skb->len);
> > +
> > +	/* Save skb pointer. */
> > +	fep->tx_skbuff[fep->skb_cur] =3D skb;
> > +
> > +	fep->skb_cur =3D (fep->skb_cur + 1) & TX_RING_MOD_MASK;
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
> > +		dev->stats.tx_errors++;
> > +		dev->stats.tx_dropped++;
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
> > +			| BD_ENET_TX_LAST | BD_ENET_TX_TC);
> > +
> > +	/* Synchronize all descriptor writes */
> > +	wmb();
> > +	bdp->cbd_sc =3D status;
> > +
> > +	netif_trans_update(dev);
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
> > +		netif_stop_queue(dev); =20
>=20
> You may want to stop the queue earlier, i.e. when 75% or the like of
> the tx ring is full. Also you can use netif_txq_maybe_stop() - with
> txq =3D=3D netdev_get_tx_queue(dev, 0)

There are two main reasons why the netif queue management is so rugged:

1. Due to simplicity - this driver is not using txq (queues), so I
cannot use APIs using as input argument queues. That is why functions
accepting only struct netdev pointer are used.

2. My feeling is that I would need to use queues abstraction only for
one queue - so this would be extra code overhead. I'm trying to
upstream driver which in fact has very simple internals (i.e. ringbuf
with 16 descriptors for tx/rx).

>=20
> [...]
> > +static void mtip_timeout(struct net_device *dev, unsigned int
> > txqueue) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct cbd_t *bdp;
> > +	int i;
> > +
> > +	dev->stats.tx_errors++;
> > +
> > +	if (IS_ENABLED(CONFIG_SWITCH_DEBUG)) {
> > +		dev_info(&dev->dev, "%s: transmit timed out.\n",
> > dev->name);
> > +		dev_info(&dev->dev,
> > +			 "Ring data: cur_tx %lx%s, dirty_tx %lx
> > cur_rx: %lx\n",
> > +			 (unsigned long)fep->cur_tx,
> > +			 fep->tx_full ? " (full)" : "",
> > +			 (unsigned long)fep->dirty_tx,
> > +			 (unsigned long)fep->cur_rx);
> > +
> > +		bdp =3D fep->tx_bd_base;
> > +		dev_info(&dev->dev, " tx: %u buffers\n",
> > TX_RING_SIZE);
> > +		for (i =3D 0; i < TX_RING_SIZE; i++) {
> > +			dev_info(&dev->dev, "  %08lx: %04x %04x
> > %08x\n",
> > +				 (kernel_ulong_t)bdp, bdp->cbd_sc,
> > +				 bdp->cbd_datlen,
> > (int)bdp->cbd_bufaddr);
> > +			bdp++;
> > +		}
> > +
> > +		bdp =3D fep->rx_bd_base;
> > +		dev_info(&dev->dev, " rx: %lu buffers\n",
> > +			 (unsigned long)RX_RING_SIZE);
> > +		for (i =3D 0 ; i < RX_RING_SIZE; i++) {
> > +			dev_info(&dev->dev, "  %08lx: %04x %04x
> > %08x\n",
> > +				 (kernel_ulong_t)bdp,
> > +				 bdp->cbd_sc, bdp->cbd_datlen,
> > +				 (int)bdp->cbd_bufaddr);
> > +			bdp++;
> > +		} =20
>=20
> Here you are traversing both rings without any lock, which looks race
> prone.

I will add  spin_{un}lock_bh(&fep->hw_lock); (this is only code used
for debugging, not production)

>=20
> /P
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/CJrMgWIo4Z=lmZ0vE4F4UWW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhbGbYACgkQAR8vZIA0
zr1nQAf8DbYsGNqHDbFPU8PQZ/XrmTtF041853WB8TNnJwaOsUnvvoywrOrdDFqt
9jzOpwf2AB6RZB1BDHGVyzNeOHW1UdfkrAL/z5Ko7r9Nx5vkicMSFTX+Orf1NJtX
FCHTxYxx0uN/rbHUmKXaqgN9pvXc+AlpoB7eC/v2CJnvbSMF8S3iklvBhpJ6YVm/
LQS/WjrmKmJSL+NZO5hy3TaMbsLi3Hv4yQAao4xmYDf7JG5xcy+VewQSv8+CY1Fj
T4a91/L5+ueoyZ1Pwlnzr/RrRrhnHKspVRIrnexH1dQJ2oCUB3X1KmsSC+yjIDAb
pC4DEXZZu3VOA+HDAikhW8tGF5DM4A==
=HTk3
-----END PGP SIGNATURE-----

--Sig_/CJrMgWIo4Z=lmZ0vE4F4UWW--

