Return-Path: <netdev+bounces-41930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE487CC419
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992731C209EE
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B342C0E;
	Tue, 17 Oct 2023 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F042BFC
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 13:12:38 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87489F2;
	Tue, 17 Oct 2023 06:12:37 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7af52ee31so68582247b3.2;
        Tue, 17 Oct 2023 06:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548356; x=1698153156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrjVOTU4vVWhg8rZEFBUd1El+uZlCjcijcwvkBEbBus=;
        b=TIrkqUnK8yYKZR/UmwjqPZikb7F9uOSLZD2wPW8LcSsAjooa4Jfx29qPc6/qmPWfUS
         28v5aliExFI+ZtzO6sYhroJG/kjAnayBsPm2oZ22ccq+KuLrCOe6S/hY3w1xdPl9eCEs
         eK8HRkCTnbP4PAM51NP7/PqUVAD7dNTwGHSPY7/erDfbx2oReMmMbdgnA0q0P+Tm5m81
         Va48lHj/8getzuCiPg5TKkbYFeHx5eRFuKnRw9x58UhFi7sF/ts8igWTRPQaWrvQrd/N
         ziiwrWjpeLOyj92TfPsOsOQYpD62WySwm73AraYoaH/t075JSxnD5xDyjkxdEEOErm6Q
         wCKw==
X-Gm-Message-State: AOJu0YwTiZZuxaWwymu35fRrW+v04LtHLMpy1WiCnP6qnL7HM36krLcu
	jenyUnzqvS1uozOywM9qtbxWhkbXw2+cOg==
X-Google-Smtp-Source: AGHT+IHdnPW7ENbcBKHUSBrHHdvh+dAtiOkatYLJfZGVRL3NyUQlvp/ZOTePuE2VjQNVpCA12YtmdQ==
X-Received: by 2002:a81:8441:0:b0:5a8:1aa2:1ac1 with SMTP id u62-20020a818441000000b005a81aa21ac1mr2316544ywf.12.1697548356481;
        Tue, 17 Oct 2023 06:12:36 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id m190-20020a0dcac7000000b0059c2e3b7d88sm600863ywd.12.2023.10.17.06.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 06:12:35 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a7c08b7744so68409737b3.3;
        Tue, 17 Oct 2023 06:12:35 -0700 (PDT)
X-Received: by 2002:a0d:cb10:0:b0:5a7:afcc:80fe with SMTP id
 n16-20020a0dcb10000000b005a7afcc80femr2307771ywd.3.1697548354803; Tue, 17 Oct
 2023 06:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-5-hch@lst.de>
 <20231016-pantyhose-tall-7565b6b20fb9@wendy> <20231016131745.GB26484@lst.de>
 <CAMuHMdXVZz=YWMAgzUzme-U3qxYeLdi66xw2CGubpesGy+ZjRw@mail.gmail.com> <20231017124608.GA4386@lst.de>
In-Reply-To: <20231017124608.GA4386@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Oct 2023 15:12:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVavDc4g3ALqxFRn45ySCJ16F-Ay72=P3fxXipk0uXFiQ@mail.gmail.com>
Message-ID: <CAMuHMdVavDc4g3ALqxFRn45ySCJ16F-Ay72=P3fxXipk0uXFiQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] soc: renesas: select RISCV_DMA_NONCOHERENT from ARCH_R9A07G043
To: Christoph Hellwig <hch@lst.de>
Cc: Conor Dooley <conor.dooley@microchip.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>, arm-soc <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Christoph,

On Tue, Oct 17, 2023 at 2:46=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> On Tue, Oct 17, 2023 at 12:44:41PM +0200, Geert Uytterhoeven wrote:
> > On Mon, Oct 16, 2023 at 3:17=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> > > On Mon, Oct 16, 2023 at 01:52:57PM +0100, Conor Dooley wrote:
> > > > > +   select RISCV_DMA_NONCOHERENT
> > > > >     select ERRATA_ANDES if RISCV_SBI
> > > > >     select ERRATA_ANDES_CMO if ERRATA_ANDES
> > > >
> > > > Since this Kconfig menu has changed a bit in linux-next, the select=
s
> > > > are unconditional here, and ERRATA_ANDES_CMO will in turn select
> > > > RISCV_DMA_NONCOHERENT.
> > >
> > > Oh, looks like another patch landed there in linux-next.  I had
> > > waited for the previous one go go upstream in -rc6.  Not sure
> > > how to best handle this conflict.
> >
> > I think the easiest is to ask soc to apply this series?
>
> I don't think pulling all the DMA bits into a random other tree
> would be a good idea.   I can hand off the first few bits, but I'd
> need a stable branch to pull in after that.  Which of the half a dozen
> soc trees we have in linux-next is this anyway?

The one and only https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.gi=
t/

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

