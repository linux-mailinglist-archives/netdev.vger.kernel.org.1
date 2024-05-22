Return-Path: <netdev+bounces-97529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9534A8CBF3A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 12:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 338DDB20FF6
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ED1823B0;
	Wed, 22 May 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUxynlyh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A908173C;
	Wed, 22 May 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373561; cv=none; b=fHDOGFd0KBY5ZJu9V1Y1a5QwJ7685LBhR+y3ib1M8Ok/vMfL8r1+e0y+Y7lNn4m0DDHZLe3oiIudGxpHFipvxvC2L7ffxH0lmI4DfjvhTD/XqGvh50XevgbE6A1+IJF+FNG9FQOVcj10lbu2XUKLqfRjK8ZddcH9D0+Rg6uxn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373561; c=relaxed/simple;
	bh=oA6una41EFEgvtUccLdrby/eP40T87tkg7tWx1WpKhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XutjoHxT1ou2aAdVf4wIWBF535ky68hg0RfDINURNxk6PBedQCyW6TWTijEXymStLn3Q8wd4ay1+93Jq8ja60XMA3Ys1Eboe4EV5t7dMEouv7QhxtmeCc+BfHbj0VCnvLYkhDX7ru7q2bpxX77zPY2CdQ/UQuXc4tINlFhyL2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUxynlyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3B9C2BD11;
	Wed, 22 May 2024 10:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716373561;
	bh=oA6una41EFEgvtUccLdrby/eP40T87tkg7tWx1WpKhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUxynlyhTjqd/3ZbJvqxVlJZb6rxqJ3wXZKUVxrOVckUQqb/vkB2ckl8Kky0UBzY/
	 ZhE894o1P2UwOInamMXQ1XgJhlBBNS/8mI/T3sjXxq/kJxa92tOQvrAz4TEMKMhfuC
	 RHvruOdV9SbvyMIk4FGR8xebmdNCdi1J/06cX7sOUaF4okIc4ViQPTd8t+xd1QsXsh
	 qqLpJry7UrfspErAOg3NbPOENrWpmqVK1PYBDKej8KtKLkmuENTOmfwG2frrFhgilA
	 CbUHwpV10hVOSFseXTbKi31vr7dtrM4ViK7wf0oWHSENSbOVVeOBijzoZnZSKhyiGF
	 vO33v/dfO5mXg==
Date: Wed, 22 May 2024 11:25:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>, "Kumar, Udit" <u-kumar1@ti.com>,
	vigneshr@ti.com, nm@ti.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kip Broadhurst <kbroadhurst@ti.com>, w.egorov@phytec.de
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
Message-ID: <20240522-vanquish-twirl-4f767578ee8d@spud>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
 <20240517-poster-purplish-9b356ce30248@spud>
 <20240517-fastball-stable-9332cae850ea@spud>
 <8e56ea52-9e58-4291-8f7f-4721dd74c72f@ti.com>
 <20240520-discard-fanatic-f8e686a4faad@spud>
 <20240520201807.GA1410789-robh@kernel.org>
 <e257de5f54d361da692820f72048ed06a8673380.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jaMN+FRy+sQyRzBS"
Content-Disposition: inline
In-Reply-To: <e257de5f54d361da692820f72048ed06a8673380.camel@redhat.com>


--jaMN+FRy+sQyRzBS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 10:04:39AM +0200, Paolo Abeni wrote:
> On Mon, 2024-05-20 at 15:18 -0500, Rob Herring wrote:
> > On Mon, May 20, 2024 at 06:17:52PM +0100, Conor Dooley wrote:
> > > On Sat, May 18, 2024 at 02:18:55PM +0530, Kumar, Udit wrote:
> > > > Hi Conor
> > > >=20
> > > > On 5/17/2024 8:11 PM, Conor Dooley wrote:
> > > > > On Fri, May 17, 2024 at 03:39:20PM +0100, Conor Dooley wrote:
> > > > > > On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
> > > > > > > Modify license to include dual licensing as GPL-2.0-only OR M=
IT
> > > > > > > license for TI specific phy header files. This allows for Lin=
ux
> > > > > > > kernel files to be used in other Operating System ecosystems
> > > > > > > such as Zephyr or FreeBSD.
> > > > > > What's wrong with BSD-2-Clause, why not use that?
> > > > > I cut myself off, I meant to say:
> > > > > What's wrong with BSD-2-Clause, the standard dual license for
> > > > > bindings, why not use that?
> > > >=20
> > > > want to be inline with License of top level DTS, which is including=
 this
> > > > header file
> > >=20
> > > Unless there's a specific reason to use MIT (like your legal won't ev=
en
> > > allow you to use BSD-2-Clause) then please just use the normal license
> > > for bindings here.
> >=20
> > Aligning with the DTS files is enough reason for me as that's where=20
> > these files are used. If you need to pick a permissive license for both=
,=20
> > then yes, use BSD-2-Clause. Better yet, ask your lawyer.
>=20
> Conor would you agree with Rob? - my take is that he is ok with this
> patch.

I don't think whether or not I agree matters, Rob said it's fine so it's
fine.

Cheers,
Conor.

--jaMN+FRy+sQyRzBS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk3INAAKCRB4tDGHoIJi
0qfrAQD41SYcr6tANTE/Fs4iO5RWRUM2zbygUYrkHQN82kRRWQEAxyhxcgn4366j
Be32KR4FnYRL7hVIh8iBnNbFXpvoUgI=
=ZSZe
-----END PGP SIGNATURE-----

--jaMN+FRy+sQyRzBS--

