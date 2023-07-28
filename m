Return-Path: <netdev+bounces-22256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB0766BF5
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 13:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175B728267C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD312B63;
	Fri, 28 Jul 2023 11:43:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE34C8C9
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7317C433C7;
	Fri, 28 Jul 2023 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690544626;
	bh=INcecSQlgL6zrFUR6E8VLZohIBeE2x7zqL6Ll+UaSqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gasNyuImC40fLQBj2ralwuJVnvB4it0n55+ai9XL/4ce32YW2bTAzOT4Uv2kUvfz7
	 mtLpajZc6Fp9MYIePtPfSmiUyeyyFi8FYqk5B8cd83c8e15ty9sRT7oV+bfuzLiTpI
	 unTB0IQOimI+AHma9GwG/7a82TmkRBFKDF/kWtR+wNOwMtTF9QL5IW2dy+LsSvS40I
	 ajjuPh1XXg4CK8Lp1ewY7U6kEs48X5E6KqMeIpcvCFLlNtmPuEot/e5KU8oLYsrCtX
	 O3juuNffyDiPZsR2Jri+AtlcLuOgkaDwiLp3HgFNeaeK0SomJHupdyaidfLTSz/+d+
	 xmuszbPA1MzUQ==
Date: Fri, 28 Jul 2023 12:43:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <46853c47-b698-4d96-ba32-5b2802f2220a@sirena.org.uk>
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
 <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
 <6766e852-dfb9-4057-b578-33e7d6b9e08e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b+222yRq1TKxUJvp"
Content-Disposition: inline
In-Reply-To: <6766e852-dfb9-4057-b578-33e7d6b9e08e@lunn.ch>
X-Cookie: Ontogeny recapitulates phylogeny.


--b+222yRq1TKxUJvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 10:41:40AM +0200, Andrew Lunn wrote:
> > Wouldn't this break SynQuacers booting with firmware that lacks a
> > network driver? (I.e., u-boot?)

> > I am not sure why, but quite some effort has gone into porting u-boot
> > to this SoC as well.

> Agreed, Rather than PHY_INTERFACE_MODE_NA, please use the correct
> value.

Does anyone know off hand what the correct value is?  I only have access
to one of these in a remote test lab which makes everything more
painful.

--b+222yRq1TKxUJvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTDqewACgkQJNaLcl1U
h9BEOAf/Vpzmc1pDsskQugJJmHrpR0lU1gCdG1oThAL1S/9ZpZdRbhCNmS9vsNjb
jmqlo7VfKcKQ7uJI/xu4RWMhHujyc+GRx8G6OMta8n5u2YTjjsK30CAgDdj6PMg8
ce3Fd3PPs0/psTESxyiL/K6Ib8S3/DcKiVe4JbkUgUvzMhkhRXMge+LV5fX16v7U
s0p5xq/fMsgB5xdcL3U3VDTlG/K9+KFly6neCTckhcqNqb9m55hLvuYNtbm3myaT
yLwWM9V3P/pX4bxfDtZGm09/URKlBOIuHpu+7M+5PVnMU0MLZjIzVamW0Cj15tAk
1irBAWD8QgtybtVR7W12IMuFYpATdw==
=SFwZ
-----END PGP SIGNATURE-----

--b+222yRq1TKxUJvp--

