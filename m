Return-Path: <netdev+bounces-41044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9937C9686
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 23:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45305281AC2
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 21:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAA22629F;
	Sat, 14 Oct 2023 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B36CF4F8;
	Sat, 14 Oct 2023 21:35:16 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3190CC;
	Sat, 14 Oct 2023 14:35:14 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1e5602c12e5so1884437fac.3;
        Sat, 14 Oct 2023 14:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697319314; x=1697924114;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MBwRMIVROmmBQpDc6SVXosJBDiLfO3KWW/346cMaQiY=;
        b=YKf78jn6KC/TudurfnV/D1x5YxmIAAvVBhHm3I2FmuIZIEJ/eHLYHdpbV+XNNnMWmc
         GcFQJzgnR9qDbZ0nqg9gTLqQid5ShaN9dIvEBZaidmDXPWztv6IR4cUAUTQXhy+ONTjx
         qDFNWq9/d2yJYobd6HNnF9DOAs9Prsvy7TeOp2L/gufpooat5ThP7HqCX8LJokUjKlyM
         rD9wRzQ98sF/Jek7RIr/kVIOo2sJ7ZgmfDPn/cOyjM4jSDy91SVnH1E11adQzpfpUDXU
         WNNqSc1gBrVdaLAgJsJncIJ0Umk8wS9n31xZd/4uJliGO/hCxdcSN3MY+whTYM4oXt5q
         2B0Q==
X-Gm-Message-State: AOJu0YxM2Q/11xoMuG6Ujo0tym190v9fY6okUZCXiwVCgbQD2PXgfpuU
	sfl+GUAhpLdMTUpSaGogAA==
X-Google-Smtp-Source: AGHT+IFh0ejBA0W/YnotiYIWBBpOzR7ycB6HKOGMnb3NELy6Kfr3Pi1cDDqsdVs5YRxjMJ/+og7j5g==
X-Received: by 2002:a05:6870:b79c:b0:1e9:dd69:2fba with SMTP id ed28-20020a056870b79c00b001e9dd692fbamr5560561oab.9.1697319314080;
        Sat, 14 Oct 2023 14:35:14 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dy40-20020a056870c7a800b001e1754b9fc1sm1221798oab.24.2023.10.14.14.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 14:35:13 -0700 (PDT)
Received: (nullmailer pid 2970737 invoked by uid 1000);
	Sat, 14 Oct 2023 21:35:12 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, Christian Marangi <ansuelsmth@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org, netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, linux-arm-kernel@lists.infradead.org, Eric Dumazet <edumazet@google.com>, Conor Dooley <conor+dt@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20231014-marvell-88e6152-wan-led-v2-1-7fca08b68849@linaro.org>
References: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
 <20231014-marvell-88e6152-wan-led-v2-1-7fca08b68849@linaro.org>
Message-Id: <169731931217.2970721.15978003644189758136.robh@kernel.org>
Subject: Re: [PATCH net-next v2 1/5] dt-bindings: marvell: Rewrite
 MV88E6xxx in schema
Date: Sat, 14 Oct 2023 16:35:12 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Sat, 14 Oct 2023 22:51:32 +0200, Linus Walleij wrote:
> This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> in YAML schema.
> 
> The current text binding says:
>   WARNING: This binding is currently unstable. Do not program it into a
>   FLASH never to be changed again. Once this binding is stable, this
>   warning will be removed.
> 
> Well that never happened before we switched to YAML markup,
> we can't have it like this, what about fixing the mess?
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 241 +++++++++++++++++++++
>  .../devicetree/bindings/net/dsa/marvell.txt        | 109 ----------
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 242 insertions(+), 110 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231014-marvell-88e6152-wan-led-v2-1-7fca08b68849@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


