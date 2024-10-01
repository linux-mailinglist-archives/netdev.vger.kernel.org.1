Return-Path: <netdev+bounces-130966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F598C43B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFDC1F21E99
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097EB1C9EC4;
	Tue,  1 Oct 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaY7fEq6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF161C6F7B;
	Tue,  1 Oct 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802626; cv=none; b=QOJvRWiq1jAICkfbeyyIWhxvjOABJpj2B3R9wSNgZdr85Y43dHJIC1ZI/QtwB1qQGxQsGWxY7eVR6PCfNzmQzlQ4xrtRyrBlL+hkzidBtDMlD0gVH1YIWJYoZHmVNr9WLVTfnCAPebBZjeP2Mpk5/bd2aed+FVMkjbNF1HXo2YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802626; c=relaxed/simple;
	bh=SiGJOCfWx/20ZNw6yG9i8mDJDLn54cMmgbcdMBfdotM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBKgLPYiD8xuixhEhO1nL4D8NwbgWKxCxZcZQAuefGOnlzoDvZoEPMV3Y5JA0ZD6glxJ7VQMQZGI7LaMv/nNmBuZu++ZyH+sqVEXtVZdbhlJe5sAs7U5k/UNHZzCFV9aORV9ubeT58r7E3UABqyqRwMiANXoHcoahfRNYB2byA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaY7fEq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD94C4CEC6;
	Tue,  1 Oct 2024 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727802626;
	bh=SiGJOCfWx/20ZNw6yG9i8mDJDLn54cMmgbcdMBfdotM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaY7fEq6xPZExPCIBDaYDgJ2q8g9jHTdjgvahH4/HlQk8iszgTQWybHvik5hEq7zo
	 Bd/sa+ZHQxCYOQyF6i+6HoFYtaHU8hxvOkPicG304PxYEikeM+0O+Dr/Pe3Uk8PD3G
	 9OVlSsK7/P9dcaf5tPoRtD9b2pA8z3nRSq4wGyt/D0N2M4tub90lDbNC1qPadrySyA
	 5jkahfBAwfbUuI+8sxNvM1fUhzNEmFb5wJP/zja/NkyPTBQN7g6OmnawkzGsIvNS9F
	 TIcrJHuRpm0qqq113jDR7Zt5Tpt644bPNNT9pRSjHTYOsfP5EbDirJNVRvYMqzhCWi
	 9sB9SHI2npbZg==
Date: Tue, 1 Oct 2024 18:10:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com, Ravikanth Tuniki <ravikanth.tuniki@amd.com>
Subject: Re: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Add missing reg
 minItems
Message-ID: <20241001-confined-sedative-2917499eb5d6@spud>
References: <1727723615-2109795-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dq1H5QpMGtBiF6fu"
Content-Disposition: inline
In-Reply-To: <1727723615-2109795-1-git-send-email-radhey.shyam.pandey@amd.com>


--dq1H5QpMGtBiF6fu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 12:43:35AM +0530, Radhey Shyam Pandey wrote:
> From: Ravikanth Tuniki <ravikanth.tuniki@amd.com>
>=20
> Add missing reg minItems as based on current binding document
> only ethernet MAC IO space is a supported configuration.
>=20
> There is a bug in schema, current examples contain 64-bit
> addressing as well as 32-bit addressing. The schema validation
> does pass incidentally considering one 64-bit reg address as
> two 32-bit reg address entries. If we change axi_ethernet_eth1
> example node reg addressing to 32-bit schema validation reports:
>=20
> Documentation/devicetree/bindings/net/xlnx,axi-ethernet.example.dtb:
> ethernet@40000000: reg: [[1073741824, 262144]] is too short
>=20
> To fix it add missing reg minItems constraints and to make things clearer
> stick to 32-bit addressing in examples.
>=20
> Fixes: cbb1ca6d5f9a ("dt-bindings: net: xlnx,axi-ethernet: convert bindin=
gs document to yaml")
> Signed-off-by: Ravikanth Tuniki <ravikanth.tuniki@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--dq1H5QpMGtBiF6fu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvws/QAKCRB4tDGHoIJi
0swwAQCpnbnTQorO35qE2tHaZ4T/C0u9oX8tMDcWcV/AcTQtEQD/V6ghJjqNo6ok
Qa5ti5Mr7Pd6p2KfbfqX5BluQ/NZQg4=
=DZEz
-----END PGP SIGNATURE-----

--dq1H5QpMGtBiF6fu--

