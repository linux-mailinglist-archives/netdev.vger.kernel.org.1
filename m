Return-Path: <netdev+bounces-174523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA53A5F149
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F7E19C1D19
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6E26656A;
	Thu, 13 Mar 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGUxO4Iz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1042661B6
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862896; cv=none; b=GkKAnsyn//ZYatQp3Z8bTPqVocmt9fjppjn3fWVrNpcX0b+4PmmNgPITpKPVJePmqtKANMKlXBWet1/TAiF9b8omI5pV5Ps1WmgfuPJxl0WGsOSrcuLVEhZJgm9aQdOgdJ0fhXLcnJMuyV833OHRtRrdeoh1Q8CL+rCq4b0+aDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862896; c=relaxed/simple;
	bh=ifXxEP9fQ+ca00C4NymK9lkHybBl5yWQFtzUvukmZnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCQqbpHgnlt/3KOgRYMS9s8/ZkOzj7RoVZKI1dcjVJm+1iuyvvtXtGyscZ+NLRCwrg88rno/dihSWlBA0Hm4DV8LTmUS2dLw7naH2grjSMv1FCEKXvT4A0hJ3nx28Ipsch8XSEHZmMzzm9GJLYTuLM+DKmST/Lq5I98+v0n/hU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGUxO4Iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DF2C4CEEE;
	Thu, 13 Mar 2025 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741862896;
	bh=ifXxEP9fQ+ca00C4NymK9lkHybBl5yWQFtzUvukmZnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGUxO4IzaiCdImvWcK07pYxlaES+FKpyGSGQS+se2QRK+fS4IxGUEbGzelHwLB+/q
	 u36Ov+lMh2bFtMiWiorUoJsCIqlxAB2/54A1bOfNySQ9EJUwXmVbWVZAZM+MLnNhDS
	 q60fcF/44I6LM6PFWe6Q4t1c0f59nE8pUQQ4N/oOkfmndKcu330/DWQaC8bbtj/Jxf
	 RfMCxb1oFk2O8r81YBQY3m2ZBt5oJyduarUFlJAn7NTGROXk+kX+4295LvHam9tbyq
	 vq24P3CCHWEEcWcrREvOOvYs1e7H5PMvdPTFrQg6LkEM6DzQCCNoZpwVYZzqbe1W3J
	 CwBUYe1l77zsw==
Date: Thu, 13 Mar 2025 11:48:13 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <Z9K37URcF_hkCTBM@lore-desk>
References: <20250312-airoha-flowtable-null-ptr-fix-v1-1-6363fab884d0@kernel.org>
 <Z9Ga7gx1u3JsOemE@localhost.localdomain>
 <Z9GgHZxkSqFCkwMg@lore-desk>
 <Z9GtKwAuEx+7HKjR@localhost.localdomain>
 <Z9G01zGCpbw1YHNs@lore-desk>
 <Z9K2vujs6+yhiXXh@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PLfdax2fnK8OYSBS"
Content-Disposition: inline
In-Reply-To: <Z9K2vujs6+yhiXXh@localhost.localdomain>


--PLfdax2fnK8OYSBS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Mar 12, 2025 at 05:22:47PM +0100, Lorenzo Bianconi wrote:
> > > On Wed, Mar 12, 2025 at 03:54:21PM +0100, Lorenzo Bianconi wrote:
> > > > > On Wed, Mar 12, 2025 at 12:31:46PM +0100, Lorenzo Bianconi wrote:
> > > > > > The system occasionally crashes dereferencing a NULL pointer wh=
en it is
> > > > > > forwarding constant, high load bidirectional traffic.
>=20
> [...]
>=20
> > >=20
> > > >=20
> > > > >=20
> > > > > > +		if (!eth->ports[i])
> > > > > > +			continue;
> > > > >=20
> > > > > Isn't this NULL check redundant?
> > > > > In the second check you compare the table element to a real point=
er.
> > > >=20
> > > > Can netdev_priv() be NULL? If not, I guess we can remove this check.
> > >=20
> > > I guess it shouldn't be NULL since "devm_alloc_etherdev_mqs()" was
> > > called, but I'm not 100% sure if there are any special cases for the =
"airoha"
> > > driver. Maybe in such cases it would be better to check for the netde=
v_priv?
> > > Anyway, such checks seem a bit too defensive to me.
> >=20
> > the dev pointer can be allocated even outside of airoha_eth driver.
> > This pointer is provided by the flowtable.
> > I guess we can drop the NULL pointer check above, and do something like:
> >=20
> > 	if (port && eth->ports[i] =3D=3D port)
> > 		return 0;
> >=20
> > what do you think?
> >=20
> > Regards,
> > Lorenzo
> >=20
>=20
> I think if there's a risk that 'port' can be NULL, it looks like a
> reasonable solution and I'm OK with that.

I guess you are right. I do not think netdev_priv pointer can be NULL since,
even if size_priv is 0, it will just point to the end of the netdevice stru=
ct.
I will repost just doing:

	if (eth->ports[i] =3D=3D port)
		return 0;

Regards,
Lorenzo

>=20
> Thanks,
> Michal
>=20

--PLfdax2fnK8OYSBS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ9K37QAKCRA6cBh0uS2t
rCf5AQCtpdGJkY45ujQJ6QxQbPLHKHEUhSbDaTD5WJCphEav2gD+J9GCbdGJ6O9g
UPXzVUQ6dVmmww/RLljE9fOkDfMR0Qs=
=f/tx
-----END PGP SIGNATURE-----

--PLfdax2fnK8OYSBS--

