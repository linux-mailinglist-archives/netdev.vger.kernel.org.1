Return-Path: <netdev+bounces-223899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453E0B7EA0F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB04463DC2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5963081AC;
	Wed, 17 Sep 2025 08:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6B306B3F
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096344; cv=none; b=unjy5RDhFMf6chvtjKl2b9WDunSCSE6mBfrH9JY2oDHQlf7z7tKJ6tuOt81JlUvujtjkpppNC3Z8YFTc/jDply58LNSrX2OEggBM06hvVNMfgWaiMy/5Adl3tu6BDBW/COqxYRdnoVs8w8Oe7YVgftmZFm6fO73E4K26X9tPpNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096344; c=relaxed/simple;
	bh=Ec9ei6B/8ewo89UcVD8Q7X1+MZiGXpFbC8JM3y5kSV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YApNkxsh7onJIMA4fa/+BvUs3NvIP6KL0UL7Ob7ILlyfeCSTdgqUhWwBWJT8DkvOksl6e70sjI2iznyMiKRt7Cm+n+rtMW0I1ul3NByk3yT88sLIZqitIsRCSGOfnjkaYl5bUDmH2nnTHQFA1NsxpIS8NucugTHhxZchWkpCWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07c2908f3eso762307666b.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 01:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096340; x=1758701140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHmK1DphSWWRr1U++nog5qIJKFnFzeb4vk8JecyOkhQ=;
        b=dtbI7g/MwRy8WD+6e39PY8rBAXvXhdFgJOYptehyu1UyK2JmNxdQNwOgIb+efeSF2D
         w97YDWw7dxwN55CcvpO2gW8RHpN0noIHVyZ7E4oM1Byo42pVYLxHSFbHJMAAMZTQCUaQ
         d8iTJDhxn6HLeXHQ6uzlKXDitQulBweMUVmIuNNrhokfG7HvCftmfit4WhnR1GF0PAFi
         jaibjYgFEvO5XBoLiN7uDTXKd2tT7HaWulOioms23+6wepBDDRMghL51JWPYVgeQ2Jdi
         C+5W3U0GGyfmkKdcoEWqFLK9UM6r8et7UuNfu3SJalJ7jnLDsHC5vwni5H9aOK+f0Exy
         GvUA==
X-Forwarded-Encrypted: i=1; AJvYcCUJdCGShMJUoRE8Yjv+VUl+LuLEC5JFkjuUIkGN+uheBvEeduqQdltEo2YsgPYO9aapxuGnobw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbGv9wHUxAEOJtbXrIJP6GxaBYrkT7ntG2Y+YWpI6/nrIHOLs
	Gam4XnfSsqW4yuV0A2HtDjxvg96zFkc920XxYduk7TCP1zNRgJcOxWuXtvSYMOLqS+g=
X-Gm-Gg: ASbGncvCVJUuzDnGlkgoSa0a5c799CcNlFBRd9jNzse10hA8syeqaZ/MKNnHx1RHtfL
	Orlj6EbE1Cv9bGUbywAi1NO+JbtuJSahDOKcxozL5d1+PQaOB8WN4E6YRzndXHRSA7M71w7u6Gb
	sJclj2zIMJ8QGW7aMH4M1NUpWVRxnY2/StBr+zhB0lPhJm0W/Hgiv6XIGXu2gyIeokRDXKD7JnU
	FUjtmed/oYBreeImczZ+ZWD3B/Vf7kIwS1jHGpM6nFuitT69eTs6xuLOr5/VhyUjzX9lRZIv8/A
	QOiE6eWbB77Jmp58eTIiSruLA3Xa3p0mbAEReT3W+7hX3iaxwkxj9hczu8BdXjgDi/1FbE6u2dG
	ZqfVGZ3afh5OlZVK9EyH1JMgpJfz96Xgg63k384K308lkTLy/s3oRqTIILCIj
X-Google-Smtp-Source: AGHT+IFbwzMveP8v+djTqKx+DXYqKTkRKWQD4q2EAMnEag3fI556rat3Sl713qrxe84J7aawfmb4MA==
X-Received: by 2002:a17:907:dac:b0:afe:cded:bf96 with SMTP id a640c23a62f3a-b1bb50c5925mr131399166b.6.1758096340127;
        Wed, 17 Sep 2025 01:05:40 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ddf93sm1301849666b.69.2025.09.17.01.05.36
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 01:05:36 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07d01fd4fbso720630766b.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 01:05:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU00diyeRisJVdB8vwJ+2BjC/C/IjAo2jMq6fPhXNvqVkuaS3qSWMfiegk8FmXMSAe8Vtzysps=@vger.kernel.org
X-Received: by 2002:a17:906:9f8e:b0:b04:6e94:f317 with SMTP id
 a640c23a62f3a-b1bbbe68575mr139964666b.34.1758096335970; Wed, 17 Sep 2025
 01:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916162335.3339558-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250916162335.3339558-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Sep 2025 10:05:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhUHAMtOx1RVtva5iGmJhKy1DyvNJdjNMj=OxmL_ydFQ@mail.gmail.com>
X-Gm-Features: AS18NWBJ_DPCNXyZLdkJ7u6e0yw3d9zcREiBtm4I2Y3XsgBeWPU4BTw3RRIOiqE
Message-ID: <CAMuHMdXhUHAMtOx1RVtva5iGmJhKy1DyvNJdjNMj=OxmL_ydFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: pcs: Kconfig: Fix unmet dependency warning
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 18:23, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Fix the Kconfig dependencies for PCS_RZN1_MIIC to avoid the unmet direct
> dependency warning when enabling DWMAC_RENESAS_GBETH. The PCS driver is
> used on multiple Renesas SoCs including RZ/N1, RZ/N2H and RZ/T2H, but the
> existing condition only allowed ARCH_RZN1, ARCH_R9A09G077, or
> ARCH_R9A09G087. This conflicted with the GBETH/GMAC driver which selects
> PCS_RZN1_MIIC under ARCH_RENESAS.
>
> Update the dependency to ARCH_RENESAS || COMPILE_TEST so that the PCS
> driver is available on all Renesas platforms.
>
> Fixes: 08f89e42121d ("net: pcs: rzn1-miic: Add RZ/T2H MIIC support")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/aMlgg_QpJOEDGcEA@monster/
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

