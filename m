Return-Path: <netdev+bounces-195898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098DFAD2A35
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 01:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B303516551F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601622541D;
	Mon,  9 Jun 2025 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VsQoXdVM"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAEA1D89E3;
	Mon,  9 Jun 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749510154; cv=none; b=c81BYkJ88HaiDh0pjuEcup6Ef9dlAba/F4bcHhSE+sE8xObs0hsiuUmfYKT0TYBNT/WqLUzdrAgwLD3LuMo5iFS7TfxP+m1vQUl0Pb6f/y4Ooodjj2u/MevhutCPo1ggxSpBuEDSH+z7LKd+YKm+xZqEJt5c4rBjuuEsZmkauKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749510154; c=relaxed/simple;
	bh=3jQ2/BwlzDQVu+hIFV83ttrxI9vBK/ZalDlfs2CF0kg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBiheqBSIEuLByVF2DG2WkCIyFDJXYYlWYb7ge31kt8mTf9d6rzDMTlvMyZ6phUUZTnbzhfrlZXrKBOIVCvUreY8B0l2yYtyTMBEYiPhtJpChCGRi8ucNYoYOZpgJjPQVXQoCbROx3fcF/WYVInsOuFBpcPcrqgggxiAnK1OLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VsQoXdVM; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9774810397298;
	Tue, 10 Jun 2025 01:02:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749510142; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=M1pM0ueTeYF/X9+4fPTVBqoLksdbZ+Cyw0VfJldze0Q=;
	b=VsQoXdVMiWDNJ9TDQVksppIyT+as0Yv8kWI56ovGxk0wzhwz2mRrO1wXyNJgbURMy+9XLA
	rthdr+ydytgMKODaaqewotKNqi9OGAHLDGND7m5q6XbRZVdPsSbBGtRV7keLxuwHfPnCVx
	AarmxHJz+2HfaGPM3tixhVj8/ejakCDSHtx0hg66/viTP0F+hu4YEhlEtcUzYJLZNyHdI2
	WJK8/YMqScXIC++tGBuh4XXi7G8XqOOoSmq0pPuD4fs0qjAqnXlv9Qnpl/m7N2wSvKOwoY
	yGac2wLyWvb/ZUaWlrKZZLWZSyqZa/bB6fAFcNm/9lxhoqC+mJkXUTszDrZZxg==
Date: Tue, 10 Jun 2025 01:02:16 +0200
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
Message-ID: <20250610010216.7331ebb5@wsk>
In-Reply-To: <0df20c3e-bd51-415f-bfdf-f88bbd39f260@redhat.com>
References: <20250522075455.1723560-1-lukma@denx.de>
	<20250522075455.1723560-5-lukma@denx.de>
	<f738d1ed-7ade-4a37-b8fd-25178f7c1dee@redhat.com>
	<20250528125329.084ab649@wsk>
	<0df20c3e-bd51-415f-bfdf-f88bbd39f260@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sgnmYD9Yr/9ZQSdJ73NdC6_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/sgnmYD9Yr/9ZQSdJ73NdC6_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 5/28/25 12:53 PM, Lukasz Majewski wrote:
> >> On 5/22/25 9:54 AM, Lukasz Majewski wrote: =20
> >>> +/* dynamicms MAC address table learn and migration */
> >>> +static void mtip_aging_timer(struct timer_list *t)
> >>> +{
> >>> +	struct switch_enet_private *fep =3D from_timer(fep, t,
> >>> timer_aging); +
> >>> +	fep->curr_time =3D mtip_timeincrement(fep->curr_time);
> >>> +
> >>> +	mod_timer(&fep->timer_aging,
> >>> +		  jiffies +
> >>> msecs_to_jiffies(LEARNING_AGING_INTERVAL)); +}   =20
> >>
> >> It's unclear to me why you need to maintain a timer just to update
> >> a timestamp?!?
> >> =20
> >=20
> > This timestamp is afterwards used in:
> > mtip_atable_dynamicms_learn_migration(), which in turn manages the
> > entries in switch "dynamic" table (it is one of the fields in the
> > record.
> >  =20
> >> (jiffies >> msecs_to_jiffies(LEARNING_AGING_INTERVAL)) & ((1 <<
> >> AT_DENTRY_TIMESTAMP_WIDTH) - 1)
> >> =20
> >=20
> > If I understood you correctly - I shall remove the timer and then
> > just use the above line (based on jiffies) when
> > mtip_atable_dynamicms_learn_migration() is called (and it requires
> > the timestamp)?
> >=20
> > Otherwise the mtip_timeincrement() seems like a nice wrapper on
> > incrementing the timestamp. =20
>=20
> Scheduling a timer to obtain a value you can have for free is not a
> good resource usage strategy. Note that is a pending question/check
> above: verify that the suggested expression yield the expected value
> in all the possible use-case.

This is a bit more tricky than just getting value from jiffies.

The current code provides a monotonic, starting from 0 time "base" for
learning and managing entries in internal routing tables for MTIP.

To be more specific - the fep->curr_time is a value incremented after
each ~10ms.

Simple masking of jiffies would not provide such features.

However, I've rewritten relevant portions where GENMASK() could be used
to simplify and make the code more readable.

>=20
> >>> +	if (!fep->link[0] && !fep->link[1]) {
> >>> +		/* Link is down or autonegotiation is in
> >>> progress. */
> >>> +		netif_stop_queue(dev);
> >>> +		spin_unlock_irqrestore(&fep->hw_lock, flags);
> >>> +		return NETDEV_TX_BUSY;   =20
> >>
> >> Intead you should probably stop the queue when such events happen =20
> >=20
> > Please correct me if I'm wrong - the netif_stop_queue(dev); is
> > called before return. Shall something different be also done? =20
>=20
> The xmit routine should assume the link is up and the tx ring has
> enough free slot to enqueue a packet.

In the case of MTIP driver, there is a circular buffer of 16 "sets" of
descriptors (allocated as coherent) and corresponding buffer
(dma_map_single at start).

The size of each "buffer" is set to 2048B to accommodate at least single
packet.

> After enqueueing it should
> check for enough space availble for the next xmit and stop the queue,
> likely using the netif_txq_maybe_stop() helper.

The problem with not using the netif_txq_maybe_stop() is that I'm not
using the "txq" (netdev_queue).

With the current code it looks like netif_stop_queue() is the most
suitable one from the network API.

>=20
> Documentation/networking/driver.rst
>=20
> >>> +	}
> >>> +
> >>> +	/* Clear all of the status flags */
> >>> +	status &=3D ~BD_ENET_TX_STATS;
> >>> +
> >>> +	/* Set buffer length and buffer pointer */
> >>> +	bufaddr =3D skb->data;
> >>> +	bdp->cbd_datlen =3D skb->len;
> >>> +
> >>> +	/* On some FEC implementations data must be aligned on
> >>> +	 * 4-byte boundaries. Use bounce buffers to copy data
> >>> +	 * and get it aligned.
> >>> +	 */
> >>> +	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) {
> >>> +		unsigned int index;
> >>> +
> >>> +		index =3D bdp - fep->tx_bd_base;
> >>> +		memcpy(fep->tx_bounce[index],
> >>> +		       (void *)skb->data, skb->len);
> >>> +		bufaddr =3D fep->tx_bounce[index];
> >>> +	}
> >>> +
> >>> +	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> >>> +		swap_buffer(bufaddr, skb->len);   =20
> >>
> >> Ouch, the above will kill performances. =20
> >=20
> > This unfortunately must be done in such a way (the same approach is
> > present on fec_main.c) as the IP block is implemented in such a way
> > (explicit conversion from big endian to little endian).
> >  =20
> >> Also it looks like it will
> >> access uninitialized memory if skb->len is not 4 bytes aligned.
> >> =20
> >=20
> > There is a few lines above a special code to prevent from such a
> > situation ((unsigned long)bufaddr & MTIP_ALIGNMENT). =20
>=20
> The problem here is not with memory buffer alignment, but with the
> packet length, that can be not a multiple of 4. In such a case the
> last swap will do an out-of-bound read touching uninitialized data.

On the init function the size of allocation for each buffer is set to
be 2048 bytes, so there is no such a thread.

>=20
> >>> +	bdp->cbd_sc =3D status;
> >>> +
> >>> +	netif_trans_update(dev);
> >>> +	skb_tx_timestamp(skb);
> >>> +
> >>> +	/* For port separation - force sending via specified port
> >>> */
> >>> +	if (!fep->br_offload && port !=3D 0)
> >>> +		mtip_forced_forward(fep, port, 1);
> >>> +
> >>> +	/* Trigger transmission start */
> >>> +	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR);
> >>>  =20
> >>
> >> Possibly you should check skb->xmit_more to avoid ringing the
> >> doorbell when not needed. =20
> >=20
> > I couldn't find skb->xmit_more in the current sources. Instead,
> > there is netdev_xmit_more(). =20
>=20
> Yeah, I referred to the old code, sorry.
>=20
> > However, the TX code just is supposed to setup one frame
> > transmission and hence there is no risk that we trigger "empty"
> > transmission. =20
>=20
> The point is that doorbell ringing is usually very expensive (slow)
> for the H/W. And is not needed when netdev_xmit_more() is true,
> because the another xmit operation will follow. If you care about
> performances you should leverage such info.

I do have an impression, that this is very important for network
devices having many queues with separate priorities.

In my case - I do have a single uDMA0 port with a single RX and TX
circular buffer (16 packets can be "queued").

>=20
> >  =20
> >>> +	/* First, grab all of the stats for the incoming packet.
> >>> +	 * These get messed up if we get called due to a busy
> >>> condition.
> >>> +	 */
> >>> +	bdp =3D fep->cur_rx;
> >>> +
> >>> +	while (!((status =3D bdp->cbd_sc) & BD_ENET_RX_EMPTY)) {
> >>> +		if (pkt_received >=3D budget)
> >>> +			break;
> >>> +
> >>> +		pkt_received++;
> >>> +		/* Since we have allocated space to hold a
> >>> complete frame,
> >>> +		 * the last indicator should be set.
> >>> +		 */
> >>> +		if ((status & BD_ENET_RX_LAST) =3D=3D 0)
> >>> +			dev_warn_ratelimited(&dev->dev,
> >>> +					     "SWITCH ENET: rcv is
> >>> not +last\n"); +
> >>> +		if (!fep->usage_count)
> >>> +			goto rx_processing_done;
> >>> +
> >>> +		/* Check for errors. */
> >>> +		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
> >>> BD_ENET_RX_NO |
> >>> +			      BD_ENET_RX_CR | BD_ENET_RX_OV)) {
> >>> +			dev->stats.rx_errors++;
> >>> +			if (status & (BD_ENET_RX_LG |
> >>> BD_ENET_RX_SH)) {
> >>> +				/* Frame too long or too short.
> >>> */
> >>> +				dev->stats.rx_length_errors++;
> >>> +			}
> >>> +			if (status & BD_ENET_RX_NO)	/*
> >>> Frame alignment */
> >>> +				dev->stats.rx_frame_errors++;
> >>> +			if (status & BD_ENET_RX_CR)	/* CRC
> >>> Error */
> >>> +				dev->stats.rx_crc_errors++;
> >>> +			if (status & BD_ENET_RX_OV)	/*
> >>> FIFO overrun */
> >>> +				dev->stats.rx_fifo_errors++;
> >>> +		}
> >>> +
> >>> +		/* Report late collisions as a frame error.
> >>> +		 * On this error, the BD is closed, but we don't
> >>> know what we
> >>> +		 * have in the buffer.  So, just drop this frame
> >>> on the floor.
> >>> +		 */
> >>> +		if (status & BD_ENET_RX_CL) {
> >>> +			dev->stats.rx_errors++;
> >>> +			dev->stats.rx_frame_errors++;
> >>> +			goto rx_processing_done;
> >>> +		}
> >>> +
> >>> +		/* Process the incoming frame */
> >>> +		pkt_len =3D bdp->cbd_datlen;
> >>> +		data =3D (__u8 *)__va(bdp->cbd_bufaddr);
> >>> +
> >>> +		dma_unmap_single(&fep->pdev->dev,
> >>> bdp->cbd_bufaddr,
> >>> +				 bdp->cbd_datlen,
> >>> DMA_FROM_DEVICE);   =20
> >>
> >> I have read your explaination WRT unmap/map. Actually you don't
> >> need to do any mapping here,  =20
> >=20
> > There are 16 cbd_t descriptors allocated (as dma_alloc_coherent).
> > Those descriptors contain pointer to data (being read in this
> > case). =20
>=20
> I'm referring to the actual packet payload, that is the buffer at
> bdp-cbd_bufaddr with len bdp->cbd_datlen; I'm not discussing the
> descriptors contents.

+1

>=20
> > Hence the need to perform dma_map_single() for each descriptor,  =20
>=20
> You are not unmapping the descriptor, you are unmapping the packet
> payload.

+1

>=20
> >> since you are unconditionally copying the
> >> whole buffer (why???) =20
> >=20
> > Only the value of=20
> > pkt_len =3D bdp->cbd_datlen; is copied to SKB (after byte
> > swap_buffer()). =20
>=20
> The relevant line is:
>=20
> 		skb_copy_to_linear_data(skb, data, pkt_len);
>=20
> AFAICS that copies whole packet contents, which is usually quite
> sub-optimal from performance PoV.
>=20

fec_main.c just assigns:
data=C2=B7=3D=C2=B7skb->data;

so I would prefer to keep the:
skb_copy_to_linear_data(skb, data, pkt_len);

> >> and re-using it.
> >>
> >> Still you need a dma_sync_single() to ensure the CPUs see the
> >> correct data. =20
> >=20
> > The descriptors - i.e. struct cbd_t fields are allocated with
> > dma_alloc_coherent(), so this is OK. =20
>=20
> I'm talking about packets contents, not packet descriptors. Please
> re-read the above and have a look at other drivers code.

The usage of dma_sync_single_for_cpu() works without issues in the
mtip_switch_rx().

>=20
> An additional point that I missed in the previous review is that the
> rx allocation schema is quite uncorrect. At ring initialization time
> you allocate full skbs, while what you need and use is just raw
> buffers for the packet payload. Instead you could/should use the page
> pool:
>=20
> Documentation/networking/page_pool.rst
>=20

Yes, for RX packets payload the page of 2048 bytes is allocated. By
using dma page pool - I can state the same maximal size, but the usage
of memory can be much more flexible.

> That will also help doing the right thing WRT DMA handling.
>=20

The dma_sync_single_for_cpu() shall work correctly with the current
approach as well.

> >> This patch is really too big, I'm pretty sure I missed some
> >> relevant issues. You should split it in multiple ones: i.e.
> >> initialization and h/w access, rx/tx, others ndos. =20
> >=20
> > It is quite hard to "scatter" this patch as:
> >=20
> > 1. I've already split it to several files (which correspond to
> > different "logical" entities - like mtipl2sw_br.c).
> > 2. The mtipl2sw.c file is the smallest part of the "core" of the
> > driver.
> > 3. If I split it, then at some point I would break bisectability for
> > imx28. =20
>=20
> Note that each patch don't need to provide complete functionality.
> i.e. patch 1 could implement ndo_open()/close and related helper,
> leaving ndo_start_xmit() and napi_poll empty and avoid allocating the
> rx buffers. patch 2 could implement the rx patch, patch 3 the tx path.
>=20

Yes, this seems to be a good idea... I will implement such approach.

> The only constraint is that each patch will build successufully, which
> is usually easy to achieve.

+1

>=20
> A 2K lines patches will probably lead to many more iterations and
> unhappy (or no) reviewers.

The problem is that all the patches "around" this driver (like *yaml,
bindings, defconfig) would get outdated very fast if not pull to
mainline.

In such a way that already done work would need to be redo...

>=20
> /P
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/sgnmYD9Yr/9ZQSdJ73NdC6_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhHZ/gACgkQAR8vZIA0
zr35NAf7BsWyM4PkwH9k8LanL+CVfhF1A32/dAugkR1hlODpkay0KHkoIXvmUt2a
+/0jcZiNrVmndySoOy+U6BCQsN6+qh34jg0Pn68gb1++WsLq473e8jldjZcyK35T
4ke3yvNRDViSgjwIyM9qeoZvIXUrWr7sEWR5wxHPDhRacYRU4vbra4F/ONnrh43A
e71Np4aSgTadeoPKMe9mkYHft5sE0PRU4Mm0jK6f3ubT4F5Hz086z/LKNmjfSz9F
YLVkbQXJGUQlB4DJhwdYXc4R1cqCj5cuCBHyLIwbusHDrDaT4TJFinzoOLr3weCq
q9bXC3suqEgacBcHzqSrZF8cXvjhjQ==
=FVxJ
-----END PGP SIGNATURE-----

--Sig_/sgnmYD9Yr/9ZQSdJ73NdC6_--

