Return-Path: <netdev+bounces-173545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5C4A595F2
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42553ADBF0
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA15A227B95;
	Mon, 10 Mar 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0cy2i+0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286DA930;
	Mon, 10 Mar 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612670; cv=none; b=YHPfoVvsKh2vEvxsTYOP9UznDdDF66oJnY05K2Xn0tEzRUvplejc1+rR9vN6YX1TVjlUar8mkwei7grvmEUCrB9/m1I0g+DA5hakE87a4uFJ0/dWy6O3bGl/7+lTkIt/NYtA55QYKdNYKxqgqkmE1aQcglV4MNSmUYJh3LGKD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612670; c=relaxed/simple;
	bh=4ZqG39C5Pf1QNEH581g9JUhd773SjHjH1W/XN4R90kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXgvkONvj0sDXfMnXs5ZhK3wtgl+96zht5s+68mrWgQ7AvhKh/dJGExB5/AONojgntVxNjnl5Fe4Lak9Nt6t/AiOJN91DLhYsSL4U86FlvFfHXSSqfboLa5bm7Sso00JOTe81vWyKS+cI81EbkWcEnrwWvqcpBQ7Ykd++qVTkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0cy2i+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87D4C4CEE5;
	Mon, 10 Mar 2025 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741612670;
	bh=4ZqG39C5Pf1QNEH581g9JUhd773SjHjH1W/XN4R90kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0cy2i+02xhEoPTuiAszjprYlougcvywMXyIRcJqQDZN0By0NVslsy8cdRhL46nH7
	 AvSMgJ3n6XiCG4WhTsSwuKyW73hzeJIzhuoHKcHV4E4V0Ead9RAwWM9lP8hpLh+7x+
	 Tk6g7mlSZbVD6q3pEzZxS47X/4f1iLVSbqBMbS7719rHlUwmWp+qm//dLCmF/F1EGQ
	 Y4gz/xfVz+X4pn+qTQdZVEGNncnPjALvI8dGZjMt9/OL5+VV4F/Z/69lsbEjF7I9RF
	 AbPobtS5X9jKqnUqFXlHHfWK9T0sbEeZotEeGvBbacNk88edjN134aalObDqJRubLb
	 H5Daac2fyQr7Q==
Date: Mon, 10 Mar 2025 13:17:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net v1 1/1] net: usb: lan78xx: Sanitize return values of
 register read/write functions
Message-ID: <92b0588d-df0b-4f97-99db-d607de774728@sirena.org.uk>
References: <20250307101223.3025632-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l3HifBw0bN+3GatU"
Content-Disposition: inline
In-Reply-To: <20250307101223.3025632-1-o.rempel@pengutronix.de>
X-Cookie: You have a truly strong individuality.


--l3HifBw0bN+3GatU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 11:12:23AM +0100, Oleksij Rempel wrote:
> usb_control_msg() returns the number of transferred bytes or a negative
> error code. The current implementation propagates the transferred byte
> count, which is unintended. This affects code paths that assume a
> boolean success/failure check, such as the EEPROM detection logic.
>=20
> Fix this by ensuring lan78xx_read_reg() and lan78xx_write_reg() return
> only 0 on success and preserve negative error codes.

Tested-by: Mark Brown <broonie@kernel.org>

This fixes NFS boot on the Raspberry Pi 3+, it'd be good to get it into
v6.14.

--l3HifBw0bN+3GatU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfO5ngACgkQJNaLcl1U
h9CWbgf/YvMxNz/qhTlv3AYOZk5I4nBX9bOxERFS7Sp/H0sDcC610uSKp3TXNPDp
2s1HDKI6gS3YxuG+qWEe7HVOZPF5TOpN22UIN+s9YJ+eV7/d088hbl5KkwNjfMNc
W15vBIgEhGcnKMhz0ZZMOURzklFjp7id9s2f5MdU3y5YvCdrFFs/nj4i11JHdpj3
GkRux67ifQ6t7sEMpGB6Po15zX5A603wYTDuiKZ5MQ/9szUIPjWQTT78UNKN8ZkU
fALRy0yd3UGWwRAUJYcOm8Oxk3mhePqizm4jDylyHMjVg33gQCW8Hg9hnR8b42pi
RBBWJu3TwqIsqWGZf+CaDtUAPqWlZQ==
=XDSV
-----END PGP SIGNATURE-----

--l3HifBw0bN+3GatU--

