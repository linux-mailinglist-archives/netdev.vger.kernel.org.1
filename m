Return-Path: <netdev+bounces-286163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /i9hD08h/2mN2gAAu9opvQ
	(envelope-from <netdev+bounces-286163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 13:58:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2EE4FF83B
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 13:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3110F300B9D6
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E255388E5B;
	Sat,  9 May 2026 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcEF8t5k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987317A2F6;
	Sat,  9 May 2026 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778327883; cv=none; b=L7sVsMYaC7EKApFPBCUuQVl7K1WodvndfCMTOwxZG7f9I3Tbe4EbWVDdj7EPfWleU2kEW5fUKJ0QpQh14yEYV/u+dSSjQqWWxTlnqNo+JIfEw7iUj8ZKoyHCclVUKFYLd3aXc5trY2yZFVlyzSj4500fVg7cz5wQq4UdW9v+Zww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778327883; c=relaxed/simple;
	bh=+kyeoNx5SiAfpEbCxeY8IdHHEPk/F+CGq69tXbZwlEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD70whDjoo6PBbGHOfVB8I71Ax4AN7yj2890iD6zqKlojGgHpUAlhmuFKoLaemPLQrSLZJN83VUp3ATTa3RBbvIURvTBYQs0faRoEr1bjGxnx1mILhsOKs8r4gXBUWUoQY1LHljA/sqOICBje9kgZyYBgnIU2g5RV81WmvBih/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcEF8t5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A110FC2BCB2;
	Sat,  9 May 2026 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778327883;
	bh=+kyeoNx5SiAfpEbCxeY8IdHHEPk/F+CGq69tXbZwlEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcEF8t5k6VqDZ6MdDBPQUeQyQaK9hltJGEAmDInpBrF4Yp8ClEhcV3MGGC263ErJ5
	 qsyWi7icnNOC5xoC4PtYBQo5QY0/Lu4l95SUBTMKxF6D1wdZLz5IGoB23s0MQDCNGP
	 7hU9CA/oKvxU4lEhzHEtsQtA/TPwsKAAvvgRlwTFDU+/cCDD5UKAqCyT02MeqYRGHu
	 dK8VaO0IlEOVAcFDFWwL6/MWk410YinV5EMq1hmrT3cNb/q8mCk3niN7docqetXaeM
	 qJgf33RV/hWTiTib1d70RaBPcdqBUk2PEHzxrgBldyk3V1V/wgqYHPO2c/Jiz2utRA
	 MaKVDnNFXA9jA==
Date: Sat, 9 May 2026 13:58:00 +0200
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
Subject: Re: [PATCH net-next v4 08/10] net: airoha: Do not stop GDM port if
 it is shared
Message-ID: <af8hSCcd2GyfbeuE@lore-desk>
References: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
 <20260507-airoha-eth-multi-serdes-v4-8-af613b61ae02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f/l86ZsPISNBd6cb"
Content-Disposition: inline
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-8-af613b61ae02@kernel.org>
X-Rspamd-Queue-Id: 7E2EE4FF83B
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
	TAGGED_FROM(0.00)[bounces-286163-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--f/l86ZsPISNBd6cb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Theoretically, in the current codebase, two independent net_devices can
> be connected to the same GDM port so we need to check the GDM port is not
> used by any other running net_device before setting the forward
> configuration to FE_PSE_PORT_DROP.
>=20
> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 36 +++++++++++++++++++++++++-=
------
>  drivers/net/ethernet/airoha/airoha_eth.h |  2 ++
>  2 files changed, 30 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 0253919714e0..1c4927c1aeb0 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1714,8 +1714,8 @@ static int airoha_dev_open(struct net_device *netde=
v)
>  	int err, len =3D ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
> +	u32 cur_len, pse_port =3D FE_PSE_PORT_PPE1;
>  	struct airoha_qdma *qdma =3D dev->qdma;
> -	u32 pse_port =3D FE_PSE_PORT_PPE1;
> =20
>  	netif_tx_start_all_queues(netdev);
>  	err =3D airoha_set_vip_for_gdm_port(dev, true);
> @@ -1729,10 +1729,14 @@ static int airoha_dev_open(struct net_device *net=
dev)
>  		airoha_fe_clear(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
>  				GDM_STAG_EN_MASK);
> =20
> -	airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
> -		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> -		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> -		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> +	cur_len =3D airoha_fe_get(qdma->eth, REG_GDM_LEN_CFG(port->id),
> +				GDM_LONG_LEN_MASK);
> +	if (!atomic_read(&port->users) || len > cur_len)
> +		airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
> +			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> +			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> +			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> +	atomic_inc(&port->users);
> =20
>  	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
>  			GLOBAL_CFG_TX_DMA_EN_MASK |
> @@ -1762,8 +1766,12 @@ static int airoha_dev_stop(struct net_device *netd=
ev)
>  	for (i =3D 0; i < netdev->num_tx_queues; i++)
>  		netdev_tx_reset_subqueue(netdev, i);
> =20
> -	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
> -				    FE_PSE_PORT_DROP);
> +	if (atomic_dec_and_test(&port->users)) {
> +		airoha_set_vip_for_gdm_port(dev, false);
> +		airoha_set_gdm_port_fwd_cfg(qdma->eth,
> +					    REG_GDM_FWD_CFG(port->id),
> +					    FE_PSE_PORT_DROP);
> +	}
> =20
>  	if (atomic_dec_and_test(&qdma->users)) {
>  		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> @@ -1915,10 +1923,22 @@ static void airoha_dev_get_stats64(struct net_dev=
ice *netdev,
>  static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	u32 cur_len, len =3D ETH_HLEN + mtu + ETH_FCS_LEN;
>  	struct airoha_gdm_port *port =3D dev->port;
> -	u32 len =3D ETH_HLEN + mtu + ETH_FCS_LEN;
>  	struct airoha_eth *eth =3D dev->eth;
> =20
> +	cur_len =3D airoha_fe_get(eth, REG_GDM_LEN_CFG(port->id),
> +				GDM_LONG_LEN_MASK);
> +	if (len < cur_len) {
> +		u8 port_refcnt =3D atomic_read(&port->users);
> +
> +		/* We can decrease the device MTU just if the GDM port is
> +		 * not shared or if the other device is not running.
> +		 */
> +		if (port_refcnt > 1 || (port_refcnt && !netif_running(netdev)))
> +			return -EBUSY;
> +	}
> +
>  	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
>  		      GDM_LONG_LEN_MASK,
>  		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 207c75152fde..3a313ac439e7 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -553,6 +553,8 @@ struct airoha_gdm_port {
>  	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
>  	int id;
> =20
> +	atomic_t users;
> +
>  	struct airoha_hw_stats stats;
> =20
>  	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
>=20
> --=20
> 2.54.0
>=20

Commenting on shashiko report:
https://sashiko.dev/#/patchset/20260507-airoha-eth-multi-serdes-v4-0-af613b=
61ae02%40kernel.org

- Is this call to airoha_set_vip_for_gdm_port() redundant?
  Looking at airoha_dev_stop(), airoha_set_vip_for_gdm_port(dev, false) is
  already called unconditionally earlier in the function. Since get_vip_por=
t()
  returns a device-specific bitmask based on dev->nbq, does the uncondition=
al
  call correctly clear the hardware bits for the specific device being stop=
ped
  without affecting other devices on the same shared port?
  - I will fix it in v5.

- Does returning -EBUSY here improperly prevent valid software MTU configur=
ations?=20
  Instead of failing the ndo_change_mtu callback and preventing the software
  netdev->mtu from updating, should this code unconditionally allow the sof=
tware
  update (netdev->mtu =3D mtu) and simply skip the hardware register
  (REG_GDM_LEN_CFG) downgrade to safely preserve the larger hardware limit
  required by active shared siblings?
  - I will fix it in v5.

- Is the use of an atomic_t necessary for tracking users here?
  The port->users reference count appears to only be modified in ndo_open a=
nd
  ndo_stop, and read in ndo_change_mtu. Since all of these callback paths a=
re
  inherently strictly serialized by the kernel's rtnl_lock(), could a simple
  integer be used instead to avoid unnecessary atomic overhead?
  - I will fix it in v5.

--f/l86ZsPISNBd6cb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaf8hSAAKCRA6cBh0uS2t
rIAVAP40XN/xVxenB27WTAZQFLE3D1aOZEx4226QciUyPoghTAEA5Q+pwNyELBEQ
C2PWBhwiUFSdhonKXDUiPaijAreZyw4=
=IPQU
-----END PGP SIGNATURE-----

--f/l86ZsPISNBd6cb--

