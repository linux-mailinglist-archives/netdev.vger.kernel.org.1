Return-Path: <netdev+bounces-39008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD57BD721
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 11:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE111C2093D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAFE156D3;
	Mon,  9 Oct 2023 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AD8F57
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 09:35:12 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3976ED;
	Mon,  9 Oct 2023 02:35:10 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59f7f46b326so51486207b3.0;
        Mon, 09 Oct 2023 02:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696844110; x=1697448910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xr8BhwyyAKTpcM9iiIvbHN9gtfLY84lyd2lf3mY1OqM=;
        b=Mbinxml7zyVjkCQuqBa/QE+pAhUXFpbxxcJXopuqB910G681RADeEYDETh6Z4cQxds
         1uiI7sCd4XUll5cW1AeFCaXe0FcA6vx2Jqr3CCQqNo+m3bTUGOJP5oOVwimlOqMsRqa2
         VFuihfbh+SqVYL8Rbs3oFwY78N4+HQwx9v4sahGMIfmrG+IZN6RqATIYbzNKj1ggsnor
         f4A/YJiEH/HkZNPdzkQRMmythQ3FJsAtRscaBWc+I25p1yYdEGncXbbmh8hjxwhPOit2
         jPWxnfKCFd1U8bl7CXm+snLTwj+vZjlIh2ynf0rdsRw72+BhCH5i0z0QC4hO+g5nUZvd
         sP2w==
X-Gm-Message-State: AOJu0YylUBCygfzAnjE1D9emudKZdLW52NLt1RK0FIoXJUPksUEb4M8I
	ICW1OUfhC2U6B+GebC8ILV28CEXUGVqcwg==
X-Google-Smtp-Source: AGHT+IHFttZ4hFjBnwgCdzGbKR9zUR/6BFNdhwQakJmPN5exLeCPEPhE68PnDYUyq5q9+JhDW8iUbA==
X-Received: by 2002:a81:5244:0:b0:589:f4ec:4d51 with SMTP id g65-20020a815244000000b00589f4ec4d51mr15081885ywb.3.1696844109871;
        Mon, 09 Oct 2023 02:35:09 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id d184-20020a0ddbc1000000b00586108dd8f5sm3532544ywe.18.2023.10.09.02.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:35:09 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f6e6b7600so51131587b3.3;
        Mon, 09 Oct 2023 02:35:08 -0700 (PDT)
X-Received: by 2002:a81:8246:0:b0:58d:f1fe:5954 with SMTP id
 s67-20020a818246000000b0058df1fe5954mr15164085ywf.32.1696844108593; Mon, 09
 Oct 2023 02:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-2-hch@lst.de>
 <CAMuHMdWiYDQ5J7R7hPaVAYgXqJvpjdksoF6X-zHrJ_80Ly4XfQ@mail.gmail.com> <20231009091625.GB22463@lst.de>
In-Reply-To: <20231009091625.GB22463@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Oct 2023 11:34:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZNewD-QC8J7MWSBP197Vc169meOjjK6=b7M11kVjUzg@mail.gmail.com>
Message-ID: <CAMuHMdUZNewD-QC8J7MWSBP197Vc169meOjjK6=b7M11kVjUzg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dma-direct: add depdenencies to CONFIG_DMA_GLOBAL_POOL
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>, linux-riscv <linux-riscv@lists.infradead.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Christoph,

On Mon, Oct 9, 2023 at 11:16=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> On Mon, Oct 09, 2023 at 10:43:57AM +0200, Geert Uytterhoeven wrote:
> > >  config DMA_DIRECT_REMAP
> >
> > riscv defconfig + CONFIG_NONPORTABLE=3Dy + CONFIG_ARCH_R9A07G043=3Dy:
> >
> > WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
> >   Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=3Dn] && !DMA_DIRECT_REMA=
P [=3Dy]
> >   Selected by [y]:
> >   - ARCH_R9A07G043 [=3Dy] && SOC_RENESAS [=3Dy] && RISCV [=3Dy] && NONP=
ORTABLE [=3Dy]
>
> And that's exactly what this patch is supposed to show.  RISCV must not
> select DMA_DIRECT_REMAP at the same time as DMA_GLOBAL_POOL.  I though
> the fix for that just went upstream?

The fix you are referring too is probably commit c1ec4b450ab729e3
("soc: renesas: Make ARCH_R9A07G043 (riscv version) depend
on NONPORTABLE") in next-20231006 and later.  It is not yet upstream.

Still, it merely makes ARCH_R9A07G043 (which selects DMA_GLOBAL_POOL)
depend on ARCH_R9A07G043.
RISCV_DMA_NONCOHERENT still selects DMA_DIRECT_REMAP, so both can end
up being enabled.

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

