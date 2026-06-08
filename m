Return-Path: <netdev+bounces-296416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UjWuMht/JmrxXQIAu9opvQ
	(envelope-from <netdev+bounces-296416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:36:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 422B56541F5
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:36:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jN3QtXTZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296416-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296416-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ECC5307A7DA
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548A3AEF3A;
	Mon,  8 Jun 2026 08:29:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101063AF670
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:29:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907372; cv=none; b=pi6cp0lPUSsIo7UioehxXik8Os3CD9HXIf2oYU4TJqXUs2gK83Kk7XJXqwaDizjj+Tlp3j30UbKTm+eV7mjJm9qhIYfV6KQ2CRZnss0/mBcTwKWDkwCyhiUSYKZlkDNF5zlmLLZ/lany88nDSEjW70Enu+t//eSJ7qTLwZBZwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907372; c=relaxed/simple;
	bh=pjrSC4vHSetszpuucpJnqub9tNaGcgJG28xSaZCtA4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTnv6ENT8bpunsPRvMKc2/ZAVQLxsIcvJhTcs3JWL8j3vEZoQ8PMaUbApULRmjuOIlp0qP0OQJBpXMee9N9EG+RmTWh93bV6+MTO100h68+cEgvOczGpIE/mePvlbh5xDZsg/R0kPAyd558dm0tpcefprH+0mNumqIgREIbkBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN3QtXTZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B4E1F00893;
	Mon,  8 Jun 2026 08:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907370;
	bh=icMiBGKDzjWCyjcMX0LyKBPzn4jDdScDbFEPljPmY3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jN3QtXTZr//HwrqBb09/0XT8XOhkeCfqb2DRYVXHdScx3yf9AsLB9fjgTqebcIwd4
	 BfME+lJ1kYJFULumDINdDGr6ENZ7MUQ7UO2q6SGY7+hfzIYXCV41y5uD0BJUyesfy3
	 2CfnfHV3kxT4ohmBkcxMYwN5glPawxoDTA/x3z86vfPQyhcZBsRPq8zxKyK0K8a0IV
	 LkolPxtL//k1wZfQPyHNBOIsvLOHCaaZO/ividOF2t/7AFbsVNgFmDCXiiSuGS6bcK
	 iKJqYk9l+e1jy3ATN/ixwihpqc6tt3is96YjebS8tsIKaN1glxGribl++n8AXKzkG/
	 ScqL7Uf1HVOgg==
Date: Mon, 8 Jun 2026 10:29:28 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: simplify WAN device check in
 airoha_dev_init()
Message-ID: <aiZ9aLsfc89dq9v8@lore-desk>
References: <20260606-airoha-eth-simplify-dev-init-v1-1-f08f8e404049@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vQUe/Ioj7I3PszYE"
Content-Disposition: inline
In-Reply-To: <20260606-airoha-eth-simplify-dev-init-v1-1-f08f8e404049@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296416-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 422B56541F5


--vQUe/Ioj7I3PszYE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> airoha_register_gdm_devices() iterates eth->ports[] in order, so GDM2's
> netdev is always registered before GDM3/GDM4. This means the explicit
> check for eth->ports[1] && eth->ports[1]->devs[0] is a redundant
> special-case of what airoha_get_wan_gdm_dev() already covers, since
> GDM2 is always marked as WAN during its own ndo_init.
> Remove the redundant check and rely solely on airoha_get_wan_gdm_dev()
> which handles both the GDM2-present and GDM2-absent cases.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Please drop this patch since I need to modify it to address Andrew's request
about LAN/WAN configuration.

Regards,
Lorenzo

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 5a8e84fa9918..b333a7b309c2 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2004,18 +2004,10 @@ static int airoha_dev_init(struct net_device *net=
dev)
> =20
>  	switch (port->id) {
>  	case AIROHA_GDM3_IDX:
> -	case AIROHA_GDM4_IDX: {
> -		struct airoha_eth *eth =3D dev->eth;
> -
> -		/* GDM2 supports a single net_device */
> -		if (eth->ports[1] && eth->ports[1]->devs[0])
> -			break;
> -
> -		if (airoha_get_wan_gdm_dev(eth))
> +	case AIROHA_GDM4_IDX:
> +		if (airoha_get_wan_gdm_dev(dev->eth))
>  			break;
> -
>  		fallthrough;
> -	}
>  	case AIROHA_GDM2_IDX:
>  		/* GDM2 is always used as wan */
>  		dev->flags |=3D AIROHA_PRIV_F_WAN;
>=20
> ---
> base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
> change-id: 20260606-airoha-eth-simplify-dev-init-5d53c7cc004e
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--vQUe/Ioj7I3PszYE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiZ9aAAKCRA6cBh0uS2t
rLcTAQCcIV8FMOBnL1whdLBuVU/v0KCYnQDJSmNx5YwbJvD7HgD9H5QXgRBA6qhL
yVJtngNaDdKxUD5cs6169k2izhlukQs=
=EWZk
-----END PGP SIGNATURE-----

--vQUe/Ioj7I3PszYE--

