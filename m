Return-Path: <netdev+bounces-277326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIsnC2rQ2GngiQgAu9opvQ
	(envelope-from <netdev+bounces-277326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:26:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B04EC3D5A91
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEDF1302D099
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6637837997E;
	Fri, 10 Apr 2026 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DchYC5sZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBA35F191;
	Fri, 10 Apr 2026 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816354; cv=none; b=r5Ozb0NutGnthcjirR2hi7KoEwVqUkJCXXeib7RWAXzffnSkIG1XsnCjr+uPmOOw7D9hPJLiXSjY2iM5X3lv1TpUEbEW8tYutv3c+95lwB8b/fTfjI5BrZDshWJdOPPW8PDYdejs1CSgDFYJIfc93fcWTDtQs2C+ID+bkN1GVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816354; c=relaxed/simple;
	bh=Fj4C42BDLN7WQk1jqppya3iWTXB2OunJypTGFWlANfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWd0c3D2ro4tHzanJkx4jERygwHe8Z2Z0FsaAM2Ukqgi3SiwwT6+P8LaEUgnyVu6xx1slXk9qp5tsqygZ8ISGTiFOz8DXIevU6Xo+NgRr34z1pXZ7pIpplpU4DRXkyLi7Z3rMjdI7nn/hfujth2IUEMaxOMPL6TEMCusjmrSGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DchYC5sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C024C19421;
	Fri, 10 Apr 2026 10:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775816353;
	bh=Fj4C42BDLN7WQk1jqppya3iWTXB2OunJypTGFWlANfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DchYC5sZrS7vic2vzXpvGKEdMa5fMHDqxyZi+AppNhi5KqE50w1BYhg4huLouHa0E
	 OW4wYOYt/WeyLq1b2siLuKLGsvTaf2WsfGRyKw3DLB7RmMk9vE6Kov34OIR3dOzBXL
	 ypAHcdN658wDYgocim+4bClKd++05SUL9bXWw/WmtsGENzMQvN0pqd9xZ3P3s9CcCX
	 Gqid/GyVKFR+O7rn03/hfku78oMub146JP6CLV8yHSdbRyES7ZwSaywBZnZccsdjFn
	 GY8Ow4RyldTUuwF1KvxeVAPeaMGDMIDahgnklMkS9tE1xcc2fkXQQBQwDABjkcYaze
	 rHHfiDVc0Zn2Q==
Date: Fri, 10 Apr 2026 12:19:11 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/12] net: airoha: Support multiple
 net_devices for a single FE GDM port
Message-ID: <adjOn0550QWZ-YdY@lore-desk>
References: <20260406-airoha-eth-multi-serdes-v3-9-ab6ea49d59ff@kernel.org>
 <20260410025724.1810007-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Aybuzh65bmgfKOa2"
Content-Disposition: inline
In-Reply-To: <20260410025724.1810007-1-kuba@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277326-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B04EC3D5A91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Aybuzh65bmgfKOa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 09, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "For your consideration."
> ---
> net: airoha: Support multiple net_devices for a single FE GDM port
>=20
> This commit introduces support for mapping multiple net_device interfaces
> to a single Frame Engine (FE) GDM port via an external hardware arbiter.
> It updates the rx/tx paths, port allocation, and registration logic to
> handle the new net_device array.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> [ ... ]
> > @@ -615,9 +617,8 @@ static int airoha_qdma_rx_process(struct airoha_que=
ue *q, int budget)
> >  		u32 hash, reason, msg1 =3D le32_to_cpu(desc->msg1);
> >  		struct page *page =3D virt_to_head_page(e->buf);
> >  		u32 desc_ctrl =3D le32_to_cpu(desc->ctrl);
> > -		struct airoha_gdm_port *port;
> > -		struct net_device *netdev;
> > -		int data_len, len, p;
> > +		struct airoha_gdm_dev *dev;
> > +		int data_len, len;
> > =20
> >  		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
> >  			break;
>=20
> While looking at this code, I noticed an issue that predates this patch.
> Can the lack of a memory barrier after checking the descriptor ownership =
bit
> cause stale reads?
>=20
> The driver checks QDMA_DESC_DONE_MASK to verify that the hardware has fin=
ished
> writing the descriptor. However, it reads desc->msg1 before this check and
> without a dma_rmb():
>=20
> 		u32 hash, reason, msg1 =3D le32_to_cpu(desc->msg1);
> 		struct page *page =3D virt_to_head_page(e->buf);
> 		u32 desc_ctrl =3D le32_to_cpu(desc->ctrl);
>=20
> 		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
> 			break;
>=20
> Since weakly ordered architectures can reorder memory reads, could the CPU
> prefetch msg1 before the DMA engine writes the new descriptor values, lea=
ding
> to routing the packet to the wrong gdm_dev?

This issue has been already fixed with the following commit:

commit 4ae0604a0673e11e2075b178387151fcad5111b5
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Tue Apr 7 08:48:04 2026 +0200

    net: airoha: Add dma_rmb() and READ_ONCE() in airoha_qdma_rx_process()
   =20
    Add missing dma_rmb() in airoha_qdma_rx_process routine to make sure the
    DMA read operations are completed when the NIC reports the processing on
    the current descriptor is done. Moreover, add missing READ_ONCE() in
    airoha_qdma_rx_process() for DMA descriptor control fields in order to
    avoid any compiler reordering.

>=20
> [ ... ]
> > @@ -1764,9 +1765,7 @@ static int airoha_set_gdm2_loopback(struct airoha=
_gdm_dev *dev)
> >  	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
> >  	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
> > =20
> > -	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
> > -	nbq =3D port->id =3D=3D AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : =
0;
> > -	src_port =3D eth->soc->ops.get_src_port_id(port, nbq);
> > +	src_port =3D eth->soc->ops.get_src_port_id(port, dev->nbq);
> >  	if (src_port < 0)
> >  		return src_port;
>=20
> Can configuring the loopback for one device break connectivity for other
> devices sharing the same port?
>=20
> When multiple net_devices (like PCIE0 and PCIE1 on GDM3) open and call
> airoha_set_gdm2_loopback(), they modify global hardware registers such as
> REG_FE_WAN_PORT.
>=20
> Since WAN0_MASK is unconditionally updated to track the current device's
> src_port:
>=20
> 	airoha_fe_rmw(eth, REG_FE_WAN_PORT,
> 		      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
> 		      FIELD_PREP(WAN0_MASK, src_port));
>=20
> won't the last configured device clobber the hardware state for the other=
s?

This issue is fixed with the following patch in the series:

commit 008995bd8f39c5fdf37a933fa3c962e7ef52e8c6
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Fri Apr 3 12:07:27 2026 +0200

    net: airoha: Introduce WAN device flag
   =20
    Introduce WAN flag to specify if a given device is used to transmit/rec=
eive
    WAN or LAN traffic. Current codebase supports specifying LAN/WAN device
    configuration in ndo_init() callback during device bootstrap.
    Please note it is possible to specify multiple LAN devices but just a
    single WAN one.

>=20
> [ ... ]
> > @@ -1987,7 +1986,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff=
 *skb,
> >  	}
> > =20
> >  	fport =3D airoha_get_fe_port(dev);
> > -	msg1 =3D FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
> > +	msg1 =3D FIELD_PREP(QDMA_ETH_TXMSG_NBOQ_MASK, dev->nbq) |
> > +	       FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
> >  	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
> > =20
> >  	q =3D &qdma->q_tx[qid];
>=20
> Does sharing the hardware QDMA TX queues among multiple net_device instan=
ces
> introduce a permanent transmit stall?
>=20
> In airoha_dev_xmit(), if a shared hardware queue is full, the driver stop=
s the
> netdev_queue of the specific netdev making the call:
>=20
> 	if (q->queued + nr_frags >=3D q->ndesc) {
> 		/* not enough space in the queue */
> 		netif_tx_stop_queue(txq);
> 		spin_unlock_bh(&q->lock);
> 		return NETDEV_TX_BUSY;
> 	}
>=20
> However, the TX completion handler (airoha_tx_irq_process()) only wakes t=
he
> queue of the netdev attached to the completed packet. If an interface's TX
> queue is stopped but it has no pending packets in the hardware queue (bec=
ause
> another interface filled it), will it ever get woken up?

This issue is orthogonal to this series and it will be fixed with a dedicat=
ed
patch.

>=20
> [ ... ]
> > @@ -2955,11 +2958,25 @@ static int airoha_alloc_gdm_device(struct airoh=
a_eth *eth,
> >  			 netdev->dev_addr);
> >  	}
> > =20
> > +	/* Allowed nbq for EN7581 on GDM3 port are 4 and 5 for PCIE0
> > +	 * and PCIE1 respectively.
> > +	 */
> > +	index =3D nbq;
> > +	if (index && airoha_is_7581(eth) && port->id =3D=3D AIROHA_GDM3_IDX)
> > +		index -=3D 4;
> > +
> > +	if (index >=3D ARRAY_SIZE(port->devs) || port->devs[index]) {
> > +		dev_err(eth->dev, "invalid nbq id: %d\n", nbq);
> > +		return -EINVAL;
> > +	}
> > +
> > +	netdev->dev.of_node =3D of_node_get(np);
> >  	dev =3D netdev_priv(netdev);
>=20
> Does this code leak the of_node reference?
>=20
> The node reference is explicitly incremented via of_node_get(np). The net=
working
> core does not automatically drop explicit of_node references on free_netd=
ev().
> Without a matching of_node_put() in the error paths or the driver's teard=
own
> function (airoha_remove()), will this reference permanently leak when the=
 device
> is destroyed?

ack, I will fix it in v4.

>=20
> [ ... ]
> > @@ -3003,7 +3021,43 @@ static int airoha_alloc_gdm_port(struct airoha_e=
th *eth,
> >  	if (err)
> >  		return err;
> > =20
> > -	return airoha_alloc_gdm_device(eth, port, np);
> > +	for_each_child_of_node(np, node) {
> > +		/* Multiple external serdes connected to the FE GDM port via an
> > +		 * external arbiter.
> > +		 */
> > +		const __be32 *nbq_ptr;
> > +		int nbq;
> > +
> > +		if (!of_device_is_compatible(node, "airoha,eth-port"))
> > +			continue;
> > +
> > +		d++;
> > +		if (!of_device_is_available(node))
> > +			continue;
> > +
> > +		nbq_ptr =3D of_get_property(node, "reg", NULL);
> > +		if (!nbq_ptr) {
> > +			dev_err(eth->dev, "missing nbq id\n");
> > +			of_node_put(node);
> > +			return -EINVAL;
> > +		}
> > +
> > +		/* Verify the provided nbq parameter is valid */
> > +		nbq =3D be32_to_cpup(nbq_ptr);
> > +		err =3D eth->soc->ops.get_src_port_id(port, nbq);
> > +		if (err < 0) {
> > +			of_node_put(node);
> > +			return err;
> > +		}
> > +
> > +		err =3D airoha_alloc_gdm_device(eth, port, nbq, node);
> > +		if (err) {
> > +			of_node_put(node);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	return !d ? airoha_alloc_gdm_device(eth, port, 0, np) : 0;
> >  }
>=20
> Does passing 0 for nbq in the fallback path break older device trees on t=
he
> EN7581 SoC?
>=20
> Later, when the interface is brought up, airoha_set_gdm2_loopback() calls
> airoha_en7581_get_src_port_id(), which returns -EINVAL for GDM3 if nbq is
> not 4 or 5:
>=20
> 	switch (port->id) {
> 	case AIROHA_GDM3_IDX:
> 		/* 7581 SoC supports PCIe serdes on GDM3 port */
> 		if (nbq =3D=3D 4)
> 			return HSGMII_LAN_7581_PCIE0_SRCPORT;
> 		if (nbq =3D=3D 5)
> 			return HSGMII_LAN_7581_PCIE1_SRCPORT;
> 		break;
>=20
> If nbq is hardcoded to 0 for legacy DTs, won't this cause interface
> initialization to fail unconditionally for GDM3?

ack, I will fix it in v4.

Regards,
Lorenzo

--Aybuzh65bmgfKOa2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCadjOnwAKCRA6cBh0uS2t
rJASAP9J84H1ZIlSgkxdU7WMyi5p/tZM5uZwUHj5u+PXljlaiQEApmQOhjtESrZr
mYT48YUrqHkMigBz7vCYWLpaAQQVagQ=
=hFjV
-----END PGP SIGNATURE-----

--Aybuzh65bmgfKOa2--

