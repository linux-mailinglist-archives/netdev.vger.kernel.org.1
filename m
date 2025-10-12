Return-Path: <netdev+bounces-228629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF9BD03F7
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 16:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC1AD4E8E4C
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018025A343;
	Sun, 12 Oct 2025 14:30:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E5715E5D4
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279437; cv=none; b=kx0d60Ga9T3mWWbqzRDeOgx5qY33xMJFY2jjXsWJvaKv8YArngre/RLPfmv6tEOeOqBKEvuACN0gRCuQa+s3wnqCYuncJMNN+asC4LGEik3M4izTvuPXzDlmmfqau/OKoapkqsVYzdixyvHw22urmvz2X26rj5W9TjfNwDfQILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279437; c=relaxed/simple;
	bh=yqb/NPmy5gD6pVb6IkeAsxHMeFbpmoPcjmcGPUy8viU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU09rW1vreY1lZIl4JVzTj5DDoEtLd09XQ4+kpaw20o5llhNvpWtxra9l3MvXr+UWKthsuLfEjf4xcM8mylLmW9gT3U1g02FZ+JrKQPYnRLNrpji6GXXoNPPJhBlrsuiXiqfE94WjoXcZx+T/vL8w9Ygq0mQ8FFy3h5jXWinmzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x5a-0004vt-0T; Sun, 12 Oct 2025 16:30:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x5Z-003EVW-0q;
	Sun, 12 Oct 2025 16:30:21 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E20B74840B7;
	Sun, 12 Oct 2025 14:30:20 +0000 (UTC)
Date: Sun, 12 Oct 2025 16:30:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] can: add Transmitter Delay Compensation (TDC)
 documentation
Message-ID: <20251012-impartial-nimble-warthog-69b223-mkl@pengutronix.de>
References: <20251012-can-fd-doc-v1-0-86cc7d130026@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g6joyd45bjqhurai"
Content-Disposition: inline
In-Reply-To: <20251012-can-fd-doc-v1-0-86cc7d130026@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--g6joyd45bjqhurai
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] can: add Transmitter Delay Compensation (TDC)
 documentation
MIME-Version: 1.0

On 12.10.2025 20:23:41, Vincent Mailhol wrote:
> TDC was added to the kernel in 2021 but I never took time to update
> the documentation. The year is now 2025... As we say: "better late
> than never"!
>=20
> The first patch is a small clean up which fixes an incorrect statement
> concerning the CAN DLC, the second patch is the real thing and adds
> the documentation of how to use the ip tool to configure the TDC.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Added to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g6joyd45bjqhurai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjru3kACgkQDHRl3/mQ
kZyzEwf/UO+I0gwibduyqyu7e/jM2ytjQ6MHjsjWxbWrKa4u3itF1t9Y/YtwcKT9
fUdIqXsbNOI27n6m5EWuhJbdP4MGT5Zy8K7kSxswWzMgZtT4B7f9V6hnUPN81vSn
/nzpojfjuF+AYcW1sYTzsLY5Ae0jIdqSgo94bMHjKJ4qiyEggDiVS/ueTkdj9uLr
fY5nkuA2JGTCCmJLwPekXbqP2dnPKtpECA7WaX9kFOl9HQnTtDPGBstD7kAJimmC
pRrgK+K37TSJ9QHqRCJWuKGjZLhb01tl66DaC5cfX48FJNRuvHFGcWN4gX894xaF
VTNHv77UIWH+TGm82Q0b/N0qqJQOug==
=qxb0
-----END PGP SIGNATURE-----

--g6joyd45bjqhurai--

