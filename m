Return-Path: <netdev+bounces-45237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F457DBA62
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4145DB20D2B
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675315EBC;
	Mon, 30 Oct 2023 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3C469E;
	Mon, 30 Oct 2023 13:16:02 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94F1C6;
	Mon, 30 Oct 2023 06:16:00 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1ea82246069so3021064fac.3;
        Mon, 30 Oct 2023 06:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698671760; x=1699276560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLmLGlbOjf38ZbhV4BEzoR/yzXBabn3e4awVISlH6tM=;
        b=M1x3SwZIwCtvIzkvk7+PqtpPrzGlXYg9GDm7eCHpQZ6LVyFHZiEEeBBKo0RDJD6Rdd
         OfvmoqWd58NK64w96tMw39tKO70TnRY6lixvXjIEBrkavkSPuWZjMfgVLe3ZC2nRo6eu
         /nXUWgaoHf9Y7XLZuOUfCSSpZuqDiZlGlqeEeutuky0L+4cC5XTAEWdq5p7vXacrcioL
         gSBRWKsbr6rRDceISbm8tgzYktM/Qpx7K5krYnyuFSSkQxnxHTopNlSKrVPEBOi6LXv3
         R9Pu4GLbPZU9wNkzHFKLBk1ZD1yF++UhVLK+Nfzi8+YU7MVIjpbkgvw2gokm957Ta7wK
         D8Hg==
X-Gm-Message-State: AOJu0Yx38KjIHzRoU7ew3LHizYLwTaC6w1IEPwyCw9201LyIsCwWx9t9
	XYJCBTvsbeKtk6BAQJFTqA==
X-Google-Smtp-Source: AGHT+IEyFKssvTbEr3mkoovbkZpZhpOmZ3zfWozMSHFZ3PvMYpEebQGgoOdiV9IUcoOil7IywnlfXg==
X-Received: by 2002:a05:6871:5385:b0:1ea:478c:a26b with SMTP id hy5-20020a056871538500b001ea478ca26bmr15365723oac.9.1698671759859;
        Mon, 30 Oct 2023 06:15:59 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dd2-20020a056871c80200b001e578de89cesm1599164oac.37.2023.10.30.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:15:59 -0700 (PDT)
Received: (nullmailer pid 724163 invoked by uid 1000);
	Mon, 30 Oct 2023 13:15:51 -0000
Date: Mon, 30 Oct 2023 08:15:51 -0500
From: Rob Herring <robh@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, arinc.unal@arinc9.com, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] dt-bindings: net: dsa: realtek: add
 reset controller
Message-ID: <20231030131551.GA714112-robh@kernel.org>
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-3-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027190910.27044-3-luizluca@gmail.com>

On Fri, Oct 27, 2023 at 04:00:56PM -0300, Luiz Angelo Daros de Luca wrote:
> Realtek switches can use a reset controller instead of reset-gpios.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/net/dsa/realtek.yaml  | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> index 46e113df77c8..ef7b27c3b1a3 100644
> --- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> @@ -59,6 +59,9 @@ properties:
>      description: GPIO to be used to reset the whole device
>      maxItems: 1
>  
> +  resets:
> +    maxItems: 1
> +
>    realtek,disable-leds:
>      type: boolean
>      description: |
> @@ -385,3 +388,75 @@ examples:
>                      };
>              };
>        };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    platform {
> +            switch {
> +                    compatible = "realtek,rtl8365mb";
> +                    mdc-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> +                    mdio-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +
> +                    resets = <&rst 8>;
> +
> +                    ethernet-ports {
> +                            #address-cells = <1>;
> +                            #size-cells = <0>;
> +
> +                            ethernet-port@0 {
> +                                    reg = <0>;
> +                                    label = "wan";
> +                                    phy-handle = <&ethphy-0>;
> +                            };
> +                            ethernet-port@1 {
> +                                    reg = <1>;
> +                                    label = "lan1";
> +                                    phy-handle = <&ethphy-1>;
> +                            };
> +                            ethernet-port@2 {
> +                                    reg = <2>;
> +                                    label = "lan2";
> +                                    phy-handle = <&ethphy-2>;
> +                            };
> +                            ethernet-port@3 {
> +                                    reg = <3>;
> +                                    label = "lan3";
> +                                    phy-handle = <&ethphy-3>;
> +                            };
> +                            ethernet-port@4 {
> +                                    reg = <4>;
> +                                    label = "lan4";
> +                                    phy-handle = <&ethphy-4>;
> +                            };
> +                            ethernet-port@5 {
> +                                    reg = <5>;
> +                                    ethernet = <&eth0>;
> +                                    phy-mode = "rgmii";
> +                                    fixed-link {
> +                                            speed = <1000>;
> +                                            full-duplex;
> +                                    };
> +                            };
> +                    };
> +
> +                    mdio {
> +                            compatible = "realtek,smi-mdio";
> +                            #address-cells = <1>;
> +                            #size-cells = <0>;
> +
> +                            ethphy-0: ethernet-phy@0 {

You didn't test your binding (make dt_binding_check).

'-' is not valid in labels.


Why do we have a whole other example just for 'resets' instead of 
'reset-gpios'? That's not really worth it.

Rob

