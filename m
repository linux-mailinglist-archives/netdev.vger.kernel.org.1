Return-Path: <netdev+bounces-287302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPxqLLCUA2rY7gEAu9opvQ
	(envelope-from <netdev+bounces-287302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:59:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F2529C1D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1B3830616A7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B4D3C661C;
	Tue, 12 May 2026 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXtCMc3b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969F3C4555;
	Tue, 12 May 2026 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619352; cv=none; b=CqAqZEG473m6dPwU68I7DoF5pk2bpvw/Wh9iElqgnzpPMCVhSYgAR1lR6yv3N6kSP0sGHejnZebpPojSFB691sy4Jntx17d3luoT2htnLrXr2somv++YD08GHsSHLGxl7UTGUrEBY1H2oncFh9PaatURN00Trh2TCtV/xrFIqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619352; c=relaxed/simple;
	bh=JeWhiiHfV2rMJDtGhe3E5Ja/4O9soxtRPqyBGa0nO7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTIxZ6BVfML5AXkTyyB7jrhSoZc+Db87Vp/d2CM1lFqNqPmhKCAIz7UtkZuO4COLisPk2NpDy9UKmvrvjFegWwLMGdfJ7WOTBirCCLtRtmBAZVT6s7rgpC31AGdk3jj1zGadcySV8YZ2yxAN08CwWQ69sS83cwzCgnpABw+H0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXtCMc3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F04C2BCF5;
	Tue, 12 May 2026 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778619351;
	bh=JeWhiiHfV2rMJDtGhe3E5Ja/4O9soxtRPqyBGa0nO7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXtCMc3bMU182gPII4u7C0fWSS7rxsRF5S4kBGWNsDSE5xwe8N8h1rNRa+mGKmkvL
	 E5CRQnkpF0NtuEIyc/lqRxx4VErpO93vQGqJoQT31FqReyBjiuR0UqwPBdengD/6am
	 CDaauHE1sh9DiE3KLDlmqUVgkF7BKT78RbJAbwu77SlTO+TtfeijO4ZVX9MHjZzkLM
	 7mK0Im0HucC/j44I/4fYe+tOWLH3Jdg35282hkl83rE7L3vHtw89BL6OPK20BpwG+w
	 Ytnq7BD/SwaCNvaLU7tlHyqYKlkp0tcGciX6JVLhOaT7LN/Z1x4//H5uhdvYLKSHF4
	 HxFrPTUN+dOoQ==
Date: Tue, 12 May 2026 22:55:48 +0200
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
Subject: Re: [PATCH net-next v6 03/12] net: airoha: Introduce airoha_gdm_dev
 struct
Message-ID: <agOT1Pn1Ficrsi2m@lore-desk>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
 <20260511-airoha-eth-multi-serdes-v6-3-c899462c4f75@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="StL0DR0VC4TpI5/J"
Content-Disposition: inline
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-3-c899462c4f75@kernel.org>
X-Rspamd-Queue-Id: 053F2529C1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287302-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--StL0DR0VC4TpI5/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 11, Lorenzo Bianconi wrote:
> EN7581 and AN7583 SoCs support connecting multiple external SerDes to GDM3
> or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
> As a result multiple net_devices can connect to the same GDM{3,4} port
> and there is a theoretical "1:n" relation between GDM port and
> net_devices.
> Introduce airoha_gdm_dev struct to collect net_device related info (e.g.
> net_device and external phy pointer). Please note this is just a
> preliminary patch and we are still supporting a single net_device for
> each GDM port. Subsequent patches will add support for multiple net_devic=
es
> connected to the same GDM port.
>=20
> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 309 ++++++++++++++++++-------=
------
>  drivers/net/ethernet/airoha/airoha_eth.h |  13 +-
>  drivers/net/ethernet/airoha/airoha_ppe.c |  17 +-
>  3 files changed, 203 insertions(+), 136 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 3fe2561c85f1..18a89de4d58a 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -600,6 +600,7 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  		struct airoha_qdma_desc *desc =3D &q->desc[q->tail];
>  		u32 hash, reason, msg1, desc_ctrl;
>  		struct airoha_gdm_port *port;
> +		struct net_device *netdev;
>  		int data_len, len, p;
>  		struct page *page;
> =20
> @@ -628,6 +629,7 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  			goto free_frag;
> =20
>  		port =3D eth->ports[p];
> +		netdev =3D port->dev->dev;
>  		if (!q->skb) { /* first buffer */
>  			q->skb =3D napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
>  						q->buf_size);
> @@ -637,8 +639,8 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  			skb_reserve(q->skb, AIROHA_RX_HEADROOM);
>  			__skb_put(q->skb, len);
>  			skb_mark_for_recycle(q->skb);
> -			q->skb->dev =3D port->dev;
> -			q->skb->protocol =3D eth_type_trans(q->skb, port->dev);
> +			q->skb->dev =3D netdev;
> +			q->skb->protocol =3D eth_type_trans(q->skb, netdev);
>  			q->skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>  			skb_record_rx_queue(q->skb, qid);
>  		} else { /* scattered frame */
> @@ -656,7 +658,7 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  		if (FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl))
>  			continue;
> =20
> -		if (netdev_uses_dsa(port->dev)) {
> +		if (netdev_uses_dsa(netdev)) {
>  			/* PPE module requires untagged packets to work
>  			 * properly and it provides DSA port index via the
>  			 * DMA descriptor. Report DSA tag to the DSA stack
> @@ -850,6 +852,7 @@ static void airoha_qdma_wake_netdev_txqs(struct airoh=
a_queue *q)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> +		struct airoha_gdm_dev *dev;
>  		int j;
> =20
>  		if (!port)
> @@ -858,11 +861,12 @@ static void airoha_qdma_wake_netdev_txqs(struct air=
oha_queue *q)
>  		if (port->qdma !=3D qdma)
>  			continue;
> =20
> -		for (j =3D 0; j < port->dev->num_tx_queues; j++) {
> +		dev =3D port->dev;
> +		for (j =3D 0; j < dev->dev->num_tx_queues; j++) {
>  			if (airoha_qdma_get_txq(qdma, j) !=3D qid)
>  				continue;
> =20
> -			netif_wake_subqueue(port->dev, j);
> +			netif_wake_subqueue(dev->dev, j);
>  		}
>  	}
>  	q->txq_stopped =3D false;
> @@ -1702,19 +1706,20 @@ static void airoha_update_hw_stats(struct airoha_=
gdm_port *port)
>  	spin_unlock(&port->stats.lock);
>  }
> =20
> -static int airoha_dev_open(struct net_device *dev)
> +static int airoha_dev_open(struct net_device *netdev)
>  {
> -	int err, len =3D ETH_HLEN + dev->mtu + ETH_FCS_LEN;
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	int err, len =3D ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_qdma *qdma =3D port->qdma;
>  	u32 pse_port =3D FE_PSE_PORT_PPE1;
> =20
> -	netif_tx_start_all_queues(dev);
> +	netif_tx_start_all_queues(netdev);
>  	err =3D airoha_set_vip_for_gdm_port(port, true);
>  	if (err)
>  		return err;
> =20
> -	if (netdev_uses_dsa(dev))
> +	if (netdev_uses_dsa(netdev))
>  		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
>  			      GDM_STAG_EN_MASK);
>  	else
> @@ -1742,16 +1747,17 @@ static int airoha_dev_open(struct net_device *dev)
>  	return 0;
>  }
> =20
> -static int airoha_dev_stop(struct net_device *dev)
> +static int airoha_dev_stop(struct net_device *netdev)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_qdma *qdma =3D port->qdma;
>  	int i;
> =20
> -	netif_tx_disable(dev);
> +	netif_tx_disable(netdev);
>  	airoha_set_vip_for_gdm_port(port, false);
> -	for (i =3D 0; i < dev->num_tx_queues; i++)
> -		netdev_tx_reset_subqueue(dev, i);
> +	for (i =3D 0; i < netdev->num_tx_queues; i++)
> +		netdev_tx_reset_subqueue(netdev, i);
> =20
>  	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
>  				    FE_PSE_PORT_DROP);
> @@ -1772,16 +1778,17 @@ static int airoha_dev_stop(struct net_device *dev)
>  	return 0;
>  }
> =20
> -static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
> +static int airoha_dev_set_macaddr(struct net_device *netdev, void *p)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	int err;
> =20
> -	err =3D eth_mac_addr(dev, p);
> +	err =3D eth_mac_addr(netdev, p);
>  	if (err)
>  		return err;
> =20
> -	airoha_set_macaddr(port, dev->dev_addr);
> +	airoha_set_macaddr(port, netdev->dev_addr);
> =20
>  	return 0;
>  }
> @@ -1845,16 +1852,17 @@ static int airoha_set_gdm2_loopback(struct airoha=
_gdm_port *port)
>  	return 0;
>  }
> =20
> -static int airoha_dev_init(struct net_device *dev)
> +static int airoha_dev_init(struct net_device *netdev)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> -	struct airoha_eth *eth =3D port->eth;
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
>  	int i;
> =20
>  	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
>  	port->qdma =3D &eth->qdma[!airoha_is_lan_gdm_port(port)];
> -	port->dev->irq =3D port->qdma->irq_banks[0].irq;
> -	airoha_set_macaddr(port, dev->dev_addr);
> +	dev->dev->irq =3D port->qdma->irq_banks[0].irq;
> +	airoha_set_macaddr(port, netdev->dev_addr);
> =20
>  	switch (port->id) {
>  	case AIROHA_GDM3_IDX:
> @@ -1879,10 +1887,11 @@ static int airoha_dev_init(struct net_device *dev)
>  	return 0;
>  }
> =20
> -static void airoha_dev_get_stats64(struct net_device *dev,
> +static void airoha_dev_get_stats64(struct net_device *netdev,
>  				   struct rtnl_link_stats64 *storage)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	unsigned int start;
> =20
>  	airoha_update_hw_stats(port);
> @@ -1901,36 +1910,39 @@ static void airoha_dev_get_stats64(struct net_dev=
ice *dev,
>  	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
>  }
> =20
> -static int airoha_dev_change_mtu(struct net_device *dev, int mtu)
> +static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_eth *eth =3D port->qdma->eth;
>  	u32 len =3D ETH_HLEN + mtu + ETH_FCS_LEN;
> =20
>  	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
>  		      GDM_LONG_LEN_MASK,
>  		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> -	WRITE_ONCE(dev->mtu, mtu);
> +	WRITE_ONCE(netdev->mtu, mtu);
> =20
>  	return 0;
>  }
> =20
> -static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buf=
f *skb,
> +static u16 airoha_dev_select_queue(struct net_device *netdev,
> +				   struct sk_buff *skb,
>  				   struct net_device *sb_dev)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	int queue, channel;
> =20
>  	/* For dsa device select QoS channel according to the dsa user port
>  	 * index, rely on port id otherwise. Select QoS queue based on the
>  	 * skb priority.
>  	 */
> -	channel =3D netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port->i=
d;
> +	channel =3D netdev_uses_dsa(netdev) ? skb_get_queue_mapping(skb) : port=
->id;
>  	channel =3D channel % AIROHA_NUM_QOS_CHANNELS;
>  	queue =3D (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
>  	queue =3D channel * AIROHA_NUM_QOS_QUEUES + queue;
> =20
> -	return queue < dev->num_tx_queues ? queue : 0;
> +	return queue < netdev->num_tx_queues ? queue : 0;
>  }
> =20
>  static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *de=
v)
> @@ -1994,9 +2006,10 @@ int airoha_get_fe_port(struct airoha_gdm_port *por=
t)
>  }
> =20
>  static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
> -				   struct net_device *dev)
> +				   struct net_device *netdev)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_qdma *qdma =3D port->qdma;
>  	u32 nr_frags, tag, msg0, msg1, len;
>  	struct airoha_queue_entry *e;
> @@ -2009,7 +2022,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  	u8 fport;
> =20
>  	qid =3D airoha_qdma_get_txq(qdma, skb_get_queue_mapping(skb));
> -	tag =3D airoha_get_dsa_tag(skb, dev);
> +	tag =3D airoha_get_dsa_tag(skb, netdev);
> =20
>  	msg0 =3D FIELD_PREP(QDMA_ETH_TXMSG_CHAN_MASK,
>  			  qid / AIROHA_NUM_QOS_QUEUES) |
> @@ -2045,7 +2058,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
> =20
>  	spin_lock_bh(&q->lock);
> =20
> -	txq =3D skb_get_tx_queue(dev, skb);
> +	txq =3D skb_get_tx_queue(netdev, skb);
>  	nr_frags =3D 1 + skb_shinfo(skb)->nr_frags;
> =20
>  	if (q->queued + nr_frags >=3D q->ndesc) {
> @@ -2069,9 +2082,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  		dma_addr_t addr;
>  		u32 val;
> =20
> -		addr =3D dma_map_single(dev->dev.parent, data, len,
> +		addr =3D dma_map_single(netdev->dev.parent, data, len,
>  				      DMA_TO_DEVICE);
> -		if (unlikely(dma_mapping_error(dev->dev.parent, addr)))
> +		if (unlikely(dma_mapping_error(netdev->dev.parent, addr)))
>  			goto error_unmap;
> =20
>  		list_move_tail(&e->list, &tx_list);
> @@ -2120,7 +2133,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
> =20
>  error_unmap:
>  	list_for_each_entry(e, &tx_list, list) {
> -		dma_unmap_single(dev->dev.parent, e->dma_addr, e->dma_len,
> +		dma_unmap_single(netdev->dev.parent, e->dma_addr, e->dma_len,
>  				 DMA_TO_DEVICE);
>  		e->dma_addr =3D 0;
>  	}
> @@ -2129,25 +2142,27 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff=
 *skb,
>  	spin_unlock_bh(&q->lock);
>  error:
>  	dev_kfree_skb_any(skb);
> -	dev->stats.tx_dropped++;
> +	netdev->stats.tx_dropped++;
> =20
>  	return NETDEV_TX_OK;
>  }
> =20
> -static void airoha_ethtool_get_drvinfo(struct net_device *dev,
> +static void airoha_ethtool_get_drvinfo(struct net_device *netdev,
>  				       struct ethtool_drvinfo *info)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_eth *eth =3D port->qdma->eth;
> =20
>  	strscpy(info->driver, eth->dev->driver->name, sizeof(info->driver));
>  	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
>  }
> =20
> -static void airoha_ethtool_get_mac_stats(struct net_device *dev,
> +static void airoha_ethtool_get_mac_stats(struct net_device *netdev,
>  					 struct ethtool_eth_mac_stats *stats)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	unsigned int start;
> =20
>  	airoha_update_hw_stats(port);
> @@ -2175,11 +2190,12 @@ static const struct ethtool_rmon_hist_range airoh=
a_ethtool_rmon_ranges[] =3D {
>  };
> =20
>  static void
> -airoha_ethtool_get_rmon_stats(struct net_device *dev,
> +airoha_ethtool_get_rmon_stats(struct net_device *netdev,
>  			      struct ethtool_rmon_stats *stats,
>  			      const struct ethtool_rmon_hist_range **ranges)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_hw_stats *hw_stats =3D &port->stats;
>  	unsigned int start;
> =20
> @@ -2204,11 +2220,12 @@ airoha_ethtool_get_rmon_stats(struct net_device *=
dev,
>  	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
>  }
> =20
> -static int airoha_qdma_set_chan_tx_sched(struct net_device *dev,
> +static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
>  					 int channel, enum tx_sched_mode mode,
>  					 const u16 *weights, u8 n_weights)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	int i;
> =20
>  	for (i =3D 0; i < AIROHA_NUM_TX_RING; i++)
> @@ -2293,10 +2310,12 @@ static int airoha_qdma_set_tx_ets_sched(struct ne=
t_device *dev, int channel,
>  					     ARRAY_SIZE(w));
>  }
> =20
> -static int airoha_qdma_get_tx_ets_stats(struct net_device *dev, int chan=
nel,
> +static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int c=
hannel,
>  					struct tc_ets_qopt_offload *opt)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> +
>  	u64 cpu_tx_packets =3D airoha_qdma_rr(port->qdma,
>  					    REG_CNTR_VAL(channel << 1));
>  	u64 fwd_tx_packets =3D airoha_qdma_rr(port->qdma,
> @@ -2558,11 +2577,12 @@ static int airoha_qdma_set_trtcm_token_bucket(str=
uct airoha_qdma *qdma,
>  					   mode, val);
>  }
> =20
> -static int airoha_qdma_set_tx_rate_limit(struct net_device *dev,
> +static int airoha_qdma_set_tx_rate_limit(struct net_device *netdev,
>  					 int channel, u32 rate,
>  					 u32 bucket_size)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	int i, err;
> =20
>  	for (i =3D 0; i <=3D TRTCM_PEAK_MODE; i++) {
> @@ -2582,20 +2602,22 @@ static int airoha_qdma_set_tx_rate_limit(struct n=
et_device *dev,
>  	return 0;
>  }
> =20
> -static int airoha_tc_htb_alloc_leaf_queue(struct net_device *dev,
> +static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
>  					  struct tc_htb_qopt_offload *opt)
>  {
>  	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>  	u32 rate =3D div_u64(opt->rate, 1000) << 3; /* kbps */
> -	int err, num_tx_queues =3D dev->real_num_tx_queues;
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	int err, num_tx_queues =3D netdev->real_num_tx_queues;
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> =20
>  	if (opt->parent_classid !=3D TC_HTB_CLASSID_ROOT) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
>  		return -EINVAL;
>  	}
> =20
> -	err =3D airoha_qdma_set_tx_rate_limit(dev, channel, rate, opt->quantum);
> +	err =3D airoha_qdma_set_tx_rate_limit(netdev, channel, rate,
> +					    opt->quantum);
>  	if (err) {
>  		NL_SET_ERR_MSG_MOD(opt->extack,
>  				   "failed configuring htb offload");
> @@ -2605,9 +2627,10 @@ static int airoha_tc_htb_alloc_leaf_queue(struct n=
et_device *dev,
>  	if (opt->command =3D=3D TC_HTB_NODE_MODIFY)
>  		return 0;
> =20
> -	err =3D netif_set_real_num_tx_queues(dev, num_tx_queues + 1);
> +	err =3D netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
>  	if (err) {
> -		airoha_qdma_set_tx_rate_limit(dev, channel, 0, opt->quantum);
> +		airoha_qdma_set_tx_rate_limit(netdev, channel, 0,
> +					      opt->quantum);
>  		NL_SET_ERR_MSG_MOD(opt->extack,
>  				   "failed setting real_num_tx_queues");
>  		return err;
> @@ -2697,11 +2720,12 @@ static int airoha_tc_matchall_act_validate(struct=
 tc_cls_matchall_offload *f)
>  	return 0;
>  }
> =20
> -static int airoha_dev_tc_matchall(struct net_device *dev,
> +static int airoha_dev_tc_matchall(struct net_device *netdev,
>  				  struct tc_cls_matchall_offload *f)
>  {
>  	enum trtcm_unit_type unit_type =3D TRTCM_BYTE_UNIT;
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	u32 rate =3D 0, bucket_size =3D 0;
> =20
>  	switch (f->command) {
> @@ -2736,18 +2760,19 @@ static int airoha_dev_tc_matchall(struct net_devi=
ce *dev,
>  static int airoha_dev_setup_tc_block_cb(enum tc_setup_type type,
>  					void *type_data, void *cb_priv)
>  {
> -	struct net_device *dev =3D cb_priv;
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct net_device *netdev =3D cb_priv;
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_eth *eth =3D port->qdma->eth;
> =20
> -	if (!tc_can_offload(dev))
> +	if (!tc_can_offload(netdev))
>  		return -EOPNOTSUPP;
> =20
>  	switch (type) {
>  	case TC_SETUP_CLSFLOWER:
>  		return airoha_ppe_setup_tc_block_cb(&eth->ppe->dev, type_data);
>  	case TC_SETUP_CLSMATCHALL:
> -		return airoha_dev_tc_matchall(dev, type_data);
> +		return airoha_dev_tc_matchall(netdev, type_data);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -2794,47 +2819,51 @@ static int airoha_dev_setup_tc_block(struct net_d=
evice *dev,
>  	}
>  }
> =20
> -static void airoha_tc_remove_htb_queue(struct net_device *dev, int queue)
> +static void airoha_tc_remove_htb_queue(struct net_device *netdev, int qu=
eue)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> =20
> -	netif_set_real_num_tx_queues(dev, dev->real_num_tx_queues - 1);
> -	airoha_qdma_set_tx_rate_limit(dev, queue + 1, 0, 0);
> +	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
> +	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
>  	clear_bit(queue, port->qos_sq_bmap);
>  }
> =20
> -static int airoha_tc_htb_delete_leaf_queue(struct net_device *dev,
> +static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
>  					   struct tc_htb_qopt_offload *opt)
>  {
>  	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> =20
>  	if (!test_bit(channel, port->qos_sq_bmap)) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
>  		return -EINVAL;
>  	}
> =20
> -	airoha_tc_remove_htb_queue(dev, channel);
> +	airoha_tc_remove_htb_queue(netdev, channel);
> =20
>  	return 0;
>  }
> =20
> -static int airoha_tc_htb_destroy(struct net_device *dev)
> +static int airoha_tc_htb_destroy(struct net_device *netdev)
>  {
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
>  	int q;
> =20
>  	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
> -		airoha_tc_remove_htb_queue(dev, q);
> +		airoha_tc_remove_htb_queue(netdev, q);
> =20
>  	return 0;
>  }
> =20
> -static int airoha_tc_get_htb_get_leaf_queue(struct net_device *dev,
> +static int airoha_tc_get_htb_get_leaf_queue(struct net_device *netdev,
>  					    struct tc_htb_qopt_offload *opt)
>  {
>  	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
> -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> =20
>  	if (!test_bit(channel, port->qos_sq_bmap)) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
> @@ -2870,8 +2899,8 @@ static int airoha_tc_setup_qdisc_htb(struct net_dev=
ice *dev,
>  	return 0;
>  }
> =20
> -static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_typ=
e type,
> -			       void *type_data)
> +static int airoha_dev_tc_setup(struct net_device *dev,
> +			       enum tc_setup_type type, void *type_data)
>  {
>  	switch (type) {
>  	case TC_SETUP_QDISC_ETS:
> @@ -2937,25 +2966,81 @@ static void airoha_metadata_dst_free(struct airoh=
a_gdm_port *port)
>  	}
>  }
> =20
> -bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
> -			      struct airoha_gdm_port *port)
> +bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
> +			     struct airoha_gdm_dev *dev)
>  {
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> -		if (eth->ports[i] =3D=3D port)
> +		struct airoha_gdm_port *port =3D eth->ports[i];
> +
> +		if (!port)
> +			continue;
> +
> +		if (port->dev =3D=3D dev)
>  			return true;
>  	}
> =20
>  	return false;
>  }
> =20
> +static int airoha_alloc_gdm_device(struct airoha_eth *eth,
> +				   struct airoha_gdm_port *port,
> +				   struct device_node *np)
> +{
> +	struct airoha_gdm_dev *dev;
> +	struct net_device *netdev;
> +	int err;
> +
> +	netdev =3D devm_alloc_etherdev_mqs(eth->dev, sizeof(*dev),
> +					 AIROHA_NUM_NETDEV_TX_RINGS,
> +					 AIROHA_NUM_RX_RING);
> +	if (!netdev) {
> +		dev_err(eth->dev, "alloc_etherdev failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	netdev->netdev_ops =3D &airoha_netdev_ops;
> +	netdev->ethtool_ops =3D &airoha_ethtool_ops;
> +	netdev->max_mtu =3D AIROHA_MAX_MTU;
> +	netdev->watchdog_timeo =3D 5 * HZ;
> +	netdev->hw_features =3D NETIF_F_IP_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO6=
 |
> +			      NETIF_F_IPV6_CSUM | NETIF_F_SG | NETIF_F_TSO |
> +			      NETIF_F_HW_TC;
> +	netdev->features |=3D netdev->hw_features;
> +	netdev->vlan_features =3D netdev->hw_features;
> +	netdev->dev.of_node =3D np;
> +	SET_NETDEV_DEV(netdev, eth->dev);
> +
> +	/* reserve hw queues for HTB offloading */
> +	err =3D netif_set_real_num_tx_queues(netdev, AIROHA_NUM_TX_RING);
> +	if (err)
> +		return err;
> +
> +	err =3D of_get_ethdev_address(np, netdev);
> +	if (err) {
> +		if (err =3D=3D -EPROBE_DEFER)
> +			return err;
> +
> +		eth_hw_addr_random(netdev);
> +		dev_info(eth->dev, "generated random MAC address %pM\n",
> +			 netdev->dev_addr);
> +	}
> +
> +	dev =3D netdev_priv(netdev);
> +	dev->dev =3D netdev;
> +	dev->port =3D port;
> +	port->dev =3D dev;
> +	dev->eth =3D eth;
> +
> +	return 0;
> +}
> +
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  				 struct device_node *np)
>  {
>  	const __be32 *id_ptr =3D of_get_property(np, "reg", NULL);
>  	struct airoha_gdm_port *port;
> -	struct net_device *dev;
>  	int err, p;
>  	u32 id;
> =20
> @@ -2977,53 +3062,22 @@ static int airoha_alloc_gdm_port(struct airoha_et=
h *eth,
>  		return -EINVAL;
>  	}
> =20
> -	dev =3D devm_alloc_etherdev_mqs(eth->dev, sizeof(*port),
> -				      AIROHA_NUM_NETDEV_TX_RINGS,
> -				      AIROHA_NUM_RX_RING);
> -	if (!dev) {
> -		dev_err(eth->dev, "alloc_etherdev failed\n");
> +	port =3D devm_kzalloc(eth->dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
>  		return -ENOMEM;
> -	}
> -
> -	dev->netdev_ops =3D &airoha_netdev_ops;
> -	dev->ethtool_ops =3D &airoha_ethtool_ops;
> -	dev->max_mtu =3D AIROHA_MAX_MTU;
> -	dev->watchdog_timeo =3D 5 * HZ;
> -	dev->hw_features =3D NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
> -			   NETIF_F_TSO6 | NETIF_F_IPV6_CSUM |
> -			   NETIF_F_SG | NETIF_F_TSO |
> -			   NETIF_F_HW_TC;
> -	dev->features |=3D dev->hw_features;
> -	dev->vlan_features =3D dev->hw_features;
> -	dev->dev.of_node =3D np;
> -	SET_NETDEV_DEV(dev, eth->dev);
> -
> -	/* reserve hw queues for HTB offloading */
> -	err =3D netif_set_real_num_tx_queues(dev, AIROHA_NUM_TX_RING);
> -	if (err)
> -		return err;
> -
> -	err =3D of_get_ethdev_address(np, dev);
> -	if (err) {
> -		if (err =3D=3D -EPROBE_DEFER)
> -			return err;
> -
> -		eth_hw_addr_random(dev);
> -		dev_info(eth->dev, "generated random MAC address %pM\n",
> -			 dev->dev_addr);
> -	}
> =20
> -	port =3D netdev_priv(dev);
>  	u64_stats_init(&port->stats.syncp);
>  	spin_lock_init(&port->stats.lock);
> -	port->eth =3D eth;
> -	port->dev =3D dev;
>  	port->id =3D id;
>  	/* XXX: Read nbq from DTS */
>  	port->nbq =3D id =3D=3D AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
>  	eth->ports[p] =3D port;
> =20
> -	return airoha_metadata_dst_alloc(port);
> +	err =3D airoha_metadata_dst_alloc(port);
> +	if (err)
> +		return err;
> +
> +	return airoha_alloc_gdm_device(eth, port, np);
>  }
> =20
>  static int airoha_register_gdm_devices(struct airoha_eth *eth)
> @@ -3037,7 +3091,7 @@ static int airoha_register_gdm_devices(struct airoh=
a_eth *eth)
>  		if (!port)
>  			continue;
> =20
> -		err =3D register_netdev(port->dev);
> +		err =3D register_netdev(port->dev->dev);
>  		if (err)
>  			return err;
>  	}
> @@ -3146,12 +3200,14 @@ static int airoha_probe(struct platform_device *p=
dev)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> +		struct airoha_gdm_dev *dev;
> =20
>  		if (!port)
>  			continue;
> =20
> -		if (port->dev->reg_state =3D=3D NETREG_REGISTERED)
> -			unregister_netdev(port->dev);
> +		dev =3D port->dev;
> +		if (dev && dev->dev->reg_state =3D=3D NETREG_REGISTERED)
> +			unregister_netdev(dev->dev);
>  		airoha_metadata_dst_free(port);
>  	}
>  	airoha_hw_cleanup(eth);
> @@ -3172,11 +3228,14 @@ static void airoha_remove(struct platform_device =
*pdev)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> +		struct airoha_gdm_dev *dev;
> =20
>  		if (!port)
>  			continue;
> =20
> -		unregister_netdev(port->dev);
> +		dev =3D port->dev;
> +		if (dev)
> +			unregister_netdev(dev->dev);
>  		airoha_metadata_dst_free(port);
>  	}
>  	airoha_hw_cleanup(eth);
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index d3781103abb5..c78cabbec753 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -535,10 +535,15 @@ struct airoha_qdma {
>  	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
>  };
> =20
> +struct airoha_gdm_dev {
> +	struct airoha_gdm_port *port;
> +	struct net_device *dev;
> +	struct airoha_eth *eth;
> +};
> +
>  struct airoha_gdm_port {
>  	struct airoha_qdma *qdma;
> -	struct airoha_eth *eth;
> -	struct net_device *dev;
> +	struct airoha_gdm_dev *dev;
>  	int id;
>  	int nbq;
> =20
> @@ -662,8 +667,8 @@ static inline bool airoha_is_7583(struct airoha_eth *=
eth)
>  }
> =20
>  int airoha_get_fe_port(struct airoha_gdm_port *port);
> -bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
> -			      struct airoha_gdm_port *port);
> +bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
> +			     struct airoha_gdm_dev *dev);
> =20
>  void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id,
>  			     u8 fport);
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 26da519236bf..af7af4097b98 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -298,12 +298,12 @@ static void airoha_ppe_foe_set_bridge_addrs(struct =
airoha_foe_bridge *br,
> =20
>  static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
>  					struct airoha_foe_entry *hwe,
> -					struct net_device *dev, int type,
> +					struct net_device *netdev, int type,
>  					struct airoha_flow_data *data,
>  					int l4proto)
>  {
>  	u32 qdata =3D FIELD_PREP(AIROHA_FOE_SHAPER_ID, 0x7f), ports_pad, val;
> -	int wlan_etype =3D -EINVAL, dsa_port =3D airoha_get_dsa_port(&dev);
> +	int wlan_etype =3D -EINVAL, dsa_port =3D airoha_get_dsa_port(&netdev);
>  	struct airoha_foe_mac_info_common *l2;
>  	u8 smac_id =3D 0xf;
> =20
> @@ -319,10 +319,11 @@ static int airoha_ppe_foe_entry_prepare(struct airo=
ha_eth *eth,
>  	hwe->ib1 =3D val;
> =20
>  	val =3D FIELD_PREP(AIROHA_FOE_IB2_PORT_AG, 0x1f);
> -	if (dev) {
> +	if (netdev) {
>  		struct airoha_wdma_info info =3D {};
> =20
> -		if (!airoha_ppe_get_wdma_info(dev, data->eth.h_dest, &info)) {
> +		if (!airoha_ppe_get_wdma_info(netdev, data->eth.h_dest,
> +					      &info)) {
>  			val |=3D FIELD_PREP(AIROHA_FOE_IB2_NBQ, info.idx) |
>  			       FIELD_PREP(AIROHA_FOE_IB2_PSE_PORT,
>  					  FE_PSE_PORT_CDM4);
> @@ -332,12 +333,14 @@ static int airoha_ppe_foe_entry_prepare(struct airo=
ha_eth *eth,
>  				     FIELD_PREP(AIROHA_FOE_MAC_WDMA_WCID,
>  						info.wcid);
>  		} else {
> -			struct airoha_gdm_port *port =3D netdev_priv(dev);
> +			struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +			struct airoha_gdm_port *port;
>  			u8 pse_port, channel;
> =20
> -			if (!airoha_is_valid_gdm_port(eth, port))
> +			if (!airoha_is_valid_gdm_dev(eth, dev))
>  				return -EINVAL;
> =20
> +			port =3D dev->port;
>  			if (dsa_port >=3D 0 || eth->ports[1])
>  				pse_port =3D port->id =3D=3D 4 ? FE_PSE_PORT_GDM4
>  							 : port->id;
> @@ -1473,7 +1476,7 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *de=
v, struct sk_buff *skb,
>  void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port)
>  {
>  	struct airoha_eth *eth =3D port->qdma->eth;
> -	struct net_device *dev =3D port->dev;
> +	struct net_device *dev =3D port->dev->dev;
>  	const u8 *addr =3D dev->dev_addr;
>  	u32 val;
> =20
>=20
> --=20
> 2.54.0
>=20

Commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260511-airoha-eth-multi-serdes-v6-0-c89946=
2c4f75%40kernel.org

- This problem wasn't introduced by this patch, but does this function call=
 lead
  to out-of-bounds memory accesses?
  - I do not think this is an issue, since airoha_eth driver supports just =
mtk as
    dsa driver where we actually skb_push() MTK_HDR_LEN bytes in mtk_tag_xm=
it().

- This problem wasn't introduced by this patch, but does this incorrect bou=
nds
  accounting in HTB offload break QoS?
  - I will fix this issue with a dedicated patch.

- This problem wasn't introduced by this patch, but does this leave the rate
  limit active due to an off-by-one error?
  - I will fix this issue with a dedicated patch.

- This problem wasn't introduced by this patch, but does this lead to a
  use-after-free of the device tree node?
  - This is fixed by a subsequent patch in the series.

Regards,
Lorenzo

--StL0DR0VC4TpI5/J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagOT1AAKCRA6cBh0uS2t
rK7eAQCf4SY4z2bv1WhJUWkWqXQp5CBFqphjygMQcfhfBXtVsQD/dm8GcXqNdmfL
LeRTMRhQ24UO0Ts5gZWG0eHCtFc6BAI=
=ooHU
-----END PGP SIGNATURE-----

--StL0DR0VC4TpI5/J--

