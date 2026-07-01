Return-Path: <netdev+bounces-303490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R+98Nae5RGp/zgoAu9opvQ
	(envelope-from <netdev+bounces-303490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:54:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5F66EA5C1
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:54:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="lazT/QJg";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303490-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303490-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 637C2304353A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 06:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176F93AD526;
	Wed,  1 Jul 2026 06:51:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE93AEB2D;
	Wed,  1 Jul 2026 06:51:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888696; cv=none; b=O6ZcXd9zmx3184e3YoGt7BQbxQ2cjdjgRliknlDxPVqonJZ3II/0VMU11zEj2OsMmH2BpzpbPrf/Kz+VJ34bo3myUrUaIecycf/80McqagtdCwb2uMjHbo1NfIgXBWK9EKjqmQ0wb2iDpxQiGVlDVVx0Jub/iYNcQABGCZ883vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888696; c=relaxed/simple;
	bh=5rvVYN/xojRPEII974MDLnp46Xsd+1gPMNjEJ/wc3rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZcAgZ4b3VUGx6Y+NMJRhVg/tFDMAl0zPJmDtBdfBJzGQ64Ngp64bDxqNbNiCXjmLunSJr+oiZ2Tl5/xCeL2uvHn1ZWQpyLZ/quSKGp+d95T1LFiPO6WE6ZBvDT4NKcJM8mM8NeICvFGPvRtSNyLYNOm2UDFhhPgokvz/yADsK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lazT/QJg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9CB1F000E9;
	Wed,  1 Jul 2026 06:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782888694;
	bh=PiCN0XbHNxL3wiS2C15r2mhEdbBCiGu3dJWvUYNOTRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lazT/QJg6tNx8ADnUeOrhR3oQvxrL7lGXlFte3tRvPd+enNiiTRSvpBghuXOx2+fR
	 mow8Tuq6QcTEMyXmRy+0GmmRjGFgdAKov6rLldCqifp4fTpbe/2DiQP9Y6iDOrh9GA
	 xz6bVHsNd1d++2pwdRqbxRH0EAMVdaWIskPQ5GIvkDu/sQPKRfT6fK/SxVwxzSXyA6
	 /dG++YTgMt0WjvnIzHUJxcS3F+pBwwe5L3yp6YMi1tpoqrdtD1pZW1j2EX5bzRl6SK
	 4W36EwVVbQnfHaCPwANNlElPzwDhS4DabNCQwThnoyWv5VBH5PP97sFYSnasI/vY6v
	 A+V/K0+jt3rGg==
Date: Wed, 1 Jul 2026 08:51:31 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Aniket Negi <aniket.negi03@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, aniket.negi@airoha.com
Subject: Re: [PATCH] net: airoha: fix MIB stats collection to be lossless
Message-ID: <akS48y8gCJf-EmTP@lore-desk>
References: <akPQ7P1Dqb00oWa3@lore-desk>
 <20260701063823.239783-1-aniket.negi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9rMejwU9NztTVBPE"
Content-Disposition: inline
In-Reply-To: <20260701063823.239783-1-aniket.negi03@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-303490-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:aniket.negi03@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:aniket.negi@airoha.com,m:aniketnegi03@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A5F66EA5C1


--9rMejwU9NztTVBPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> Thank you for the detailed review and suggestions!
>=20
> > > +	/* TX - 64-bit H+L registers: hw accumulates the total, read direct=
ly. =3D
> > */
> > >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
> > > -	dev->stats.tx_ok_pkts +=3D ((u64)val << 32);
> > > -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
> > > -	dev->stats.tx_ok_pkts +=3D val;
> > > +	dev->stats.tx_ok_pkts =3D (u64)val << 32;
> >=20
> > I guess it is more readable to store REG_FE_GDM_TX_OK_PKT_CNT_L() read =
in v=3D
> > al
> > here. Something like:
> >=20
> > 	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
> > 	dev->stats.tx_ok_pkts +=3D val;
> >=20
> > This apply even to occurrence below
> Agreed. I'll store CNT_L read in val first to improve readability.
>=20
> > > +	dev->stats.tx_ok_pkts +=3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_C=
NT_L=3D
> > (port->id));
> > > =3D20
> > >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
> > > -	dev->stats.tx_ok_bytes +=3D ((u64)val << 32);
> > > -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
> > > -	dev->stats.tx_ok_bytes +=3D val;
> > > +	dev->stats.tx_ok_bytes =3D (u64)val << 32;
> > > +	dev->stats.tx_ok_bytes +=3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE=
_CNT=3D
> > _L(port->id));
> > > =3D20
> > > +	/* TX - 32-bit registers: accumulate delta to handle wrap-around. */
> > >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
> > > -	dev->stats.tx_drops +=3D val;
> > > +	dev->stats.tx_drops +=3D (u32)(val - dev->stats.hw_prev_stats.tx_dr=
ops);
> > > +	dev->stats.hw_prev_stats.tx_drops =3D val;
> > > =3D20
> > >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
> > > -	dev->stats.tx_broadcast +=3D val;
> > > +	dev->stats.tx_broadcast +=3D (u32)(val - dev->stats.hw_prev_stats.t=
x_br=3D
> > oadcast);
> > > +	dev->stats.hw_prev_stats.tx_broadcast =3D val;
> > > =3D20
> > >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
> > > -	dev->stats.tx_multicast +=3D val;
> > > +	dev->stats.tx_multicast +=3D (u32)(val - dev->stats.hw_prev_stats.t=
x_mu=3D
> > lticast);
> > > +	dev->stats.hw_prev_stats.tx_multicast =3D val;
> > > =3D20
> > >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
> > > -	dev->stats.tx_len[i] +=3D val;
> > > +	dev->stats.tx_len[i] +=3D (u32)(val - dev->stats.hw_prev_stats.tx_l=
en[i=3D
> > ]);
> > > +	dev->stats.hw_prev_stats.tx_len[i] =3D val;
> > > =3D20
> > >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
> > > -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> > > -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
> > > -	dev->stats.tx_len[i++] +=3D val;
> > > +	dev->stats.tx_len[i] +=3D (u64)val << 32;
> > =20
> > Since now we do not reset MIB counters, this is wrong, you can't use "+=
=3D"
>=20
> You are absolutely right, since MIB counters are no longer cleared, using=
 "+=3D" for E64 counter would cause double counting each iteration. This wa=
s missed in the patch, specifically for the case where runt count(32 bit) a=
nd E64 counter (64 bit) need to be combined in the same counter.=20
>=20
> I'll fix this by using separate accumulator fields to "tx_runt_accum/rx_r=
unt_accum" to track the runt deltas, then compute tx_len[i] as tx_len[i]=3D=
 tx_runt_accum + E64_CNT (H+L).
>=20
> > >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
> > > -	dev->stats.rx_len[i] +=3D val;
> > > +	dev->stats.rx_len[i] +=3D (u32)(val - dev->stats.hw_prev_stats.rx_l=
en[i=3D
> > ]);
> > > +	dev->stats.hw_prev_stats.rx_len[i] =3D val;
> > > =3D20
> > >  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
> > > -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> > > -	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
> > > -	dev->stats.rx_len[i++] +=3D val;
> > > +	dev->stats.rx_len[i] +=3D (u64)val << 32;
> >=20
> > same here.
>=20
> Acked. The same approach above will be applied to rx_len[i].=20
>=20
> > > +
> > > +	struct {
> > > +	/* Previous HW register values for 32-bit counter delta tracking.
> > > +	 * Storing the last seen value and accumulating (u32)(curr - prev)
> > > +	 * in 64-bit software counter & handles wrap-around transparently
> > > +	 * via unsigned arithmetic. These fields are never reported to
> > > +	 * userspace.
> > > +	 */
> >=20
> > can you please align the comment here?
>=20
> Will fix the comment alignment.
>=20
> >=20
> > > +		u32 tx_drops;
> > > +		u32 tx_broadcast;
> > > +		u32 tx_multicast;
> > > +		u32 tx_len[7];
> > > +		u32 rx_drops;
> > > +		u32 rx_broadcast;
> > > +		u32 rx_multicast;
> > > +		u32 rx_errors;
> > > +		u32 rx_crc_error;
> > > +		u32 rx_over_errors;
> > > +		u32 rx_fragment;
> > > +		u32 rx_jabber;
> > > +		u32 rx_len[7];
> > > +	} hw_prev_stats;
> >=20
> > Maybe something like "prev_val32" ?
> >=20
> > Will update the name of struct to hold prev counter from hw_pre_stats t=
o prev_val32.
>=20
> Good suggestion. However, since the struct hw_prev_stats now contains bot=
h u32 (previous register value) and u64 (runt accumulators) fields. I'll re=
name it to "prev_mib_state" to better reflect its dual purpose of storing p=
revious register values for delta calculation and accumulators for combined=
 counters.=20

Maybe better mib_prev?

Since now we do not reset the MIB counters in airoha_update_hw_stats(), we =
can
get rid of the for loop there and just call airoha_dev_get_hw_stats() with =
the
provided dev pointer. Even better, just rename airoha_dev_get_hw_stats() in
airoha_update_hw_stats() and move the spinlock there. What do you think?

Regards,
Lorenzo

>  =20
> Regards,
> Aniket Negi
>=20

--9rMejwU9NztTVBPE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakS48wAKCRA6cBh0uS2t
rHTFAP98GZd4vah+/iyTOTP+JaCGb7y8uJEZbADWZ+6OdKVipQEAoZh7+BYH/Ppl
mqqkT8muUF4OwTApIzilfaivEim+bgI=
=w6dd
-----END PGP SIGNATURE-----

--9rMejwU9NztTVBPE--

