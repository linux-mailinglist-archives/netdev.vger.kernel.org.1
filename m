Return-Path: <netdev+bounces-295113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xrUNJyc8IWppBgEAu9opvQ
	(envelope-from <netdev+bounces-295113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:49:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC0663E253
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:49:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mDsKgH2H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295113-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295113-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3FA130A62AB
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00245394797;
	Thu,  4 Jun 2026 08:41:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7453E63B3;
	Thu,  4 Jun 2026 08:41:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562480; cv=none; b=T5XTbOPFwM1ewQ25EucIni/1UdMvtXh5Oj7R6ap09QuLVe3hNBSVJG9LGOiAo88tL+9KuaCzXIJxNyr8iCMi6TXsGqs7LTFWqQZlnr2utsBJiNANrESdD7Dc/+GYtX4nG8ACQDmfIpDktAFHxxCyCPmDpeELNSauDwCfKsJ8B4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562480; c=relaxed/simple;
	bh=ETRZbbA+O6ISTC6qvtbv+VbCL8DwRkvzwXDlGx5Ng4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY6MLmV68DmVgO6t2XAPxtCiSjT7MJMC5dMjsnFweXHalKaKKOvFjtVJhf7xJL3CEcoxJYAXmwgiLQrlQOZVOMqZT6FY81Wnje82AFRb7yzpEmQG5LQKuobzU6fdroS3Gou1lOy2KmQLjEKDy8z1d2TQKFf93vXIGjV/JX/Yv6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDsKgH2H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF5C1F0089A;
	Thu,  4 Jun 2026 08:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562470;
	bh=hgxl+4h3llj7eVv4Ij0cStkKqvycXFnOdLOxQYJgz14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mDsKgH2HVGbBV+FqyhWgsTwh5XT88Gs73iVfZltfZ7QTrSHuuJPI/T+FOLAx/lAoN
	 EOqKHfRRMw6E8cQrQ+e/ijyAzhU06jiulbIHX3dq/CT2RSBqU0RRebcUROhuSaKtaw
	 NvGH+s9UwaN5ZkaODTLuSAaC71UvCd0dkuQKYySgI/thPDyjFcUgNbGHAn4mJzR/+R
	 WaH3tEAAGPo3qC09FfGWds8Koh9WZl6qA2fjgujQ5m0oWHdNerN4k/QJi0IgfbVqMB
	 LoqCEI9Dkf2bMflAz80eFXqthNJEN/5aW6bat+Lzo9TOTogMNnQGYlSBKSWxFYCgCq
	 rPs7hWPnEfKQA==
Date: Thu, 4 Jun 2026 10:41:08 +0200
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
Subject: Re: [PATCH net-next v9 3/6] net: airoha: Support multiple
 net_devices for a single FE GDM port
Message-ID: <aiE6JOuyuf7g1MhI@lore-desk>
References: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
 <20260603-airoha-eth-multi-serdes-v9-3-5d476bc2f426@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mKruGJ7lwcXRHwuH"
Content-Disposition: inline
In-Reply-To: <20260603-airoha-eth-multi-serdes-v9-3-5d476bc2f426@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295113-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ansuelsmth@gmail.com,m:benjamin.larsson@genexis.eu,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:xuegang.lu@airoha.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lore-desk:mid,vger.kernel.org:from_smtp,linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CC0663E253


--mKruGJ7lwcXRHwuH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
>  drivers/net/ethernet/airoha/airoha_eth.c | 280 +++++++++++++++++++++++--=
------
>  drivers/net/ethernet/airoha/airoha_eth.h |   8 +-
>  drivers/net/ethernet/airoha/airoha_ppe.c |  26 ++-
>  3 files changed, 237 insertions(+), 77 deletions(-)

commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603-airoha-eth-mul=
ti-serdes-v9-0-5d476bc2f426%40kernel.org

- With multiple net_devices now allowed on the same GDM3/GDM4 port,
  airoha_dev_init() runs the GDM3/GDM4 branch of the switch for every
  device, which calls airoha_enable_gdm2_loopback() once per device.
  Inside that function:
  	src_port =3D eth->soc->ops.get_sport(port, dev->nbq);
  	...
  	airoha_fe_rmw(eth, REG_FE_WAN_PORT,
  		      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
  		      FIELD_PREP(WAN0_MASK, src_port));
  the rmw clears WAN0/WAN1/WAN1_EN and writes only WAN0. When two devices
  share a port (for example EN7581 GDM3 with nbq=3D4 and nbq=3D5, giving
  HSGMII_LAN_7581_PCIE0_SRCPORT and HSGMII_LAN_7581_PCIE1_SRCPORT, or
  ETH/USB on GDM4) wouldn't the second invocation overwrite the first
  device's src_port in WAN0, leaving the first device's traffic
  unrecognized as WAN even though the hardware register has WAN0/WAN1
  slots specifically for two ports?
  - We can run airoha_enable_gdm2_loopback() just for the single device
    configured as WAN. As pointed out by the report, this is enforced by a
    following patch in the series.

- Should d++ live below the of_device_is_available() check?
  - This is done on purpose to highlight device-tree misconfigurations.

Regards,
Lorenzo

>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 57a16de0a2ec..1d088d95d5fb 100644
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
> @@ -598,9 +600,9 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  		struct airoha_queue_entry *e =3D &q->entry[q->tail];
>  		struct airoha_qdma_desc *desc =3D &q->desc[q->tail];
>  		u32 hash, reason, msg1, desc_ctrl;
> -		struct airoha_gdm_port *port;
> +		struct airoha_gdm_dev *dev;
>  		struct net_device *netdev;
> -		int data_len, len, p;
> +		int data_len, len;
>  		struct page *page;
> =20
>  		desc_ctrl =3D le32_to_cpu(READ_ONCE(desc->ctrl));
> @@ -621,15 +623,11 @@ static int airoha_qdma_rx_process(struct airoha_que=
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
> -		if (!port->dev)
> -			goto free_frag;
> -
> -		netdev =3D netdev_from_priv(port->dev);
> +		netdev =3D netdev_from_priv(dev);
>  		if (!q->skb) { /* first buffer */
>  			q->skb =3D napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
>  						q->buf_size);
> @@ -659,6 +657,8 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  			continue;
> =20
>  		if (netdev_uses_dsa(netdev)) {
> +			struct airoha_gdm_port *port =3D dev->port;
> +
>  			/* PPE module requires untagged packets to work
>  			 * properly and it provides DSA port index via the
>  			 * DMA descriptor. Report DSA tag to the DSA stack
> @@ -852,26 +852,29 @@ static void airoha_qdma_wake_netdev_txqs(struct air=
oha_queue *q)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> -		struct airoha_gdm_dev *dev;
> -		struct net_device *netdev;
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
> +			struct net_device *netdev;
> +			int j;
> =20
> -		if (dev->qdma !=3D qdma)
> -			continue;
> +			if (!dev)
> +				continue;
> =20
> -		netdev =3D netdev_from_priv(dev);
> -		for (j =3D 0; j < netdev->num_tx_queues; j++) {
> -			if (airoha_qdma_get_txq(qdma, j) !=3D qid)
> +			if (dev->qdma !=3D qdma)
>  				continue;
> =20
> -			netif_wake_subqueue(netdev, j);
> +			netdev =3D netdev_from_priv(dev);
> +			for (j =3D 0; j < netdev->num_tx_queues; j++) {
> +				if (airoha_qdma_get_txq(qdma, j) !=3D qid)
> +					continue;
> +
> +				netif_wake_subqueue(netdev, j);
> +			}
>  		}
>  	}
>  	q->txq_stopped =3D false;
> @@ -1742,11 +1745,9 @@ static int airoha_dev_open(struct net_device *netd=
ev)
>  			GLOBAL_CFG_RX_DMA_EN_MASK);
>  	atomic_inc(&qdma->users);
> =20
> -	if (port->id =3D=3D AIROHA_GDM2_IDX &&
> -	    airoha_ppe_is_enabled(qdma->eth, 1)) {
> -		/* For PPE2 always use secondary cpu port. */
> +	if (!airoha_is_lan_gdm_dev(dev) &&
> +	    airoha_ppe_is_enabled(qdma->eth, 1))
>  		pse_port =3D FE_PSE_PORT_PPE2;
> -	}
>  	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
>  				    pse_port);
> =20
> @@ -1834,7 +1835,7 @@ static int airoha_enable_gdm2_loopback(struct airoh=
a_gdm_dev *dev)
>  	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
>  	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
> =20
> -	src_port =3D eth->soc->ops.get_sport(port, port->nbq);
> +	src_port =3D eth->soc->ops.get_sport(port, dev->nbq);
>  	if (src_port < 0)
>  		return src_port;
> =20
> @@ -1851,7 +1852,7 @@ static int airoha_enable_gdm2_loopback(struct airoh=
a_gdm_dev *dev)
>  		airoha_ppe_set_cpu_port(dev, i, AIROHA_GDM2_IDX);
> =20
>  	if (port->id =3D=3D AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
> -		u32 mask =3D FC_ID_OF_SRC_PORT_MASK(port->nbq);
> +		u32 mask =3D FC_ID_OF_SRC_PORT_MASK(dev->nbq);
> =20
>  		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
>  			      __field_prep(mask, AIROHA_GDM2_IDX));
> @@ -1865,7 +1866,7 @@ static int airoha_dev_init(struct net_device *netde=
v)
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_eth *eth =3D dev->eth;
> -	int i;
> +	int ppe_id;
> =20
>  	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
>  	dev->qdma =3D &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
> @@ -1888,8 +1889,8 @@ static int airoha_dev_init(struct net_device *netde=
v)
>  		break;
>  	}
> =20
> -	for (i =3D 0; i < eth->soc->num_ppe; i++)
> -		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
> +	ppe_id =3D !airoha_is_lan_gdm_dev(dev) && airoha_ppe_is_enabled(eth, 1);
> +	airoha_ppe_set_cpu_port(dev, ppe_id, airoha_get_fe_port(dev));
> =20
>  	return 0;
>  }
> @@ -2055,7 +2056,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
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
> @@ -2985,12 +2987,15 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *e=
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
> @@ -2998,10 +3003,11 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *e=
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
> @@ -3021,7 +3027,6 @@ static int airoha_alloc_gdm_device(struct airoha_et=
h *eth,
>  			      NETIF_F_HW_TC;
>  	netdev->features |=3D netdev->hw_features;
>  	netdev->vlan_features =3D netdev->hw_features;
> -	netdev->dev.of_node =3D np;
>  	SET_NETDEV_DEV(netdev, eth->dev);
> =20
>  	/* reserve hw queues for HTB offloading */
> @@ -3039,10 +3044,24 @@ static int airoha_alloc_gdm_device(struct airoha_=
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
>  	dev->port =3D port;
> -	port->dev =3D dev;
>  	dev->eth =3D eth;
> +	dev->nbq =3D nbq;
> +	port->devs[index] =3D dev;
> =20
>  	return 0;
>  }
> @@ -3052,7 +3071,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth =
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
> @@ -3080,15 +3100,51 @@ static int airoha_alloc_gdm_port(struct airoha_et=
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
> @@ -3097,14 +3153,22 @@ static int airoha_register_gdm_devices(struct air=
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
> -		err =3D register_netdev(netdev_from_priv(port->dev));
> -		if (err)
> -			return err;
> +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *dev =3D port->devs[j];
> +			int err;
> +
> +			if (!dev)
> +				continue;
> +
> +			err =3D register_netdev(netdev_from_priv(dev));
> +			if (err)
> +				return err;
> +		}
>  	}
> =20
>  	set_bit(DEV_STATE_REGISTERED, &eth->state);
> @@ -3211,17 +3275,22 @@ static int airoha_probe(struct platform_device *p=
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
> -		if (dev) {
> -			struct net_device *netdev =3D netdev_from_priv(dev);
> +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *dev =3D port->devs[j];
> +			struct net_device *netdev;
> +
> +			if (!dev)
> +				continue;
> =20
> +			netdev =3D netdev_from_priv(dev);
>  			if (netdev->reg_state =3D=3D NETREG_REGISTERED)
>  				unregister_netdev(netdev);
> +			of_node_put(netdev->dev.of_node);
>  		}
>  		airoha_metadata_dst_free(port);
>  	}
> @@ -3243,14 +3312,22 @@ static void airoha_remove(struct platform_device =
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
> -			unregister_netdev(netdev_from_priv(dev));
> +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *dev =3D port->devs[j];
> +			struct net_device *netdev;
> +
> +			if (!dev)
> +				continue;
> +
> +			netdev =3D netdev_from_priv(dev);
> +			unregister_netdev(netdev);
> +			of_node_put(netdev->dev.of_node);
> +		}
>  		airoha_metadata_dst_free(port);
>  	}
>  	airoha_hw_cleanup(eth);
> @@ -3313,6 +3390,39 @@ static u32 airoha_en7581_get_vip_port(struct airoh=
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
> @@ -3362,6 +3472,36 @@ static u32 airoha_an7583_get_vip_port(struct airoh=
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
> @@ -3370,6 +3510,7 @@ static const struct airoha_eth_soc_data en7581_soc_=
data =3D {
>  	.ops =3D {
>  		.get_sport =3D airoha_en7581_get_sport,
>  		.get_vip_port =3D airoha_en7581_get_vip_port,
> +		.get_dev_from_sport =3D airoha_en7581_get_dev_from_sport,
>  	},
>  };
> =20
> @@ -3381,6 +3522,7 @@ static const struct airoha_eth_soc_data an7583_soc_=
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
> index 1f162fa1405e..92fd81bb9269 100644
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
> @@ -546,12 +547,13 @@ struct airoha_gdm_dev {
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
> @@ -587,6 +589,8 @@ struct airoha_eth_soc_data {
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
> index c9711bb7ef1c..96abf451fdac 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -167,9 +167,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
>  		airoha_fe_clear(eth, REG_PPE_PPE_FLOW_CFG(i),
>  				PPE_FLOW_CFG_IP6_6RD_MASK);
> =20
> -		for (p =3D 0; p < ARRAY_SIZE(eth->ports); p++) {
> -			struct airoha_gdm_port *port =3D eth->ports[p];
> -
> +		for (p =3D 0; p < ARRAY_SIZE(eth->ports); p++)
>  			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),
>  				      FP0_EGRESS_MTU_MASK |
>  				      FP1_EGRESS_MTU_MASK,
> @@ -177,11 +175,27 @@ static void airoha_ppe_hw_init(struct airoha_ppe *p=
pe)
>  						 AIROHA_MAX_MTU) |
>  				      FIELD_PREP(FP1_EGRESS_MTU_MASK,
>  						 AIROHA_MAX_MTU));
> -			if (!port)
> +	}
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
> +			int ppe_id;
> +			u8 fport;
> +
> +			if (!dev)
>  				continue;
> =20
> -			airoha_ppe_set_cpu_port(port->dev, i,
> -						airoha_get_fe_port(port->dev));
> +			ppe_id =3D !airoha_is_lan_gdm_dev(dev) &&
> +				 airoha_ppe_is_enabled(eth, 1);
> +			fport =3D airoha_get_fe_port(dev);
> +			airoha_ppe_set_cpu_port(dev, ppe_id, fport);
>  		}
>  	}
>  }
>=20
> --=20
> 2.54.0
>=20

--mKruGJ7lwcXRHwuH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiE6JAAKCRA6cBh0uS2t
rKWvAQDDJs8m0vfUTAgiiuR0P3MEM/NZuaw8lkk4XQCfwRwn0AD+LhB2DiAhdWQ4
WJQdmU6cFL4LOeZJTP3e9+CrNc5FAgQ=
=PFdg
-----END PGP SIGNATURE-----

--mKruGJ7lwcXRHwuH--

