Return-Path: <netdev+bounces-20746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A14BE760E0A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 11:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14331C20D4E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF87314287;
	Tue, 25 Jul 2023 09:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356114281
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:11:22 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553710B;
	Tue, 25 Jul 2023 02:11:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b962535808so74469311fa.0;
        Tue, 25 Jul 2023 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690276279; x=1690881079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U3aGdRhrvkuTr58GqZ2ywXuQf8rEnTYi74G4TIbego=;
        b=nOCzujai+yb0ylPhWsHDvcTjmXoQkZfLP2EWkGRfJmuXdSvQfgH+ax2Sj5yqfUxaQG
         qbaIi/NO5G1ciNGIozhTufMoXJ+4Za92bLQhS1tFEq49GaX9JlwaB+j5/sBjAFsIkIIo
         IEJLxLVWQGSiDwFVjrvOxwkxohtz/LGc+TKxJmIclNJypUs6vDRXMHvI+g5FpLkIQghw
         DpguOUftBj9T9IFT2FEQ3jKb95TysDamYg4l1YpkmQ8GtwMhi3Oyd27ztkd85ieFWRDC
         KNmWIzCeTsHsU34m7QkUMsU4+Pz/RN/6hRSMPPjsDjWPNS9x+DjXBui5oTvdIw5H03W/
         /9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690276279; x=1690881079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U3aGdRhrvkuTr58GqZ2ywXuQf8rEnTYi74G4TIbego=;
        b=hLJ36qct3UyzUrYFJe94/llutpOmhNzWgdNfHsUlZo9zirD7wwPh+apH9sw3/PMEsh
         AQqHnR1xQeqnPqvz5jBGORdRv2Dh+VAPEykL/IvRkpyeVXVhmfdVzLTkLxFZauDARvZG
         KSRHsyOPn+lReqMnBsNoY7trRqIYRpXgzVtctoX4T2ttu2YAHQ5ywPqV77DgZ60gZQob
         Lr1mIp9FW7zGRTCJ58c9etOuUUkyECcdAw03JvEl1HBsE8VwzxHWsvFJr2pXqyH1N8dF
         9M2AgnLnAvNvFXcEsZ5MpuwJJ+4/wr9wNfb7fpvO3bFw6Wubb0FTvcjtLrQrDw/BsxG1
         IIEg==
X-Gm-Message-State: ABy/qLZraGWXSPRJcN+1KE7nLoXCqzbhOFjwh5c6DBi59CJ+PFYvHnN0
	6ud/wT25sOLSDdvPj+ziuPahFSilwvlKINV0ric=
X-Google-Smtp-Source: APBJJlHMdlSNdNyjXJHuU/0ITcZYdkv60mYKe/AcHSk40gGM8e8N6hCUwQiB94P3MKjHtDYNfzeGTOrOaeN6WGv5vNw=
X-Received: by 2002:a2e:9587:0:b0:2b6:e2aa:8fc2 with SMTP id
 w7-20020a2e9587000000b002b6e2aa8fc2mr7658338ljh.46.1690276278578; Tue, 25 Jul
 2023 02:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724090044.2668064-1-ilia.lin@kernel.org> <20230724181105.GD11388@unreal>
 <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com> <20230725051917.GH11388@unreal>
In-Reply-To: <20230725051917.GH11388@unreal>
From: Ilia Lin <ilia.lin@gmail.com>
Date: Tue, 25 Jul 2023 12:11:06 +0300
Message-ID: <CA+5LGR2oDFEjJL5j715Pi9AtmJ7LXM82a63+rcyYow-E5trXtg@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
To: Leon Romanovsky <leon@kernel.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 8:19=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Jul 25, 2023 at 07:41:49AM +0300, Ilia Lin wrote:
> > Hi Leon,
>
> You was already asked do not top-post.
> https://lore.kernel.org/netdev/20230718105446.GD8808@unreal/
> Please stop it.
>
> >
> > This is exactly like I described:
> > * xfrm.h is included from the net/core/sock.c unconditionally.
> > * If CONFIG_XFRM_OFFLOAD is set, then the xfrm_dst_offload_ok() is
> > being compiled.
> > * If CONFIG_XFRM is not set, the struct dst_entry doesn't have the xfrm=
 member.
> > * xfrm_dst_offload_ok() tries to access the dst->xfrm and that fails to=
 compile.
>
> I asked two questions. First one was "How did you set XFRM_OFFLOAD
> without XFRM?".
>
> Thanks
>
In driver Kconfig: "select XFRM_OFFLOAD"
>
> >
> >
> > Thanks,
> > Ilia Lin
> >
> > On Mon, Jul 24, 2023 at 9:11=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Mon, Jul 24, 2023 at 12:00:44PM +0300, Ilia Lin wrote:
> > > > If XFRM_OFFLOAD is configured, but XFRM is not
> > >
> > > How did you do it?
> > >
> > > >, it will cause
> > > > compilation error on include xfrm.h:
> > > >  C 05:56:39 In file included from /src/linux/kernel_platform/msm-ke=
rnel/net/core/sock.c:127:
> > > >  C 05:56:39 /src/linux/kernel_platform/msm-kernel/include/net/xfrm.=
h:1932:30: error: no member named 'xfrm' in 'struct dst_entry'
> > > >  C 05:56:39         struct xfrm_state *x =3D dst->xfrm;
> > > >  C 05:56:39                                ~~~  ^
> > > >
> > > > Making the XFRM_OFFLOAD select the XFRM.
> > > >
> > > > Fixes: 48e01e001da31 ("ixgbe/ixgbevf: fix XFRM_ALGO dependency")
> > > > Reported-by: Ilia Lin <ilia.lin@kernel.org>
> > > > Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> > > > ---
> > > >  net/xfrm/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> > > > index 3adf31a83a79a..3fc2c1bcb5bbe 100644
> > > > --- a/net/xfrm/Kconfig
> > > > +++ b/net/xfrm/Kconfig
> > > > @@ -10,6 +10,7 @@ config XFRM
> > > >
> > > >  config XFRM_OFFLOAD
> > > >       bool
> > > > +     select XFRM
> > >
> > > struct dst_entry depends on CONFIG_XFRM and not on CONFIG_XFRM_OFFLOA=
D,
> > > so it is unclear to me why do you need to add new "select XFRM" line.
> > >
> > >    26 struct dst_entry {
> > >    27         struct net_device       *dev;
> > >    28         struct  dst_ops         *ops;
> > >    29         unsigned long           _metrics;
> > >    30         unsigned long           expires;
> > >    31 #ifdef CONFIG_XFRM
> > >    32         struct xfrm_state       *xfrm;
> > >    33 #else
> > >    34         void                    *__pad1;
> > >    35 #endif
> > >    36         int
> > >
> > > Thanks

