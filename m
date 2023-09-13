Return-Path: <netdev+bounces-33482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A4D79E211
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1C4281E94
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D58B1DA4F;
	Wed, 13 Sep 2023 08:28:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B79D1DA4D
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 08:28:35 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4224198C
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:28:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so388262166b.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694593713; x=1695198513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcjHciOEB4wGjPRxzcQg2KY+X5TWNjgyiN/R9k87O0c=;
        b=r4c+LgDtyRnIYnVX5kB0Ld6hWveQwM3R7EN91ItGr5ztAj4zFfAYQFsDLL++ZV94+0
         unqxsKYkryu+33jTQQQlVjo+aCSXoIbsQFMTI8ZO9f+sYo6/UALGkgVx6hJk5Zrxj19X
         X1AQ5e2hD4KBp7yfwq6lkRFX3lOQ83N1XCb6K2lPQsqgNrnylCpzSZXAj/Z7TyJmIDa3
         i5XO7G9bn5bfOSVcME51KCIypZ4sanPYi261yvKfSBc9+ffTNM870jed+BA18Lk6wlCF
         PRVTm/58rYNABMIcYQ5OWrSz6AHiDOenlBUzOPTWPyfGZ8iceW/sIzHSyQ1hw5xf9NXl
         6u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593713; x=1695198513;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcjHciOEB4wGjPRxzcQg2KY+X5TWNjgyiN/R9k87O0c=;
        b=X3U1pTXktXWz9ZjFt4pK//O9GxslNuPxK01xnsiMsW2c5fzhnOY1wN/BjTuEVFlCbD
         jg/ToZ+JAPlBPVZikMusOjbzAvoG14cae0X7pBaxgNjiUWXvXbH176/AxCUkUY4wjcOj
         Gw9dDWpbrv85oAm7MvO/s1Uoq67jTSeutsErCeGjgaFW78JgHfDQ/k9vX/hIHRmDv01P
         t928z2YSrxIRX1vf5briOTlkoUAIrvKuLfrPKfLXdMky1kBUFMw+Zvryh/v9rkNzHola
         MH0N9KxUC6LymLB69IrcXUkwluSLIIFOCp2gJnrjf/q1amEx8u//Ko2iaYeuLKfTN0Rg
         bdBw==
X-Gm-Message-State: AOJu0YwgxIorW97LoIgTIiLDLrLp6Cv84dyRMtsl77sUP84AoUAYy1Fj
	uID9zpWEhjFMrrW7wjIRJPUCpw==
X-Google-Smtp-Source: AGHT+IFmMNDnYGHGyTxB2kTvPlHFBu9w/k0OtnoM7DCf7UVubTFyWhLBTkhY65paoCVkLDhe1SCRYw==
X-Received: by 2002:a17:906:5188:b0:9ad:99a8:7c4e with SMTP id y8-20020a170906518800b009ad99a87c4emr1463772ejk.55.1694593713320;
        Wed, 13 Sep 2023 01:28:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v14-20020a170906338e00b00992b1c93279sm7936294eja.110.2023.09.13.01.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:28:32 -0700 (PDT)
Message-ID: <c6b473a0-3576-9cac-dfec-126f3cc5803a@linaro.org>
Date: Wed, 13 Sep 2023 10:28:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 4/7] dt-bindings: clock: Add ipq9574 NSSCC clock and
 reset definitions
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Devi Priya <quic_devipriy@quicinc.com>, andersson@kernel.org,
 agross@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 p.zabel@pengutronix.de, richardcochran@gmail.com, arnd@arndb.de,
 geert+renesas@glider.be, nfraprado@collabora.com, rafal@milecki.pl,
 peng.fan@nxp.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: quic_saahtoma@quicinc.com
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-5-quic_devipriy@quicinc.com>
 <29a968e9-9c6f-034d-35fe-71c42b5d7cbb@linaro.org>
In-Reply-To: <29a968e9-9c6f-034d-35fe-71c42b5d7cbb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/2023 14:30, Krzysztof Kozlowski wrote:
> On 25/08/2023 11:12, Devi Priya wrote:
>> Add NSSCC clock and reset definitions for ipq9574.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>  Changes in V2:
>> 	- Referenced gcc.yaml and dropped the duplicate properties from
>> 	  the binding
>> 	- Updated Uniphy clock names
>> 	- Added nssnoc clocks and clock-names
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Rob's bot report is a result of patch #2 failing to apply.

I assume changes will be needed here to drop clock-names.

Best regards,
Krzysztof


