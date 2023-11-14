Return-Path: <netdev+bounces-47583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A27EA88A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 03:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3BB1C209FB
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 02:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7079CC;
	Tue, 14 Nov 2023 02:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4A7497;
	Tue, 14 Nov 2023 02:03:21 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A73D43;
	Mon, 13 Nov 2023 18:03:19 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b2ea7cca04so3135246b6e.2;
        Mon, 13 Nov 2023 18:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699927399; x=1700532199;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3QCfTjRiCz/DzkCe1cM9AjRQBmoPaZC036Y8ShSbLoo=;
        b=Pc7F/qVGttsWVB6SLLdk64sh7KIR3eBB/UqBWRR0bDvtSZUOZtPm62x1maONI8rY4a
         eOPgB0MukwSdMr3G8xO1jXoz1Cl8F2qe0pUhZLP4ch/hgsSUQf6uOMmPtUF9IcF9QdQ6
         Q4dJ94PW9o/If7zZH6k1E7PuLO1n+of4UxrmHaeapdYnsU7KluMEjWrDoLKFOBzvUfuz
         meancAvKHOwwfK7q8ojbcz9oOtiwUYTiEjqUr1KtkrbpwK+XnppdeMs2UOXz88htePFp
         M6fnSNKYFeJ6J6lWjzXFqeAruaN2mP1+YXAyk7FH3GxRda9CyHf1nm255vV29cBDVZ/2
         p2JA==
X-Gm-Message-State: AOJu0Yw87N+EkKGkU/EsyOcUQ9RDwH+/yAkIc71L4ugFXRJoDRaKsXzX
	i3Wq0lzqfxzEe1A25laFAFQjbaw/Tw==
X-Google-Smtp-Source: AGHT+IGNhdjn69qylIMWJZG44A4aCt+rpAV1f6vOuC1Wj18EeE9NqpmNUo+WyjgB8wJNaTV8XLb9Tw==
X-Received: by 2002:a05:6808:a0c:b0:3ae:16aa:8ba9 with SMTP id n12-20020a0568080a0c00b003ae16aa8ba9mr9873991oij.30.1699927399003;
        Mon, 13 Nov 2023 18:03:19 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n7-20020a0568080a0700b003ae540759a0sm993772oij.40.2023.11.13.18.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 18:03:18 -0800 (PST)
Received: (nullmailer pid 301813 invoked by uid 1000);
	Tue, 14 Nov 2023 02:03:15 -0000
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Gregory Clement <gregory.clement@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, Vladimir Oltean <olteanv@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-2-50688741691b@linaro.org>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <20231114-marvell-88e6152-wan-led-v8-2-50688741691b@linaro.org>
Message-Id: <169992739589.301792.1356820385901192007.robh@kernel.org>
Subject: Re: [PATCH net-next v8 2/9] dt-bindings: net: mvusb: Fix up DSA
 example
Date: Mon, 13 Nov 2023 20:03:15 -0600


On Tue, 14 Nov 2023 00:35:57 +0100, Linus Walleij wrote:
> When adding a proper schema for the Marvell mx88e6xxx switch,
> the scripts start complaining about this embedded example:
> 
>   dtschema/dtc warnings/errors:
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> 
> Fix this up by extending the example with those properties in
> the ports node.
> 
> While we are at it, rename "ports" to "ethernet-ports" and rename
> "switch" to "ethernet-switch" as this is recommended practice.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/marvell,mvusb.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: /example-0/usb/mdio@1/ethernet-switch@0: failed to match any schema with compatible: ['marvell,mv88e6190']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231114-marvell-88e6152-wan-led-v8-2-50688741691b@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


