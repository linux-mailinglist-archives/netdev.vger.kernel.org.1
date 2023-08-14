Return-Path: <netdev+bounces-27455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E674877C0EE
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8F8281215
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70BCA7E;
	Mon, 14 Aug 2023 19:41:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1685CA4B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:41:19 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F510E5
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:41:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so42681255e9.3
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692042077; x=1692646877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlkRphW99TUQjmsLQhZVnE2TXQQ32GbCiM/RRZT7IL0=;
        b=TZwIG9hlRrAaevAKoGITPcyiUCy9/dOP/RfJNRnD8rCEY64TEMkk1dqlPM88cKrDTL
         ueDj5TjLkeglROwOO1zYus7MaMO4aNSAJe/9LcPGePJ71h36Eouy0oy5szJLNsOVKtWJ
         2uYPscPayIA4YVZQkW+l93f+FkVSF6F5FFw7L9RJrNmi1hEgKtFi525ZzwIOMJROdXow
         Hgqe4mkM44ZGY7ug7OqQsg+DXxBVFHRzMjJysZHirpqG6dExNur+J23TX+dm6JeTkG0b
         mxekx1U6HHryASrvDDhOfQsgzxid0fa7ZTyGhqSID+mArig9aA5gyNtStjGA7wzYRl7I
         /DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692042077; x=1692646877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlkRphW99TUQjmsLQhZVnE2TXQQ32GbCiM/RRZT7IL0=;
        b=kj0UDk66kf3oFapOJLZrYIAgmXss0lOO5oH4SGFy76E6OCAAkWhAFIMRTDGmJb0R15
         mS33pW0x0cOFfAiC6fhfA5m/aIPsKWCUm3C3GkOEXWXH+0ga4thhgtz2ij6ZRcUKy2Ah
         jizjsh/Ct+hJeLS93VuDPoryq+CqkdarLl52i/fvx1SICiKbF5pvLxSfse3Z3qLP48Ki
         eaQ1Wt2XaTGBUDlvemjDTKBl0pHJJRG2VhmJfSEAbhtLEGgMIbD5qgVF2DbOiaWgddm/
         TEvRFPe36jqLSabQowlx6uP/FmyEW8a0tfPcNb5VitqL1rX6jnhXNv++mAFSu/xSJr5R
         XIEQ==
X-Gm-Message-State: AOJu0YyeVJgcpgsqjTuLoCpd6aMILrqSxeUb9TkNWVh2dcXX1XbEjo7O
	zKnuU7OvJK+6uNASiRHRO5/1XQ==
X-Google-Smtp-Source: AGHT+IF5YrLzgnKux/XfX0ddvCVBGHZoDjc5aUCzOkanpW7tRsK6Gst2cYveMpl0sstGRpKdZK++WA==
X-Received: by 2002:a1c:7717:0:b0:3fb:dbd0:a7ea with SMTP id t23-20020a1c7717000000b003fbdbd0a7eamr8370041wmi.37.1692042076983;
        Mon, 14 Aug 2023 12:41:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id k13-20020a7bc40d000000b003fe1cb874afsm15043180wmi.18.2023.08.14.12.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:41:16 -0700 (PDT)
Message-ID: <1ada88be-45db-1f38-5e08-daf4b544bb6b@linaro.org>
Date: Mon, 14 Aug 2023 21:41:14 +0200
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230814112539.70453-5-sriranjani.p@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14/08/2023 13:25, Sriranjani P wrote:
> The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one in
> FSYS0 block and other in PERIC block.
> 
> Adds device tree node for Ethernet in PERIC Block and enables the same for
> FSD platform.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi         | 29 +++++++++++
>  3 files changed, 94 insertions(+)

Looks duplicated.

Best regards,
Krzysztof


