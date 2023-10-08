Return-Path: <netdev+bounces-38875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CAA7BCCF8
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 09:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AB72817A1
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 07:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0F38486;
	Sun,  8 Oct 2023 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="QJvTAWmR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161163205
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 07:11:50 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D918B6
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 00:11:49 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a22eaafd72so43680417b3.3
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 00:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696749108; x=1697353908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SEOXfJA7vzTv4ptNNIVK7Ccy8v0ranMjIXDfq2q8cM=;
        b=QJvTAWmRMAL84cGrwiVkNfCPYA3D/XTSgEaBx5OE5H4mp55TSrpgYSVURwE/7I9mMX
         07/u7cIowFhW0U6t4CXf55gL3Npq2JR7Re3sXBjD0cya4diYvwLrzPE88C6TEmFiKltf
         wHQMeIBHPul0B1KCDwSl3cst2rq/J1MforB0Ei6I+j+ynzIO/cQeVdcWGmISX/wFuqex
         uTt28TMD+zP/sDcuxjFhiQa4gVK5m/FJN8uhdjxbSf3xdjiE4QeM0npdsmVrrjsdA+aa
         aBfSmeo0h21NVwcnHC6ghSEMnPhmoqnxoyJcDb1cKDhAvhSkj50kODnxvx/VQGs8MhKx
         O1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696749108; x=1697353908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SEOXfJA7vzTv4ptNNIVK7Ccy8v0ranMjIXDfq2q8cM=;
        b=Az0Qt9ATium3BWAUmIQjvx59OyvTU4+m6Tbh4HH47Q30MVvdjrQH46oWkUiGKZkNrT
         tRor0pIr2r+Qz4uXqUxEwfCIrhRSb8Rvqx44veK3SwInsGBz2pemr+JXEWBhP31r6ELq
         NQ3BlASKFajqgXQFBug7aI13wNpWcRv3HFyBkeulnVqB4f7tj17p5xzrb/KfzvBhfH4l
         DQ4YliTllugIvzt2BPNNcVHbFcoCRk7v0XjdnoloTF6ZRbIUYK+qSBYPUxD2iBvgFepm
         aDNK1pCSCuXhz0p3xLacj6nVyRU6XuThQil1MYlU+eTuFnjzJbALzsRpa4PwjQUlLUx3
         TvKA==
X-Gm-Message-State: AOJu0Yzml4l0MHHFgEHvawBsoG6DlaW885G0y9R/VIKlWrKzoz1CAJ/G
	bL4FqxI3yNMduO3CUv6EcIoG/mnf8tUa+q1Eo/NpFg==
X-Google-Smtp-Source: AGHT+IHiLam8NYeG4w8zFjLq9SzVce7FiePeqlro3AOd9i6WDLpmhFete+ozBjcwvjpfp2PkYO9N82WSAO3uZ4ueyfY=
X-Received: by 2002:a25:374b:0:b0:d0a:da40:638e with SMTP id
 e72-20020a25374b000000b00d0ada40638emr10999315yba.12.1696749108528; Sun, 08
 Oct 2023 00:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-4-fujita.tomonori@gmail.com> <CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A37FjwUzZO9Fn-iPaoA@mail.gmail.com>
 <20231007.210734.448113675800173824.fujita.tomonori@gmail.com>
In-Reply-To: <20231007.210734.448113675800173824.fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 8 Oct 2023 03:11:36 -0400
Message-ID: <CALNs47sxuGVXBwhXZa5NgHQ8F0MH2OoUzsgthAURE+OuTtJ1wQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 8:10=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
> >> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
> >> +        dev.genphy_update_link()?;
> >> +        if !dev.get_link() {
> >> +            return Ok(0);
> >> +        }
> >
> > Looking at this usage, I think `get_link()` should be renamed to just
> > `link()`. `get_link` makes me think that it is performing an action
> > like calling `genphy_update_link`, just `link()` sounds more like a
> > static accessor.
>
> Andrew suggested to rename link() to get_link(), I think.
>
> Then we discussed again last week:
>
> https://lore.kernel.org/rust-for-linux/20231004.084644.50784533959398755.=
fujita.tomonori@gmail.com/

Thanks for the link, in that case LGTM

>
> >> +        if ret as u32 & uapi::BMCR_SPEED100 !=3D 0 {
> >> +            dev.set_speed(100);
> >> +        } else {
> >> +            dev.set_speed(10);
> >> +        }
> >
> > Speed should probably actually be an enum since it has defined values.
> > Something like
> >
> >     #[non_exhaustive]
> >     enum Speed {
> >         Speed10M,
> >         Speed100M,
> >         Speed1000M,
> >         // 2.5G, 5G, 10G, 25G?
> >     }
> >
> >     impl Speed {
> >         fn as_mb(self) -> u32;
> >     }
> >
>
> ethtool.h says:
>
> /* The forced speed, in units of 1Mb. All values 0 to INT_MAX are legal.
>  * Update drivers/net/phy/phy.c:phy_speed_to_str() and
>  * drivers/net/bonding/bond_3ad.c:__get_link_speed() when adding new valu=
es.
>  */
>
> I don't know there are drivers that set such values.

Andrew replied to this too and an enum wouldn't work. Maybe good to
add uapi/linux/ethtool.h to the bindings and use the SPEED_X defined
there?

> >> +        let duplex =3D if ret as u32 & uapi::BMCR_FULLDPLX !=3D 0 {
> >> +            phy::DuplexMode::Full
> >> +        } else {
> >> +            phy::DuplexMode::Half
> >> +        };
> >
> > BMCR_x and MII_x are generated as `u32` but that's just a bindgen
> > thing. It seems we should reexport them as the correct types so users
> > don't need to cast all over:
> >
> >     pub MII_BMCR: u8 =3D bindings::MII_BMCR as u8;
> >     pub BMCR_RESV: u16 =3D bindings::BMCR_RESV as u16; ...
> >     // (I'd just make a macro for this)
> >
> > But I'm not sure how to handle that since the uapi crate exposes its
> > bindings directly. We're probably going to run into this issue with
> > other uapi items at some point, any thoughts Miguel?
>
> reexporting all the BMCR_ values by hand doesn't sound fun. Can we
> automaticall generate such?

Definitely not by hand, I don't think bindgen allows finer control
over what types are created from `#define` yet. I am not sure what our
policy is on build scripts but the below would work:

    # repeat this with a different prefix (BMCR) and type (u16) as needed
    perl -ne 'print if
s/^#define\s+(BMCR\w+)\s+([0-9xX]+)\s+(?:\/\*(.*)\*\/)?/\/\/\/ \3\npub
const \1: u16 =3D \2;/' include/uapi/linux/mii.h > somefile.rs

That creates outputs

    ///  MSB of Speed (1000)
    pub const BMCR_SPEED1000: u16 =3D 0x0040;
    ///  Collision test
    pub const BMCR_CTST: u16 =3D 0x0080;
    ///  Full duplex
    pub const BMCR_FULLDPLX: u16 =3D 0x0100;

Miguel, any suggestions here?

