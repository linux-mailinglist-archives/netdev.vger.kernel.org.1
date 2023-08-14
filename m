Return-Path: <netdev+bounces-27456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF81B77C0F3
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FDA280E46
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881E0CA7F;
	Mon, 14 Aug 2023 19:41:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD25687
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:41:58 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9DC10E5
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:41:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso44140765e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692042116; x=1692646916;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hWVokt/CwUyrFGLpSEZU7jNylhLXHRK0ucHWHSV3+I=;
        b=TUKdKob8s0T4JkeeDvT2dwa/tAVm1CqbadyrTRnxa2IyDq45IUs0P9sEW9ak6SMtgo
         1iflsz9PnPw9auzulLS72OisiSeffETp0ki6FH2/Y7SK89qbuA11pWT7RwXZ6hpV1Yxj
         W/9xWndQTr4Wl0hbN2lO7LxVKa8DMfZq0J5jWre84hqkR63wpu7cjlKJ/4vYdlW+1RjN
         MV0HpPpVW1R8qyHkFMu8yg9f1sK3/pLyUGyqne54imype5AVfb70csLNauvHHvP5WPND
         er5RusW1g7jMG3e2B5X/Scx70aQRAYXpwRO8izMi4S91t9MulmSU9aFuBp0UwqPNJ+1i
         Toyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692042116; x=1692646916;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hWVokt/CwUyrFGLpSEZU7jNylhLXHRK0ucHWHSV3+I=;
        b=aXyGcOyWUpr2+0f/xuKjsb+lR1xrnZmTBUMeWO7wmzH2xIroROu4/oDkbU+rv4rTrS
         e2rHUNBDKUSLMxUPOiAdWd6vQOp0vAa+hz4otLMhikEq1+N9oc0HgU6ULcpEBd4pQnE7
         PGfO+h/79XEffdSkQOjMZj/5PKHIFoxiWEQEzuVNONTSd/syVw6O1f61ZKZvGlPX4Kfy
         dUkqpekHFTvgaSz0VAcr8Ooqoi5vbMrTaCPooS69ekeXqnILgj0q8Nvm6/tHXvY2B0v/
         EqrhRfUB+ZkYEAJi5iABezGk4djdh6uI6eIkJacy9bz572lzpIqKFeJWg3S80/CUd7Wz
         5lGA==
X-Gm-Message-State: AOJu0YzkKxOsKG+oLVyYRk4Ve5l5CHPr34SCoYx2cohOmxVqToICjnsu
	AZRQ8hJDS+nlWVA4LlNNU/kx3g==
X-Google-Smtp-Source: AGHT+IG0u5gtxp32TUl77yAObK7hqWwBKPwbNr+WC1w31y4c6uk0yZmWJwLX5Q0Imes/bQTO1MKiEQ==
X-Received: by 2002:a7b:cbc7:0:b0:3f6:91c:4e86 with SMTP id n7-20020a7bcbc7000000b003f6091c4e86mr7729047wmi.3.1692042115963;
        Mon, 14 Aug 2023 12:41:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l4-20020a1ced04000000b003fe61c33df5sm18296228wmh.3.2023.08.14.12.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:41:55 -0700 (PDT)
Message-ID: <ae1107f7-d48e-d89f-4de9-f8d01abcc3e2@linaro.org>
Date: Mon, 14 Aug 2023 21:41:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sriranjani P <sriranjani.p@samsung.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 richardcochran@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
 linux-fsd@tesla.com, pankaj.dubey@samsung.com, swathi.ks@samsung.com,
 ravi.patel@samsung.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jayati Sahu <jayati.sahu@samsung.com>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112625epcas5p1e1d488a590bfc10d4e2a06dcff166037@epcas5p1.samsung.com>
 <20230814112539.70453-5-sriranjani.p@samsung.com>
 <1ada88be-45db-1f38-5e08-daf4b544bb6b@linaro.org>
In-Reply-To: <1ada88be-45db-1f38-5e08-daf4b544bb6b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14/08/2023 21:41, Krzysztof Kozlowski wrote:
> On 14/08/2023 13:25, Sriranjani P wrote:
>> The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one in
>> FSYS0 block and other in PERIC block.
>>
>> Adds device tree node for Ethernet in PERIC Block and enables the same for
>> FSD platform.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
>> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
>> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
>> ---
>>  arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
>>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
>>  arch/arm64/boot/dts/tesla/fsd.dtsi         | 29 +++++++++++
>>  3 files changed, 94 insertions(+)
> 
> Looks duplicated.

Ah, not, it's another block.

My question whether this was tested remains...

Best regards,
Krzysztof


