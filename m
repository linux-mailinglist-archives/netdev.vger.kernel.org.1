Return-Path: <netdev+bounces-189004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9ACAAFD23
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B991BC7082
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8B267AFF;
	Thu,  8 May 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5udA0UL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC401D6195;
	Thu,  8 May 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714741; cv=none; b=FEeVXjg0Q0Wqc44zbWU1xmzFr+XxJ3A1wm/Zfd29nzqkf5b6O7Bo5CzRqlj/YUFBYz5gjRc7GNC1Z9vFY0yGQRjjQWGhzU4riaE/FUfCQC5omFhfOv7n+vEtMdl/c2JsbYaKLKOBR1RvsvMR/LHD35RrC9WhUB1o02gH6AEEDE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714741; c=relaxed/simple;
	bh=a8B3CrBH4iQmYkgsTJfyPccNfxKzYgWqojWrnciToUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+SPz93+vh34pLGKSjgXZLNfAXPJFIOS81yzdbJYONoKXM9hezgkUCWB80oaSvAmVMTQdhnP5GjV7kRsLcAKEsbb7gpLgdMrMMVj4jxysgUXLJTzH6gmOJt+C2be8QvcQ8DK0166c4JaG70VCn494QEgCuIW0YV4id1FeY5DLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5udA0UL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B29C4CEE7;
	Thu,  8 May 2025 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746714741;
	bh=a8B3CrBH4iQmYkgsTJfyPccNfxKzYgWqojWrnciToUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5udA0ULdtiDwGZ0YqUqg3WcqCGV3xSq8hcXUpditES2aBEr3s6hyjcuAWzh1DfZo
	 TjWXsaG4ZNq+uglUj6sOHoyeAIbah6Bv9uTn5V3jBwXWYtctC61korsu2A9QEB0M3U
	 /X+6GiMEgYY6Br0u1NaN8vb8qx1FCaHgJW+eV+nFkmomL7guBIkioFCng+bk5AImC8
	 hw+nyYaWVY+697Dd7PWMj4nVFKOKTD2NqG02oi70AugSfwoFUceh82ovnVuVMOOXgH
	 0lwzXQ/kYYUwnjptBzW58l6S/Bripf/qj3T/GMk53v15iVKTNyT3a0Ld2rpFg2ZHF3
	 IMH2m79+kIiKQ==
Date: Thu, 8 May 2025 23:32:18 +0900
From: Mark Brown <broonie@kernel.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap: remove MDIO support
Message-ID: <aBzAcpYhpYE6X2Hq@finisterre.sirena.org.uk>
References: <c5452c26-f947-4b0c-928d-13ba8d133a43@gmail.com>
 <aBquZCvu4v1yoVWD@finisterre.sirena.org.uk>
 <59109ac3-808d-4d65-baf6-40199124db3b@gmail.com>
 <aBr70GkoQEpe0sOt@finisterre.sirena.org.uk>
 <a975df3f-45a7-426d-8e29-f3b3e2f3f9e7@gmail.com>
 <4cdbc8804ad23a24a9aa3bb12667031b5bada3a6.camel@svanheule.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p5j8JsFgxDScXhWc"
Content-Disposition: inline
In-Reply-To: <4cdbc8804ad23a24a9aa3bb12667031b5bada3a6.camel@svanheule.net>
X-Cookie: Well begun is half done.


--p5j8JsFgxDScXhWc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2025 at 10:23:49PM +0200, Sander Vanheule wrote:

> downstream in OpenWrt for a few months too, where they are using the regmap MDIO
> support, but I understand that out-of-tree consumers aren't usually up for
> consideration.

Given that there's not really a particularly strong push to remove the
support that's actually relatively strong - if it was getting in the way
of something then it'd be a differnet story, but if there's out of tree
users we're aware of then removing it would be a minor roadblock to them
getting upstreamed and might encourage them to do something less good.

--p5j8JsFgxDScXhWc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgcwG0ACgkQJNaLcl1U
h9A+fAf+I0/FLpPZ+dR1Vh4eBldSpB0IC0Pu/3y/919kIPBbKrUdKk8XwaeC8CmQ
HqAtxVqsTxcJ5NKl/xBQ4Ln5J3YV9PJreUdkWkqQbM7nsgue2PzeFKWCSB6Ip3Fu
f1ra48rIu46Y6axTmrE6PuJDWoE1PE0Jz2ZcCWIFk236mYDLLvePPIq1dsd6Qig0
+dOEWM4vhbXt8vQtQKNJSXB9xZra+n+KQRaDKCAJdLSkf03exSYoJ0T5BdvebRgD
fQI7siPohnXag4mQKzu4IeD1mx8eqQWGyWnjmO1Tw0LoUcWKEOdb3EST3gZIp1qt
rrlw/XiOEpJzHpNQkekJMxy2utzEsA==
=y15B
-----END PGP SIGNATURE-----

--p5j8JsFgxDScXhWc--

