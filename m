Return-Path: <netdev+bounces-42907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E964F7D0948
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269AA1C20F99
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE61BD2F9;
	Fri, 20 Oct 2023 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F5D2E4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:18:46 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E02D7
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:18:45 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a7b92cd0ccso5060387b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786324; x=1698391124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OizVgKEhlDyqgQ+n9W+hpcjW/zmDsIX6WVqXAdIMLco=;
        b=tp8f5pxUFslIvJeW2kqFnF/Qcrz5pnRS5cXe2dC30ggsw513EvGayLn3toFaU7Cg6i
         4qT9j7P/sGZDUwuiKBW9x+uu33knN4IlAkn6vZKKamcuvdNPqkgvJyQHyw9Bm5cRASI3
         Nl7PBOFqkJFUA79d4m529uWHlVugnt8PzlFMHeZRgF6K7e8ONYW861+ui6dU1lrfAUXR
         B9nrC0R+R32wW2E5iZEVucdyl7OEvToaB6NlhrosRM1JIOTJ8L5qxaPM5EY9sD8QCUOe
         3MVcNGGCL2c+KraE7sFmwOOMbhVTgD/gUg2dVpw2T7txvUp3b1OCIiUyZ9dAgDp7u/kT
         1xMg==
X-Gm-Message-State: AOJu0YyM+OEkYLIjT1ZYvmRArihGAnuLjlAmQraEjxh+z64i6GY3l3X0
	5eic9weDXYR8DYlW/9O8OfZyhwxZ/6tXqg==
X-Google-Smtp-Source: AGHT+IGomyc8i2XgxHv4wz64ip8iigZLS8X4yWS9mpKdTXr7K/qxs1g8t0MQXdg/ItSqqtKr5jtiAw==
X-Received: by 2002:a81:91c2:0:b0:5a7:b54a:e0db with SMTP id i185-20020a8191c2000000b005a7b54ae0dbmr1008572ywg.10.1697786324237;
        Fri, 20 Oct 2023 00:18:44 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id o139-20020a0dcc91000000b00583e52232f1sm481763ywd.112.2023.10.20.00.18.43
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 00:18:43 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a8ada42c2aso4926977b3.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:18:43 -0700 (PDT)
X-Received: by 2002:a0d:ddd7:0:b0:59f:4dcd:227e with SMTP id
 g206-20020a0dddd7000000b0059f4dcd227emr1147454ywe.37.1697786323167; Fri, 20
 Oct 2023 00:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020054024.78295-1-hch@lst.de> <20231020054024.78295-2-hch@lst.de>
In-Reply-To: <20231020054024.78295-2-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Oct 2023 09:18:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVNmbMsqBF3gozT7yqUVJZ+9Eg2wjTuQF+1W4jKXdAZVQ@mail.gmail.com>
Message-ID: <CAMuHMdVNmbMsqBF3gozT7yqUVJZ+9Eg2wjTuQF+1W4jKXdAZVQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] dma-direct: add depdenencies to CONFIG_DMA_GLOBAL_POOL
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

s/depdenencies/dependencies/

On Fri, Oct 20, 2023 at 7:40=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> CONFIG_DMA_GLOBAL_POOL can't be combined with other DMA coherent
> allocators.  Add dependencies to Kconfig to document this, and make
> kconfig complain about unment dependencies if someone tries.

unmet


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

