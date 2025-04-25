Return-Path: <netdev+bounces-186020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF93A9CBCD
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0C11BA6960
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF342472A6;
	Fri, 25 Apr 2025 14:36:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285E0242D64;
	Fri, 25 Apr 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591779; cv=none; b=otriJ0miSNCvjMupb7QXgoRzWAQvCfRoMijFZu9QduqzmfHiWVKdWGts17fjpNSHcTuWvNiQ+jhEXk8bKB0D9KFt8SqBDp4bVzb3uH908UBLFeX9ZMqzA+ytbiWG9nhIMcRTIQB+N6nQyFcNrwD3VB39sbPsWR3VDSqCBnhzYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591779; c=relaxed/simple;
	bh=l0t+c9VOElcgGwPJX41n44akw+bTfnQ6M36YJZwvlaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEaeX+/+D8q68cNadq9akhzJdCc7EnDkIz3Yoi/VE8qwbF0zIdNBbosmnmHalaFYXL7QiDvA7K8zcgloNtFkl/zCUvyQXf7BkX1JYGBnL190m9V6Gh0tCaet5uRG7h6yhIExFE7JUzAsGj4C046ApdpedP2ZvBcVFAn8uN1Y/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549967c72bcso2629294e87.3;
        Fri, 25 Apr 2025 07:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745591774; x=1746196574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NR8AY7/r7j1Bynibp57ezAgc4LFEr9BMoNMHriAH6oo=;
        b=eKqoCGZXUKVUyp8XMCQ2y9AECuyP2c1BXEUrhRWeg7G9D9HUhGP0SaTBVt7LGsAMvN
         E8aeh/W75kCa70NM6LcPQJajNOE/4gLDRxfedsAU6Tvd/29yoYBrf9RbaRl/TURvXdzW
         AkqzYJEHbogmDezylPUtIPq9HxpN8oXootxE0PdAVrJ6MFvl1+RobHcJxp2q5z5JCxM5
         a1/BsBnmaiysGColCljFUr/PfnRmzyzG/2Ifnp4ISQEr6RpaHF6UhEyV3BQUOHaLY4CR
         5yxpqtwHYThiJ0liU0bcA0TVNMLAGViggGZ57vNMdl+pKyNM4RVkvBdGLFz40nlEDwoZ
         iVpw==
X-Forwarded-Encrypted: i=1; AJvYcCWJliMQU363PK5GcCUy03Ii7eXIJ6MoCiTCj0gs5wxbzu+daPsaHIYNuZYts7JuAZX3QvATmOJs@vger.kernel.org, AJvYcCWLe/5aSg37yAUIXkdlXYVnRZsVtvWWy30EZoz6JlzuwEA+l7yKiF2AHI4jXGOp9Wkh0B3XSJxJfVQao5lD@vger.kernel.org, AJvYcCXjGZU56DXG691SgiU7trtqIkKm9IewUB5ITOjcxOk+N+H1rEQKb29fHlZZx3BeSxtlMNTf2tiP5gRX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0jFaDZSvg9EeQDP4vuvP6gzo8Ekw/3HF4DiiBcfCAwk3GbLO
	A0VZnCItuCgCQGKXd0gZ7MfaZoJryUSQH+6VWPeonwJkihvccuHGnnaOui3o354=
X-Gm-Gg: ASbGncsH5j3xmO2Ic3tUfxdrsdvanDmPBIATs/bq4iinZaUj39+vgQtIsPBqyJgFxt4
	/mr1fZw50zjTDfxUBywUvPzsdh9xf13Phpqc/VcEDAJdJJZQ9rk5yAgdHRmLKJRaMFre309o1GX
	wMUJ2G/zp+SD/GLFQ0XGyMCFRqmHf3b98KThDHd75bVqbSH91VthTGtlEza+ceZCrEw7+8Qu9ro
	4Z2P1FI0JwDNcQ3VBI9j1Keras0aw7EVgXpnApcd8HrDXr5ZlZQAtVplB3Tg2DQlCQfDrwv/ZOI
	DSL4+wIxxRoFqHIdak8deUhDb3YZoVIX6TKB30TBd5O7uAOdfQ6Y6SH6Yy6gbwQhc/tiIwS3xA=
	=
X-Google-Smtp-Source: AGHT+IGznjhbuq6FiPRXXRyMXRoNBeQ0xweGlhYj/GZ0VH8V4UfHIjIuIGav+dLV/s7ivQ9XESHDrQ==
X-Received: by 2002:ac2:4c4c:0:b0:54b:1039:fe61 with SMTP id 2adb3069b0e04-54e8cbd8e04mr996674e87.33.1745591773363;
        Fri, 25 Apr 2025 07:36:13 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb2627asm629687e87.16.2025.04.25.07.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 07:36:13 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso22928491fa.3;
        Fri, 25 Apr 2025 07:36:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIIbn/1GrJvHJJ9w5tFkZbOFBxXNDWifRdLIAx0hv5Qt0TADzQm+x8z38f3ZO10/ZX9FdU+QMTyv/qF963@vger.kernel.org, AJvYcCVpwIsxXzAsNzAPP500ijLitFUELC9+kep5rRadb8j30t+dk3+Y8plGeNa8ObtPIRokb1gUZajh@vger.kernel.org, AJvYcCW10YhZIwiy0Lsoz/eS2TAYXeeekq2Uc1G71FPrqlZCmF0L1JwVVx6nfssHz2KIitGrXOmQ3+tInu7r@vger.kernel.org
X-Received: by 2002:a2e:bc22:0:b0:30b:9813:b002 with SMTP id
 38308e7fff4ca-31907611d07mr9058331fa.30.1745591772086; Fri, 25 Apr 2025
 07:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
 <20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org> <CAGb2v66a4ERAf_YhPkMWJjm26SsfjO3ze_Zp=QqkXNDLaLnBRg@mail.gmail.com>
 <20250425104128.14f953f3@donnerap.manchester.arm.com>
In-Reply-To: <20250425104128.14f953f3@donnerap.manchester.arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 25 Apr 2025 22:35:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v65QUrCjgHXWAb72Sdppqg1AUxXyD_ZcXShtkRSHCQBbOg@mail.gmail.com>
X-Gm-Features: ATxdqUGytr4HbfY93aZiokaET82aJ2vi5Nhe3vDvbhoSCAK-s8uP_doJV3CtnsQ
Message-ID: <CAGb2v65QUrCjgHXWAb72Sdppqg1AUxXyD_ZcXShtkRSHCQBbOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Corentin Labbe <clabbe.montjoie@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 5:41=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Fri, 25 Apr 2025 13:26:25 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi Chen-Yu,
>
> > On Thu, Apr 24, 2025 at 6:09=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wro=
te:
> > >
> > > Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
> > > including the A527/T527 chips. MAC0 is compatible to the A64 chip whi=
ch
> > > requires an external PHY. This patch only add RGMII pins for now.
> > >
> > > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 40 ++++++++++++++++=
++++++++++
> > >  1 file changed, 40 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/ar=
m64/boot/dts/allwinner/sun55i-a523.dtsi
> > > index ee485899ba0af69f32727a53de20051a2e31be1d..c9a9b9dd479af05ba22fe=
9d783e32f6d61a74ef7 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > > @@ -126,6 +126,15 @@ pio: pinctrl@2000000 {
> > >                         interrupt-controller;
> > >                         #interrupt-cells =3D <3>;
> > >
> > > +                       rgmii0_pins: rgmii0-pins {
> > > +                               pins =3D "PH0", "PH1", "PH2", "PH3", =
"PH4",
> > > +                                      "PH5", "PH6", "PH7", "PH9", "P=
H10",
> > > +                                      "PH14", "PH15", "PH16", "PH17"=
, "PH18";
> > > +                               allwinner,pinmux =3D <5>;
> > > +                               function =3D "emac0";
> > > +                               drive-strength =3D <40>;
> >
> > We should probably add
> >
> >                                   bias-disable;
> >
> > to explicitly turn off pull-up and pull-down.
>
> Should we? I don't see this anywhere else for sunxi, probably because it =
is
> the (reset) default (0b00).
> I wonder if we have a hidden assumption about this? As in: if no bias is
> specified, we assume bias-disable? Then we should maybe enforce this is i=
n
> the driver?

There isn't any assumption, as in we were fine with either the reset
default or whatever the bootloader left it in. However in projects at
work I learned that it's better to have explicit settings despite
working defaults.


ChenYu

