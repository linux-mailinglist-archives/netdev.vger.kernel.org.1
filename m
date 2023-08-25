Return-Path: <netdev+bounces-30644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2B87885BF
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBA42817ED
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0200ED2E0;
	Fri, 25 Aug 2023 11:29:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D4CA6A
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 11:29:00 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE5F26A5
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 04:28:37 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58fb8963617so9339567b3.3
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962914; x=1693567714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DeMuSlxUtzQfWCufq9OumalQo8UgVgjecOg8zY7pRu0=;
        b=VENurXBZvcjbdL1mQlZRrpfxE/b/BPdhZCOflTBLiaOVdOgIb/88bM58+C27fiWcIE
         wsh9ykLWOSRadrMWNF1O3+qzEOlMYlZjJDp4Ce7zhZd3utIu7cCofviHZgaHsqSU4T5j
         zDYVofLRGrRlYwiVZZNXHNgCXJ1XYdEyGFpobY29+GS8ENvo6Ep9laE0gvYG1klwCat+
         egPuOaftHKc8zbx8zBtJt4zT+Et4gUXAofcwFTuqDXWt+ce9uWo1sof2dGFiHK4hyjnz
         MpkRKx0mscgPe2BjXZyos0n6X0HvTkmuL7OIeP+DviO2WCq0JbXYIrPmyxGVhRtmxW3m
         qkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962914; x=1693567714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeMuSlxUtzQfWCufq9OumalQo8UgVgjecOg8zY7pRu0=;
        b=ERkyylhMC74M3PyBWdNCU6BVCTgciM5e2pnEuYPG1FakxsbhPbau6DmUrH3gwTGIWP
         k8NIlCQ7pcW5eLoyuyluC6EwsIY08r3N/nCM/aiiNiTz3JWWvzabV91KiLu/a+8oviy7
         RTVW1l3lwKP4ng2gc8zfjDAuDuqR7w2qweGr9ETR/IkgaZSv8SRuO2GhdYeOdMMmIM/1
         xOz5qraeKvWGvLempH2BgzQJO7NIwi4/xzSJtcuxbfWMmpLceoHthWd/i6uGkwCrvQIP
         9dy7hYwPbYz1VT/I5+7yJA+X2yeYWI/6zND1hv8f7RqygJnDH4NubcVlbEgLel7zBC9b
         nJ4A==
X-Gm-Message-State: AOJu0Yw+/3IqibTYit3xtJGmC8aNEC1STIy5aM/3NM+XOFU/ggR2dRSg
	aMol0jwffnUgx/RnTzKgUrPo+s/CSKs9hwAQBitATg==
X-Google-Smtp-Source: AGHT+IHUgfu2tsexI+VJcgqvjEyLuKSLHFMu/xUlz+Q8AtTZDI1mZZPzp34WcqG0IR77T8xrrkPiuCDV4ZulMmomQ94=
X-Received: by 2002:a25:d257:0:b0:d12:77c7:b362 with SMTP id
 j84-20020a25d257000000b00d1277c7b362mr18460990ybg.26.1692962913802; Fri, 25
 Aug 2023 04:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230825091234.32713-1-quic_devipriy@quicinc.com> <20230825091234.32713-7-quic_devipriy@quicinc.com>
In-Reply-To: <20230825091234.32713-7-quic_devipriy@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Aug 2023 14:28:22 +0300
Message-ID: <CAA8EJpo75zWLXuF-HC-Xz+6mvu_S1ET-9gzW=mOq+FjKspDwhw@mail.gmail.com>
Subject: Re: [PATCH V2 6/7] arm64: dts: qcom: ipq9574: Add support for nsscc node
To: Devi Priya <quic_devipriy@quicinc.com>
Cc: andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, arnd@arndb.de, geert+renesas@glider.be, 
	nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	quic_saahtoma@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 25 Aug 2023 at 12:15, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
> Add a node for the nss clock controller found on ipq9574 based devices.
>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:
>         - Dropped the fixed clock node gcc_gpll0_out_aux and added
>           support for the same in gcc driver
>         - Updated the node name to clock-controller@39b00000
>         - Added clock-names to retrieve the nssnoc clocks and add them
>           to the list of pm clocks in nss driver
>
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 48 +++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 51aba071c1eb..903311547e96 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -10,6 +10,8 @@
>  #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
>  #include <dt-bindings/thermal/thermal.h>
>
>  / {
> @@ -18,6 +20,24 @@ / {
>         #size-cells = <2>;
>
>         clocks {
> +               bias_pll_cc_clk: bias-pll-cc-clk {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <1200000000>;
> +                       #clock-cells = <0>;
> +               };
> +
> +               bias_pll_nss_noc_clk: bias-pll-nss-noc-clk {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <461500000>;
> +                       #clock-cells = <0>;
> +               };
> +
> +               bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <353000000>;
> +                       #clock-cells = <0>;
> +               };

Which part provides these clocks?

> +
>                 sleep_clk: sleep-clk {
>                         compatible = "fixed-clock";
>                         #clock-cells = <0>;
> @@ -722,6 +742,34 @@ frame@b128000 {
>                                 status = "disabled";
>                         };
>                 };
> +
> +               nsscc: clock-controller@39b00000 {
> +                       compatible = "qcom,ipq9574-nsscc";
> +                       reg = <0x39b00000 0x80000>;
> +                       clocks = <&gcc GCC_NSSNOC_NSSCC_CLK>,
> +                                <&gcc GCC_NSSNOC_SNOC_CLK>,
> +                                <&gcc GCC_NSSNOC_SNOC_1_CLK>,
> +                                <&bias_pll_cc_clk>,
> +                                <&bias_pll_nss_noc_clk>,
> +                                <&bias_pll_ubi_nc_clk>,
> +                                <&gcc GPLL0_OUT_AUX>,
> +                                <0>,
> +                                <0>,
> +                                <0>,
> +                                <0>,
> +                                <0>,
> +                                <0>,
> +                                <&xo_board_clk>;

If you move xo_board closer to the start of the list, it will be
slightly easier to review.

> +                       clock-names = "nssnoc_nsscc", "nssnoc_snoc", "nssnoc_snoc_1",
> +                                     "bias_pll_cc_clk", "bias_pll_nss_noc_clk",
> +                                     "bias_pll_ubi_nc_clk", "gpll0_out_aux", "uniphy0_nss_rx_clk",
> +                                     "uniphy0_nss_tx_clk", "uniphy1_nss_rx_clk",
> +                                     "uniphy1_nss_tx_clk", "uniphy2_nss_rx_clk",
> +                                     "uniphy2_nss_tx_clk", "xo_board_clk";

You are using clock indices. Please drop clock-names.

> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +                       #power-domain-cells = <1>;
> +               };
>         };
>
>         thermal-zones {
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

