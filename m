Return-Path: <netdev+bounces-304703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C8MHMuPpSGouvQAAu9opvQ
	(envelope-from <netdev+bounces-304703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 13:09:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1241F70764E
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 13:09:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D9+FylOV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304703-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304703-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E4F300F533
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCE7354AE3;
	Sat,  4 Jul 2026 11:09:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2984039
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 11:09:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783163356; cv=none; b=uaqBxvkbgFw38sXraNl1TU5ZsFnqni/7fstsLkoKVmIHUDEFo9nHTmQg/RMm925XKhs7tWqGUNF3qeoU4r8sihr2CFVe8d5BfuRJ0HowTDXOEWeqGTSN6vR96ePcr0givr/y/xY6XcSCodvalUgsxTbFveWlT/6/GuLEmvyROMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783163356; c=relaxed/simple;
	bh=t77RH5CoAxIl1MJQi6HyUPQyKxRQse6saQbWIYuOYOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qn6hRw0U9jVJfPQwRpVetep6iDj4OKVaiMvELGNWdq/FWOfv5Y96OD7+SppW1ldZlQOPf/xeTIGh1xLicR5Qf5rycfHy8gAZZcAwLThp0TC44Jwl8pj/+/7o8kuFfdrPTfAmCXMHOGgnpJ51YiDYlxKeHjmdtD1lcpnOViPnsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9+FylOV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66851F000E9;
	Sat,  4 Jul 2026 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783163354;
	bh=UpgJvy1MiMw4/dGao4okt7N0G00o0QS8CEPzzHtfcew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D9+FylOVZV+Vb9s+m7e3vWjw5MV5beBStmZdCr9XVNAV+CBo9C6ozHPh/+4pSpTm3
	 2Qb2VgfjeLdcFygRuXt4FPciprFVDE4ctBAAGO1IjYleTaHGv0vb0tLDkKt5VTsmWr
	 8o8kfG5PQ2HbObclrj0gcJw92y1WK6ilHcRtVkUHBhYWgJMswD3CW7Pl/oKOkooUJH
	 XCEjPjiecZbwGrrnP68vfVoEW/Uo0sqw+U7oax2tfhIQz7wiLGx+yG0vZQADosSxi+
	 0rmGlTH1BP+5Gi5/Sv0/MRxPHzMfDMdpH6+NM0rL2ZW2CEKtglbYNad3oWAQ+Sn3oh
	 pX9BXbXV69nIg==
Date: Sat, 4 Jul 2026 13:09:10 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v8 3/3] net: airoha: defer GDM3/GDM4 WAN mode
 and GDM2 loopback to QoS offload
Message-ID: <akjp1gBqBOLKQ5HB@lore-rh-laptop>
References: <20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org>
 <20260703-airoha-ethtool-priv_flags-v8-3-015ba5ac89ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uo2PZy/jsyMPv8Yd"
Content-Disposition: inline
In-Reply-To: <20260703-airoha-ethtool-priv_flags-v8-3-015ba5ac89ee@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304703-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:aleksander.lobakin@intel.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,vger.kernel.org:from_smtp,linux.dev:url,airoha.com:email,lore-rh-laptop:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1241F70764E


--uo2PZy/jsyMPv8Yd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> GDM3 and GDM4 ports require GDM2 loopback to be enabled for hardware
> QoS offload to function. Without it, HTB and ETS offload on these ports
> do not work.
> Previously, GDM3/GDM4 ports were automatically configured as WAN with
> GDM2 loopback enabled during ndo_init(). Add the capability to configure
> GDM3/GDM4 as WAN/LAN on demand when QoS offload is created or destroyed.
> Hook airoha_enable_qos_for_gdm34() into TC_HTB_CREATE so that requesting
> HTB offload on a GDM3/GDM4 LAN port switches it to WAN mode and enables
> GDM2 loopback, with proper rollback on failure. Introduce the
> AIROHA_DEV_F_QOS flag to track whether a device has an active HTB
> qdisc; clear it on TC_HTB_DESTROY. The device keeps its WAN role after
> qdisc teardown so that its configuration is preserved until another
> device explicitly needs the WAN role for QoS offload.
> If another GDM3/GDM4 device already holds the WAN role without an active
> QoS qdisc, demote it to LAN before promoting the requesting device. Skip
> the demotion when the requesting device is itself already the WAN device.
> Since airoha_dev_set_qdma() can now be called on a running device to
> migrate between QDMA blocks, make dev->qdma an RCU pointer so the TX
> path can safely dereference it without holding RTNL.
> Hold flow_offload_mutex in airoha_enable_qos_for_gdm34() and
> airoha_disable_qos_for_gdm34() around the dev->flags update,
> airoha_dev_set_qdma() and GDM2 loopback configuration, serializing
> against concurrent airoha_ppe_hw_init() in the TC_SETUP_CLSFLOWER
> offload path.
> Introduce airoha_qdma_deref() helper that wraps rcu_dereference_protected=
()
> with a lockdep condition accepting either rtnl_lock or flow_offload_mutex,
> and use it across all control-path dereferences of the RCU-protected
> dev->qdma pointer.
> Add airoha_disable_gdm2_loopback() to disable GDM2 hw loopback.
>=20
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260703-airoha-ethtool=
-priv_flags-v8-0-015ba5ac89ee%40kernel.org

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  | 233 ++++++++++++++++++++++++=
++----
>  drivers/net/ethernet/airoha/airoha_eth.h  |  13 +-
>  drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
>  drivers/net/ethernet/airoha/airoha_regs.h |   1 +
>  4 files changed, 227 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index aaf2a4717d12..fe2e2af67173 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -934,7 +934,7 @@ static void airoha_qdma_wake_netdev_txqs(struct airoh=
a_queue *q)
>  			if (!dev)
>  				continue;
> =20
> -			if (dev->qdma !=3D qdma)
> +			if (rcu_access_pointer(dev->qdma) !=3D qdma)
>  				continue;
> =20
>  			netdev =3D netdev_from_priv(dev);
> @@ -1866,8 +1866,8 @@ static int airoha_dev_open(struct net_device *netde=
v)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
> -	struct airoha_qdma *qdma =3D dev->qdma;
>  	u32 pse_port =3D FE_PSE_PORT_PPE1;
> +	struct airoha_qdma *qdma;
>  	int err;
> =20
>  	netif_tx_start_all_queues(netdev);
> @@ -1875,6 +1875,7 @@ static int airoha_dev_open(struct net_device *netde=
v)
>  	if (err)
>  		return err;
> =20
> +	qdma =3D airoha_qdma_deref(dev);
>  	if (netdev_uses_dsa(netdev))
>  		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
>  			      GDM_STAG_EN_MASK);
> @@ -1898,7 +1899,6 @@ static int airoha_dev_stop(struct net_device *netde=
v)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
> -	struct airoha_qdma *qdma =3D dev->qdma;
> =20
>  	netif_tx_disable(netdev);
>  	airoha_set_vip_for_gdm_port(dev, false);
> @@ -1906,7 +1906,7 @@ static int airoha_dev_stop(struct net_device *netde=
v)
>  	if (--port->users)
>  		airoha_ppe_set_xmit_frame_size(dev);
>  	else
> -		airoha_set_gdm_port_fwd_cfg(qdma->eth,
> +		airoha_set_gdm_port_fwd_cfg(dev->eth,
>  					    REG_GDM_FWD_CFG(port->id),
>  					    FE_PSE_PORT_DROP);
>  	return 0;
> @@ -1989,6 +1989,53 @@ static int airoha_enable_gdm2_loopback(struct airo=
ha_gdm_dev *dev)
>  	return 0;
>  }
> =20
> +static int airoha_disable_gdm2_loopback(struct airoha_gdm_dev *dev)
> +{
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
> +	int i, src_port;
> +	u32 pse_port;
> +
> +	src_port =3D eth->soc->ops.get_sport(dev->port, dev->nbq);
> +	if (src_port < 0)
> +		return src_port;
> +
> +	airoha_fe_clear(eth,
> +			REG_SP_DFT_CPORT(src_port >> fls(SP_CPORT_DFT_MASK)),
> +			SP_CPORT_MASK(src_port & SP_CPORT_DFT_MASK));
> +
> +	airoha_fe_set(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
> +		      GDM_STRIP_CRC_MASK);
> +	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
> +				    FE_PSE_PORT_DROP);
> +	airoha_fe_clear(eth, REG_GDM_LPBK_CFG(AIROHA_GDM2_IDX),
> +			LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK);
> +	pse_port =3D airoha_ppe_is_enabled(eth, 1) ? FE_PSE_PORT_PPE2
> +						 : FE_PSE_PORT_PPE1;
> +	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
> +				    pse_port);
> +
> +	airoha_fe_rmw(eth, REG_FE_WAN_PORT, WAN0_MASK,
> +		      FIELD_PREP(WAN0_MASK, AIROHA_GDM2_IDX));
> +
> +	for (i =3D 0; i < eth->soc->num_ppe; i++)
> +		airoha_fe_clear(eth, REG_PPE_DFT_CPORT(i, AIROHA_GDM2_IDX),
> +				DFT_CPORT_MASK(AIROHA_GDM2_IDX));
> +
> +	/* Enable VIP and IFC for GDM2 */
> +	airoha_fe_set(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
> +	airoha_fe_set(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
> +
> +	if (port->id =3D=3D AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
> +		u32 mask =3D FC_ID_OF_SRC_PORT_MASK(dev->nbq);
> +
> +		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
> +			      FC_MAP6_DEF_VALUE & mask);
> +	}
> +
> +	return 0;
> +}
> +
>  static struct airoha_gdm_dev *
>  airoha_get_wan_gdm_dev(struct airoha_eth *eth)
>  {
> @@ -2015,15 +2062,35 @@ airoha_get_wan_gdm_dev(struct airoha_eth *eth)
>  static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
>  {
>  	struct net_device *netdev =3D netdev_from_priv(dev);
> +	struct airoha_qdma *cur_qdma, *qdma;
>  	struct airoha_eth *eth =3D dev->eth;
> -	int ppe_id;
> +	int i, ppe_id;
> =20
>  	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
> -	dev->qdma =3D &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
> -	netdev->irq =3D dev->qdma->irq_banks[0].irq;
> +	qdma =3D &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
> +	cur_qdma =3D airoha_qdma_deref(dev);
> +
> +	rcu_assign_pointer(dev->qdma, qdma);
> +	netdev->irq =3D qdma->irq_banks[0].irq;
> =20
>  	ppe_id =3D !airoha_is_lan_gdm_dev(dev) && airoha_ppe_is_enabled(eth, 1);
>  	airoha_ppe_set_cpu_port(dev, ppe_id, airoha_get_fe_port(dev));
> +
> +	if (!cur_qdma)
> +		return;
> +
> +	/* Seed qos_stats baselines with the new QDMA block's current
> +	 * counter values to avoid a spurious spike on the first stats
> +	 * query after migration.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(dev->qos_stats); i++) {
> +		dev->qos_stats[i].cpu_tx_packets =3D
> +			airoha_qdma_rr(qdma, REG_CNTR_VAL(i << 1));
> +		dev->qos_stats[i].fwd_tx_packets =3D
> +			airoha_qdma_rr(qdma, REG_CNTR_VAL((i << 1) + 1));
> +	}
> +	synchronize_rcu();
> +	netif_tx_wake_all_queues(netdev);
>  }

- Is the ordering here safe with respect to the TX fast path?
  - There is a small window where in-flight packets can see the hw not fully
    re-configured (e.g. FE not fully re-configured) but this is not harmful
    (e.g. causing persistent state corruption or hardware), just some packe=
ts
    are drop during user-requested configuration. I think we can ignore this
    comment.

> =20
>  static int airoha_dev_init(struct net_device *netdev)
> @@ -2178,9 +2245,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  				   struct net_device *netdev)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_qdma *qdma =3D dev->qdma;
>  	u32 nr_frags, tag, msg0, msg1, len;
>  	struct airoha_queue_entry *e;
> +	struct airoha_qdma *qdma;
>  	struct netdev_queue *txq;
>  	struct airoha_queue *q;
>  	LIST_HEAD(tx_list);
> @@ -2189,6 +2256,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  	u16 index;
>  	u8 fport;
> =20
> +	rcu_read_lock();
> +	qdma =3D rcu_dereference(dev->qdma);
>  	qid =3D airoha_qdma_get_txq(qdma, skb_get_queue_mapping(skb));
>  	tag =3D airoha_get_dsa_tag(skb, netdev);
> =20
> @@ -2238,6 +2307,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  		netif_tx_stop_queue(txq);
>  		q->txq_stopped =3D true;
>  		spin_unlock_bh(&q->lock);
> +		rcu_read_unlock();
> +
>  		return NETDEV_TX_BUSY;
>  	}
> =20
> @@ -2303,6 +2374,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
> =20
>  	spin_unlock_bh(&q->lock);
> +	rcu_read_unlock();
> =20
>  	return NETDEV_TX_OK;
> =20
> @@ -2315,6 +2387,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  error:
>  	dev_kfree_skb_any(skb);
>  	netdev->stats.tx_dropped++;
> +	rcu_read_unlock();
> =20
>  	return NETDEV_TX_OK;
>  }
> @@ -2394,17 +2467,19 @@ static int airoha_qdma_set_chan_tx_sched(struct n=
et_device *netdev,
>  					 const u16 *weights, u8 n_weights)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_qdma *qdma;
>  	int i;
> =20
> +	qdma =3D airoha_qdma_deref(dev);
>  	for (i =3D 0; i < AIROHA_NUM_QOS_QUEUES; i++)
> -		airoha_qdma_clear(dev->qdma, REG_QUEUE_CLOSE_CFG(channel),
> +		airoha_qdma_clear(qdma, REG_QUEUE_CLOSE_CFG(channel),
>  				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));
> =20
>  	for (i =3D 0; i < n_weights; i++) {
>  		u32 status;
>  		int err;
> =20
> -		airoha_qdma_wr(dev->qdma, REG_TXWRR_WEIGHT_CFG,
> +		airoha_qdma_wr(qdma, REG_TXWRR_WEIGHT_CFG,
>  			       TWRR_RW_CMD_MASK |
>  			       FIELD_PREP(TWRR_CHAN_IDX_MASK, channel) |
>  			       FIELD_PREP(TWRR_QUEUE_IDX_MASK, i) |
> @@ -2412,12 +2487,12 @@ static int airoha_qdma_set_chan_tx_sched(struct n=
et_device *netdev,
>  		err =3D read_poll_timeout(airoha_qdma_rr, status,
>  					status & TWRR_RW_CMD_DONE,
>  					USEC_PER_MSEC, 10 * USEC_PER_MSEC,
> -					true, dev->qdma, REG_TXWRR_WEIGHT_CFG);
> +					true, qdma, REG_TXWRR_WEIGHT_CFG);
>  		if (err)
>  			return err;
>  	}
> =20
> -	airoha_qdma_rmw(dev->qdma, REG_CHAN_QOS_MODE(channel >> 3),
> +	airoha_qdma_rmw(qdma, REG_CHAN_QOS_MODE(channel >> 3),
>  			CHAN_QOS_MODE_MASK(channel),
>  			__field_prep(CHAN_QOS_MODE_MASK(channel), mode));
> =20
> @@ -2481,10 +2556,11 @@ static int airoha_qdma_get_tx_ets_stats(struct ne=
t_device *netdev, int channel,
>  					struct tc_ets_qopt_offload *opt)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_qdma *qdma =3D dev->qdma;
>  	u32 cpu_tx_packets, fwd_tx_packets;
> +	struct airoha_qdma *qdma;
>  	u64 tx_packets;
> =20
> +	qdma =3D airoha_qdma_deref(dev);
>  	cpu_tx_packets =3D airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
>  	fwd_tx_packets =3D airoha_qdma_rr(qdma,
>  					REG_CNTR_VAL((channel << 1) + 1));
> @@ -2751,16 +2827,18 @@ static int airoha_qdma_set_tx_rate_limit(struct n=
et_device *netdev,
>  					 u32 bucket_size)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_qdma *qdma;
>  	int i, err;
> =20
> +	qdma =3D airoha_qdma_deref(dev);
>  	for (i =3D 0; i <=3D TRTCM_PEAK_MODE; i++) {
> -		err =3D airoha_qdma_set_trtcm_config(dev->qdma, channel,
> +		err =3D airoha_qdma_set_trtcm_config(qdma, channel,
>  						   REG_EGRESS_TRTCM_CFG, i,
>  						   !!rate, TRTCM_METER_MODE);
>  		if (err)
>  			return err;
> =20
> -		err =3D airoha_qdma_set_trtcm_token_bucket(dev->qdma, channel,
> +		err =3D airoha_qdma_set_trtcm_token_bucket(qdma, channel,
>  							 REG_EGRESS_TRTCM_CFG,
>  							 i, rate, bucket_size);
>  		if (err)
> @@ -2796,11 +2874,12 @@ static int airoha_tc_htb_alloc_leaf_queue(struct =
net_device *netdev,
>  	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>  	int err, num_tx_queues =3D AIROHA_NUM_TX_RING + channel + 1;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_qdma *qdma =3D dev->qdma;
> +	struct airoha_qdma *qdma;
> =20
>  	/* Here we need to check the requested QDMA channel is not already
>  	 * in use by another net_device running on the same QDMA block.
>  	 */
> +	qdma =3D airoha_qdma_deref(dev);
>  	if (test_and_set_bit(channel, qdma->qos_channel_map)) {
>  		NL_SET_ERR_MSG_MOD(opt->extack,
>  				   "qdma qos channel already in use");
> @@ -2836,7 +2915,7 @@ static int airoha_qdma_set_rx_meter(struct airoha_g=
dm_dev *dev,
>  				    u32 rate, u32 bucket_size,
>  				    enum trtcm_unit_type unit_type)
>  {
> -	struct airoha_qdma *qdma =3D dev->qdma;
> +	struct airoha_qdma *qdma =3D airoha_qdma_deref(dev);
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
> @@ -3011,10 +3090,11 @@ static void airoha_tc_remove_htb_queue(struct net=
_device *netdev, int queue)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	int num_tx_queues =3D AIROHA_NUM_TX_RING;
> -	struct airoha_qdma *qdma =3D dev->qdma;
> +	struct airoha_qdma *qdma;
> =20
>  	airoha_qdma_set_tx_rate_limit(netdev, queue, 0, 0);
> =20
> +	qdma =3D airoha_qdma_deref(dev);
>  	clear_bit(queue, qdma->qos_channel_map);
>  	clear_bit(queue, dev->qos_sq_bmap);
> =20
> @@ -3040,6 +3120,98 @@ static int airoha_tc_htb_delete_leaf_queue(struct =
net_device *netdev,
>  	return 0;
>  }
> =20
> +static void airoha_disable_qos_for_gdm34(struct net_device *netdev)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> +	int err;
> +
> +	if (port->id !=3D AIROHA_GDM3_IDX &&
> +	    port->id !=3D AIROHA_GDM4_IDX)
> +		return;
> +
> +	err =3D airoha_disable_gdm2_loopback(dev);
> +	if (err)
> +		netdev_warn(netdev,
> +			    "failed disabling GDM2 loopback: %d\n", err);
> +
> +	dev->flags &=3D ~AIROHA_DEV_F_WAN;
> +	airoha_dev_set_qdma(dev);
> +
> +	airoha_set_macaddr(dev, netdev->dev_addr);

- Should the return value of airoha_set_macaddr() be checked here?
  - This issue has been reported and discussed in previous iterations.
    airoha_set_macaddr() can fail just if the device is misconfigured.
    Moreover, airoha_set_macaddr() already logs warnings via dev_warn()
    when the MSB check fails, so the failure won't be silent.

> +	airoha_ppe_set_xmit_frame_size(dev);
> +
> +	if (netif_running(netdev))
> +		airoha_set_gdm_port_fwd_cfg(dev->eth,
> +					    REG_GDM_FWD_CFG(port->id),
> +					    FE_PSE_PORT_PPE1);
> +}
> +
> +static int airoha_enable_qos_for_gdm34(struct net_device *netdev,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct airoha_gdm_dev *wan_dev, *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
> +	int err =3D -EBUSY;
> +
> +	if (port->id !=3D AIROHA_GDM3_IDX &&
> +	    port->id !=3D AIROHA_GDM4_IDX) {
> +		/* HW QoS is always supported by GDM1 and GDM2 */
> +		return 0;
> +	}
> +
> +	if (!airoha_is_lan_gdm_dev(dev)) /* Already enabled */
> +		return 0;
> +
> +	mutex_lock(&flow_offload_mutex);
> +
> +	wan_dev =3D airoha_get_wan_gdm_dev(eth);
> +	if (wan_dev) {
> +		if ((wan_dev->flags & AIROHA_DEV_F_QOS) ||
> +		    wan_dev->port->id =3D=3D AIROHA_GDM2_IDX) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "QoS configured for WAN device");
> +			goto error_unlock;
> +		}
> +		airoha_disable_qos_for_gdm34(netdev_from_priv(wan_dev));
> +	}
> +
> +	dev->flags |=3D AIROHA_DEV_F_WAN;
> +	airoha_dev_set_qdma(dev);
> +	err =3D airoha_enable_gdm2_loopback(dev);
> +	if (err)
> +		goto error_disable_wan;
> +
> +	err =3D airoha_set_macaddr(dev, netdev->dev_addr);
> +	if (err)
> +		goto error_disable_loopback;
> +
> +	airoha_dev_set_xmit_frame_size(netdev);
> +	if (netif_running(netdev)) {
> +		u32 pse_port;
> +
> +		pse_port =3D airoha_ppe_is_enabled(eth, 1) ? FE_PSE_PORT_PPE2
> +							 : FE_PSE_PORT_PPE1;
> +		airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(port->id),
> +					    pse_port);
> +	}
> +
> +	mutex_unlock(&flow_offload_mutex);
> +
> +	return 0;
> +
> +error_disable_loopback:
> +	airoha_disable_gdm2_loopback(dev);
> +error_disable_wan:
> +	dev->flags &=3D ~AIROHA_DEV_F_WAN;
> +	airoha_dev_set_qdma(dev);
> +error_unlock:
> +	mutex_unlock(&flow_offload_mutex);
> +
> +	return err;

- Does this rollback path fully undo the effect of demoting the previous WA=
N device?
  - This issue has been reported and discussed in previous iterations.
    If the promotion of the new device fails, the tc command returns an err=
or to userspace,
    the requested configuration was not applied. The system is still proces=
sing
    packets and the user can log and reapply the configuration.
    Re-promoting the old WAN device on error would add complexity for failu=
re cases that
    do not really occur in practice since airoha_set_macaddr() and
    airoha_enable_gdm2_loopback() fail only if the device is misconfigured.

Regards,
Lorenzo

> +}
> +
>  static int airoha_tc_htb_destroy(struct net_device *netdev)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> @@ -3048,6 +3220,8 @@ static int airoha_tc_htb_destroy(struct net_device =
*netdev)
>  	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
>  		airoha_tc_remove_htb_queue(netdev, q);
> =20
> +	dev->flags &=3D ~AIROHA_DEV_F_QOS;
> +
>  	return 0;
>  }
> =20
> @@ -3067,24 +3241,33 @@ static int airoha_tc_get_htb_get_leaf_queue(struc=
t net_device *netdev,
>  	return 0;
>  }
> =20
> -static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
> +static int airoha_tc_setup_qdisc_htb(struct net_device *netdev,
>  				     struct tc_htb_qopt_offload *opt)
>  {
>  	switch (opt->command) {
> -	case TC_HTB_CREATE:
> +	case TC_HTB_CREATE: {
> +		struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +		int err;
> +
> +		err =3D airoha_enable_qos_for_gdm34(netdev, opt->extack);
> +		if (err)
> +			return err;
> +
> +		dev->flags |=3D AIROHA_DEV_F_QOS;
>  		break;
> +	}
>  	case TC_HTB_DESTROY:
> -		return airoha_tc_htb_destroy(dev);
> +		return airoha_tc_htb_destroy(netdev);
>  	case TC_HTB_NODE_MODIFY:
> -		return airoha_tc_htb_modify_queue(dev, opt);
> +		return airoha_tc_htb_modify_queue(netdev, opt);
>  	case TC_HTB_LEAF_ALLOC_QUEUE:
> -		return airoha_tc_htb_alloc_leaf_queue(dev, opt);
> +		return airoha_tc_htb_alloc_leaf_queue(netdev, opt);
>  	case TC_HTB_LEAF_DEL:
>  	case TC_HTB_LEAF_DEL_LAST:
>  	case TC_HTB_LEAF_DEL_LAST_FORCE:
> -		return airoha_tc_htb_delete_leaf_queue(dev, opt);
> +		return airoha_tc_htb_delete_leaf_queue(netdev, opt);
>  	case TC_HTB_LEAF_QUERY_QUEUE:
> -		return airoha_tc_get_htb_get_leaf_queue(dev, opt);
> +		return airoha_tc_get_htb_get_leaf_queue(netdev, opt);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index bf44be9f0954..4d03ebae1a2d 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -545,11 +545,12 @@ struct airoha_qdma {
> =20
>  enum airoha_dev_flags {
>  	AIROHA_DEV_F_WAN =3D BIT(0),
> +	AIROHA_DEV_F_QOS =3D BIT(1),
>  };
> =20
>  struct airoha_gdm_dev {
> +	struct airoha_qdma __rcu *qdma;
>  	struct airoha_gdm_port *port;
> -	struct airoha_qdma *qdma;
>  	struct airoha_eth *eth;
> =20
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> @@ -685,6 +686,16 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev);
>  bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>  			     struct airoha_gdm_dev *dev);
> =20
> +extern struct mutex flow_offload_mutex;
> +
> +static inline struct airoha_qdma *
> +airoha_qdma_deref(struct airoha_gdm_dev *dev)
> +{
> +	return rcu_dereference_protected(dev->qdma,
> +					 lockdep_rtnl_is_held() ||
> +					 lockdep_is_held(&flow_offload_mutex));
> +}
> +
>  void airoha_ppe_set_xmit_frame_size(struct airoha_gdm_dev *dev);
>  void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port);
>  bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index e7c78293002a..78378a6262f9 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -15,7 +15,10 @@
>  #include "airoha_regs.h"
>  #include "airoha_eth.h"
> =20
> -static DEFINE_MUTEX(flow_offload_mutex);
> +/* Serialize airoha_gdm_dev flags, QDMA pointer and PPE CPU port
> + * configuration.
> + */
> +DEFINE_MUTEX(flow_offload_mutex);
>  static DEFINE_SPINLOCK(ppe_lock);
> =20
>  static const struct rhashtable_params airoha_flow_table_params =3D {
> @@ -86,8 +89,8 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe *=
ppe)
> =20
>  void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port)
>  {
> -	struct airoha_qdma *qdma =3D dev->qdma;
> -	struct airoha_eth *eth =3D qdma->eth;
> +	struct airoha_qdma *qdma =3D airoha_qdma_deref(dev);
> +	struct airoha_eth *eth =3D dev->eth;
>  	u8 qdma_id =3D qdma - &eth->qdma[0];
>  	u32 fe_cpu_port;
> =20
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index 6fed63d013b4..442b48c9b991 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -375,6 +375,7 @@
> =20
>  #define REG_SRC_PORT_FC_MAP6		0x2298
>  #define FC_ID_OF_SRC_PORT_MASK(_n)	GENMASK(4 + ((_n) << 3), ((_n) << 3))
> +#define FC_MAP6_DEF_VALUE		0x1b1a1918
> =20
>  #define REG_WAN_MTU0			0x2300
>  #define WAN_MTU1_MASK			GENMASK(29, 16)
>=20
> --=20
> 2.55.0
>=20

--uo2PZy/jsyMPv8Yd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakjp0wAKCRA6cBh0uS2t
rCgAAQC1Xx6bNa7ib+VhTeOVCzXxwNBjOUnpOwteUn8p3wrQQgEAwyobGWOqe0SH
gl5o7kc5It/4k9F9LFk+yAheBUlqZAg=
=+Jw3
-----END PGP SIGNATURE-----

--uo2PZy/jsyMPv8Yd--

