Return-Path: <netdev+bounces-17272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37519750FB3
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8681C2110A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF4E20F95;
	Wed, 12 Jul 2023 17:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049E200DF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:34:19 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398EA1991
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 10:34:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso10898454e87.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689183255; x=1691775255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THupXVrcQgstmKZ7g3sWCpKEqGRDMCR0S1cuPxvrmm0=;
        b=CEkTls9NpLa7QXntC+qxjwisHZSsRQgQwgxURUxzFeBcv9LvOyTjJworuQN7WatsWZ
         2K8NdX0u0LbxZ2lR1yUo79lVYV7Up0UpO2i2X/Rw8KhfiAEoAlYYFuDPvs0u48lBYlby
         Hr1UZ63ywo5FibwhwcS7qoubUmXWRJA5tgVIa0eFHOuV/v7sNq3UfNSWZ7LHxLcnsYO7
         4av0aEY16DDYWnZRJoM4szLJmn5o+qjXQ6Ny2xJEot+VxVVdx7Lp4Q3D7xvuoXEsOoCE
         +AVENbJNR+oens7/f65Ii+msEkHaRKqN92l7wvCOx7qSEv3ZeIceedllAlVUezPkND2D
         psnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183255; x=1691775255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THupXVrcQgstmKZ7g3sWCpKEqGRDMCR0S1cuPxvrmm0=;
        b=XnXaHPHY3wqhWH3fzOQHKBBEGoncCvpPsYh21vglWjEJrITJZ3TvVs5T1w5IsfU5FR
         Wcz119IUuM+J1MZr21qHJZw2G+3qt2KOA3Z4rLMHQOP4e9E4PboDGQarLYmr7uBw//Ys
         3o4WoY+ErPzpwQeLEtHaFn5S0kSm5Kh5qqPmvkGHmePNVpZawf8mRgapfELygGytWLtK
         nkkXlZpRyW4AH0yKVwhwMFTheClQq/bHoA5McE/ELm8S5L7fbIP0XryHxbUUOgSNHpT5
         u3HQ3gGYu978V+Bs3cULv0jIqesq/nPUBpoDXYGK1fpjI6LS6xUFTFSBrqLY0yGXw/oQ
         VieA==
X-Gm-Message-State: ABy/qLa/NNi0omZPG+wuoS99X6SUxXLB+7QUu1Fpjx14eHMuhHgF55Yi
	Jv9Ddi1mjxxGGrbshhveo25P1R+h3BEmJkXl59XxQw==
X-Google-Smtp-Source: APBJJlHvVk6KQIaeMx+Y8djfpAYOUtMArgWEG07w/d6ONkJCrU9E2j1ZpgldQFTViBw1jnRhyDheAmQQeSboRoBB5SI=
X-Received: by 2002:a05:6512:3287:b0:4fb:89f2:278e with SMTP id
 p7-20020a056512328700b004fb89f2278emr17145159lfe.68.1689183255338; Wed, 12
 Jul 2023 10:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706081554.1616839-1-alex@shruggie.ro> <20230706081554.1616839-2-alex@shruggie.ro>
 <9c37e2d5-a430-4a0f-b6b9-5de0dc14033f@lunn.ch>
In-Reply-To: <9c37e2d5-a430-4a0f-b6b9-5de0dc14033f@lunn.ch>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Wed, 12 Jul 2023 20:34:03 +0300
Message-ID: <CAH3L5Qp_887Jg4QN8qo1QQWJGhyLmvafKKTBRF-Yu3nkLE0G+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 8, 2023 at 9:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jul 06, 2023 at 11:15:54AM +0300, Alexandru Ardelean wrote:
> > For VSC8351 and similar PHYs, a new property was added to generate a cl=
ock
> > signal on the CLKOUT pin.
> > This change documents the change in the device-tree bindings doc.
> >
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> > ---
> >  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt=
 b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > index 0a3647fe331b..133bdd644618 100644
> > --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > @@ -31,6 +31,10 @@ Optional properties:
> >                         VSC8531_LINK_100_ACTIVITY (2),
> >                         VSC8531_LINK_ACTIVITY (0) and
> >                         VSC8531_DUPLEX_COLLISION (8).
> > +- vsc8531,clkout-freq-mhz : For VSC8531 and similar PHYs, this will ou=
tput
> > +                       a clock signal on the CLKOUT pin of the chip.
> > +                       The supported values are 25, 50 & 125 Mhz.
> > +                       Default value is no clock signal on the CLKOUT =
pin.
>
> It is possible this could cause regressions. The bootloader could
> turned the clock on, and then Linux leaves it alone. Now, it will get
> turned off unless a DT property is added.
>
> I prefer to explicitly have the property, so there is no dependency on
> the bootloader, so lets leave it like this. But if we do get
> regressions reported, this might need to change.

Well, we could also need add a "mscc,clkout-freq-mhz =3D <0>" handling
where the CLKOUT pin gets disabled explicitly (if needed, after the
bootloade), for some weird corner cases.
Though, to-be-honest, I can't think of any (remotely) reasonable ones.

It would definitely be simple to just make sure that Linux does not do
any changes if this property isn't present.

If you're on board about having this as-is, I will keep it; and spin a
V2 just with 'vsc8531,clkout-freq-mhz ' -> 'mscc,clkout-freq-mhz' as
Rob requested.

Thanks
Alex

>
>    Andrew

