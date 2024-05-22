Return-Path: <netdev+bounces-97599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBB48CC437
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B14A282BB8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0CB768EC;
	Wed, 22 May 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Top1XGc2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31741171C;
	Wed, 22 May 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392267; cv=none; b=FMK5ixOCcNUaWppvyEfrIVHoQ8z0oz8AzK74CfAhA0oP3FEH+V4Zmz12tC7N2sJrV/o+4eMFT6NtfZeaClX+MdmjJkVyS/dL5/1bL88FCywBwLCmS1AdW2IwYDdxWYqjS2CSFnP0fT17PfTSIbf3/wT0GVv6QeFpdlh59h+L9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392267; c=relaxed/simple;
	bh=3YRIw4xGban3ncUZ5m5pmLWIF/RlgCbtMqm+fj2vRaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2TCnEWQzGiWlXOBYfpBomqri8QoJuRPD7+TBosNAtsrFoOxiQlPerZ92L+ZPIRxG2UnpdpmACEBjBSNSsnf4rLPuXeDzR52N4SXSsqBk2pZxA0IqaBDkf1DuutfjZkJF63+euH6YqF2xRqmcIujUGfQZGfKmuia5iPfnmmxDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Top1XGc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B1CC32782;
	Wed, 22 May 2024 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716392267;
	bh=3YRIw4xGban3ncUZ5m5pmLWIF/RlgCbtMqm+fj2vRaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Top1XGc2EHvGIykobL/WY78wXCOg+w5a4zd0y+dm/qbjgLc3q8SxDIdiRjmoZ86wb
	 YhJIwjF46lMw4UK0f8u8YsgrBaGhFsYQlTNuLvWr1u+agWobGjDF/uiq5K0cK128UQ
	 CcvCU86D7bVM9PLCUxcU2L7FQX4eItVjH53WQUg1MybMFRNRn3slIElFLu6+9XqA/P
	 3vKKHlbIyt7BpajuUSElOlmtwdgGQ3HGN/BNYKbRNLMyZcBlakr6zGLI7shq3cE4Kg
	 ROzqsFUBHWpdAx+gmTocP4lAfeg265n7ButbzdW08WCtA/zL8n3tbGELt1J07MYYX7
	 iVeXCwGpt4mvw==
Date: Wed, 22 May 2024 16:37:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	"Kumar, Udit" <u-kumar1@ti.com>, vigneshr@ti.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kip Broadhurst <kbroadhurst@ti.com>, w.egorov@phytec.de
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
Message-ID: <20240522-trash-unshaven-226dba991c3f@spud>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
 <20240517-poster-purplish-9b356ce30248@spud>
 <20240517-fastball-stable-9332cae850ea@spud>
 <8e56ea52-9e58-4291-8f7f-4721dd74c72f@ti.com>
 <20240520-discard-fanatic-f8e686a4faad@spud>
 <20240520201807.GA1410789-robh@kernel.org>
 <e257de5f54d361da692820f72048ed06a8673380.camel@redhat.com>
 <20240522-vanquish-twirl-4f767578ee8d@spud>
 <20240522134001.tjgvzglufwmi3k75@imitate>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ppzR8UWyzGuYSJha"
Content-Disposition: inline
In-Reply-To: <20240522134001.tjgvzglufwmi3k75@imitate>


--ppzR8UWyzGuYSJha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 08:40:01AM -0500, Nishanth Menon wrote:
> On 11:25-20240522, Conor Dooley wrote:
> > On Wed, May 22, 2024 at 10:04:39AM +0200, Paolo Abeni wrote:
> > > On Mon, 2024-05-20 at 15:18 -0500, Rob Herring wrote:
> > > > On Mon, May 20, 2024 at 06:17:52PM +0100, Conor Dooley wrote:
> > > > > On Sat, May 18, 2024 at 02:18:55PM +0530, Kumar, Udit wrote:
> > > > > > Hi Conor
> > > > > >=20
> > > > > > On 5/17/2024 8:11 PM, Conor Dooley wrote:
> > > > > > > On Fri, May 17, 2024 at 03:39:20PM +0100, Conor Dooley wrote:
> > > > > > > > On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
> > > > > > > > > Modify license to include dual licensing as GPL-2.0-only =
OR MIT
> > > > > > > > > license for TI specific phy header files. This allows for=
 Linux
> > > > > > > > > kernel files to be used in other Operating System ecosyst=
ems
> > > > > > > > > such as Zephyr or FreeBSD.
> > > > > > > > What's wrong with BSD-2-Clause, why not use that?
> > > > > > > I cut myself off, I meant to say:
> > > > > > > What's wrong with BSD-2-Clause, the standard dual license for
> > > > > > > bindings, why not use that?
> > > > > >=20
> > > > > > want to be inline with License of top level DTS, which is inclu=
ding this
> > > > > > header file
> > > > >=20
> > > > > Unless there's a specific reason to use MIT (like your legal won'=
t even
> > > > > allow you to use BSD-2-Clause) then please just use the normal li=
cense
> > > > > for bindings here.
> > > >=20
> > > > Aligning with the DTS files is enough reason for me as that's where=
=20
> > > > these files are used. If you need to pick a permissive license for =
both,=20
> > > > then yes, use BSD-2-Clause. Better yet, ask your lawyer.
> > >=20
> > > Conor would you agree with Rob? - my take is that he is ok with this
> > > patch.
> >=20
> > I don't think whether or not I agree matters, Rob said it's fine so it's
> > fine.
>=20
> Just to close the loop here: Udit pointed me to this thread and having
> gone through this already[1] with internal TI teams, the feedback we
> have gotten from our licensing team (including legal) is to go with
> GPL2 or MIT. BSD (2 and 3 clauses) were considered, but due to varied
> reasons, dropped.

> [1] https://serenity.dal.design.ti.com/lore/linux-patch-review/2024010923=
1804.3879513-1-nm@ti.com/

FWIW, this is some internal-only link.


--ppzR8UWyzGuYSJha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk4RRgAKCRB4tDGHoIJi
0m8iAP9jFWjwj8aEFrkB3HLKIlQDhPOWBuiUMMerAM0cG0KaMgD+NODN0v5Iasoe
aS9UOo2PdFpVa3pipDsLL4zD3r8rkwE=
=rWro
-----END PGP SIGNATURE-----

--ppzR8UWyzGuYSJha--

