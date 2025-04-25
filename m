Return-Path: <netdev+bounces-186026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCE6A9CC66
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5ED4E287E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798425DD12;
	Fri, 25 Apr 2025 15:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993025D20D;
	Fri, 25 Apr 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593545; cv=none; b=gZgWKjrbB5PuAXgxhBhtrAfa2XxPTd9Me/TVvbaWyWjzR5ThdCMA1c01/01Tp/s2GZ78gJgwowfmASPLhJLTbOvbT3Xm9uiWnpjIYyBjrtYQczk6Rzu/DyewNu3h8Ua+e4xMNQQ+4hj91EZviEBxQ22fp4XLhJ6Ra4bKzzWEDXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593545; c=relaxed/simple;
	bh=p0doezY0qRJoQyRKWjT90kO1zQ1vjFowzJ8Ke6uItuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eD6W8makHJGTca7fVuXhRUXALBX/r6Vc9Po84f+AAGs7nxk7RbiElVKwqeOBm0ktU8Scg3gckvRow6pvMue0EyyVdvgJo7jq4b6hlsCgd8FOxaw80MjKtBnUUNlK3J2/CWA52GogysHRUecyQRHCx9h6iwthCBtBKqGFOtSoJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9847D106F;
	Fri, 25 Apr 2025 08:05:36 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1867B3F59E;
	Fri, 25 Apr 2025 08:05:38 -0700 (PDT)
Date: Fri, 25 Apr 2025 16:05:35 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet
 MAC
Message-ID: <20250425160535.5a18adbb@donnerap.manchester.arm.com>
In-Reply-To: <CAGb2v65QUrCjgHXWAb72Sdppqg1AUxXyD_ZcXShtkRSHCQBbOg@mail.gmail.com>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
	<20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org>
	<CAGb2v66a4ERAf_YhPkMWJjm26SsfjO3ze_Zp=QqkXNDLaLnBRg@mail.gmail.com>
	<20250425104128.14f953f3@donnerap.manchester.arm.com>
	<CAGb2v65QUrCjgHXWAb72Sdppqg1AUxXyD_ZcXShtkRSHCQBbOg@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Apr 2025 22:35:59 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

adding LinusW for a more generic pinctrl question ...

> On Fri, Apr 25, 2025 at 5:41=E2=80=AFPM Andre Przywara <andre.przywara@ar=
m.com> wrote:
> >
> > On Fri, 25 Apr 2025 13:26:25 +0800
> > Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi Chen-Yu,
> > =20
> > > On Thu, Apr 24, 2025 at 6:09=E2=80=AFPM Yixun Lan <dlan@gentoo.org> w=
rote: =20
> > > >
> > > > Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
> > > > including the A527/T527 chips. MAC0 is compatible to the A64 chip w=
hich
> > > > requires an external PHY. This patch only add RGMII pins for now.
> > > >
> > > > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > > > ---
> > > >  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 40 ++++++++++++++=
++++++++++++
> > > >  1 file changed, 40 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/=
arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > > > index ee485899ba0af69f32727a53de20051a2e31be1d..c9a9b9dd479af05ba22=
fe9d783e32f6d61a74ef7 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > > > @@ -126,6 +126,15 @@ pio: pinctrl@2000000 {
> > > >                         interrupt-controller;
> > > >                         #interrupt-cells =3D <3>;
> > > >
> > > > +                       rgmii0_pins: rgmii0-pins {
> > > > +                               pins =3D "PH0", "PH1", "PH2", "PH3"=
, "PH4",
> > > > +                                      "PH5", "PH6", "PH7", "PH9", =
"PH10",
> > > > +                                      "PH14", "PH15", "PH16", "PH1=
7", "PH18";
> > > > +                               allwinner,pinmux =3D <5>;
> > > > +                               function =3D "emac0";
> > > > +                               drive-strength =3D <40>; =20
> > >
> > > We should probably add
> > >
> > >                                   bias-disable;
> > >
> > > to explicitly turn off pull-up and pull-down. =20
> >
> > Should we? I don't see this anywhere else for sunxi, probably because i=
t is
> > the (reset) default (0b00).
> > I wonder if we have a hidden assumption about this? As in: if no bias is
> > specified, we assume bias-disable? Then we should maybe enforce this is=
 in
> > the driver? =20
>=20
> There isn't any assumption, as in we were fine with either the reset
> default or whatever the bootloader left it in. However in projects at
> work I learned that it's better to have explicit settings despite
> working defaults.

I totally agree, but my point was that this applies basically to every
pinctrl user. I usually think of the bias settings as "do we need
pull-ups or pull-downs", and if nothing is specified, I somewhat assume
bias-disable.

So I am fine with this being added here, but was wondering if we should
look at a more generic solution.

Linus: is bias-disable assumed to be the default, that pinctrl drivers
should set in absence of explicit properties? Or is this "whatever is in
the registers at boot" the default we have to live with?

Cheers,
Andre

