Return-Path: <netdev+bounces-97220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC158CA126
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 19:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88181F21478
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8C2137C42;
	Mon, 20 May 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLFOZCVL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203953E13;
	Mon, 20 May 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225477; cv=none; b=TSMETg1RuGHk6Uq1Ytr5F1k3ZYz2ID+WyKLlDuB2Ajzp8Pr+sOdwmR+itOvxQBHtqwqXCywcOPtDvxbldnPBQ+W20KzPvDe8KwyohxMhMTWxujyvsVK7JoD+3JXa2V6elPJcqrprRAUYnVI5N868AjUNue5gKcAYqC+vD0pwN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225477; c=relaxed/simple;
	bh=dcRbeZXXPhsr3+R4ot9MrqpKhfby+5UfDHXnDXLmTf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsQ6na8Rljg4EOA9SBz1cG2YhWp/e2TyQPVZbvUJVV/jK1jhTn+ihXHyaRbps3PtPD+CoZqxaQWaYy9lqrpYw+hiUDAU6Vhp21aa8qeVQ5U5MBH09nduZYRHS+hI8/wm5rlH2dHR5oactSWnPl/CrvdhHE8HX6lJeRgiltbYk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLFOZCVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2514EC2BD10;
	Mon, 20 May 2024 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716225477;
	bh=dcRbeZXXPhsr3+R4ot9MrqpKhfby+5UfDHXnDXLmTf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLFOZCVLaHTVAadnpMqrFdDPJX9WTFJBxD4XO8BM0QSZPh5vvkHfu2k2z3p2Yppqn
	 51G/WWUBzwP+2b87UhibetcDxKR1TNUnCB08PDJZieh7Gjo7PmT4ruk+hJMv1s7Jpj
	 9PU0bVD1+EzXdqvQXhH7k7rn7h3XF/TSAC1kBrELO/doaj6VIeuSTujPNsXZHKA+pU
	 u4TltHlq2aqR80Ed5WDihbMg++nnYCH/1Q5gRMzN0t8o2P/bqyxQYIY5kdRO0P5NGz
	 g1Eb9LCsd0fwmI0W1pQgtGG3lUlFdlpHpPseqCsccLput9IQmUQcErFOC8MA7aMpNs
	 E/sgRobiyYUzg==
Date: Mon, 20 May 2024 18:17:52 +0100
From: Conor Dooley <conor@kernel.org>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kip Broadhurst <kbroadhurst@ti.com>, w.egorov@phytec.de
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
Message-ID: <20240520-discard-fanatic-f8e686a4faad@spud>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
 <20240517-poster-purplish-9b356ce30248@spud>
 <20240517-fastball-stable-9332cae850ea@spud>
 <8e56ea52-9e58-4291-8f7f-4721dd74c72f@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UePwvSjabeybRF4C"
Content-Disposition: inline
In-Reply-To: <8e56ea52-9e58-4291-8f7f-4721dd74c72f@ti.com>


--UePwvSjabeybRF4C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 02:18:55PM +0530, Kumar, Udit wrote:
> Hi Conor
>=20
> On 5/17/2024 8:11 PM, Conor Dooley wrote:
> > On Fri, May 17, 2024 at 03:39:20PM +0100, Conor Dooley wrote:
> > > On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
> > > > Modify license to include dual licensing as GPL-2.0-only OR MIT
> > > > license for TI specific phy header files. This allows for Linux
> > > > kernel files to be used in other Operating System ecosystems
> > > > such as Zephyr or FreeBSD.
> > > What's wrong with BSD-2-Clause, why not use that?
> > I cut myself off, I meant to say:
> > What's wrong with BSD-2-Clause, the standard dual license for
> > bindings, why not use that?
>=20
> want to be inline with License of top level DTS, which is including this
> header file

Unless there's a specific reason to use MIT (like your legal won't even
allow you to use BSD-2-Clause) then please just use the normal license
for bindings here.

Cheers,
Conor.

--UePwvSjabeybRF4C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkuFvwAKCRB4tDGHoIJi
0jFQAP9VmADFwFETab2Xw6u8RNuEmVRMP4CsXPoUSZDuZyWVrwEAypOI3tz6MeUd
1duYMmtHWNxu9vJjZAZ0lCOfDKr95wg=
=WAqU
-----END PGP SIGNATURE-----

--UePwvSjabeybRF4C--

