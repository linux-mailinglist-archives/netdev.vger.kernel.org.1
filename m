Return-Path: <netdev+bounces-193946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F3EAC67C4
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 12:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E4C9E3A6B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D1327A10D;
	Wed, 28 May 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gOYQmi76"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AE2472AD;
	Wed, 28 May 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429627; cv=none; b=F+dy3kK8n+MC+spbl5mOchwxn/neU/x+dojBfk6o3MlzeTjMbavqskvMm0MGRxqhPJOpL6z7YlbwESQX/K3Mr7sMZoZuSu1cMhgyrXjFeKIkR2GaU7niBSZ3LLpZvfafFdNzrYxt1A8QGNgslHY6UDT4Cs8AitZyspkZJXdDGeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429627; c=relaxed/simple;
	bh=U05qBBMBZ+zkfz9YMSbX9w+3mmO246ooiae3gxS+BUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5OZhARuJqGNaLPHuvtPbH1rXYXGDEznxLycX1BN9zNnGXwre4Ilzhabii7VhMdRb+3ppxBTtqFildERH+kJgXOmcwzALaGV0NjnBnbnD+PUQ9ESejIoB7gHsccBQZhW6pXN6QFhnESZlDXskOvvBMGFV0qtpHVtkLAr+h4eBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gOYQmi76; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFFD2103972A7;
	Wed, 28 May 2025 12:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748429616; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Rnlpm1rJuu9LugndshFdGeKyJZbgjRbA1UmZOD2hgzU=;
	b=gOYQmi76dOC4pVrK0GAyK3s57luwOkQ2slpAqPEpVBuO1ysUf6/hGc+wz1OPbAYnpftvif
	kMhuBBLGKVc1x9CCnqzb5gTkc41XK0rjoGSv/7XCIkWiu+s8O/Hr5xp+IvbohDx3oO7eo5
	RIY9Nk79yHpdupcA+chi3PlWYPVydXo3sf8T05BfAHiOvR5TYjtkuW4Jj2s8lovnwQN6Sz
	+EdXMZaSHhFia50Oo5DpffWSKzi2Xirs+TGIHU/ViuBjJWw03ZwitB9rU6THWNJswnujLP
	5dW1zX/Cl4cY2YCTN6wmvFssgxfOpvasOE7wwgmYiGsha5xV31RQHPN4o554BA==
Date: Wed, 28 May 2025 12:53:29 +0200
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
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v12 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250528125329.084ab649@wsk>
In-Reply-To: <f738d1ed-7ade-4a37-b8fd-25178f7c1dee@redhat.com>
References: <20250522075455.1723560-1-lukma@denx.de>
	<20250522075455.1723560-5-lukma@denx.de>
	<f738d1ed-7ade-4a37-b8fd-25178f7c1dee@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9ZmmnzXWe89Ci6PNTA0eE1a";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/9ZmmnzXWe89Ci6PNTA0eE1a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 5/22/25 9:54 AM, Lukasz Majewski wrote:
> > +/* dynamicms MAC address table learn and migration */
> > +static void
> > +mtip_atable_dynamicms_learn_migration(struct switch_enet_private
> > *fep,
> > +				      int curr_time, unsigned char
> > *mac,
> > +				      u8 *rx_port)
> > +{
> > +	u8 port =3D MTIP_PORT_FORWARDING_INIT;
> > +	struct mtip_port_info *port_info;
> > +	u32 rx_mac_lo =3D 0, rx_mac_hi =3D 0;
> > +	unsigned long flags;
> > +	int index;
> > +
> > +	spin_lock_irqsave(&fep->learn_lock, flags); =20
>=20
> AFAICS this is called by napi context and by a plain thread context,
> spin_lock_bh() should be sufficient.

Ok

>=20
> > +
> > +	if (mac && is_valid_ether_addr(mac)) {
> > +		rx_mac_lo =3D (u32)((mac[3] << 24) | (mac[2] << 16) |
> > +				  (mac[1] << 8) | mac[0]);
> > +		rx_mac_hi =3D (u32)((mac[5] << 8) | (mac[4]));
> > +	}
> > +
> > +	port_info =3D mtip_portinfofifo_read(fep);
> > +	while (port_info) {
> > +		/* get block index from lookup table */
> > +		index =3D GET_BLOCK_PTR(port_info->hash);
> > +		mtip_update_atable_dynamic1(port_info->maclo,
> > port_info->machi,
> > +					    index, port_info->port,
> > +					    curr_time, fep);
> > +
> > +		if (mac && is_valid_ether_addr(mac) &&
> > +		    port =3D=3D MTIP_PORT_FORWARDING_INIT) {
> > +			if (rx_mac_lo =3D=3D port_info->maclo &&
> > +			    rx_mac_hi =3D=3D port_info->machi) {
> > +				/* The newly learned MAC is the
> > source of
> > +				 * our filtered frame.
> > +				 */
> > +				port =3D (u8)port_info->port;
> > +			}
> > +		}
> > +		port_info =3D mtip_portinfofifo_read(fep);
> > +	}
> > +
> > +	if (rx_port)
> > +		*rx_port =3D port;
> > +
> > +	spin_unlock_irqrestore(&fep->learn_lock, flags);
> > +}
> > +
> > +static void mtip_aging_timer(struct timer_list *t)
> > +{
> > +	struct switch_enet_private *fep =3D from_timer(fep, t,
> > timer_aging); +
> > +	fep->curr_time =3D mtip_timeincrement(fep->curr_time);
> > +
> > +	mod_timer(&fep->timer_aging,
> > +		  jiffies +
> > msecs_to_jiffies(LEARNING_AGING_INTERVAL)); +} =20
>=20
> It's unclear to me why you need to maintain a timer just to update a
> timestamp?!?
>=20

This timestamp is afterwards used in:
mtip_atable_dynamicms_learn_migration(), which in turn manages the
entries in switch "dynamic" table (it is one of the fields in the
record.

> (jiffies >> msecs_to_jiffies(LEARNING_AGING_INTERVAL)) & ((1 <<
> AT_DENTRY_TIMESTAMP_WIDTH) - 1)
>=20

If I understood you correctly - I shall remove the timer and then just
use the above line (based on jiffies) when
mtip_atable_dynamicms_learn_migration() is called (and it requires the
timestamp)?

Otherwise the mtip_timeincrement() seems like a nice wrapper on
incrementing the timestamp.

> should yield the same value (and possibly define a bitmask as a
> shortcut)
>=20
> > +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> > +					struct net_device *dev,
> > int port) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned short	status;
> > +	unsigned long flags;
> > +	struct cbd_t *bdp;
> > +	void *bufaddr;
> > +
> > +	spin_lock_irqsave(&fep->hw_lock, flags); =20
>=20
> AFAICS this lock is acquired only by napi and thread context the _bh
> variant should be sufficient.

Ok.

>=20
> > +
> > +	if (!fep->link[0] && !fep->link[1]) {
> > +		/* Link is down or autonegotiation is in progress.
> > */
> > +		netif_stop_queue(dev);
> > +		spin_unlock_irqrestore(&fep->hw_lock, flags);
> > +		return NETDEV_TX_BUSY; =20
>=20
> Intead you should probably stop the queue when such events happen

Please correct me if I'm wrong - the netif_stop_queue(dev); is called
before return. Shall something different be also done?

>=20
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
> > +		dev_err(&fep->pdev->dev, "%s: tx queue full!.\n",
> > dev->name);
> > +		spin_unlock_irqrestore(&fep->hw_lock, flags);
> > +		return NETDEV_TX_BUSY; =20
>=20
> Instead you should use
> netif_txq_maybe_stop()/netif_subqueue_maybe_stop() to stop the queue
> eariler.

As I don't manage queues - maybe the netif_txq_maybe_stop() seems to be
an overkill. In the earlier code the netif_stop_queue() is used.

>=20
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
> > +	 * and get it aligned.
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
> > +		swap_buffer(bufaddr, skb->len); =20
>=20
> Ouch, the above will kill performances.

This unfortunately must be done in such a way (the same approach is
present on fec_main.c) as the IP block is implemented in such a way
(explicit conversion from big endian to little endian).

> Also it looks like it will
> access uninitialized memory if skb->len is not 4 bytes aligned.
>=20

There is a few lines above a special code to prevent from such a
situation ((unsigned long)bufaddr & MTIP_ALIGNMENT).

> > +
> > +	/* Save skb pointer. */
> > +	fep->tx_skbuff[fep->skb_cur] =3D skb;
> > +
> > +	dev->stats.tx_bytes +=3D skb->len; =20
>=20
> It looks like this start is incremented too early, as tx could still
> fail later.

Ok.

>=20
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
> > + =20
>=20
> Likely you need some memory barrier here to ensure the descriptor
> status update is seen by the device after the buffer addr update.
>=20
> > +	status |=3D (BD_ENET_TX_READY | BD_ENET_TX_INTR
> > +			| BD_ENET_TX_LAST | BD_ENET_TX_TC);

I will add wmb() here.

> > +	bdp->cbd_sc =3D status;
> > +
> > +	netif_trans_update(dev);
> > +	skb_tx_timestamp(skb);
> > +
> > +	/* For port separation - force sending via specified port
> > */
> > +	if (!fep->br_offload && port !=3D 0)
> > +		mtip_forced_forward(fep, port, 1);
> > +
> > +	/* Trigger transmission start */
> > +	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR); =20
>=20
> Possibly you should check skb->xmit_more to avoid ringing the doorbell
> when not needed.

I couldn't find skb->xmit_more in the current sources. Instead, there
is netdev_xmit_more().

However, the TX code just is supposed to setup one frame transmission
and hence there is no risk that we trigger "empty" transmission.

>=20
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
> > +		}
> > +	}
> > +
> > +	rtnl_lock(); =20
>=20
> This is called in atomic scope, you can't acquire a mutex here.
> Instead you could schedule a work and do the reset in such scope.
>=20

Yes, you are right. I will rewrite it.

> > +	if (netif_device_present(dev) || netif_running(dev)) {
> > +		napi_disable(&fep->napi);
> > +		netif_tx_lock_bh(dev);
> > +		mtip_switch_restart(dev, fep->full_duplex[0],
> > +				    fep->full_duplex[1]);
> > +		netif_tx_wake_all_queues(dev);
> > +		netif_tx_unlock_bh(dev);
> > +		napi_enable(&fep->napi);
> > +	}
> > +	rtnl_unlock();
> > +} =20
>=20
> > +
> > +/* During a receive, the cur_rx points to the current incoming
> > buffer.
> > + * When we update through the ring, if the next incoming buffer has
> > + * not been given to the system, we just set the empty indicator,
> > + * effectively tossing the packet.
> > + */
> > +static int mtip_switch_rx(struct net_device *dev, int budget, int
> > *port) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	u8 *data, rx_port =3D MTIP_PORT_FORWARDING_INIT;
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned short status, pkt_len;
> > +	struct net_device *pndev;
> > +	struct ethhdr *eth_hdr;
> > +	int pkt_received =3D 0;
> > +	struct sk_buff *skb;
> > +	unsigned long flags;
> > +	struct cbd_t *bdp;
> > +
> > +	spin_lock_irqsave(&fep->hw_lock, flags);
> > +

It is also called in the NAPI context, so I will change
spin_lock_irqsave() to spin_lock_bh().

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
> > +		/* Since we have allocated space to hold a
> > complete frame,
> > +		 * the last indicator should be set.
> > +		 */
> > +		if ((status & BD_ENET_RX_LAST) =3D=3D 0)
> > +			dev_warn_ratelimited(&dev->dev,
> > +					     "SWITCH ENET: rcv is
> > not +last\n"); +
> > +		if (!fep->usage_count)
> > +			goto rx_processing_done;
> > +
> > +		/* Check for errors. */
> > +		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
> > BD_ENET_RX_NO |
> > +			      BD_ENET_RX_CR | BD_ENET_RX_OV)) {
> > +			dev->stats.rx_errors++;
> > +			if (status & (BD_ENET_RX_LG |
> > BD_ENET_RX_SH)) {
> > +				/* Frame too long or too short. */
> > +				dev->stats.rx_length_errors++;
> > +			}
> > +			if (status & BD_ENET_RX_NO)	/*
> > Frame alignment */
> > +				dev->stats.rx_frame_errors++;
> > +			if (status & BD_ENET_RX_CR)	/* CRC
> > Error */
> > +				dev->stats.rx_crc_errors++;
> > +			if (status & BD_ENET_RX_OV)	/* FIFO
> > overrun */
> > +				dev->stats.rx_fifo_errors++;
> > +		}
> > +
> > +		/* Report late collisions as a frame error.
> > +		 * On this error, the BD is closed, but we don't
> > know what we
> > +		 * have in the buffer.  So, just drop this frame
> > on the floor.
> > +		 */
> > +		if (status & BD_ENET_RX_CL) {
> > +			dev->stats.rx_errors++;
> > +			dev->stats.rx_frame_errors++;
> > +			goto rx_processing_done;
> > +		}
> > +
> > +		/* Process the incoming frame */
> > +		pkt_len =3D bdp->cbd_datlen;
> > +		data =3D (__u8 *)__va(bdp->cbd_bufaddr);
> > +
> > +		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
> > +				 bdp->cbd_datlen,
> > DMA_FROM_DEVICE); =20
>=20
> I have read your explaination WRT unmap/map. Actually you don't need
> to do any mapping here,=20

There are 16 cbd_t descriptors allocated (as dma_alloc_coherent). Those
descriptors contain pointer to data (being read in this case).

Hence the need to perform dma_map_single() for each descriptor, so I
would hold the correct pointer. However, initially this is done in
mtip_alloc_buffers().

> since you are unconditionally copying the
> whole buffer (why???)

Only the value of=20
pkt_len =3D bdp->cbd_datlen; is copied to SKB (after byte swap_buffer()).

> and re-using it.
>=20
> Still you need a dma_sync_single() to ensure the CPUs see the correct
> data.

The descriptors - i.e. struct cbd_t fields are allocated with
dma_alloc_coherent(), so this is OK.

The pointer, which is provided by dma_map_single(), is then used by
cbd_t descriptor to store data read by MTIP IP block.

>=20
> > +
> > +		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> > +			swap_buffer(data, pkt_len);
> > +
> > +		if (data) {
> > +			eth_hdr =3D (struct ethhdr *)data;
> > +			mtip_atable_get_entry_port_number(fep,
> > +
> > eth_hdr->h_source,
> > +
> > &rx_port);
> > +			if (rx_port =3D=3D MTIP_PORT_FORWARDING_INIT)
> > +
> > mtip_atable_dynamicms_learn_migration(fep,
> > +
> >    fep->curr_time,
> > +
> >    eth_hdr->h_source,
> > +
> >    &rx_port);
> > +		}
> > +
> > +		if (!fep->br_offload && (rx_port =3D=3D 1 || rx_port
> > =3D=3D 2))
> > +			pndev =3D fep->ndev[rx_port - 1];
> > +		else
> > +			pndev =3D dev;
> > +
> > +		*port =3D rx_port;
> > +		pndev->stats.rx_packets++;
> > +		pndev->stats.rx_bytes +=3D pkt_len; =20
>=20
> It looks like the stats are incremented too early, as the packets
> could still be dropped a few lines later

+1

>=20
> > +
> > +		/* This does 16 byte alignment, exactly what we
> > need.
> > +		 * The packet length includes FCS, but we don't
> > want to
> > +		 * include that when passing upstream as it messes
> > up
> > +		 * bridging applications.
> > +		 */
> > +		skb =3D netdev_alloc_skb(pndev, pkt_len +
> > NET_IP_ALIGN);
> > +		if (unlikely(!skb)) {
> > +			dev_dbg(&fep->pdev->dev,
> > +				"%s: Memory squeeze, dropping
> > packet.\n",
> > +				pndev->name);
> > +			pndev->stats.rx_dropped++;
> > +			goto err_mem;
> > +		} else {
> > +			skb_reserve(skb, NET_IP_ALIGN);
> > +			skb_put(skb, pkt_len);      /* Make room */
> > +			skb_copy_to_linear_data(skb, data,
> > pkt_len);
> > +			skb->protocol =3D eth_type_trans(skb, pndev);
> > +			napi_gro_receive(&fep->napi, skb);
> > +		}
> > +
> > +		bdp->cbd_bufaddr =3D dma_map_single(&fep->pdev->dev,
> > data,
> > +						  bdp->cbd_datlen,
> > +						  DMA_FROM_DEVICE);
> > +		if (unlikely(dma_mapping_error(&fep->pdev->dev,
> > +					       bdp->cbd_bufaddr)))
> > {
> > +			dev_err(&fep->pdev->dev,
> > +				"Failed to map descriptor rx
> > buffer\n");
> > +			pndev->stats.rx_errors++;
> > +			pndev->stats.rx_dropped++;
> > +			dev_kfree_skb_any(skb); =20
>=20
> The above statement is wrong even if you intend to keep the
> dma_unmap/dma_map pair (and please, don't do that! ;).

It looks like the in the mtip_alloc_buffers() the area to provide
pointer for bdp->cbd_bufaddr is allocated.

Then in the mtip_switch_rx() (if data is received) - the data (from
bdp->cbd_bufaddr) is read and the dma_unmap_single() is called.

When the data is "passed" via SKB to upper "layers" of network stack,
then the dma_map_single() is call (with the same bdp->cbd_datlen
parameter) to allocate pointer for bdp->cbd_bufaddr.

Indeed, it looks like not optimal solution (maybe there are some side
effects to cover from this IP block?).=20

I will check if dma_sync_single_for_cpu() can be used instead (so we can
re-use the descriptors' pointers from the initial allocation).

> At this point
> the skb ownership has been handed to the stack by the previous
> napi_gro_receive(), freeing it here will cause UaF and double free.
>=20

I will remove the call to dev_kfree_skb_any(skb);

> > +			goto err_mem;
> > +		}
> > +
> > + rx_processing_done:
> > +		/* Clear the status flags for this buffer */
> > +		status &=3D ~BD_ENET_RX_STATS; =20
>=20
> With the dma map/unmap in place, you likely need a memory barrier to
> ensure the device will see the descriptor status update after
> bufferptr update.

I will add wmb() here.

>=20
> > +static int mtip_alloc_buffers(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct sk_buff *skb;
> > +	struct cbd_t *bdp;
> > +	int i;
> > +
> > +	bdp =3D fep->rx_bd_base;
> > +	for (i =3D 0; i < RX_RING_SIZE; i++) {
> > +		skb =3D netdev_alloc_skb(dev, MTIP_SWITCH_RX_FRSIZE);
> > +		if (!skb)
> > +			goto err;
> > +
> > +		fep->rx_skbuff[i] =3D skb;
> > +
> > +		bdp->cbd_bufaddr =3D dma_map_single(&fep->pdev->dev,
> > skb->data,
> > +
> > MTIP_SWITCH_RX_FRSIZE,
> > +						  DMA_FROM_DEVICE);
> > +		if (unlikely(dma_mapping_error(&fep->pdev->dev,
> > +					       bdp->cbd_bufaddr)))
> > {
> > +			dev_err(&fep->pdev->dev,
> > +				"Failed to map descriptor rx
> > buffer\n");
> > +			dev_kfree_skb_any(skb); =20
>=20
> At this point fep->rx_skbuff[i] is still not NULL, and later
> mtip_free_buffers() will try to free it again. You should remove the
> above dev_kfree_skb_any(skb).

+1

>=20
> > +static const struct ethtool_ops mtip_ethtool_ops =3D {
> > +	.get_link_ksettings     =3D phy_ethtool_get_link_ksettings,
> > +	.set_link_ksettings     =3D phy_ethtool_set_link_ksettings,
> > +	.get_drvinfo            =3D mtip_get_drvinfo,
> > +	.get_link               =3D ethtool_op_get_link,
> > +	.get_ts_info		=3D ethtool_op_get_ts_info,
> > +};
> > +
> > +static const struct net_device_ops mtip_netdev_ops =3D {
> > +	.ndo_open		=3D mtip_open,
> > +	.ndo_stop		=3D mtip_close,
> > +	.ndo_start_xmit	=3D mtip_start_xmit,
> > +	.ndo_set_rx_mode	=3D mtip_set_multicast_list,
> > +	.ndo_tx_timeout	=3D mtip_timeout,
> > +	.ndo_set_mac_address	=3D mtip_set_mac_address,
> > +};
> > +
> > +bool mtip_is_switch_netdev_port(const struct net_device *ndev)
> > +{
> > +	return ndev->netdev_ops =3D=3D &mtip_netdev_ops;
> > +}
> > +
> > +static int mtip_switch_dma_init(struct switch_enet_private *fep)
> > +{
> > +	struct cbd_t *bdp, *cbd_base;
> > +	int ret, i;
> > +
> > +	/* Check mask of the streaming and coherent API */
> > +	ret =3D dma_set_mask_and_coherent(&fep->pdev->dev,
> > DMA_BIT_MASK(32));
> > +	if (ret < 0) {
> > +		dev_err(&fep->pdev->dev, "No suitable DMA
> > available\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Allocate memory for buffer descriptors */
> > +	cbd_base =3D dma_alloc_coherent(&fep->pdev->dev, PAGE_SIZE,
> > &fep->bd_dma,
> > +				      GFP_KERNEL);
> > +	if (!cbd_base)
> > +		return -ENOMEM;
> > +
> > +	/* Set receive and transmit descriptor base */
> > +	fep->rx_bd_base =3D cbd_base;
> > +	fep->tx_bd_base =3D cbd_base + RX_RING_SIZE;
> > +
> > +	/* Initialize the receive buffer descriptors */
> > +	bdp =3D fep->rx_bd_base;
> > +	for (i =3D 0; i < RX_RING_SIZE; i++) {
> > +		bdp->cbd_sc =3D 0;
> > +		bdp++;
> > +	}
> > +
> > +	/* Set the last buffer to wrap */
> > +	bdp--;
> > +	bdp->cbd_sc |=3D BD_SC_WRAP; =20
>=20
> This is a recurring pattern, you should use an helper for it.
>=20

Ok.

> > +/* FEC MII MMFR bits definition */
> > +#define FEC_MMFR_ST             BIT(30)
> > +#define FEC_MMFR_OP_READ        BIT(29)
> > +#define FEC_MMFR_OP_WRITE       BIT(28)
> > +#define FEC_MMFR_PA(v)          (((v) & 0x1F) << 23)
> > +#define FEC_MMFR_RA(v)          (((v) & 0x1F) << 18) =20
>=20
> Here and elsewhere it looks like you could use FIELD_PREP and friends

Ok, I will adjust the code.

>=20
> This patch is really too big, I'm pretty sure I missed some relevant
> issues. You should split it in multiple ones: i.e. initialization and
> h/w access, rx/tx, others ndos.

It is quite hard to "scatter" this patch as:

1. I've already split it to several files (which correspond to
different "logical" entities - like mtipl2sw_br.c).
2. The mtipl2sw.c file is the smallest part of the "core" of the
driver.
3. If I split it, then at some point I would break bisectability for
imx28.

>=20
> /P
>=20

Big thanks for your comments.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/9ZmmnzXWe89Ci6PNTA0eE1a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmg26ykACgkQAR8vZIA0
zr3NqQgAg/Wms6Es7gJIi5Y1I4OGda037cT9BtwVJAq8YpjkdZSDZ9+t/xbkIx58
Em4XhPq6hlDM1KLo6kKVqbP55CVYou8Rnen1U6viL9kukWYRNStymTWdfQt0rp7z
HaBQlTruWw4P2FOSMoica9A28yl37oBtk6Qnf3t9bdgKgJkj/B6eq4sRCAqJFe8E
UA0OjNcowsMWoI8rUqx5/bxC26Nm/oLdgJL8qVc8KzZNJPOci3TKOswk9So7+Pb8
fplwy0ynrnnopl4ur4ufHcJa0cchJev202fvyhyt7jIbhsi8MyNOw7fd1ucVRmxx
Pyx/sTv38i2fGb9DLp0q40ZTXbPl7A==
=uAU+
-----END PGP SIGNATURE-----

--Sig_/9ZmmnzXWe89Ci6PNTA0eE1a--

