Return-Path: <netdev+bounces-211504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4867B19CBD
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009D31771BB
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEBA238D52;
	Mon,  4 Aug 2025 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej79/ZjL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579552E3705;
	Mon,  4 Aug 2025 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293053; cv=none; b=bMdl6qoDORvpSikKsHBgmVXqUTnJ7E1v6lhM2Hoer6u8fh0j5JZjf+eHHPzmIWjxApgaCOoQTQjzU0tLXQQT39rC434xZSt4tcRw0SRbwRnoWkcnPezGKlzdYBYBhF3KEW6/qwTCPYtPY8+6AwVXUbMj6Mzw1b2WsegJsC1+AB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293053; c=relaxed/simple;
	bh=Hy50DwegmXkBEIcfBMpAQwt7iPyBXtj+MWF3Z0JBf2o=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=KMgpp7/F2v+kDZTuoQThOUequxSTWuH87OtQeasEYeVce1/vtW6btTqJm1dBRjvnSXQRMeT38Br+4SrnXxDS7N+f3IxAD1ZBu9oxv7QSKn+9bGC4cwywn6d94eS/Ye6o6qGl4mwd9wlgRAXL/77tdcrIgXrPapFB5OAhbwAT1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej79/ZjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2C4C4CEE7;
	Mon,  4 Aug 2025 07:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754293052;
	bh=Hy50DwegmXkBEIcfBMpAQwt7iPyBXtj+MWF3Z0JBf2o=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=Ej79/ZjL7SoWXmTTqxezzowa7FoDmtHvbMzAkNnf8svXiIqmtM+UmfM1uP8RlS3Wg
	 UFndA2+420DqG7FnR4BX9C+BG/kmAcyvzDTznqf01uxDGoVISJNrD6bm/5PXEvnX4U
	 D3pZ6unGCBcS6pi6j0cP+OmuK3dU7i0MOvv0AcaOG/AG4GrQBIoPLOUeppf1BnPKCc
	 MTmO8Ug4oIi1L7FaEUEQ21BM3/9SjbvXjuNJ163E6SBfz6ej5+HWf1ohrrrD3F5dT/
	 458AszK06u/JQE3/WdYvXZCPRe57FTGdYMZ/CA1M31U3GNvtnFtwmQ1oOvJVQm2LNE
	 wr2zljuReTrbA==
Content-Type: multipart/signed;
 boundary=10d157f1bbc1d46e05d56827db4bb5cdcb9554d40060213328a4fcc6eada;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 04 Aug 2025 09:37:28 +0200
Message-Id: <DBTGZGPLGJBX.32VALG3IRURBQ@kernel.org>
Subject: Re: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup
 PHY mode for fixed RGMII TX delay"
Cc: "Matthias Schiffer" <matthias.schiffer@ew.tq-group.com>, "Nishanth
 Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo"
 <kristo@kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Roger
 Quadros" <rogerq@kernel.org>, "Simon Horman" <horms@kernel.org>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@ew.tq-group.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>, "Andrew Lunn"
 <andrew@lunn.ch>
X-Mailer: aerc 0.16.0
References: <20250728064938.275304-1-mwalle@kernel.org>
 <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
 <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
 <d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
 <DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org>
 <2269f445fb233a55e63460351ab983cf3a6a2ed6.camel@ew.tq-group.com>
 <88972e3aa99d7b9f4dd1967fbb445892829a9b47.camel@ew.tq-group.com>
 <84588371-ddae-453e-8de9-2527c5e15740@lunn.ch>
 <47b0406f-7980-422e-b63b-cc0f37d86b18@ti.com>
In-Reply-To: <47b0406f-7980-422e-b63b-cc0f37d86b18@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

--10d157f1bbc1d46e05d56827db4bb5cdcb9554d40060213328a4fcc6eada
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Aug 2, 2025 at 7:44 AM CEST, Siddharth Vadapalli wrote:
> On Wed, Jul 30, 2025 at 04:27:52PM +0200, Andrew Lunn wrote:
> > > I can confirm that the undocumented/reserved bit switches the MAC-sid=
e TX delay
> > > on and off on the J722S/AM67A.
> >=20
> > Thanks.
> >=20
> > > I have not checked if there is anything wrong with the undelayed
> > > mode that might explain why TI doesn't want to support it, but
> > > traffic appears to flow through the interface without issue if I
> > > disable the MAC-side and enable the PHY-side delay.
> >=20
> > I cannot say this is true for TI, but i've often had vendors say that
> > they want the MAC to do the delay so you can use a PHY which does not
> > implement delays. However, every single RGMII PHY driver in Linux
> > supports all four RGMII modes. So it is a bit of a pointless argument.
> >=20
> > And MAC vendors want to make full use of the hardware they have, so
> > naturally want to do the delay in the MAC because they can.
> >=20
> > TI is a bit unusual in this, in that they force the delay on. So that
> > adds a little bit of weight towards maybe there being a design issue
> > with it turned off.
>
> Based on internal discussions with the SoC and Documentation teams,
> disabling TX delay in the MAC (CPSW) is not officially supported by
> TI. The RGMII switching characteristics have been validated only with
> the TX delay enabled - users are therefore expected not to disable it.

Of all the myriad settings of the SoC, this was the one which was
not validated? Anyway, TI should really get that communicated in a
proper way because in the e2e forum you'll get the exact opposite
answer, which is, it is a documentation issue. And also, the
original document available to TI engineers apparently has that setting
documented (judging by the screenshot in the e2e forum).

> Disabling the TX delay may or may not result in an operational system.
> This holds true for all SoCs with various CPSW instances that are
> programmed by the am65-cpsw-nuss.c driver along with the phy-gmii-sel.c
> driver.

In that case u-boot shall be fixed, soon. And to workaround older
u-boot versions, linux shall always enable that delay, like Andrew
proposed.

> In addition to the above, I would like to point out the source of
> confusion. When the am65-cpsw-nuss.c driver was written(2020), the
> documentation indicated that the internal delay could be disabled.
> Later on, the documentation was updated to indicate that internal
> delay cannot (should not) be disabled by marking the feature reserved.

> This was done to be consistent with the hardware validation performed.
> As a result, older documentation contains references to the possibility
> of disabling the internal delay whereas newer documentation doesn't.

See above, that seems to be still the case.

-michael

--10d157f1bbc1d46e05d56827db4bb5cdcb9554d40060213328a4fcc6eada
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaJBjORIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hpXQGAiBriOv6IxHVS6UwhziglQphaJZrmpxYR
YAbDagIe390sSFp7Pi0Y/oVGf3FwEuHfAYC/fr7B4DQ+HPyxVJof5DCRAUkBIns4
Ee7ORDQG56K+mXINMqu2MEjWSOkZ3HgzZBw=
=zjdQ
-----END PGP SIGNATURE-----

--10d157f1bbc1d46e05d56827db4bb5cdcb9554d40060213328a4fcc6eada--

