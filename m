Return-Path: <netdev+bounces-48112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3647EC923
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441AD1C20BA1
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F633063;
	Wed, 15 Nov 2023 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxVRDLQH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87A3175A
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 17:01:26 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A19FA
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:01:25 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c594196344so91420121fa.3
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700067684; x=1700672484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nr6vuhfPEics7daBdGQpqD1rLR5BjzbdvN+08xBD+q8=;
        b=AxVRDLQH+RVBookmP+3DwqtfiQuAunIROpp+gwEgC1RcI7bt9Rtv4PXWqg03juw3JU
         BI8CBoBGlFZJnThxL1X5MbXULEiArII7Yenoz+fMBXRxbQk2C8IZsaWfDvx/mM7Ox8gG
         RZVkdE+f2OwqoFn5oAajapplo4hSgsQDtFIn/NgoDc0kdCniEs4Kc3RD0u4JeVYhyaj2
         EDbLFaKyz1N2WStEFDIdKcDWtwj4eVclNJl8z/APb5Z1Dz1ZUw+Z35kKSNFuW5JYaJHw
         eQqDB327sZwX7liyASR3OvS28PnnUAjuX4iPdEvDAppEPZhGTbPPxQnv3hBMa1s20YI3
         be+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067684; x=1700672484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nr6vuhfPEics7daBdGQpqD1rLR5BjzbdvN+08xBD+q8=;
        b=Ip9skq3vGTbX+R/qko3amgEsgNvOOP0jbVZ6dA4orcD7U7+5w3uMKPWHjPYikSoBjG
         PKb7L6/rfPvXstYLhJtHDQayK8PZyPqcYeIFMePTd+2yl4H8kCOGa8nt0YFSx7UTt26o
         YF7W6OIVftSAHnjY9rVQzKgk3T3n5I5YBchYFVWYF3Sl6MDcFYSo2+AqujIfhzgfzzTq
         73Tg8L/JC3yZV/eWAGvBTJCDVwRZSLfNu3ptM5J9ANCKGWqHvTBsgkTnjt4088ViG3Vf
         OJKQnjZGyQYDywz9/dg9iUoSGjCzq6lQg6sDhGx/hADipWFzsEjs6qTSKwm9cgtzWE0n
         1YBg==
X-Gm-Message-State: AOJu0YyqJQwn9AqOK1B3rgXEJSyNAUSEVghkHoCeNX2rOwstm4XpD+vu
	uixx6MeW1fPBqw9qi6vp0MjQFg==
X-Google-Smtp-Source: AGHT+IEPUYkKyHBiFfTLuh8TKtrGvK9xxvJ/BsN6m2FxavNOkoOEWZwhNsaG6LdlbntqkUILzUlnCw==
X-Received: by 2002:a05:651c:1a24:b0:2c5:2eaa:5397 with SMTP id by36-20020a05651c1a2400b002c52eaa5397mr5131497ljb.11.1700067679053;
        Wed, 15 Nov 2023 09:01:19 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h24-20020a2eb0f8000000b002c00da5c522sm1716220ljl.78.2023.11.15.09.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 09:01:18 -0800 (PST)
Message-ID: <cb4131d1-534d-4412-a562-fb26edfea0d1@linaro.org>
Date: Wed, 15 Nov 2023 18:01:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] net: mdio: ipq4019: add qca8084 configurations
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Luo Jie <quic_luoj@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-9-quic_luoj@quicinc.com>
 <a1954855-f82d-434b-afd1-aa05c7a1b39b@lunn.ch>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a1954855-f82d-434b-afd1-aa05c7a1b39b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: *



On 11/15/23 17:20, Andrew Lunn wrote:
> On Wed, Nov 15, 2023 at 11:25:14AM +0800, Luo Jie wrote:
>> The PHY & PCS clocks need to be enabled and the reset
>> sequence needs to be completed to make qca8084 PHY
>> probeable by MDIO bus.
> 
> Is all this guaranteed to be the same between different boards?
No, this looks like a total subsystem overreach, these should be
taken care of from within clk framework and consumed with the clk
APIs.

Konrad

