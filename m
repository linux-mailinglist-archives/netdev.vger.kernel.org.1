Return-Path: <netdev+bounces-48769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B07EF74B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 19:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833061F251E6
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA3630659;
	Fri, 17 Nov 2023 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOTlh1Q0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE449F8A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 18:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FA2C433C7;
	Fri, 17 Nov 2023 18:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700244043;
	bh=eynEyaIBuBjrQ9oV+nUoN0qckQ3uiEKGSHNnU5itV5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOTlh1Q0XCTve//I0Sj4kg53qMqlmOCyaiJuQK23mdayrxtXuAOKKqgKULaZfxboF
	 FH4vbWmv8SLmye9nnZH7z4iPgo0KydVklkelojt7cl9Pd0aAEXLohX7t97iIV6yZh3
	 6h4Q8FzHo6DS7oG9H9PFLwy1xk0vRZiz73Mg5ttzQ49YIzVzkF1F+mhmsF6Css7/e6
	 mJQX+qE277mNJRZsmQRVt67mqKMDWB0ksmGtwVKHC/yvztt/1G7zQzNSqpDhKeEnuV
	 fhxFv/4iVQUJeK62eQMaw/+2iaM8uecbiblXPi9ell3o4UAWMPHMinluUnymf9ObIV
	 ZWBk2Qw4sq5Tw==
Date: Fri, 17 Nov 2023 13:00:42 -0500
From: Wolfram Sang <wsa@kernel.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [net-next 4/5] net: ethernet: renesas: rcar_gen4_ptp: Add V4H
 clock setting
Message-ID: <ZVeqSsfBEMsQ+8mP@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
 <20231117164332.354443-5-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zq3oPg4x7Dpv6xMo"
Content-Disposition: inline
In-Reply-To: <20231117164332.354443-5-niklas.soderlund+renesas@ragnatech.se>


--Zq3oPg4x7Dpv6xMo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +#define RCAR_GEN4_PTP_CLOCK_V4H		PTPTIVC_INIT_200MHZ

Is this easier right now or could it be added together with the TSN
driver?


--Zq3oPg4x7Dpv6xMo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVXqkoACgkQFA3kzBSg
KbaxGRAAojviuZlYStFvXIXsit/RonbMs93nxW8SWEv/dZJkd5nmzNUkvV6sjQmO
gHtNfVEc2bsO+fBnJJh5C8V2HniTBSRCzauDiaZsguJAX3XCu7RDcdH1o8Zimvy2
zNXhvCNgxQGWCGRbk6Bce6aGNDXwYDZQe2v1n40ioCNIC/6twS4C3wwgul6qZ0ey
GoQ6dA6nwMLdn7lA3EoNNpv7eWYwMTH5Zc5x848mKGboENMYasiwwE3C+DhRN5yI
8E+F2o1EQfFNugZrtEuBTtva7cf4vzqMGJD+Aa9hGKcYfN7/washOk9fs4SBz5sX
DRTMV1pDQ7MUhNEERgfKn23q4VIqQ0Z0ECq4dw6n5ekDjXuz1/H2ShmWMZxf8ddR
yRGtWZNfob21zu6OEjvQFc3/SwhsPwpKO0ADeLmgvAgv+c+TxS/dyzOho+3m2l5U
1CosIucpPk+pJ5oUo3FyYGmIYwvDJQMIPmLstlpK5pypkqROKwLeGlG03oM8Yaes
YeZL1oguaOe9Rz/6/TPhHRqGMPOLUVNrgm5Bv64fX0PGfe2/rgXJN5Q30YahEviO
Va1RjPJHuXOpaa5jVt+83LS8zQTaemFdVwFyeh1i5l24FIZMOF2novSMjtmoVY6v
Z1VJIxCBDlgv1gchBBo86fqrDzx1A2ir1tHRv6gvw5vzch1Qi8c=
=KSSV
-----END PGP SIGNATURE-----

--Zq3oPg4x7Dpv6xMo--

