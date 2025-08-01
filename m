Return-Path: <netdev+bounces-211341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF04B1816D
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0941C25761
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C01FF1BF;
	Fri,  1 Aug 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLrFFQxs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3515580B;
	Fri,  1 Aug 2025 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049683; cv=none; b=nUoQgGOGQb4Qw994B+wlyiHTOOhdDQ4bp/4WDBYJWoV/E8Sv87ffvgQZs6Is2c1+dOVqS88GV8sz0NhrSFzT002maJQPOlkcVmNjNeM+2CfrMJHP43Ge5gK35hDu3uakuQqSeMBqQNkicLaXAv5huBMkbVuztP4Pjzcv9Xa8860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049683; c=relaxed/simple;
	bh=9+Jd99desmQ3vwv0Jdep0nHcwp7vUTWh0+6D7DDQjQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4GIVPkUAuIm6+zsct/85w6eRL41VHAryybE2t6ADG4rdTJ6JKv0DpzLKXHccIEv6ez55KWHemsa/BN86EQCsRtkIxvGP/D1igWIChgvVsalANp4J3BUzTL3g7oJcQxTeJuvzfKL853/41o9CKg/84XiAPgPgiRRN1pBoay1sCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLrFFQxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8929EC4CEE7;
	Fri,  1 Aug 2025 12:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754049682;
	bh=9+Jd99desmQ3vwv0Jdep0nHcwp7vUTWh0+6D7DDQjQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLrFFQxsEkx9hV+CzEGnQIwq/jhrwwBBrFJyU5NCqMDbZhyySvEbb/vwlLh3A1v6G
	 DWPUpakk9uOkQs0GeWjaSCNLvuQV4yYzqJX67eYg7pJCANsMyTNcLRkiL3JfeSujdL
	 H6AH8QL+A2bQ8Xk/PpsKRAAn5AH4DCD9+xk+tA0NH9OHvjXq4e57NxRoSxgKFwB8zs
	 mQ37Tph0haB15rKfRUgpIL5fs80gCS/Yerq380S2lWyNp86PtOfSr2RAZqYWcH4fhT
	 ILGoBaWGs9+RumXeatjl9il/3pBe0ndS+IbN44qxobDReQR/8DoIqyeKjweMOprA8r
	 dYzHfg4jddGoA==
Date: Fri, 1 Aug 2025 13:01:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Csaba Buday <buday.csaba@prolan.hu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: mdio_bus: Use devm for getting reset GPIO
Message-ID: <95449490-fa58-41d4-9493-c9213c1f2e7d@sirena.org.uk>
References: <20250728153455.47190-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dTuiP5h9CjyworoS"
Content-Disposition: inline
In-Reply-To: <20250728153455.47190-2-csokas.bence@prolan.hu>
X-Cookie: Go 'way!  You're bothering me!


--dTuiP5h9CjyworoS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 05:34:55PM +0200, Bence Cs=F3k=E1s wrote:
> Commit bafbdd527d56 ("phylib: Add device reset GPIO support") removed
> devm_gpiod_get_optional() in favor of the non-devres managed
> fwnode_get_named_gpiod(). When it was kind-of reverted by commit
> 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()"), the devm
> functionality was not reinstated. Nor was the GPIO unclaimed on device
> remove. This leads to the GPIO being claimed indefinitely, even when the
> device and/or the driver gets removed.

I'm seeing multiple platforms including at least Beaglebone Black,
Tordax Mallow and Libre Computer Alta printing errors in
next/pending-fixes today:

[    3.252885] mdio_bus 4a101000.mdio:00: Resources present before probing

Bisects are pointing to this patch which is 3b98c9352511db in -next,
full log for Beaglebone at:

   https://lava.sirena.org.uk/scheduler/job/1627658

and Mallow at:

   https://lava.sirena.org.uk/scheduler/job/1627696

and a bisect log (this one for Beaglebone):

# bad: [02694a9281c9b3da7f7574f9f39a69cc70e344ce] Merge branch 'dt/linus' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
# good: [f2d282e1dfb3d8cb95b5ccdea43f2411f27201db] Merge tag 'bitmap-for-6.=
17' of https://github.com/norov/linux
# good: [50a479527ef01f9b36dde1803a7e81741a222509] ASoC: SDCA: Add support =
for -cn- value properties
# good: [10dfd36f078423c51602a9a21ed85e8e6c947a00] regulator: core: correct=
 convergence check in regulator_set_voltage()
# good: [11f74f48c14c1f4fe16541900ea5944c42e30ccf] ASoC: Intel: avs: Fix un=
initialized pointer error in probe()
# good: [ca592e20659e0304ebd8f4dabb273da4f9385848] ASoC: fsl_xcvr: get chan=
nel status data when PHY is not exists
# good: [a735ee58c0d673d630a10ac2939dccb54df0622a] spi: cs42l43: Property e=
ntry should be a null-terminated array
# good: [061fade7a67f6cdfe918a675270d84107abbef61] ASoC: SDCA: Fix some hol=
es in the regmap readable/writeable helpers
# good: [eb3bb145280b6c857a748731a229698e4a7cf37b] ASoC: SOF: amd: acp-load=
er: Use GFP_KERNEL for DMA allocations in resume context
# good: [e95122a32e777309412e30dc638dbc88b9036811] ASoC: codecs: Add acpi_m=
atch_table for aw88399 driver
# good: [da98e8b97058c73b5c58e9976af2e7286f1c799b] ASoC: dt-bindings: atmel=
,at91-ssc: add microchip,sam9x7-ssc
# good: [926406a85ad895fbe6ee4577cdbc4f55245a0742] MAINTAINERS: Add entries=
 for the RZ/V2H(P) RSPI
# good: [8d452accd1380e1cb0b15a9876bcd19b14c5fabb] ASoC: wm8962: Clear mast=
er mode when enter runtime suspend
# good: [7379907e241d85803efc1d9eb27c28a6322e274f] ASoC: fsl_xcvr: get chan=
nel status data in two cases
# good: [2260bc6ea8bd57aec92cbda770de9cc95232f64d] ASoC: imx-card: Add WM85=
24 support
# good: [6776ecc9dd587c08a6bb334542f9f8821a091013] ASoC: fsl_xcvr: get chan=
nel status data with firmware exists
# good: [1032fa556c37c500bf2b93d95fa18e7d1fd1b4de] More minor SDCA changes
git bisect start '02694a9281c9b3da7f7574f9f39a69cc70e344ce' 'f2d282e1dfb3d8=
cb95b5ccdea43f2411f27201db' '50a479527ef01f9b36dde1803a7e81741a222509' '10d=
fd36f078423c51602a9a21ed85e8e6c947a00' '11f74f48c14c1f4fe16541900ea5944c42e=
30ccf' 'ca592e20659e0304ebd8f4dabb273da4f9385848' 'a735ee58c0d673d630a10ac2=
939dccb54df0622a' '061fade7a67f6cdfe918a675270d84107abbef61' 'eb3bb145280b6=
c857a748731a229698e4a7cf37b' 'e95122a32e777309412e30dc638dbc88b9036811' 'da=
98e8b97058c73b5c58e9976af2e7286f1c799b' '926406a85ad895fbe6ee4577cdbc4f5524=
5a0742' '8d452accd1380e1cb0b15a9876bcd19b14c5fabb' '7379907e241d85803efc1d9=
eb27c28a6322e274f' '2260bc6ea8bd57aec92cbda770de9cc95232f64d' '6776ecc9dd58=
7c08a6bb334542f9f8821a091013' '1032fa556c37c500bf2b93d95fa18e7d1fd1b4de'
# test job: [50a479527ef01f9b36dde1803a7e81741a222509] https://lava.sirena.=
org.uk/scheduler/job/1604113
# test job: [10dfd36f078423c51602a9a21ed85e8e6c947a00] https://lava.sirena.=
org.uk/scheduler/job/1617510
# test job: [11f74f48c14c1f4fe16541900ea5944c42e30ccf] https://lava.sirena.=
org.uk/scheduler/job/1622131
# test job: [ca592e20659e0304ebd8f4dabb273da4f9385848] https://lava.sirena.=
org.uk/scheduler/job/1604636
# test job: [a735ee58c0d673d630a10ac2939dccb54df0622a] https://lava.sirena.=
org.uk/scheduler/job/1625798
# test job: [061fade7a67f6cdfe918a675270d84107abbef61] https://lava.sirena.=
org.uk/scheduler/job/1604012
# test job: [eb3bb145280b6c857a748731a229698e4a7cf37b] https://lava.sirena.=
org.uk/scheduler/job/1614504
# test job: [e95122a32e777309412e30dc638dbc88b9036811] https://lava.sirena.=
org.uk/scheduler/job/1607730
# test job: [da98e8b97058c73b5c58e9976af2e7286f1c799b] https://lava.sirena.=
org.uk/scheduler/job/1604614
# test job: [926406a85ad895fbe6ee4577cdbc4f55245a0742] https://lava.sirena.=
org.uk/scheduler/job/1617649
# test job: [8d452accd1380e1cb0b15a9876bcd19b14c5fabb] https://lava.sirena.=
org.uk/scheduler/job/1621163
# test job: [7379907e241d85803efc1d9eb27c28a6322e274f] https://lava.sirena.=
org.uk/scheduler/job/1605837
# test job: [2260bc6ea8bd57aec92cbda770de9cc95232f64d] https://lava.sirena.=
org.uk/scheduler/job/1604642
# test job: [6776ecc9dd587c08a6bb334542f9f8821a091013] https://lava.sirena.=
org.uk/scheduler/job/1604670
# test job: [1032fa556c37c500bf2b93d95fa18e7d1fd1b4de] https://lava.sirena.=
org.uk/scheduler/job/1605715
# test job: [02694a9281c9b3da7f7574f9f39a69cc70e344ce] https://lava.sirena.=
org.uk/scheduler/job/1627658
# bad: [02694a9281c9b3da7f7574f9f39a69cc70e344ce] Merge branch 'dt/linus' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
git bisect bad 02694a9281c9b3da7f7574f9f39a69cc70e344ce
# test job: [4889166d1aaa4761f1162e01487b129aad7ef6a6] https://lava.sirena.=
org.uk/scheduler/job/1627868
# bad: [4889166d1aaa4761f1162e01487b129aad7ef6a6] Merge branch 'main' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
git bisect bad 4889166d1aaa4761f1162e01487b129aad7ef6a6
# test job: [29c349380205ced75f66c0ccab821d00ff50d123] https://lava.sirena.=
org.uk/scheduler/job/1627932
# good: [29c349380205ced75f66c0ccab821d00ff50d123] Merge branch 'arm/fixes'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect good 29c349380205ced75f66c0ccab821d00ff50d123
# test job: [2da4def0f487f24bbb0cece3bb2bcdcb918a0b72] https://lava.sirena.=
org.uk/scheduler/job/1628009
# good: [2da4def0f487f24bbb0cece3bb2bcdcb918a0b72] netpoll: prevent hanging=
 NAPI when netcons gets enabled
git bisect good 2da4def0f487f24bbb0cece3bb2bcdcb918a0b72
# test job: [3b98c9352511db627b606477fc7944b2fa53a165] https://lava.sirena.=
org.uk/scheduler/job/1628132
# bad: [3b98c9352511db627b606477fc7944b2fa53a165] net: mdio_bus: Use devm f=
or getting reset GPIO
git bisect bad 3b98c9352511db627b606477fc7944b2fa53a165
# test job: [f2aa00e4f65efcf25ff6bc8198e21f031e7b9b1b] https://lava.sirena.=
org.uk/scheduler/job/1628177
# good: [f2aa00e4f65efcf25ff6bc8198e21f031e7b9b1b] net: ipa: add IPA v5.1 a=
nd v5.5 to ipa_version_string()
git bisect good f2aa00e4f65efcf25ff6bc8198e21f031e7b9b1b
# test job: [57ec5a8735dc5dccd1ee68afdb1114956a3fce0d] https://lava.sirena.=
org.uk/scheduler/job/1628433
# good: [57ec5a8735dc5dccd1ee68afdb1114956a3fce0d] net: phy: smsc: add prop=
er reset flags for LAN8710A
git bisect good 57ec5a8735dc5dccd1ee68afdb1114956a3fce0d
# first bad commit: [3b98c9352511db627b606477fc7944b2fa53a165] net: mdio_bu=
s: Use devm for getting reset GPIO

--dTuiP5h9CjyworoS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiMrIsACgkQJNaLcl1U
h9D2+gf/QQvtx1kydJuhj5PdCQQY/VfNhLzsVJlZbIg8bPkUaN780S0y8+WeWei4
BTdAuZrS7gWYghasXBmSTuqmRYtfiIEISoLDSgCoWbK9Oj59OFREO+C5WzWzMWez
zKh7vt9t8JxIs3AhT68gDeHxwCjiHWzFu6nZmdNFys52utF7tl5tYjukHdN74JjD
4mpLO6LVa3R8V3CD25ogELo8Mj9nWgDmj1yy3/uYfbr1jbDAZrFg7CcxRc1FX5y1
eeYe/Uo+Kz5BHzO5oHgaLzJCuIjUApBTV6+jBK3UWH3Ml5fB3hdeG8iJmbESNyml
uwMKhxis0YTUh7TCviPAQfWHe+AuGA==
=zFSS
-----END PGP SIGNATURE-----

--dTuiP5h9CjyworoS--

