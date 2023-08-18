Return-Path: <netdev+bounces-28852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AAB781031
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592CF1C20F45
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45CE19BBF;
	Fri, 18 Aug 2023 16:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92BA18C0B
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:21:07 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6D33590;
	Fri, 18 Aug 2023 09:21:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ffa248263cso1615254e87.2;
        Fri, 18 Aug 2023 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692375665; x=1692980465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISevr3prZA/3S0QxHj5ydXN0Zv61FsI9PfVEfof23CI=;
        b=jZahUfj/MmduD+IPM03Pint/RLvUMSFv0iyRRMZSaK908OZyaz1O8uAqEOBN88VHc1
         qNUNn4OVR+Z5EdbK7gnS4UphDN5VeVwufEUMpn8lpNV2nvE0UB4iMLP8b+cjHbHV47u/
         2bqeW+UcsPb1eQTiJ5flLoGXw+0pKJFWwXm03O2yDfz5x39ZvdyJ+EOW2S5LatN4wemT
         pFYYtLSTflnCmN31qdlqNS/9ABA85Bw7JTX4xETOWP1ymW5V+RDZfzrwYw/5LX6Ds9k3
         bZeWn68Ym2ldz7i9zXQjKozmlM+fRC5okYuigbqgTnkiYKmUAldLuYmhHznPiV3rREO2
         YiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375665; x=1692980465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISevr3prZA/3S0QxHj5ydXN0Zv61FsI9PfVEfof23CI=;
        b=Gjeq3RFEbAg10Vu4ycgJVMmo6gtLiq8mw/Rn3ecpCwEvMqDnXNUGGER7nknVY5VMXt
         FneG5gTPTQ6lniCZwklWbB+g+st4y8/1I79tXDdS87m6zsDUcvFgqO6tjq1fAg/xKqYq
         TGIU9y09ZWFxTMV/p0uYdbrTn8y4PkIhg+48V5DJ+D47mkcuRjM04I4L7p8rw20wC6Rz
         0WPVXzNMQ7SS3dePpqoBgZoEiuUMtcGePFoJ41eUDq5NotJNEqp78CDuXqTeeJUAZkJr
         H3zEVXho9t5ZB2TW0oOBFq9mzMIDiZg4OYrmThaQpFYX+RZ7Lj6EYdYB+7CjSy92JWRV
         GtfQ==
X-Gm-Message-State: AOJu0YzoJy0ZQlgjDBh+R6ObU/rX7tDgTw4NaAQU9uoAUH6FbAWlLJj6
	4Kb7QRKu35u4rIveDjWMVbQ=
X-Google-Smtp-Source: AGHT+IE3/49Cxy+7LqkfRNSOMxG3XFb7K+P7OqdpNJXTtf3WMhq9yD7RJ9phPsVggVXGgrG0MkRTsw==
X-Received: by 2002:a19:4f42:0:b0:4fb:9129:705b with SMTP id a2-20020a194f42000000b004fb9129705bmr1957691lfk.6.1692375664574;
        Fri, 18 Aug 2023 09:21:04 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id l17-20020ac25551000000b004fe432108aesm406648lfk.261.2023.08.18.09.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:21:04 -0700 (PDT)
Date: Fri, 18 Aug 2023 19:21:02 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v5 1/9] net: stmmac: correct RX COE parsing for
 xgmac
Message-ID: <2kx4oyzkt3d72lf746rhblx4cecy32yosyyshqzehd5vadth7w@4jppnqxpm6ww>
References: <20230817165749.672-1-jszhang@kernel.org>
 <20230817165749.672-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817165749.672-2-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 12:57:41AM +0800, Jisheng Zhang wrote:
> xgmac can support RX COE, but there's no two kinds of COE, I.E type 1
> and type 2 COE.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 733b5e900817..3d90ca983389 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7035,7 +7035,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  	if (priv->plat->rx_coe) {
>  		priv->hw->rx_csum = priv->plat->rx_coe;
>  		dev_info(priv->device, "RX Checksum Offload Engine supported\n");
> -		if (priv->synopsys_id < DWMAC_CORE_4_00)
> +		if (priv->synopsys_id < DWMAC_CORE_4_00 && !priv->plat->has_xgmac)
>  			dev_info(priv->device, "COE Type %d\n", priv->hw->rx_csum);
>  	}
>  	if (priv->plat->tx_coe)
> -- 
> 2.40.1
> 
> 

