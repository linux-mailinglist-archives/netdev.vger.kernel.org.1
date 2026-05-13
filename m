Return-Path: <netdev+bounces-287494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF0BOvhHBGo+GwIAu9opvQ
	(envelope-from <netdev+bounces-287494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:44:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FAB530DFF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FB8530ECD9A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D33E5A2E;
	Wed, 13 May 2026 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc9l7Qot"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC63AC0ED;
	Wed, 13 May 2026 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664376; cv=none; b=ML8PxAxA7IWGbL8A4oFgO4MU5hMDkLXKJj2Ri1PnqunxkloIM86+8aGKzr6O1CSdgEpcdk3Ka2xAJ9Df5y4TYMZMTsTlH1SQDLzpzYGgTPSdAOxz/y/x0kF56PbDYnIqsL3Y8dQNVn+pANNDh0og3kATp00cd20uVBLaf8p3g3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664376; c=relaxed/simple;
	bh=24fx6bf5OV0Zhr7vgtaOax7lnyBIrTaGhT3SSkgPXzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUEsQNAvhxK6bRhsOHvY61aqpjNZyhXu7PU0VLeVN/vLfi6uh3eoS1km+226vo8kHq7s4C6+27E35Ln9+K/lwDc9YimsEfD0D0HT0SmGkzB3QcvFdFEyD3LtfyVw84wzi9UIw8lDcHVoNYx7fB8NNIe9qBw7pHjeCjpwjTFZoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc9l7Qot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BC3C2BCB7;
	Wed, 13 May 2026 09:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778664376;
	bh=24fx6bf5OV0Zhr7vgtaOax7lnyBIrTaGhT3SSkgPXzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pc9l7QotT5zFux/mNrTkYAPVZYtKT5sz7gdYOQ2sAG2hNIY2I8Q60gb2XVj8w/rVL
	 Lz6MlMcpRrhfkmGSsK/BSqryw1RolPqeGMNM/AyeusEadK8X1hi+JpJv0Lrbgqq7TY
	 yUb9/2Zlv3oFHdiZ/g5q65Yeb8EI7okbTLyjXzlQ8rqwhQRZK+bv6/oJ7iy47odVtC
	 MDkuefaVuWBkIrOCaaN5trUWXrfcI4iFhysVkAk+8xBG3l8I24vnPqzVjO4DX9liZG
	 SkMcFepkFcz6KTcQ0wGuhCZBVc/c3bu3GM74/3slPbC6VuIzvH9uGc3HqJBNBzh9jF
	 046aCnPIJBlFg==
Date: Wed, 13 May 2026 11:26:13 +0200
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
Subject: Re: [PATCH net-next v6 08/12] net: airoha: Support multiple
 net_devices for a single FE GDM port
Message-ID: <agRDtRkLJRcTpjfO@lore-desk>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
 <20260511-airoha-eth-multi-serdes-v6-8-c899462c4f75@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="27mh7oEUiZrtb6rf"
Content-Disposition: inline
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-8-c899462c4f75@kernel.org>
X-Rspamd-Queue-Id: 48FAB530DFF
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-287494-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--27mh7oEUiZrtb6rf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 11, Lorenzo Bianconi wrote:
> EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
> manages the traffic in a TDM manner. As a result multiple net_devices can
> connect to the same GDM{3,4} port and there is a theoretical "1:n"
> relation between GDM ports and net_devices.
>=20
>            =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90
>            =E2=94=82                                 =E2=94=82    =E2=94=
=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>            =E2=94=82                         P1 GDM1 =E2=94=9C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=96=BAMT7530=E2=94=82
>            =E2=94=82                                 =E2=94=82    =E2=94=
=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>            =E2=94=82                                 =E2=94=82      ETH0 =
(DSA conduit)
>            =E2=94=82                                 =E2=94=82
>            =E2=94=82              PSE/FE             =E2=94=82
>            =E2=94=82                                 =E2=94=82
>            =E2=94=82                                 =E2=94=82
>            =E2=94=82                                 =E2=94=82    =E2=94=
=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>            =E2=94=82                         P0 CDM1 =E2=94=9C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=96=BAQDMA0=E2=94=82
>            =E2=94=82  P4                     P9 GDM4 =E2=94=82    =E2=94=
=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>            =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98
>               =E2=94=82                         =E2=94=82
>            =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=
=90                 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>            =E2=94=82 PPE =E2=94=82                 =E2=94=82   ARB   =E2=
=94=82
>            =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98                 =E2=94=94=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=98
>                                      =E2=94=82     =E2=94=82
>                                   =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=
=94=80=E2=94=80=E2=94=90=E2=94=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90
>                                   =E2=94=82 ETH =E2=94=82=E2=94=82 USB =
=E2=94=82
>                                   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98
>                                    ETH1   ETH2
>=20
> Introduce support for multiple net_devices connected to the same Frame
> Engine (FE) GDM port (GDM3 or GDM4) via an external hw arbiter.
> Please note GDM1 or GDM2 does not support the connection with the external
> arbiter.
> Add get_dev_from_sport callback since EN7581 and AN7583 have different
> logics for the net_device type connected to GDM3 or GDM4.
>=20
> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 271 ++++++++++++++++++++++++-=
------
>  drivers/net/ethernet/airoha/airoha_eth.h |  10 +-
>  drivers/net/ethernet/airoha/airoha_ppe.c |  13 +-
>  3 files changed, 228 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index f0d5f28dd731..4efd36779453 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -106,7 +106,7 @@ static int airoha_set_vip_for_gdm_port(struct airoha_=
gdm_dev *dev, bool enable)
>  	struct airoha_eth *eth =3D dev->eth;
>  	u32 vip_port;
> =20
> -	vip_port =3D eth->soc->ops.get_vip_port(port, port->nbq);
> +	vip_port =3D eth->soc->ops.get_vip_port(port, dev->nbq);
>  	if (enable) {
>  		airoha_fe_set(eth, REG_FE_VIP_PORT_EN, vip_port);
>  		airoha_fe_set(eth, REG_FE_IFC_PORT_EN, vip_port);
> @@ -566,24 +566,26 @@ static int airoha_qdma_fill_rx_queue(struct airoha_=
queue *q)
>  	return nframes;
>  }
> =20
> -static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
> -				    struct airoha_qdma_desc *desc)
> +static struct airoha_gdm_dev *
> +airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc =
*desc)
>  {
> -	u32 port, sport, msg1 =3D le32_to_cpu(READ_ONCE(desc->msg1));
> +	struct airoha_gdm_port *port;
> +	u16 p, d;
> =20
> -	sport =3D FIELD_GET(QDMA_ETH_RXMSG_SPORT_MASK, msg1);
> -	switch (sport) {
> -	case 0x10 ... 0x14:
> -		port =3D 0;
> -		break;
> -	case 0x2 ... 0x4:
> -		port =3D sport - 1;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	if (eth->soc->ops.get_dev_from_sport(desc, &p, &d))
> +		return ERR_PTR(-ENODEV);
> =20
> -	return port >=3D ARRAY_SIZE(eth->ports) ? -EINVAL : port;
> +	if (p >=3D ARRAY_SIZE(eth->ports))
> +		return ERR_PTR(-ENODEV);
> +
> +	port =3D eth->ports[p];
> +	if (!port)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (d >=3D ARRAY_SIZE(port->devs))
> +		return ERR_PTR(-ENODEV);
> +
> +	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
>  }
> =20
>  static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
> @@ -598,9 +600,8 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  		struct airoha_queue_entry *e =3D &q->entry[q->tail];
>  		struct airoha_qdma_desc *desc =3D &q->desc[q->tail];
>  		u32 hash, reason, msg1, desc_ctrl;
> -		struct airoha_gdm_port *port;
> -		struct net_device *netdev;
> -		int data_len, len, p;
> +		struct airoha_gdm_dev *dev;
> +		int data_len, len;
>  		struct page *page;
> =20
>  		desc_ctrl =3D le32_to_cpu(READ_ONCE(desc->ctrl));
> @@ -623,12 +624,10 @@ static int airoha_qdma_rx_process(struct airoha_que=
ue *q, int budget)
>  		if (!len || data_len < len)
>  			goto free_frag;
> =20
> -		p =3D airoha_qdma_get_gdm_port(eth, desc);
> -		if (p < 0 || !eth->ports[p])
> +		dev =3D airoha_qdma_get_gdm_dev(eth, desc);
> +		if (IS_ERR(dev))
>  			goto free_frag;
> =20
> -		port =3D eth->ports[p];
> -		netdev =3D port->dev->dev;
>  		if (!q->skb) { /* first buffer */
>  			q->skb =3D napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
>  						q->buf_size);
> @@ -638,8 +637,8 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  			skb_reserve(q->skb, AIROHA_RX_HEADROOM);
>  			__skb_put(q->skb, len);
>  			skb_mark_for_recycle(q->skb);
> -			q->skb->dev =3D netdev;
> -			q->skb->protocol =3D eth_type_trans(q->skb, netdev);
> +			q->skb->dev =3D dev->dev;
> +			q->skb->protocol =3D eth_type_trans(q->skb, dev->dev);
>  			q->skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>  			skb_record_rx_queue(q->skb, qid);
>  		} else { /* scattered frame */
> @@ -657,7 +656,9 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  		if (FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl))
>  			continue;
> =20
> -		if (netdev_uses_dsa(netdev)) {
> +		if (netdev_uses_dsa(dev->dev)) {
> +			struct airoha_gdm_port *port =3D dev->port;
> +
>  			/* PPE module requires untagged packets to work
>  			 * properly and it provides DSA port index via the
>  			 * DMA descriptor. Report DSA tag to the DSA stack
> @@ -851,24 +852,27 @@ static void airoha_qdma_wake_netdev_txqs(struct air=
oha_queue *q)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> -		struct airoha_gdm_dev *dev;
> -		int j;
> +		int d;
> =20
>  		if (!port)
>  			continue;
> =20
> -		dev =3D port->dev;
> -		if (!dev)
> -			continue;
> +		for (d =3D 0; d < ARRAY_SIZE(port->devs); d++) {
> +			struct airoha_gdm_dev *dev =3D port->devs[d];
> +			int j;
> =20
> -		if (dev->qdma !=3D qdma)
> -			continue;
> +			if (!dev)
> +				continue;
> =20
> -		for (j =3D 0; j < dev->dev->num_tx_queues; j++) {
> -			if (airoha_qdma_get_txq(qdma, j) !=3D qid)
> +			if (dev->qdma !=3D qdma)
>  				continue;
> =20
> -			netif_wake_subqueue(dev->dev, j);
> +			for (j =3D 0; j < dev->dev->num_tx_queues; j++) {
> +				if (airoha_qdma_get_txq(qdma, j) !=3D qid)
> +					continue;
> +
> +				netif_wake_subqueue(dev->dev, j);
> +			}
>  		}
>  	}
>  	q->txq_stopped =3D false;
> @@ -1829,7 +1833,7 @@ static int airoha_set_gdm2_loopback(struct airoha_g=
dm_dev *dev)
>  	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
>  	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
> =20
> -	src_port =3D eth->soc->ops.get_sport(port, port->nbq);
> +	src_port =3D eth->soc->ops.get_sport(port, dev->nbq);
>  	if (src_port < 0)
>  		return src_port;
> =20
> @@ -1846,7 +1850,7 @@ static int airoha_set_gdm2_loopback(struct airoha_g=
dm_dev *dev)
>  		airoha_ppe_set_cpu_port(dev, i, AIROHA_GDM2_IDX);
> =20
>  	if (port->id =3D=3D AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
> -		u32 mask =3D FC_ID_OF_SRC_PORT_MASK(port->nbq);
> +		u32 mask =3D FC_ID_OF_SRC_PORT_MASK(dev->nbq);
> =20
>  		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
>  			      __field_prep(mask, AIROHA_GDM2_IDX));
> @@ -2050,7 +2054,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  	}
> =20
>  	fport =3D airoha_get_fe_port(dev);
> -	msg1 =3D FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
> +	msg1 =3D FIELD_PREP(QDMA_ETH_TXMSG_NBOQ_MASK, dev->nbq) |
> +	       FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
>  	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
> =20
>  	q =3D &qdma->q_tx[qid];
> @@ -2983,12 +2988,15 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *e=
th,
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> +		int j;
> =20
>  		if (!port)
>  			continue;
> =20
> -		if (port->dev =3D=3D dev)
> -			return true;
> +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +			if (port->devs[j] =3D=3D dev)
> +				return true;
> +		}
>  	}
> =20
>  	return false;
> @@ -2996,10 +3004,11 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *e=
th,
> =20
>  static int airoha_alloc_gdm_device(struct airoha_eth *eth,
>  				   struct airoha_gdm_port *port,
> -				   struct device_node *np)
> +				   int nbq, struct device_node *np)
>  {
> -	struct airoha_gdm_dev *dev;
>  	struct net_device *netdev;
> +	struct airoha_gdm_dev *dev;
> +	u8 index;
>  	int err;
> =20
>  	netdev =3D devm_alloc_etherdev_mqs(eth->dev, sizeof(*dev),
> @@ -3019,7 +3028,6 @@ static int airoha_alloc_gdm_device(struct airoha_et=
h *eth,
>  			      NETIF_F_HW_TC;
>  	netdev->features |=3D netdev->hw_features;
>  	netdev->vlan_features =3D netdev->hw_features;
> -	netdev->dev.of_node =3D np;
>  	SET_NETDEV_DEV(netdev, eth->dev);
> =20
>  	/* reserve hw queues for HTB offloading */
> @@ -3037,11 +3045,25 @@ static int airoha_alloc_gdm_device(struct airoha_=
eth *eth,
>  			 netdev->dev_addr);
>  	}
> =20
> +	/* Allowed nbq for EN7581 on GDM3 port are 4 and 5 for PCIE0
> +	 * and PCIE1 respectively.
> +	 */
> +	index =3D nbq;
> +	if (index && airoha_is_7581(eth) && port->id =3D=3D AIROHA_GDM3_IDX)
> +		index -=3D 4;
> +
> +	if (index >=3D ARRAY_SIZE(port->devs) || port->devs[index]) {
> +		dev_err(eth->dev, "invalid nbq id: %d\n", nbq);
> +		return -EINVAL;
> +	}
> +
> +	netdev->dev.of_node =3D of_node_get(np);
>  	dev =3D netdev_priv(netdev);
>  	dev->dev =3D netdev;
>  	dev->port =3D port;
> -	port->dev =3D dev;
>  	dev->eth =3D eth;
> +	dev->nbq =3D nbq;
> +	port->devs[index] =3D dev;
> =20
>  	return 0;
>  }
> @@ -3051,7 +3073,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth =
*eth,
>  {
>  	const __be32 *id_ptr =3D of_get_property(np, "reg", NULL);
>  	struct airoha_gdm_port *port;
> -	int err, p;
> +	struct device_node *node;
> +	int err, nbq, p, d =3D 0;
>  	u32 id;
> =20
>  	if (!id_ptr) {
> @@ -3079,15 +3102,51 @@ static int airoha_alloc_gdm_port(struct airoha_et=
h *eth,
>  	u64_stats_init(&port->stats.syncp);
>  	spin_lock_init(&port->stats.lock);
>  	port->id =3D id;
> -	/* XXX: Read nbq from DTS */
> -	port->nbq =3D id =3D=3D AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
>  	eth->ports[p] =3D port;
> =20
>  	err =3D airoha_metadata_dst_alloc(port);
>  	if (err)
>  		return err;
> =20
> -	return airoha_alloc_gdm_device(eth, port, np);
> +	/* Default nbq value to ensure backward compatibility */
> +	nbq =3D id =3D=3D AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
> +
> +	for_each_child_of_node(np, node) {
> +		/* Multiple external serdes connected to the FE GDM port via an
> +		 * external arbiter.
> +		 */
> +		const __be32 *nbq_ptr;
> +
> +		if (!of_device_is_compatible(node, "airoha,eth-port"))
> +			continue;
> +
> +		d++;
> +		if (!of_device_is_available(node))
> +			continue;
> +
> +		nbq_ptr =3D of_get_property(node, "reg", NULL);
> +		if (!nbq_ptr) {
> +			dev_err(eth->dev, "missing nbq id\n");
> +			of_node_put(node);
> +			return -EINVAL;
> +		}
> +
> +		/* Verify the provided nbq parameter is valid */
> +		nbq =3D be32_to_cpup(nbq_ptr);
> +		err =3D eth->soc->ops.get_sport(port, nbq);
> +		if (err < 0) {
> +			of_node_put(node);
> +			return err;
> +		}
> +
> +		err =3D airoha_alloc_gdm_device(eth, port, nbq, node);
> +		if (err) {
> +			of_node_put(node);
> +			return err;
> +		}
> +	}
> +
> +	return !d ? airoha_alloc_gdm_device(eth, port, nbq, np) : 0;
>  }
> =20
>  static int airoha_register_gdm_devices(struct airoha_eth *eth)
> @@ -3096,14 +3155,22 @@ static int airoha_register_gdm_devices(struct air=
oha_eth *eth)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> -		int err;
> +		int j;
> =20
>  		if (!port)
>  			continue;
> =20
> -		err =3D register_netdev(port->dev->dev);
> -		if (err)
> -			return err;
> +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *dev =3D port->devs[j];
> +			int err;
> +
> +			if (!dev)
> +				continue;
> +
> +			err =3D register_netdev(dev->dev);
> +			if (err)
> +				return err;
> +		}
>  	}
> =20
>  	set_bit(DEV_STATE_REGISTERED, &eth->state);
> @@ -3210,14 +3277,23 @@ static int airoha_probe(struct platform_device *p=
dev)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> -		struct airoha_gdm_dev *dev;
> +		int j;
> =20
>  		if (!port)
>  			continue;
> =20
> -		dev =3D port->dev;
> -		if (dev && dev->dev->reg_state =3D=3D NETREG_REGISTERED)
> -			unregister_netdev(dev->dev);
> +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *dev =3D port->devs[j];
> +			struct net_device *netdev;
> +
> +			if (!dev)
> +				continue;
> +
> +			netdev =3D dev->dev;
> +			if (netdev->reg_state =3D=3D NETREG_REGISTERED)
> +				unregister_netdev(netdev);
> +			of_node_put(netdev->dev.of_node);
> +		}
>  		airoha_metadata_dst_free(port);
>  	}
>  	airoha_hw_cleanup(eth);
> @@ -3238,14 +3314,22 @@ static void airoha_remove(struct platform_device =
*pdev)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> -		struct airoha_gdm_dev *dev;
> +		int j;
> =20
>  		if (!port)
>  			continue;
> =20
> -		dev =3D port->dev;
> -		if (dev)
> -			unregister_netdev(dev->dev);
> +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *dev =3D port->devs[j];
> +			struct net_device *netdev;
> +
> +			if (!dev)
> +				continue;
> +
> +			netdev =3D dev->dev;
> +			unregister_netdev(netdev);
> +			of_node_put(netdev->dev.of_node);
> +		}
>  		airoha_metadata_dst_free(port);
>  	}
>  	airoha_hw_cleanup(eth);
> @@ -3308,6 +3392,39 @@ static u32 airoha_en7581_get_vip_port(struct airoh=
a_gdm_port *port, int nbq)
>  	return 0;
>  }
> =20
> +static int airoha_en7581_get_dev_from_sport(struct airoha_qdma_desc *des=
c,
> +					    u16 *port, u16 *dev)
> +{
> +	u32 sport =3D FIELD_GET(QDMA_ETH_RXMSG_SPORT_MASK,
> +			      le32_to_cpu(READ_ONCE(desc->msg1)));
> +
> +	*dev =3D 0;
> +	switch (sport) {
> +	case 0x10 ... 0x14:
> +		*port =3D 0; /* GDM1 */
> +		break;
> +	case 0x2 ... 0x4:
> +		*port =3D sport - 1;
> +		break;
> +	case HSGMII_LAN_7581_PCIE1_SRCPORT:
> +		*dev =3D 1;
> +		fallthrough;
> +	case HSGMII_LAN_7581_PCIE0_SRCPORT:
> +		*port =3D 2; /* GDM3 */
> +		break;
> +	case HSGMII_LAN_7581_USB_SRCPORT:
> +		*dev =3D 1;
> +		fallthrough;
> +	case HSGMII_LAN_7581_ETH_SRCPORT:
> +		*port =3D 3; /* GDM4 */
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const char * const an7583_xsi_rsts_names[] =3D {
>  	"xsi-mac",
>  	"hsi0-mac",
> @@ -3357,6 +3474,36 @@ static u32 airoha_an7583_get_vip_port(struct airoh=
a_gdm_port *port, int nbq)
>  	return 0;
>  }
> =20
> +static int airoha_an7583_get_dev_from_sport(struct airoha_qdma_desc *des=
c,
> +					    u16 *port, u16 *dev)
> +{
> +	u32 sport =3D FIELD_GET(QDMA_ETH_RXMSG_SPORT_MASK,
> +			      le32_to_cpu(READ_ONCE(desc->msg1)));
> +
> +	*dev =3D 0;
> +	switch (sport) {
> +	case 0x10 ... 0x14:
> +		*port =3D 0; /* GDM1 */
> +		break;
> +	case 0x2 ... 0x4:
> +		*port =3D sport - 1;
> +		break;
> +	case HSGMII_LAN_7583_ETH_SRCPORT:
> +		*port =3D 2; /* GDM3 */
> +		break;
> +	case HSGMII_LAN_7583_USB_SRCPORT:
> +		*dev =3D 1;
> +		fallthrough;
> +	case HSGMII_LAN_7583_PCIE_SRCPORT:
> +		*port =3D 3; /* GDM4 */
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct airoha_eth_soc_data en7581_soc_data =3D {
>  	.version =3D 0x7581,
>  	.xsi_rsts_names =3D en7581_xsi_rsts_names,
> @@ -3365,6 +3512,7 @@ static const struct airoha_eth_soc_data en7581_soc_=
data =3D {
>  	.ops =3D {
>  		.get_sport =3D airoha_en7581_get_sport,
>  		.get_vip_port =3D airoha_en7581_get_vip_port,
> +		.get_dev_from_sport =3D airoha_en7581_get_dev_from_sport,
>  	},
>  };
> =20
> @@ -3376,6 +3524,7 @@ static const struct airoha_eth_soc_data an7583_soc_=
data =3D {
>  	.ops =3D {
>  		.get_sport =3D airoha_an7583_get_sport,
>  		.get_vip_port =3D airoha_an7583_get_vip_port,
> +		.get_dev_from_sport =3D airoha_an7583_get_dev_from_sport,
>  	},
>  };
> =20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index fbb50dc73af8..fc49f0049983 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -17,6 +17,7 @@
>  #include <net/dsa.h>
> =20
>  #define AIROHA_MAX_NUM_GDM_PORTS	4
> +#define AIROHA_MAX_NUM_GDM_DEVS		2
>  #define AIROHA_MAX_NUM_QDMA		2
>  #define AIROHA_MAX_NUM_IRQ_BANKS	4
>  #define AIROHA_MAX_DSA_PORTS		7
> @@ -540,19 +541,20 @@ struct airoha_qdma {
>  struct airoha_gdm_dev {
>  	struct airoha_gdm_port *port;
>  	struct airoha_qdma *qdma;
> -	struct net_device *dev;
>  	struct airoha_eth *eth;
> +	struct net_device *dev;
> =20
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
>  	/* qos stats counters */
>  	u64 cpu_tx_packets;
>  	u64 fwd_tx_packets;
> +
> +	int nbq;
>  };
> =20
>  struct airoha_gdm_port {
> -	struct airoha_gdm_dev *dev;
> +	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
>  	int id;
> -	int nbq;
> =20
>  	struct airoha_hw_stats stats;
> =20
> @@ -588,6 +590,8 @@ struct airoha_eth_soc_data {
>  	struct {
>  		int (*get_sport)(struct airoha_gdm_port *port, int nbq);
>  		u32 (*get_vip_port)(struct airoha_gdm_port *port, int nbq);
> +		int (*get_dev_from_sport)(struct airoha_qdma_desc *desc,
> +					  u16 *port, u16 *dev);
>  	} ops;
>  };
> =20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 047141b2d6d8..c4086d29d984 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -169,6 +169,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
> =20
>  		for (p =3D 0; p < ARRAY_SIZE(eth->ports); p++) {
>  			struct airoha_gdm_port *port =3D eth->ports[p];
> +			int j;
> =20
>  			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),
>  				      FP0_EGRESS_MTU_MASK |
> @@ -180,8 +181,16 @@ static void airoha_ppe_hw_init(struct airoha_ppe *pp=
e)
>  			if (!port)
>  				continue;
> =20
> -			airoha_ppe_set_cpu_port(port->dev, i,
> -						airoha_get_fe_port(port->dev));
> +			for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +				struct airoha_gdm_dev *dev =3D port->devs[j];
> +				u8 fport;
> +
> +				if (!dev)
> +					continue;
> +
> +				fport =3D airoha_get_fe_port(dev);
> +				airoha_ppe_set_cpu_port(dev, i, fport);
> +			}
>  		}
>  	}
>  }
>=20
> --=20
> 2.54.0
>=20

commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260511-airoha-eth-mul=
ti-serdes-v6-0-c899462c4f75%40kernel.org

- With multiple net_devices now sharing a single GDM3 or GDM4 port (for
  example EN7581 GDM3 with PCIE0 nbq=3D4 and PCIE1 nbq=3D5), is
  airoha_set_gdm2_loopback() still safe to call once per dev through .ndo_i=
nit?
  - This is not a problem since airoha_set_gdm2_loopback() is run just for =
WAN
    interfaces and we can have a single WAN device.

Regards,
Lorenzo

--27mh7oEUiZrtb6rf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagRDtQAKCRA6cBh0uS2t
rKvWAQCW1+cG4PwX7l7QVVSwm6GXL48HZKkxHkDqS5K2kKQoWQD+N5xte6qM3wBI
sM/RS/tLG1DS2tO9Qc065Rbck6yIVwI=
=/KL7
-----END PGP SIGNATURE-----

--27mh7oEUiZrtb6rf--

