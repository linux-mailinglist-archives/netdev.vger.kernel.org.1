Return-Path: <netdev+bounces-185947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A4A9C402
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDFE7B8312
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582EA230BC2;
	Fri, 25 Apr 2025 09:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F6221540;
	Fri, 25 Apr 2025 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574099; cv=none; b=nU0O0cPJxkQ+tj8+Bwq+LwhcS93FSgAsetL0ydX2bxO8w+lYoVNDewxOgaoNVsiv0ir36V7Gkz0sSD+GK42HgVNnpWsxWxaH4BatcF+ALQlwZd32Q9d4u/hc3XtEVUEQiJfQ0Sw+p6KAguvW+kqqgbiyNYFswmUtlLJQ9cfDS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574099; c=relaxed/simple;
	bh=nmlAACPdyi1o/ejLELZQWZEK1WfkrRpmg/mY+BUQcfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AF3fPpulRF39of7lEaDDbcJ9Ek7U3QegvMmRPbGz4QtC+ITpNvqquwwoeloBNoxd7/lk5jBAKgO6aHWdn5gHp+UoJuQ4O7hJnWGT2PzXR59KTcMT4SeaXERddK8bfKF2Z3tpS0bR34JRyypH+ZYKUcouYW8U1NlC7+BPIe1lDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4A941BCA;
	Fri, 25 Apr 2025 02:41:29 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4511E3F59E;
	Fri, 25 Apr 2025 02:41:32 -0700 (PDT)
Date: Fri, 25 Apr 2025 10:41:28 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>
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
Message-ID: <20250425104128.14f953f3@donnerap.manchester.arm.com>
In-Reply-To: <CAGb2v66a4ERAf_YhPkMWJjm26SsfjO3ze_Zp=QqkXNDLaLnBRg@mail.gmail.com>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
	<20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org>
	<CAGb2v66a4ERAf_YhPkMWJjm26SsfjO3ze_Zp=QqkXNDLaLnBRg@mail.gmail.com>
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

On Fri, 25 Apr 2025 13:26:25 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

Hi Chen-Yu,

> On Thu, Apr 24, 2025 at 6:09=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
> >
> > Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
> > including the A527/T527 chips. MAC0 is compatible to the A64 chip which
> > requires an external PHY. This patch only add RGMII pins for now.
> >
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 40 ++++++++++++++++++=
++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun55i-a523.dtsi
> > index ee485899ba0af69f32727a53de20051a2e31be1d..c9a9b9dd479af05ba22fe9d=
783e32f6d61a74ef7 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > @@ -126,6 +126,15 @@ pio: pinctrl@2000000 {
> >                         interrupt-controller;
> >                         #interrupt-cells =3D <3>;
> >
> > +                       rgmii0_pins: rgmii0-pins {
> > +                               pins =3D "PH0", "PH1", "PH2", "PH3", "P=
H4",
> > +                                      "PH5", "PH6", "PH7", "PH9", "PH1=
0",
> > +                                      "PH14", "PH15", "PH16", "PH17", =
"PH18";
> > +                               allwinner,pinmux =3D <5>;
> > +                               function =3D "emac0";
> > +                               drive-strength =3D <40>; =20
>=20
> We should probably add
>=20
>                                   bias-disable;
>=20
> to explicitly turn off pull-up and pull-down.

Should we? I don't see this anywhere else for sunxi, probably because it is
the (reset) default (0b00).
I wonder if we have a hidden assumption about this? As in: if no bias is
specified, we assume bias-disable? Then we should maybe enforce this is in
the driver?

Cheers,
Andre

