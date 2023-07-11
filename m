Return-Path: <netdev+bounces-16792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC7574EB4C
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6ED1C20DC4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6C8182AA;
	Tue, 11 Jul 2023 09:57:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B4182A4
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:57:47 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6919C172C
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 02:57:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e6113437cso1280208a12.2
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689069456; x=1691661456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWka34Gw82nr/cFSWzXWk0N4X377rpeIdKu/sRdqI3w=;
        b=E1S24mQwOCmHBBy4DRz23P23yqDhq4uQrWy8X+IpX1HgWvgkeoZGsrBB2i8xYNJHHM
         xlurGXGi5+SjP8v3G/hEvZe0C+M+f66ThjHsH4P+pX9c/3M8Fci/ZNBvMek7IyA4HTOJ
         MPMOXUu1nCzSWFL+cFpgZFhVMg5sftDhY0mCg11oRSjMlEK4wlQlhOuHPb19J12NtjU5
         1kVvl4of2Hl53/F0KLI/r7bxd+x3RAmU3+D3Adf/AvZZxcXSaFO1plhemYa++54LP1bY
         XjL25qbN6DhcAUZ0tjQ4rFYbrxcgRjqztmb0BYCyRB/+W7zvT4v7c25HXZYcgzLcsrTL
         Sp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689069456; x=1691661456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWka34Gw82nr/cFSWzXWk0N4X377rpeIdKu/sRdqI3w=;
        b=Njf4pMVm9nRkb+js0Bg24oFQe/Yd2nVdguDTkB3WyDwolOxJXszbN5ixe/FxX1kKKC
         No2jyCGvi/3bFPoNVeOg1XUknXBGk1TI939WfNKCWpO6BKceeiojejyv68EcOiBz1yO9
         H5z3RQI2GxZeCEy7WuiOk+vvmQ8YIchm7mgZJsfKdTX+x1Se3q2Sw85Vby/p9y710TkB
         wh/1a+0+Tt+GsW0OkbhZbCC9z11CWopkrwrj4XniKKg679UkNb+n+akMeTeD/cMJejAZ
         gDlhKiD8taFEbNXCdhfjPTW28p7lczoOMupSik3P+UAPPU/Jrf7N12XHr8FLdpX9LPaL
         8Gtg==
X-Gm-Message-State: ABy/qLbQzuUyieb8mwTeICHosQhrV9siSjneQip82o8HBI90FzYKKgDY
	l/svq38QYKUcn/F4nK3xK3sBEg==
X-Google-Smtp-Source: APBJJlGrct9CF3NdgozgtT88PsYl+iuo0rr8yPDlmRTaY5g+azPTKOqK7kxmUAT7dEu+Y7gYM6DatA==
X-Received: by 2002:a17:907:12ce:b0:983:cb6c:8aa3 with SMTP id vp14-20020a17090712ce00b00983cb6c8aa3mr13056484ejb.59.1689069456550;
        Tue, 11 Jul 2023 02:57:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906354a00b00982be08a9besm926457eja.172.2023.07.11.02.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:57:36 -0700 (PDT)
Message-ID: <05554015-6b08-c194-9d27-af5539e3ce46@linaro.org>
Date: Tue, 11 Jul 2023 11:57:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq9574: Add support for nsscc node
Content-Language: en-US
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
 <20230711093529.18355-6-quic_devipriy@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230711093529.18355-6-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/07/2023 11:35, Devi Priya wrote:
> Add a node for the nss clock controller found on ipq9574 based devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index f120c7c52351..257ce4a5bfd5 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -10,6 +10,8 @@
>  #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -17,6 +19,30 @@
>  	#size-cells = <2>;
>  
>  	clocks {
> +		bias_pll_cc_clk: bias-pll-cc-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <1200000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		bias_pll_nss_noc_clk: bias-pll-nss-noc-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <461500000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <353000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		gcc_gpll0_out_aux: gcc-gpll0-out-aux {
> +			compatible = "fixed-clock";
> +			clock-frequency = <800000000>;
> +			#clock-cells = <0>;
> +		};

Isn't this GCC clock?

> +
>  		sleep_clk: sleep-clk {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> @@ -620,6 +646,24 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		nsscc: nsscc@39b00000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof


