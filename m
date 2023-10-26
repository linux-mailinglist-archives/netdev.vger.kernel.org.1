Return-Path: <netdev+bounces-44557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F417E7D89E9
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC532820EE
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDA63AC0B;
	Thu, 26 Oct 2023 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC16C8E8;
	Thu, 26 Oct 2023 20:58:12 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA6F1A5;
	Thu, 26 Oct 2023 13:58:11 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6cd09f51fe0so747791a34.1;
        Thu, 26 Oct 2023 13:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698353890; x=1698958690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZZs6ipF1/kyYhxkHZor6S/scn40iCNPizM59Ene1L8=;
        b=YlhrVUTigmk4EFT4VufTztDdlYtfVJ++S4+WZyHwV9PM7EZzfApOMKPhJUjRHYYROT
         HDPA/J9+gkLyGFVmei7raX1iVtDjEOLEnd/7DFys8J+r8S1dYIY84+f5sILSaCxwxJyz
         1tGnOqEfsp1aDvB7Ly821oJTF5Z9HG8IZCKfoPCzf0Xhs3E0Tu1O2ur3vU1t1oKdkpId
         iHJh1PHqL81/lv5mATIROadIkdTvFBpRkaTs9bbE/uOUvw+AHelfDx8oy9Uj9rHELFz8
         3Af7aDMz0VtZapE5nLv9aornJG346xJ21WPsxtdlTduV3mYTP0fDU0o6UoZbt2z2bNTB
         f8pw==
X-Gm-Message-State: AOJu0Ywr1TKArjoPRpvbEsyI4wALjNSmL7nXwjWF5OcN0ahMOaGW3Bwk
	F9vPVekDrcq4ZLT89OsAjg==
X-Google-Smtp-Source: AGHT+IHnHkZswO8YBailJZbQHDWeErCjZkAmi7dsoNesGJpL7ZjpwoWWVG0G7aRPvWifYpGVVGsFxA==
X-Received: by 2002:a9d:7d96:0:b0:6bc:f276:717f with SMTP id j22-20020a9d7d96000000b006bcf276717fmr562427otn.13.1698353890370;
        Thu, 26 Oct 2023 13:58:10 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r25-20020a05683001d900b006bee5535b44sm10575ota.75.2023.10.26.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:58:09 -0700 (PDT)
Received: (nullmailer pid 383670 invoked by uid 1000);
	Thu, 26 Oct 2023 20:58:07 -0000
Date: Thu, 26 Oct 2023 15:58:07 -0500
From: Rob Herring <robh@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, arinc.unal@arinc9.com, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: dsa: realtek: add reset
 controller
Message-ID: <20231026205807.GA347941-robh@kernel.org>
References: <20231024205805.19314-1-luizluca@gmail.com>
 <20231024205805.19314-3-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024205805.19314-3-luizluca@gmail.com>

On Tue, Oct 24, 2023 at 05:58:06PM -0300, Luiz Angelo Daros de Luca wrote:
> Realtek switches can now be reset using a reset controller.
> 
> The 'reset-gpios' were never mandatory for the driver, although they
> are required for some devices if the switch reset was left asserted by
> a previous driver, such as the bootloader.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/net/dsa/realtek.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> index cce692f57b08..070821eae2a7 100644
> --- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> @@ -59,6 +59,12 @@ properties:
>      description: GPIO to be used to reset the whole device
>      maxItems: 1
>  
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: switch

$block-name is not really a useful name for resources. Generally, you   
don't need -names if there's only 1 entry.

> +
>    realtek,disable-leds:
>      type: boolean
>      description: |
> @@ -127,7 +133,6 @@ else:
>      - mdc-gpios
>      - mdio-gpios
>      - mdio
> -    - reset-gpios
>  
>  required:
>    - compatible
> -- 
> 2.42.0
> 

