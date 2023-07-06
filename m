Return-Path: <netdev+bounces-15883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234CF74A43E
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 21:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DE12813E6
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DDABE46;
	Thu,  6 Jul 2023 19:12:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34144A947
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 19:12:01 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D01BDB;
	Thu,  6 Jul 2023 12:12:00 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-785cbc5bfd2so38024039f.2;
        Thu, 06 Jul 2023 12:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688670720; x=1691262720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXU7Wt2272aI2cWoAWkzUapCyXWe+5UzEWsEVDkssTE=;
        b=KIhP2M2D5arM0QCytoyBxUogEOoNdu/LtCIjCNwaV9AS72h9ekqEPJId7Ti48hwVIU
         wk2p2eXipqgU7tvva6fibhaCtVNax5RaCpGrsBWtcjhQEa+37i2o3OlTyNHEpqgZg38X
         J3zTvyIgTJ4KthiLe8fAsviquUtIlUq3FX/I9pJDo+EAID35VmsAnBhTFg3O62al8iJw
         H/BU2vGEJEZiCYwPcHvTHEUNetbDoivaFbiDF7OBSAEwEo5jL3otQWpyRzcnBvOjdKus
         c3ZjhjNeeh3I/Kor+hM4hkJgiDtoK3EF29ug9hJHVpCo8mmWWVS2D0izbKK128T18zFB
         AwIQ==
X-Gm-Message-State: ABy/qLaAhOpPwRmXqMXMjbzrhO72cLpNXClD+ilHpg/SWpn3t6wISwil
	JCXibcDRrI6WwWBjvb900g==
X-Google-Smtp-Source: APBJJlF07iocpCggVXaw78JSKNekrgWfNt3CbG1McmPUCJtGyu2pbeZDDeztboCM4rurH1+MtXodYA==
X-Received: by 2002:a05:6602:2774:b0:780:ccb9:297b with SMTP id l20-20020a056602277400b00780ccb9297bmr3152305ioe.11.1688670720022;
        Thu, 06 Jul 2023 12:12:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u16-20020a02c950000000b0042b85d6e125sm112599jao.24.2023.07.06.12.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:11:59 -0700 (PDT)
Received: (nullmailer pid 168322 invoked by uid 1000);
	Thu, 06 Jul 2023 19:11:57 -0000
Date: Thu, 6 Jul 2023 13:11:57 -0600
From: Rob Herring <robh@kernel.org>
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, olteanv@gmail.com, marius.muresan@mxt.ro
Subject: Re: [PATCH 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
Message-ID: <20230706191157.GA163793-robh@kernel.org>
References: <20230706081554.1616839-1-alex@shruggie.ro>
 <20230706081554.1616839-2-alex@shruggie.ro>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706081554.1616839-2-alex@shruggie.ro>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 11:15:54AM +0300, Alexandru Ardelean wrote:
> For VSC8351 and similar PHYs, a new property was added to generate a clock
> signal on the CLKOUT pin.
> This change documents the change in the device-tree bindings doc.
> 
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> index 0a3647fe331b..133bdd644618 100644
> --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> @@ -31,6 +31,10 @@ Optional properties:
>  			  VSC8531_LINK_100_ACTIVITY (2),
>  			  VSC8531_LINK_ACTIVITY (0) and
>  			  VSC8531_DUPLEX_COLLISION (8).
> +- vsc8531,clkout-freq-mhz : For VSC8531 and similar PHYs, this will output

Please don't continue this naming pattern with 'vsc8531' prefix. The 
prefix should be the vendor prefix.

> +			  a clock signal on the CLKOUT pin of the chip.
> +			  The supported values are 25, 50 & 125 Mhz.
> +			  Default value is no clock signal on the CLKOUT pin.
>  - load-save-gpios	: GPIO used for the load/save operation of the PTP
>  			  hardware clock (PHC).
>  
> @@ -69,5 +73,6 @@ Example:
>                  vsc8531,edge-slowdown	= <7>;
>                  vsc8531,led-0-mode	= <VSC8531_LINK_1000_ACTIVITY>;
>                  vsc8531,led-1-mode	= <VSC8531_LINK_100_ACTIVITY>;
> +                vsc8531,clkout-freq-mhz	= <50>;
>  		load-save-gpios		= <&gpio 10 GPIO_ACTIVE_HIGH>;
>          };
> -- 
> 2.40.1
> 

