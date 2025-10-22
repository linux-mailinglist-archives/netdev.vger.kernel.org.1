Return-Path: <netdev+bounces-231560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BC9BFA8B2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3862A4F1FB0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9E92F7AA7;
	Wed, 22 Oct 2025 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElS/csoG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13451E8320;
	Wed, 22 Oct 2025 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118132; cv=none; b=pzU1jFhslz7nInhtXaKI1ihf1OEwt5L40Ij2g9r1g+ZCfPeKljRPZ7ZhJtA4XPusARDdUb+s01z4nFKP8DumKiFs5uSSCnJMcQ2BDMYuqxasHiRQDohnTLhADxCXQi34OJ9mq85QM6uduYA3J96oy+CJ140es/4yQ4MR0Fb9u6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118132; c=relaxed/simple;
	bh=wky3URqf3O2vjJEMF4Q+odzCED58MXfczjQc4betxSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/jimRWt6bMB6i4yF3bJkKimcerqdnwbrTQKCQPbaKfr6byjvhNF088vC/5jVE6Vc2BLcCxdEeaBW3EPAQNKhEojwGRZJJX71OFvBegd4JddWsSlD00RnA8YRdMtR/4COJdEC4P361UflGCfeUYSoGwhFWrwXq24mykYiy0Cibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElS/csoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD65FC4CEE7;
	Wed, 22 Oct 2025 07:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761118132;
	bh=wky3URqf3O2vjJEMF4Q+odzCED58MXfczjQc4betxSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElS/csoGEHpJmV/kJZ7zuPyLrDswCqt9GQnk/p6LWrUGFIBhTPs5gFJ7NST0aJSZy
	 z/fkns0R+F7yEV6KvABFJPZ+Wci6G/nJ3op+4NcvOVypo660UhZQiLx9qkuScOZkXt
	 Qty5ROWtQvqJhun7JmenYfNWYgCiSDqKS1W8hMWRjh4L9Vf1CmnZ/a84giCfADKpXw
	 vUKTOZXNal36pWO6VqQUSwNR7YmQ/axf4nIq/zljJZj7GtuDWP5k3jOZVoQymg+RzK
	 nk+0oyfRN7OTXapqGzcXMsjbe5zrIMO1GwaTBxa2oO3C8vYNkgjgJmH23vDRCxxHB1
	 1ZJnm5Hm3zMiw==
Date: Wed, 22 Oct 2025 09:28:49 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] net: airoha: add phylink support for GDM1
Message-ID: <aPiHsYquV0NEc8zc@lore-desk>
References: <20251021193315.2192359-1-ansuelsmth@gmail.com>
 <20251021193315.2192359-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kazh4dQb53u+N7RG"
Content-Disposition: inline
In-Reply-To: <20251021193315.2192359-3-ansuelsmth@gmail.com>


--kazh4dQb53u+N7RG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  				 struct device_node *np, int index)
>  {
> @@ -2931,19 +2995,30 @@ static int airoha_alloc_gdm_port(struct airoha_et=
h *eth,
>  	port->id =3D id;
>  	eth->ports[p] =3D port;
> =20
> -	err =3D airoha_metadata_dst_alloc(port);
> -	if (err)
> -		return err;
> +	return airoha_metadata_dst_alloc(port);
> +}
> =20
> -	err =3D register_netdev(dev);
> -	if (err)
> -		goto free_metadata_dst;
> +static int airoha_register_gdm_ports(struct airoha_eth *eth)
> +{
> +	int i;
> =20
> -	return 0;
> +	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> +		struct airoha_gdm_port *port =3D eth->ports[i];
> +		int err;
> =20
> -free_metadata_dst:
> -	airoha_metadata_dst_free(port);
> -	return err;
> +		if (!port)
> +			continue;
> +
> +		err =3D airoha_setup_phylink(port->dev);
> +		if (err)
> +			return err;
> +
> +		err =3D register_netdev(port->dev);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> =20
>  static int airoha_probe(struct platform_device *pdev)
> @@ -3034,6 +3109,10 @@ static int airoha_probe(struct platform_device *pd=
ev)
>  		}
>  	}
> =20
> +	err =3D airoha_register_gdm_ports(eth);

is there any specific reason we need to alloc all netdevs before registering
the given phylink? I guess you can just do it in airoha_alloc_gdm_port(),
right?

Regards,
Lorenzo

> +	if (err)
> +		goto error_napi_stop;
> +
>  	return 0;
> =20
>  error_napi_stop:
> @@ -3047,10 +3126,14 @@ static int airoha_probe(struct platform_device *p=
dev)
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> =20
> -		if (port && port->dev->reg_state =3D=3D NETREG_REGISTERED) {
> +		if (!port)
> +			continue;
> +
> +		if (port->dev->reg_state =3D=3D NETREG_REGISTERED) {
>  			unregister_netdev(port->dev);
> -			airoha_metadata_dst_free(port);
> +			phylink_destroy(port->phylink);
>  		}
> +		airoha_metadata_dst_free(port);
>  	}
>  	free_netdev(eth->napi_dev);
>  	platform_set_drvdata(pdev, NULL);
> @@ -3076,6 +3159,7 @@ static void airoha_remove(struct platform_device *p=
dev)
> =20
>  		airoha_dev_stop(port->dev);
>  		unregister_netdev(port->dev);
> +		phylink_destroy(port->phylink);
>  		airoha_metadata_dst_free(port);
>  	}
>  	free_netdev(eth->napi_dev);
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index eb27a4ff5198..c144c1ece23b 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -531,6 +531,9 @@ struct airoha_gdm_port {
>  	struct net_device *dev;
>  	int id;
> =20
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
> +
>  	struct airoha_hw_stats stats;
> =20
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> --=20
> 2.51.0
>=20

--kazh4dQb53u+N7RG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPiHsQAKCRA6cBh0uS2t
rCv/APwLqOVbfi/DsCOVxc0WBmL8YmDTSl9WyN+GAxmI89XOBgD+K69sz2/U+4uw
IJ5/VGNGbObQDMmPdHC4ZwXdx//AmgI=
=FUxz
-----END PGP SIGNATURE-----

--kazh4dQb53u+N7RG--

