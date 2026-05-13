Return-Path: <netdev+bounces-287522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI0GEYRWBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:46:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D81531944
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EC2B301A918
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082A73E95A8;
	Wed, 13 May 2026 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmyphwtr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD6379C2F;
	Wed, 13 May 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669183; cv=none; b=K/UvTWGGGjZ8yo1i9R2Kq1Vs9JjqxCDGGyMjTqUd7HtYcUM1QP2bFNAxeV4Rs+HEOZWOAAUDCkQY9tq5IsfjHeRBv6xilNfDSIyNsMxArD6a8a08ghObuvm+/iI7l7XixnN40yNUQYyptTDmOsk/gJK1H+1fWI9ptMYu9s1cpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669183; c=relaxed/simple;
	bh=S5jHqO9/OtD4Qp1sakoELifPOdsA247cnIKU/KM3hlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7QbgiYr7OLdIDd0y843Wz4RxKqdiue5pZ7nOaNYBReqroR9sSMIHhe/GMjPvVt1v2GUboBPILJg26V/idqg+pKxTAIqZKlixpaXsgr957Pi1CDc8EGsKYLCn1977kNnbwu1vWHn3Tzcn1rnSgLWJ2pYZzIZDkcJTe9I//cWU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmyphwtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3E0C2BCB7;
	Wed, 13 May 2026 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778669183;
	bh=S5jHqO9/OtD4Qp1sakoELifPOdsA247cnIKU/KM3hlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmyphwtrrjECq+DIfxVwN99APzgOZFjBQzM/sEWKBQNIB4CklodqhHMMwbOgiKYzv
	 dCLz5kRsRAHzfordRV7VdVMooN0Dho4MZDstnA1goecgm6KLrXT6FgOeSnTU6WEj9G
	 3MkvMpcs4Z4CdgzuviAp2z7PihAvLccf6LLaSXS4L+ygaHXGbxkIgGuNCp9rbSAjx7
	 s0Tzye6fAnwOv+7FjO9901t2bc+e2D2zhsV9s+WN5xasNgDYjg/H/qRlsfveuxPok8
	 lazmR/w8YYfZ9KCHcTnQWVZ9Rqllrr0wZS98ofiCM2HQ9eT5g3rUWT5LzWro1B9fYr
	 iDqHQWsfiTTFQ==
Date: Wed, 13 May 2026 12:46:21 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 12/12] net: airoha: Better handle MIB for GDM
 with multiple port attached
Message-ID: <agRWfSghLZGeMVOc@lore-desk>
References: <20260511-airoha-eth-multi-serdes-v6-12-c899462c4f75@kernel.org>
 <20260512233205.7CA40C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vN0T/RtPM7tQgdoY"
Content-Disposition: inline
In-Reply-To: <20260512233205.7CA40C2BCB0@smtp.kernel.org>
X-Rspamd-Queue-Id: 84D81531944
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287522-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action


--vN0T/RtPM7tQgdoY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] The RUNT_CNT statistic is overwritten and lost due to incorrect =
assignment logic.
> - [High] 32-bit free-running hardware statistics will wrap around and res=
et 64-bit software counters to zero.
> - [High] Torn hardware reads on 64-bit registers due to free-running coun=
ters.
> - [High] Pre-existing potential deadlock due to using `spin_lock()` inste=
ad of `spin_lock_bh()` for stats lock.
> --
>=20
> commit 2f0d0c633539afc37cceb4ad426afb56465e7b6d
> Author: Christian Marangi <ansuelsmth@gmail.com>
> Subject: net: airoha: Better handle MIB for GDM with multiple port attach=
ed
>=20
> The commit enables the split MIB feature for GDM3 and GDM4, moving stats
> from port to device, and modifying the stats update logic from clear-on-r=
ead
> to direct assignment since the MIB clear was removed.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 533ffe20f8333..27ccc636d8009 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1621,143 +1621,146 @@ static void airoha_update_hw_stats(struct air=
oha_gdm_dev *dev)
> >  	struct airoha_eth *eth =3D dev->eth;
> >  	u32 val, i =3D 0;
> > =20
> > -	spin_lock(&port->stats.lock);
> > -	u64_stats_update_begin(&port->stats.syncp);
> > +	spin_lock(&port->stats_lock);
>=20
> This isn't a bug introduced by this patch, but could this spin_lock()
> cause a deadlock? Since airoha_update_hw_stats() is called by
> ndo_get_stats64() (which can run in softirq context) and ethtool
> callbacks (which run in process context), a softirq could interrupt the
> process context and spin forever trying to acquire the same lock. Should
> this be spin_lock_bh()?

ndo_get_stats64() does not run in softirq context.

>=20
> > +	u64_stats_update_begin(&dev->stats.syncp);
> > +
> > +	/* Read relevant MIB for GDM with multiple port attached */
> > +	if (port->id =3D=3D AIROHA_GDM3_IDX || port->id =3D=3D AIROHA_GDM4_ID=
X)
> > +		airoha_fe_rmw(eth, REG_FE_GDM_MIB_CFG(port->id),
> > +			      FE_TX_MIB_ID_MASK | FE_RX_MIB_ID_MASK,
> > +			      FIELD_PREP(FE_TX_MIB_ID_MASK, dev->nbq) |
> > +			      FIELD_PREP(FE_RX_MIB_ID_MASK, dev->nbq));
> > =20
> >  	/* TX */
> >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
> > -	port->stats.tx_ok_pkts +=3D ((u64)val << 32);
> > +	dev->stats.tx_ok_pkts =3D (u64)val << 32;
> >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
> > -	port->stats.tx_ok_pkts +=3D val;
>=20
> Now that the hardware counters are free-running (the MIB clear operation
> was removed later in the patch), can a torn read occur here? If the low
> 32-bit register overflows and increments the high 32-bit register in the
> brief window between the two reads, the resulting 64-bit value will be
> corrupted and off by ~4.29 billion.

ack, I will fit it in v7.

>=20
> [ ... ]
> >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
> > -	port->stats.tx_drops +=3D val;
> > +	dev->stats.tx_drops =3D val;
>=20
> Since TX_ETH_DROP_CNT is a 32-bit hardware register and the MIB clear
> operation is removed, the hardware counter will eventually wrap back to
> zero. By assigning it directly to dev->stats.tx_drops, won't this
> cause the 64-bit software counter to also silently drop back to zero and
> violate the monotonically increasing requirement of ndo_get_stats64?
> Does this need to calculate the delta instead of directly assigning the
> value?

ack, I will fit it in v7.

>=20
> [ ... ]
> >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
> > -	port->stats.tx_len[i] +=3D val;
> > +	dev->stats.tx_len[i] =3D val;
> > =20
> >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
> > -	port->stats.tx_len[i] +=3D ((u64)val << 32);
> > +	dev->stats.tx_len[i] =3D (u64)val << 32;
> >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
> > -	port->stats.tx_len[i++] +=3D val;
>=20
> Does this overwrite the RUNT_CNT statistic? The code assigns RUNT_CNT
> to tx_len[i] (where i=3D0), but immediately overwrites it with
> E64_CNT_H at the same index because i is not incremented between
> the assignments.

ack, I will fit it in v7.

>=20
> [ ... ]
> >  	i =3D 0;
> >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
> > -	port->stats.rx_len[i] +=3D val;
> > +	dev->stats.rx_len[i] =3D val;
> > =20
> >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
> > -	port->stats.rx_len[i] +=3D ((u64)val << 32);
> > +	dev->stats.rx_len[i] =3D (u64)val << 32;
> >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
> > -	port->stats.rx_len[i++] +=3D val;
>=20
> Does this also overwrite the RUNT_CNT statistic for the RX path in the
> same way?

ack, I will fit it in v7.

Regards,
Lorenzo

>=20
> [ ... ]
> > -	/* reset mib counters */
> > -	airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(port->id),
> > -		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
> > +	dev->stats.rx_len[i++] =3D val;
> > =20
> > -	u64_stats_update_end(&port->stats.syncp);
> > -	spin_unlock(&port->stats.lock);
> > +	u64_stats_update_end(&dev->stats.syncp);
> > +	spin_unlock(&port->stats_lock);
> >  }
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260511-airoha-eth-=
multi-serdes-v6-0-c899462c4f75@kernel.org?part=3D12

--vN0T/RtPM7tQgdoY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagRWfQAKCRA6cBh0uS2t
rHRvAQDvhwEDz38SNHFl39yZrO6NXNUyv0ET+x02j6VV3qobLgD/cudIa265P1iZ
NloiPq14rbXxC/WzJq7r3oLA/0hQJA8=
=y+s9
-----END PGP SIGNATURE-----

--vN0T/RtPM7tQgdoY--

