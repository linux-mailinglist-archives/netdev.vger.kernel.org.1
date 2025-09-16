Return-Path: <netdev+bounces-223546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08873B597B0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814E04604E8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8021B918;
	Tue, 16 Sep 2025 13:31:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7B2DAFB5
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029480; cv=none; b=W3kzwvuJgqqOsw27yP3oisSV+hYAODsF4JFdEE0qo2CQKTq1R4Pso7vOWfnXxA1dY5SPujzuQltkUvCpspCHjSeRXSGjL5mMTzzrL8jW6y0ze8rLVmZ/utjX3endplhWw5XOdA+7S/mtR0up/KUe1QPoUt7rTOeo1LTmY2tnLDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029480; c=relaxed/simple;
	bh=lRwGS+EzOykdHSjihfKZFNIAo3QDxUC71G1I5pU5mBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WI3k7wd97JsxIfyHzNhkP438y/uEQGCnQZjMhVWy6dPS6pHUBtIBzrJOGnHvn2vZe7mIh+mPSulcHtCJAMw+u6N2d/ecd46JuuLtj9eySHJl3qb3k52740TklCbsKG5TyLn26nPP1z17iwskDg2B4njuuppOtCqAhVG6wUCTibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8943501ba3dso2839629241.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029478; x=1758634278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDQooxDkD5fz4sLWBIH6i0SDIPVUTbpTi303GssaIAI=;
        b=hgdComAE91cR1JY+U3DTKyNSmcgsyjNnbt6qBRI+QrJE0hG1fi860o51MhitDSYFSK
         BRJtjbXraZkWn0gzfLXfPDzbVlOZnLnf/jVFHByCiAOzOWYGnmPbuIODglPKeF4yT5IM
         Zj8uzTr9xYD1H5JM2wF+tM9yc1h0t3jdTDvaJHz7yiN3x8icUcDHoU4MSl6UjjWRxPZf
         7QP+izfqa+LUWBvtyGZtOHJBlDup8wRsq93VcEdYoHMWKRqZyJZN8XiMZS6csdo1g2j2
         NYL4wNEgNyaka3FYzZ6wObFe6ru+uNSX1lh6WZjd31zR68/n9s5ctAGB+71JBLdga6aZ
         nsKA==
X-Forwarded-Encrypted: i=1; AJvYcCVIYWlzTb/JU3ZqVP+w8acUaQyVhCB2N8AveDub/Ok5Gy2Qv85PySBDfkMmbrJ+7ddk982Wv3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmUnCWeRyd5ACv+WTwe2FB71fVAVgwWb98vZBkKTpUd0Q3qInq
	o5N38WDFHp/1+6Pnggw+3WWGXsH2cG6pClkTTJ0cJ0oRVA9Ab0nqtfv8+ngX/ttr
X-Gm-Gg: ASbGncs+0o3h3kmokB1nnClzgxH3A3PaWmLJlDP4pg2hga54H6vTRG/b2mbRCW5oaCb
	YIz/uDtph8mG91PIs8mH9TLQ0Y/yUlOjHGUmSBGvYx6m7FD0GqeJdgovXRERyDZdoV0ycDY0xs4
	u0cjUvLKnlxe8FYY3t/hFVp7ijeJnISM7P8CusgxHQpXDsS+zXwdpqk8pY6asRMk1E9rmKr1wGO
	vhvxJxwM/DYkHUFX39B4ySnE1SeYRX5jpgl5kQNrDJRDlNejZps5N3q1FJAnTNN2LVj67A3iRv8
	YuLO60yVclnTDTbOkxrwmUkeHHfIqTQTEAhSdCihkqJbUO/KzliCYoGH3xGDIMBY6ppv1kCwO5q
	g4Wv+S/fdvMiBCA31ZoXEuZlTT2MS7HBrcF8DoB7eTNTabaXTQ1ZezKesyrv13RxJ
X-Google-Smtp-Source: AGHT+IFAXWHfXtIFa/OFoH3HqwcBrm8/pxLbOxZ4zxl+eUUVwOD61rPnvcdg2SIJIU7Vt/lvAxCXcQ==
X-Received: by 2002:a05:6102:4243:b0:538:dc93:e3c4 with SMTP id ada2fe7eead31-5560c6e61ebmr6127903137.16.1758029477756;
        Tue, 16 Sep 2025 06:31:17 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5537062c9c5sm3572013137.5.2025.09.16.06.31.15
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:31:15 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5448514543eso4006333e0c.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:31:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBK4jRAXZs6ik31WDefW7jc0bzGxRMgYLoUhSWIzb9kQYju7AO345Z3EtR15gZc2cZ+fm2XH0=@vger.kernel.org
X-Received: by 2002:a05:6122:1d8c:b0:53b:174d:98f2 with SMTP id
 71dfb90a1353d-54a16b20009mr5200853e0c.3.1758029474999; Tue, 16 Sep 2025
 06:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908105901.3198975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250908105901.3198975-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <aMlgg_QpJOEDGcEA@monster>
In-Reply-To: <aMlgg_QpJOEDGcEA@monster>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 15:31:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXWVXd5FauMYNq0yXgQa87F4Z9HcGOu2O_ercQg48GNoQ@mail.gmail.com>
X-Gm-Features: AS18NWCih78Z1mvXR97O_iR6cJDURxsOD6O73Iub1rATQe0jxKnm2iY0iJuCAa8
Message-ID: <CAMuHMdXWVXd5FauMYNq0yXgQa87F4Z9HcGOu2O_ercQg48GNoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: dwmac-renesas-gbeth: Add
 support for RZ/T2H SoC
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Prabhakar <prabhakar.csengg@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Anders,

On Tue, 16 Sept 2025 at 15:05, Anders Roxell <anders.roxell@linaro.org> wrote:
> On 2025-09-08 11:59, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Extend the Renesas GBETH stmmac glue driver to support the RZ/T2H SoC,
> > where the GMAC is connected through a MIIC PCS. Introduce a new
> > `has_pcs` flag in `struct renesas_gbeth_of_data` to indicate when PCS
> > handling is required.
> >
> > When enabled, the driver parses the `pcs-handle` phandle, creates a PCS
> > instance with `miic_create()`, and wires it into phylink. Proper cleanup
> > is done with `miic_destroy()`. New init/exit/select hooks are added to
> > `plat_stmmacenet_data` for PCS integration.
> >
> > Update Kconfig to select `PCS_RZN1_MIIC` when building the Renesas GBETH
> > driver so the PCS support is always available.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3:
> > - Dropped passing STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP flag in stmmac_flags
> >   as it is always set for all the SoCs.
> > - Updated Kconfig to include RZ/T2H and RZ/N2H.
> >
> > v1->v2:
> > - No changes.
>
> The following warning is seen when doing a defconfig build (make
> defconfig) for arm64 on the Linux next-20250915 tag.
>
> First seen on next-20250915
> Good: next-20250912
> Bad: next-20250915
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Build regression: WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> This is the build warning:
> WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC
>   Depends on [n]: NETDEVICES [=y] && OF [=y] && (ARCH_RZN1 [=n] || COMPILE_TEST [=n])
>   Selected by [m]:
>   - DWMAC_RENESAS_GBETH [=m] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_STMICRO [=y] && STMMAC_ETH [=m] && STMMAC_PLATFORM [=m] && OF [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n])
>
> WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC
>   Depends on [n]: NETDEVICES [=y] && OF [=y] && (ARCH_RZN1 [=n] || COMPILE_TEST [=n])
>   Selected by [m]:
>   - DWMAC_RENESAS_GBETH [=m] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_STMICRO [=y] && STMMAC_ETH [=m] && STMMAC_PLATFORM [=m] && OF [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n])
> I: config: PASS in 0:00:01.592356

Thanks for your report!

    config DWMAC_RENESAS_GBETH
        depends on OF && (ARCH_RENESAS || COMPILE_TEST)
        select PCS_RZN1_MIIC

    config PCS_RZN1_MIIC
        depends on ARCH_RZN1 || ARCH_R9A09G077 || ARCH_R9A09G087 || COMPILE_TEST

"ARCH_RENESAS" is wider than "ARCH_RZN1 || ARCH_R9A09G077 || ARCH_R9A09G087".
I would just change the latter to ARCH_RENESAS.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

