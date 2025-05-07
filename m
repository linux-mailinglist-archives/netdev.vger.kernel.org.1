Return-Path: <netdev+bounces-188559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8989AAD5E4
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080FF1B67C42
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890482010F6;
	Wed,  7 May 2025 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpVGih2l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B014884C;
	Wed,  7 May 2025 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598867; cv=none; b=SBl8JNQp5WiNPUOpgxMhA+mc8O8CNoflGx8Fk3bTAYiQm42lIGF9VpWTU4d7SxAnDaBc7t8HwEMKRJrNvavNrFyz1gdqsRRMnrdsN3MVCwuBmLa7iWM8EEuzPN1pvXml3pO09aAz/oh3v8eZDffMUxso/dEZWMJRfnQZC2jN8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598867; c=relaxed/simple;
	bh=0D+Tdo2OwXLWYP3IRAD3ktKnQD9CgJbw3LACcvS8npc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkYNFFm7BzuNXWPNSPZVbA6IJ5dTVQBIGftETpTwGq/z+bFIow8hRlMtA/MMRURX32LDdIUy1L4uVfId4sx95QxuV+t0levXgZ26ygtCGy8mVToVv7MnxvvK6QT8qZFkYnpuoQd1IRqmvhdvqJWhhJ8w0bwHD6ZbDq5S/UjY7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpVGih2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797E8C4CEE7;
	Wed,  7 May 2025 06:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746598866;
	bh=0D+Tdo2OwXLWYP3IRAD3ktKnQD9CgJbw3LACcvS8npc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpVGih2lGPKKqhgBoViAsh2MGm7pU9k3tmPDJlX/6Zfzf66RSKHMbHaiJe/bL44uz
	 EYoUXPly3E0nL3bTAHLX0d1NXdwc6yzRLvahyep+8TL/eC3AIgsrFM3w6fnyiT7rGr
	 4zJ/wt5iSTtpNttYF7i4ChBzUbAtjMCIdcyR+smEWqiL6gDfEEjFKFYGKNM6gVlB69
	 MPsP1XTGCz1pznQMDhcgkqJ75xZHF8SRfwGP0poz0l9eahN80KPlmdz0Qs2/Z0nhST
	 QomTVvLuAJCCVbZ0CYvZjFTh6sRvPGrpU/pVQjKbc0XRZxuWWloB9JwTzrQNwom4Zy
	 q1MifAIZxihog==
Date: Wed, 7 May 2025 15:21:04 +0900
From: Mark Brown <broonie@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Sander Vanheule <sander@svanheule.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap: remove MDIO support
Message-ID: <aBr70GkoQEpe0sOt@finisterre.sirena.org.uk>
References: <c5452c26-f947-4b0c-928d-13ba8d133a43@gmail.com>
 <aBquZCvu4v1yoVWD@finisterre.sirena.org.uk>
 <59109ac3-808d-4d65-baf6-40199124db3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JU5l45uWXeqTMhD2"
Content-Disposition: inline
In-Reply-To: <59109ac3-808d-4d65-baf6-40199124db3b@gmail.com>
X-Cookie: Well begun is half done.


--JU5l45uWXeqTMhD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2025 at 08:09:27AM +0200, Heiner Kallweit wrote:
> On 07.05.2025 02:50, Mark Brown wrote:
> > On Tue, May 06, 2025 at 10:06:00PM +0200, Heiner Kallweit wrote:

> >> MDIO regmap support was added with 1f89d2fe1607 as only patch from a
> >> series. The rest of the series wasn't applied. Therefore MDIO regmap
> >> has never had a user.

> > Is it causing trouble, or is this just a cleanup?

> It's merely a cleanup. The only thing that otherwise would need

If it's not getting in the way I'd rather leave it there in case someone
wants it, that way I don't need to get CCed into some other series
again.

> improvement is that REGMAP_MDIO selects MDIO_BUS w/o considering
> the dependency of MDIO_BUS on MDIO_DEVICE. REGMAP_MDIO should
> depend on MDIO_BUS.

Well, REGMAP_MDIO should be selected itself so none of these selects or
dependencies would do anything anyway.

--JU5l45uWXeqTMhD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmga+80ACgkQJNaLcl1U
h9DZSwf/UacNqpLSOgvwOYhS5g6GaTnVoP8wSBCvKXgvmQX1BH+dyvEQa35e6Ltb
Pcl99zYDXZxthp4kPME4CGB/QOK2aJS5TptkJLf8XdKWJ7GUdyNMq7000w7A9kSI
yJQ4LDODNx6WTRtCjQr6mIj0xD3IysQ05KgZo1i0v61S9+HT9lE6wbWlEK5xmjMs
HeZP5Adqw2DMxQ3LxrscJE04p3B3ym8oQdErEjuZTWKyi8Xm9S94J3vO1q+sK/cK
4jmC8BLbWSijMXHsXCPwOnwHIBMIgxrekLERsP7vIme2c+H7M13YMdTttFaR3qlU
WB/6CgjDm/z1KIPkNPG4NFoiG8/gXA==
=stj/
-----END PGP SIGNATURE-----

--JU5l45uWXeqTMhD2--

