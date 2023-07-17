Return-Path: <netdev+bounces-18191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03518755B67
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347B81C20A54
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 06:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC2279EB;
	Mon, 17 Jul 2023 06:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36679D0
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:19:43 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F0DB2
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 23:19:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977e0fbd742so564231166b.2
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 23:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689574780; x=1692166780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B980zBwLvj4rtQ6N+4vP5VbTnvVlJSdED2QfjPo3mK0=;
        b=ml3nAAFrIO4+vXIZ7tajyVURVldVB49rTImgZXD76Sd6H4kDO+eloC+2YiELHdzYol
         WkrUIEGRzL8ZUHHfYvcQ3j1MLT960VrQtS1KaQnxIDCLhnnvCKPzXnPUGxNQwkVTkhHP
         yBOEWYWLw0rivY8Gip93wq3Lw12MxL8CLXpudaic7k//bez6NDX6HLEazOIqd5GFuCsD
         TVRoamKRvZsU/k4EQTumjsAbkvhR3cw6PWYfArJ0w9YALRVxPHGywPdkxxSo5TOj36lc
         hAjXGZgz4fOkTIYVsHXoy90Yst4L5n1RiZ7KkzOmDT7/Ywbr22gF7yV3YF58bLhl78ie
         0u2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689574780; x=1692166780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B980zBwLvj4rtQ6N+4vP5VbTnvVlJSdED2QfjPo3mK0=;
        b=FUrCPNa+gOh1syuZxh3UcKz+oRCmYRF7+KZTuvUmdUkb/izqH54D359irWnwLYC5/d
         f4B17yMe7fazFgVepyaVjxr93fA3OR9mu54o/H6ir6i8rcu5gD7+6o8yDHeCAz6dtu2h
         BvljodInNsOvBSsc15+FCFMzlzKcC10JZAslrLRYXLVZlGKmuqc/HwuJrqLfbfblz+1i
         k3fnKqkJ2JaL2STP7lkmyAdyF+2IRxFWP3YOu0f4Z1OULYW0zY2KDGoIcuUTCeJq6gJq
         Sqt0ZBSvBEJZvX2i6+TUaUOtDVcf1u4v/kd16MP3swWWafknTw+oEEe5pfWVisnuF2/Y
         oBow==
X-Gm-Message-State: ABy/qLZc5R50YRsgCHgN1blcbfra7QJ0qh6Pvu57YrEQAG9Q8UfJJY3T
	SZNpC0aTlqRypQemHNbUAtz7PA==
X-Google-Smtp-Source: APBJJlEwZvOZFx9jGjKzTSquavLLMGpfSvcqz9eU7eg6dlZXcBSsj/oLHuzFIs4w1OrikNKIVtKqsg==
X-Received: by 2002:a17:907:1186:b0:991:e12e:9858 with SMTP id uz6-20020a170907118600b00991e12e9858mr9809390ejb.64.1689574780367;
        Sun, 16 Jul 2023 23:19:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id lf16-20020a170907175000b00993928e4d1bsm8710466ejc.24.2023.07.16.23.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 23:19:39 -0700 (PDT)
Message-ID: <793b6cc7-f939-a889-1e4c-6ed8ff857e5d@linaro.org>
Date: Mon, 17 Jul 2023 08:19:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: i3c: Add mctp-controller
 property
Content-Language: en-US
To: Matt Johnston <matt@codeconstruct.com.au>, linux-i3c@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20230717040638.1292536-1-matt@codeconstruct.com.au>
 <20230717040638.1292536-2-matt@codeconstruct.com.au>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717040638.1292536-2-matt@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/07/2023 06:06, Matt Johnston wrote:
> This property is used to describe a I3C bus with attached MCTP I3C
> target devices.
> 
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> ---
> 
> v2:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof


