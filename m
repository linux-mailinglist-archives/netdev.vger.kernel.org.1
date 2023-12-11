Return-Path: <netdev+bounces-55681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985B080BF6A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 03:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F771C2089B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862A415495;
	Mon, 11 Dec 2023 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku7Os8NR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA751BC6
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 18:50:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bce78f145so4473407e87.0
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 18:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702263046; x=1702867846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNTdlhKPOpcCfnnKOcOQH+xUH2YOWzC/u7MDpXunjGA=;
        b=Ku7Os8NRaHFjCd0kCsh80hy5pCb7qp+d4idIs9rD8n9V3A82vz3YqAYtE2aGQYQlam
         4PCMPO9y+bCw40Nxl8gsOBtdxWsm0Nx3CW352fkOYtm6mzmTrrIaQCNlpZcYD+UHg9xY
         hoF2gwfvTKVrSOZbgqnNWVIYLiuRc3qKeRq1lrR5TqN6dEdDgofUAB6uYWrIHXP2FnrN
         hTKnXtRw0ZM410cVPhlYS9za1V570NJcSmOUwPHDbVMaJXqUZa9n6GYZnVMLj4cyp0Gs
         XQ5zJnLBltsQ+tDPNH1pl+YPZ+fB9Dv7QUrHm87A/AkGa4FZedg6UdWUk+K0WNWIREE8
         AUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702263046; x=1702867846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNTdlhKPOpcCfnnKOcOQH+xUH2YOWzC/u7MDpXunjGA=;
        b=eWh8/gvCZEghAEm5PXAlLgDZSnaufVfItxvbD6wCv8GVczTGoS86pBKsG1uQJrclVg
         8qxq63ChvOSVQQL/BFTetjXqjktRjf918fWeM09Zbp6tppS89pe19e3b4uQ9Fiq5ppQr
         /onAahbIZw6lpehCWm5V/QNdOlnBUwnzc8ge0nZ72JUUfGhwVkQwOGr4bj7JGBTvvSCB
         pYnARP6kfkmgZMTdK732LCHq4zkY58MadbgM3zUsgfv8Ls5XfqpmmMm8kodu0bkaXSwA
         BwQltBbl95ZKnFJJfXggqgvcTkxLSPf6O45ASp7aWVWsbVWOL33biIoTGFQCXIwyHUii
         ekPQ==
X-Gm-Message-State: AOJu0Yx1ScBt8MsdqS8M1AnZSfLquWdFGbdMRew0WCuxBSMJokSFbj23
	N+4SOLI76YZdUKp2Rzj36fbH4yjfV6lFX4dawKg=
X-Google-Smtp-Source: AGHT+IEV181f++J0q+7XvbplvaqiLzcEDK8roGcdP3HxF6NzUSzycEoe06zLiv08LAmxEvwGXjTJkEnd56kVcRYJkIs=
X-Received: by 2002:a05:6512:40d:b0:50c:f7a:befd with SMTP id
 u13-20020a056512040d00b0050c0f7abefdmr849577lfk.21.1702263046203; Sun, 10 Dec
 2023 18:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org> <20231209-rtl8366rb-mtu-fix-v1-1-df863e2b2b2a@linaro.org>
In-Reply-To: <20231209-rtl8366rb-mtu-fix-v1-1-df863e2b2b2a@linaro.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 10 Dec 2023 23:50:35 -0300
Message-ID: <CAJq09z6PLo7YhON57YwVWwbHNZQZg_2VK5e=W=Zc2YUEo3Kt_Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: Rename bogus RTL8368S variable
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em s=C3=A1b., 9 de dez. de 2023 =C3=A0s 19:37, Linus Walleij
<linus.walleij@linaro.org> escreveu:
>
> Rename the register name to RTL8366RB instead of the bogus
> RTL8368S (internal product name?)
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

> ---
>  drivers/net/dsa/realtek/rtl8366rb.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realte=
k/rtl8366rb.c
> index b39b719a5b8f..887afd1392cb 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> @@ -117,10 +117,11 @@
>         RTL8366RB_STP_STATE((port), RTL8366RB_STP_MASK)
>
>  /* CPU port control reg */
> -#define RTL8368RB_CPU_CTRL_REG         0x0061
> -#define RTL8368RB_CPU_PORTS_MSK                0x00FF
> +#define RTL8366RB_CPU_CTRL_REG         0x0061
> +#define RTL8366RB_CPU_PORTS_MSK                0x00FF
>  /* Disables inserting custom tag length/type 0x8899 */
> -#define RTL8368RB_CPU_NO_TAG           BIT(15)
> +#define RTL8366RB_CPU_NO_TAG           BIT(15)
> +#define RTL8366RB_CPU_TAG_SIZE         4
>
>  #define RTL8366RB_SMAR0                        0x0070 /* bits 0..15 */
>  #define RTL8366RB_SMAR1                        0x0071 /* bits 16..31 */
> @@ -912,10 +913,10 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
>
>         /* Enable CPU port with custom DSA tag 8899.
>          *
> -        * If you set RTL8368RB_CPU_NO_TAG (bit 15) in this registers
> +        * If you set RTL8366RB_CPU_NO_TAG (bit 15) in this register
>          * the custom tag is turned off.
>          */
> -       ret =3D regmap_update_bits(priv->map, RTL8368RB_CPU_CTRL_REG,
> +       ret =3D regmap_update_bits(priv->map, RTL8366RB_CPU_CTRL_REG,
>                                  0xFFFF,
>                                  BIT(priv->cpu_port));
>         if (ret)
>
> --
> 2.34.1
>
>

