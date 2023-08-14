Return-Path: <netdev+bounces-27454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FD777C0ED
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DB92811F2
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5B2CA7B;
	Mon, 14 Aug 2023 19:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104BC5687
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:40:58 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E48510F9
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:40:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so42772855e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692042056; x=1692646856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnT4YPa8nNOE82Rm8E36xDO3rg3Ol06s32kJVf5CeCo=;
        b=V28BKbrgWZl0am8yS4+7nWM/U21DC779FhQWXYexL4DPpn3wh3IzS09EJDBkM0VPbd
         0EHAExRsn3PaMz/jg8P7I/Vb7N9i2rd0vTzHOwPbP2QzlWR6VxNMa+QA1AjTawqGcDvP
         ldru+5sWquL0o0rHdPSVDiMIA85f1E6Q6BDjdVXWngbHIEzDOfRBrJjoY17Ff0tAcUxc
         8cqbu3lM6n301EIdG2vAynJkjQOJoQ5/WM23g4lEGrjmYzj+9co9TIkui6up2JNpO50f
         mDAatDbSWMnJ0IpMsvzxOGPtTpuHqBcaoh7ulzyeP+YKJCthLKBmX6d8xSxPpT/Sw2q+
         JODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692042056; x=1692646856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnT4YPa8nNOE82Rm8E36xDO3rg3Ol06s32kJVf5CeCo=;
        b=OLvii8MoGmvY1FGuxqVe7rDA8e4ULFi1geNuEmKxyJaCjwDcX7PdlfTR5gHYrwAsLF
         GcFA2zIx//bECrp4GftRyURzd/nORT5Drf0QoGpUkqKQDgMGiNKjpdQRv0/1Op9TtDI0
         RTFtH9Hf70T6AK1tNAObcAV38+W7UnXS+x9x4yvWkLJGha/eZXqcgYVXHElFM/ALOD3U
         Mhlzpbqdszttvhiqc6FGDmQK8vhwZ9cRPID/8iTKDga+TkDkXdClHs4b2OB6ODdztbJz
         r47imzE+goeaxdi5DYcY0Bhb+yoi/SBktdBWjYNqfzHsobj7xCT5lUtzRwZR59nvC5ny
         pnEg==
X-Gm-Message-State: AOJu0YzY9VWWNEvLfgFx1RpUFTZ14L3tpzf2ULJlcli7qn2XTOV0fBBU
	na2Sa5wB3tjPRO/BZIDHAk+lbA==
X-Google-Smtp-Source: AGHT+IFd4SakSpwe9eeXaVG5RHlJCYmoIG50o6eXgR/xz0Vjp4SEK6gcRxpVfXDJ2KQxaTO1UWhQAw==
X-Received: by 2002:a5d:484b:0:b0:313:e735:6d23 with SMTP id n11-20020a5d484b000000b00313e7356d23mr7754700wrs.22.1692042056076;
        Mon, 14 Aug 2023 12:40:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id f17-20020adff451000000b00317efb41e44sm15376508wrp.18.2023.08.14.12.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:40:55 -0700 (PDT)
Message-ID: <f694a5fc-8d84-4000-1bc8-ac6e6e75f404@linaro.org>
Date: Mon, 14 Aug 2023 21:40:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Content-Language: en-US
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
 <CGME20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28@epcas5p1.samsung.com>
 <20230814112539.70453-4-sriranjani.p@samsung.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230814112539.70453-4-sriranjani.p@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14/08/2023 13:25, Sriranjani P wrote:
> The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one
> in FSYS0 block and other in PERIC block.


...

>  
>  	cpus {
> @@ -984,6 +985,27 @@
>  			clocks = <&clock_fsys0 UFS0_MPHY_REFCLK_IXTAL26>;
>  			clock-names = "ref_clk";
>  		};
> +
> +		ethernet_0: ethernet@15300000 {
> +			compatible = "tesla,dwc-qos-ethernet-4.21";

The requirement for entire Samsung and its flavors is to pass
dtbs_check. Since some months.

Does it pass?

Best regards,
Krzysztof


