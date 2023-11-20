Return-Path: <netdev+bounces-49385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8297F1DDA
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA67B20DA9
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AA837177;
	Mon, 20 Nov 2023 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmySCxX1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13337174;
	Mon, 20 Nov 2023 20:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8765AC433C8;
	Mon, 20 Nov 2023 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700511204;
	bh=4sUDEp6FYMfD2QrfOBC4znr4NhcbtUaY8p3AqsjaVX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmySCxX1nvFtdQ8UsIeucqu8wgXj0Q3rdUEYubyupWh6P7ZWXqu9pglCx7VFRrVzq
	 Jj+65pdeF0zLXsCGOO9B6c6RdpYMmpkN87Brsa2BykPRiNMS51ZlFfPk3dwlBKLSJh
	 94ZMOlh+ksE2Yt2DPLiUkLvCqMTo2Htk92h7Cer17OmW8gYolLT8LRDpV2a2dhGjzR
	 +q5totgxMTv0OU7XoB+gQ/0+SpcGpky89v80FB9KUFp97xwdhrC/i5JSDRtFMRgcoB
	 rKwVkk9S7NsBznSw/9kUbx4dbi0yRxFA74tTZTbaXwgBa0dyK95gK65q+YSChZSYb+
	 u2+5NGOfjzPgQ==
Date: Mon, 20 Nov 2023 20:13:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew@lunn.ch, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: try to guide people on dealing with
 silence
Message-ID: <0d80ee23-e106-487e-a824-b048948a859a@sirena.org.uk>
References: <20231120200109.620392-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RbKDKJRhjswcAM1A"
Content-Disposition: inline
In-Reply-To: <20231120200109.620392-1-kuba@kernel.org>
X-Cookie: <Manoj> I *like* the chicken


--RbKDKJRhjswcAM1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2023 at 12:01:09PM -0800, Jakub Kicinski wrote:

> +Emails saying just "ping" or "bump" are considered rude. If you can't figure
> +out the status of the patch from patchwork or where the discussion has
> +landed - describe your best guess and ask if it's correct. For example::

> +  I don't understand what the next steps are. Person X seems to be unhappy
> +  with A, should I do B and repost the patches?

This bit (modulo the reference to patchwork) feels like it's generically
good advice and could find a home in submitting-patches.rst or similar,
not that it isn't worth repeating here.

--RbKDKJRhjswcAM1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbvd4ACgkQJNaLcl1U
h9D67Qf9HPgF7lQhJm9GidXfuMsvjIBSe0kH7WnFQND6lioBmMb3AdRniHDNKLx1
YJLSKE2SAdlUXuFpGtfqwvf4AzaYnkNcDpxPdJBJpeuN+DkJXRguKy6fuzux4CzL
FKjz8d7B+MIVxB7eaZCi6nuLPoHetW13OSZ/b1mepPRfSkaNDMQtUJ0kJadbzvR4
eeW+qjZVhislHHtjneQYsgmY6qQRCDBeFryFKdN0ucc5sy/NRzKseWL5dMAzr92D
9p54Exvw5g8ndtMCarOR2/ULR76NRJfDRBd1gKp1MflakE778m3MZsoG7k5342B4
3YcT26WP6qpUpLZ7QjTiLGycXUVM/g==
=d0ou
-----END PGP SIGNATURE-----

--RbKDKJRhjswcAM1A--

