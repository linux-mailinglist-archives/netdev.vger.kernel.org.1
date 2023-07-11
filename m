Return-Path: <netdev+bounces-16803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544874EBEC
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6341C20DF5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0332C174CD;
	Tue, 11 Jul 2023 10:47:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEE74410
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:47:01 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D46E6F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:46:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb7589b187so8829027e87.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689072417; x=1691664417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1G2QCPO5qYJSFYYMmReBO6Vbw5wgGsf85elL+w0M7HA=;
        b=ZdwnaGV99mbFcQ2MmcdZ8aPTzU/rWHB6kmIpJH6y3ydgQ0I1i1mYo6uRVBcJiC23aB
         RoH4MHqOzn0F/3a5x/39IsHlI2kmsixfzBIJlWdZR8HM0jUNa8zNYGSmcJagAxKPYAXF
         2aTyxTPaXPPhmU1tHAsFMDrzH7j3oXZYs2KXM0ZceO78B3Y9hGAcQEhvW0vbZVoVa4Nu
         rLFQgf/cLPk9BUzFgVPdXQIrV1erREr32nyUvu/8cwPFD7TG2BJLo1cEe6kdUM/Ii+wb
         niW56vrmySHbRKIzBvB0MPWD3a3IbpMkUAHN+j4gPij7BuwShaLiGb+5loVnF4+p8Gwd
         7WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689072417; x=1691664417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G2QCPO5qYJSFYYMmReBO6Vbw5wgGsf85elL+w0M7HA=;
        b=gVjFqVWkAKNGMxNWlFol/yDfe8lnjpgCBqNYAowv9Pg3s4+NPbUvskkcCv4A4MWdaL
         +K5FPs2cbQw2JH0vtQMMBtlHfCYQNysbE+zub06HwAwiB55+crsiE/lfHXix8zLNtp4Q
         IA7rHHcbsuhEez/Lc1HcEiRwrcT/9NLRmNCZLciRLzsJhkEUlWMo6082BzxOy3aDUgnl
         fZP88UeuwJ/S+kiVujnnlpe533R7p84XvXWE6CbLk4Ueot8k6QngVXReVkbhm+sOl4EE
         rBDlzn8iYwQRJsuRl0e2nLqJNc2AM5CWAUGJTVbHtOrCr99QiRHkmoB8T68t//OB29es
         Cy/A==
X-Gm-Message-State: ABy/qLaF+OWgeh3Uu+BcZA1vt1Gl/N/N32HIro08sWcmZB8+q0GPqZzb
	QMD5nOQs5EoSv829EIauJHFDLQ==
X-Google-Smtp-Source: APBJJlGGtOSmaBuFLF6puXF4cKfrRVCjXBB9xwyZodKGt6AJk2t1G49mfDFJEjOY4VLOAen1V5DhFw==
X-Received: by 2002:a19:7714:0:b0:4fb:8953:bb8 with SMTP id s20-20020a197714000000b004fb89530bb8mr11290246lfc.50.1689072417450;
        Tue, 11 Jul 2023 03:46:57 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id e12-20020ac2546c000000b004fb96e2b3f3sm268066lfn.165.2023.07.11.03.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:46:56 -0700 (PDT)
Message-ID: <49e24e0c-978b-6249-1ecc-bd485f5f90de@linaro.org>
Date: Tue, 11 Jul 2023 13:46:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/6] clk: qcom: clk-alpha-pll: Add NSS HUAYRA ALPHA PLL
 support for ipq9574
Content-Language: en-GB
To: Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 p.zabel@pengutronix.de, richardcochran@gmail.com, arnd@arndb.de,
 geert+renesas@glider.be, neil.armstrong@linaro.org, nfraprado@collabora.com,
 rafal@milecki.pl, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: quic_saahtoma@quicinc.com
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-2-quic_devipriy@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230711093529.18355-2-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/07/2023 12:35, Devi Priya wrote:
> Add support for NSS Huayra alpha pll found on ipq9574 SoCs.
> Programming sequence is the same as that of Huayra type Alpha PLL,
> so we can re-use the same.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   drivers/clk/qcom/clk-alpha-pll.c | 12 ++++++++++++
>   drivers/clk/qcom/clk-alpha-pll.h |  1 +
>   2 files changed, 13 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


