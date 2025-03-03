Return-Path: <netdev+bounces-171802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38EEA4EBE6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 204867AC73F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502172356B2;
	Tue,  4 Mar 2025 18:27:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1232E337C
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112869; cv=pass; b=YA2Bs791jvr9TpiGGU72p27SNM7SbKl7pUyRrgp1s8jfW9DgghZWzjxfqN/MRytEMylPfxMa7/TFrlz44i2DAmVKAa+q1B/RKUzJYr87sQ6gXBPQTt5MNI7LHnFjpRg54oayDz37jKIMiheldAGgdVVL2Nb3UpyoIRVXLqevWkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112869; c=relaxed/simple;
	bh=GpiZMOoa9Dd0lVa5mQxYvhJCA3PozAweI+AolilGiy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBOtGHJkDbse2I8FPzq3VhdumqoVgSKkUpEGZSPDZRVlsbLPZARmqGLtTWZ9D2JLbg1xJVfVIT/b2TZDUIC+aeHVntNOLy8dbtDIwcIx4QPw31MO8YN/1NJ+WL+criCPe/5KOgxjjZpGSBmreR5IBsnnVdjNM3Qp2akLkrTg3EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=209.85.222.54; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 563E740D5713
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 21:27:45 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6frH1FJWzG0Yt
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:34:55 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9EC0442731; Tue,  4 Mar 2025 18:34:39 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541401-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 7EEE74339A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:41:30 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id C38772DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:41:29 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672677A83A3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7791EB5D7;
	Mon,  3 Mar 2025 10:40:36 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F31D7E4C;
	Mon,  3 Mar 2025 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998434; cv=none; b=sxuAHBEdAodfmPL8uFAOBYuZHNeuMgZvhzQMMoHgQUwp6nZONZqhgemB7x37cyoNZkSLU4klQ9kyckGTzRtLiIBLUqIJOk+Flpm5htsN0HyuLuhcUS4jawSZ5tPFebahnSY4AYIHTXczhuG19c0FVodwTYcRxR2p7iZ/4M1MsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998434; c=relaxed/simple;
	bh=GpiZMOoa9Dd0lVa5mQxYvhJCA3PozAweI+AolilGiy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfTeT2Iirj9ofdomy8nBDZ9vcnutFBKTUGCTEiT52jqReSK2sfYjP5FMZ/O2pm1lBVctNJdwcyMOIcUoY64SLPd11veGf12wnAEVTSVBvqLyDDqbX1CjhlolQMBbEFFgl/SxLpnba1ZNKgwG49th4nmX0utSgCBl6v1WBWhjDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86b3ed5fde5so3631980241.0;
        Mon, 03 Mar 2025 02:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998429; x=1741603229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7nppDH0wEnn0k1LbQlYHcxjcCY12F5sq67FKUOJ3Wk=;
        b=rEaU6PylpvNHHpdKiJEKrmy8MaMBSvzNnXk90qka5PgM0cb3/ERyMyZFdidj2PVG4P
         98w1X+BXNeJvfSTodPEjYdWZFZeQzbM2dtyFRUZFOscPBCKKy/wpmfR43exzR+HiJigp
         rh4/V12+jv6/88sACfbDEruPRyaZBCUP9EhpbU9jWB/j+4DNIeTgxmC///qPciuvHcI/
         OpgPmCYvv8TqVc4fiQ+JWc63VaHShMPHCd6NDkNtqnSWKtDrdv5l9JiEOswU8ff9ChjG
         MY14GrzblGyq/7GsjJCstLJBN1fdBlJ2Zf5zMv4BJdjbqQyGzrizbj9jFJSyRPQmULpt
         8C+g==
X-Forwarded-Encrypted: i=1; AJvYcCV8U6MfKFyLEBt8FnCKv3HiUJqI0J2XCdz7iz6ol9xm2AQld5uyny8sgnJTJcpz0yumJcY27KCo82YQ@vger.kernel.org, AJvYcCVfIxa+jDve/e7ktzSTHYBtvGBxDB16NzcpvMJxdCSsvsqicfVXEYzY614h3418Mkv98H1eLtAqBMkiPJORy2D9dh0=@vger.kernel.org, AJvYcCVlGEZfUqYvj2QJ6kEoctNR5xnWRpz3acJ0eUtRG+qOCHJwf1UHcNbkV8n9fXRxq7FMySsXPFzyq2EaOvLT@vger.kernel.org, AJvYcCWTlIj7ynjXLN8qsZuJNIq3eK+rmFnDNFHgYHZlmSGPF1f61qdzzxYuRedQHud2R7tEoQNlVaCV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ysIml5Mk3B3PXTCGetjlhBHKhIbnGcwA58Z9XC1EhCC5pEIS
	LwMPcymBCcQIHCb/vmuMT8xpE9aKE8mii1KasfGBb8VdCVnK0l+WOePPZBbR
X-Gm-Gg: ASbGncsMWJblpi7D7uL4SqIM6BDi47OralO621+RTPijCN+pYLXtXXL1if1nFM2ISw1
	5T2CwfbuQzKbLDKSEQ9qtcYrFzPnVZQZJHQIuMWBh9xwcbp7OOzANg/edBuMY7exQw8wgMCYZRD
	FqeLa6YRha4L6b2oxOIavm2uGL/URavYLZbugH2Ea4Ka28iOtejk+u5BWQXjvLsBy9OPWs872of
	pOlhXc6qIjaRbbiFrUnNnyblyuJ9AfpyXG9KCcQrrEADj/nwKRuuun9Jl8SysCa3mI7JqEsMXXM
	iYNnDC+sLUIpugFspEsZn+6hr/vkmaG0oxtDR90sN0Q7tz082D7gXkO92Nz+XRNO8QG9Qzgndyc
	LnK/lCMM=
X-Google-Smtp-Source: AGHT+IFwwEwdoibEPNyIJoSsMOSEcyoA3IYhqXdgxg8vWiKueAMO9jJvFjxo2atT96bygP6CrBdCMg==
X-Received: by 2002:a05:6102:3a65:b0:4c1:9ecd:b250 with SMTP id ada2fe7eead31-4c19ecdcb1cmr813504137.5.1740998428785;
        Mon, 03 Mar 2025 02:40:28 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c17e90cf5csm1082975137.3.2025.03.03.02.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 02:40:27 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86718541914so4406771241.1;
        Mon, 03 Mar 2025 02:40:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZTYS7ipsmaPBuDels12ewpHS4+ZWfkP/lO4OSvDUm8dc0LNBg5iG7zVIlVpim6WJPLDgfEr9Hfap45BXE@vger.kernel.org, AJvYcCVIAinCCltIbPZimzTR0OSncfBvxdaVX5fYj9n2QkWWAhPSinc6UC4glZ+LtsklswP+n4k390S+@vger.kernel.org, AJvYcCWniliZqvo+Ihj2NEtAwuqSq3rR7cmXPT9LdKpCjhGxdPh5RGt4XRrbQGasP8RJiojXezgBETCTIjEWAgEfNpNXwdw=@vger.kernel.org, AJvYcCWyQth0XikRHX3bWhrX7DNiClaq9TroMFyRQbYTF/+XZSvwwd5tEhfbE6ycW3nuLbLHqytgwSivDt1O@vger.kernel.org
X-Received: by 2002:a05:6102:2a42:b0:4c0:435b:5dd2 with SMTP id
 ada2fe7eead31-4c0435b5ebdmr6337617137.1.1740998427518; Mon, 03 Mar 2025
 02:40:27 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302181808.728734-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20250302181808.728734-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250302181808.728734-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Mar 2025 11:40:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV8GqnhsJg7J7keGvT=Dvj_w0hZOiuZqCa=tiUgLE8Vtg@mail.gmail.com>
X-Gm-Features: AQ5f1Jpv15ql5krxTjLeAExxOGaKNBovwnzhgUjXQ5dDEMa9JTfxXPA61zZ_Iv0
Message-ID: <CAMuHMdV8GqnhsJg7J7keGvT=Dvj_w0hZOiuZqCa=tiUgLE8Vtg@mail.gmail.com>
Subject: Re: [PATCH 3/3] net: stmmac: Add DWMAC glue layer for Renesas GBETH
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6frH1FJWzG0Yt
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717541.49604@/ud/6VsJAZhWgsWjhqqEoQ
X-ITU-MailScanner-SpamCheck: not spam

Hi Prabhakar,

On Sun, 2 Mar 2025 at 19:18, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Renesas RZ/V2H(P) SoC is equipped with Synopsys DesignWare Ethernet
> Quality-of-Service IP block version 5.20. This commit adds DWMAC glue
> layer for the Renesas GBETH found on the RZ/V2H(P) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c

> +static int renesas_gbeth_probe(struct platform_device *pdev)
> +{
> +       struct plat_stmmacenet_data *plat_dat;
> +       struct stmmac_resources stmmac_res;
> +       struct device *dev =3D &pdev->dev;
> +       struct renesas_gbeth *gbeth;
> +       struct reset_control *rstc;
> +       unsigned int i;
> +       int err;
> +
> +       err =3D stmmac_get_platform_resources(pdev, &stmmac_res);
> +       if (err)
> +               return dev_err_probe(dev, err,
> +                                    "failed to get resources\n");
> +
> +       plat_dat =3D devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +       if (IS_ERR(plat_dat))
> +               return dev_err_probe(dev, PTR_ERR(plat_dat),
> +                                    "dt configuration failed\n");
> +
> +       gbeth =3D devm_kzalloc(dev, sizeof(*gbeth), GFP_KERNEL);
> +       if (!gbeth)
> +               return -ENOMEM;
> +
> +       plat_dat->clk_tx_i =3D devm_clk_get_enabled(dev, "tx");

drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c:52:17:
error: =E2=80=98struct plat_stmmacenet_data=E2=80=99 has no member named =
=E2=80=98clk_tx_i=E2=80=99

Also not in next-20250228.

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


