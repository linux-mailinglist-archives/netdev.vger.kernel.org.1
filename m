Return-Path: <netdev+bounces-44574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27D57D8B75
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65092282135
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491C03E48E;
	Thu, 26 Oct 2023 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JoVLho0R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570344426
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 22:11:44 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58D0AB
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:11:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5079f9675c6so2233943e87.2
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698358301; x=1698963101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7QyUigwL+AihRwuENBgL/lkTObabmHkjoTqFNGjpDU=;
        b=JoVLho0Ry/Nc3mefIZkDvwTWG8RS8v7YxyhoZ0dOiN+JlESexiFIKGBD8wInQ2syjT
         1EoHhhzQ3ZrM+uECf1iJIiJnHYOU7Sa/R2OrT22M6/HFk37TAiv4oMzt5KPwi1sYc5ze
         96kKe1U2XO/ej3+T7baBKZmwt14e8AtCqimELAOgY2mstJZUr2t33tiuA8sLShWDN5Zn
         GD80rlzyfDK7ii5/lQ3nKU4dSbsej3OQ8ih8G+gtNsrZw6Nx3FN4Jcr7heY6sebYwzfd
         KeXKcB2Rz8cDEQZdvcl8rH2wZnBW+ue0RNJpTuKp5VpC9q2sL19ikPqagAjuLXYUco+S
         TbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698358301; x=1698963101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7QyUigwL+AihRwuENBgL/lkTObabmHkjoTqFNGjpDU=;
        b=hG6/bqDw3KsJrOGrmS1/JYpBb2Vi2anaCvt+bled9xBJdITY8u9exK6jPzu611Y6wV
         vSP+gKQ/8ZJ8H3+40pqFo7lpA3zw03TEk3jz9YBqjETu6cfrjFobQe3Iwh8i+93EyCZI
         LRLzlwAAovQVG9SfAnW/zn7lvQXxNeRuN8+EayilDolAHs3km+Vbhq3Di7+VERJ/u6B7
         DmjHV//i/JhSs8dumk6p6hyfJ1eMMSlzRkuTJhQFUI3bcx4rKssG+e4f9JmDyDQx8JrD
         +L0rUcT9c08ZrXSTK+LUV/mUBFT7NLVszkg5G1oLxqffd06Gi5V3uXN/ss0d5WMqmxCI
         jmng==
X-Gm-Message-State: AOJu0Yz6uB0pti10Wq9BrJP7jdo1CFqIFtQeisvHWLOKtYjH2no9Q5L4
	2CgosVCP1do5WOT7FXr9qF8JgyBfGVHbKMV80inBCA==
X-Google-Smtp-Source: AGHT+IHf/4g0ckl88vh8B7NAaPWRBEPuiUqA7RhSF/OaNkq65RrrqAUENIJx47f8YuoL+1dF/Uae/bzIzQfZl027bkI=
X-Received: by 2002:a19:ac0a:0:b0:4ff:a04c:8a5b with SMTP id
 g10-20020a19ac0a000000b004ffa04c8a5bmr431476lfc.47.1698358300700; Thu, 26 Oct
 2023 15:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-1-0d67cbdd0538@google.com> <20231026220248.blgf7kgt5fkkbg7f@skbuf>
 <CAFhGd8rWOE8zGFCdjM6i8H3TP8q5BFFxMGCk0n-nmLmjHojefg@mail.gmail.com>
In-Reply-To: <CAFhGd8rWOE8zGFCdjM6i8H3TP8q5BFFxMGCk0n-nmLmjHojefg@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 26 Oct 2023 15:11:28 -0700
Message-ID: <CAFhGd8pJkdpF4BYDf_Ym-zsisAVzM06_4ba+_6Uca_2Xerp1Qg@mail.gmail.com>
Subject: Re: [PATCH next v2 1/3] ethtool: Implement ethtool_puts()
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com, 
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 3:09=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> On Thu, Oct 26, 2023 at 3:02=E2=80=AFPM Vladimir Oltean <olteanv@gmail.co=
m> wrote:
> >
> > Hi Justin,
> >
> > On Thu, Oct 26, 2023 at 09:56:07PM +0000, Justin Stitt wrote:
> > > Use strscpy() to implement ethtool_puts().
> > >
> > > Functionally the same as ethtool_sprintf() when it's used with two
> > > arguments or with just "%s" format specifier.
> > >
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > >  include/linux/ethtool.h | 34 +++++++++++++++++++++++-----------
> > >  net/ethtool/ioctl.c     |  7 +++++++
> > >  2 files changed, 30 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> > > index 226a36ed5aa1..7129dd2e227c 100644
> > > --- a/include/linux/ethtool.h
> > > +++ b/include/linux/ethtool.h
> > > @@ -1053,22 +1053,34 @@ static inline int ethtool_mm_frag_size_min_to=
_add(u32 val_min, u32 *val_add,
> > >   */
> > >  extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fm=
t, ...);
> > >
> > > +/**
> > > + * ethtool_puts - Write string to ethtool string data
> > > + * @data: Pointer to start of string to update
> > > + * @str: String to write
> > > + *
> > > + * Write string to data. Update data to point at start of next
> > > + * string.
> > > + *
> > > + * Prefer this function to ethtool_sprintf() when given only
> > > + * two arguments or if @fmt is just "%s".
> > > + */
> > > +extern void ethtool_puts(u8 **data, const char *str);
> > > +
> > >  /* Link mode to forced speed capabilities maps */
> > >  struct ethtool_forced_speed_map {
> > > -     u32             speed;
> > > +     u32 speed;
> > >       __ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
> > >
> > > -     const u32       *cap_arr;
> > > -     u32             arr_size;
> > > +     const u32 *cap_arr;
> > > +     u32 arr_size;
> > >  };
> > >
> > > -#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)                     =
         \
> > > -{                                                                   =
 \
> > > -     .speed          =3D SPEED_##value,                             =
   \
> > > -     .cap_arr        =3D prefix##_##value,                          =
   \
> > > -     .arr_size       =3D ARRAY_SIZE(prefix##_##value),              =
   \
> > > -}
> > > +#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)                     =
 \
> > > +     {                                                            \
> > > +             .speed =3D SPEED_##value, .cap_arr =3D prefix##_##value=
, \
> > > +             .arr_size =3D ARRAY_SIZE(prefix##_##value),            =
\
> > > +     }
> > >
> > > -void
> > > -ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps=
, u32 size);
> > > +void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map =
*maps,
> > > +                                 u32 size);
> > >  #endif /* _LINUX_ETHTOOL_H */
> >
> > Maybe this is due to an incorrect rebase conflict resolution, but you
> > shouldn't have touched any of the ethtool force speed maps.
>
> Ah, I did have a conflict and resolved by simply moving the hunks
> out of each other's way. Trivial resolution.
>
> Should I undo this? I want my patch against next since it's targeting
> some stuff in-flight over there. BUT, I also want ethtool_puts() to be
> directly below ethtool_sprintf() in the source code. What to do?

Oh, I just realized my auto formatter had a field day with that function.
I will rectify this in a new version after waiting 24hrs for comments to
trickle in as well.

>
> >
> > Please wait for at least 24 hours to pass before posting a new version,
> > to allow for more comments to come in.
>
> Ok :)
>
> Thanks
> Justin

Thanks
Justin

