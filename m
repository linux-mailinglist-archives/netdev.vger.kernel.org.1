Return-Path: <netdev+bounces-241155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F02C80985
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97DBA345898
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AC9296BAA;
	Mon, 24 Nov 2025 12:52:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF61F4CB3
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988775; cv=none; b=LIeynLg4lF9Vga0iwk/vL8GnzR8Okt0I2necpZHOv4i7RpyVbDEvIA4J75wicddAOgh6sr+iAHzG3Ycd0yvjMEiEwLOvGX4p26jAWlXlEdy3Os6NVrdT8oY4S5NrjJJmVdKKUhXNX18Co7Pnq0Yx1N4nI/WELbZLKEboUsfFt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988775; c=relaxed/simple;
	bh=6ikZIvAH9OCQ6Wns4/V7XjJocQUcbG50xgS5dfJhh50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDjsxeTGUV4/4b7zD+K14kVvIxyf1/3Va/0DWgnp8YOG469gPgNcytCYO0VpnDvgvf/2ipdwntBAhHBr/GeOyr6xym+pjW1v0e7FhPVyTNbz1NKF72IzMa18FdpthwtVU3uKGiPlfzkWDc2ZHvtvDHr+cgmQJdrR3zvpQCjhaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8823e39c581so65825216d6.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 04:52:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763988773; x=1764593573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD+BMZYNAgwSb9OdW8YWeL8m3yDdVApXfLl44Yo7CPA=;
        b=SQE1yZIh6d1dgAt0sm9F1xX1KgPlOCTcE6SYesjErisB3yYZW/1u9pC2T4xN3LNDY7
         Hxen5CrjBUoMEmIU/XXmKEKgmO/Dw9487gh0drInmoj0DTMU88990wYEYAE+6QpHoutu
         ZvkzdoWZ6vNACke6FmE1xYWJ69VkvevXlQlTg/n8nro7SpIFLgwB4nEsPG/Pd4EGdQm8
         gN1gfHrbTVUNYuA/MESXUxih6lnCtz61DsEuqKcbJtr4K5gp8Gw/QFXE6UpU+ANpvz/z
         NIcbo2euEw6dGWechUcmHE1M3a5RBR+/88NzHtp1u4E94Zf8+IbNY1xDb5SAJ2SHg1d/
         D1sA==
X-Forwarded-Encrypted: i=1; AJvYcCVlhBGm9il/ogn+b7g5N41EKQyVqy60Srry5DDCwTG15BYvWl4LfqMxlwX7MzaUwb2CskQGkUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhMMywW/n0R9Ebr71kVla1uVaRAhF1pXsNCXQR+LsV0PSV7aj
	DrZ4ZTgfl4GbwM/ZFne+8Ksv4X+/Qlm7RwugpR2T8DPQOLIiTe1wzwuAVrmfeBkx
X-Gm-Gg: ASbGncseZ4rEtoXq1ZNrPIcG02n0sQAsMaob0TF8zj4mPfiuaLNd1YxZslbTt6X1LZW
	VCezwS+UvKLnWnUXM0Yz+90WF3WqcY8U0RJEiVbCaU6qimeWASH7sNR0vJqvTzp7F90g4nnXbvR
	vx5hokQ1BHN6GNfh8ldVj552g/DnR6KbdeMUrpOAlix/nQv4bmzyu2f1NE0tsSf43BqY2PeT+/W
	VSi/3iotBC9fVFNiqfX9doyPpUQQEZZpVm1quu2yZpZGPs5wUKzlsLVf6+PBhj+t6g3Dc8vGJsY
	OSZYIew/vE2PgxJo0X9JLJBsEsGVLwjoRFoZfNRvG81ZBHVftBdZVI42lL18ONoe2VuThgPM+jL
	VK8IQn0agwIjQQ1/b9XXvQWqzrjT0kt4qDCrekLOzX5M8EctYIpEm7IMMfEumB39/XPPihT89ce
	4/u5ga3agkhY5rudS26siDYgq3BTXK0r1fSU+s/YztIJtwzpcpAb02
X-Google-Smtp-Source: AGHT+IHaCDOPyQe4iUQyOt7K/+bdVO4SsGSQ2ZFWg0/VfJUebiyjE1/ZV/Y7mtuY/J9DeWUrnMpOzA==
X-Received: by 2002:a05:622a:1386:b0:4ed:542:bb38 with SMTP id d75a77b69052e-4ee58af89e4mr169789531cf.74.1763988772584;
        Mon, 24 Nov 2025 04:52:52 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e90b62sm85179641cf.34.2025.11.24.04.52.52
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 04:52:52 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2148ca40eso595105985a.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 04:52:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuc7EyEoCzLXDLMAR/TeujLZo8tRHGUqsqzy/jtYDSe2Uy2XNDBvPvaSAmAP95pUV+UBTN9h0=@vger.kernel.org
X-Received: by 2002:a05:6102:3594:b0:5db:23d0:65e7 with SMTP id
 ada2fe7eead31-5e1de3b25d5mr3839254137.27.1763988343849; Mon, 24 Nov 2025
 04:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251121113553.2955854-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251121113553.2955854-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Nov 2025 13:45:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXrkt0MXOBSvpdJwNVmGrnmt03mSGqj7EhqF16tf4i5Pg@mail.gmail.com>
X-Gm-Features: AWmQ_bkVR2IR-2-tuIChhhpMAiosiEEmcPQoTdpPEz707calSo8UIsTYAGe2Ino
Message-ID: <CAMuHMdXrkt0MXOBSvpdJwNVmGrnmt03mSGqj7EhqF16tf4i5Pg@mail.gmail.com>
Subject: Re: [PATCH net-next 06/11] net: dsa: rzn1-a5psw: Add support for
 optional timestamp clock
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Fri, 21 Nov 2025 at 12:36, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add support for an optional "ts" (timestamp) clock to the RZN1 A5PSW
> driver. Some SoC variants provide a dedicated clock source for
> timestamping or time synchronization features within the Ethernet
> switch IP.
>
> Request and enable this clock during probe if defined in the device tree.
> If the clock is not present, the driver continues to operate normally.
>
> This change prepares the driver for Renesas RZ/T2H and RZ/N2H SoCs, where
> the Ethernet switch includes a timestamp clock input.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!


> --- a/drivers/net/dsa/rzn1_a5psw.c
> +++ b/drivers/net/dsa/rzn1_a5psw.c
> @@ -1243,6 +1243,13 @@ static int a5psw_probe(struct platform_device *pdev)
>                 goto free_pcs;
>         }
>
> +       a5psw->ts = devm_clk_get_optional_enabled(dev, "ts");
> +       if (IS_ERR(a5psw->ts)) {
> +               dev_err(dev, "failed get ts clock\n");

I think the error can be -EPROBE_DEFER, so this should use
dev_err_probe() instead. Same for the existing calls.

> +               ret = PTR_ERR(a5psw->ts);
> +               goto free_pcs;
> +       }
> +
>         reset = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
>         if (IS_ERR(reset)) {
>                 ret = PTR_ERR(reset);

> --- a/drivers/net/dsa/rzn1_a5psw.h
> +++ b/drivers/net/dsa/rzn1_a5psw.h
> @@ -236,6 +236,7 @@ union lk_data {
>   * @base: Base address of the switch
>   * @hclk: hclk_switch clock
>   * @clk: clk_switch clock
> + * @ts: Timestamp clock
>   * @dev: Device associated to the switch
>   * @mii_bus: MDIO bus struct
>   * @mdio_freq: MDIO bus frequency requested
> @@ -251,6 +252,7 @@ struct a5psw {
>         void __iomem *base;
>         struct clk *hclk;
>         struct clk *clk;
> +       struct clk *ts;

"ts" is only used inside a5psw_probe(), so it can be a local variable.

>         struct device *dev;
>         struct mii_bus  *mii_bus;
>         struct phylink_pcs *pcs[A5PSW_PORTS_NUM - 1];

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

