Return-Path: <netdev+bounces-111073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ACD92FBB6
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3A71F22C23
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C49D16F8F3;
	Fri, 12 Jul 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCpJAWGB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260E7407B;
	Fri, 12 Jul 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792063; cv=none; b=RTjvXGOboZMJBh9+4UJtomig7C2qxaq2tyvT5VY6W18f0qxwTs9hFXOdYCPTySiM5uHMUCecBzJ6r0FU2jItHv4m8iAZs2PMhtVFaPhctJU7QaJ8VMTKfPzC1zvHTo96+2MBnB/s1+7JEwWi1PezuV/iwCfNxn9zYXwkzlY6nmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792063; c=relaxed/simple;
	bh=Cbs4uEgVFz0twvkFBPF14O1aMhyq7/WrRj983laoddU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojQCWiA3w1sOWF2782RPK6o5KHcM3xEF+cPVr8Swt4FXoJgRRUXngZAbGk1XLDMP99YyUiJkZRipmpFTQbAFrLFKZs+vBVYc5/APMmYbQNOTjXYcoiMQF9NVBU3xTUjs74JELLXk2GKdVnllzLfCRiAJTdJ/UetVL/QWTu8vtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCpJAWGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0700DC32782;
	Fri, 12 Jul 2024 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792062;
	bh=Cbs4uEgVFz0twvkFBPF14O1aMhyq7/WrRj983laoddU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCpJAWGB+CqhiNtW+nKhnOcVbFZ5jGOc7Ice7gkgorUG7AJSnLxKzersXZ2Rgt5++
	 bhs/2IxVzwnM0TdyWHqlofA0SvXpCH32e42XihlYi0++1BGFeT02azmWL9nQmiUXYc
	 XPN5nzj4hZewAKLh3FUJAeRcyIL/0UEZ8r2yzUkIROrtIFLvCQPZ3IWuonLh78BNPn
	 MgzcZe08TOK1K/w/ajwI0fHoW+4XAm6i05fcx9p1Wfuu269997cvWMCqUrU3vM6DEu
	 hy9s6iuvf/t7ZaPAisaZEya8XB+z9xnu21GQ1KrfToAQ2EalQb0s44MR1qsUMUjYvv
	 kBj9Pl9jBrrRA==
Date: Fri, 12 Jul 2024 15:47:38 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	conor@kernel.org, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
	horms@kernel.org
Subject: Re: [PATCH v7 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <ZpEz-o1Dkg1gF_ud@lore-desk>
References: <cover.1720600905.git.lorenzo@kernel.org>
 <8ca603f8cea1ad64b703191b4c780bab87cb7dff.1720600905.git.lorenzo@kernel.org>
 <20240711181003.4089a633@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EbyGczZ25h78mBaS"
Content-Disposition: inline
In-Reply-To: <20240711181003.4089a633@kernel.org>


--EbyGczZ25h78mBaS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 10 Jul 2024 10:47:41 +0200 Lorenzo Bianconi wrote:
> > Add airoha_eth driver in order to introduce ethernet support for
> > Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> > en7581-evb networking architecture is composed by airoha_eth as mac
> > controller (cpu port) and a mt7530 dsa based switch.
> > EN7581 mac controller is mainly composed by Frame Engine (FE) and
> > QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> > functionalities are supported now) while QDMA is used for DMA operation
> > and QOS functionalities between mac layer and the dsa switch (hw QoS is
> > not available yet and it will be added in the future).
> > Currently only hw lan features are available, hw wan will be added with
> > subsequent patches.
>=20
> It seems a bit unusual for DSA to have multiple ports, isn't it?
> Can you explain how this driver differs from normal DSA a little=20
> more in the commit message?

The Airoha eth SoC architecture is similar to mtk_eth_soc one (e.g MT7988a).
The FrameEngine (FE) module has multiple GDM ports that are connected to
different blocks. Current airoha_eth driver supports just GDM1 that is conn=
ected
to a MT7530 DSA switch (I have not posted a tiny patch for mt7530 driver ye=
t).
In the future we will support even GDM{2,3,4} that will connect to differ
phy modues (e.g. 2.5Gbps phy).

>=20
> > +static void airoha_dev_get_stats64(struct net_device *dev,
> > +				   struct rtnl_link_stats64 *storage)
> > +{
> > +	struct airoha_gdm_port *port =3D netdev_priv(dev);
> > +
> > +	mutex_lock(&port->stats.mutex);
>=20
> can't take sleeping locks here :( Gotta do periodic updates from=20
> a workqueue or spinlock. there are callers under RCU (annoyingly)

ack, I will fix it in v8

>=20
> > +	airoha_update_hw_stats(port);
> > +	storage->rx_packets =3D port->stats.rx_ok_pkts;
> > +	storage->tx_packets =3D port->stats.tx_ok_pkts;
> > +	storage->rx_bytes =3D port->stats.rx_ok_bytes;
> > +	storage->tx_bytes =3D port->stats.tx_ok_bytes;
> > +	storage->multicast =3D port->stats.rx_multicast;
> > +	storage->rx_errors =3D port->stats.rx_errors;
> > +	storage->rx_dropped =3D port->stats.rx_drops;
> > +	storage->tx_dropped =3D port->stats.tx_drops;
> > +	storage->rx_crc_errors =3D port->stats.rx_crc_error;
> > +	storage->rx_over_errors =3D port->stats.rx_over_errors;
> > +
> > +	mutex_unlock(&port->stats.mutex);
> > +}
> > +
> > +static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
> > +				   struct net_device *dev)
> > +{
> > +	struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > +	struct airoha_gdm_port *port =3D netdev_priv(dev);
> > +	int i, qid =3D skb_get_queue_mapping(skb);
> > +	struct airoha_eth *eth =3D port->eth;
> > +	u32 nr_frags, msg0 =3D 0, msg1;
> > +	u32 len =3D skb_headlen(skb);
> > +	struct netdev_queue *txq;
> > +	struct airoha_queue *q;
> > +	void *data =3D skb->data;
> > +	u16 index;
> > +	u8 fport;
> > +
> > +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
> > +		msg0 |=3D FIELD_PREP(QDMA_ETH_TXMSG_TCO_MASK, 1) |
> > +			FIELD_PREP(QDMA_ETH_TXMSG_UCO_MASK, 1) |
> > +			FIELD_PREP(QDMA_ETH_TXMSG_ICO_MASK, 1);
> > +
> > +	/* TSO: fill MSS info in tcp checksum field */
> > +	if (skb_is_gso(skb)) {
> > +		if (skb_cow_head(skb, 0))
> > +			goto error;
> > +
> > +		if (sinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
> > +			__be16 csum =3D cpu_to_be16(sinfo->gso_size);
> > +
> > +			tcp_hdr(skb)->check =3D (__force __sum16)csum;
> > +			msg0 |=3D FIELD_PREP(QDMA_ETH_TXMSG_TSO_MASK, 1);
> > +		}
> > +	}
> > +
> > +	fport =3D port->id =3D=3D 4 ? FE_PSE_PORT_GDM4 : port->id;
> > +	msg1 =3D FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
> > +	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
> > +
> > +	if (WARN_ON_ONCE(qid >=3D ARRAY_SIZE(eth->q_tx)))
> > +		qid =3D 0;
>=20
> Hm, how? Stack should protect against that.

ack, I will fix it in v8

>=20
> > +	q =3D &eth->q_tx[qid];
> > +	if (WARN_ON_ONCE(!q->ndesc))
> > +		goto error;
> > +
> > +	spin_lock_bh(&q->lock);
> > +
> > +	nr_frags =3D 1 + sinfo->nr_frags;
> > +	if (q->queued + nr_frags > q->ndesc) {
> > +		/* not enough space in the queue */
> > +		spin_unlock_bh(&q->lock);
> > +		return NETDEV_TX_BUSY;
>=20
> no need to stop the queue?

reviewing this chunk, I guess we can get rid of it since we already block t=
he
txq at the end of airoha_dev_xmit() if we do not have enough space for the =
next
packet:

	if (q->ndesc - q->queued < q->free_thr)
		netif_tx_stop_queue(txq);

>=20
> > +	}
> > +
> > +	index =3D q->head;
> > +	for (i =3D 0; i < nr_frags; i++) {
> > +		struct airoha_qdma_desc *desc =3D &q->desc[index];
> > +		struct airoha_queue_entry *e =3D &q->entry[index];
> > +		skb_frag_t *frag =3D &sinfo->frags[i];
> > +		dma_addr_t addr;
> > +		u32 val;
> > +
> > +		addr =3D dma_map_single(dev->dev.parent, data, len,
> > +				      DMA_TO_DEVICE);
> > +		if (unlikely(dma_mapping_error(dev->dev.parent, addr)))
> > +			goto error_unmap;
> > +
> > +		index =3D (index + 1) % q->ndesc;
> > +
> > +		val =3D FIELD_PREP(QDMA_DESC_LEN_MASK, len);
> > +		if (i < nr_frags - 1)
> > +			val |=3D FIELD_PREP(QDMA_DESC_MORE_MASK, 1);
> > +		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
> > +		WRITE_ONCE(desc->addr, cpu_to_le32(addr));
> > +		val =3D FIELD_PREP(QDMA_DESC_NEXT_ID_MASK, index);
> > +		WRITE_ONCE(desc->data, cpu_to_le32(val));
> > +		WRITE_ONCE(desc->msg0, cpu_to_le32(msg0));
> > +		WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
> > +		WRITE_ONCE(desc->msg2, cpu_to_le32(0xffff));
> > +
> > +		e->skb =3D i ? NULL : skb;
> > +		e->dma_addr =3D addr;
> > +		e->dma_len =3D len;
> > +
> > +		airoha_qdma_rmw(eth, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
> > +				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
> > +
> > +		data =3D skb_frag_address(frag);
> > +		len =3D skb_frag_size(frag);
> > +	}
> > +
> > +	q->head =3D index;
> > +	q->queued +=3D i;
> > +
> > +	txq =3D netdev_get_tx_queue(dev, qid);
> > +	netdev_tx_sent_queue(txq, skb->len);
> > +	skb_tx_timestamp(skb);
> > +
> > +	if (q->ndesc - q->queued < q->free_thr)
> > +		netif_tx_stop_queue(txq);
> > +
> > +	spin_unlock_bh(&q->lock);
> > +
> > +	return NETDEV_TX_OK;
> > +
> > +error_unmap:
> > +	for (i--; i >=3D 0; i++)
> > +		dma_unmap_single(dev->dev.parent, q->entry[i].dma_addr,
> > +				 q->entry[i].dma_len, DMA_TO_DEVICE);
> > +
> > +	spin_unlock_bh(&q->lock);
> > +error:
> > +	dev_kfree_skb_any(skb);
> > +	dev->stats.tx_dropped++;
> > +
> > +	return NETDEV_TX_OK;
> > +}
> > +
> > +static const char * const airoha_ethtool_stats_name[] =3D {
> > +	"tx_eth_bc_cnt",
> > +	"tx_eth_mc_cnt",
>=20
> struct ethtool_eth_mac_stats
>=20
> > +	"tx_eth_lt64_cnt",
> > +	"tx_eth_eq64_cnt",
> > +	"tx_eth_65_127_cnt",
> > +	"tx_eth_128_255_cnt",
> > +	"tx_eth_256_511_cnt",
> > +	"tx_eth_512_1023_cnt",
> > +	"tx_eth_1024_1518_cnt",
> > +	"tx_eth_gt1518_cnt",
>=20
> struct ethtool_rmon_stats=20
>=20
> > +	"rx_eth_bc_cnt",
> > +	"rx_eth_frag_cnt",
> > +	"rx_eth_jabber_cnt",
>=20
> those are also covered.. somewhere..

ack, I guess we can use .get_eth_mac_stats() and .get_rmon_stats() callbacks
and get rid of .get_ethtool_stats() one since it will duplicate stats
otherwise.

>=20
> > +	"rx_eth_fc_drops",
> > +	"rx_eth_rc_drops",
> > +	"rx_eth_lt64_cnt",
> > +	"rx_eth_eq64_cnt",
> > +	"rx_eth_65_127_cnt",
> > +	"rx_eth_128_255_cnt",
> > +	"rx_eth_256_511_cnt",
> > +	"rx_eth_512_1023_cnt",
> > +	"rx_eth_1024_1518_cnt",
> > +	"rx_eth_gt1518_cnt",
> > +};
> > +
> > +static void airoha_ethtool_get_drvinfo(struct net_device *dev,
> > +				       struct ethtool_drvinfo *info)
> > +{
> > +	struct airoha_gdm_port *port =3D netdev_priv(dev);
> > +	struct airoha_eth *eth =3D port->eth;
> > +
> > +	strscpy(info->driver, eth->dev->driver->name, sizeof(info->driver));
> > +	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
> > +	info->n_stats =3D ARRAY_SIZE(airoha_ethtool_stats_name) +
> > +			page_pool_ethtool_stats_get_count();
> > +}
> > +
> > +static void airoha_ethtool_get_strings(struct net_device *dev, u32 sse=
t,
> > +				       u8 *data)
> > +{
> > +	int i;
> > +
> > +	if (sset !=3D ETH_SS_STATS)
> > +		return;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_stats_name); i++)
> > +		ethtool_puts(&data, airoha_ethtool_stats_name[i]);
> > +
> > +	page_pool_ethtool_stats_get_strings(data);
> > +}
> > +
> > +static int airoha_ethtool_get_sset_count(struct net_device *dev, int s=
set)
> > +{
> > +	if (sset !=3D ETH_SS_STATS)
> > +		return -EOPNOTSUPP;
> > +
> > +	return ARRAY_SIZE(airoha_ethtool_stats_name) +
> > +	       page_pool_ethtool_stats_get_count();
> > +}
> > +
> > +static void airoha_ethtool_get_stats(struct net_device *dev,
> > +				     struct ethtool_stats *stats, u64 *data)
> > +{
> > +	int off =3D offsetof(struct airoha_hw_stats, tx_broadcast) / sizeof(u=
64);
> > +	struct airoha_gdm_port *port =3D netdev_priv(dev);
> > +	u64 *hw_stats =3D (u64 *)&port->stats + off;
> > +	struct page_pool_stats pp_stats =3D {};
> > +	struct airoha_eth *eth =3D port->eth;
> > +	int i;
> > +
> > +	BUILD_BUG_ON(ARRAY_SIZE(airoha_ethtool_stats_name) + off !=3D
> > +		     sizeof(struct airoha_hw_stats) / sizeof(u64));
> > +
> > +	mutex_lock(&port->stats.mutex);
> > +
> > +	airoha_update_hw_stats(port);
> > +	for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_stats_name); i++)
> > +		*data++ =3D hw_stats[i];
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->q_rx); i++) {
> > +		if (!eth->q_rx[i].ndesc)
> > +			continue;
> > +
> > +		page_pool_get_stats(eth->q_rx[i].page_pool, &pp_stats);
> > +	}
> > +	page_pool_ethtool_stats_get(data, &pp_stats);
>=20
> We can't use the netlink stats because of the shared DMA / shared
> device? mlxsw had a similar problem recently:
>=20
> https://lore.kernel.org/all/20240625120807.1165581-1-amcohen@nvidia.com/
>=20
> Can we list the stats without a netdev or add a new netlink attr
> to describe such devices? BTW setting pp->netdev to an unregistered
> device is probably a bad idea, we should add a WARN_ON() for that
> if we don't have one =F0=9F=98=AE=EF=B8=8F

ack, we have the same architecture here, rx queues/page_pools are shared
between net_devices. So far I used page_pool stats just for debugging so
I will remove them for the moment till we have a good/defined solution
for this kind of architecture.

>=20
> > +	for_each_child_of_node(pdev->dev.of_node, np) {
> > +		if (!of_device_is_compatible(np, "airoha,eth-mac"))
> > +			continue;
> > +
> > +		if (!of_device_is_available(np))
> > +			continue;
> > +
> > +		err =3D airoha_alloc_gdm_port(eth, np);
> > +		if (err) {
> > +			of_node_put(np);
> > +			goto error;
> > +		}
> > +	}
> > +
> > +	airoha_qdma_start_napi(eth);
>=20
> Are you sure starting the NAPI after registration is safe?
> Nothing will go wrong if interface gets opened before
> airoha_qdma_start_napi() gets to run?
>=20
> Also you don't seem to call napi_disable(), NAPI can reschedule itself,
> and netif_napi_del() doesn't wait for quiescence.

ack, I will fix it in v8.

Regards,
Lorenzo

--EbyGczZ25h78mBaS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZpEz+gAKCRA6cBh0uS2t
rPFXAP9aByoZI34nNj0eT6AIj6LYFANcapMCZ+wWnlIgVIGy1wD+LJ1ehts0Og5o
IhWDxQ/9uMrGY5I/MD7jptKEJrYPJQ4=
=IIuf
-----END PGP SIGNATURE-----

--EbyGczZ25h78mBaS--

