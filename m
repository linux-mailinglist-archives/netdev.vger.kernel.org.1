Return-Path: <netdev+bounces-183819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FCA9221A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B3A1B60F7F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E1254AE9;
	Thu, 17 Apr 2025 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ0V1oRD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5580253B7E;
	Thu, 17 Apr 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905485; cv=none; b=el6NHnNfHlkt98969nWX/+qz5oKIH7pSqlo8omZ7UDJEkLMrPrm/MwVg3jNf+2VyebX9ya1GJTBW+o7opxd69HCKWc2gCmKyTE10X9P1HwJEIaP+AYiyytyRhLGy4vN/ebMlFJoCsg6xgK+9f8mqPFpulrP6i8g3SBexhd5h4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905485; c=relaxed/simple;
	bh=GllX0jW++yamnFVlA/TohYrJ14gAk/iVgW+F+LU/2Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxP/gUS/R2zEnrZ8W6P7+8CBAP3UI2Qvs3a4YKJdQuAkhl0tHoHNfH59qgOfU9tYb+3t9ONGe2CLKX484Hg4XecrunU4GShA0cclfQ2ztKcmv6rDPZKoenpO3coddhSCTKYEcyNtVcGN10JfjI0sHf6w4kdQMAPieqjvd4uM40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ0V1oRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7547C4CEE4;
	Thu, 17 Apr 2025 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744905484;
	bh=GllX0jW++yamnFVlA/TohYrJ14gAk/iVgW+F+LU/2Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQ0V1oRDvX24v/6RSZVX66S7ccPqodVfH7RslUxpcOoTtqkMoEJDxvFR29+yhds0M
	 bH4uNHhstKLZo00EpHHQUhQquo+924EbRJCudhWW48H393FbRiJAvKeAfaS7Z+veUq
	 lrraP3NIejIzAWPe/gywCRA+27TZeTpjCvjKY/xYfCvpVcKfhRuw8cUvLo1Oa8CdbT
	 YiQXxO2QE0DATOljVbMwW2qezlgo0rx9nCIQptqiTlZo+5aSXtJJkqEMadO+LmsqLr
	 ktcl6P90ENpas3AIy+0lPBNBnHdNG45t5h3LsUEGIungpodbooJpUz2ZQtNtDPbxdZ
	 8LUqEPSf0/ITg==
Date: Thu, 17 Apr 2025 16:57:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/8] mfd: Add Microchip ZL3073x support
Message-ID: <4324af33-4be7-45bc-b7d2-b400a7865319@sirena.org.uk>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yqusERaWlBR5Yr5t"
Content-Disposition: inline
In-Reply-To: <20250416162144.670760-4-ivecera@redhat.com>
X-Cookie: Put your trust in those who are worthy.


--yqusERaWlBR5Yr5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 16, 2025 at 06:21:39PM +0200, Ivan Vecera wrote:

> +static const struct regmap_config zl3073x_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= ZL_RANGE_OFF + ZL_NUM_REGS - 1,
> +	.ranges		= &zl3073x_regmap_range,
> +	.num_ranges	= 1,
> +	.cache_type	= REGCACHE_RBTREE,

Unless you have a specific reason to use something else you should
probably use _MAPLE these days, it's a more modern data structure and
makes choices more suited to current hardware.

--yqusERaWlBR5Yr5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgBJQUACgkQJNaLcl1U
h9DwRQf/WkJ1VCnbTK4RrOyMtq2TWaDZ4zhsQwJE3IcTykdPOLVVa0c8Jn48Jgz/
cpRTJ7e1sMujvXUVP+HpjYmdp7WdF6ddRwuQMwFEdjYqDInna46avYqJ47WHUrQF
E2ItuXZ3U8q7IY1SahwTVg2wI8WlAkEoSMAQQD21RzJi4/PmjfUUvj0sE4mlxc3J
VLmpdAsrJax0Rmzez2M8POGApjt+JuQdj4+pI3VGc+KnwTbuOVzx2XZiOIb7l8ry
EDy5XWfZb/Zh9qVHr+d9SgCKujv8VynRVRjmn/X/wTCyTAXeKg9cKhsKJs4/uGee
9g/fKvZ5awzkWWgfgBq53cFs3MkMpw==
=q/zk
-----END PGP SIGNATURE-----

--yqusERaWlBR5Yr5t--

