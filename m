Return-Path: <netdev+bounces-300053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u+3oI+ZFMmpMxwUAu9opvQ
	(envelope-from <netdev+bounces-300053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D577769700C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:59:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D6dXz3bb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300053-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300053-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71F28302796F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169DC3B9608;
	Wed, 17 Jun 2026 06:58:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1678B3B71D7
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:58:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679521; cv=none; b=VCOti0zzaHOOC0t62A8lhIziZY6+Lo58e2ElqcQyv24V+p6S9DKC4Q2yTILrmzvJ7qvQHhFr6A52aw0ZD71fFZpRpeR3bxoc9ZGp+uXvOmfKG6Lvr3ifKOCkK4/gHDCGSmmzKs897oltfxUz9zwUWrhwDAh7/Yid6S5wQXu0kuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679521; c=relaxed/simple;
	bh=O2jVcYMcGIeMtvGNdmM4iInvaKSacqWy0dRq7t0bH5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/iJfaI0opQHt57WgcjO9wC1sRlYiA22SYhWMFVEl2F8tZ8rOlw+r7Keknb5mYJWsUsvo1Y3g+AsiJnXkCq4+PIdskf9BDiN99mloXDNAcPWICNHM1d80kk5Tx08S3BVXtCLnSc2ydjkj9JDm85l6Zw0VTmJqBErl7y0i9PAvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6dXz3bb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C171F000E9;
	Wed, 17 Jun 2026 06:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781679519;
	bh=n9YBolv+gzQ7HhE0xK39SkRKgHgeZglk5MjU3GOUQ/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D6dXz3bbM8MjoqY3y3YE07w2Xj698HV93s818L5A1a0vkH+TL/F/m3W2SKgwkljwB
	 SgfDtQ0jtNCs6UYRSrrLT5MKTeZ3CPwgzJPr5k8Z1fllD/ny0i2UN2XG6yn0/dIYMD
	 vG9EqTLnoA8MJJXgaAE0UYK2tXMcll9D0OdkDJUdyEpeAGSsyqBAKrAYw0bKKMMy2l
	 inTOMJE/C3Nj4Rf8VKsYSkHAPLjWvZoVP2h3Ar1gFS6XPsnO+A8GfE3jvwyY+KbOgS
	 ju6P40Q2NhJLmDdGZcAUmhHYX/VXh1EwgyazuxQnoGFc7hOh47a+n8R0wDj5KpCqhK
	 7B1ffH4O+r8Sw==
Date: Wed, 17 Jun 2026 08:58:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_ppe: Fix rhashtable leak in
 mtk_ppe_init error paths
Message-ID: <ajJFnBsnyoSeKl1D@lore-desk>
References: <178167550101.2217645.14579307712717502425@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8NDJ4ufy8ArQzYca"
Content-Disposition: inline
In-Reply-To: <178167550101.2217645.14579307712717502425@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300053-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D577769700C


--8NDJ4ufy8ArQzYca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In mtk_ppe_init(), when accounting is enabled, the error paths for
> dmam_alloc_coherent(mib) and devm_kzalloc(acct) failures return NULL
> directly, bypassing the err_free_l2_flows label that destroys the
> rhashtable initialized earlier.
>=20
> While this leak only occurs during probe (not runtime) and the leaked
> memory is minimal (an empty rhash table), fixing it ensures proper
> error path cleanup consistency.
>=20
> Fix by changing the two return NULL statements to goto err_free_l2_flows.
>=20
> Fixes: 603ea5e7ffa7 ("net: ethernet: mtk_eth_soc: fix memory leak in erro=
r path")
> Signed-off-by: Wayen Yan <win847@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/mediatek/mtk_ppe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethern=
et/mediatek/mtk_ppe.c
> index 18279e2a70..8451dc3fd0 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
> @@ -918,7 +918,7 @@ struct mtk_ppe *mtk_ppe_init(struct mtk_eth *eth, voi=
d __iomem *base, int index)
>  		mib =3D dmam_alloc_coherent(ppe->dev, MTK_PPE_ENTRIES * sizeof(*mib),
>  					  &ppe->mib_phys, GFP_KERNEL);
>  		if (!mib)
> -			return NULL;
> +			goto err_free_l2_flows;
> =20
>  		ppe->mib_table =3D mib;
> =20
> @@ -926,7 +926,7 @@ struct mtk_ppe *mtk_ppe_init(struct mtk_eth *eth, voi=
d __iomem *base, int index)
>  				    GFP_KERNEL);
> =20
>  		if (!acct)
> -			return NULL;
> +			goto err_free_l2_flows;
> =20
>  		ppe->acct_table =3D acct;
>  	}
> --=20
> 2.51.0
>=20
>=20

--8NDJ4ufy8ArQzYca
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajJFnAAKCRA6cBh0uS2t
rI0aAPwM2odjog7hQypO1g2W6YBDDYMmzP5yW+nhVPnoN4SFPAD/RUOnP+tpmTPx
yLojKc99Vrm8lkiLh6lj+hu3m/WI5ws=
=srBO
-----END PGP SIGNATURE-----

--8NDJ4ufy8ArQzYca--

