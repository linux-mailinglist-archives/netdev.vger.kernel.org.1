Return-Path: <netdev+bounces-130963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BE498C3F3
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C46A1F240B9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD51C9ECE;
	Tue,  1 Oct 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kacD0SyN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD4646;
	Tue,  1 Oct 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801546; cv=none; b=ClkslWeR1kHBDAqEgpjZF+pWRxm4+zCrKG9iFD827NceHuk9Uuz8gY3rIJgKKrVnG6u39Z/UELhUBQteVtga5yxUhTdG7pSgdVUoPinWTI8kFKkEKQbV6aeZr/a4U1Q8EobLDOLAo2VoorB7xGVFVmfCy7OaiK1bSnYDTns5gCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801546; c=relaxed/simple;
	bh=O8kM/T6VQqLQbAH1MWMkPU1BLFMr1RVAP4rN0s02mhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXHrCFRK+dbSZPZQ/J0NoA0wDCrDkeLa002gXjvFq1HvWawEDnXWR4s8uDssER9B5rMO0mnYGDnQS4BYfJwt+FP5bFsVV24hG4SbDm4KpsOnRXqFbVgxnOnAW0OZ3RUIjJ6FsqjSIfbL43vQ6A7A7Vs4eNjHLVQ8+empMREqa8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kacD0SyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC87EC4CED3;
	Tue,  1 Oct 2024 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727801545;
	bh=O8kM/T6VQqLQbAH1MWMkPU1BLFMr1RVAP4rN0s02mhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kacD0SyNQ80uIodoXTzcKc2JX5cGyPiCGUzw6s0YxSi2CjAUrOHaktNh5rPZVX2Cf
	 VLja/2UVw6qoDyVyDNLq8XVmEBDu1RyINYWTiWlFvUZ+4Qkq2yFWaEjo6hcsMZbzY5
	 Uw1yrpgyoLQXA+SbRMm6dYf/blaC+peDqcEBrskjBKTjq4O3EFNBpvbA1nPJmmbWMc
	 Ls1TNKKjycwbnTNvTEle44503QULCE4jERtX+tcXY06m7Lf0qFt6q8uDvJTa+9InRJ
	 v3gc1QQ7n7xfiyMokQZJKOArrJAf9vAbVXVNmUMm2mnOoj+hYoBFr8V62z7YE98F7z
	 6WeG2kl8ltEvQ==
Date: Tue, 1 Oct 2024 17:52:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michal.simek@amd.com, abin.joseph@amd.com,
	u.kleine-koenig@pengutronix.de, elfring@users.sourceforge.net,
	harini.katakam@amd.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: emaclite: Add clock
 support
Message-ID: <20241001-battered-stardom-28d5f28798c2@spud>
References: <1727726138-2203615-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1727726138-2203615-2-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RQ7Mi1lo08Qqi5sg"
Content-Disposition: inline
In-Reply-To: <1727726138-2203615-2-git-send-email-radhey.shyam.pandey@amd.com>


--RQ7Mi1lo08Qqi5sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 01:25:36AM +0530, Radhey Shyam Pandey wrote:
> From: Abin Joseph <abin.joseph@amd.com>
>=20
> Add s_axi_aclk AXI4 clock support and make clk optional to keep DTB
> backward compatibility. Define max supported clock constraints.

Why was the clock not provided before, but is now?
Was it automatically enabled by firmware and that is no longer done?
I'm suspicious of the clock being made optional, but the driver doing
nothing other than enable it. That reeks of actually being required to
me.

>=20
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  Documentation/devicetree/bindings/net/xlnx,emaclite.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml b/D=
ocumentation/devicetree/bindings/net/xlnx,emaclite.yaml
> index 92d8ade988f6..8fcf0732d713 100644
> --- a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> +++ b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> @@ -29,6 +29,9 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  clocks:
> +    maxItems: 1
> +
>    phy-handle: true
> =20
>    local-mac-address: true
> --=20
> 2.34.1
>=20

--RQ7Mi1lo08Qqi5sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvwowwAKCRB4tDGHoIJi
0vouAP9IqvWh1E3qUt438ZfMnQXb1mwXnrDkP/wXybmQ18nDAwD9FtCI+Njapmt2
8f69L62OfMnwgP/1HSmAwSMxkZybRwA=
=QW3P
-----END PGP SIGNATURE-----

--RQ7Mi1lo08Qqi5sg--

