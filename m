Return-Path: <netdev+bounces-41192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CC77CA3AA
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1373CB20C8F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1622C1BDCC;
	Mon, 16 Oct 2023 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E21A5AE
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:12:25 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E1AD
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:12:24 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a82c2eb50cso31582967b3.2
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697447543; x=1698052343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc70JsqUxydN6ziam4wYfEF4cooz3zSobnEoW7SHk6M=;
        b=H+wujAdrbDSUxw5XtmEsJuQDQc7oY3ZMBQsTCfgLSwgcnIpXDlNu4INLXQOwbXigIW
         duqNYnsLGOUEpH08Rp6ASv4C5F/4jNnBxcH+SPMK8YVuSfmU8wkq4SD8qHlFxC2DXbXw
         Q0Um7lJVSTq/GFdbZkqGs3tRFCgioj0AzPw1fkG3sBuqsDr0QqN8jz6Rks/28I1yNy8n
         3Y7hRr3+oEKwGA2kICaLp48LAK8/vf9OgNlxSki8Wi6WwO9MAErC2lWUgPrz+ITrIobm
         58Aou+onwAZPuWgR7ug9Fw1ky/na4BXKlWcB49vJbvokPw6xwcqwSRptYnEPLR3hWR1/
         uYqA==
X-Gm-Message-State: AOJu0YyGbK6wPPHq9Jx+y/Dsvtb6p6cDUiZr7f/1aIXAooRLAK8tfvjW
	F0AAxMiZ3fE/5ioM61wQFwUvgVqe82b3Zw==
X-Google-Smtp-Source: AGHT+IFZ36bpTF0lfmoUknXHJxGC+ln9xX2JD5Ad98qBAs3b/nZSi0DprvBP63FlTaqAxGxE2b5tZw==
X-Received: by 2002:a0d:cb04:0:b0:5a7:ba17:7109 with SMTP id n4-20020a0dcb04000000b005a7ba177109mr18460002ywd.1.1697447543318;
        Mon, 16 Oct 2023 02:12:23 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id h128-20020a0dde86000000b005925c896bc3sm2084461ywe.53.2023.10.16.02.12.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 02:12:23 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7af45084eso54640017b3.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:12:22 -0700 (PDT)
X-Received: by 2002:a0d:d5c1:0:b0:5a8:1ffe:eb4e with SMTP id
 x184-20020a0dd5c1000000b005a81ffeeb4emr9258455ywd.34.1697447542485; Mon, 16
 Oct 2023 02:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-6-hch@lst.de>
 <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com> <20231009125843.GA7272@lst.de> <eedf951d-901c-40d8-91f2-0f13d33b7d4e@linux-m68k.org>
In-Reply-To: <eedf951d-901c-40d8-91f2-0f13d33b7d4e@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Oct 2023 11:12:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVis0F02J1D7C2=MgShswt+2-4vCV076Mb3q4weagUY1A@mail.gmail.com>
Message-ID: <CAMuHMdVis0F02J1D7C2=MgShswt+2-4vCV076Mb3q4weagUY1A@mail.gmail.com>
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Greg,

On Tue, Oct 10, 2023 at 4:45=E2=80=AFPM Greg Ungerer <gerg@linux-m68k.org> =
wrote:
> On 9/10/23 22:58, Christoph Hellwig wrote:
> > On Mon, Oct 09, 2023 at 11:29:12AM +0100, Robin Murphy wrote:
> >> It looks a bit odd that this ends up applying to all of Coldfire, whil=
e the
> >> associated cache flush only applies to the M532x platform, which impli=
es
> >> that we'd now be relying on the non-coherent allocation actually being
> >> coherent on other Coldfire platforms.
> >>
> >> Would it work to do something like this to make sure dma-direct does t=
he
> >> right thing on such platforms (which presumably don't have caches?), a=
nd
> >> then reduce the scope of this FEC hack accordingly, to clean things up=
 even
> >> better?
> >
> > Probably.  Actually Greg comment something along the lines last
> > time, and mentioned something about just instruction vs instruction
> > and data cache.
>
> I just elaborated on that point a little in response to Robin's email.
>
> >>
> >> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> >> index b826e9c677b2..1851fa3fe077 100644
> >> --- a/arch/m68k/Kconfig.cpu
> >> +++ b/arch/m68k/Kconfig.cpu
> >> @@ -27,6 +27,7 @@ config COLDFIRE
> >>      select CPU_HAS_NO_BITFIELDS
> >>      select CPU_HAS_NO_CAS
> >>      select CPU_HAS_NO_MULDIV64
> >> +    select DMA_DEFAULT_COHERENT if !MMU && !M523x
> >
> > Although it would probably make more sense to simply not select
> > CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE and
> > CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU for these platforms and not
> > build the non-coherent code at all.  This should also include
> > all coldfire platforms with mmu (M54xx/M548x/M5441x).  Then
> > again for many of the coldfire platforms the Kconfig allows
> > to select CACHE_WRITETHRU/CACHE_COPYBACK which looks related.
> >
> > Greg, any chance you could help out with the caching modes on
> > coldfire and legacy m68knommu?
>
> Sure, yep. I am not aware that the legacy 68000 or 68328 had any caches
> at all.

68000 (and derivatives like 68*328) does not have any cache.
68360 (which is no longer supported by Linux) is based on CPU32, and
does not seem to have any caches, although the documentation does
mention the use of "external cache memories".

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

