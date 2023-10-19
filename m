Return-Path: <netdev+bounces-42720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F947CFF46
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D359282031
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10333321B9;
	Thu, 19 Oct 2023 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok/ZlHJI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B12BD314;
	Thu, 19 Oct 2023 16:18:23 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E421126;
	Thu, 19 Oct 2023 09:18:22 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41cc776ccb4so6170311cf.1;
        Thu, 19 Oct 2023 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697732301; x=1698337101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uapV51mLN8WMmYGSnBZfefCdK6ozT3UVGFGF24qIeuY=;
        b=Ok/ZlHJIr8NEYHVFvYHSOv7Lj6afaG8jpmG/NJVlBivlUtviGn2jX6HMptrogT+3s+
         ACG+194lnIICGjRvbdDsXqilN1PEu6JmH8q59H30GrT7rxekReU1huejLWO+G4mxHRPM
         ZqG+XjqB11x0pq0dTmq9wzB1MIBUiR62dtrSh3ioLG6hzeKTDB5N6ESQL7oJE5tZG0b6
         1A8NDDO3RtrfE3DVWNrLuax0ONKyg8TFOJb2T+JoSyfdxWMZx/9u98VJFTjRYadA1VI2
         qlkmm1RbC5tiklcgA8DW1Jd6/PHXZwfuD65p7s5zlEWkwkHFXvL5SKOS0yRg44NKgd25
         z/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732301; x=1698337101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uapV51mLN8WMmYGSnBZfefCdK6ozT3UVGFGF24qIeuY=;
        b=KtLyPZRqsOtZRFMGndeYNFGLw1KLntOWPapRZ0YPIdxbBiQ6IihHOEcVURSo5Sy1Ng
         pSl4xI70mCpqVmshat3cxXTk1kHg7AwdQfdaW853qwNZitMK1NH7adtC7ui1fxSeJYUv
         mEc59M2y+Gf6x50hUmDfi5TVBxj/6n7hi00FMX4UqN7Q+AzaneHsOAH6XALTwbhm4McA
         2IyjwS3U5dg3HN+3c4XPOZvqOXZ/0AAb52LCO242E4ItvPGop/wkFwPYxc/JFpBgOYYk
         S/89JA9Yo+AOhmYg086uTj0OkHFlOgpXcUo+sgp/f+CVJ3YFissBwt0ofMMgVxHzzd9Z
         NAlg==
X-Gm-Message-State: AOJu0YwS0GaIOqMeNNFmeKw73n9tabx6DB3YsKwAFuSyLSA3uzCJmnPb
	iuHe+nFsIpUM/jnJL6eLAMo=
X-Google-Smtp-Source: AGHT+IGjvhJfLKuDs5DfvJnYwes/BIJO6xmXm1HYK7qwm3adZqHNq/BSUWQbhp/V1oYQa1lhQTLq8w==
X-Received: by 2002:ac8:5b86:0:b0:41c:b617:8529 with SMTP id a6-20020ac85b86000000b0041cb6178529mr2752525qta.21.1697732300989;
        Thu, 19 Oct 2023 09:18:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fp7-20020a05622a508700b00405502aaf76sm836120qtb.57.2023.10.19.09.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:18:20 -0700 (PDT)
Message-ID: <8ba336f9-b2e3-43e1-a3b7-06022ea9ac00@gmail.com>
Date: Thu, 19 Oct 2023 09:18:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: ksz9477: Add Wake on
 Magic Packet support
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 "Russell King (Oracle)" <linux@armlinux.org.uk>, devicetree@vger.kernel.org
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231019122850.1199821-6-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/23 05:28, Oleksij Rempel wrote:
> Introduce Wake on Magic Packet (WoL) functionality to the ksz9477
> driver.
> 
> Major changes include:
> 
> 1. Extending the `ksz9477_handle_wake_reason` function to identify Magic
>     Packet wake events alongside existing wake reasons.
> 
> 2. Updating the `ksz9477_get_wol` and `ksz9477_set_wol` functions to
>     handle WAKE_MAGIC alongside the existing WAKE_PHY option, and to
>     program the switch's MAC address register accordingly when Magic
>     Packet wake-up is enabled. This change will prevent WAKE_MAGIC
>     activation if the related port has a different MAC address compared
>     to a MAC address already used by HSR or an already active WAKE_MAGIC
>     on another port.
> 
> 3. Adding a restriction in `ksz_port_set_mac_address` to prevent MAC
>     address changes on ports with active Wake on Magic Packet, as the
>     switch's MAC address register is utilized for this feature.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


