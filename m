Return-Path: <netdev+bounces-30913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B789789CFB
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 12:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEF71C208CF
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 10:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AEC613D;
	Sun, 27 Aug 2023 10:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15E612E
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 10:24:26 +0000 (UTC)
Received: from mail.redxen.eu (chisa.nurnberg.hetzner.redxen.eu [IPv6:2a01:4f8:c2c:b2fc::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06829AD
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 03:24:25 -0700 (PDT)
Received: from localhost (karu.nurnberg.hetzner.redxen.eu [157.90.160.106])
	by mail.redxen.eu (RedXen Mail Postfix) with ESMTPSA id 18FF95FA70;
	Sun, 27 Aug 2023 10:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redxen.eu;
	s=2021.05.31.01-mail; t=1693131863;
	bh=9k0JQB+drBJwoixk7vCjCUSTHO7qp47lw/1ISFt4eEE=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To;
	b=mrg6roF8BIGoqYNFEalyCDBE9IT2WbMM9VikMvLyMBimOYJg3EO+F24jxcEIzFRnL
	 L85yDIxvXmi+HiKavzPv1MJ3zGWFYG+ZVlqnx6rShwNyPp+kN0vRgFnayHD0LP57Se
	 jV8PeOoot4lPhsmpEsHq+WBqUSVUBeZN36b8GGX9wMqbuxlW0VJABl5VFnfMYk4qJY
	 JdT0z25NR5HdChxPDwjhN6jEpwpQgbVDhnjxn5t6a6WPVqolIXTkkLBleuV4XveFAm
	 wfCvDfY3I+J121JhPoUrP7VHVqP/CFYOg5aPfHMflJ0kyzd5JAqukzatiWNMSJJZxy
	 5+jZe1timNRwg==
Authentication-Results: mail.redxen.eu;
	auth=pass smtp.auth=caskd smtp.mailfrom=caskd@redxen.eu
Date: Sun, 27 Aug 2023 10:24:22 +0000
To: caskd <caskd@redxen.eu>
Cc: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, netdev@vger.kernel.org
Subject: Re: IPv6 multicast and snooping on bridges
From: caskd <caskd@redxen.eu>
References: <2GFL0JKN91JCI.2BNDSFI1J4DTV@unix.is.love.unix.is.life>
 <3A0UPE856X8FP.2IUCPPEM7A2R3@unix.is.love.unix.is.life>
In-Reply-To: <3A0UPE856X8FP.2IUCPPEM7A2R3@unix.is.love.unix.is.life>
Message-Id: <3L9Q6VZGO0Y2L.3LBULT0Z6RO3M@unix.is.love.unix.is.life>
User-Agent: mblaze/20220328-3140-g8658ea6aef
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="----_=_3340e06a3f3fe7a077301ace_=_"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multipart message in MIME format.

------_=_3340e06a3f3fe7a077301ace_=_
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_46e2670550e083c707119b31_=_"

This is a multipart message in MIME format.

------_=_46e2670550e083c707119b31_=_
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

caskd <caskd@redxen.eu> wrote:
> Hello everyone,
>=20
> > How to reproduce:=0D
> >=20=0D
> > - Create a bridge=0D
> > - Activate multicast snooping=0D
> > - Assign a address to the bridge=0D
> > - Watch multicast database (especially the ones with the device and por=
t both being the bridge)=0D
> > - Wait 5-10 minutes (i wasn't able to pinpoint a exact interval but it =
usually happens in this timeframe)=0D
> >=20=0D
> > During the waiting timeframe the interface's own host groups should dis=
appear from the bridge's database, resulting in the bridge not accepting an=
y more packets for it's own group.=0D
> >=20=0D
> > Is this intended behaviour? It would seem like the interface can be use=
d as a "switch-port" itself instead of configuring a dummy interface to be =
a part of the bridge, as it behaves correctly except for this one case. Thi=
s isn't a problem in the IPv4 world but creates routing problems in the IPv=
6 world. If it is, could this be documented somewhere?=0D
>=20
> After some futher investigation, i noticed i can only replicate this when=
 there is a VLAN interface as part of the bridge that is up. As soon as the=
 interface goes up, it takes a bit and then the entries get deleted. I can =
replicate this on 6.4 just fine while i cannot replicate it in 5.19, so it =
seems to be something that used to work and broke during this period. I wil=
l build older kernels and try to pinpoint the breaking change(s).
>
Nevermind, found the trigger being the temporary entry lifetime and it also=
 happens without a VLAN. So it seems to be a feature? Why would own multica=
st groups expire on a bridge that does snooping?

How to reproduce:

ip link add dummy-slave type dummy
ip link add bridge-dummy type bridge mcast_snooping 1
ip link set dev dummy-slave master bridge-dummy up
ip link set dev bridge-dummy up

# Watch as the timer goes down and own entries disappear
watch -n0.2 -d -x bridge -d -s mdb

--=20
Alex D.
RedXen System & Infrastructure Administration
https://redxen.eu/

------_=_46e2670550e083c707119b31_=_--

------_=_3340e06a3f3fe7a077301ace_=_
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJEBAABCgAuFiEE2k4nnbsAOnatJfEW+SuoX2H0wXMFAmTrJFUQHGNhc2tkQHJl
ZHhlbi5ldQAKCRD5K6hfYfTBc/NmD/0Z35HbRPka/pM4BuaB2yBuaNlV3Y+AHPk5
58VDUJGWuW0wx0mgR2m8zUKe1rpHgXUhK07TGFAcxc1EKcSqAE+hmOudPazYbsBb
w3/VDYIMOIsM5l/jA2k6fe8cgrNWyS4UM9Jqag7wzvyDMhePblj7epZ8nC5BxUU/
N0lgSIH67Rv2nH7NM7Tz56SkHLTz40xgy5NsJNPczqsYorL/U/PmXpXXXcg6J+Pw
GNk2g0lnPWCFQlo8jeV/6JqkpCC5gfvzawBa5Zli/1/fjYspI5nGov32IIn4HRgZ
zwO35It1A9wgXfInA/6bUu5EWQUomwx7bO7Sw2XC3LErbgTX+bPZLaiL8V90R4gS
nuuM3OVNl34vO1kgpAKpYG2QcDiEHBiFojl2VJMX1ZVs53QHZCGuImp4Q5alH93i
1DZk5t3u0PP9GTdsnIOg8mUyrQKXMkd/9rivdXghEriNfJjYX8PVybTcl3nvs24f
5/a8sMPLaTTcqblrrByVCpJWh2yI2lrN/PvOW/iNPjNiJz08V0/VO0db7QroKgPR
mWHbkBLNwG9DsH5e5jX6peRsa4fm4n/9MBw/+NqjgcQINeR4EFfEsiMZkCb9NbbD
Wy5Jus7Q8xBA5picKgLSUQ0YllylZw7TY4ruFfSQ0EturhUCxUI8DHqdal/OPC3T
78qi2pJnAA==
=soAd
-----END PGP SIGNATURE-----

------_=_3340e06a3f3fe7a077301ace_=_--

