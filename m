Return-Path: <netdev+bounces-19786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282FD75C518
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 12:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6BC28221A
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B621C1642A;
	Fri, 21 Jul 2023 10:55:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE23D78
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7169DC433C7;
	Fri, 21 Jul 2023 10:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689936954;
	bh=YZ1JW5PrKwfiqr7ouES5fNN9Q4lLq0d4ETJKvBFZCdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3vGx3rtkuxjZSXI6FTC1RQKIdZZogDJMzAUFoZcWaV2Z+EN0PHHRhnO36vCyzp8v
	 4LQGE3yZWcHuWrmlpiJLc5d0cw19NIPUzbQDfSWYBMWyI9po/0I8A5mZnfHuHkOdB8
	 VU3fE6XtJOfEMvlWWOjqBbT6ePtHJCGDWGmYVu3GuNwaa86HX1Ty+hMs6dmUYoPg8s
	 Jqmrf5wpbRFXbGe9nqpZM8vLlPPI8GFw3B+lP+Z4ajzsNmYXHC0ytC3+TnIHwkr2gj
	 4Ao/IFDoFCGurb2ritXzIZ8gQ+vM8u6YEuN8Nl1AYS0k+JMWyRC1e9uUaqOKpx9C0t
	 xkKmrqKvT28Yg==
Date: Fri, 21 Jul 2023 11:55:49 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v1] spi:
 fsl-dspi: Use dev_err_probe() in dspi_request_dma()
Message-ID: <3ac9a83c-4f5a-4914-a1ae-5d8eb5d32ce6@sirena.org.uk>
References: <20230719071239.4736-1-duminjie@vivo.com>
 <dd60d083-6ffe-4d74-8c5b-588a62303b34@sirena.org.uk>
 <SG2PR06MB5288FB4E5CB1FD5E0FB6D18BAE3FA@SG2PR06MB5288.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Cxyek033qdK/8Yu"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB5288FB4E5CB1FD5E0FB6D18BAE3FA@SG2PR06MB5288.apcprd06.prod.outlook.com>
X-Cookie: Do, or do not


--/Cxyek033qdK/8Yu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 02:54:26AM +0000, =E6=9D=9C=E6=95=8F=E6=9D=B0 wrote:
> You said:

> > The indentation on the second line is messed up here, it's far too inde=
nted.

> Could you tell me what is the specification for indentation?

Documentation/process/coding-style.rst and more generally things should
look like the nearby code.

--/Cxyek033qdK/8Yu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS6ZDQACgkQJNaLcl1U
h9D8GAf9HiMXdGv8S4xPOcLaUXzbKC7InZlIaJ9YVyyFx21E/mNRqszdVbN9PCuL
kvOvggjtVBUrfI+ou4Xe72MlsbbglvS2cw43OSw4I8xu26Q7V80XTvrXYhMbgrNj
YRUdL1c94n8FSVdLY9xrNLCBM8+w6OyPYiNZXNI0OYK68gaYxCwpifHLayO04/yO
G2x5CnsOOT9IwEGfeAIAvbOZaEuOftq0v7bmRhVy7+nAu56SAoOLg7wcn8B6c+6I
dv+5ZReUG3XmZGyjXZXgbBXTHvPnvjrDU6UlLq0h1AMaxtqFzzARWtzULOkIQPty
M3/b6iYTv2ck5EQsN1YsOttuBmq4IA==
=A2xd
-----END PGP SIGNATURE-----

--/Cxyek033qdK/8Yu--

