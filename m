Return-Path: <netdev+bounces-229924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 383EBBE2189
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B16A935259A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F712FFFAA;
	Thu, 16 Oct 2025 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFAs+/pz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C32FFDCF;
	Thu, 16 Oct 2025 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602231; cv=none; b=L6h5XxmWxb0EvFeNUcnWSeCej2s7+K2VW3YOgfkAO1kNwX1yv6mzo6hC1BanhNKLlbtM91YxyQfX1ACyDcxUUEb3Xq9xlCtybnZOc3AxXG5pZRan/2gWscT6KlzXtDUSdyEkKuKZirvwC6MDvlLebelwTmcTtr22YmbM1WMV7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602231; c=relaxed/simple;
	bh=BqE165DW1W7QlpVTH7AU/66UVMbPwzOvW0CrLWglYhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcAh3y/rl0MvU4fXhOijHPBYscVX18CM4ecIn5tpUwEaswZ55JQPBjHEjA9dfv8TxsPS3BoTX0vkuE6sAKfCEU0S+44NpfGnmLKZpLOYGI/zQ6ILkQu7XL2LgQZJTpPfGN49kaC5+KNiFUHg7+FPkvrtELsoYsg6OGpuVKnajQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFAs+/pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45001C4CEF1;
	Thu, 16 Oct 2025 08:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760602230;
	bh=BqE165DW1W7QlpVTH7AU/66UVMbPwzOvW0CrLWglYhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFAs+/pzVgP+mpwH3riBiHGxPTQFVGQ1SFIFoCFpefs9Ay3Hae3mOTbOb9ANhytly
	 h8ZZ1HqK+R0kNzc6F/+UIZPZ5RFZ9T5ZCm40F7YU5g3SupREgEsd3rH2UMvj6rqX3+
	 Y90Lkvkdu6eYglFqR/BXbMaSwcyMr/jZx1kegnulI5CbT9B9O3tZ3QPJ05c6fj0XTv
	 b9ud1Xm4QhpzMO/lI4giQm35TOECNxN819WRZd/Cy/eUe2uPfrKmpVkG6YRmIkZQCW
	 O6cBEpXx0bnHzMQ976S4ryGEBcHBnbaFfz63KaSZi59UJlIM7VKXN4B6D0Y14KKYyb
	 XDdhJeMcFu4mg==
Date: Thu, 16 Oct 2025 10:10:28 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 03/12] net: airoha: Add
 airoha_ppe_get_num_stats_entries() and
 airoha_ppe_get_num_total_stats_entries()
Message-ID: <aPCodE0_u94s-w73@lore-desk>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-3-064855f05923@kernel.org>
 <aO-ZCqsvPQ6Pqjpg@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zgC7fqkmMZN9riIm"
Content-Disposition: inline
In-Reply-To: <aO-ZCqsvPQ6Pqjpg@horms.kernel.org>


--zgC7fqkmMZN9riIm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Oct 15, 2025 at 09:15:03AM +0200, Lorenzo Bianconi wrote:
> > Introduce airoha_ppe_get_num_stats_entries and
> > airoha_ppe_get_num_total_stats_entries routines in order to make the
> > code more readable controlling if CONFIG_NET_AIROHA_FLOW_STATS is
> > enabled or disabled.
> > Modify airoha_ppe_foe_get_flow_stats_index routine signature relying on
> > airoha_ppe_get_num_total_stats_entries().
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.h |  10 +--
> >  drivers/net/ethernet/airoha/airoha_ppe.c | 103 +++++++++++++++++++++++=
++------
> >  2 files changed, 86 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index 4330b672d99e1e190efa5ad75d13fb35e77d070e..1f7e34a5f457ca2200e9c81=
dd05dc03cd7c5eb77 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -50,15 +50,9 @@
> > =20
> >  #define PPE_NUM				2
> >  #define PPE1_SRAM_NUM_ENTRIES		(8 * 1024)
> > -#define PPE_SRAM_NUM_ENTRIES		(2 * PPE1_SRAM_NUM_ENTRIES)
> > -#ifdef CONFIG_NET_AIROHA_FLOW_STATS
> > +#define PPE_SRAM_NUM_ENTRIES		(PPE_NUM * PPE1_SRAM_NUM_ENTRIES)
> >  #define PPE1_STATS_NUM_ENTRIES		(4 * 1024)
> > -#else
> > -#define PPE1_STATS_NUM_ENTRIES		0
> > -#endif /* CONFIG_NET_AIROHA_FLOW_STATS */
> > -#define PPE_STATS_NUM_ENTRIES		(2 * PPE1_STATS_NUM_ENTRIES)
> > -#define PPE1_SRAM_NUM_DATA_ENTRIES	(PPE1_SRAM_NUM_ENTRIES - PPE1_STATS=
_NUM_ENTRIES)
> > -#define PPE_SRAM_NUM_DATA_ENTRIES	(2 * PPE1_SRAM_NUM_DATA_ENTRIES)
> > +#define PPE_STATS_NUM_ENTRIES		(PPE_NUM * PPE1_STATS_NUM_ENTRIES)
> >  #define PPE_DRAM_NUM_ENTRIES		(16 * 1024)
> >  #define PPE_NUM_ENTRIES			(PPE_SRAM_NUM_ENTRIES + PPE_DRAM_NUM_ENTRIES)
> >  #define PPE_HASH_MASK			(PPE_NUM_ENTRIES - 1)
> > diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/eth=
ernet/airoha/airoha_ppe.c
> > index 8d1dceadce0becb2b1ce656d64ab77bd3c2f914a..303d31e1da4b723023ee0cc=
1ca5f6038c16966cd 100644
> > --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> > +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> > @@ -32,6 +32,30 @@ static const struct rhashtable_params airoha_l2_flow=
_table_params =3D {
> >  	.automatic_shrinking =3D true,
> >  };
> > =20
> > +static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe,
> > +					    u32 *num_stats)
> > +{
> > +#ifdef CONFIG_NET_AIROHA_FLOW_STATS
> > +	*num_stats =3D PPE1_STATS_NUM_ENTRIES;
> > +	return 0;
> > +#else
> > +	return -EOPNOTSUPP;
> > +#endif /* CONFIG_NET_AIROHA_FLOW_STATS */
> > +}
>=20
> Hi Lorenzo,

Hi Simon,

>=20
> I think that in general using IS_ENABLED is preferred over #ifdef
> in cases where the former can be used. For one thing it improves compile
> coverage.
>=20
> That does seem applicable here, so I'm wondering if
> we can do something like the following.
> (Compile tested only!)
>=20
> static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe,
>                                             u32 *num_stats)
> {
>         if (!IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS))
>                 return -EOPNOTSUPP;
>=20
>         *num_stats =3D PPE1_STATS_NUM_ENTRIES;
>         return 0;
> }

ack, fine. I will fix it in v2.

>=20
> Also, very subjectively, I might have returned num_stats as
> a positive return value. I'm assuming it's value will never overflow an i=
nt.
> Likewise elsewhere.
>=20
> But that's just my idea. Feel free to stick with the current scheme.

I guess it is fine. I will fix it in v2.

Regards,
Lorenzo

>=20
> ...

--zgC7fqkmMZN9riIm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPCodAAKCRA6cBh0uS2t
rOw7AQCrjTRELdN7df/7nasO5hLMxRhlBZzyAL0R8iFX2T/0jAD/Z0pUAE59OW0Z
Q9RIe4mD8YXtUcw5ym+gnF/sXJKqLgM=
=3ofA
-----END PGP SIGNATURE-----

--zgC7fqkmMZN9riIm--

