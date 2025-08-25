Return-Path: <netdev+bounces-216553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D7AB34777
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D225E7614
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120072FDC27;
	Mon, 25 Aug 2025 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmBBlIaw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC721ADDB;
	Mon, 25 Aug 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139520; cv=none; b=jng3BfINrvaz7FxTzkPcQyWxjZLmgY435y+lpmmSxsirs/RXHwLxvxPTJwcgavSAzxxnueJlzOC4pwO2IccWZSmXXmMCHswZWFbVowuzwTEvF2RqhJcNCHkTNJA9ENGTvWCK1A748AqDyCAaVLHYEbbAKjQ5olD++UYNM359V1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139520; c=relaxed/simple;
	bh=/mx6M03nN9EBf2D+R3XgMuMXnvHlGCvvTh5QwNvJmOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVO6iw+HN6uQpCheLSMYaqsPo7oEH2RPXGnTMb9Un4Ab1qjEd4mZdiNRXz2XYprPfg8Q8vwRxcQ7MlmDabg/d1JCBQkaVn1s3eotopm9ViNF4m5UEatTvAjPDgGne/HWyk0NoKNtnZScPFTuHfBCU0/qLSQUS9paVeEoQZQ1coI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmBBlIaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08878C4CEED;
	Mon, 25 Aug 2025 16:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139519;
	bh=/mx6M03nN9EBf2D+R3XgMuMXnvHlGCvvTh5QwNvJmOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmBBlIawR5wMXRqCRcwZxwluKrnG53+7Eexub+Eb4QHHBxYFlgXa7snpq/o5kyKMF
	 cceClCD0lFbBX7+wr34F1Ka99TbPd+uMZi8wqQPI2igG+OJ4W64MUEWJ41Jilwi64P
	 JNjvO0FGbE7G5LCOVY9RsslRqzvK26BoSFXE0uvv/qS1J8SZhcBxNAnoSFf1Cnkhq8
	 RyQk+8A6vqAL9/XowiK9vNifMZfpLKEJN75xKlWWtUtNgJY+2Gr/8hC0o0OBSP+S3A
	 RcLaMk/B05JJVSUvxmwGYF0LfAfi3twS13e7OqXKyFSONl+9PxUswKsgfue2QNgUG5
	 htJgs45xND/xg==
Date: Mon, 25 Aug 2025 17:31:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: krzk@kernel.org, mgreer@animalcreek.com, robh@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nfc: ti,trf7970a: Restrict the
 ti,rx-gain-reduction-db values
Message-ID: <20250825-blazer-drift-f4c8d3d9fc8b@spud>
References: <20250825161059.496903-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O3y1f/7QYXUFWVpO"
Content-Disposition: inline
In-Reply-To: <20250825161059.496903-1-festevam@gmail.com>


--O3y1f/7QYXUFWVpO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 01:10:59PM -0300, Fabio Estevam wrote:
> Instead of stating the supported values for the ti,rx-gain-reduction-db
> property in free text format, add an enum entry that can help validating
> the devicetree files.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--O3y1f/7QYXUFWVpO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKyP+wAKCRB4tDGHoIJi
0maOAP9Bxtnc4chWw8bspT3xPgke7nHYHh6mnrr6LePUSoYDwgEA6lMjBxtnB93s
i+dgYs0tTh0PqSzUJHsXdlXpc2g3hwE=
=HznD
-----END PGP SIGNATURE-----

--O3y1f/7QYXUFWVpO--

