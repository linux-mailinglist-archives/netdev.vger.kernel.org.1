Return-Path: <netdev+bounces-95899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A477E8C3D02
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452651F21EB6
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B11474AA;
	Mon, 13 May 2024 08:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B4146D74;
	Mon, 13 May 2024 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588288; cv=none; b=ZAaMSZMwaV4mEWUujf3uB7UdunZCmfQFvwSQFyR6UJioARseggn1yf+dSn/nxv4Gl5BLMgvZQWHj7/CiHRqC5DMKZSTrCRm2hk9xAnB/VzJ1b2Ep5glRhGn7XOAUz6CtRgPfLpZ2zkBM0e5JzpTXDsOVHKeKmJK/+Yw6PF9onQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588288; c=relaxed/simple;
	bh=GNcyqoxp0Epx6j9uWuFAHSdaWV57aMNenFgPvcptujc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZroparFVoq2egLWOxkNHmRS/fI1BUd/eGZCy1kn+wxsOEKoYd38dRBt0HJdZAznZC1y5hAaykhmjRWmEHTnMUCvxuZMxXyopuiC0U6L4BqoeavIAXDb9Yd6ifKtIw3xZBjDhbnyMkWrcOE4tZiSS50cnoOaiSK3CjtAKx64X7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2FB1A1C0081; Mon, 13 May 2024 10:18:05 +0200 (CEST)
Date: Mon, 13 May 2024 10:18:04 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>, manishc@marvell.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 5/9] net: qede: sanitize 'rc' in
 qede_add_tc_flower_fltr()
Message-ID: <ZkHMvNFzwPfMeJL3@duo.ucw.cz>
References: <20240507231406.395123-1-sashal@kernel.org>
 <20240507231406.395123-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZ7dzZu1NWj758bL"
Content-Disposition: inline
In-Reply-To: <20240507231406.395123-5-sashal@kernel.org>


--dZ7dzZu1NWj758bL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Explicitly set 'rc' (return code), before jumping to the
> unlock and return path.
>=20
> By not having any code depend on that 'rc' remains at
> it's initial value of -EINVAL, then we can re-use 'rc' for
> the return code of function calls in subsequent patches.
>=20
> Only compile tested.

Only compile tested, and is a preparation for something we won't do in
stable. Does not fix a bug, please drop.

								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dZ7dzZu1NWj758bL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkHMvAAKCRAw5/Bqldv6
8tdtAJ0QUvOQYhb0mACincVCohX+7qZKAACeL239XKrtZ0vHgpELJaeXLFV2BpA=
=Nt/f
-----END PGP SIGNATURE-----

--dZ7dzZu1NWj758bL--

