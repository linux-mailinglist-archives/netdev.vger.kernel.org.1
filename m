Return-Path: <netdev+bounces-180504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA8A8193A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A3E1BA1F67
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F0C24BBFA;
	Tue,  8 Apr 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaRKTDUD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50CC13AD38
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154359; cv=none; b=XOz78n92Oa2oviaNA03YdeFFdgpZMlBj+TfkhoahWH3+Yjl+/ZirOjiojSxw30iMbOIVvgg5L+dx/A6ZIbnyqzgJg5km9ePDi075bllv3C6O16+nnq4zJaH8lH1qSPYyrZ9nHM4DMiLRW5T57G+AvXnXyEF0cuvRYj7xy2H51Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154359; c=relaxed/simple;
	bh=jq+FrRJ8wmPSlEyVRgARkqehmDkbb8yB70PS2EY+cZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDJfmgZYFara19TVI/jLOS3buNBh5lqMQyW6ozV4gi6NBcZqY/xEVrHYhP07CNgrIz44NRx3oGK8YJw9907AW/LBjzL8lR77Gc2rwG5s/juuPPkKaFbbd/OJ3E0PUVpqKAjFT3GSJ2qotAIJC5EMBVUszxGBGzyoSa0qbbV2YCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaRKTDUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC94FC4CEE5;
	Tue,  8 Apr 2025 23:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744154359;
	bh=jq+FrRJ8wmPSlEyVRgARkqehmDkbb8yB70PS2EY+cZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaRKTDUD7aSux1lHxvu0vYbpp332XuP/7dbrUIuNehASvPMACmPTcU3k5EIRTiPlB
	 RifELkRpXtFPMa2erZyOdpnQLz/vw51OxCGTVTBEITJUuJcXfK0Qtx4lpElXRiZ5Sy
	 A5uzx+z4hg2yKUIveg5/634n0IMzjUc2vKF+ONZHUCriL0MI9pvEatkJ1cbP/8t6tq
	 5Uzl/wjRTrVwAXgWTqZUy4cN9k3ij4/E1/1zHLvU/l7PO0MWREN+1nAuy2BycaHycB
	 jync/h5nPEOUZikwPI/GBpWeXFskatlzeoMFEc3/XcywgGXkNZN5RHAUYhpkCK6afB
	 EYlT7OkUI1/9g==
Date: Wed, 9 Apr 2025 01:19:16 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: airoha: Add L2 hw acceleration support
Message-ID: <Z_Wu9EDZM9jvmgAU@lore-desk>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
 <20250407-airoha-flowtable-l2b-v1-3-18777778e568@kernel.org>
 <Z/V/ip/dA+aw+dCW@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D5x5nT7TkBsGAvZK"
Content-Disposition: inline
In-Reply-To: <Z/V/ip/dA+aw+dCW@localhost.localdomain>


--D5x5nT7TkBsGAvZK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Apr 07, 2025 at 04:18:32PM +0200, Lorenzo Bianconi wrote:
> > Similar to mtk driver, introduce the capability to offload L2 traffic
> > defining flower rules in the PSE/PPE engine available on EN7581 SoC.
> > Since the hw always reports L2/L3/L4 flower rules, link all L2 rules
> > sharing the same L2 info (with different L3/L4 info) in the L2 subflows
> > list of a given L2 PPE entry.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c |   2 +-
> >  drivers/net/ethernet/airoha/airoha_eth.h |  11 ++-
> >  drivers/net/ethernet/airoha/airoha_ppe.c | 162 +++++++++++++++++++++++=
++------
> >  3 files changed, 144 insertions(+), 31 deletions(-)
> >=20
>=20
> [...]
>=20
> > +static void airoha_ppe_foe_remove_flow(struct airoha_ppe *ppe,
> > +				       struct airoha_flow_table_entry *e)
> > +{
> > +	lockdep_assert_held(&ppe_lock);
> > +
> > +	hlist_del_init(&e->list);
> > +	if (e->hash !=3D 0xffff) {
> > +		e->data.ib1 &=3D ~AIROHA_FOE_IB1_BIND_STATE;
> > +		e->data.ib1 |=3D FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
> > +					  AIROHA_FOE_STATE_INVALID);
> > +		airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash);
> > +		e->hash =3D 0xffff;
> > +	}
> > +	if (e->type =3D=3D FLOW_TYPE_L2_SUBFLOW) {
> > +		hlist_del_init(&e->l2_subflow_node);
> > +		kfree(e);
> > +	}
> > +}
> > +
> > +static void airoha_ppe_foe_remove_l2_flow(struct airoha_ppe *ppe,
> > +					  struct airoha_flow_table_entry *e)
> > +{
> > +	struct hlist_head *head =3D &e->l2_flows;
> > +	struct hlist_node *n;
> > +
> > +	lockdep_assert_held(&ppe_lock);
> > +
> > +	rhashtable_remove_fast(&ppe->l2_flows, &e->l2_node,
> > +			       airoha_l2_flow_table_params);
> > +	hlist_for_each_entry_safe(e, n, head, l2_subflow_node)
> > +		airoha_ppe_foe_remove_flow(ppe, e);
> > +}
> > +
> >  static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
> >  					     struct airoha_flow_table_entry *e)
> >  {
> >  	lockdep_assert_held(&ppe_lock);
> > =20
> > -	if (e->type =3D=3D FLOW_TYPE_L2) {
> > -		rhashtable_remove_fast(&ppe->l2_flows, &e->l2_node,
> > -				       airoha_l2_flow_table_params);
> > -	} else {
> > -		hlist_del_init(&e->list);
> > -		if (e->hash !=3D 0xffff) {
> > -			e->data.ib1 &=3D ~AIROHA_FOE_IB1_BIND_STATE;
> > -			e->data.ib1 |=3D FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
> > -						  AIROHA_FOE_STATE_INVALID);
> > -			airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash);
> > -			e->hash =3D 0xffff;
> > -		}
> > -	}
> > +	if (e->type =3D=3D FLOW_TYPE_L2)
> > +		airoha_ppe_foe_remove_l2_flow(ppe, e);
> > +	else
> > +		airoha_ppe_foe_remove_flow(ppe, e);
>=20
> It's not a hard request, more of a question: wouldn't it be better to
> introduce "airoha_ppe_foe_remove_l2_flow()" and
> "airoha_ppe_foe_remove_flow()" in the patch #2?
> It looks like reorganizing the code can be part of the preliminary
> patch and the current patch can just add the feature, e.g. L2_SUBFLOW.

ack, fine for me. I will fix it in v2.

Regards,
Lorenzo

>=20
> Thanks,
> Michal
>=20

--D5x5nT7TkBsGAvZK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ/Wu9AAKCRA6cBh0uS2t
rE8gAP0RtE2rJQnq69I0ppX4iKk8Uqocro+ljFSQFoVvrjGXSgEA5pei1LXuW1nS
Z3eXKwveeMuRdFN8Dj8lGxCU1GwVnw0=
=lKOk
-----END PGP SIGNATURE-----

--D5x5nT7TkBsGAvZK--

