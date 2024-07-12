Return-Path: <netdev+bounces-110990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302292F348
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C602D1F22905
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0761FAA;
	Fri, 12 Jul 2024 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST+XM9Ce"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65B10E3;
	Fri, 12 Jul 2024 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746606; cv=none; b=MXj/gza276DZ/5YVJaWvSaBrSQPsir4YRQVLHFTvMoyULJzDr3SQW/p8To5xJkheyU5BbgjnEwcG4dgKFoYXQzrvqa8rWaJMq7bH6dfckTGZbGeRqtPnKoF6fAwj/gD4IqUlsgTBy/rPyeXULd+NST/ZZz1Ful46B7zDGrjf+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746606; c=relaxed/simple;
	bh=pbT57k7QB3HrURFKNbnnjOrCHWNpdlLB7IX4cdo349Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+tsyWI4owyWXDMn1Rom/zqtFqBuSz2dF32BU6fofCZDwr0FythPl3gz3V3xH4ufPPnv5UIo4QLtoRcSXmp4cer230C2p67oRH/VIj4e6eGf50enshvFv4oaBQZaHTPCyD/2fIH6CjyQmfRAtvydbr5HAeB+zYF1xh27LaPA92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST+XM9Ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07D7C116B1;
	Fri, 12 Jul 2024 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720746605;
	bh=pbT57k7QB3HrURFKNbnnjOrCHWNpdlLB7IX4cdo349Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ST+XM9Cem5GiFdrAEFwqLg7T7ZfCDV8jJrMm/RoTB63Vh3YdxODXNzYhSx/ok+chE
	 RRJXstoI1etRNXR0PA6cJf14UqTikoMaTJXB+6C5pyAFx7t66kqU+M4ERxIRS6aXcs
	 iPH0ApcNqhmrDSO7Yi6rejwLM0MiQXrSc2HBRbp7L4gmWQAxBAa2flkx3OGTmrwx7U
	 g64mkkgB9c5Fih4oECA8B2v+YnvriA5kYnQHE4mTbhXR7884pYiOHTIIloTdsLf44M
	 A4CMm3m3F4H3joPigcm/ViL/wzUDmX5pC9c8qJKu/Q+wKzQieOQ9H8rAtkc/ujqwb4
	 HAM3teTMqmwpQ==
Date: Thu, 11 Jul 2024 18:10:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 conor@kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 upstream@airoha.com, angelogioacchino.delregno@collabora.com,
 benjamin.larsson@genexis.eu, rkannoth@marvell.com, sgoutham@marvell.com,
 andrew@lunn.ch, arnd@arndb.de, horms@kernel.org
Subject: Re: [PATCH v7 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <20240711181003.4089a633@kernel.org>
In-Reply-To: <8ca603f8cea1ad64b703191b4c780bab87cb7dff.1720600905.git.lorenzo@kernel.org>
References: <cover.1720600905.git.lorenzo@kernel.org>
	<8ca603f8cea1ad64b703191b4c780bab87cb7dff.1720600905.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jul 2024 10:47:41 +0200 Lorenzo Bianconi wrote:
> Add airoha_eth driver in order to introduce ethernet support for
> Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> en7581-evb networking architecture is composed by airoha_eth as mac
> controller (cpu port) and a mt7530 dsa based switch.
> EN7581 mac controller is mainly composed by Frame Engine (FE) and
> QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> functionalities are supported now) while QDMA is used for DMA operation
> and QOS functionalities between mac layer and the dsa switch (hw QoS is
> not available yet and it will be added in the future).
> Currently only hw lan features are available, hw wan will be added with
> subsequent patches.

It seems a bit unusual for DSA to have multiple ports, isn't it?
Can you explain how this driver differs from normal DSA a little=20
more in the commit message?

> +static void airoha_dev_get_stats64(struct net_device *dev,
> +				   struct rtnl_link_stats64 *storage)
> +{
> +	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +
> +	mutex_lock(&port->stats.mutex);

can't take sleeping locks here :( Gotta do periodic updates from=20
a workqueue or spinlock. there are callers under RCU (annoyingly)

> +	airoha_update_hw_stats(port);
> +	storage->rx_packets =3D port->stats.rx_ok_pkts;
> +	storage->tx_packets =3D port->stats.tx_ok_pkts;
> +	storage->rx_bytes =3D port->stats.rx_ok_bytes;
> +	storage->tx_bytes =3D port->stats.tx_ok_bytes;
> +	storage->multicast =3D port->stats.rx_multicast;
> +	storage->rx_errors =3D port->stats.rx_errors;
> +	storage->rx_dropped =3D port->stats.rx_drops;
> +	storage->tx_dropped =3D port->stats.tx_drops;
> +	storage->rx_crc_errors =3D port->stats.rx_crc_error;
> +	storage->rx_over_errors =3D port->stats.rx_over_errors;
> +
> +	mutex_unlock(&port->stats.mutex);
> +}
> +
> +static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
> +				   struct net_device *dev)
> +{
> +	struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> +	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	int i, qid =3D skb_get_queue_mapping(skb);
> +	struct airoha_eth *eth =3D port->eth;
> +	u32 nr_frags, msg0 =3D 0, msg1;
> +	u32 len =3D skb_headlen(skb);
> +	struct netdev_queue *txq;
> +	struct airoha_queue *q;
> +	void *data =3D skb->data;
> +	u16 index;
> +	u8 fport;
> +
> +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
> +		msg0 |=3D FIELD_PREP(QDMA_ETH_TXMSG_TCO_MASK, 1) |
> +			FIELD_PREP(QDMA_ETH_TXMSG_UCO_MASK, 1) |
> +			FIELD_PREP(QDMA_ETH_TXMSG_ICO_MASK, 1);
> +
> +	/* TSO: fill MSS info in tcp checksum field */
> +	if (skb_is_gso(skb)) {
> +		if (skb_cow_head(skb, 0))
> +			goto error;
> +
> +		if (sinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
> +			__be16 csum =3D cpu_to_be16(sinfo->gso_size);
> +
> +			tcp_hdr(skb)->check =3D (__force __sum16)csum;
> +			msg0 |=3D FIELD_PREP(QDMA_ETH_TXMSG_TSO_MASK, 1);
> +		}
> +	}
> +
> +	fport =3D port->id =3D=3D 4 ? FE_PSE_PORT_GDM4 : port->id;
> +	msg1 =3D FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
> +	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
> +
> +	if (WARN_ON_ONCE(qid >=3D ARRAY_SIZE(eth->q_tx)))
> +		qid =3D 0;

Hm, how? Stack should protect against that.

> +	q =3D &eth->q_tx[qid];
> +	if (WARN_ON_ONCE(!q->ndesc))
> +		goto error;
> +
> +	spin_lock_bh(&q->lock);
> +
> +	nr_frags =3D 1 + sinfo->nr_frags;
> +	if (q->queued + nr_frags > q->ndesc) {
> +		/* not enough space in the queue */
> +		spin_unlock_bh(&q->lock);
> +		return NETDEV_TX_BUSY;

no need to stop the queue?

> +	}
> +
> +	index =3D q->head;
> +	for (i =3D 0; i < nr_frags; i++) {
> +		struct airoha_qdma_desc *desc =3D &q->desc[index];
> +		struct airoha_queue_entry *e =3D &q->entry[index];
> +		skb_frag_t *frag =3D &sinfo->frags[i];
> +		dma_addr_t addr;
> +		u32 val;
> +
> +		addr =3D dma_map_single(dev->dev.parent, data, len,
> +				      DMA_TO_DEVICE);
> +		if (unlikely(dma_mapping_error(dev->dev.parent, addr)))
> +			goto error_unmap;
> +
> +		index =3D (index + 1) % q->ndesc;
> +
> +		val =3D FIELD_PREP(QDMA_DESC_LEN_MASK, len);
> +		if (i < nr_frags - 1)
> +			val |=3D FIELD_PREP(QDMA_DESC_MORE_MASK, 1);
> +		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
> +		WRITE_ONCE(desc->addr, cpu_to_le32(addr));
> +		val =3D FIELD_PREP(QDMA_DESC_NEXT_ID_MASK, index);
> +		WRITE_ONCE(desc->data, cpu_to_le32(val));
> +		WRITE_ONCE(desc->msg0, cpu_to_le32(msg0));
> +		WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
> +		WRITE_ONCE(desc->msg2, cpu_to_le32(0xffff));
> +
> +		e->skb =3D i ? NULL : skb;
> +		e->dma_addr =3D addr;
> +		e->dma_len =3D len;
> +
> +		airoha_qdma_rmw(eth, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
> +				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
> +
> +		data =3D skb_frag_address(frag);
> +		len =3D skb_frag_size(frag);
> +	}
> +
> +	q->head =3D index;
> +	q->queued +=3D i;
> +
> +	txq =3D netdev_get_tx_queue(dev, qid);
> +	netdev_tx_sent_queue(txq, skb->len);
> +	skb_tx_timestamp(skb);
> +
> +	if (q->ndesc - q->queued < q->free_thr)
> +		netif_tx_stop_queue(txq);
> +
> +	spin_unlock_bh(&q->lock);
> +
> +	return NETDEV_TX_OK;
> +
> +error_unmap:
> +	for (i--; i >=3D 0; i++)
> +		dma_unmap_single(dev->dev.parent, q->entry[i].dma_addr,
> +				 q->entry[i].dma_len, DMA_TO_DEVICE);
> +
> +	spin_unlock_bh(&q->lock);
> +error:
> +	dev_kfree_skb_any(skb);
> +	dev->stats.tx_dropped++;
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static const char * const airoha_ethtool_stats_name[] =3D {
> +	"tx_eth_bc_cnt",
> +	"tx_eth_mc_cnt",

struct ethtool_eth_mac_stats

> +	"tx_eth_lt64_cnt",
> +	"tx_eth_eq64_cnt",
> +	"tx_eth_65_127_cnt",
> +	"tx_eth_128_255_cnt",
> +	"tx_eth_256_511_cnt",
> +	"tx_eth_512_1023_cnt",
> +	"tx_eth_1024_1518_cnt",
> +	"tx_eth_gt1518_cnt",

struct ethtool_rmon_stats=20

> +	"rx_eth_bc_cnt",
> +	"rx_eth_frag_cnt",
> +	"rx_eth_jabber_cnt",

those are also covered.. somewhere..

> +	"rx_eth_fc_drops",
> +	"rx_eth_rc_drops",
> +	"rx_eth_lt64_cnt",
> +	"rx_eth_eq64_cnt",
> +	"rx_eth_65_127_cnt",
> +	"rx_eth_128_255_cnt",
> +	"rx_eth_256_511_cnt",
> +	"rx_eth_512_1023_cnt",
> +	"rx_eth_1024_1518_cnt",
> +	"rx_eth_gt1518_cnt",
> +};
> +
> +static void airoha_ethtool_get_drvinfo(struct net_device *dev,
> +				       struct ethtool_drvinfo *info)
> +{
> +	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_eth *eth =3D port->eth;
> +
> +	strscpy(info->driver, eth->dev->driver->name, sizeof(info->driver));
> +	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
> +	info->n_stats =3D ARRAY_SIZE(airoha_ethtool_stats_name) +
> +			page_pool_ethtool_stats_get_count();
> +}
> +
> +static void airoha_ethtool_get_strings(struct net_device *dev, u32 sset,
> +				       u8 *data)
> +{
> +	int i;
> +
> +	if (sset !=3D ETH_SS_STATS)
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_stats_name); i++)
> +		ethtool_puts(&data, airoha_ethtool_stats_name[i]);
> +
> +	page_pool_ethtool_stats_get_strings(data);
> +}
> +
> +static int airoha_ethtool_get_sset_count(struct net_device *dev, int sse=
t)
> +{
> +	if (sset !=3D ETH_SS_STATS)
> +		return -EOPNOTSUPP;
> +
> +	return ARRAY_SIZE(airoha_ethtool_stats_name) +
> +	       page_pool_ethtool_stats_get_count();
> +}
> +
> +static void airoha_ethtool_get_stats(struct net_device *dev,
> +				     struct ethtool_stats *stats, u64 *data)
> +{
> +	int off =3D offsetof(struct airoha_hw_stats, tx_broadcast) / sizeof(u64=
);
> +	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	u64 *hw_stats =3D (u64 *)&port->stats + off;
> +	struct page_pool_stats pp_stats =3D {};
> +	struct airoha_eth *eth =3D port->eth;
> +	int i;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(airoha_ethtool_stats_name) + off !=3D
> +		     sizeof(struct airoha_hw_stats) / sizeof(u64));
> +
> +	mutex_lock(&port->stats.mutex);
> +
> +	airoha_update_hw_stats(port);
> +	for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_stats_name); i++)
> +		*data++ =3D hw_stats[i];
> +
> +	for (i =3D 0; i < ARRAY_SIZE(eth->q_rx); i++) {
> +		if (!eth->q_rx[i].ndesc)
> +			continue;
> +
> +		page_pool_get_stats(eth->q_rx[i].page_pool, &pp_stats);
> +	}
> +	page_pool_ethtool_stats_get(data, &pp_stats);

We can't use the netlink stats because of the shared DMA / shared
device? mlxsw had a similar problem recently:

https://lore.kernel.org/all/20240625120807.1165581-1-amcohen@nvidia.com/

Can we list the stats without a netdev or add a new netlink attr
to describe such devices? BTW setting pp->netdev to an unregistered
device is probably a bad idea, we should add a WARN_ON() for that
if we don't have one =F0=9F=98=AE=EF=B8=8F

> +	for_each_child_of_node(pdev->dev.of_node, np) {
> +		if (!of_device_is_compatible(np, "airoha,eth-mac"))
> +			continue;
> +
> +		if (!of_device_is_available(np))
> +			continue;
> +
> +		err =3D airoha_alloc_gdm_port(eth, np);
> +		if (err) {
> +			of_node_put(np);
> +			goto error;
> +		}
> +	}
> +
> +	airoha_qdma_start_napi(eth);

Are you sure starting the NAPI after registration is safe?
Nothing will go wrong if interface gets opened before
airoha_qdma_start_napi() gets to run?

Also you don't seem to call napi_disable(), NAPI can reschedule itself,
and netif_napi_del() doesn't wait for quiescence.

