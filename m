Return-Path: <netdev+bounces-38988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93487BD55B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A392B281566
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 08:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404D91C05;
	Mon,  9 Oct 2023 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8617D1
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:39:35 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08BC9F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 01:39:31 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59e77e4f707so51823477b3.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 01:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696840770; x=1697445570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCa60SJYenNTin9ORA6mgu5HPNBKWXiBobv0OFeXlBg=;
        b=u4WK83eu7MWra8cOsdEnL6EpNn4X5bV+t/yNg3sqTcwyWhHLlPIv8h/ejB9dHiaJEL
         ARZU5VfCiDVid2xuej3NkUnqGAqca6nYrtAwggFvpHTcsW56qau9zOLwzbK8q5v80ggM
         kONskClwPcT/ANDahajPuzDqv/xG+clF9yi7Euv53R3KIz2qF5SZ3nj/VlnscFJEPvaP
         6052C81DS4uDfEChx2UpeEjQqQzvrrDBJwGT0vQ2kphowe7FV0xLGLbc9tmEg8uO58Ze
         4aYir5bRBhUqTKupuVEzYtgwwBOfcflfhkY9VozAXJWjmCdHfi9mX93sekZ6bV/D5BQh
         jlzw==
X-Gm-Message-State: AOJu0Yz/Fbhre6zjFEIPhQmk8wTTx7WcN5k40yVLTWYup1p9pu4MNh80
	WyIMFvIkkpw3fAy0r5Q2qTjBPmLVUp7cfw==
X-Google-Smtp-Source: AGHT+IH/3sVVL9wClH2FXxcNUZmScKisC42yZA6rBHo9GprEuATpWF9LKOpcfT08lH76BfBlZ1gE6w==
X-Received: by 2002:a05:690c:2c8a:b0:5a5:756:44f4 with SMTP id ep10-20020a05690c2c8a00b005a5075644f4mr10564325ywb.22.1696840770694;
        Mon, 09 Oct 2023 01:39:30 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id w205-20020a817bd6000000b00565271801b6sm3563819ywc.59.2023.10.09.01.39.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 01:39:30 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a2536adaf3so51601977b3.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 01:39:29 -0700 (PDT)
X-Received: by 2002:a0d:d443:0:b0:5a2:3734:507 with SMTP id
 w64-20020a0dd443000000b005a237340507mr16135074ywd.21.1696840769802; Mon, 09
 Oct 2023 01:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009074121.219686-1-hch@lst.de>
In-Reply-To: <20231009074121.219686-1-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Oct 2023 10:39:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU281a+=9SApaCRy5os3k73HGZhQ=Fsv58OD4C430iDDg@mail.gmail.com>
Message-ID: <CAMuHMdU281a+=9SApaCRy5os3k73HGZhQ=Fsv58OD4C430iDDg@mail.gmail.com>
Subject: Re: fix the non-coherent coldfire dma_alloc_coherent
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CC Greg

On Mon, Oct 9, 2023 at 9:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
> this is the next attempt to not return memory that is not DMA coherent
> on coldfire/m68knommu.  The last one needed more fixups in the fec
> driver, which this versions includes.  On top of that I've also added
> a few more cleanups to the core dma allocation code.
>
> Jim: any work to support the set_uncached and remap method for arm32
> should probably be based on this, and patch 3 should make that
> selection a little easier.

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

