Return-Path: <netdev+bounces-45769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF697DF72C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 16:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA61C20ED8
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC491D529;
	Thu,  2 Nov 2023 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgLBuAWA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2E1D69F
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:57:09 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D62193
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 08:57:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso1868051a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698940626; x=1699545426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvCowQJSJm1whGqTVCCk9/+0nMBKi55ty4a9YvRCK2w=;
        b=DgLBuAWAqLthql2fgNy0YETo1/aD1bZlEVI03pZvIELkv+7nB5/FdXK3YUK3p2WRGI
         Wdo3Surqsrz1zRkK4TwHbjN3Vnff5p5bGawKqLBlYLW/i87Q1OEuwhDbWZQ1ZhMRHzBI
         o91yliwip6Br79Mk+SzlzN+LLgD3e6KfLJUZqK47QDqxjh/dBVZofdvz35A0v8syR99O
         5I+8ye7kHnVRgHn/sAXZA5DAj533LJYBJ0HcMFb5s+q43YicyFQWhGqbEAlhI9fYA3Jo
         Zs14Gyf9w5fE13OMWxnKx+RB8pvpinB0r+W4H/eB6jQ8tDZEWDpS8zp2O4lw+iz3iNHK
         x5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698940626; x=1699545426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvCowQJSJm1whGqTVCCk9/+0nMBKi55ty4a9YvRCK2w=;
        b=XsNiL3H4bXR+BVJ1uspq/SdRJQnpRBCYCXLCrrjYT5hzOR3YgnNdTGQJ5Z3nPMlIqk
         yy8nm3fi8cUoBhK3sqzE2mrrBeZ0EbP7WdPzpuyu/OwFJUY87HCN470ylghH3DQu6Yin
         svtw61zZmeXLl17wq90aCaNiA0bzH+6ObquFaHhV+u/5E5L7V1ZX0AhYmfX4QxbMbojv
         qhAK+mQO7sxG+vFv8+O6FnNbBDyKi+Wuv5MsgXStFwcY+fziI/E4ptl1Z0+vSF6qhvKD
         Dm5l2jyIMrc2jt6xaKlgirPRgbqvdm9Of5Gb3SCJzHGVeKAel92+0mAE+td4rk6sZ4zj
         tIkg==
X-Gm-Message-State: AOJu0Yz7NJpkyjvPVvzFnIOCbPlYCgmIE+BgQZuuKc4ifqLN2giLwN8P
	K+Dwy2qmKBL7bbgFZM6e5kk=
X-Google-Smtp-Source: AGHT+IHS6w68B51vYhWGQhAszTVy/Sx7clPyA8znn4ITWnaCgVu7SeOXycSl9LPshqJ+6hhtVhJy8A==
X-Received: by 2002:a50:c318:0:b0:543:cec6:c00b with SMTP id a24-20020a50c318000000b00543cec6c00bmr2818093edb.24.1698940626090;
        Thu, 02 Nov 2023 08:57:06 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7db4d000000b00533e915923asm33268edt.49.2023.11.02.08.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:57:05 -0700 (PDT)
Date: Thu, 2 Nov 2023 17:57:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
	alsi@bang-olufsen.dk, andrew@lunn.ch, vivien.didelot@gmail.com,
	f.fainelli@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org, krzk+dt@kernel.org,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset
 controller
Message-ID: <20231102155703.2itwweekjr7uqbsg@skbuf>
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf>
 <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
 <CACRpkdairxqm_YVshEuk_KbnZw9oH2sKiHapY_sTrgc85_+AmQ@mail.gmail.com>
 <20231102155521.2yo5qpugdhkjy22x@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102155521.2yo5qpugdhkjy22x@skbuf>

On Thu, Nov 02, 2023 at 05:55:21PM +0200, Vladimir Oltean wrote:
> diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
> index 060165a85fb7..857a039fb0f1 100644
> --- a/drivers/net/dsa/realtek/Kconfig
> +++ b/drivers/net/dsa/realtek/Kconfig
> @@ -15,39 +15,37 @@ menuconfig NET_DSA_REALTEK
>  
>  if NET_DSA_REALTEK
>  
> +config NET_DSA_REALTEK_INTERFACE
> +	tristate
> +	help
> +	  Common interface driver for accessing Realtek switches, either
> +	  through MDIO or SMI.
> +
>  config NET_DSA_REALTEK_MDIO
> -	tristate "Realtek MDIO interface driver"
> -	depends on OF
> -	depends on NET_DSA_REALTEK_RTL8365MB || NET_DSA_REALTEK_RTL8366RB
> -	depends on NET_DSA_REALTEK_RTL8365MB || !NET_DSA_REALTEK_RTL8365MB
> -	depends on NET_DSA_REALTEK_RTL8366RB || !NET_DSA_REALTEK_RTL8366RB
> +	tristate "Realtek MDIO interface support"

I meant to also make "config NET_DSA_REALTEK_MDIO" a bool and not tristate.

>  	help
>  	  Select to enable support for registering switches configured
>  	  through MDIO.
>  
>  config NET_DSA_REALTEK_SMI
> -	tristate "Realtek SMI interface driver"
> -	depends on OF
> -	depends on NET_DSA_REALTEK_RTL8365MB || NET_DSA_REALTEK_RTL8366RB
> -	depends on NET_DSA_REALTEK_RTL8365MB || !NET_DSA_REALTEK_RTL8365MB
> -	depends on NET_DSA_REALTEK_RTL8366RB || !NET_DSA_REALTEK_RTL8366RB
> +	bool "Realtek SMI interface support"
>  	help
>  	  Select to enable support for registering switches connected
>  	  through SMI.
>  
>  config NET_DSA_REALTEK_RTL8365MB
>  	tristate "Realtek RTL8365MB switch subdriver"
> -	imply NET_DSA_REALTEK_SMI
> -	imply NET_DSA_REALTEK_MDIO
> +	select NET_DSA_REALTEK_INTERFACE
>  	select NET_DSA_TAG_RTL8_4
> +	depends on OF
>  	help
>  	  Select to enable support for Realtek RTL8365MB-VC and RTL8367S.
>  
>  config NET_DSA_REALTEK_RTL8366RB
>  	tristate "Realtek RTL8366RB switch subdriver"
> -	imply NET_DSA_REALTEK_SMI
> -	imply NET_DSA_REALTEK_MDIO
> +	select NET_DSA_REALTEK_INTERFACE
>  	select NET_DSA_TAG_RTL4_A
> +	depends on OF
>  	help
>  	  Select to enable support for Realtek RTL8366RB.

