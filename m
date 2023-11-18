Return-Path: <netdev+bounces-48890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C615B7EFF33
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 12:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65ACC28107B
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCF61097D;
	Sat, 18 Nov 2023 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5177D6C;
	Sat, 18 Nov 2023 03:17:07 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a822f96aedso32131067b3.2;
        Sat, 18 Nov 2023 03:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700306226; x=1700911026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/gCm/o6c2++cyQYsw+VNmhQ/B0RHoApOrqfxujvmck=;
        b=nazIeEFMN6Lky54FHdfKxpf6BZSAIcGKVyF7QyxqGwPJKGbcZJEkVlVBPFMbNzA3id
         9ZbBjwG8gNDOGPKIGM8hVSmzbL3qSVzQkFc6lJPDppx8eyVao8fxsvN/FOcFkj1KFrI1
         KLORU7i11hhMI8iKMj8Ij87TmjEWISYSR9HDHMCzZ+/f7OW93ctRB/zjFW2L0GLe1dgH
         gHB394ubM+xHr+WVjZaFaMWqMVhOXHNJ6CqM4pMpGPSHnIsiY9AMbgtnFIcvM0cjupEE
         0Qwus9p3mAa/hX+AG4A4G9yHufJa99Mv/IPZ4+lMnn7HdXLmrSo6flY5R8P+Ktsvnciu
         5uGw==
X-Gm-Message-State: AOJu0YzwKouP80UpzEPktNqn0KB+0WAfRENNsYKTBOnEsFyzKQ93z6Z6
	8BhE595tenYkoUSUzfFWde3+W+g6xdUQHA==
X-Google-Smtp-Source: AGHT+IEChTaRTLTLoJmXOvQp/inysy3ZeVkO6443EeuqZM2WChn2VMsUsp9kXktdBF8DF+l7o4ogkQ==
X-Received: by 2002:a0d:d481:0:b0:5a8:bbeb:38a5 with SMTP id w123-20020a0dd481000000b005a8bbeb38a5mr2155490ywd.42.1700306226444;
        Sat, 18 Nov 2023 03:17:06 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id u125-20020a814783000000b0058fc7604f45sm1049243ywa.130.2023.11.18.03.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 03:17:05 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-daef74513e1so2681299276.2;
        Sat, 18 Nov 2023 03:17:04 -0800 (PST)
X-Received: by 2002:a05:6902:4e6:b0:da3:b87b:5b7c with SMTP id
 w6-20020a05690204e600b00da3b87b5b7cmr1857879ybs.38.1700306224496; Sat, 18 Nov
 2023 03:17:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se> <20231117164332.354443-5-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20231117164332.354443-5-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 18 Nov 2023 12:16:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8L9BxPUkBf-pNrACqAyFcEcczOBEaOqwwgHpisZ_e5g@mail.gmail.com>
Message-ID: <CAMuHMdW8L9BxPUkBf-pNrACqAyFcEcczOBEaOqwwgHpisZ_e5g@mail.gmail.com>
Subject: Re: [net-next 4/5] net: ethernet: renesas: rcar_gen4_ptp: Add V4H
 clock setting
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Fri, Nov 17, 2023 at 5:45=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The gPTP clock is different between R-Car S4 and R-Car V4H. In
> preparation of adding R-Car V4H support define the clock setting.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Thanks for your patch!

> --- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
> +++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
> @@ -9,8 +9,12 @@
>
>  #include <linux/ptp_clock_kernel.h>
>
> -#define PTPTIVC_INIT                   0x19000000      /* 320MHz */
> -#define RCAR_GEN4_PTP_CLOCK_S4         PTPTIVC_INIT
> +#define PTPTIVC_INIT_200MHZ            0x28000000      /* 200MHz */
> +#define PTPTIVC_INIT_320MHZ            0x19000000      /* 320MHz */
> +
> +#define RCAR_GEN4_PTP_CLOCK_S4         PTPTIVC_INIT_320MHZ
> +#define RCAR_GEN4_PTP_CLOCK_V4H                PTPTIVC_INIT_200MHZ

I think the gPTP Timer Increment Value Configuration value should be
calculated from the module clock rate instead (rsw2 runs at 320 MHz
on R-Car S4, S0D4_HSC and tsn run at 200 MHz on R-Car V4H).

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

