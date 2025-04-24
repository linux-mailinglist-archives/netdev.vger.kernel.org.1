Return-Path: <netdev+bounces-185491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6F8A9AA7C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715CF467C47
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2C2367D2;
	Thu, 24 Apr 2025 10:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DDF233D64;
	Thu, 24 Apr 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490537; cv=none; b=NcQowIu+oVyGIwMmHttxge/Q2q0VCMa4HVUbbTvxny5zZYkuA2pDVCIPqEYEnWgXetb6SO4OGeq09EQ3b+HMIRn9xw5mBUn2SlPuukLQS/xejbGQx8r0/2zZKwNIC7vUr7wWdU2sEremZvbjIWI6MV0Sjpyf9kp2fv+tveJJobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490537; c=relaxed/simple;
	bh=I3Yp1YC8RYR0QAk/38zVfCmTj46GW+ntIKQzSiFsPl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xtb6aro+uCMbLvCbUCCfjIpWOqzTBXxDeE6SYFH63GlGqaS/mx0E6ickaOi0z2k6uUi1glW8MkbLzgzXiwv5G0jyM5VNsKstYaNiPrzzEnOR7e3RHuQWmte0LorMPwjOYA2OPtQoIcvWA9MQ2Zy9nb2atVRTDhx/khw8uoFZrmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5499659e669so888031e87.3;
        Thu, 24 Apr 2025 03:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745490531; x=1746095331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIj64A9Kj7dSdNG5r+KzTmwdGPe5B5brgWerOzNi7es=;
        b=cqZWwTq4Rqn2KVtX6YT70OhMMEP4BHQytreLlTvEQszNl8enj+hcACDfO7s58f8lOo
         MIXuLfwGkbDCKVrd6sdQRFgjWCP656iKeejOZI1htSCWY4zZQzzcKKMeqjpnbno0BrUI
         wi6XXnL8ZhxybTnGoaHdmT7abnf2RwiVkKJ0bzsL28bN6bGwfkyTt5mUUpKTvGi57Yl1
         5+DBgonikIqr5cS1F4Dh3ma1sUhpzbEEX41DAbyKLoAl0t9rZ7Byeex2R3U+HfW2C3uf
         tn5VLYqWsHtRsTnKjgnWaaIaY98mZBcYUYy57DM38CK45GaNNuHnZMlCHtnVAIFnxAnP
         oLQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ryHAyyxk8LALdIY/pK71xZuCli14fwlLpzvbQWXmGclzBZi/Ng1aFaZpAELlfo6NY63P0BwXc8Np@vger.kernel.org, AJvYcCU9hRmUj2IxbPqIC+3SL5gnQQtJl70hxl242rIU7HQoEld8SjVXaDY2NF8meHDI/l5VVr1nDdBfHblBkzET@vger.kernel.org, AJvYcCXHdz6AXB7ViXVTzxpCVLe2VPNWPhh5VwrvhRaRnruas4kTLOkZB8ICH0XIJNBx5EkQfGkqp6AK@vger.kernel.org
X-Gm-Message-State: AOJu0YwGiVqp/UZXjZjF8ThlJSh84TmFaWBiefKz+AfnZj3lcH2OOvmm
	/0Bq+lVxlXYsLWISAAll8BCOZBq1SuHBsnmMhQrnrtM3Pe4DEJytxQZ7t0gR
X-Gm-Gg: ASbGnctdtKy0Qod/gQNtNNGYtFGL3GWAJfEe3XdgWE4r80eTZwHrB6FcSuMheGx7+xQ
	wY1uSIc63fexF1BaURxqy2SwYl/5vyW0X0fyPcfClDtK05rlOBENn3H4Q2zAZlI1txACZkr1YGM
	8wCzL/iYZiP3qS+f6D0Q/ZXG4zJGr3QLVepQTToDAu+OqwaJ5CekLOjna1by3yNYuJQBqalCTeK
	iJknMULaA35jh0z4IPrPLo6Rnjt3n1RutZayzE0XWOz2WKuBCT6Cu5XUJIhXg7hAPKxMFjDty3K
	DkQjBzGCdMfjjpzpnbK48BDVyWT3RmvwkCoKrIWN0gz9WTs9Aq4BN0GgSu0RRZLDQ/xCBRHYIQ=
	=
X-Google-Smtp-Source: AGHT+IGjj04KSkKJdU0n7VU1ArBXsZuPNeIURX6fW7DDzGwdjuohN4xuHglyimb2iJk7ICd4Eax7Dg==
X-Received: by 2002:a05:6512:4013:b0:549:b28b:17bd with SMTP id 2adb3069b0e04-54e7c542a64mr724256e87.35.1745490531065;
        Thu, 24 Apr 2025 03:28:51 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cc9eb4bsm182524e87.137.2025.04.24.03.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 03:28:49 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30db2c2c609so11028701fa.3;
        Thu, 24 Apr 2025 03:28:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK3DcQS+Mh3B1v59TLNReMmN3NH5NXNXHV8XP6Jak2rp130HENDxjMC3NCsG5jeCcPf8Krtkoo@vger.kernel.org, AJvYcCX7QG6GOhIUWLr3WjI9BZt6JtDGCoi3EgKaf8byIN22h67BlZldKhuMztjUHMv0qvtvsqtiOsLveZGxih9L@vger.kernel.org, AJvYcCXGw/83lL/gzImX3Su3cmb7W9bf/dpgj1SUEdaOY95VD6GnZoejSNi/pGNKkcoj9BikN27mDTCGAArN@vger.kernel.org
X-Received: by 2002:a05:651c:1513:b0:30c:4346:b1ae with SMTP id
 38308e7fff4ca-3179ffc88femr9768651fa.33.1745490529368; Thu, 24 Apr 2025
 03:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-3-46ee4c855e0a@gentoo.org> <20250424014314.146e088f@minigeek.lan>
 <20250424032836-GYC47799@gentoo>
In-Reply-To: <20250424032836-GYC47799@gentoo>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 24 Apr 2025 18:28:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v65WaC_6vExOoeRvhQxvk3fhiEyJL8Cfhyeq7vseMtoYUQ@mail.gmail.com>
X-Gm-Features: ATxdqUETS2xqqAY8auwUfOgAexX7AZr4wXke2z1Y8iAkz-BxG6Ttd6UjjiwNFRU
Message-ID: <CAGb2v65WaC_6vExOoeRvhQxvk3fhiEyJL8Cfhyeq7vseMtoYUQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
To: Yixun Lan <dlan@gentoo.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:28=E2=80=AFAM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Andre,
>
> On 01:43 Thu 24 Apr     , Andre Przywara wrote:
> > On Wed, 23 Apr 2025 22:03:24 +0800
> > Yixun Lan <dlan@gentoo.org> wrote:
> >
> > Hi Yixun,
> >
> > thanks for sending those patches!
> >
> > > Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
> > > including the A527/T527 chips.
> >
> > maybe add here that MAC0 is compatible to the A64, and requires an
> > external PHY. And that we only add the RGMII pins for now.
> >
> ok
>
> > > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 42 ++++++++++++++++=
++++++++++
> > >  1 file changed, 42 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/ar=
m64/boot/dts/allwinner/sun55i-a523.dtsi
> > > index ee485899ba0af69f32727a53de20051a2e31be1d..c3ba2146c4b45f72c2a56=
33ec434740d681a21fb 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > > @@ -126,6 +126,17 @@ pio: pinctrl@2000000 {
> > >                     interrupt-controller;
> > >                     #interrupt-cells =3D <3>;
> > >
> > > +                   emac0_pins: emac0-pins {
> >
> > Both the alias and the node name should contain rgmii instead of emac0,
> > as the other SoCs do, I think:
> >                       rgmii0_pins: rgmii0-pins {
> >
> ok
> > > +                           pins =3D "PH0", "PH1", "PH2", "PH3",
> > > +                                   "PH4", "PH5", "PH6", "PH7",
> > > +                                   "PH9", "PH10","PH13","PH14",
> > > +                                   "PH15","PH16","PH17","PH18";
> >
> > I think there should be a space behind each comma, and the
> > first quotation marks in each line should align.
> >
> will do
>
> > PH13 is EPHY-25M, that's the (optional) 25 MHz output clock pin, for
> > PHYs without a crystal. That's not controlled by the MAC, so I would
> > leave it out of this list, as also both the Avaota and the Radxa don't
> > need it. If there will be a user, they can add this separately.
> >
> make sense
>
> > > +                           allwinner,pinmux =3D <5>;
> > > +                           function =3D "emac0";
> > > +                           drive-strength =3D <40>;
> > > +                           bias-pull-up;
> >
> > Shouldn't this be push-pull, so no pull-up?
> >
> will drop

It would be better to have an explicit "bias-disable" here.
That way you are not depending on the bootloader setting a
certain state, or depending on the reset default.

ChenYu

> > The rest looks correct, when compared to the A523 manual.
> >
> thanks for review
>
> --
> Yixun Lan (dlan)

