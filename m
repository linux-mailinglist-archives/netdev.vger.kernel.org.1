Return-Path: <netdev+bounces-42743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E86547D0086
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FB61C20F73
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1EB34183;
	Thu, 19 Oct 2023 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clO4a30B"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306832C9F;
	Thu, 19 Oct 2023 17:29:59 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E86ACF;
	Thu, 19 Oct 2023 10:29:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so12581454a12.2;
        Thu, 19 Oct 2023 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697736596; x=1698341396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFKgH9n9+SxqUDiw0yxHqyCrok+3OXMJXcFzWxHubbI=;
        b=clO4a30BUdTEc4Jed7+M5AVHUI8M6DP/ug0TXCDnfJ1N5m7QXS6sq5rYhRVbl7MgvD
         5KVjf6u7cvpp4aLfQLmg17uPvBYnP+FxIv8Gf2Ohp5NnAa61NaOBYNBCvKXxEWwN048k
         laikaIdqpGQxlYZEnUgNdz+Qo+lEU6s2xKnIcyxPo9fNYekc/mk7b7m3m5mNiuWs3PEW
         Sp0E7dodRpbDXLk621686sIvxL90F+eTEZ0V9vsMjfxiy5ibw+5/hi9N/SEM25hhYgcF
         BB2M68cpcrjV7YrlIG6xMDHCuoCzAHuzPFjbE6gi63AkUFW06Vpqi7mihgWn2rsVNDcC
         Ns6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736596; x=1698341396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFKgH9n9+SxqUDiw0yxHqyCrok+3OXMJXcFzWxHubbI=;
        b=PeONBVWhyIyC5LkvTPZaVK9jrXTb+eRR0ESr3Fcirw4QJkqqPtcYY+9xetl/zaSElc
         YDQV//qBweZOztesx3IA+hvJMV/XdMPwKr4D/SoxcRoolt9hrTKnqxi2eo+f7iy2MNSz
         UF5YEzsgWCb6I8aHjc86WRCHV0RxY1LxyhcAL1joSS6OweKVAH/hxoMbZ1zLx13SA0st
         9FlJLl4LCLuCd9ubuICcrHrnR/fs3cOY0It5qIWwOvmHYaGszWtIAf0Af8etEv5UDUPe
         6J5nI55/IEXEyepzy5eWPWeXupNBw6Xo8hfwsZY6byNAwUsVA8T6yt7S8j4IP5tBQNVe
         rdFQ==
X-Gm-Message-State: AOJu0YyyBBgbq18yGKNY0vjySbWomWpoFDjv/f4SeatWVmYxDrcP1xzg
	wZynfl+VcE+b+4YEB4im4i8=
X-Google-Smtp-Source: AGHT+IH7ukcv4XB+jdwSZlR2vWC+v5ygQdoEvsIOBTIEs5IhWAS5GvrNrMMcp0/utmcgiTBtb4iXXg==
X-Received: by 2002:a17:907:6e9e:b0:9bf:9f04:e63b with SMTP id sh30-20020a1709076e9e00b009bf9f04e63bmr3046231ejc.23.1697736596467;
        Thu, 19 Oct 2023 10:29:56 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906190e00b0099b7276235esm3837508eje.93.2023.10.19.10.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:29:56 -0700 (PDT)
Date: Thu, 19 Oct 2023 20:29:53 +0300
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
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <20231019172953.ajqtmnnthohnlek7@skbuf>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>

On Thu, Oct 19, 2023 at 02:28:46PM +0200, Oleksij Rempel wrote:
> Introduce Wake on Magic Packet (WoL) functionality to the ksz9477
> driver.
> 
> Major changes include:
> 
> 1. Extending the `ksz9477_handle_wake_reason` function to identify Magic
>    Packet wake events alongside existing wake reasons.
> 
> 2. Updating the `ksz9477_get_wol` and `ksz9477_set_wol` functions to
>    handle WAKE_MAGIC alongside the existing WAKE_PHY option, and to
>    program the switch's MAC address register accordingly when Magic
>    Packet wake-up is enabled. This change will prevent WAKE_MAGIC
>    activation if the related port has a different MAC address compared
>    to a MAC address already used by HSR or an already active WAKE_MAGIC
>    on another port.
> 
> 3. Adding a restriction in `ksz_port_set_mac_address` to prevent MAC
>    address changes on ports with active Wake on Magic Packet, as the
>    switch's MAC address register is utilized for this feature.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/ksz9477.c    | 60 ++++++++++++++++++++++++--
>  drivers/net/dsa/microchip/ksz_common.c | 15 +++++--
>  drivers/net/dsa/microchip/ksz_common.h |  3 ++
>  3 files changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index b9419d4b5e7b..bcc8863951ca 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -81,7 +81,8 @@ static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
>  	if (!pme_status)
>  		return 0;
>  
> -	dev_dbg(dev->dev, "Wake event on port %d due to: %s %s\n", port,
> +	dev_dbg(dev->dev, "Wake event on port %d due to: %s %s %s\n", port,
> +		pme_status & PME_WOL_MAGICPKT ? "\"Magic Packet\"" : "",
>  		pme_status & PME_WOL_LINKUP ? "\"Link Up\"" : "",
>  		pme_status & PME_WOL_ENERGY ? "\"Enery detect\"" : "");

Trivial: if you format the printf string as %s%s%s and the arguments as
"\"Magic Packet\" " : "", then the printed line won't have a trailing
space at the end.

>  
> @@ -109,10 +110,22 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
>  
>  	wol->supported = WAKE_PHY;
>  
> +	/* Check if at this moment we would be able to get the MAC address
> +	 * and use it for WAKE_MAGIC support. This result may change dynamically
> +	 * depending on configuration of other ports.
> +	 */
> +	ret = ksz_switch_macaddr_get(dev->ds, port, NULL);
> +	if (!ret) {
> +		wol->supported |= WAKE_MAGIC;
> +		ksz_switch_macaddr_put(dev->ds);

I don't get it, why do you release the reference on the MAC address as
soon as you successfully get it? Without a reference held, the
programmed address still lingers on, but the HSR offload code, on a
different port with a different MAC address, can change it and break WoL.

> +	}
> +
>  	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl);
>  	if (ret)
>  		return;
>  
> +	if (pme_ctrl & PME_WOL_MAGICPKT)
> +		wol->wolopts |= WAKE_MAGIC;
>  	if (pme_ctrl & (PME_WOL_LINKUP | PME_WOL_ENERGY))
>  		wol->wolopts |= WAKE_PHY;
>  }

