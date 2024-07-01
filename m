Return-Path: <netdev+bounces-108182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 292FB91E367
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12881F22923
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D194516C860;
	Mon,  1 Jul 2024 15:06:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D316C874;
	Mon,  1 Jul 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846386; cv=none; b=YQvyS70rEtsAvfP+xFpmxwqak9bYBdK3eKtW81sXh7w1Cddp8e/C977YuMaBN8CPl+755O3eUe9teBKssFEcc3RtYYLsf79M2Cycn5V6rrDaY1F75E/qu1YBWElqhYso6sF7BaYzTdCJU86v8QU3+Mj8jgKBzhPlN41uBHnuXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846386; c=relaxed/simple;
	bh=0Nif9q7hfz76NQxhnSKV6YnAV079PXlI5gtqsrIOlCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujGnM9mNj/KSh9yYFNgRaGNG2MIOSi6ZVGHt16jD8mKOPJ0eHpC9bTdc9p5NHZc8Qtv2lyKtcH2IaVVHYurS5uR93V7gNAcjZMndi7lVL8yFwZ7GQ4E9rVT4ocVwi8E7tJLSrr+4MpKuZBoPgoYG2yVYt/fmar1JdsHHAH1E4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e03609bd52dso2936231276.1;
        Mon, 01 Jul 2024 08:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719846384; x=1720451184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWaohw8PG+1tErtmwgjMHrDH9yLlzp5VM7eJLmI1QaQ=;
        b=QBdSs3ILefZAPdTF2flNohpmc52+zljX+1HajHQnSDH8IF/dSBsHRW0C2Cw+Bsw4b9
         cWGF+juMbfCPESHElSh9Ao2eHqtrUFhjdJ9/CR30wZte/nim+QIIWLBWMnesLhNTDUN5
         lzDvzHCs2LrmfER9/erX5dJsx2DuhNBaDbwRSmwyLOEUq7hKSUE0ECWls937TGkX6GOF
         jveomq8cKdFjdRWV8H3Php1Zsn1HjnifQq36kxB2gwEPEhlxm4rVa2pfM8p2/PvFuMTK
         f9kfTW2VeprpC/o9OJPJNet4gibGiKvHFDiHn9lZVgHcKm7/iF0SxlfGb4C+gGdQmkqd
         u+8g==
X-Forwarded-Encrypted: i=1; AJvYcCWmUTkAhDeDKwV93cMxJyiDAVUG94Wv/7buR64QYCxMrvePs2ENaDKWAVKG5DO/e9GVPmKryeUShEyyVtdbKAcmgLzP+w/LCWmIsA==
X-Gm-Message-State: AOJu0Ywdy8Gx0RX2YdnjbPCNT9VBtIaY/OmSpR5RR5bBJlU4UXUymDse
	/yx5VBGE4VvzQvAT+mvaBs3/zvq888qczTc7ScXBF94XDDOhAc9R4bmau8Gw
X-Google-Smtp-Source: AGHT+IEEmh+HXS09Q+ckaARwyxU9ZqAhmpDAjcFjJunyZZTEkk64baYcD1Fh8KJaFAXs9Ijr4cz4OQ==
X-Received: by 2002:a81:738a:0:b0:646:628d:32ae with SMTP id 00721157ae682-64c718f83e5mr66775297b3.20.1719846383753;
        Mon, 01 Jul 2024 08:06:23 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a8037b9sm13787877b3.63.2024.07.01.08.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 08:06:23 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64f4fd64773so5748137b3.0;
        Mon, 01 Jul 2024 08:06:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7CYIDjBNTPg4eQxXl+MTZe+5HvCDMjOGlc1t0hP2v3K9m2YRnfAuf++HRmkOgIxzpiT+kYq3v6IcKwikZpFP96gDcZEEZjk6MgQ==
X-Received: by 2002:a81:8645:0:b0:64a:5b5b:d48b with SMTP id
 00721157ae682-64c73229ed1mr64857507b3.47.1719846382942; Mon, 01 Jul 2024
 08:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625184359.153423-1-marex@denx.de>
In-Reply-To: <20240625184359.153423-1-marex@denx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Jul 2024 17:06:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJmQ-Jhko-0SO6_dKceXPNu8nx++wgWxxLn=6xPcBMPg@mail.gmail.com>
Message-ID: <CAMuHMdWJmQ-Jhko-0SO6_dKceXPNu8nx++wgWxxLn=6xPcBMPg@mail.gmail.com>
Subject: Re: [net-next,PATCH v2] dt-bindings: net: realtek,rtl82xx: Document
 known PHY IDs as compatible strings
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Conor Dooley <conor+dt@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Joakim Zhang <qiangqing.zhang@nxp.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	kernel@dh-electronics.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Tue, Jun 25, 2024 at 8:46=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
> Extract known PHY IDs from Linux kernel realtek PHY driver
> and convert them into supported compatible string list for
> this DT binding document.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Thanks for your patch, which is now commit 8fda53719a596fa2
("dt-bindings: net: realtek,rtl82xx: Document known PHY IDs as
compatible strings") in net-next/main (next-20240628 and later).

> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> @@ -18,6 +18,29 @@ allOf:
>    - $ref: ethernet-phy.yaml#
>
>  properties:
> +  compatible:
> +    enum:
> +      - ethernet-phy-id001c.c800
> +      - ethernet-phy-id001c.c816
> +      - ethernet-phy-id001c.c838
> +      - ethernet-phy-id001c.c840
> +      - ethernet-phy-id001c.c848
> +      - ethernet-phy-id001c.c849
> +      - ethernet-phy-id001c.c84a
> +      - ethernet-phy-id001c.c862
> +      - ethernet-phy-id001c.c878
> +      - ethernet-phy-id001c.c880
> +      - ethernet-phy-id001c.c910
> +      - ethernet-phy-id001c.c912
> +      - ethernet-phy-id001c.c913
> +      - ethernet-phy-id001c.c914
> +      - ethernet-phy-id001c.c915
> +      - ethernet-phy-id001c.c916
> +      - ethernet-phy-id001c.c942
> +      - ethernet-phy-id001c.c961
> +      - ethernet-phy-id001c.cad0
> +      - ethernet-phy-id001c.cb00

Can you please elaborate why you didn't add an
"ethernet-phy-ieee802.3-c22" fallback?

> +
>    realtek,clkout-disable:
>      type: boolean
>      description:

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

