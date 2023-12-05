Return-Path: <netdev+bounces-53941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE58805541
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F2B1F213F4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76BF54F85;
	Tue,  5 Dec 2023 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgGW1yM9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F84CDF7;
	Tue,  5 Dec 2023 12:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFD2C433C8;
	Tue,  5 Dec 2023 12:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701780886;
	bh=ZUW3bH9lap1pU6oOrX+4c8gMumKtpzivKK6//PJcYqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgGW1yM9YXS/WiNNYTXZKDgkj7n9w1mLPN97qO1RFh0Vx4yoatSrKesNDfPCmvbt9
	 LA4r4bFcNZdR5xZf5al+YtiWSnjBBB0R+UUMTpyv3Ph/qWPLRAa2gOTY7IsjbnEdMT
	 VUr+hfIRvmRxXtFxbh1WOHujfMNwuGDvKRjdAzzFVUJ76KWW8k+gm6CR4X5CDJt23K
	 KlboCpApFnO5V6cmnf1ovndVjJ6UvADQePX0+tKl7/U60sOYBUVQT3ZL3ykR8jpNAk
	 8JxcI3G3sw4zapNzLRjd/lcCF3xizXWu7cfkQiBp1LJMWkopYIc5XzW4Vf7uyXJ/mp
	 0uAp97mONI7Pw==
Date: Tue, 5 Dec 2023 12:54:38 +0000
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
Subject: Re: [PATCH net-next v2 7/8] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <e08052bf-0301-4417-9e79-c48d41866ffc@sirena.org.uk>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-7-56d8cac607fa@bootlin.com>
 <20231204230845.GH981228@pengutronix.de>
 <20231205063606.GI981228@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cO95tLspe5Bb81aI"
Content-Disposition: inline
In-Reply-To: <20231205063606.GI981228@pengutronix.de>
X-Cookie: I've Been Moved!


--cO95tLspe5Bb81aI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 07:36:06AM +0100, Oleksij Rempel wrote:

> CC regulator devs here. PSE is a regulator for network devices :)=20

Is there some question related to regulators here?  I couldn't spot one.

--cO95tLspe5Bb81aI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvHY0ACgkQJNaLcl1U
h9Cj7Af+JOnCNtO3ZAgvtMkuUfdU5lVliJZyThUXZHQxXqKRM0SJvxmaaalLJvuM
Z/imYTaQ8ULqmVdxUcEFa+VJ4XVKQUs9ejFgn3qc5ENCBDSJs6m+m7xedbk0RqWd
6XZlZ31+WHcc8If6BcF+Gpy9kr7WtozWJKUr0wDytNmk0b/zpTEnwKQhqpCTCLyF
kaAHlcgnjM8OumpA9sGAHrKAw2h+tPcSQl69iCjAxX0RDOxDRnt9GgxN8+uc+UdK
8CcXaLI3V2hPapUH06DhCqPhw9CFo88tOqInMnm/yxhzljNibpx2U+lycydKRV2j
SbeWy5OVcgj+XCurxZ2jrt0S4Cs0RA==
=0rK9
-----END PGP SIGNATURE-----

--cO95tLspe5Bb81aI--

