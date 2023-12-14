Return-Path: <netdev+bounces-57614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C40D8139CE
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798D82830E5
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C037468B83;
	Thu, 14 Dec 2023 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAgstMJo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5293311D
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:18:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50be10acaf9so939497e87.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577902; x=1703182702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUXxNIE0oyhaGNjYhqDm71JIvcw2/l7lxWAlHlBLujc=;
        b=kAgstMJo59Uulo15INN4HDJUpYM5JnIK6OhLAqGBKXFXoFlG5KzO0OKnGvj4x4U1Bt
         99U6Uvg4F/Zk1hRyp2EmW80qYBzV5GpZEbazT3cPB6GdhyfI2vcVP+4zQfavpPs0nE7M
         U8V/ngLyCpW8C5xBQEv5+IExNEGawEBMITF0FyCrq919AnehwLZsPVTQVUUdGk7IOuTK
         sAPpyuluR7T+QQxIqxbKHFT0N0boAPJXS83QT5uW5RDGvkZl2sRO3pNENlzq/BNMDq/Z
         eiweJL7VX7z7LWsbTokpTJTJuaLxe6UQYEDWr7d4GJKkbUuBsI1XmZmhuatJ0aPW+SKA
         mdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577902; x=1703182702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUXxNIE0oyhaGNjYhqDm71JIvcw2/l7lxWAlHlBLujc=;
        b=fQgAfvCUKZUE3hC+GBB/fL8eG0h/p49Z83lmjBqlGhp0TFIHf3+u8ZpiyDUq6pJ+B1
         pEitnVX77pj15qb28SC7JZkVgAQtFUnckL9aUlt5xQzTZ5LWaXxddvU+zD/MBhFTvfeD
         YcgPtzA4TAnmhKmikLBs7+d3VAhIZTOowpkK+Xhq3R27U/8PJ2Xd6bMPx6G7sDsK0FWQ
         JutjzAOWr8yxmKOGUzl0EFsfZZBuRyiyl3UQ3Rnj1otpXQqZTYR8Te2nG+XYYAO8Zths
         kW3xwcMhW0iIzRWHjD3R6cyQE5vL4Q/QT/Y7AFBOoop5VfXedECsfnJvTPgR20OFuVRw
         ygyg==
X-Gm-Message-State: AOJu0YzYS5BVF2gGiCNUQp40FsxXPuBXT4PVi/RXFnyt61MjeRC8Mf8i
	cidGyJ5bG4ZQbpQC27ytwLVsqQ==
X-Google-Smtp-Source: AGHT+IHPvoFv9KvPlT+AD1GWaLtelWYGlfY72peH/oBCnqzIcbZPrWCVcWP96N2Eo12F9Pm8pvzRCA==
X-Received: by 2002:a05:6512:398f:b0:50e:15de:9931 with SMTP id j15-20020a056512398f00b0050e15de9931mr1257549lfu.24.1702577902567;
        Thu, 14 Dec 2023 10:18:22 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c16-20020a056512105000b0050d1a0e7129sm1659686lfb.291.2023.12.14.10.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 10:18:22 -0800 (PST)
Message-ID: <92e9039b-a0e3-4f93-aaa8-226ef9e8b613@linaro.org>
Date: Thu, 14 Dec 2023 19:18:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: ipq5332: add support for the
 NSSCC
Content-Language: en-US
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
 <20231211-ipq5332-nsscc-v3-7-ad13bef9b137@quicinc.com>
 <c4034715-53a5-468e-914a-3f19d0618c42@linaro.org>
 <8cc2a8ec-632e-4e3b-b13b-d1523a61c136@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8cc2a8ec-632e-4e3b-b13b-d1523a61c136@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: *



On 12/11/23 14:28, Kathiravan Thirumoorthy wrote:
> 
> 
> On 12/11/2023 4:02 PM, Konrad Dybcio wrote:
>> On 11.12.2023 04:37, Kathiravan Thirumoorthy wrote:
>>> Describe the NSS clock controller node and it's relevant external
>>> clocks.
>>>
>>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> index 42e2e48b2bc3..a1504f6c40c1 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> @@ -15,6 +15,18 @@ / {
>>>       #size-cells = <2>;
>>>       clocks {
>>> +        cmn_pll_nss_200m_clk: cmn-pll-nss-200m-clk {
>>> +            compatible = "fixed-clock";
>>> +            clock-frequency = <200000000>;
>>> +            #clock-cells = <0>;
>>> +        };
>>> +
>>> +        cmn_pll_nss_300m_clk: cmn-pll-nss-300m-clk {
>>> +            compatible = "fixed-clock";
>>> +            clock-frequency = <300000000>;
>>> +            #clock-cells = <0>;
>>> +        };
>>> +
>>>           sleep_clk: sleep-clk {
>>>               compatible = "fixed-clock";
>>>               #clock-cells = <0>;
>>> @@ -473,6 +485,22 @@ frame@b128000 {
>>>                   status = "disabled";
>>>               };
>>>           };
>>> +
>>> +        nsscc: clock-controller@39b00000{
>> Missing space between the opening curly brace
> 
> My bad :( will fix it in next spin.
> 
>>
>>> +            compatible = "qcom,ipq5332-nsscc";
>>> +            reg = <0x39b00000 0x80000>;
>> the regmap_config in the clk driver has .max_register = 0x800, is this
>> correct?
> 
> As per the memory map, 512KB is the size of this block. However the last register in that region is at the offset 0x800. Shall I update the max_register also to 512KB to keep it consistency?
No, it's fine, I just wanted to know if it's intentional :)

Thanks!

Konrad

