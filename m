Return-Path: <netdev+bounces-188512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B2CAAD26C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBC0985BB2
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E135280;
	Wed,  7 May 2025 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOq6IwKo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB61A29A;
	Wed,  7 May 2025 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579047; cv=none; b=K0q1WLixEfz2R2XzbJWr5W2brNv3UL7AzirfSHgz2S91ceoGq7BnoTjP8C47oxft5bvlqe+sEhDLMvFMvav91GOAprbk70W51KbbL46VG0fsAQQM3Lz9Mm6Fd8MMYg6K+8SAvQWiWzWQ0JgsLCuHTywLWVk/AQ0bi7VTbYTUHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579047; c=relaxed/simple;
	bh=fxRmXPVT7FC8KvfWax+2Rl9F1CWcl3zvGCeM26yK2ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3RXdrIcBtud8QIk3zHqAF8NuR1pRmHsOSH1mbU5UHv0VweDK8Rc6kH+1QYvGcXiSaJiwA4OFk8EsehGjKjNCXmFqH5+GW09ltL9pX0qGcxSDcXHWOUmT0NuIJxs7eF0hE0e5eAjYtyXoLFPdouulfoFNrFzF3jjlFTk3xaVlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOq6IwKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448D8C4CEE4;
	Wed,  7 May 2025 00:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746579046;
	bh=fxRmXPVT7FC8KvfWax+2Rl9F1CWcl3zvGCeM26yK2ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOq6IwKovh8CjurHbq1PBmGaji7irKAlBzCdbfjkJjRCU8A92+N9vRpohWhkU66px
	 GiXGrChm3/WWFcR1wZT41BVTiJCSEu9PW2J7xe0XqSflUQApbLUhmWzqbqc+J4ryjJ
	 6xe+CitsqzhRCztyyhuFQHr9q2Y1+/7A9ByU9fMz5Q2yMbQY3vOBMgRL2KAg33vmcP
	 I/fqvu6dKDHcI1j6KXwDB0lDRNNXC7R6T0VuNOSaTPZzF9k5cVWfD96q6wASLwVAAQ
	 WbEJXFmL/SR8riAKZc0dQ1oKgkuoqpgKrUqDl22RsqVrw2q6hROG5kT6nnvUoNbkRB
	 cv+JHUbp+YDNw==
Date: Wed, 7 May 2025 09:50:44 +0900
From: Mark Brown <broonie@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Sander Vanheule <sander@svanheule.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap: remove MDIO support
Message-ID: <aBquZCvu4v1yoVWD@finisterre.sirena.org.uk>
References: <c5452c26-f947-4b0c-928d-13ba8d133a43@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uEv/jRd31r0H1SX0"
Content-Disposition: inline
In-Reply-To: <c5452c26-f947-4b0c-928d-13ba8d133a43@gmail.com>
X-Cookie: Well begun is half done.


--uEv/jRd31r0H1SX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2025 at 10:06:00PM +0200, Heiner Kallweit wrote:
> MDIO regmap support was added with 1f89d2fe1607 as only patch from a
> series. The rest of the series wasn't applied. Therefore MDIO regmap
> has never had a user.

Is it causing trouble, or is this just a cleanup?

--uEv/jRd31r0H1SX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgarl4ACgkQJNaLcl1U
h9C7ggf/cMTPYshjf0uNeGC9Wlys8n2/myQHXG/p/GLsV5Qbs82pHdzZ+wyFejPB
l5BJ6D6ZR1vr0vIwVmkrSJ8f0Fv0xWJ7Gla+u9LETsi8rn0AD/yCVzrJjy/i9CbL
juLKOrAk5iO8OSRtDTOWRoUA9xWdTfMI7DBPAzxLUGfNYflNyXz1e5sIKED9Xv78
CHjKnt2N+q4zhyNFuUq+Rd55jAeTbzW9IYv7bvT6FPWCgi5scfR4UCncjoyPzzMP
9FutUnQcnJiehiW3e0vDB+15My2D4wRhrTkIT2zCG5lTSnJFbk9WLYan5AaODdmb
oRD+0d/QN3BjmK1K/ttHoHFCpyzHqA==
=Qcr9
-----END PGP SIGNATURE-----

--uEv/jRd31r0H1SX0--

