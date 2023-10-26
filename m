Return-Path: <netdev+bounces-44449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA27D800F
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 11:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B49B212D3
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725D128E08;
	Thu, 26 Oct 2023 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeLaPXBk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA827728;
	Thu, 26 Oct 2023 09:53:45 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D069E198;
	Thu, 26 Oct 2023 02:53:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-540105dea92so1003465a12.2;
        Thu, 26 Oct 2023 02:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698314022; x=1698918822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sKfBNadnTr56Xc/xg3ISbacdEoqQ0HVmsmGJG/4R2A=;
        b=MeLaPXBkmURCRH2aQt5dYiZFnZTn8kAAciJa1+nZhdaBSw8pRHn1O0PpouF2lkOAmm
         03VcDEmKFhnL/MCe97P63IGDv+8+Ceqh1gGS+ahCmypRiUb352Anql31eUs90Sllvpp7
         gqKrAdreKZdog5ncH/6lRcx35FcNEjXBJCRgtQ7cIfQ3U70vupxudz+pXNOZMjgTvolg
         SELAStw90fAs3ZqgqXZfYypKOQWy44UU9/xOuLOC/Tg64M0E5x6Jp7HZhdY82hL+HFJv
         h++gdQ2woiSxVmZEljPMeOwqwTrZIifAgeK5cJXy7/lt6GA3+iiKlQ/H9YGmd0cLNSp1
         0U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698314022; x=1698918822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sKfBNadnTr56Xc/xg3ISbacdEoqQ0HVmsmGJG/4R2A=;
        b=wHimgLqYVk2NfXhsomJ6P95utbpbiWKjrx5O9DDDlmKR9N8k8y7ax8/5SgwLFJk4wh
         ZCPrAkwqmS/YX/CBDSnxUh1h7hXsTKWRs79SZcnUnkSoPkxLlJwCxeukLCt9NIQErutY
         SH0Y/njjhLkY6wIQ3Wsn5TRW4hqxnH4LXaIQndkJ5bfU9sLxUPm8QG0nZaGZoXYnKw8o
         2gD33b+MqMYaETFDwsNCtvqEer4sIAMM6oeXMRo0pwR6BjD5IqVK+E/cyLcsccG1M30I
         heJ52UiGYXBFY8K0IcTNy916TKZvMYVt2lHFZKk7kMLLZB5miIq1w5wwIYytpfYlJ11b
         zQSw==
X-Gm-Message-State: AOJu0Yz+jHS/q/TwOIXW0tLylXQ+2Utk+ztIL7xZ4355s0miXgRBLfRs
	r9lVObgQHDYZjquQQ/zuVKs=
X-Google-Smtp-Source: AGHT+IG4j7BhGIqb7pQU9bz8m7JoS9pzA5FPWz2L+Tu7Yi1Zr1/NmpbNW3tpJspHBT43ihjJhJubDg==
X-Received: by 2002:a17:907:789:b0:9b6:5b56:bbe3 with SMTP id xd9-20020a170907078900b009b65b56bbe3mr14024428ejb.72.1698314021897;
        Thu, 26 Oct 2023 02:53:41 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id j14-20020a1709064b4e00b009ad778a68c5sm11494190ejv.60.2023.10.26.02.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:53:41 -0700 (PDT)
Date: Thu, 26 Oct 2023 12:53:38 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v8 3/5] net: dsa: microchip: Add error handling
 for ksz_switch_macaddr_get()
Message-ID: <20231026095338.o6v6wzrjoyci72jk@skbuf>
References: <20231026051051.2316937-1-o.rempel@pengutronix.de>
 <20231026051051.2316937-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026051051.2316937-4-o.rempel@pengutronix.de>

On Thu, Oct 26, 2023 at 07:10:49AM +0200, Oleksij Rempel wrote:
> Enhance the ksz_switch_macaddr_get() function to handle errors that may
> occur during the call to ksz_write8(). Specifically, this update checks
> the return value of ksz_write8(), which may fail if regmap ranges
> validation is not passed and returns the error code.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  drivers/net/dsa/microchip/ksz_common.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 0c3adc389d0b..00be812bef40 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3640,7 +3640,7 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
>  	struct ksz_switch_macaddr *switch_macaddr;
>  	struct ksz_device *dev = ds->priv;
>  	const u16 *regs = dev->info->regs;
> -	int i;
> +	int i, ret;
>  
>  	/* Make sure concurrent MAC address changes are blocked */
>  	ASSERT_RTNL();
> @@ -3667,10 +3667,20 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
>  	dev->switch_macaddr = switch_macaddr;
>  
>  	/* Program the switch MAC address to hardware */
> -	for (i = 0; i < ETH_ALEN; i++)
> -		ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
> +	for (i = 0; i < ETH_ALEN; i++) {
> +		ret = ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
> +		if (ret)
> +			goto macaddr_drop;
> +	}
>  
>  	return 0;
> +
> +macaddr_drop:
> +	dev->switch_macaddr = NULL;
> +	refcount_set(&switch_macaddr->refcount, 0);

Nitpick: this line doesn't do any harm, but it doesn't do any good, either.
It can be removed in a follow-up patch.

> +	kfree(switch_macaddr);
> +
> +	return ret;
>  }
>  
>  void ksz_switch_macaddr_put(struct dsa_switch *ds)
> -- 
> 2.39.2
> 

