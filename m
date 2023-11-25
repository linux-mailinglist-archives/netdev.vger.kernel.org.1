Return-Path: <netdev+bounces-51079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D767F905D
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 00:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21F01C20A4F
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 23:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA637315A9;
	Sat, 25 Nov 2023 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LclWgNdL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC27B115
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 15:46:15 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5b383b4184fso30453957b3.1
        for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 15:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700955975; x=1701560775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hFIt0HmR86o9B8NpKYxKa6/Sz6hTZOcUx/vMSf/X6U=;
        b=LclWgNdLtUgCrUPOz6lD3ZYZbcpRee6fMR/vU7nM6ALljxSs+nHiAPxhdn0PSNQZ45
         /NzJnENKNul8QwZ4M1RQ7s0pimQ3Lyorza8qzPmfwh4RidoNcR7x+Y80Ej9GAuRwtAGk
         /d1OCBYf7mwpEB/V6QDEefCokgH5kAnZhj7uR3EN6fBiHei/FTXD7ItT9NfbkbpEuoC0
         Vw7trBQZltdFgxdbJhBeHceIL8ZFrdvKP4r3VZYkEuS6dln94oMLpsCAz+mq1iO3YNfr
         aO0nTRHE+eQghND6Cn6/18oymsAEMKzgBRArZ9Fto2kz0mFMF8DoW2mYPEurvAVC5/bg
         Q0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700955975; x=1701560775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hFIt0HmR86o9B8NpKYxKa6/Sz6hTZOcUx/vMSf/X6U=;
        b=uusZW4ctxeGx3sz1E0Z0ACRUXDaU4H9V9216VMuMnKOv9qIgae8BMDickVnBkUretY
         kIDgH0vBiSWdvTkkAZawz2tLu9GlqZYRSj13S0mZffW6GeVc6g1qjVkJJKBAHYC1yNQf
         lmhUqf95AhhCLEwlf1Kba29KsOM1+jGJhXFQrX98TPc4yS52s8nhDi3MMhxxjhQJZL6B
         lrHTjwtrnSM4PGJwghzn4N8BXUh435pvktiG8+tj5xzu45xQhtUB7vFleXGM9lGgfpDK
         UZaDjS1OB89KHSLd+/Vqk8fqSAB3lfVFcAnockBE1RPDmNCN75kMFZf8P5cN4AYlBh0E
         3+KA==
X-Gm-Message-State: AOJu0YwB+i9AWU1JineUev3ACcAQn1RD+ZcT21y4/Ze5OujDrAnpxv0V
	udlWSSLQKQ6Nxea7r8BmbBKaDfNTHdEDtZgFeG15lg==
X-Google-Smtp-Source: AGHT+IG60g3mNV47IlwttcnDH+atQvnMLJ1evmHoV/+jZ4ba2ng+5GbfULZhB+H2t82HBju/xWOk1HvQPjPv5o1XktY=
X-Received: by 2002:a0d:fcc2:0:b0:59f:b0d9:5df2 with SMTP id
 m185-20020a0dfcc2000000b0059fb0d95df2mr8159218ywf.0.1700955974890; Sat, 25
 Nov 2023 15:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123-mv88e6xxx-leds-v1-1-3c379b3d23fb@linaro.org> <c8c821f8-e170-44b3-a3f9-207cf7cb70e2@lunn.ch>
In-Reply-To: <c8c821f8-e170-44b3-a3f9-207cf7cb70e2@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 26 Nov 2023 00:46:03 +0100
Message-ID: <CACRpkdY+T8Rqg_irkLNvAC+o_QfwO2N+eB9X-y24t34_9Rg3ww@mail.gmail.com>
Subject: Re: [PATCH RFC] net: dsa: mv88e6xxx: Support LED control
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 5:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> What i would really like to see happen is that the DSA core handles
> the registration of the LEDs, similar to how phylib does. The DT
> binding should be identical for all DSA devices, so there is no need
> for each driver to do its own parsing.
>
> There are some WIP patches at
>
> https://github.com/lunn/linux.git leds-offload-support-reduced-auto-netde=
v
>
> which implement this. Feel free to make use of them.

Oh it's quite a lot of patches, I really cannot drive that because there ar=
e
so many things about them that I don't understand the thinking behind...
But I like what I see!

While I defined the bits a bit differently, some of it looks similar enough=
.

> > +/* Entries are listed in selector order */
> > +static const struct mv88e6xxx_led_hwconfig mv88e6xxx_led_hwconfigs[] =
=3D {
>
> You need to be careful with naming. These are probably specific to the
> 6352. Different switches probably have different capabilities. So it
> would be good to have the names reflect the switch family they are
> valid for.

OK I'll try to name them like such.

> When we come to add support for other switch families, i wounder how
> tables like this scale. Is there some things which can be shared, if
> we break the table up? I need to check the data sheets.

We will see I guess. It falls back to the whole question of whether
supporting all variants in a single module is even scaling. So far
it does I guess? One day the MV88E6xxx may need to be broken
into submodules.

Yours,
Linus Walleij

