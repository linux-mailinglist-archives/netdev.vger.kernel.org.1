Return-Path: <netdev+bounces-53942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512AA805544
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F6B1C20CAE
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC0F5576C;
	Tue,  5 Dec 2023 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCp1XxpV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5153D3BC;
	Tue,  5 Dec 2023 12:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF517C433C8;
	Tue,  5 Dec 2023 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701780926;
	bh=llK4VgfU9M7BUAIsGTV5IdpayF9LEJp4ETnPX0BuuzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCp1XxpVWCmqmJ19VGGl95DZFPb+kwewM3cLBzV0oEEb/VXdEfcisAi+UmR/wdNn2
	 cm7b1CkJlnbjlPn5ZnIMVEel9ZLe7G4OUj4wWi6ujSryAHq9Ck/M2aVL6RMjpsSNRl
	 r3X3WDPhMufICSgai/BLnFyt20K13unfbRks+bjBtM0qEMSwfoDjqxnbY0yeK/43X9
	 Z5feOjrFfI7EdCML7zfaLj9+0ZHuYP0EWe+78EI/imZdTcADtsHf3drQzkVQ+EOPNY
	 n5YjyMcTLQC07nqCr//PwlwPqwgX08JfJbodZGY1QOSChm/t5eYeNeVTmeRU4atiu5
	 luojtG+NcRXJg==
Date: Tue, 5 Dec 2023 12:55:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
 <20231204225956.GG981228@pengutronix.de>
 <20231205064527.GJ981228@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zoXV23kthTxZLA1X"
Content-Disposition: inline
In-Reply-To: <20231205064527.GJ981228@pengutronix.de>
X-Cookie: I've Been Moved!


--zoXV23kthTxZLA1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 07:45:27AM +0100, Oleksij Rempel wrote:

> CC regulator devs here too.

Again, I'm not sure what if any question there is?

--zoXV23kthTxZLA1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvHbYACgkQJNaLcl1U
h9BHrQf8C6nw/SboP4lAP9ogknacWdRLOmkOBm/zqJn3nEWLF+zm/vly+rGUUWnk
CFA5bDZdBl96CHHQwJAW/O6tPl2hbNoKYh1H4TuZ8GSqZh0EXgwswEy1rGamnZBt
DtKBokQP85r1ryASwAmyGs0s34PRimChsG5Jgo11mD02cysAMiwFUrpPzyUYsY7c
Z4n40HTEOa8nat42h5rqCnVIdJPBmNYWzFsCUBzOELFl11PF3yIkZ/f72wPwkShv
PFHRrki1bfSqpQs0WyPPAGXS+gVTpJY/qlAGB5VhZjAU3JyMlUFTGj1nZvM0H9hl
Ipq4bh94622GiF4rrkbT3/Qndr2nCA==
=CFvz
-----END PGP SIGNATURE-----

--zoXV23kthTxZLA1X--

