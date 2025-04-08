Return-Path: <netdev+bounces-180344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701C6A81046
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47191B65E1A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A6322D7B0;
	Tue,  8 Apr 2025 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIUnuqwm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC222B598;
	Tue,  8 Apr 2025 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126407; cv=none; b=lk5Y6jfp85ucV96sK4Er35WVHQuk3aQq8Ft1q6aVIsdEbpk6kwT7j0GiAkIwc9ljaASKCehWl3YGRAzqdhLQfMf6wod9YH+lCeVaCMicfPxNCaAEeMMWdh9zJ6xwPbJk8eIIv7ZNQL3CXyiZk+BWJijLrqkKonHYScst+JB1c/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126407; c=relaxed/simple;
	bh=jTDbRpm/2plpGWyuZcgnOrksZvCKonLIj49TrwkLGMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9uZxMB7uzqSSqR9AcEgSr+wz/cHmsEloBgW/7aD4Uoi5VCya4+TO0gKhgNIV20E+MlV6SdjTVmowTrrBu3lOUL/O8ZLZnBvOkagzI5sSSKmE1kPLV8hUcQnh1nNpnBWOcl0sZRFaVMFq7QTcnD41BdUr+Wc/FT4XfcVMVnQRu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIUnuqwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF28EC4CEE9;
	Tue,  8 Apr 2025 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126406;
	bh=jTDbRpm/2plpGWyuZcgnOrksZvCKonLIj49TrwkLGMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gIUnuqwmDKh1UdrcyGo5h8XkMiMGPrHjGP2Cmlp/98SG+JZqvfK3OyBJ+YaEE/Dw5
	 H6pY6EMPjEV6BhiE9oYP/y9FYAJYJMr9WztK+fOVQIp5YV7we+jfWPW1khCxcwglQg
	 xakHA48v1mIq6Fp8b1O39NyWxaTPUGkG6DN+U4mttyqTh1f/kLJSXedWGRbJ4/sVpX
	 NVgkHtZMImN2NAh4mD3IfY/HwQwNeu73yMxcVR5K77AWicjVlISZoq3O2gwIAwPC9L
	 KyUa3uiK/aqdj6hw7DeoXSa6j6ktcUkt8aXr4kggFWZjUtLWWN0oUJLCSktQwPDDgn
	 qX2hYtprje98g==
Date: Tue, 8 Apr 2025 08:33:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, upstream@airoha.com, Christian Marangi
 <ansuelsmth@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Kory
 Maincent <kory.maincent@bootlin.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Clark Wang <xiaoning.wang@nxp.com>, Claudiu
 Beznea <claudiu.beznea@microchip.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Joyce Ooi
 <joyce.ooi@intel.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Madalin
 Bucur <madalin.bucur@nxp.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Rob Herring <robh+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, Robert Hancock <robert.hancock@calian.com>,
 Saravana Kannan <saravanak@google.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v2 00/14] Add PCS core support
Message-ID: <20250408083324.3996c141@kernel.org>
In-Reply-To: <08c0e1eb-2de6-45bf-95a4-e817008209ab@linux.dev>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
	<20250408075047.69d031a9@kernel.org>
	<08c0e1eb-2de6-45bf-95a4-e817008209ab@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 11:30:43 -0400 Sean Anderson wrote:
> > These appear to break the build:
> >=20
> > drivers/acpi/property.c:1669:39: error: initialization of =E2=80=98int =
(*)(const struct fwnode_handle *, const char *, const char *, int,  unsigne=
d int,  struct fwnode_reference_args *)=E2=80=99 from incompatible pointer =
type =E2=80=98int (*)(const struct fwnode_handle *, const char *, const cha=
r *, unsigned int,  unsigned int,  struct fwnode_reference_args *)=E2=80=99=
 [-Wincompatible-pointer-types]
> >  1669 |                 .get_reference_args =3D acpi_fwnode_get_referen=
ce_args,   \
> >=20
> > Could you post as RFC until we can actually merge this? I'm worried=20
> > some sleep deprived maintainer may miss the note in the cover letter
> > and just apply it all to net-next.. =20
>=20
> I would really like to keep RFC off the titles since some reviewers don't
> pay attention to RFC series.
>=20
> Would [DO NOT MERGE] in the subject be OK?

That works too.

