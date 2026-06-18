Return-Path: <netdev+bounces-300479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e6SbNvERNGqQNQYAu9opvQ
	(envelope-from <netdev+bounces-300479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:42:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A456A14DA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:42:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DzbhgxUx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300479-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300479-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFDE33014247
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9F832BF5A;
	Thu, 18 Jun 2026 15:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55B32B128
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:42:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797355; cv=none; b=RwKeAYUN9ZwtmK4tB+CZK4UNJKXmA49uTE4viHJntwrVcbZiRtptmMN7wjccG/7GYRQsZjAPG79L7Zf/coeFFaTYAq+lIiLE2gAyygJqrPPKThxkIPLJ9ReHaX1CDkiMjXLa98RDm1d5moV5na8C4Onu2/AaNIeOFy8rrvjY2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797355; c=relaxed/simple;
	bh=9Kha7S4nqNLbsKYMY2fGK2PJwP5wzSXFe0X48KEZ6PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy1acuPsuIUAWnKYm2kDlFEGeClXglOjqswwem6rp69KBMc90f6c6FAcI7Q9K9rk2ZM2iHB2E26Im+E2fa6PGB5HS9/ETlIukSBKwWf95CV6G9BG0Pbo2XTBpOpbl7Js67Ay7jbT3A95fy+PHVVUJX6E7NfHlamAvRkPCUbuFgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzbhgxUx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D8D1F000E9;
	Thu, 18 Jun 2026 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781797354;
	bh=VjfhLXxCEIVy/ezaAy4yB7hmEeEswoa6WnM2lC5QNec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DzbhgxUxeAAYXTM+y0XcRW+5iZqzWl5duVZ+s/g3tJbbbmbl1xhUB3ebZDAjCW92Z
	 P9pI9QDUChwsNy3UYAtGN5tUw+brEAw0j6GfjGvGobzW5ietV1tlOg+k7KO9ywrt3p
	 0spdSwh4RwZqD0bzRzj6s5R9/CpcgERhifh8yuINFvaCue+fEfrw32jwju/jlrpDCc
	 8FrsbMQpqbyPwMOeczena4A2bCrm0FpffxYr4z0RRuMiumw3pWO56C40ndEzIcqtXE
	 kQAF3WRj5MsiKd0JYrW18EKNwWGUVS2p6SxkNtrW8CO74KTaqKaQ7XGzbvGtSVmylH
	 7rZ18tEXGFcIQ==
Date: Thu, 18 Jun 2026 17:42:31 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: fix BQL underflow and UAF in shared
 QDMA TX ring
Message-ID: <ajQR533ZUKyS5KYP@lore-desk>
References: <20260618-airoha-bql-fixes-v1-1-ffd2c2089518@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uRgNDmciIoh0RGbX"
Content-Disposition: inline
In-Reply-To: <20260618-airoha-bql-fixes-v1-1-ffd2c2089518@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300479-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7A456A14DA


--uRgNDmciIoh0RGbX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> When multiple netdevs share a QDMA TX ring and one device is stopped,
> netdev_tx_reset_subqueue() zeroes that device's BQL counters while its
> pending skbs remain in the shared HW TX ring. When NAPI later completes
> those skbs via netdev_tx_completed_queue(), the already-zeroed
> dql->num_queued counter underflows.
> Moreover, in the airoha_remove() path, netdevs are unregistered
> sequentially while skbs from previously unregistered netdevs may still
> reference freed net_device memory via skb->dev, causing a use-after-free
> during BQL accounting.
> Fix both issues:
> - Remove netdev_tx_reset_subqueue() from airoha_dev_stop() so pending
>   skbs are completed naturally by NAPI with proper BQL accounting.
> - Add netdev_tx_completed_queue() in airoha_qdma_cleanup_tx_queue()
>   to properly account for skbs freed during queue teardown.
> - Introduce airoha_qdma_tx_disable() to stop TX on all registered
>   netdevs for a given QDMA instance under RTNL lock.
> - Move DMA engine start/stop into probe/remove and
>   airoha_qdma_cleanup(), ensuring TX queues are cleaned up while all
>   netdevs are still registered and skb->dev is valid.
>=20
> Fixes: 6df0488dc9dd ("net: airoha: fix BQL accounting in airoha_qdma_clea=
nup_tx_queue()")

This Fixes tag is wrong, the proper one is the one below:
Fixes: a9c2ca61fec7 ("net: airoha: Support multiple net_devices for a singl=
e FE GDM port")

Regards,
Lorenzo

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 95 ++++++++++++++++++++++++--=
------
>  1 file changed, 72 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 64dde6464f3f..4d6a061cd779 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1004,6 +1004,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_str=
uct *napi, int budget)
> =20
>  		e =3D &q->entry[index];
>  		skb =3D e->skb;
> +		e->skb =3D NULL;
> =20
>  		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
>  				 DMA_TO_DEVICE);
> @@ -1147,6 +1148,42 @@ static int airoha_qdma_init_tx(struct airoha_qdma =
*qdma)
>  	return 0;
>  }
> =20
> +static void airoha_qdma_tx_disable(struct airoha_qdma *qdma)
> +{
> +	struct airoha_eth *eth =3D qdma->eth;
> +	int i;
> +
> +	/* Protect netdev->reg_state and netif_tx_disable() calls. */
> +	rtnl_lock();
> +
> +	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> +		struct airoha_gdm_port *port =3D eth->ports[i];
> +		int j;
> +
> +		if (!port)
> +			continue;
> +
> +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *dev =3D port->devs[j];
> +			struct net_device *netdev;
> +
> +			if (!dev)
> +				continue;
> +
> +			if (dev->qdma !=3D qdma)
> +				continue;
> +
> +			netdev =3D netdev_from_priv(dev);
> +			if (netdev->reg_state !=3D NETREG_REGISTERED)
> +				continue;
> +
> +			netif_tx_disable(netdev);
> +		}
> +	}
> +
> +	rtnl_unlock();
> +}
> +
>  static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
>  {
>  	struct airoha_qdma *qdma =3D q->qdma;
> @@ -1158,13 +1195,20 @@ static void airoha_qdma_cleanup_tx_queue(struct a=
iroha_queue *q)
>  	for (i =3D 0; i < q->ndesc; i++) {
>  		struct airoha_queue_entry *e =3D &q->entry[i];
>  		struct airoha_qdma_desc *desc =3D &q->desc[i];
> +		struct sk_buff *skb =3D e->skb;
> =20
>  		if (!e->dma_addr)
>  			continue;
> =20
>  		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
>  				 DMA_TO_DEVICE);
> -		dev_kfree_skb_any(e->skb);
> +		if (skb) {
> +			struct netdev_queue *txq;
> +
> +			txq =3D skb_get_tx_queue(skb->dev, skb);
> +			netdev_tx_completed_queue(txq, 1, skb->len);
> +			dev_kfree_skb_any(skb);
> +		}
>  		e->dma_addr =3D 0;
>  		e->skb =3D NULL;
>  		list_add_tail(&e->list, &q->tx_list);
> @@ -1527,6 +1571,23 @@ static void airoha_qdma_cleanup(struct airoha_qdma=
 *qdma)
>  {
>  	int i;
> =20
> +	if (test_bit(DEV_STATE_INITIALIZED, &qdma->eth->state)) {
> +		u32 status;
> +
> +		airoha_qdma_tx_disable(qdma);
> +
> +		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> +				  GLOBAL_CFG_TX_DMA_EN_MASK |
> +				  GLOBAL_CFG_RX_DMA_EN_MASK);
> +		if (read_poll_timeout(airoha_qdma_rr, status,
> +				      !(status & (GLOBAL_CFG_TX_DMA_BUSY_MASK |
> +						  GLOBAL_CFG_RX_DMA_BUSY_MASK)),
> +				      USEC_PER_MSEC, 50 * USEC_PER_MSEC, true,
> +				      qdma, REG_QDMA_GLOBAL_CFG))
> +			dev_warn(qdma->eth->dev,
> +				 "QDMA DMA engine busy timeout\n");
> +	}
> +
>  	for (i =3D 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
>  		if (!qdma->q_rx[i].ndesc)
>  			continue;
> @@ -1837,9 +1898,6 @@ static int airoha_dev_open(struct net_device *netde=
v)
>  	}
>  	port->users++;
> =20
> -	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
> -			GLOBAL_CFG_TX_DMA_EN_MASK |
> -			GLOBAL_CFG_RX_DMA_EN_MASK);
>  	qdma->users++;
> =20
>  	if (!airoha_is_lan_gdm_dev(dev) &&
> @@ -1880,12 +1938,9 @@ static int airoha_dev_stop(struct net_device *netd=
ev)
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_qdma *qdma =3D dev->qdma;
> -	int i;
> =20
>  	netif_tx_disable(netdev);
>  	airoha_set_vip_for_gdm_port(dev, false);
> -	for (i =3D 0; i < netdev->num_tx_queues; i++)
> -		netdev_tx_reset_subqueue(netdev, i);
> =20
>  	if (--port->users)
>  		airoha_set_port_mtu(dev->eth, port);
> @@ -1893,19 +1948,7 @@ static int airoha_dev_stop(struct net_device *netd=
ev)
>  		airoha_set_gdm_port_fwd_cfg(qdma->eth,
>  					    REG_GDM_FWD_CFG(port->id),
>  					    FE_PSE_PORT_DROP);
> -
> -	if (!--qdma->users) {
> -		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> -				  GLOBAL_CFG_TX_DMA_EN_MASK |
> -				  GLOBAL_CFG_RX_DMA_EN_MASK);
> -
> -		for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
> -			if (!qdma->q_tx[i].ndesc)
> -				continue;
> -
> -			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
> -		}
> -	}
> +	qdma->users--;
> =20
>  	return 0;
>  }
> @@ -3413,8 +3456,12 @@ static int airoha_probe(struct platform_device *pd=
ev)
>  	if (err)
>  		goto error_netdev_free;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
> +	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++) {
>  		airoha_qdma_start_napi(&eth->qdma[i]);
> +		airoha_qdma_set(&eth->qdma[i], REG_QDMA_GLOBAL_CFG,
> +				GLOBAL_CFG_TX_DMA_EN_MASK |
> +				GLOBAL_CFG_RX_DMA_EN_MASK);
> +	}
> =20
>  	for_each_child_of_node(pdev->dev.of_node, np) {
>  		if (!of_device_is_compatible(np, "airoha,eth-mac"))
> @@ -3440,6 +3487,8 @@ static int airoha_probe(struct platform_device *pde=
v)
>  	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
>  		airoha_qdma_stop_napi(&eth->qdma[i]);
> =20
> +	airoha_hw_cleanup(eth);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
>  		int j;
> @@ -3461,7 +3510,6 @@ static int airoha_probe(struct platform_device *pde=
v)
>  		}
>  		airoha_metadata_dst_free(port);
>  	}
> -	airoha_hw_cleanup(eth);
>  error_netdev_free:
>  	free_netdev(eth->napi_dev);
>  	platform_set_drvdata(pdev, NULL);
> @@ -3477,6 +3525,8 @@ static void airoha_remove(struct platform_device *p=
dev)
>  	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
>  		airoha_qdma_stop_napi(&eth->qdma[i]);
> =20
> +	airoha_hw_cleanup(eth);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
>  		int j;
> @@ -3497,7 +3547,6 @@ static void airoha_remove(struct platform_device *p=
dev)
>  		}
>  		airoha_metadata_dst_free(port);
>  	}
> -	airoha_hw_cleanup(eth);
> =20
>  	free_netdev(eth->napi_dev);
>  	platform_set_drvdata(pdev, NULL);
>=20
> ---
> base-commit: 7d8297e26b4e20b5d1c3c3fe51fe81a1c7fbc823
> change-id: 20260618-airoha-bql-fixes-f57b2d108573
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--uRgNDmciIoh0RGbX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajQR5wAKCRA6cBh0uS2t
rAvbAQCjz8fl5z8pg/Dww3cSzoKYeJW7gQgKt5YXJAh8QPDitQD/QuOMcXn0aPf9
Hnwl+7hYGryC7gxzeLCRhRe0E16isgw=
=qhPo
-----END PGP SIGNATURE-----

--uRgNDmciIoh0RGbX--

