Return-Path: <netdev+bounces-304896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z/YkIoVnS2prQwEAu9opvQ
	(envelope-from <netdev+bounces-304896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 10:29:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 436D370E1A7
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 10:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lu3lTHlD;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304896-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304896-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC21E30800F4
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9874E3ED5C9;
	Mon,  6 Jul 2026 08:03:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FE3D332C
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 08:03:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324988; cv=none; b=PdWsu+/L/Se1EMxUvskLuBrR5V+7fTX+natAXwO7Y1qeNgFwXeikwtVi+xBASd6CcjYusl81+dHCMwGxbdHoGKS4c0Gw+d0ZPL4fkUTDuyPILA8g97UWjD+HXGqleEugAar1ThQPhh9sfeLrkxvvIQshVNuBhKuDpX+j5vGvJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324988; c=relaxed/simple;
	bh=FHyDp56dJrfW2ikeN+Mol4v/04WogQDfMUueFzA3BN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm9c9yrk/lXV5Ra6E68mqjTG+q8DlAlFb1WnW4Yf0t+vcZWdsRrdNCnODIvU5lhWeAQuIVCwclDybQHZxa0XVUMQNXYt8mAO35o7tEO3DAVB2uk31XCf7VwkJJjruYU/5GyKUWYsmXD7nuAPrd3ypOPBICrKho9BVnksfey6Gzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu3lTHlD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DC91F000E9;
	Mon,  6 Jul 2026 08:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783324982;
	bh=GKty3BnTs9lhufSDTSMNeVknGjo/e/FTm30CuVSO0SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lu3lTHlD1sEPJOzpw5uK/YLPW1dXxZk+4SELaJIDe8m74CGxzqfdui8jqXQCtbT5m
	 1VpUmeusLoCmn46sNj/T9CCUUVcq9V0fNatnPkUZsbUQO8PSr+ERZg+RExYoi1Ys/n
	 /x0pmXR1gj3PDq9AGrqmPUJYrMHGeHth8tKrc2JRKgFE1DPIqZAfZbOaEXxlGl4piZ
	 jSnKx5oRLpCOC0kKkoQQmdL1zv32n0QrxXoaVbg2fS462y6ZcqVS767hUteUIt460K
	 IylqmFYraoGDgy4+6bgqUT70bNh648oW6YPktJGJtwrpzsXYeEJu1KDgMZn6P3w4Mr
	 Rlh6+/kt0ZYPQ==
Date: Mon, 6 Jul 2026 10:02:59 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: fix HTB class modification offload
Message-ID: <akthM-O5eea52MN6@lore-desk>
References: <178332096675.2250671.599544331813347302@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OZRxGIyhvtcgNsPb"
Content-Disposition: inline
In-Reply-To: <178332096675.2250671.599544331813347302@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304896-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 436D370E1A7


--OZRxGIyhvtcgNsPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> HTB core does not populate parent_classid for TC_HTB_NODE_MODIFY.
> Airoha currently checks parent_classid against TC_HTB_CLASSID_ROOT
> in a helper shared by both TC_HTB_LEAF_ALLOC_QUEUE and
> TC_HTB_NODE_MODIFY. Since the modify path leaves parent_classid as
> zero, the check always fails and changing parameters of an already
> offloaded HTB class is rejected with -EINVAL.
>=20
> Move the root-parent check into the allocation path and validate
> modify requests using the per-netdev QoS channel bitmap, consistent
> with the delete and query paths.
>=20
> Fixes: ef1ca9271313 ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Wayen Yan <win847@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 32 +++++++++++++++++-------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 59001fd4b6f7..8e4e79c1e4c2 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2766,18 +2766,13 @@ static int airoha_qdma_set_tx_rate_limit(struct n=
et_device *netdev,
>  	return 0;
>  }
> =20
> -static int airoha_tc_htb_modify_queue(struct net_device *dev,
> -				      struct tc_htb_qopt_offload *opt)
> +static int airoha_tc_htb_set_rate(struct net_device *dev,
> +				  struct tc_htb_qopt_offload *opt,
> +				  u32 channel)
>  {
> -	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>  	u32 rate =3D div_u64(opt->rate, 1000) << 3; /* kbps */
>  	int err;
> =20
> -	if (opt->parent_classid !=3D TC_HTB_CLASSID_ROOT) {
> -		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
> -		return -EINVAL;
> -	}
> -
>  	err =3D airoha_qdma_set_tx_rate_limit(dev, channel, rate, opt->quantum);
>  	if (err)
>  		NL_SET_ERR_MSG_MOD(opt->extack,
> @@ -2786,6 +2781,20 @@ static int airoha_tc_htb_modify_queue(struct net_d=
evice *dev,
>  	return err;
>  }
> =20
> +static int airoha_tc_htb_modify_queue(struct net_device *netdev,
> +				      struct tc_htb_qopt_offload *opt)
> +{
> +	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +
> +	if (!test_bit(channel, dev->qos_sq_bmap)) {
> +		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
> +		return -EINVAL;
> +	}
> +
> +	return airoha_tc_htb_set_rate(netdev, opt, channel);
> +}
> +
>  static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
>  					  struct tc_htb_qopt_offload *opt)
>  {
> @@ -2794,6 +2803,11 @@ static int airoha_tc_htb_alloc_leaf_queue(struct n=
et_device *netdev,
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_qdma *qdma =3D dev->qdma;
> =20
> +	if (opt->parent_classid !=3D TC_HTB_CLASSID_ROOT) {
> +		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
> +		return -EINVAL;
> +	}
> +
>  	/* Here we need to check the requested QDMA channel is not already
>  	 * in use by another net_device running on the same QDMA block.
>  	 */
> @@ -2803,7 +2817,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct ne=
t_device *netdev,
>  		return -EBUSY;
>  	}
> =20
> -	err =3D airoha_tc_htb_modify_queue(netdev, opt);
> +	err =3D airoha_tc_htb_set_rate(netdev, opt, channel);
>  	if (err)
>  		goto error;
> =20
> --=20
> 2.51.0
>=20
>=20

--OZRxGIyhvtcgNsPb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakthMwAKCRA6cBh0uS2t
rCsVAP9ljiYxppsaJlJwomZ/UOwoDuMalWAJaceTn3CY52YtOAEAvEBOKojmVRKo
J73Vkun+MpMLw7kl/M1eNbTqkV5F+wA=
=T5aZ
-----END PGP SIGNATURE-----

--OZRxGIyhvtcgNsPb--

