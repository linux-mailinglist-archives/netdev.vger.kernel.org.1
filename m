Return-Path: <netdev+bounces-117232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3869794D2F9
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4961281D87
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FAB197A98;
	Fri,  9 Aug 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt2x7KNx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C61197A7A;
	Fri,  9 Aug 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216228; cv=none; b=A7u3MeiD9U/bj13WuHr1L4BguDQMk65tR8CWT8r4bUNqs8ZFuHs+vEqcJdQoUzkRLB2mHdcp8W183Wmb0MYhju9gY1BT6qRA9cmLqEbaB5goXLY3/fpGFZAwhqM12iqX/PM/2VxlEp/X8hZVguq0tZy0KwrgTEmMc5ZJ7HqsS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216228; c=relaxed/simple;
	bh=P2QtE8OHYSp/8bvRdhI4PJKM3LlbRcrXcb+xFnH/vbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeL0cWkMd4x9fOAwf2KzI4XnVht1eTmJv0WQQHEKhu4d41aE6RGIgkaJ5cwQpNpF1fzfyLX0JZtswzPKTsac9uDXDYQ5o/nSuEB4alwqOkct7LjVob2pOZIsMxkt95otsz2dP5hYKSh6LPvzHLoarkfPjp/sgTjpyOWPfF9xa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt2x7KNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC362C32782;
	Fri,  9 Aug 2024 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216227;
	bh=P2QtE8OHYSp/8bvRdhI4PJKM3LlbRcrXcb+xFnH/vbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pt2x7KNxK1bt5Oa0mikDIAjU5w/v44wgKDBEm1T/MwSgkZjNxNBwZMKGObRzr3pI0
	 7b1crrbN3jFk9/81JriBPG3I+7HrU9HXuAhaoCLuM79FI0DOkOPLq4Rto3KGe0S7k6
	 QHCVxME/MBg0uKkgUPmI6ggICjYKZGMwznHaBuBDINEqwFNr/2DYeJ0NSIJtZvYzNw
	 9rJhs1lvw5XZftZHZeCZC/j1D0ADJBCMwLF7JuvHxoSKchLJshnm4/nlGVN5lfbYsa
	 lwdX6PuSVXvzr3fFltePrDMT05S1PQ+BK9/FRGZAVkiNYy9cXfm04hwSLyqtzCgm2q
	 mYJjao7/0xh5A==
Date: Fri, 9 Aug 2024 16:10:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Linux Team <linux-imx@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: fec: add pps channel
 property
Message-ID: <20240809-euphemism-degrading-f2b329ccce50@spud>
References: <20240809094804.391441-1-francesco@dolcini.it>
 <20240809094804.391441-2-francesco@dolcini.it>
 <20240809-bunt-undercook-3bb1b5da084f@spud>
 <20240809144914.GA418297@francesco-nb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w/FwCQG0jzaZZ8B9"
Content-Disposition: inline
In-Reply-To: <20240809144914.GA418297@francesco-nb>


--w/FwCQG0jzaZZ8B9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 04:49:14PM +0200, Francesco Dolcini wrote:
> On Fri, Aug 09, 2024 at 03:27:39PM +0100, Conor Dooley wrote:
> > On Fri, Aug 09, 2024 at 11:48:02AM +0200, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > >=20
> > > Add fsl,pps-channel property to specify to which timer instance the P=
PS
> > > channel is connected to.
> >=20
> > In the driver patch you say "depending on the soc ... might be routed to
> > different timer instances", why is a soc-specific compatible
> > insufficient to determine which timer instance is in use?
> > I think I know what you mean, but I'm not 100%.
> >=20
> > That said, the explanation in the driver patch is better than the one
> > here, so a commit message improvement is required.
>=20
> This was clarified by NXP during the discussion on this series [1] and the
> commit messages were not amended to take this new information into
> account, my fault.
>=20
> I would propose something like this here:
>=20
> ```
> Add fsl,pps-channel property to select where to connect the PPS
> signal. This depends on the internal SoC routing and on the board, for
> example on the i.MX8 SoC it can be connected to an external pin (using
> channel 1) or to internal eDMA as DMA request (channel 0).
> ```

That's definitely better, as it illustrates why the compatible is not
sufficient.

--w/FwCQG0jzaZZ8B9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYxXQAKCRB4tDGHoIJi
0nDAAQC0z2Kl9NY506ibzdDJaCI+z0EzhOgMwcAWUwKMd6ohTAD/dByz+NALI2JS
Q8tXIcDoTnv+eZEIECKJkERYxMfeLws=
=CMis
-----END PGP SIGNATURE-----

--w/FwCQG0jzaZZ8B9--

