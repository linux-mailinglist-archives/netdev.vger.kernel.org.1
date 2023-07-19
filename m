Return-Path: <netdev+bounces-19016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3027595C7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F83281824
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7275713AF6;
	Wed, 19 Jul 2023 12:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35119101E6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE4AC433C7;
	Wed, 19 Jul 2023 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689770574;
	bh=HyVoxX8AEi9B94ASA5k8kd4DUFL0wTVKIY1KcFtkfDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+Kws3lxThBlltt/f12GSaRAtAPzhFg7bYb/YuJz81qIKKbGOM8s0gZ93UM2nntD5
	 WTdVlTaZ9UpAoV01CmvQTGSWbkfflC6gz7szk9vgcbt2wAzyyXirymJ0HiE7ttgdUL
	 YrItBCsCKRLpUeWupKKLHiWcZHkLDvhVbHTjOeGNGyu8qgdUud2B18ijrklNUgxOor
	 WG8pU/E6h7bNVbGXA3cJ7bAaDoY616B26mEroXMJzLXzvnixNrRAXWezamCq4SIPa0
	 A7sTZ8nQMcfWQ4aGevhi6NChrMr/u7EmXTcVJDRJbFSXBTvo4Hx9UTBVoAYtpCjXuQ
	 4vZGjWCIvDUIg==
Date: Wed, 19 Jul 2023 13:42:50 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] spi: fsl-dspi: Use dev_err_probe() in
 dspi_request_dma()
Message-ID: <dd60d083-6ffe-4d74-8c5b-588a62303b34@sirena.org.uk>
References: <20230719071239.4736-1-duminjie@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yplmLVqcDsA0Kwdt"
Content-Disposition: inline
In-Reply-To: <20230719071239.4736-1-duminjie@vivo.com>
X-Cookie: They just buzzed and buzzed...buzzed.


--yplmLVqcDsA0Kwdt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 07:13:02AM +0000, =E6=9D=9C=E6=95=8F=E6=9D=B0 wrote:

> -		dev_err(dev, "rx dma channel not available\n");
> -		ret =3D PTR_ERR(dma->chan_rx);
> -		return ret;
> +		return dev_err_probe(dev, PTR_ERR(dma->chan_rx),
> +							"rx dma channel not available\n");

The indentation on the second line is messed up here, it's far too
indented.

--yplmLVqcDsA0Kwdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS32kkACgkQJNaLcl1U
h9AsAwf/XRlF/OUeW8KspA4enro+hJVLmo1S1OP2Q+sUoS0nCV2LL3aj++22ZNVb
gB0Jmw0xhhdm9x/mw/oI6SZ1UJnKtRg4af3SF40tzTp5RgjkVOHWq0AethK9kLvr
DN4mrd8DunsuOCSoNOXHVDsHKtVwE7LQ9aNgSpHTdK/XVz20HnRYasSYzYFI81Al
FIzP816JKvW6fDqWSA2UmDGrwSjkonQxJHw4pRW/dhrDVqCdmCmj43JvRcH1XDo5
N2URSskEi/8AfIUYsHAkXdGfptKBFa/3xM2IeQZKCT1T+TzwqlozFcSx5D7YtS+R
phO5DyksBpm4CRd+VgHt9wwsc6zo7w==
=unq7
-----END PGP SIGNATURE-----

--yplmLVqcDsA0Kwdt--

