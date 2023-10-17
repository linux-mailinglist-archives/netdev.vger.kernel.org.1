Return-Path: <netdev+bounces-41932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E97CC4E3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9E81C20AB0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41F1436A5;
	Tue, 17 Oct 2023 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLI/hFso"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEAEBE;
	Tue, 17 Oct 2023 13:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D906FC433C7;
	Tue, 17 Oct 2023 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697549965;
	bh=RoziKrsJD6E/nYyqj1Ebyaqd5eUcEo8AVJSKW+3q8Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLI/hFsoGvWGtDNMHNjVmk8Aif9SDW8uUk/Qs3QPPnJ/83dHmSlP3iLgBU/FgFJ/e
	 ty3sOM8v6yaPaNEW5RJF3RD99KnzalPIePCpPmhSvN4aPcHN1dQD5ku6jQps9d3oh8
	 sDWT16mUg/KvDIbhbmn3ACgaa55WeOr+pt03CvSGLIqCKN7m3Mrz1mniPnT/68N0xb
	 71HfYdTfP0O7c1fP0LpnIA/QvMx3QSMnEVbMrvYQjWikpypkfa1Ulu3i67GflhP8zr
	 F72lDm4g5eDOldNW7GdDXYlKTAG7CNza+jvfvQfg6pwcU7jV36yyfy5qSsUqy7YkGG
	 OA6N6Q51RdAVg==
Date: Tue, 17 Oct 2023 14:39:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ante Knezic <ante.knezic@helmholz.de>, conor+dt@kernel.org,
	davem@davemloft.net, devicetree@vger.kernel.org,
	edumazet@google.com, f.fainelli@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marex@denx.de, netdev@vger.kernel.org,
	olteanv@gmail.com, pabeni@redhat.com, robh+dt@kernel.org,
	woojung.huh@microchip.com
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document
 microchip,rmii-clk-internal
Message-ID: <20231017-mocker-contort-5ea0d84e7e2d@spud>
References: <20231012-unicorn-rambling-55dc66b78f2f@spud>
 <20231016075349.18792-1-ante.knezic@helmholz.de>
 <20231017-generous-botanical-28436c5ba13a@spud>
 <8e1fb87d-b611-49f3-8091-a15b29e03659@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bEjA3mPhipjMVa1a"
Content-Disposition: inline
In-Reply-To: <8e1fb87d-b611-49f3-8091-a15b29e03659@lunn.ch>


--bEjA3mPhipjMVa1a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 02:59:46PM +0200, Andrew Lunn wrote:
> > The switch always provides it's own external reference, wut? Why would
> > anyone actually bother doing this instead of just using the internal
> > reference?
>=20
> I think you are getting provider and consumer mixed up.

The comment suggested that it was acting as both, via an external
loopback:
> > > In both cases (external and internal), the KSZ88X3 is actually provid=
ing the
> > > RMII reference clock. Difference is only will the clock be routed as =
external
> > > copper track (pin REFCLKO -> pin REFCLKI), or will it be routed inter=
nally.

If there's another interpretation for that, it's lost on me.
A later mail goes on to say:
> > > The KSZ88x3 does not have to provide the reference clock, it can be p=
rovided=20
> > > externally, by some other device, for example the uC.

So I think I was just picking up on a mistaken explanation.

> Lets simplify to just a MAC and a PHY. There needs to be a shared
> clock between these two. Sometimes the PHY is the provider and the MAC
> is the consumer, sometimes the MAC is the provider, and the PHY is the
> consumer. Sometimes the hardware gives you no choices, sometimes it
> does. Sometimes a third party provides the clock, and both are
> consumers.
>=20
> With the KSZ, we are talking about a switch, so there are multiple
> MACs and PHYs. They can all share the same clock, so long as you have
> one provider, and the rest are consumers. Or each pair can figure out
> its provider/consumer etc.

Thanks for the explanation. I'm still not really sure why someone would
want to employ external loopback, instead of the internal one though.

> How this is described in DT has evolved over time. We don't have clean
> clock provider/consumer relationships. The PHYs and MACs are generally
> not CCF consumers/providers. They just have a property to enable the
> to output a clock, or maybe a property to disable the clock output in
> order to save power. There are a few exceptions, but that tends to be
> where the clock provider is already CCF clock, e.g. a SoC clock.

Yeah, I did acknowledge that at the end of my mail (although I managed
to typo "that ship has sailed").
Doing ccf stuff doesn't seem viable given there's currently no required
clocks in the binding despite there likely being some in use.

I'm fine acking the binding with the change I suggested, I was just
looking to understand why a clocks property could not be used and I
think I have my answer to that now :)

Cheers,
Conor.

--bEjA3mPhipjMVa1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS6OiAAKCRB4tDGHoIJi
0lngAP0awQQcWcRDsKtuYoRW+xSLTyZWxTzBEKqGSpcMoFbF0QD8CHLj8FgKI1gO
ziNYtHwUuZkjpwMVzPO85p04nsb3vwU=
=J1bT
-----END PGP SIGNATURE-----

--bEjA3mPhipjMVa1a--

