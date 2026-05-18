Return-Path: <netdev+bounces-289176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BNqOOx9C2qOIQUAu9opvQ
	(envelope-from <netdev+bounces-289176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:00:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 479615739C9
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AFB0300916B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67CA38B149;
	Mon, 18 May 2026 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5mCG/9X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3910371CEC;
	Mon, 18 May 2026 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137954; cv=none; b=Ej1fE4KnuJKVqCHz37//m8x1UFI8CjBOXaDGWtly8wlFKqtR8DNLzvHAO6cWOFAdWdjQVuK9xzs1xE5Jpo9IoZi+5Y0wSh1bqVooFnIN7n4Mo2F2G70xgBsTmmGwP3JjV+gr6sapByhGDmxpZUPxKdzedV4xAlggwfDfGHiHYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137954; c=relaxed/simple;
	bh=lO7cK/BdKDswb57EujED7Mp/I6vQbg0rlmtGY4RNQMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4ekJAr6HZiE3H5YUcd0NWzn6P8S/twxTnnvKxXQ5+iXGj6aRwcDrPuuiGJqgj05YbcjZFs/OnFTAhd5kT36dEzzOhSa7MZJwp05orbqgsvUHqjWcwemT56963td5CmkkF3MaKj5nNxACK4Uz13rtiaAWWpSlKuhAE8zdWQkmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5mCG/9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF85BC2BCB7;
	Mon, 18 May 2026 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779137954;
	bh=lO7cK/BdKDswb57EujED7Mp/I6vQbg0rlmtGY4RNQMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5mCG/9X8XK4N9oT6M0Kj1mPdrW/JIjhOp/TTpr53pul2Fa7pNEknOxnaSbmUucJa
	 5UZpMQ0oWt++Y9uD7Ws+HDNeEnqUGqsFwH6/hGGaYzpLyaGhZXu+/CYI3+9Ocd/LTH
	 Rq1zNAPVHF3Cebone50LSS38Veb8MhgwbBGGxOGcllL8H1aS7oTLlWDJXPPheCe5QL
	 l1qqKSeTg0G2UQ2sqDxzvGgXgD8QF8hzF+a38l3OXlYrOJd4RiYh7GIyMai4JDK3Nx
	 CEplR/PpPQem9D6kT8zfh/qUR+ovZQsNo2vSY0RNIfZB5bAlk/xi9txb6AStZ8/wdg
	 vP/Vqc5mBRQGg==
Date: Mon, 18 May 2026 22:59:11 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 02/10] net: airoha: Introduce airoha_gdm_dev
 struct
Message-ID: <agt9n4qF3hyardCB@lore-desk>
References: <20260516-airoha-eth-multi-serdes-v7-2-99e0093303e2@kernel.org>
 <20260517055812.CEC33C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I5Ic1VMvRwYsDD/n"
Content-Disposition: inline
In-Reply-To: <20260517055812.CEC33C2BCB0@smtp.kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289176-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 479615739C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--I5Ic1VMvRwYsDD/n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] The patch introduces a race condition exposing a partially initi=
alized port, leading to a NULL pointer dereference in NAPI polling handlers.
> - [High] The `airoha_get_dsa_tag` function lacks packet length validation=
 before stripping the MTK DSA tag, leading to an out-of-bounds memory acces=
s and `skb->len` integer underflow.
> --
>=20
> commit 3474bcc37d20c84839dc4e74bab44197a0507f51
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Introduce airoha_gdm_dev struct
>=20
> This commit introduces the airoha_gdm_dev structure to collect net_device
> related info, preparing the driver for a 1:n relationship between GDM por=
ts
> and net_devices.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 5a027cc7ffcb1..3ca0dbd19275a 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> > @@ -2007,7 +2020,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff=
 *skb,
> >  	u8 fport;
> > =20
> >  	qid =3D airoha_qdma_get_txq(qdma, skb_get_queue_mapping(skb));
> > -	tag =3D airoha_get_dsa_tag(skb, dev);
> > +	tag =3D airoha_get_dsa_tag(skb, netdev);
>=20
> While looking at this patch, I noticed an issue in airoha_get_dsa_tag() t=
hat
> pre-exists in the code. Does this function lack packet length validation
> before pulling the MTK DSA tag?
>=20
> airoha_get_dsa_tag() unconditionally performs memmove() and __skb_pull():
>=20
>         memmove(skb->data + MTK_HDR_LEN, skb->data, 2 * ETH_ALEN);
>         __skb_pull(skb, MTK_HDR_LEN);
>=20
> If an unprivileged user sends an undersized packet via a raw socket
> (AF_PACKET), could this result in an out-of-bounds memory access and cause
> skb->len to integer-underflow?
>=20
> This could lead to dma_map_single() attempting to map a massive amount of
> memory, potentially causing an IOMMU fault and a local denial-of-service.

As already pointed out, this does not seem an issue.

>=20
> [ ... ]
>=20
> > @@ -2975,53 +3060,22 @@ static int airoha_alloc_gdm_port(struct airoha_=
eth *eth,
> >  		return -EINVAL;
> >  	}
> > =20
> > -	dev =3D devm_alloc_etherdev_mqs(eth->dev, sizeof(*port),
> > -				      AIROHA_NUM_NETDEV_TX_RINGS,
> > -				      AIROHA_NUM_RX_RING);
> > -	if (!dev) {
> > -		dev_err(eth->dev, "alloc_etherdev failed\n");
> > +	port =3D devm_kzalloc(eth->dev, sizeof(*port), GFP_KERNEL);
> > +	if (!port)
> >  		return -ENOMEM;
>=20
> [ ... ]
>=20
> > -	port =3D netdev_priv(dev);
> >  	u64_stats_init(&port->stats.syncp);
> >  	spin_lock_init(&port->stats.lock);
> > -	port->eth =3D eth;
> > -	port->dev =3D dev;
> >  	port->id =3D id;
> >  	/* XXX: Read nbq from DTS */
> >  	port->nbq =3D id =3D=3D AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : =
0;
> >  	eth->ports[p] =3D port;
> > =20
> > -	return airoha_metadata_dst_alloc(port);
> > +	err =3D airoha_metadata_dst_alloc(port);
> > +	if (err)
> > +		return err;
> > +
> > +	return airoha_alloc_gdm_device(eth, port, np);
> >  }
>=20
> Could an interrupt cause a NULL pointer dereference in the NAPI handlers?
>=20
> Since NAPI is enabled earlier in airoha_probe() via airoha_qdma_start_nap=
i(),
> and eth->ports[p] is assigned here before airoha_alloc_gdm_device() popul=
ates
> port->dev, NAPI handlers like airoha_qdma_rx_process() could see a NULL
> port->dev:
>=20
> airoha_qdma_rx_process()
>         ...
>         port =3D eth->ports[p];
>         netdev =3D port->dev->dev;
>=20
> I note that this issue is fixed later in the series by commit 68e8fa8fe02=
24
> ("net: airoha: Support multiple net_devices for a single FE GDM port"), w=
hich
> changes port->dev to an array and adds proper NULL checks.

ack, I will fix it in v8.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260516-airoha-eth-=
multi-serdes-v7-0-99e0093303e2@kernel.org?part=3D2

--I5Ic1VMvRwYsDD/n
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagt9nwAKCRA6cBh0uS2t
rBeLAQCdlm/QAuyNFWuTfclaOJkPj3v/jYi7gcrxxPmerVRw1QD9EL4eO6LNj9Rk
bDp2khdOoGbazmqN+YdLfTX70ZT5IAI=
=t9f+
-----END PGP SIGNATURE-----

--I5Ic1VMvRwYsDD/n--

