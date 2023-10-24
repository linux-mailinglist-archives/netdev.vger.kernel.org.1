Return-Path: <netdev+bounces-44007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEE37D5CE7
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB6328135E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836493CCF9;
	Tue, 24 Oct 2023 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9yFFu6z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980715B4
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:09:24 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0787910D4
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:09:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ca3a54d2c4so41333595ad.3
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698181763; x=1698786563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XPxyuokscMQFf3r8r+DIj+U452MgFtA2dXbD8svgIM=;
        b=E9yFFu6zhHmLhKWoIFbhMzAuPPAINNCltlcTOHE1qhMza5OXUFRWGuIt/t0JUZVq4X
         +LnbtI9H+0Bmg4jrIbH/yYECUCpIeXUeYNyZ2uBdxBTgAMa/489Ok+Xmp6l0dKFdEMAr
         dgfHz1MXvkaNX6IYsZ8Ucu3M3pyXCGbqZXDGbWIFrFoUKRhANtVaS7E9/3x/ka5HI7lg
         jjP3dGRxI4VN7WH0s3oGdeq79s44ZNQ5E1nCE2w2b40fax66VGSX+25gSw1T/PwJI62B
         whkn0oOVy7TbqpfifO+/QR7aVQ+JAO5xBVePfbmBDstAR2SqS8eo4t2Z5GR+SMamc7NY
         QdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698181763; x=1698786563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XPxyuokscMQFf3r8r+DIj+U452MgFtA2dXbD8svgIM=;
        b=j/wocmNEBEnpoaTmUmGto9C5Jf3gwKyCgb8EbvNSUTfojoCGgLeMU8xb9cTqcJI6Zn
         Dz6k+XPhFBlablPqaK4bp65YuZlEjUB9P0x7imlhRxoZs5nAYRy7zLkFL6tzsApNQDY4
         L97juxTolg3vnduqnxbQaxthJFP6m0S4csGI4FoKJldk5ydeG9WdVLuRze6qp28KPAHq
         Fh0xZgI6A8psNR21Kx8uT65nu0lD0v4w2Bpp+7fx4HDLzHWx/oPHrq1khc11JH17Rzj+
         miLGeh5KOWyJ132fqp35nBIEozczn+yZ96KUe9yQ5COqtoGzqcGiha8heqIhbk/d4AIH
         yTLA==
X-Gm-Message-State: AOJu0YyYl4dZdesbhzcnsf6f+px90sR7H8qqwy4GlL/3fye68Pfo6I5M
	VTPvRc6Mp/HtufzQLteqQA4=
X-Google-Smtp-Source: AGHT+IFmIfO3GrsoRmM26b5J2scXaSPf8Y7BjyoTUFeGD/g6mmaIZau77M2Ekvnk2dkZkloN52r8aw==
X-Received: by 2002:a17:903:d4:b0:1c9:97b7:b3d5 with SMTP id x20-20020a17090300d400b001c997b7b3d5mr10980920plc.45.1698181763384;
        Tue, 24 Oct 2023 14:09:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id jk4-20020a170903330400b001c5fd2a28d3sm7824524plb.28.2023.10.24.14.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 14:09:22 -0700 (PDT)
Message-ID: <809d24bf-2c1b-469c-a906-c0b4298e56a0@gmail.com>
Date: Tue, 24 Oct 2023 14:09:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: support reset controller
Content-Language: en-US
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 vivien.didelot@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, krzk+dt@kernel.org,
 arinc.unal@arinc9.com
References: <20231024205805.19314-1-luizluca@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024205805.19314-1-luizluca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 13:58, Luiz Angelo Daros de Luca wrote:
> The 'reset-gpios' will not work when the switch reset is controlled by a
> reset controller.
> 
> Although the reset is optional and the driver performs a soft reset
> during setup, if the initial reset state was asserted, the driver will
> not detect it.
> 
> This is an example of how to use the reset controller:
> 
>          switch {
>                  compatible = "realtek,rtl8366rb";
> 
>                  resets = <&rst 8>;
>                  reset-names = "switch";
> 
> 		...
> 	}
> 
> The reset controller will take precedence over the reset GPIO.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>   drivers/net/dsa/realtek/realtek-mdio.c | 36 +++++++++++++++++++++-----
>   drivers/net/dsa/realtek/realtek-smi.c  | 34 +++++++++++++++++++-----
>   drivers/net/dsa/realtek/realtek.h      |  6 +++++
>   3 files changed, 63 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index 292e6d087e8b..600124c58c00 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -140,6 +140,23 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
>   	.disable_locking = true,
>   };
>   
> +static int realtek_mdio_hwreset(struct realtek_priv *priv, bool active)
> +{
> +#ifdef CONFIG_RESET_CONTROLLER
> +	if (priv->reset_ctl) {
> +		if (active)
> +			return reset_control_assert(priv->reset_ctl);
> +		else
> +			return reset_control_deassert(priv->reset_ctl);
> +	}
> +#endif

Empty stubs are provided when CONFIG_RESET_CONTROLLER is disabled, and 
if you switch to using devm_reset_control_get() then you will get a NULL 
reset_control reference which will be a no-op for all of those operations.
-- 
Florian


