Return-Path: <netdev+bounces-237887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6B9C51347
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE083BB13C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B752FFDDA;
	Wed, 12 Nov 2025 08:49:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F52FD672
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937384; cv=none; b=GBFRxaTE6IMf8g/OfpAZcvEAmT5kVRtbG650RawlQ32LYZKsmdwDLVY7cL86iEsuDy/RGyfrPXaMkeKgmUUL95RvnzE7gDs5jN705Pxn5KlVqN9HPoVrt2K87VrER0hs2S5yWAmhDKkj11LnV7McXTcvNMp6n5MuVYM8m3+ZzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937384; c=relaxed/simple;
	bh=GEPcxScTlNQXWLN1NkRTChaD1+/VaqI0xZxACdHRNZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBH4zACCNiBNMiYAzg699bICNLOMnPDxMroa2WtdXd3z5AQ0zMbLLTevEegOzcJ91CIvAXnw4OaqvhZ8hz2cS5JUPa2vQi0ih19hSAltB6eoPVLJR1jhAoGdpNiJGSbCQayBzGfjW3me8h6TEWXwJvXoPEfWOWjcy7u97EYvbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-55965c96fd7so167965e0c.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937380; x=1763542180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRuYUt97/AAYUOVBqnw5NKTwDWHex1IdJ959zTzv1gA=;
        b=bai7RI1AcUuVBjzGv6h3YOjqCOPHZ6is1XJ1mVKJa+JsSvUnT9NHXScBRk3PXMGo7b
         5lxqCBO+403C6cKQK+285ULPnY7iVFlznkWRpcE4huIO2W1XzKcsVuQj6OAqsEsrWF47
         PE/o86fJ14VYaEr6c6jlMoFIVQGg+58BRKKioETB7Do+M+caBh41BRZAgJFgD5UwUpWJ
         E1kYXG6jlp8mDnUNitHTmRkFXBKgr+QaloS7kz76zTwNwRK+oG8EakecgoOtWMmoujq2
         T2lwPC9HCJz/qZS+fj+SxyZ8cvSfaJfMdx0F8i8veu+IUxntguJFVJvQ38UCn+KoKCoL
         B70g==
X-Forwarded-Encrypted: i=1; AJvYcCWbVPS8giN1xDH+9lnMG3wdl98n5nReGSIdejvCJP5ei0cSiyNB4CQIyJLIpnn95HPnH5n7oFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pLovEpT0AV0HNB/VDfwQnrKfWTNtyGs+BlcZJPYJ3bjShnBL
	ycgTM10aZk7M+9dYXXfWLvEVj/KPo/EFhLGwUaOSI4Osv5eylPB6/1A2Z2GjVDnZ
X-Gm-Gg: ASbGnctiiUEoWkdLYsy8OAlwZiyTA0uTBQWAsiG0Gi+9lnTxMYIkuZJfTe6zt08FbcS
	YrdPp2p4wb8t13BTsc83l+yzYrfkcFMeT7IU08nBJEb61wTXRn2sjT9qtm0dxPM6Wnx+ih0za+h
	nVfk2CL1HvTuuYtIHqUBhYYhKIwpg5/7BypI6lN1F2gBK1HOzMhUJhetEufH8StUZNYYOMAZwq4
	7vdmcEcHBQHsrPvs3foPNsHSxDi9sfAb1alBLHeocFq9ZLbSSXHE00XSYtbmOaUBHbPZ1/Lpdyu
	JqPi4Z2PyMgf80VT5kjjD8q9dZOnxCK0WsSpLd8PctPEJeybjrb0JC50PUuxTU0roRCu5ImUgHT
	CQ2ufDSjdmlfZcLn8QpD9JyOK/7KbNKB2+0Co0m+DwhcdySWRsv4gsinPMviphL2jw7V+SaJK4O
	Sm34NanGLiHh/PLAnSimbDaib27za2MhXh6juwpQ==
X-Google-Smtp-Source: AGHT+IEPxwc1KYwCpI9/S3A6cNmFwCKA5A+9kz7sm26Md/a2ZjXBVljMEyOYgGEPzQNQaLfw2NJ5wA==
X-Received: by 2002:a05:6122:16aa:b0:54b:c83b:9299 with SMTP id 71dfb90a1353d-559e7cdd3f1mr723092e0c.10.1762937379791;
        Wed, 12 Nov 2025 00:49:39 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559968c29a1sm9252222e0c.3.2025.11.12.00.49.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 00:49:39 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5d61f261ebfso240293137.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:49:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHWpZO5WfwUIXAcevq18elUC/HS6SrDi65HYpLI2bcgKM9DsHj4G/9jLHo7iIAr8eGpYoGbzg=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0a:b0:5d7:bb3c:d5dc with SMTP id
 ada2fe7eead31-5de07f16d04mr501696137.41.1762937378500; Wed, 12 Nov 2025
 00:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251111091047.831005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251111091047.831005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 09:49:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUv7tOc-QC8N_ie7739t07Y5A_6HQPMVR9fxW-jo_d9Ng@mail.gmail.com>
X-Gm-Features: AWmQ_bnWiYGIV8O5vMXPYGxK5G9F49mp_eGvUmhrBRrD8EAR2kAYVwJHFvxANG8
Message-ID: <CAMuHMdUv7tOc-QC8N_ie7739t07Y5A_6HQPMVR9fxW-jo_d9Ng@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: phy: mscc: Consolidate probe
 functions into a common helper
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Tue, 11 Nov 2025 at 10:11, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Unify the probe implementations of the VSC85xx PHY family into a single
> vsc85xx_probe_common() helper. The existing probe functions for the
> vsc85xx, vsc8514, vsc8574, and vsc8584 variants contained almost
> identical initialization logic, differing only in configuration
> parameters such as the number of LEDs, supported LED modes, hardware
> statistics, and PTP support.
>
> Introduce a vsc85xx_probe_config structure to describe the per-variant
> parameters, and move all common setup code into the shared helper. Each
> variant's probe function now defines a constant configuration instance
> and calls vsc85xx_probe_common().
>
> Also mark the default LED mode array parameter as const to match its
> usage.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3:
> - Grouped check_rate_magic check

Thanks for your patch!

> --- a/drivers/net/phy/mscc/mscc_main.c
> +++ b/drivers/net/phy/mscc/mscc_main.c
> @@ -22,6 +22,24 @@
>  #include "mscc_serdes.h"
>  #include "mscc.h"
>
> +struct vsc85xx_probe_config {
> +       const struct vsc85xx_hw_stat *hw_stats;
> +       u8 nleds;
> +       u16 supp_led_modes;
> +       size_t nstats;
> +       bool use_package;
> +       size_t shared_size;
> +       bool has_ptp;
> +       bool check_rate_magic;
> +};

Please sort by decreasing size, to reduce holes:
  1. pointer and size_t,
  2. u16,
  3. u8 and bool.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

