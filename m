Return-Path: <netdev+bounces-49364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D4A7F1D48
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EA7282377
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136ED3456E;
	Mon, 20 Nov 2023 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F9BCC;
	Mon, 20 Nov 2023 11:28:22 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db029574f13so4696822276.1;
        Mon, 20 Nov 2023 11:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700508502; x=1701113302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzOUYWrw4qYLV8wCUaEf/5tB/ioKS2pQYfel7hQdp8s=;
        b=nooiTBvkFQK9LxbcPcZvAk5Tt7uC54/RyB9uu2AnlZOr91nNo+6mtsha/kE18xO1Ad
         sT/n6vMTAGyxGcFUHryjaRbD09yC1CO7zstdGzETWYEDrRSd8DyxuhvjKsf/zmLHH+Hq
         RR0rhWbe5/teFWFYQB1TyoQ+WF0rXFG5elyI/ZFQQ0EbxGLfsG67e4x+7+R4NKEga7jY
         mz087m6MgZkFuhuT/M6Oe6fXRxTYGUi/gzJek7dL+Hm3wtgSRZzWlkiL+a0CXaHxy0PC
         bgWKr0M90ZmpF8F7tkG4nd/EDim5Cb4YahMbCWC2WIdKlnjfYQBIoBkRRLKkoGw905Ed
         4+ig==
X-Gm-Message-State: AOJu0YxEsT7zJ0jsnI0AhdARU5k9W8t82TUvqOp9OvHyWFIKpyozu1AR
	sUiah+UifcER4UZ0/fz7Dgyrc0gNeg2KkQ==
X-Google-Smtp-Source: AGHT+IFtd08JAOB3r62zXBS0Z+UuWC96OuBAcu4T5hUFo8+lpxuAqOkM0Da59dind2+rd6WTujwqnA==
X-Received: by 2002:a25:3457:0:b0:da0:3d0d:3a18 with SMTP id b84-20020a253457000000b00da03d0d3a18mr7984756yba.39.1700508502002;
        Mon, 20 Nov 2023 11:28:22 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id a11-20020a5b0ecb000000b00da086d6921fsm176767ybs.50.2023.11.20.11.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 11:28:21 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so4681733276.2;
        Mon, 20 Nov 2023 11:28:20 -0800 (PST)
X-Received: by 2002:a25:d84e:0:b0:da3:7764:41d0 with SMTP id
 p75-20020a25d84e000000b00da3776441d0mr7689956ybg.31.1700508500408; Mon, 20
 Nov 2023 11:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120160118.3524309-1-niklas.soderlund+renesas@ragnatech.se> <20231120160118.3524309-6-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20231120160118.3524309-6-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Nov 2023 20:28:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWcS4uW6QLYyea5A1SXgCS_8Ni--5db29+JzYh3KNVphw@mail.gmail.com>
Message-ID: <CAMuHMdWcS4uW6QLYyea5A1SXgCS_8Ni--5db29+JzYh3KNVphw@mail.gmail.com>
Subject: Re: [net-next v2 5/5] net: ethernet: renesas: rcar_gen4_ptp: Break
 out to module
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Mon, Nov 20, 2023 at 5:03=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The Gen4 gPTP support will be shared between the existing Renesas
> Ethernet Switch driver and the upcoming Renesas Ethernet-TSN driver. In
> preparation for this break out the gPTP support to its own module.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
> * Changes since v1
> - s/Gen3/Gen4/ in commit message.
> - Add missing MODULE_AUTHOR() and MODULE_DESCRIPTION() definitions.
> - Make Kconfig tristate depend on COMPILE_TEST. All drivers that make
>   use of the shared code auto selects this anyhow.

Thanks for the update!

> --- a/drivers/net/ethernet/renesas/Kconfig
> +++ b/drivers/net/ethernet/renesas/Kconfig
> @@ -44,7 +44,17 @@ config RENESAS_ETHER_SWITCH
>         select CRC32
>         select MII
>         select PHYLINK
> +       select RENESAS_GEN4_PTP
>         help
>           Renesas Ethernet Switch device driver.
>
> +config RENESAS_GEN4_PTP
> +       tristate "Renesas R-Car Gen4 gPTP support" if COMPILE_TEST
> +       depends on ARCH_RENESAS || COMPILE_TEST

You can drop the depends line, too.

> +       select CRC32
> +       select MII
> +       select PHYLIB
> +       help
> +         Renesas R-Car Gen4 gPTP device driver.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

