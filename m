Return-Path: <netdev+bounces-127247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D058974BF2
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07301283FA2
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F1F1428E4;
	Wed, 11 Sep 2024 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vuYDUzua"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D01422C3;
	Wed, 11 Sep 2024 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041612; cv=none; b=qH/dUBWOgQYvE+33yeXrFBhEFcRW6qMQfuHq9zNIgt/Qra0cM/5L/vh6E4DwSxUiOOFS2ZF9ITRnpLch3DKUXIu09buItBME7DAmDpeiiz7Gvi+8AfWE2ch6xiJfuIDHqqQQR08kuBT3K69GLz74oVdF5xu6c0VBL5rZR6Wyhts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041612; c=relaxed/simple;
	bh=oPG18xmyEbpeYNpPwEr62c/qRuxUvqXAcKt8PTuHMVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grCL7YJbDFpjBvOjom8eDxBvHUvbhpP8kHLtGv0YrqQOVP5i87wjt0+D2iuOwMZxQ8v4aQv5Az/zxv2n2vhErr3ytkXdfulMs+epy16UNfoyyFenS1afIFs8QVFMdATecRJ1uWbHehap88qDiXsitzylbqBI2LxU/WQaQvFgjvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vuYDUzua; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 56D14891D1;
	Wed, 11 Sep 2024 10:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726041609;
	bh=T8m7rqONmu1nj7zPXVt0V0nx+eeqpOiL3Bn7hrcE2T8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vuYDUzuaP+dX3kBGMCIWuNLooj4i6AZCuHaXe8T0KJC3PPGBkUKP+JLTCDXl2mSYK
	 KaItMW4LLCtRxRIW2Gf+e904JqBdCLcIN0bgQFQaAjZS4TaLhN/xAz4ZUqB6d55Yxl
	 CvR5p6TFjeqpkAZClY8MuBiJrQvj35GIEx12WTg8XoNmKpxcABNh2oSLQgVB8IMC1/
	 RLdxDRrWRCoan7QmJXsYLcbX1aZIrsrhESlyhrkKFHweGLSM/64/IbXuubnCp4iY4y
	 GE52XJCFq1b+N5xm8vI8y/EfNZVXM/jqsqf2bVRYL1QJm2yY4a1cUgJe4KHKji4L6v
	 MsgpLvFqSKkZA==
Date: Wed, 11 Sep 2024 10:00:07 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeongjun Park <aha310510@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 ricardo@marliere.net, m-karicheri2@ti.com, n.zhandarovich@fintech.ru,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: hsr: prevent NULL pointer dereference in
 hsr_proxy_announce()
Message-ID: <20240911100007.31d600fc@wsk>
In-Reply-To: <20240910191517.0eeaa132@kernel.org>
References: <20240907190341.162289-1-aha310510@gmail.com>
	<20240909105822.16362339@wsk>
	<20240910191517.0eeaa132@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=axxuq5oVPAOzcsO/ZIkebi";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/=axxuq5oVPAOzcsO/ZIkebi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Mon, 9 Sep 2024 10:58:22 +0200 Lukasz Majewski wrote:
> > > In the function hsr_proxy_annouance() added in the previous
> > > commit 5f703ce5c981 ("net: hsr: Send supervisory frames to HSR
> > > network with ProxyNodeTable data"), the return value of the
> > > hsr_port_get_hsr() function is not checked to be a NULL pointer,
> > > which causes a NULL pointer dereference.   =20
> >=20
> > Thank you for your patch.
> >=20
> > The code in hsr_proxy_announcement() is _only_ executed (the timer
> > is configured to trigger this function) when hsr->redbox is set,
> > which means that somebody has called earlier iproute2 command:
> >=20
> > ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink
> > lan3 supervision 45 version 1 =20
>=20
> Are you trying to say the patch is correct or incorrect?

I'm just trying to explain that this code (i.e.
hsr_proxy_announcement()) shall NOT be trigger if the interlink port is
not configured.

Nonetheless the patch is correct - as it was pointed out that the return
value is not checked.

> The structs have no refcounting - should the timers be deleted with
> _sync() inside hsr_check_announce()?

The timers don't need to be conditionally enabled (and removed) as we
discussed it previously (as they only do useful work when they are
configured and almost take no resources when declared during the
driver probe).

Anyway:

Acked-by: Lukasz Majewski <lukma@denx.de>

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/=axxuq5oVPAOzcsO/ZIkebi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbhTgcACgkQAR8vZIA0
zr3dPwgAng+gHjUeQPNfCu/asjj/O5Cu26VE3wTV8gFq7gEI5BP3fFGbBIbwql++
RyEH/QaM3YbZ2UQBNX/p1Rdjyb0+Vh7MMUBFsbuXwA24I66vz744W5wN2ETe0N4P
ErBF3GRSsXV1riZNUdi57PGoQIj+UBCHvpcXoHdM96QqVz9GM9i/mOyt+hfnR9sI
r2Er1GwWNUAfZ+TOh+jqKiyDSbXXxyE9u5vniFP38pY5SSPNBheY0PyEWKtwszsw
sqoaq+Pgpi8gGRY3AWRdiqvYNiADMkmbWK7kOf1R4293fk4Om/S7URkC6bo0NcdS
YX8G71K2SUkzsIOB5bAvfx3CH6VY3w==
=Mv6G
-----END PGP SIGNATURE-----

--Sig_/=axxuq5oVPAOzcsO/ZIkebi--

