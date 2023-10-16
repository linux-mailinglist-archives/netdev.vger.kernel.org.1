Return-Path: <netdev+bounces-41472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954ED7CB127
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B790281613
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB93158A;
	Mon, 16 Oct 2023 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipMf8FZs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A330FB9;
	Mon, 16 Oct 2023 17:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9E5C433C8;
	Mon, 16 Oct 2023 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697476586;
	bh=MRy3up7oqUohj1XgFS/GiBFKY4NG7WbUD1k/7sSM8yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipMf8FZsx8iTVB3wSbylZBSCHdrLB9w4rvDfkqnc8OEH92i+lx+zxbGvLA3SWLgf7
	 inKovQXXDMyiOl88agX16f0oLzdYGl0f/kKBwYw79ppGjETfOyJ8krtmvDh8M+C7sR
	 o1xcU2etDt1GGUk7m/x2cShFClEqOmPkkZT1XVfdJS5xgt6beKobBf+FlARHSh+9vt
	 lP/OevPV6O3qMwS2fzL4p1WRYsP4pjlBRiAJHZ4IC6TVRZqftsbLYewdNCH3EIM0g7
	 fsEq5bObLfsAlf2jYlRrxk6Kh53CEmpcwkdc9QoozbLHqM2eYAn9KDpqGNJSrXDFo5
	 U0u0JM/pkIv8Q==
Date: Mon, 16 Oct 2023 18:16:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Greg Ungerer <gerg@linux-m68k.org>, iommu@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH 01/12] riscv: RISCV_NONSTANDARD_CACHE_OPS shouldn't
 depend on RISCV_DMA_NONCOHERENT
Message-ID: <20231016-outwit-bungee-b46cf212c292@spud>
References: <20231016054755.915155-1-hch@lst.de>
 <20231016054755.915155-2-hch@lst.de>
 <20231016-walmart-egomaniac-dc4c63ea70a6@wendy>
 <20231016131716.GA26484@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n9y3/cEO82Secmi+"
Content-Disposition: inline
In-Reply-To: <20231016131716.GA26484@lst.de>


--n9y3/cEO82Secmi+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 03:17:16PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 16, 2023 at 01:49:41PM +0100, Conor Dooley wrote:
> > Hey,
> >=20
> > On Mon, Oct 16, 2023 at 07:47:43AM +0200, Christoph Hellwig wrote:
> > > RISCV_NONSTANDARD_CACHE_OPS is also used for the pmem cache maintenan=
ce
> > > helpers, which are built into the kernel unconditionally.
> >=20
> > You surely have better insight than I do here, but is this actually
> > required?
> > This patch seems to allow creation of a kernel where the cache
> > maintenance operations could be used for pmem, but would be otherwise
> > unavailable, which seems counter intuitive to me.
> >
> > Why would someone want to provide the pmem helpers with cache
> > maintenance operations, but not provide them generally?
> >=20
>=20
> Even if all your periphals are cache coherent (very common on server
> class hardware) you still need cache maintenance for pmem.  No need
> to force the extra text size and runtime overhead for non-coherent DMA.

Ah, right.

> > I also don't really understand what the unconditional nature of the pmem
> > helpers has to do with anything, as this patch does not unconditionally
> > provide any cache management operations, only relax the conditions under
> > which the non-standard cache management operations can be provided.
>=20
> They simply were broken if a platform had non-standard cache mem but
> only coherent DMA before.  That's probably more a theoretical than
> practial case, but still worth fixing.

And this part of it makes more sense with the above use-case explained.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--n9y3/cEO82Secmi+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS1v5AAKCRB4tDGHoIJi
0uu/AQDsd+QvHSok4Q8k4HHYfsUMrdFaeTVLhvRpSi+kRG+LLwD/T6ws6vJoKrWg
ZkwzD5bj5QIZjaHiwVcDzL6nh9r1gAo=
=qQsV
-----END PGP SIGNATURE-----

--n9y3/cEO82Secmi+--

