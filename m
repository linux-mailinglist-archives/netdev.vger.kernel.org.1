Return-Path: <netdev+bounces-96476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091638C612F
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A198C1F23C62
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FBA43AA4;
	Wed, 15 May 2024 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="wAOE8lha"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9054D58E;
	Wed, 15 May 2024 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756951; cv=none; b=a0orZw1Y0PoJbeAjRxes7Sf5GFkbaPUp3S3DerH+x8bRbi6A6wMGpRNeIB2uOWXy7xnfMATpk2FXOPNa5ZEnBn9fT5fg9DVLSSpFshxEDYSPhJPfq5PhNunUFIP55RUQe35bb1XW5T6vqvSvSNFKpNoY3JD9dRDCR1+fnjFxhAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756951; c=relaxed/simple;
	bh=TlijGYMDNzqIG7iiD3qAFvS5QTO9ino5t7xI4ecx6I0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0ikw83z1+g0pey37ZUAThfoKMjb5Jl+dL3ZwY/D3an0qlKX5oUIwldCPV2VKlYrTI2pQ/30tt6+xGOuZ8Q5S91qiQv5LeoJC8VhlBzL++UaAR4y3DTniPH1wmmoLeLc3MCVH64m4JV4BKysgug8H4lXbeMSufVxUG0Yufpp0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=wAOE8lha; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1F238881C8;
	Wed, 15 May 2024 09:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715756947;
	bh=qZEnpACq0iHTaacG6FZZEyfsiJPcBQ6mk9fV3PhjltU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wAOE8lhaMKWtilGri2uI01elUkjYFpu3dtgegVDoPB01RXTQCESJCG3cHfUMuHJtP
	 MY6X1Phy8qI9b8a/Cf79fUpmxkQj1UI3F9iZDaVkj8YOsOlehw2tMJ/5eu5LCWOc3R
	 6o3IkRJhXZDT1jmP/p69xOrN9X+pyDrre09E/3ElcwR+geJ+tz0CUOXrp1kNaJYR4X
	 Qtk5WAauBxJnuiT2NXq6bX0PLz7npt1UeR3UO3B7qtfxmcyKWrXrtnjQQDoVcIUXnQ
	 NkuVgz0insnprJYDBELK12tVtNM9cA8U9VmLpW+fV9MTxw2b6wCe7KiOmCrtgo7mUT
	 1ibyO98tfce4Q==
Date: Wed, 15 May 2024 09:09:04 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>, Nikita
 Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Arvid Brodin <Arvid.Brodin@xdin.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, "Ricardo B. Marliere" <ricardo@marliere.net>,
 Casper Andersson <casper.casan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hsr: Setup and delete proxy prune timer only when
 RedBox is enabled
Message-ID: <20240515090904.477c6b5f@wsk>
In-Reply-To: <20240515064139.-B-_Hf0_@linutronix.de>
References: <20240514091306.229444-1-lukma@denx.de>
	<20240515064139.-B-_Hf0_@linutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7vQ_Gdg_fcDO5+YKl6phDUR";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/7vQ_Gdg_fcDO5+YKl6phDUR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

> On 2024-05-14 11:13:06 [+0200], Lukasz Majewski wrote:
> > The timer for removing entries in the ProxyNodeTable shall be only
> > active when the HSR driver works as RedBox (HSR-SAN).
> >=20
> > Moreover, the obsolete del_timer_sync() is replaced with
> > timer_delete_sync().
> >=20
> > This patch improves fix from commit 3c668cef61ad
> > ("net: hsr: init prune_proxy_timer sooner") as the prune node
> > timer shall be setup only when HSR RedBox is supported in the node.
> > =20
>=20
> Is it problematic to init/ delete the timer in non-redbox mode? It
> looks easier and it is not a hotpath.

My concern is only with resource allocation - when RedBox is not
enabled the resources for this particular, not used timer are allocated
anyway.

If this can be omitted - then we can drop the patch.

>=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Sebastian




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/7vQ_Gdg_fcDO5+YKl6phDUR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZEX5AACgkQAR8vZIA0
zr1lTAgA2ENishaKFuCVLs+wjmiwd631kRvCT/CrhFlZee0BvnKzZt8kCInlqXHz
87nox73yEmt+X7K5j+IvZCWLgJlrlhkqmeJRfubl4/9p7XfAraK5z+jrCt3PlhRQ
gsNSMHRcthViR7aluoVSbWWjuYH04CjKejrW1fxIm8BHVOVFMI2WU/dnm0UCTetM
19XhJ4MK+u9+doa9jGekd1CHv39U67jx7bhkOx0FR6j1P1/ye0cg5JOUKP+CwLos
auEtJMO9taESL6ptJB0JOmNLycJXD9HROgpALwSkgBZ/VAfvfaes0Y8u4G7EIfW8
P2+Tl9nI+DLm2OjU3V7IMXrQnO6ARg==
=Dwv4
-----END PGP SIGNATURE-----

--Sig_/7vQ_Gdg_fcDO5+YKl6phDUR--

