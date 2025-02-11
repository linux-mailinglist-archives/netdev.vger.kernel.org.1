Return-Path: <netdev+bounces-165247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2EDA313EE
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06841889FFC
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4D21E5B63;
	Tue, 11 Feb 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAz0HdbE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFF91E3DEC;
	Tue, 11 Feb 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297945; cv=none; b=umQSfZCZU5ESvJlULCPpH32sCDOfNSY23fjKwLTGegnzoPzy0uUB8SvDqMHJcS+3ee+0pyN8DXGa7adBykuSCwSc+91D+SafoVn9p0drd7/kJi77k/slG2a1A7TAl7FPi4cyljEFj19ALtwjJ9uoIQZOfVjhDHxV9qsbqzXT3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297945; c=relaxed/simple;
	bh=2Kp4Zi09nuv/kuORUiQJl1dYvW4RXdPB6gTsNvTY3CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfdFk2P9Kx0sS9P9qBc7JD/zu0v4x4s8HNbMpFleCx9X+qm/SGTMTxuGG3T9gwWq0pakiYv6UfxZhi+R5qkPJfZuvd1Hsiz7aIlZdPqFgfu1u2PysB+57wyVp+fqb+GAUQjhLCUisT3yIg5NJDYFtHeB5DUKwwrFur90owCXJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAz0HdbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A9DC4CEDD;
	Tue, 11 Feb 2025 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297945;
	bh=2Kp4Zi09nuv/kuORUiQJl1dYvW4RXdPB6gTsNvTY3CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAz0HdbEmfMot5nLBQmD75IFwZRqJATTQq+XEA3Py2vGD1Y9HmEUKepf/qOXfc9iU
	 eJxbJceHVdPWesVXvMENGYpvvcUIC8aNi9fl4twGE7BzlXiF1B5lGnNV62HlbBvnIU
	 O3tSBq3S4UwGgX2LrAm0FeSKAlD2+d0iCvdIhmgi85LaCLrBcvqPfaaqR7SsPU0fM+
	 oD4XYMbVHToR4eFWAJNoepJ6nxla44PrtwOQGlbsCcYxCoSnsJ1zmHvbjWBEBpp+K7
	 gCk/LRB1eUx/bRPAUmG0ONlMb/Om7TIg5tR3Hna7wj+fV4xtKh3xS/DAK7F/vuAixx
	 LK2/f+gwqvqeg==
Date: Tue, 11 Feb 2025 18:19:00 +0000
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
Subject: Re: [PATCH 05/10] dt-bindings: stm32: document stm32mp235f-dk board
Message-ID: <20250211-surviving-bunch-f4de29898d71@spud>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
 <20250210-b4-stm32mp2_new_dts-v1-5-e8ef1e666c5e@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ueo0e+SD1hPCV0MU"
Content-Disposition: inline
In-Reply-To: <20250210-b4-stm32mp2_new_dts-v1-5-e8ef1e666c5e@foss.st.com>


--Ueo0e+SD1hPCV0MU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 04:20:59PM +0100, Amelie Delaunay wrote:
> Add new entry for stm32mp235-dk board.
>=20
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Ueo0e+SD1hPCV0MU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6uUlAAKCRB4tDGHoIJi
0nTOAQDJ4oscU2Sfp60SfXJoCMC3ARGWSbzSfjc1JO2iL40lJwEA3gV6SLlmwCn8
9am4zS12tt9N3U9+3EGMeTGdy9mptg4=
=MiP+
-----END PGP SIGNATURE-----

--Ueo0e+SD1hPCV0MU--

