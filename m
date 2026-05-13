Return-Path: <netdev+bounces-287480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELfPGEA6BGoqFgIAu9opvQ
	(envelope-from <netdev+bounces-287480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:45:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D168D52FE17
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C4BC3013899
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B9E3DF00D;
	Wed, 13 May 2026 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhJDfSuA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273839EF2B;
	Wed, 13 May 2026 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661926; cv=none; b=dVzT8QeUdqu+xe7m2MGMVxNrQERPINDj1gApzTdXa0IvQJDkW7HbT1kBE72PLKwfQ7k0PyA2rtkzi57nm9PUHTBlEaWYbM9V64IUN049H+eD4LAVjogNi5OCC8pcSay+H6kp55IvHq/RTisl0MG1nW8HE9Y7JdOZjcUSWYQZ6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661926; c=relaxed/simple;
	bh=jwu+uu0rnBLvJnhGeNme6KjpiIiHqGW+NsZ7oiFUHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9QslL7FTjejnFxPm+ENzSV1JRaZB5KWBPcKkSQcS7Y39XouirivJsrIEJFpw2ZhOxoEd+/j3JkM8XrCJKLE+HcGA0sLvE3ix178M+yDptn1tvB6955SD1bPHe7ikGC3QEVr4+BvI0uZqZBTDMin3RHri+VmS9WrRwLnmL/2Tjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhJDfSuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA33C2BCB7;
	Wed, 13 May 2026 08:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778661925;
	bh=jwu+uu0rnBLvJnhGeNme6KjpiIiHqGW+NsZ7oiFUHVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhJDfSuAZmfhq3NWC8YNKCfMmzOIuJ4HqDAY8EQl+Xa2T2A83GaAnvBi0evCJE2ua
	 OUBEMg2v3h5V8GTzC3y3MRbT+vITxx0ie0NdvRRlD9gFkq24yfkLmBUyVqwYwbhz9Z
	 7CcRX7xByP7R7OKbxuhWLiqqQbuQvVTSWNdmPfl36kc5AXgWLT0kNrtLGaQmjcf4rV
	 qgEjB9cyvf3hSOIXBfetkw9ekQafNBOTgfiMaoTdbA5msYIt0Eoe+wSAJutf+SHGEr
	 HghV64GbimXQg+oaWppLGxqdvrv+pQRrC79qnYPbmow7cYDopA8VqvFFil0eRbqr7T
	 Fpt9DOFNmQgXw==
Date: Wed, 13 May 2026 10:45:22 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next v6 04/12] net: airoha: Move airoha_qdma pointer
 in airoha_gdm_dev struct
Message-ID: <agQ6ItB6HFgdffCx@lore-desk>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
 <20260511-airoha-eth-multi-serdes-v6-4-c899462c4f75@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NE+4h+Wyx7O1ITBi"
Content-Disposition: inline
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-4-c899462c4f75@kernel.org>
X-Rspamd-Queue-Id: D168D52FE17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287480-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Action: no action


--NE+4h+Wyx7O1ITBi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 11, Lorenzo Bianconi wrote:
> Move airoha_qdma pointer from airoha_gdm_port struct to airoha_gdm_dev
> one since the QDMA block used depends on the particular net_device
> WAN/LAN configuration and in the current codebase net_device pointer is
> associated to airoha_gdm_dev struct.
> This is a preliminary patch to support multiple net_devices connected
> to the same GDM{3,4} port via an external hw arbiter.
>=20
> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 105 +++++++++++++++----------=
------
>  drivers/net/ethernet/airoha/airoha_eth.h |   9 ++-
>  drivers/net/ethernet/airoha/airoha_ppe.c |  17 ++---
>  3 files changed, 64 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 18a89de4d58a..e0cd401bbf67 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -71,9 +71,10 @@ static void airoha_qdma_irq_disable(struct airoha_irq_=
bank *irq_bank,
>  	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
>  }
> =20
> -static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *a=
ddr)
> +static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *add=
r)
>  {
> -	struct airoha_eth *eth =3D port->qdma->eth;
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
>  	u32 val, reg;
> =20
>  	reg =3D airoha_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
> @@ -85,7 +86,7 @@ static void airoha_set_macaddr(struct airoha_gdm_port *=
port, const u8 *addr)
>  	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), val);
>  	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), val);
> =20
> -	airoha_ppe_init_upd_mem(port);
> +	airoha_ppe_init_upd_mem(dev);
>  }
> =20
>  static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
> @@ -101,10 +102,10 @@ static void airoha_set_gdm_port_fwd_cfg(struct airo=
ha_eth *eth, u32 addr,
>  		      FIELD_PREP(GDM_UCFQ_MASK, val));
>  }
> =20
> -static int airoha_set_vip_for_gdm_port(struct airoha_gdm_port *port,
> -				       bool enable)
> +static int airoha_set_vip_for_gdm_port(struct airoha_gdm_dev *dev, bool =
enable)
>  {
> -	struct airoha_eth *eth =3D port->qdma->eth;
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
>  	u32 vip_port;
> =20
>  	vip_port =3D eth->soc->ops.get_vip_port(port, port->nbq);
> @@ -858,10 +859,13 @@ static void airoha_qdma_wake_netdev_txqs(struct air=
oha_queue *q)
>  		if (!port)
>  			continue;
> =20
> -		if (port->qdma !=3D qdma)
> +		dev =3D port->dev;
> +		if (!dev)
> +			continue;
> +
> +		if (dev->qdma !=3D qdma)
>  			continue;
> =20
> -		dev =3D port->dev;
>  		for (j =3D 0; j < dev->dev->num_tx_queues; j++) {
>  			if (airoha_qdma_get_txq(qdma, j) !=3D qid)
>  				continue;
> @@ -1562,9 +1566,10 @@ static void airoha_qdma_stop_napi(struct airoha_qd=
ma *qdma)
>  	}
>  }
> =20
> -static void airoha_update_hw_stats(struct airoha_gdm_port *port)
> +static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
>  {
> -	struct airoha_eth *eth =3D port->qdma->eth;
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
>  	u32 val, i =3D 0;
> =20
>  	spin_lock(&port->stats.lock);
> @@ -1711,11 +1716,11 @@ static int airoha_dev_open(struct net_device *net=
dev)
>  	int err, len =3D ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
> -	struct airoha_qdma *qdma =3D port->qdma;
> +	struct airoha_qdma *qdma =3D dev->qdma;
>  	u32 pse_port =3D FE_PSE_PORT_PPE1;
> =20
>  	netif_tx_start_all_queues(netdev);
> -	err =3D airoha_set_vip_for_gdm_port(port, true);
> +	err =3D airoha_set_vip_for_gdm_port(dev, true);
>  	if (err)
>  		return err;
> =20
> @@ -1751,11 +1756,11 @@ static int airoha_dev_stop(struct net_device *net=
dev)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
> -	struct airoha_qdma *qdma =3D port->qdma;
> +	struct airoha_qdma *qdma =3D dev->qdma;
>  	int i;
> =20
>  	netif_tx_disable(netdev);
> -	airoha_set_vip_for_gdm_port(port, false);
> +	airoha_set_vip_for_gdm_port(dev, false);
>  	for (i =3D 0; i < netdev->num_tx_queues; i++)
>  		netdev_tx_reset_subqueue(netdev, i);
> =20
> @@ -1781,21 +1786,21 @@ static int airoha_dev_stop(struct net_device *net=
dev)
>  static int airoha_dev_set_macaddr(struct net_device *netdev, void *p)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
>  	int err;
> =20
>  	err =3D eth_mac_addr(netdev, p);
>  	if (err)
>  		return err;
> =20
> -	airoha_set_macaddr(port, netdev->dev_addr);
> +	airoha_set_macaddr(dev, netdev->dev_addr);
> =20
>  	return 0;
>  }
> =20
> -static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
> +static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
>  {
> -	struct airoha_eth *eth =3D port->qdma->eth;
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
>  	u32 val, pse_port, chan;
>  	int i, src_port;
> =20
> @@ -1840,7 +1845,7 @@ static int airoha_set_gdm2_loopback(struct airoha_g=
dm_port *port)
>  		      __field_prep(SP_CPORT_MASK(val), FE_PSE_PORT_CDM2));
> =20
>  	for (i =3D 0; i < eth->soc->num_ppe; i++)
> -		airoha_ppe_set_cpu_port(port, i, AIROHA_GDM2_IDX);
> +		airoha_ppe_set_cpu_port(dev, i, AIROHA_GDM2_IDX);
> =20
>  	if (port->id =3D=3D AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
>  		u32 mask =3D FC_ID_OF_SRC_PORT_MASK(port->nbq);
> @@ -1860,9 +1865,9 @@ static int airoha_dev_init(struct net_device *netde=
v)
>  	int i;
> =20
>  	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
> -	port->qdma =3D &eth->qdma[!airoha_is_lan_gdm_port(port)];
> -	dev->dev->irq =3D port->qdma->irq_banks[0].irq;
> -	airoha_set_macaddr(port, netdev->dev_addr);
> +	dev->qdma =3D &eth->qdma[!airoha_is_lan_gdm_port(port)];
> +	dev->dev->irq =3D dev->qdma->irq_banks[0].irq;
> +	airoha_set_macaddr(dev, netdev->dev_addr);
> =20
>  	switch (port->id) {
>  	case AIROHA_GDM3_IDX:
> @@ -1871,7 +1876,7 @@ static int airoha_dev_init(struct net_device *netde=
v)
>  		if (!eth->ports[1]) {
>  			int err;
> =20
> -			err =3D airoha_set_gdm2_loopback(port);
> +			err =3D airoha_set_gdm2_loopback(dev);
>  			if (err)
>  				return err;
>  		}
> @@ -1881,8 +1886,7 @@ static int airoha_dev_init(struct net_device *netde=
v)
>  	}
> =20
>  	for (i =3D 0; i < eth->soc->num_ppe; i++)
> -		airoha_ppe_set_cpu_port(port, i,
> -					airoha_get_fe_port(port));
> +		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
> =20
>  	return 0;
>  }
> @@ -1894,7 +1898,7 @@ static void airoha_dev_get_stats64(struct net_devic=
e *netdev,
>  	struct airoha_gdm_port *port =3D dev->port;
>  	unsigned int start;
> =20
> -	airoha_update_hw_stats(port);
> +	airoha_update_hw_stats(dev);
>  	do {
>  		start =3D u64_stats_fetch_begin(&port->stats.syncp);
>  		storage->rx_packets =3D port->stats.rx_ok_pkts;
> @@ -1914,8 +1918,8 @@ static int airoha_dev_change_mtu(struct net_device =
*netdev, int mtu)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
> -	struct airoha_eth *eth =3D port->qdma->eth;
>  	u32 len =3D ETH_HLEN + mtu + ETH_FCS_LEN;
> +	struct airoha_eth *eth =3D dev->eth;
> =20
>  	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
>  		      GDM_LONG_LEN_MASK,
> @@ -1989,10 +1993,10 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb=
, struct net_device *dev)
>  #endif
>  }
> =20
> -int airoha_get_fe_port(struct airoha_gdm_port *port)
> +int airoha_get_fe_port(struct airoha_gdm_dev *dev)
>  {
> -	struct airoha_qdma *qdma =3D port->qdma;
> -	struct airoha_eth *eth =3D qdma->eth;
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
> =20
>  	switch (eth->soc->version) {
>  	case 0x7583:
> @@ -2009,8 +2013,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  				   struct net_device *netdev)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> -	struct airoha_qdma *qdma =3D port->qdma;
> +	struct airoha_qdma *qdma =3D dev->qdma;
>  	u32 nr_frags, tag, msg0, msg1, len;
>  	struct airoha_queue_entry *e;
>  	struct netdev_queue *txq;
> @@ -2048,7 +2051,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  		}
>  	}
> =20
> -	fport =3D airoha_get_fe_port(port);
> +	fport =3D airoha_get_fe_port(dev);
>  	msg1 =3D FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
>  	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
> =20
> @@ -2151,8 +2154,7 @@ static void airoha_ethtool_get_drvinfo(struct net_d=
evice *netdev,
>  				       struct ethtool_drvinfo *info)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> -	struct airoha_eth *eth =3D port->qdma->eth;
> +	struct airoha_eth *eth =3D dev->eth;
> =20
>  	strscpy(info->driver, eth->dev->driver->name, sizeof(info->driver));
>  	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
> @@ -2165,7 +2167,7 @@ static void airoha_ethtool_get_mac_stats(struct net=
_device *netdev,
>  	struct airoha_gdm_port *port =3D dev->port;
>  	unsigned int start;
> =20
> -	airoha_update_hw_stats(port);
> +	airoha_update_hw_stats(dev);
>  	do {
>  		start =3D u64_stats_fetch_begin(&port->stats.syncp);
>  		stats->FramesTransmittedOK =3D port->stats.tx_ok_pkts;
> @@ -2205,7 +2207,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *ne=
tdev,
>  		     ARRAY_SIZE(hw_stats->rx_len) + 1);
> =20
>  	*ranges =3D airoha_ethtool_rmon_ranges;
> -	airoha_update_hw_stats(port);
> +	airoha_update_hw_stats(dev);
>  	do {
>  		int i;
> =20
> @@ -2225,18 +2227,17 @@ static int airoha_qdma_set_chan_tx_sched(struct n=
et_device *netdev,
>  					 const u16 *weights, u8 n_weights)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
>  	int i;
> =20
>  	for (i =3D 0; i < AIROHA_NUM_TX_RING; i++)
> -		airoha_qdma_clear(port->qdma, REG_QUEUE_CLOSE_CFG(channel),
> +		airoha_qdma_clear(dev->qdma, REG_QUEUE_CLOSE_CFG(channel),
>  				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));
> =20
>  	for (i =3D 0; i < n_weights; i++) {
>  		u32 status;
>  		int err;
> =20
> -		airoha_qdma_wr(port->qdma, REG_TXWRR_WEIGHT_CFG,
> +		airoha_qdma_wr(dev->qdma, REG_TXWRR_WEIGHT_CFG,
>  			       TWRR_RW_CMD_MASK |
>  			       FIELD_PREP(TWRR_CHAN_IDX_MASK, channel) |
>  			       FIELD_PREP(TWRR_QUEUE_IDX_MASK, i) |
> @@ -2244,13 +2245,12 @@ static int airoha_qdma_set_chan_tx_sched(struct n=
et_device *netdev,
>  		err =3D read_poll_timeout(airoha_qdma_rr, status,
>  					status & TWRR_RW_CMD_DONE,
>  					USEC_PER_MSEC, 10 * USEC_PER_MSEC,
> -					true, port->qdma,
> -					REG_TXWRR_WEIGHT_CFG);
> +					true, dev->qdma, REG_TXWRR_WEIGHT_CFG);
>  		if (err)
>  			return err;
>  	}
> =20
> -	airoha_qdma_rmw(port->qdma, REG_CHAN_QOS_MODE(channel >> 3),
> +	airoha_qdma_rmw(dev->qdma, REG_CHAN_QOS_MODE(channel >> 3),
>  			CHAN_QOS_MODE_MASK(channel),
>  			__field_prep(CHAN_QOS_MODE_MASK(channel), mode));
> =20
> @@ -2316,9 +2316,9 @@ static int airoha_qdma_get_tx_ets_stats(struct net_=
device *netdev, int channel,
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
> =20
> -	u64 cpu_tx_packets =3D airoha_qdma_rr(port->qdma,
> +	u64 cpu_tx_packets =3D airoha_qdma_rr(dev->qdma,
>  					    REG_CNTR_VAL(channel << 1));
> -	u64 fwd_tx_packets =3D airoha_qdma_rr(port->qdma,
> +	u64 fwd_tx_packets =3D airoha_qdma_rr(dev->qdma,
>  					    REG_CNTR_VAL((channel << 1) + 1));
>  	u64 tx_packets =3D (cpu_tx_packets - port->cpu_tx_packets) +
>  			 (fwd_tx_packets - port->fwd_tx_packets);
> @@ -2582,17 +2582,16 @@ static int airoha_qdma_set_tx_rate_limit(struct n=
et_device *netdev,
>  					 u32 bucket_size)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
>  	int i, err;
> =20
>  	for (i =3D 0; i <=3D TRTCM_PEAK_MODE; i++) {
> -		err =3D airoha_qdma_set_trtcm_config(port->qdma, channel,
> +		err =3D airoha_qdma_set_trtcm_config(dev->qdma, channel,
>  						   REG_EGRESS_TRTCM_CFG, i,
>  						   !!rate, TRTCM_METER_MODE);
>  		if (err)
>  			return err;
> =20
> -		err =3D airoha_qdma_set_trtcm_token_bucket(port->qdma, channel,
> +		err =3D airoha_qdma_set_trtcm_token_bucket(dev->qdma, channel,
>  							 REG_EGRESS_TRTCM_CFG,
>  							 i, rate, bucket_size);
>  		if (err)
> @@ -2642,11 +2641,11 @@ static int airoha_tc_htb_alloc_leaf_queue(struct =
net_device *netdev,
>  	return 0;
>  }
> =20
> -static int airoha_qdma_set_rx_meter(struct airoha_gdm_port *port,
> +static int airoha_qdma_set_rx_meter(struct airoha_gdm_dev *dev,
>  				    u32 rate, u32 bucket_size,
>  				    enum trtcm_unit_type unit_type)
>  {
> -	struct airoha_qdma *qdma =3D port->qdma;
> +	struct airoha_qdma *qdma =3D dev->qdma;
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
> @@ -2725,7 +2724,6 @@ static int airoha_dev_tc_matchall(struct net_device=
 *netdev,
>  {
>  	enum trtcm_unit_type unit_type =3D TRTCM_BYTE_UNIT;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
>  	u32 rate =3D 0, bucket_size =3D 0;
> =20
>  	switch (f->command) {
> @@ -2750,7 +2748,7 @@ static int airoha_dev_tc_matchall(struct net_device=
 *netdev,
>  		fallthrough;
>  	}
>  	case TC_CLSMATCHALL_DESTROY:
> -		return airoha_qdma_set_rx_meter(port, rate, bucket_size,
> +		return airoha_qdma_set_rx_meter(dev, rate, bucket_size,
>  						unit_type);
>  	default:
>  		return -EOPNOTSUPP;
> @@ -2762,8 +2760,7 @@ static int airoha_dev_setup_tc_block_cb(enum tc_set=
up_type type,
>  {
>  	struct net_device *netdev =3D cb_priv;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> -	struct airoha_eth *eth =3D port->qdma->eth;
> +	struct airoha_eth *eth =3D dev->eth;
> =20
>  	if (!tc_can_offload(netdev))
>  		return -EOPNOTSUPP;
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index c78cabbec753..f1eea492217c 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -537,12 +537,12 @@ struct airoha_qdma {
> =20
>  struct airoha_gdm_dev {
>  	struct airoha_gdm_port *port;
> +	struct airoha_qdma *qdma;
>  	struct net_device *dev;
>  	struct airoha_eth *eth;
>  };
> =20
>  struct airoha_gdm_port {
> -	struct airoha_qdma *qdma;
>  	struct airoha_gdm_dev *dev;
>  	int id;
>  	int nbq;
> @@ -666,19 +666,18 @@ static inline bool airoha_is_7583(struct airoha_eth=
 *eth)
>  	return eth->soc->version =3D=3D 0x7583;
>  }
> =20
> -int airoha_get_fe_port(struct airoha_gdm_port *port);
> +int airoha_get_fe_port(struct airoha_gdm_dev *dev);
>  bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>  			     struct airoha_gdm_dev *dev);
> =20
> -void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id,
> -			     u8 fport);
> +void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port);
>  bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
>  void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *sk=
b,
>  			  u16 hash, bool rx_wlan);
>  int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_=
data);
>  int airoha_ppe_init(struct airoha_eth *eth);
>  void airoha_ppe_deinit(struct airoha_eth *eth);
> -void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port);
> +void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev);
>  u32 airoha_ppe_get_total_num_entries(struct airoha_ppe *ppe);
>  struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
>  						  u32 hash);
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index af7af4097b98..22f5f1bae730 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -84,9 +84,9 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe *=
ppe)
>  			     AIROHA_FOE_IB1_BIND_TIMESTAMP);
>  }
> =20
> -void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id, u8=
 fport)
> +void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port)
>  {
> -	struct airoha_qdma *qdma =3D port->qdma;
> +	struct airoha_qdma *qdma =3D dev->qdma;
>  	struct airoha_eth *eth =3D qdma->eth;
>  	u8 qdma_id =3D qdma - &eth->qdma[0];
>  	u32 fe_cpu_port;
> @@ -180,8 +180,8 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
>  			if (!port)
>  				continue;
> =20
> -			airoha_ppe_set_cpu_port(port, i,
> -						airoha_get_fe_port(port));
> +			airoha_ppe_set_cpu_port(port->dev, i,
> +						airoha_get_fe_port(port->dev));
>  		}
>  	}
>  }
> @@ -1473,11 +1473,12 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *=
dev, struct sk_buff *skb,
>  	airoha_ppe_foe_insert_entry(ppe, skb, hash, rx_wlan);
>  }
> =20
> -void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port)
> +void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev)
>  {
> -	struct airoha_eth *eth =3D port->qdma->eth;
> -	struct net_device *dev =3D port->dev->dev;
> -	const u8 *addr =3D dev->dev_addr;
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct net_device *netdev =3D dev->dev;
> +	struct airoha_eth *eth =3D dev->eth;
> +	const u8 *addr =3D netdev->dev_addr;
>  	u32 val;
> =20
>  	val =3D (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];
>=20
> --=20
> 2.54.0
>=20

Commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260511-airoha-eth-multi-serdes-v6-0-c89946=
2c4f75%40kernel.org
- This isn't a regression introduced by this patch, but is it safe to use
  spin_lock() here instead of spin_lock_bh()?
  - According to my understanding ndo_get_stats64 callback can't run softirq
    context.

--NE+4h+Wyx7O1ITBi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagQ6IgAKCRA6cBh0uS2t
rEkcAQC2ig9Q3isG9GROZcAedOuCxFa7PNLkJr6FgQU71+9XKgD+KENnRdmunSv/
sv4qVObbRaSCGbg1D1CLGPFCsU2UeAs=
=eF2v
-----END PGP SIGNATURE-----

--NE+4h+Wyx7O1ITBi--

