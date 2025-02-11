Return-Path: <netdev+bounces-165248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A81A313F1
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0653A6013
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B2F1E5018;
	Tue, 11 Feb 2025 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/Osz5Jb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97901E282D;
	Tue, 11 Feb 2025 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297976; cv=none; b=IZ1/XA1uhfxhQwRs3J26nV04ZgvF0gdEcIFD+81IEw8WWS88A+4CJXyPuviO+AnXS32up6NWluRWDy1kCs1fVm/ndsJzIB7o9uqjFfpRu7/agBk9OrT/Tm8AKolD4LTJWv62FU/MYDda4LMkYDHvq4i021iRwyQ3zeROg6MOUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297976; c=relaxed/simple;
	bh=ZeJSRLFk7KzsTUlyQirGAXBVKKCiGm4LCGhgWOZKRJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmV3DJw6e+UmuZezcDKpDU+wUDic02z9Y7OWZLabAL5yp7r7+ep7wECamBojjdeJgXeqnQDcekXQOtOIjygcyCagBT3YUgALEov7ow3uO90BoWwkl3BcugAbm9Uy2eBwWIcz5rewUPKCZhLBFMXhm8hQO2QjWatfOposvDMw5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/Osz5Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17E2C4CEDD;
	Tue, 11 Feb 2025 18:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297976;
	bh=ZeJSRLFk7KzsTUlyQirGAXBVKKCiGm4LCGhgWOZKRJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/Osz5JbUrSHd8Om2IbxPFGYYL42La6X+hZMhI8cImporz2QzFoqtyehmGRht+viM
	 sPw0rF//J+UBF2IR3YmhFIDgSIznzMXXoYd3fTdqmJPy3zYr6UbtDfy+g8m7MAE934
	 upZ10ewuGLmO7CT3W28CaiYl5Dm+RyxOyEE8fH7G6qJTXD1z409uGqePU2zzCIkwWJ
	 oow7KqxmXHGhY4mDI6/KLe7XAGTnF6ECpXiF6uBzIMuKOlkOWlsOrVjAFF4TGlhzXf
	 aKJTlOEQnqMEe2RB2/70p8MARoJ7vz8lrxR+rxu+vN+e+rg58M1cMgQER/GQXduqGR
	 8DjomiUPvWf+A==
Date: Tue, 11 Feb 2025 18:19:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: stm32: document stm32mp257f-dk board
Message-ID: <20250211-napping-womankind-3c3146c6b2d6@spud>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
 <20250210-b4-stm32mp2_new_dts-v1-1-e8ef1e666c5e@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8ZGf21frFMU/x+4E"
Content-Disposition: inline
In-Reply-To: <20250210-b4-stm32mp2_new_dts-v1-1-e8ef1e666c5e@foss.st.com>


--8ZGf21frFMU/x+4E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 04:20:55PM +0100, Amelie Delaunay wrote:
> Add new entry for stm32mp257f-dk board.
>=20
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--8ZGf21frFMU/x+4E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6uUswAKCRB4tDGHoIJi
0gNGAP4rXS2pU6/TpiaMyh6ngiLT4et79Hj10mAIW2mYBmMPegD/Uz/xYHHM4rFT
xeXShH6AVOss5Xm80BVMmzfIPq1bows=
=9R2h
-----END PGP SIGNATURE-----

--8ZGf21frFMU/x+4E--

