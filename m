Return-Path: <netdev+bounces-48891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0777EFF38
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 12:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242A6280FC2
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 11:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39ED53A9;
	Sat, 18 Nov 2023 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5F6D6C;
	Sat, 18 Nov 2023 03:20:58 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-daf26d84100so2843155276.3;
        Sat, 18 Nov 2023 03:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700306457; x=1700911257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7AzhxJFnam25pfCDfxhRFO5ktfVbapYW88b1TiW864=;
        b=DisOEqfqoHxVTR4ScM1n7KX2c49JtUsiKq5bocTbvslONc29PsNIG6KmEaMkTjLJz/
         dbk7j2ZpfHblL0MarHznspFO5FcT3ESL2+KE5niu+uhoPNcUbCkBjLm+B/dcEVLkhvhF
         C8+lHZIFCRz9zGkqlPGmum8+zeAC+bgVPCtRuPsRGTlHEjttsadcjzd21HjmKC9viOL7
         WU+rUs3jHhFO2AltzDtEgFefa0eM83tHDq5WrmJCAAOauk9w8Uv2MjYi9iOcEtqz0Bvg
         YRnYEXeVky2teosPhw+Bte26sq9Ck+QUgk8lH7jASmbUgfP8glq81m0le8Im2R2dEklQ
         1JaA==
X-Gm-Message-State: AOJu0YxHgW9EKwb0mMB7JYjfndndHzCGNdxcxxYa+lUilDKm6/Ghx3jI
	3X4jvOqbsaiWRw1g9UgOR243lSVf0JoDDw==
X-Google-Smtp-Source: AGHT+IExCJl6Hmm3cYPHXJJtO2Ha3Yb238N+goN2MXziomGvoM2DGAbRH6qggN+NOf3nk2z3hdVVqA==
X-Received: by 2002:a25:aae1:0:b0:da0:48df:cb09 with SMTP id t88-20020a25aae1000000b00da048dfcb09mr2079805ybi.54.1700306456986;
        Sat, 18 Nov 2023 03:20:56 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id l129-20020a257087000000b00d8168e226e6sm907379ybc.47.2023.11.18.03.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 03:20:56 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so2848883276.2;
        Sat, 18 Nov 2023 03:20:55 -0800 (PST)
X-Received: by 2002:a5b:d51:0:b0:d81:754a:7cb8 with SMTP id
 f17-20020a5b0d51000000b00d81754a7cb8mr2248902ybr.65.1700306455241; Sat, 18
 Nov 2023 03:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se> <20231117164332.354443-6-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20231117164332.354443-6-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 18 Nov 2023 12:20:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWd7gK3_p4mhkKS4VJUw6WCAHEw-pkQ8DBABq7=np+1Vw@mail.gmail.com>
Message-ID: <CAMuHMdWd7gK3_p4mhkKS4VJUw6WCAHEw-pkQ8DBABq7=np+1Vw@mail.gmail.com>
Subject: Re: [net-next 5/5] net: ethernet: renesas: rcar_gen4_ptp: Break out
 to module
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Thanks for your patch!

On Fri, Nov 17, 2023 at 5:45=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The Gen3 gPTP support will be shared between the existing Renesas

Gen4

> Ethernet Switch driver and the upcoming Renesas Ethernet-TSN driver. In
> preparation for this break out the gPTP support to its own module.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

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
> +       tristate "Renesas R-Car Gen4 gPTP support"
> +       depends on ARCH_RENESAS || COMPILE_TEST

Perhaps

    tristate "Renesas R-Car Gen4 gPTP support" if COMPILE_TEST

?

The driver is already auto-selected when needed.

> +       select CRC32
> +       select MII
> +       select PHYLIB
> +       help
> +         Renesas R-Car Gen4 gPTP device driver.
> +
>  endif # NET_VENDOR_RENESAS

> --- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
> +++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c

> @@ -186,3 +188,6 @@ struct rcar_gen4_ptp_private *rcar_gen4_ptp_alloc(str=
uct platform_device *pdev)
>
>         return ptp;
>  }
> +EXPORT_SYMBOL_GPL(rcar_gen4_ptp_alloc);
> +
> +MODULE_LICENSE("GPL");

Please add the other MODULE_*() definitions,too.

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

