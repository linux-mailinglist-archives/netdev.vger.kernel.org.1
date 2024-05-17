Return-Path: <netdev+bounces-96975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3708C8837
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 16:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6681C23AF8
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D201A2C2E;
	Fri, 17 May 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUflN7Bx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F861863F;
	Fri, 17 May 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956889; cv=none; b=DE3aYHZXCIbk6DzSqeR4SrQV777z+SUl34DLlyEQ0aJj5xCvooklI5T9Pndlo2Nk5LxFJCP+y5zNZHF7ROUbyk2Tciw3bWLgi+nLJpeYP6mFghb+qPCfwLQtnTv3Lx9OSTisEPXSZJ2TmLDU2wUBsP2l1Ea1Mor7cKXtrRwzG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956889; c=relaxed/simple;
	bh=76Nt0O2hctz5gqI5NrYMMVOVC+VAz16TUsv7w9gd1iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG2IbGolpebmiWWylJmt/QpYAfc/RHIgJuW/UhBV5q4PxLpnQckN9IkYawHL6nKez2kthSw7rGOwB8Rx/F82rl6tFJ3HAdYrqHUHER2cQQJqmmjnj8jgmu5Y14d3+D/UfVeJgDl4PPcN+NtJVCISKmqU2C9mlGMR2FAQ/mIJdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUflN7Bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376B1C2BD10;
	Fri, 17 May 2024 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715956888;
	bh=76Nt0O2hctz5gqI5NrYMMVOVC+VAz16TUsv7w9gd1iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUflN7BxRMGJTVijHZpyqwKnd6B/W90RmJmUGRJmKbk2QeYjM7SjmPB+dKpVx5yNU
	 RgPl/hZuI734O8eyUe2k8kB48/lWR3sgSFdbsByc8Lj1og86bmAA+DS9Jnu5parkpy
	 8KnE93m8MmEhenEYZH3M0UclX5WnmR7pIGDCpMD4Z7UkB/4m/wg04Kz0KWp/2pxuMd
	 ELG1wNnngskTUu9eKCGo6FxLyQzkjOIJfzP8vB8m/kDSq0ZJUEj37FaXRWTVMOLvQB
	 FX/OiWMld1wx7c9ndnBsd5Ljy7pCtCO89nHz9Wz3RNvqKyTLSzmXZXMZwfBVUcyOzm
	 wupiO3BAmEIUw==
Date: Fri, 17 May 2024 15:41:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kip Broadhurst <kbroadhurst@ti.com>
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
Message-ID: <20240517-fastball-stable-9332cae850ea@spud>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
 <20240517-poster-purplish-9b356ce30248@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SwZyRbd43sg29RgW"
Content-Disposition: inline
In-Reply-To: <20240517-poster-purplish-9b356ce30248@spud>


--SwZyRbd43sg29RgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 03:39:20PM +0100, Conor Dooley wrote:
> On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
> > Modify license to include dual licensing as GPL-2.0-only OR MIT
> > license for TI specific phy header files. This allows for Linux
> > kernel files to be used in other Operating System ecosystems
> > such as Zephyr or FreeBSD.
>=20
> What's wrong with BSD-2-Clause, why not use that?

I cut myself off, I meant to say:
What's wrong with BSD-2-Clause, the standard dual license for
bindings, why not use that?

--SwZyRbd43sg29RgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkdslAAKCRB4tDGHoIJi
0kTrAQDJ7y89owej/45s2YYuPVZOx3PEXF5YdiHU463IdepEaAEAkgZueywNtp2R
mfeQk9vGdrOgG7SojmF/AuMPTL0j2Qk=
=PCfe
-----END PGP SIGNATURE-----

--SwZyRbd43sg29RgW--

