Return-Path: <netdev+bounces-19617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EDC75B6CE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235D028209A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEBA2FA40;
	Thu, 20 Jul 2023 18:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7761BE6A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 18:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853CBC433C9;
	Thu, 20 Jul 2023 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689877877;
	bh=CtNFdU3F9NU71cT8OwvsL628imoZj0J7FgObAG63Kxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3oMGjflOKxpKcCuRTekPugXGhdCEoJECkCTCtljh9qkBNODb2gjp/RH8CrfeBET3
	 V08CAQ5L9vSmqBuNoa0cwYWxopmZ5ohkahFf2x+u1lf2LjjL/ThDQE8eEP3imj/n2s
	 XjvY50a4o8mJpBIu9YI+Goan+/t1AadoS2R9nhmLxM49gjZHc4ddLrAIE8c2QHhhoF
	 imn4wueHAcTdZV+KnNNPpD/A06brA5ZstZxqjtZwxb9vjbKeCc1lWlbZtdCZCo5Pj4
	 s7zXHStdAlWnD9z0EraLhldfQRFvipqq5zuitrNJjgvpfxeDN/aDZOtNQxzUuEJqW2
	 4gxfgLSwZs5PA==
Date: Thu, 20 Jul 2023 19:31:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net,
	Andrew Lunn <andrew@lunn.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
	benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <1d136db7-4c39-4b56-86fc-3840b1395b4d@sirena.org.uk>
References: <20230719183225.1827100-1-kuba@kernel.org>
 <50164116-9d12-698d-f552-96b52c718749@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jb9kzeyvt9pPL7IP"
Content-Disposition: inline
In-Reply-To: <50164116-9d12-698d-f552-96b52c718749@gmail.com>
X-Cookie: Ginger snap.


--jb9kzeyvt9pPL7IP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 07:23:56PM +0100, Edward Cree wrote:
> On 19/07/2023 19:32, Jakub Kicinski wrote:

> > +Maintainers must review *all* patches touching exclusively their drivers,
> > +no matter how trivial. If the patch is a tree wide change and modifies
> > +multiple drivers - whether to provide a review is left to the maintainer.

> Does this apply even to "checkpatch cleanup patch spam", where other patches
>  sprayed from the same source (perhaps against other drivers) have already
>  been nacked as worthless churn?  I've generally been assuming I can ignore
>  those, do I need to make sure to explicitly respond with typically a repeat
>  of what's already been said elsewhere?

Yeah, it's this sort of stuff that makes me concerned about the "must"
wording.  I'd say it's obviously reasonable to ignore such things.

--jb9kzeyvt9pPL7IP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5fW4ACgkQJNaLcl1U
h9AIHQf/Q9pz80IaSHLonaCmKZBC/PhYzARUEaUDHduoe5xLcbBScTYkq8I6Z7Xp
MMEdiuI9ueOcSGGJNwSxrsjJMPvYQ59ji4fsJ7hEQULZZ+44f5XBR46jRd0rYX3z
b3fNyivasjTQEo/yNinlzMDQBA5Bzgquft3GCSd7sOn+Ba76YWofKBrAWJ9XfHqs
Hc9JY98Eh/sa03U8rTMF8BuDKpz+XNexp6r5WY9SbVwtHlNOM/vwvb3Lf3EK5TYA
Xau0KMJYF+Z+kIn7vElXvGwxLPa1rbxZfj8yuvEnwxX76U0in2XSXmJ2b8Nyd2I4
wF7oOllE5TwlbmHTw0i5uBWk33Npdw==
=XcvA
-----END PGP SIGNATURE-----

--jb9kzeyvt9pPL7IP--

