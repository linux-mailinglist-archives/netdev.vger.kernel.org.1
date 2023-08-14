Return-Path: <netdev+bounces-27462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BE077C11F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDCF1C20B2D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFA9D510;
	Mon, 14 Aug 2023 19:56:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205D5687
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:56:47 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8266810F2
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:56:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bccc9ec02so664171166b.2
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692043004; x=1692647804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nok+x4rAaoA66YfdKSul17+hSDqui/hoTkzkEnvOsak=;
        b=LzejYZismv9otFUW9sYB9GRVEaob91IcaZzY149ALyRmA5jqtz9T23PAggKnM/v8z/
         hsJlAc8Zu5Jtmg/lOwEZ/8xHdvCQMtCb7R9zxWVq8XmhEOkw6PHW5nlNf8hfCz5JpA/6
         +KOgQbhRKtU4PLhIBDE4YYoQ/+lWbUUKYr99AgSMsNvzMsSCF7iitujt6wK+OIKDXpMy
         Vr+cb8+xrYJT7V2tqcpxOW1/JvAhGTDGTuBDD9iLmPXCwEUkXArQeRen34niZJRdD3EH
         blPMM1dYUsmMyHcXVxQdeLWI/TOBBHnrdW0rbGA1U8dh0+tDL+tsPmn5JvH+tG2zoYMI
         xLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043004; x=1692647804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nok+x4rAaoA66YfdKSul17+hSDqui/hoTkzkEnvOsak=;
        b=WsOoICgSyJ0LWb7s8cc7x/VRGRWETfzG6V/4mUaKscxCfy15RyVvXWNK11I+YVFYxN
         X7XRkLXsSpB9hpeEWHp6DYVsVfeCno3BfKaJzIT9bMUTnTNtnMzm0OPu1CMklaustBGv
         7SR4GQ56BlgRtBUQtY0gr4tj961Me+I2x8Et7fd6EdYQgOy6rqVbRPn0EQg0cTaf/cwN
         pVSJ87G7MYa1l52SA7Y2qnmCmjH1AayIjVghar2NKeWwQOm51TP6ThVWhvhNbACRLL7z
         OInI+4oerQCzBuaFuvJovL8fDlvSLCUseI+0QeDs2HH6zjpIWLv4R5NUWal4yKEacOba
         FGDA==
X-Gm-Message-State: AOJu0YwKeLGUYFwnQAzrBIOAdrBCHJ+t0dt5wrzZpa1h6WRiw1Jl/QRs
	YLdtJ/E/OrgMznTBWJvjkA+U6Q==
X-Google-Smtp-Source: AGHT+IF+xA1+FyUO9foiefiY3Jz8QtEmKZYsiJnOt9ZxqPDwExjQixI/+6KjrTEJTDYH2+oRvOg4pg==
X-Received: by 2002:a17:906:32c6:b0:99b:415f:2e4f with SMTP id k6-20020a17090632c600b0099b415f2e4fmr8726890ejk.57.1692043003925;
        Mon, 14 Aug 2023 12:56:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906670b00b0099315454e76sm6021723ejp.211.2023.08.14.12.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:56:43 -0700 (PDT)
Message-ID: <b3cd8115-b2bd-63dd-01d3-3cd27127d534@linaro.org>
Date: Mon, 14 Aug 2023 21:56:41 +0200
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14/08/2023 13:25, Sriranjani P wrote:
> The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one
> in FSYS0 block and other in PERIC block.
> 
> Adds device tree node for Ethernet in FSYS0 Block and enables the same for
> FSD platform.
> 

...

>  &pinctrl_peric {
> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
> index 1c53c68efd53..9a991f021711 100644
> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> @@ -32,6 +32,7 @@
>  		spi0 = &spi_0;
>  		spi1 = &spi_1;
>  		spi2 = &spi_2;
> +		eth0 = &ethernet_0;

One more thing - I said it two times already. Patch v1 and then in v2.
You responded now without waiting for my further feedback and
immediately sent the same stuff.

Let's be clear:

NAK for the reasons I said multiple times.

Best regards,
Krzysztof


