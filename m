Return-Path: <netdev+bounces-150331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3785D9E9E45
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF23188390D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B24414E2CC;
	Mon,  9 Dec 2024 18:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14013B59A
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769929; cv=none; b=UCW4Y819UgLBSfljomcdHJ2Im7+je0kSdi/2OuCJfPJyjJcG1O8HX/hOmQylvgmfhn67tHCZZ4WtaKc6J3ZrSmMilDQ8TGMuSCm0Kx2qiZoNL3bL0f2XcUtuQ2XqxsP6dRu9aPBABvSIyNtHhJRQrHCcjHZ3ONpIby3NXGPTlcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769929; c=relaxed/simple;
	bh=BVuwvrbSPEmPLGDwReMAzkGJoDptDqqDsx1VPr97Dnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPewBDZFEQ/VucxciZA6JoUK0JuIrRi602ijmXf8EVIkCZbEng9J6N+7cAhUl6pzFPLOA8KwvVo73n4LDdnDzakCYMTKNogw17grPxGjvtIYOMXrd7bIsSF79i5gFUFxWv+U3BsRvjjqTD+QmDTZ5dXh9C6p8mC2jR6X83RVBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tKikq-001FPb-0u;
	Mon, 09 Dec 2024 19:45:12 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tKikp-00000000Bs3-2cR3;
	Mon, 09 Dec 2024 19:45:11 +0100
Date: Mon, 9 Dec 2024 19:45:11 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Subject: Re: KSZ8795 fixes for v5.15
Message-ID: <kuvnl6z64ldmksnlfdcsfl5unlfdy3sryajjmvrtyenadwktqq@6fhjs3blojkl>
References: <uz5k4wl4fka3rxoz2tkvpogiwblokbpo72p3sdjdbakwgfbwfi@bzxazuhkhbps>
 <9e0efd14-ea5c-459f-a70c-b34e61bc47b1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6tygjn6zac7ih6tg"
Content-Disposition: inline
In-Reply-To: <9e0efd14-ea5c-459f-a70c-b34e61bc47b1@lunn.ch>


--6tygjn6zac7ih6tg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KSZ8795 fixes for v5.15
MIME-Version: 1.0

Andrew Lunn schrieb am Sa 07. Dez, 21:58 (+0100):
> On Sat, Dec 07, 2024 at 09:44:46AM +0100, J=F6rg Sommer wrote:
> > Hi,
> >=20
> > it's me again with the KSZ8795 connected to TI_DAVINCI_EMAC. It works on
> > v5.10.227 and now, I try to get this working on v5.15 (and then later
> > versions). I found this patch [1] in the Microchip forum [2]. Someone p=
ut it
> > together to make this chip work with v5.15. I applies fine on v5.15.173=
 and
> > gets me to a point where the kernel detects the chip during boot. (It s=
till
> > doesn't work, but it's better with this patch than without.)
> >=20
> > [1] https://forum.microchip.com/sfc/servlet.shepherd/document/download/=
0693l00000XiIt9AAF
> > [2] https://forum.microchip.com/s/topic/a5C3l000000MfQkEAK/t388621
> >=20
> > The driver code was restructured in 9f73e1 which contained some mistake=
s.
> > These were fixed later with 4bdf79 (which is part of the patch), but wa=
s not
> > backported to v5.15 as a grep shows:
> >=20
> > $ git grep STATIC_MAC_TABLE_OVERRIDE'.*2[26]' v5.15.173
> > v5.15.173:drivers/net/dsa/microchip/ksz8795.c:55:       [STATIC_MAC_TAB=
LE_OVERRIDE]     =3D BIT(26),
> > $ git grep STATIC_MAC_TABLE_OVERRIDE'.*2[26]' v6.6.62
> > v6.6.62:drivers/net/dsa/microchip/ksz_common.c:334:     [STATIC_MAC_TAB=
LE_OVERRIDE]     =3D BIT(22),
> >=20
> > Can someone review this patch and apply it to the v5.15 branch?
>=20
> Hi J=F6rg
>=20
> Please see:
>=20
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>=20
> Option 2.

I didn't know everyone can request a backport. But, unfortunately, neither
4bdf79d686b49ac49373b36466acfb93972c7d7c from main, nor
ce3ec3fc64e0e0f4d148cccba4e31246d50ec910 from v6.1 can be cherry-picked
without big conflicts.

I think I have to use Option 3 and send a new commit.


Kind regards, J=F6rg

--=20
Au=DFerdem teilt sich die Welt nicht in gute Menschen und b=F6se, wir haben
alle sowohl eine helle als auch eine dunkle Seite in uns. Es kommt darauf
an, welche Seite wir f=FCr unser Handeln aussuchen. Das macht uns wirklich
aus.                             (Harry Potter und der Orden des Ph=F6nix)

--6tygjn6zac7ih6tg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ1c6tgAKCRB9LJoj0a6j
dXtNAQCqFVnWfIsUlL1iP6Rt4gz+UQXgzXUdRSvMGGpWnSbP6QEAr1NIREGUGbSX
kE4oRV6sMxRyMSj8CDP+6wcyhdbxdPw=
=fkjp
-----END PGP SIGNATURE-----

--6tygjn6zac7ih6tg--

