Return-Path: <netdev+bounces-191501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16881ABBAA3
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07DA168528
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF14F269D0A;
	Mon, 19 May 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyIxmRBU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EAF1E9906;
	Mon, 19 May 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649290; cv=none; b=ppbft2i29rlWCTxSrodwPWPaad+Atpl99d5BcCanPBxPbS17V1tFk1+6ks1WU23uVIh+sbh/XeCt4z7S3lHvyiWBNZPoIkUW7FOsI0G3tkLPCVgo2cxQS9ppCRVms52TEV8yyB7eO9/y5EQFIkYcTXeRSAhkTESEEE9p+WCOEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649290; c=relaxed/simple;
	bh=wL+5PnBKqpKcg8WZY/24OfXz24Tyva4tqhKg/S7c2A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQniIw+vBKxrp3kvOZeMwpyuTVI8DZJvMLriwidBaJ/rWS4XAt638sF/zRf1ezexHg8hZ8ol9OUAnt7F45z8nXOTcYaCafIqyBqY7s+LbRIGusb5PRZ4OxuWIGosl/yjnfuZa+FNVdeRh71N5BJ8EZyDWSatoK/rj1LDIdVpYjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyIxmRBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F544C4CEE4;
	Mon, 19 May 2025 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747649290;
	bh=wL+5PnBKqpKcg8WZY/24OfXz24Tyva4tqhKg/S7c2A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyIxmRBUNTWLWC8pnAJ9DzSmLwOckyInVq5KSXN7KGIGPwqQc4JpQoEsE+gj//PfG
	 kHU3IQlcwO/cP5YsGqbLgfDAVe2twWHQW04h56uSaa9yOUto86rpJXl+xPZ8Zl8lWp
	 P2N6pH1W/MB7Omm8UXNGVBaBo7K2pc1QcThFjEyaIAefJ94kb/gEhjJlr9seeGuCcM
	 E2De76g0pjTqtM9ab/2iySGcjx1txxOT+IS7EKlS1N6R/6/rFPWe/fEoha8yVzKIl8
	 PGXKVlv+RWTfGgHJU+Q43BgiuaB12DEAasAAMlyzH9XlEuv9EswvF7wQW3HeP1PMya
	 n74Srx+wlVlCQ==
Date: Mon, 19 May 2025 11:08:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: krzk@kernel.org, bongsu.jeon@samsung.com, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, lee@kernel.org, lgirdwood@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] fix: Correct Samsung 'Electronics' spelling in
 copyright headers
Message-ID: <3aa30119-60e5-4dcb-b13a-1753966ca775@sirena.org.uk>
References: <20250518085734.88890-1-sumanth.gavini.ref@yahoo.com>
 <20250518085734.88890-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1JBMmA2tdEPES3PJ"
Content-Disposition: inline
In-Reply-To: <20250518085734.88890-1-sumanth.gavini@yahoo.com>
X-Cookie: We have ears, earther...FOUR OF THEM!


--1JBMmA2tdEPES3PJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 01:57:26AM -0700, Sumanth Gavini wrote:
> This series fixes the misspelling of "Electronics" as "Electrnoics"
> across multiple subsystems (MFD, NFC, EXTCON). Each patch targets
> a different subsystem for easier review.
>=20
> The changes are mechanical and do not affect functionality.

Please don't combine unrelated patches like this into a series that
crosses subsystems, it just makes it more confusing how things are
going to get applied and if there's dependencies. Just send things
separately to each subsystem.

--1JBMmA2tdEPES3PJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgrAwIACgkQJNaLcl1U
h9DFnwf/XjcxEKF2KSmebB4Y0RFqowuduWRbFUGux971QxPXN02FXJDhen91BqiO
RjnTHmUbbkQiHs2kealN4P1k3ousMoAPdIcpFUQG2vt59BPfuyJCpsbKXzogUBOF
OYKz9N5JHxx/zxQ4C7xuS+FnZyEQIQoni+FDFLKQQOUWfqS4g+bYg1RPMs7YOHVs
Gr3eJQHE7eQk4ISHEmErCGHIIWaZ/XXHrNtGP4ZZvRWHQb76hXTxumwtoE+waIR+
Of+4V3ODuX7PqXeF5XbY8PRicptJhsuSVhuuuqdmQNgd5Gne4THhnmnddi1tud3f
L5GC9XUhs0xhl9ilsvANYvNjIR/Xdw==
=dDHu
-----END PGP SIGNATURE-----

--1JBMmA2tdEPES3PJ--

