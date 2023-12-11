Return-Path: <netdev+bounces-55685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CC680BFBF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 04:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A989280C1A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 03:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB415AF7;
	Mon, 11 Dec 2023 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMRPUcmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE829D
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:14:53 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bf37fd2bbso5141538e87.0
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702264491; x=1702869291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dt0zuupP+ohC9RzBBk25aI8KsFg2z2sq2OKR+xgeiCY=;
        b=iMRPUcmY/LYSsjbAO9XTDWTpiKD3DkMWgLRQnGQY5G0k0YDec6R+6ZxmzT690N3lkh
         70UaMjXvfAdTOxb0HVgb6sPzrbgVz4FeNCH6C7YhXjZb6QtLU8NoU4ARpqygt6qWkvxz
         BcjoYFER00eik3311NslXVocbsMnYohFv2SmkCHG/t9o1z9necxolw3tI0Xj3gWJDj+G
         WNuEUNv2jYAusYbqaSRlxMatscC9yD81pUEcZAo/2xEhtyK9JyxpbWBQNJbJvAeOPzn1
         MBpuGfnn053cdJcnFy5r6yVpAp2WeO5KTKAgsJNZIl8YYv6yospValezXGA6gAcYipMB
         L0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702264491; x=1702869291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dt0zuupP+ohC9RzBBk25aI8KsFg2z2sq2OKR+xgeiCY=;
        b=QPN+b2H79GT3UkEqA7p4TgFq6rzPV2pzK/tlHjBLkB1KxP/qUqur0zZfx3352LXimW
         li6zJe+ky3oCKAfqFiZOV2ZK9+N+1YvrvUraOzIoZSGhjixAt2cVUT5PkJK+70KMCRTZ
         CL6Kt4FCQm6DyyLdEr89SMMg+tHbqiRNfl/JVeUE8S5m7IQTA4DRR9qPnCAYD+v1dm/4
         0dRKLT+r8gTXbIF+igcZBBlFp8zIvws8fozYcQFNxQORNUg8ncyL7DveaE7YcEs3y/fm
         Z1L7MJt6GHwp0JGx6ccsWr0+yn23tzHoPTcH4jYJcqaQqG3IBDZEXBuKCdP/mOwZdTTl
         ACFw==
X-Gm-Message-State: AOJu0YxhrE1ekrzXJ8evkVeX9B25ShcH7Oa1yQSDjc6gqrYZQ0Lnc9fp
	bWR3QlgZRvtZOzQNGbJqH2W30uxT6NbYgKmfVsA=
X-Google-Smtp-Source: AGHT+IE35u0R4TyBQ8tCLwZKDE6ohRIHshbN9HaM/IojXCrn8Id2PSNswfOHFj6bINZb/Lwl/V0jEfq+GjGbKqs4zH0=
X-Received: by 2002:a05:6512:3c9f:b0:50b:e20b:93eb with SMTP id
 h31-20020a0565123c9f00b0050be20b93ebmr2338976lfv.60.1702264490703; Sun, 10
 Dec 2023 19:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org> <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
In-Reply-To: <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 11 Dec 2023 00:14:39 -0300
Message-ID: <CAJq09z4fJmc9=CwdVSS_+LfOS9ax+voWrkPMwDmiBtrCwzc20A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: realtek: Rewrite RTL8366RB MTU handling
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The MTU callbacks are in layer 1 size, so for example 1500
> bytes is a normal setting. Cache this size, and only add
> the layer 2 framing right before choosing the setting. On
> the CPU port this will however include the DSA tag since
> this is transmitted from the parent ethernet interface!
>
> Add the layer 2 overhead such as ethernet and VLAN framing
> and FCS before selecting the size in the register.
>
> This will make the code easier to understand.
>
> The rtl8366rb_max_mtu() callback returns a bogus MTU
> just subtracting the CPU tag, which is the only thing
> we should NOT subtract. Return the correct layer 1
> max MTU after removing headers and checksum.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Don't we need a Fixes tag?

> ---
>  drivers/net/dsa/realtek/rtl8366rb.c | 48 +++++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
> index 887afd1392cb..e3b6a470ca67 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> @@ -15,6 +15,7 @@
>  #include <linux/bitops.h>
>  #include <linux/etherdevice.h>
>  #include <linux/if_bridge.h>
> +#include <linux/if_vlan.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqdomain.h>
>  #include <linux/irqchip/chained_irq.h>
> @@ -929,15 +930,19 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
>         if (ret)
>                 return ret;
>
> -       /* Set maximum packet length to 1536 bytes */
> +       /* Set default maximum packet length to 1536 bytes */
>         ret = regmap_update_bits(priv->map, RTL8366RB_SGCR,
>                                  RTL8366RB_SGCR_MAX_LENGTH_MASK,
>                                  RTL8366RB_SGCR_MAX_LENGTH_1536);
>         if (ret)
>                 return ret;
> -       for (i = 0; i < RTL8366RB_NUM_PORTS; i++)
> -               /* layer 2 size, see rtl8366rb_change_mtu() */
> -               rb->max_mtu[i] = 1532;
> +       for (i = 0; i < RTL8366RB_NUM_PORTS; i++) {
> +               if (i == priv->cpu_port)
> +                       /* CPU port need to also accept the tag */
> +                       rb->max_mtu[i] = ETH_DATA_LEN + RTL8366RB_CPU_TAG_SIZE;
> +               else
> +                       rb->max_mtu[i] = ETH_DATA_LEN;
> +       }
>
>         /* Disable learning for all ports */
>         ret = regmap_write(priv->map, RTL8366RB_PORT_LEARNDIS_CTRL,
> @@ -1442,24 +1447,29 @@ static int rtl8366rb_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>         /* Roof out the MTU for the entire switch to the greatest
>          * common denominator: the biggest set for any one port will
>          * be the biggest MTU for the switch.
> -        *
> -        * The first setting, 1522 bytes, is max IP packet 1500 bytes,
> -        * plus ethernet header, 1518 bytes, plus CPU tag, 4 bytes.
> -        * This function should consider the parameter an SDU, so the
> -        * MTU passed for this setting is 1518 bytes. The same logic
> -        * of subtracting the DSA tag of 4 bytes apply to the other
> -        * settings.
>          */
> -       max_mtu = 1518;
> +       max_mtu = ETH_DATA_LEN;
>         for (i = 0; i < RTL8366RB_NUM_PORTS; i++) {
>                 if (rb->max_mtu[i] > max_mtu)
>                         max_mtu = rb->max_mtu[i];
>         }

I'm not sure you need this old code. Whenever you change the MTU in a
user port, it will also call rtl8366rb_change_mtu() for the CPU port
if the max MTU changes. A call to change both the port and the CPU
port makes sense when you need to update something inside the switch
to set the MTU per port. However, these realtek switches only have a
global MTU size for all ports. What I did in rtl8365mb is to ignore
any MTU change except it is related to the CPU port. I hope this is a
"core feature" that you can rely on.

If that works for you, you can also drop the rb->max_mtu and the code
in rtl8366rb_setup(), calling rtl8366rb_change_mtu() for the CPU port
instead.

> -       if (max_mtu <= 1518)
> +
> +       /* Translate to layer 2 size.
> +        * Add ethernet and (possible) VLAN headers, and checksum to the size.
> +        * For ETH_DATA_LEN (1500 bytes) this will add up to 1522 bytes.
> +        */
> +       max_mtu += VLAN_ETH_HLEN;
> +       max_mtu += ETH_FCS_LEN;
> +
> +       if (max_mtu <= 1522)
>                 len = RTL8366RB_SGCR_MAX_LENGTH_1522;
> -       else if (max_mtu > 1518 && max_mtu <= 1532)
> +       else if (max_mtu > 1522 && max_mtu <= 1536)
> +               /* This will be the most common default if using VLAN and
> +                * CPU tagging on a port as both VLAN and CPU tag will
> +                * result in 1518 + 4 + 4 = 1526 bytes.
> +                */
>                 len = RTL8366RB_SGCR_MAX_LENGTH_1536;
> -       else if (max_mtu > 1532 && max_mtu <= 1548)
> +       else if (max_mtu > 1536 && max_mtu <= 1552)
>                 len = RTL8366RB_SGCR_MAX_LENGTH_1552;
>         else
>                 len = RTL8366RB_SGCR_MAX_LENGTH_16000;
> @@ -1471,10 +1481,12 @@ static int rtl8366rb_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>
>  static int rtl8366rb_max_mtu(struct dsa_switch *ds, int port)
>  {
> -       /* The max MTU is 16000 bytes, so we subtract the CPU tag
> -        * and the max presented to the system is 15996 bytes.
> +       /* The max MTU is 16000 bytes, so we subtract the ethernet
> +        * headers with VLAN and checksum and arrive at
> +        * 16000 - 18 - 4 = 15978. This does not include the CPU tag
> +        * since that is added to the requested MTU by the DSA framework.
>          */
> -       return 15996;
> +       return 16000 - VLAN_ETH_HLEN - ETH_FCS_LEN;
>  }
>
>  static int rtl8366rb_get_vlan_4k(struct realtek_priv *priv, u32 vid,
>
> --
> 2.34.1
>
>

