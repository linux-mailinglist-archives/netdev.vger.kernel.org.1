Return-Path: <netdev+bounces-205354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413BBAFE3E1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EEEF3ACB5C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F47A275867;
	Wed,  9 Jul 2025 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="h+rtFD+O"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDCC265292;
	Wed,  9 Jul 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052719; cv=none; b=gWKenvWaH+0tONs1thI6q0OtuTRFJCvlz0K7xgkV0XLZxaT19wIZGIuIfgFZW3GxhbLUzuvjvxk3N22oBoA2BW7w4axNX7mJ7Ak6uFkS+VEp1PMUXqsjMUIcW+fnS6QwlC4hAbLiChlrhQqIYX0ZJXXThqAUqv7RTNpevXyWdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052719; c=relaxed/simple;
	bh=IJkLg9cgBCEv7gEatQbd+FGXB6V+fMy+ZA2Hw/qJxKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7wdOGL/CosPkhl8mMtOmuRjGtWi9dKSZPr6Q4w7eIHrylH9oyNbn1py+yYQ43rqmrTda/8fby0EIlex2bqv82Djpd6XPqHnb2rlltbja7dkE35hsDVppv3Rzsisq8eZbalL0Od2kOrEdsGVMRSbwWyjPEyHPtxax4Ae36EqGqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=h+rtFD+O; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9511C103972A7;
	Wed,  9 Jul 2025 11:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752052711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+E5u62zac/bI/nhyHC/KCVEzYQjnoInD57ATOWi7/J4=;
	b=h+rtFD+OgSNbW8K1Lo3j/OMDeHR/MG8B4sC0DR/IleX2yLP6KxcadR90YVkGzadxoT16Vr
	86Fd3RHN4CM3jMeTDzUbP5on8PURBNDwbtYZYnF5apatwyfzlUw8A9Hm2ShVOJDYpBEkPO
	n2lvoVMO7mNxD6Ehgj+9ZH3bEzILesAv/jZmvIg0waLpxvWa4zEcd45Cpbpkny/M3VNKfK
	A+fD3h8csuAWHkxRZupJ6gydPnkaD0XryOV3P0jzPCMUs7JwFlJQQ7W2wpE7P9XKMYXhHo
	c+qBLP6VBHFbgWZfo+ILUc9kt1+fjfJ/mHdQQG/ONrpJgzkuLtjF0REFQcEp9w==
Date: Wed, 9 Jul 2025 11:18:22 +0200
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
Subject: Re: [net-next v14 07/12] net: mtip: Add mtip_switch_{rx|tx}
 functions to the L2 switch driver
Message-ID: <20250709111822.3b204b27@wsk>
In-Reply-To: <d51a84c7-d534-44cc-88bc-73db8721e50e@redhat.com>
References: <20250701114957.2492486-1-lukma@denx.de>
	<20250701114957.2492486-8-lukma@denx.de>
	<d51a84c7-d534-44cc-88bc-73db8721e50e@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RL_uXyrG8zwSfr1tH8qUxU/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/RL_uXyrG8zwSfr1tH8qUxU/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c index
> > 63afdf2beea6..b5a82748b39b 100644 ---
> > a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c +++
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c @@ -228,6
> > +228,39 @@ struct mtip_port_info *mtip_portinfofifo_read(struct
> > switch_enet_private *fep) return info; }
> > =20
> > +static void mtip_atable_get_entry_port_number(struct
> > switch_enet_private *fep,
> > +					      unsigned char
> > *mac_addr, u8 *port) +{
> > +	int block_index, block_index_end, entry;
> > +	u32 mac_addr_lo, mac_addr_hi;
> > +	u32 read_lo, read_hi;
> > +
> > +	mac_addr_lo =3D (u32)((mac_addr[3] << 24) | (mac_addr[2] <<
> > 16) |
> > +			    (mac_addr[1] << 8) | mac_addr[0]);
> > +	mac_addr_hi =3D (u32)((mac_addr[5] << 8) | (mac_addr[4]));
> > +
> > +	block_index =3D GET_BLOCK_PTR(crc8_calc(mac_addr));
> > +	block_index_end =3D block_index + ATABLE_ENTRY_PER_SLOT;
> > +
> > +	/* now search all the entries in the selected block */
> > +	for (entry =3D block_index; entry < block_index_end;
> > entry++) {
> > +		mtip_read_atable(fep, entry, &read_lo, &read_hi);
> > +		*port =3D MTIP_PORT_FORWARDING_INIT;
> > +
> > +		if (read_lo =3D=3D mac_addr_lo &&
> > +		    ((read_hi & 0x0000FFFF) =3D=3D
> > +		     (mac_addr_hi & 0x0000FFFF))) {
> > +			/* found the correct address */
> > +			if ((read_hi & (1 << 16)) && (!(read_hi &
> > (1 << 17))))
> > +				*port =3D FIELD_GET(AT_PORT_MASK,
> > read_hi);
> > +			break;
> > +		}
> > +	}
> > +
> > +	dev_dbg(&fep->pdev->dev, "%s: MAC: %pM PORT: 0x%x\n",
> > __func__,
> > +		mac_addr, *port);
> > +}
> > +
> >  /* Clear complete MAC Look Up Table */
> >  void mtip_clear_atable(struct switch_enet_private *fep)
> >  {
> > @@ -825,11 +858,217 @@ static irqreturn_t mtip_interrupt(int irq,
> > void *ptr_fep)=20
> >  static void mtip_switch_tx(struct net_device *dev)
> >  {
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned short status;
> > +	struct sk_buff *skb;
> > +	struct cbd_t *bdp;
> > +
> > +	spin_lock(&fep->hw_lock);
> > +	bdp =3D fep->dirty_tx;
> > +
> > +	while (((status =3D bdp->cbd_sc) & BD_ENET_TX_READY) =3D=3D 0) {
> > +		if (bdp =3D=3D fep->cur_tx && fep->tx_full =3D=3D 0)
> > +			break;
> > +
> > +		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
> > +				 MTIP_SWITCH_TX_FRSIZE,
> > DMA_TO_DEVICE);
> > +		bdp->cbd_bufaddr =3D 0;
> > +		skb =3D fep->tx_skbuff[fep->skb_dirty];
> > +		/* Check for errors */
> > +		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
> > +				   BD_ENET_TX_RL | BD_ENET_TX_UN |
> > +				   BD_ENET_TX_CSL)) {
> > +			dev->stats.tx_errors++;
> > +			if (status & BD_ENET_TX_HB)  /* No
> > heartbeat */
> > +				dev->stats.tx_heartbeat_errors++;
> > +			if (status & BD_ENET_TX_LC)  /* Late
> > collision */
> > +				dev->stats.tx_window_errors++;
> > +			if (status & BD_ENET_TX_RL)  /* Retrans
> > limit */
> > +				dev->stats.tx_aborted_errors++;
> > +			if (status & BD_ENET_TX_UN)  /* Underrun */
> > +				dev->stats.tx_fifo_errors++;
> > +			if (status & BD_ENET_TX_CSL) /* Carrier
> > lost */
> > +				dev->stats.tx_carrier_errors++;
> > +		} else {
> > +			dev->stats.tx_packets++;
> > +		}
> > +
> > +		if (status & BD_ENET_TX_READY)
> > +			dev_err(&fep->pdev->dev,
> > +				"Enet xmit interrupt and
> > TX_READY.\n"); +
> > +		/* Deferred means some collisions occurred during
> > transmit,
> > +		 * but we eventually sent the packet OK.
> > +		 */
> > +		if (status & BD_ENET_TX_DEF)
> > +			dev->stats.collisions++;
> > +
> > +		/* Free the sk buffer associated with this last
> > transmit */
> > +		dev_consume_skb_irq(skb);
> > +		fep->tx_skbuff[fep->skb_dirty] =3D NULL;
> > +		fep->skb_dirty =3D (fep->skb_dirty + 1) &
> > TX_RING_MOD_MASK; +
> > +		/* Update pointer to next buffer descriptor to be
> > transmitted */
> > +		if (status & BD_ENET_TX_WRAP)
> > +			bdp =3D fep->tx_bd_base;
> > +		else
> > +			bdp++;
> > +
> > +		/* Since we have freed up a buffer, the ring is no
> > longer
> > +		 * full.
> > +		 */
> > +		if (fep->tx_full) {
> > +			fep->tx_full =3D 0;
> > +			if (netif_queue_stopped(dev))
> > +				netif_wake_queue(dev);
> > +		}
> > +	}
> > +	fep->dirty_tx =3D bdp;
> > +	spin_unlock(&fep->hw_lock);
> >  }
> > =20
> > +/* During a receive, the cur_rx points to the current incoming
> > buffer.
> > + * When we update through the ring, if the next incoming buffer has
> > + * not been given to the system, we just set the empty indicator,
> > + * effectively tossing the packet.
> > + */
> >  static int mtip_switch_rx(struct net_device *dev, int budget, int
> > *port) {
> > -	return -ENOMEM;
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	u8 *data, rx_port =3D MTIP_PORT_FORWARDING_INIT;
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned short status, pkt_len;
> > +	struct net_device *pndev;
> > +	struct ethhdr *eth_hdr;
> > +	int pkt_received =3D 0;
> > +	struct sk_buff *skb;
> > +	struct cbd_t *bdp;
> > +	struct page *page;
> > +
> > +	/* First, grab all of the stats for the incoming packet.
> > +	 * These get messed up if we get called due to a busy
> > condition.
> > +	 */
> > +	bdp =3D fep->cur_rx;
> > +
> > +	while (!((status =3D bdp->cbd_sc) & BD_ENET_RX_EMPTY)) {
> > +		if (pkt_received >=3D budget)
> > +			break;
> > +
> > +		pkt_received++;
> > +
> > +		if (!fep->usage_count)
> > +			goto rx_processing_done;
> > +
> > +		status ^=3D BD_ENET_RX_LAST;
> > +		/* Check for errors. */
> > +		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
> > BD_ENET_RX_NO |
> > +			      BD_ENET_RX_CR | BD_ENET_RX_OV |
> > BD_ENET_RX_LAST |
> > +			      BD_ENET_RX_CL)) {
> > +			dev->stats.rx_errors++;
> > +			if (status & BD_ENET_RX_OV) {
> > +				/* FIFO overrun */
> > +				dev->stats.rx_fifo_errors++;
> > +				goto rx_processing_done;
> > +			}
> > +			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
> > +				      | BD_ENET_RX_LAST)) {
> > +				/* Frame too long or too short. */
> > +				dev->stats.rx_length_errors++;
> > +				if (status & BD_ENET_RX_LAST)
> > +					netdev_err(dev, "rcv is
> > not +last\n");
> > +			}
> > +			if (status & BD_ENET_RX_CR)	/* CRC
> > Error */
> > +				dev->stats.rx_crc_errors++;
> > +
> > +			/* Report late collisions as a frame
> > error. */
> > +			if (status & (BD_ENET_RX_NO |
> > BD_ENET_RX_CL))
> > +				dev->stats.rx_frame_errors++;
> > +			goto rx_processing_done;
> > +		}
> > +
> > +		/* Get correct RX page */
> > +		page =3D fep->page[bdp - fep->rx_bd_base];
> > +		/* Process the incoming frame */
> > +		pkt_len =3D bdp->cbd_datlen;
> > +		data =3D (__u8 *)__va(bdp->cbd_bufaddr);
> > +
> > +		dma_sync_single_for_cpu(&fep->pdev->dev,
> > bdp->cbd_bufaddr,
> > +					pkt_len, DMA_FROM_DEVICE);
> > +		net_prefetch(page_address(page)); =20
>=20
> Both `__va(bdp->cbd_bufaddr)` and `page_address(page)` should point to
> the same same memory. Please use constantly one _or_ the other  -
> likely page_address(page) is the best option.

Yes, the __va() can be replaced with page_address(page) as those are
the same addresses.

>=20
> > +
> > +		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> > +			swap_buffer(data, pkt_len);
> > +
> > +		if (data) { =20
>=20
> The above check is not needed. If data is null swap_buffer will still
> unconditionally dereference it.

+1

>=20
> Also it looks like it can't be NULL.

Yes, those buffers are allocated at the initialization phase - if the
allocation fails, driver is not operational.

>=20
> /P
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/RL_uXyrG8zwSfr1tH8qUxU/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhuM94ACgkQAR8vZIA0
zr1RaQgArKJdLlpGVCfmHoWrOlhwERb9npP855S4nWH/nIu4LGnsEf8IIiz6wYxw
wpt8UCBcuoagdoUDvfXBEM4SgGw/zpYJz63sYg1yVnUz6scgmcL5fdGitYQbC9O3
DEeKJBzyOP3DP29+61LMWSbnLUm1z4eEuotPlOhy3xwrxs9FEy3Dwm8o74axdPhO
icGeBaCPYvk86if7I4pHMGpRFA+on3upbCnMjjBSZdkX8am3gdZE/TAdeR7WdQ9+
xaxf8NklQBJQfXwtY8LEoB6VsFzxZ7n+qotp3GD9FUq53jgR2dZLw3km1bEo6RBa
t+ihQGZ1wEKNf9eE91UTFCBi796fYA==
=aA9e
-----END PGP SIGNATURE-----

--Sig_/RL_uXyrG8zwSfr1tH8qUxU/--

