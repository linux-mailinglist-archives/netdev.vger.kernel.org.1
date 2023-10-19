Return-Path: <netdev+bounces-42734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C36C7CFFFD
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A9C2821E1
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2D2FE39;
	Thu, 19 Oct 2023 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG0jSdYw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A018C18;
	Thu, 19 Oct 2023 16:54:15 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE7312D;
	Thu, 19 Oct 2023 09:54:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9c603e235d1so517363766b.3;
        Thu, 19 Oct 2023 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697734452; x=1698339252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LnQzaD7UARmrsNP+XgiTfV7s8JM3EDm7yuLQmmghN7M=;
        b=LG0jSdYwli2aw8XpS1zSr7K59N/NXuRoinCNHC1DRuAzCcxobVwX9+BQWeum08gpbB
         Pj+zdPBSOIL1gJY20r2nzF9gpr8y4MTpxmgInpyILoEZmgVCwbs5xF9PzTeIq2omde4n
         iHZtD2hRpVaw8r3SbE3vpOeinSZmgPXv8k0YAAxFnvGL0Lcfm1XR28rt4m2D32NILOpt
         0NTXhOMR6DTFeXAgHOIIzPdUG7YpnUOic2o+b9Cz80XmavTgf2HoiQiC1eFSy0RvzIzw
         0FRRUZp487fywTUqdKY3ZgBvoffYR0MtX0vFgZv88Vy0W8E/yJ6O+slwzCtwdCkWtU0p
         KltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697734452; x=1698339252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnQzaD7UARmrsNP+XgiTfV7s8JM3EDm7yuLQmmghN7M=;
        b=mQc9D3gIpP/+lfeoboadTls7maYGwbEz0dELkU1KmF5NGjMmr33iTl7STvDhc6GCDn
         jJn+F24rnJLQV7NwFewPJTB72huBbLuYJEtRPF3dkL/2QTX7Ejq5+LV46AaycidYeEG4
         +elzF0Pzo7RD8MQROezINWTIxdcrujvdwQMbzxlLfEDayyf1sm8i8ldr7NBonpNVqHPt
         tbiX+320tjOfoSUgbAo01ntCNZvjhaEAB2lcbB8+8h6IXGx4J6A4HwVtseCDEWOBas8m
         DYly4j83bcPlzvWiP7Aca1Od9K/UR7txcn9gc2fV0I4M17BAKRg4VLKqf6A/a+fePUnP
         NzjA==
X-Gm-Message-State: AOJu0Yyx+pt0CERt+AJlK1AtFyfwniUe8fjHKN0myOoaD3cKv/c5+SKa
	a/twTmbevRD6uHH+I4WoTGg=
X-Google-Smtp-Source: AGHT+IHdh0CmhclRC1ufOIeiTPcCni6v6lM/NaXBFArsuefb3I7J2Wy9fxrDuw6Sdep7AvwQrZqtpA==
X-Received: by 2002:a17:907:1c24:b0:9bf:32c8:30ff with SMTP id nc36-20020a1709071c2400b009bf32c830ffmr2396776ejc.25.1697734451925;
        Thu, 19 Oct 2023 09:54:11 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709063e9500b009adc77fe164sm3772714ejj.66.2023.10.19.09.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:54:11 -0700 (PDT)
Date: Thu, 19 Oct 2023 19:54:09 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	marex@denx.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 2/2] net:dsa:microchip: add property to
 select internal RMII reference clock
Message-ID: <20231019165409.5sgkyvxsidrrptgh@skbuf>
References: <351f7993397a496bf7d6d79b9096079a41157919.1697620929.git.ante.knezic@helmholz.de>
 <893a3ad19b28c6bb1bf5ea18dee2fa5855f0c207.1697620929.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893a3ad19b28c6bb1bf5ea18dee2fa5855f0c207.1697620929.git.ante.knezic@helmholz.de>

On Wed, Oct 18, 2023 at 11:24:14AM +0200, Ante Knezic wrote:
> Microchip KSZ8863/KSZ8873 have the ability to select between internal
> and external RMII reference clock. By default, reference clock
> needs to be provided via REFCLKI_3 pin. If required, device can be
> setup to provide RMII clock internally so that REFCLKI_3 pin can be
> left unconnected.
> Add a new "microchip,rmii-clk-internal" property which will set
> RMII clock reference to internal. If property is not set, reference
> clock needs to be provided externally.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
>  drivers/net/dsa/microchip/ksz8795.c     | 10 +++++++++-
>  drivers/net/dsa/microchip/ksz8795_reg.h |  3 +++
>  drivers/net/dsa/microchip/ksz_common.h  |  1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
> index 91aba470fb2f..b50ad9552c65 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -1312,8 +1312,16 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
>  	ksz_port_cfg(dev, port, P_PRIO_CTRL, PORT_802_1P_ENABLE, true);
>  
>  	if (cpu_port) {
> -		if (!ksz_is_ksz88x3(dev))
> +		if (!ksz_is_ksz88x3(dev)) {
>  			ksz8795_cpu_interface_select(dev, port);
> +		} else {
> +			dev->rmii_clk_internal = of_property_read_bool(dev->dev->of_node,
> +								       "microchip,rmii-clk-internal");
> +
> +			ksz_cfg(dev, KSZ88X3_REG_FVID_AND_HOST_MODE,
> +				KSZ88X3_PORT3_RMII_CLK_INTERNAL,
> +				dev->rmii_clk_internal);

Odd code placement, and it looks too crammed/shifted to the right due to indentation.

The calling pattern is as follows: ksz8_port_setup() has 2 callers.

One is from
ds->ops->port_setup()
-> ksz_port_setup()
   -> filters out everything except user ports
   -> dev->dev_ops->port_setup()
      -> ksz8_port_setup()

and the other is from
ds->ops->setup() // switch-wide
-> dev->dev_ops->config_cpu_port()
   -> ksz8_config_cpu_port()
      -> ksz8_port_setup()

So user ports and CPU ports meet at ksz8_port_setup() from different
call paths, but I think it's strange to continue this coding pattern for
port stuff that's not common between user ports and CPU ports. For that
reason, the placement of the existing ksz8795_cpu_interface_select() is
also weird, when it could have been directly placed under
ksz8_config_cpu_port(), and it would have not confusingly shared a code
path with user ports.

Could you please add a dedicated ksz88x3_config_rmii_clk(), called
directly from ksz8_config_cpu_port()? It can have this as first step:

	if (!ksz_is_ksz88x3(dev))
		return 0;

and then the rest of the code can have a single level of indentation,
which would look much more natural.

> +		}
>  
>  		member = dsa_user_ports(ds);
>  	} else {
> 

