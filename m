Return-Path: <netdev+bounces-17557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13A3751FD6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA48281CF7
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6341119F;
	Thu, 13 Jul 2023 11:23:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5D101E8
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:23:40 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D8E53
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:23:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso1052401e87.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689247417; x=1691839417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdA26b3TlY+qVHFXfPT1loEQBlaITbodxKS5uFmTHFI=;
        b=p998AEX5zIHGMjonVjUbgh8/6QXiGDq451oj4GhrOMbgxHlwnZ45wSU6N4fOY1nXCq
         dQ19BR1al1G1NrDLgXCflOyr7ZtXl2BquH+coP6BfC6Cr6/PGdsTeKWrvIaB25vdsonP
         dcPRwSM48VY60QKLAHO+hhMyD5EV//veREUy0rN2p7nJbnpyhyJ2Fq7O0wVgIISYC2Xi
         vh0BKVFkYFPaYpn3ffOanHRSVDw+LIGOWSZ62hw3ct6AC3mbVVUjBLr6RpGs12Y350rJ
         CtixOs+Q6PYq2ZJNoTkwXz054d4lePbxrRwEbiCdBw4LC91TVzhnvYwKdPIaLky4F6tB
         kX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689247417; x=1691839417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdA26b3TlY+qVHFXfPT1loEQBlaITbodxKS5uFmTHFI=;
        b=Rb5pjdpaDlhp6thpzj3Ux5SPRrXbdiNFOSFDzfFLg+RbcSQ1+8HhFCgDGnovu6IZ39
         ZzB8nyHI8p8rkbu7lgUwTmk0gvJUxzkSGcmx33a19mBD30lv3066EU6EKPGbOt3Dw5I5
         TDGcv2a6/NjKB6+lfj6rhbamlkvY4MuJY9zZA67v5Wta3brbYVdLUakG81Cnj0dxy93P
         A9kV0Ijt1NMWwxYnrsUAJ/21dZPLJMVfaY5qW5wALz74S6JMdo4o00UAV6XO6LXm3f4+
         XJCYebJxhzpNn+wkZtRF0c20FzvG2DIFegWew5jwh7kLv6PD+7AbBBykvGh1by6KQoJk
         wteA==
X-Gm-Message-State: ABy/qLbxsreNTi/PUSw8TH6UGJrFipAiv2vDlTwRqWKldWQOjkxV3NH4
	WRYhp81jsjt66rm4EHsJLgys7w==
X-Google-Smtp-Source: APBJJlFOclpA9UTM6DzH6FOtAA8753K+Xc9Pk5yTtRuLx+RYqFXrAkPPpxbPMKd+GiA3HToh0ficQw==
X-Received: by 2002:a05:6512:65:b0:4fb:c693:c73b with SMTP id i5-20020a056512006500b004fbc693c73bmr1040777lfo.64.1689247416988;
        Thu, 13 Jul 2023 04:23:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d6810000000b003144b50034esm7675296wru.110.2023.07.13.04.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 04:23:36 -0700 (PDT)
Message-ID: <f6c11605-56d7-7228-b86d-bc317a8496d0@linaro.org>
Date: Thu, 13 Jul 2023 13:23:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
Content-Language: en-US
To: Pranavi Somisetty <pranavi.somisetty@amd.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, harini.katakam@amd.com
Cc: git@amd.com, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20230713103453.24018-1-pranavi.somisetty@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230713103453.24018-1-pranavi.somisetty@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 12:34, Pranavi Somisetty wrote:
> Convert the Xilinx GMII to RGMII Converter device tree binding
> documentation to json schema.
> This converter is usually used as gem <---> gmii2rgmii <---> external phy
> and, it's phy-handle should point to the phandle of the external phy.
> 
> Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>

...

> +
> +description:
> +  The Gigabit Media Independent Interface (GMII) to Reduced Gigabit Media
> +  Independent Interface (RGMII) core provides the RGMII between RGMII-compliant
> +  ethernet physical media devices (PHY) and the Gigabit Ethernet controller.
> +  This core can be used in all three modes of operation(10/100/1000 Mb/s).
> +  The Management Data Input/Output (MDIO) interface is used to configure the
> +  speed of operation. This core can switch dynamically between the three
> +  different speed modes by configuring the converter register through mdio write.
> +  The core cannot function without an external phy connected to it.
> +
> +properties:
> +  compatible:
> +    const: xlnx,gmii-to-rgmii-1.0
> +
> +  reg:
> +    minimum: 0
> +    maximum: 31
> +    description: The ID number for the phy, usually a small integer.

Drop the "usually small...", it's obvious from constraints.

> +
> +  phy-handle: true

Where is this defined?

> +
> +required:
> +  - compatible
> +  - reg
> +  - phy-handle
> +
> +unevaluatedProperties: false

Either you miss $ref or this should be additionalProperties. I bet it's
the first problem.

> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        phy: ethernet-phy@0 {
> +            reg = <0>;
> +        };

Drop this node, quite obvious.

> +        gmiitorgmii@8 {
> +            compatible = "xlnx,gmii-to-rgmii-1.0";
> +            reg = <8>;
> +            phy-handle = <&phy>;
> +        };
> +    };

Best regards,
Krzysztof


