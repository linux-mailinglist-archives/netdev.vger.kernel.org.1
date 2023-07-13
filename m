Return-Path: <netdev+bounces-17675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93F752A8D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D2B1C2141C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263DD1ED3A;
	Thu, 13 Jul 2023 18:54:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179223224
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 18:54:02 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BB52D6B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:53:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso7140985e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689274417; x=1691866417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xmc1sE9Mq+D+NHMQWiyH+jo9A18cWBOIkCA/5pe5/a0=;
        b=AT2yZufGgFU4zc5kdeWcjkY+4EPwoYSGlVdmT5fsMKXBRAjXelkG637w7llP/wqvhk
         49z+FNYxoKGtvpN8zvIL4YMlKSifYy7TTSip+6EzNNuPHt1rWvzlGzetQXwEtCXcV25B
         GgXZoEimNeOu38gQjz6iWjiIpE3z2jTcb3Jb+gojFSt7BxlzR+trZPwRrHiv2oJAb19I
         8Pk96Ytz/SZMxXM6eXtvPY4Kva4qzd52T7d/rbB4vTEqpOrhnxuxQ3Qc4fpTSj68lpd5
         mrI2P3P0tsWC9Uayb4ohDEL1af0Q/fImjdX5JsIHWJ6tUQJdLVJLJaQi34hVgIzProCG
         GJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274417; x=1691866417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmc1sE9Mq+D+NHMQWiyH+jo9A18cWBOIkCA/5pe5/a0=;
        b=K2kOFIeQx533uervoYcxujtm+OX4GuD6j347MDAC03GhfpgnuRYekzjR77RTi021rs
         Lu/5S5xH+3dL85prrpdzkL5mvkPayZQx2ZLOQDwaCjPI+kcnkmyqBovztRA/DENMI7dk
         DJwS9tDvtzu15rIBfD34BQZm0GreY7r8u3r7bx9wdfA3B3Cx1t9TZW6YwxeQOn1m7rlN
         N6bdUcgmiNhW7k7Gb7e6MlveRuwlO8wSwE4NfY1fDP/El+Xx5oPF/S8ZSb1OH5KC5q7O
         /V4GN8abWAuB2DQ0MW/XOP2Cgg096haGohnLIvBNuCeTb4HMjRFUNAmANmBzKT+FkzP8
         wvZQ==
X-Gm-Message-State: ABy/qLbn1f3k8flUAPGmKOjfSViODzruMQ6wNys1evv+FMH5QW73mfrO
	h6Kq+up1KDSUy/FEqb/f6uQv0Q==
X-Google-Smtp-Source: APBJJlFGcBOC1CQdQzgJvkJuHC7qUoBaELowjSnjyXxtm2hCTolZLj1cIz2922V2EK06GANygH9RJQ==
X-Received: by 2002:a05:600c:ac6:b0:3fa:9741:5b73 with SMTP id c6-20020a05600c0ac600b003fa97415b73mr395202wmr.10.1689274417049;
        Thu, 13 Jul 2023 11:53:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l4-20020a1ced04000000b003fbe561f6a3sm19089261wmh.37.2023.07.13.11.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 11:53:36 -0700 (PDT)
Message-ID: <ebd30cd0-5081-f05d-28f7-5d5b637041e4@linaro.org>
Date: Thu, 13 Jul 2023 20:53:34 +0200
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: Pranavi Somisetty <pranavi.somisetty@amd.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, harini.katakam@amd.com, git@amd.com,
 radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20230713103453.24018-1-pranavi.somisetty@amd.com>
 <f6c11605-56d7-7228-b86d-bc317a8496d0@linaro.org>
 <a17b0a4f-619d-47dd-b0ad-d5f3c1a558fc@lunn.ch>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a17b0a4f-619d-47dd-b0ad-d5f3c1a558fc@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 17:59, Andrew Lunn wrote:
>>> +examples:
>>> +  - |
>>> +    mdio {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        phy: ethernet-phy@0 {
>>> +            reg = <0>;
>>> +        };
>>
>> Drop this node, quite obvious.
> 
> Dumb question. Isn't it needed since it is referenced by phy-handle =
> <&phy> below. Without it, the fragment is not valid DT and so the
> checking tools will fail?

No, because the example is compiled with silencing missing phandles.

Best regards,
Krzysztof


