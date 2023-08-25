Return-Path: <netdev+bounces-30635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2288D788486
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541AD1C20FCE
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6B7CA4C;
	Fri, 25 Aug 2023 10:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C60C2EB
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 10:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E1CC433C8;
	Fri, 25 Aug 2023 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692958490;
	bh=F8oKNVTy6rC98/+pAVZNa2M+atmjLnnbW393Y6FNBxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A8sw7xFVWcXBro5K9uPJOpgpgU7sA3zf9EWvvip2RG0ctsGSI70mxoQyHoBDNaVf/
	 NMTZlY8a3pXOfwJLZjwS6YO/Vhp9A1m5XG9tOSJnRpZbvovGknzdF8MvzalNXFKttE
	 G2TBUN7jNzf0UpoJxCWpTddFNy+ShUOkokH5Vv+cK/ad9fjrimWOtYzuH01UvqJTSM
	 9ZUqZG4fz+8luaaZ5tywnaNWMRdbXznrKlrSG4cpvysgMw4gaNDrsRftoN9iCLuQMi
	 qhkGjZc3UIf3oX8UkwuXG7tnB+/AYOOsW0j8kGmnic/eQKI2jwLvW84bWQYhpQ4Uxb
	 Lbn1BqYsXKFcg==
Received: (nullmailer pid 2559857 invoked by uid 1000);
	Fri, 25 Aug 2023 10:14:46 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Devi Priya <quic_devipriy@quicinc.com>
Cc: rafal@milecki.pl, agross@kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, richardcochran@gmail.com, p.zabel@pengutronix.de, catalin.marinas@arm.com, will@kernel.org, conor+dt@kernel.org, nfraprado@collabora.com, quic_saahtoma@quicinc.com, sboyd@kernel.org, konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-clk@vger.kernel.org, arnd@arndb.de, andersson@kernel.org, linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com, netdev@vger.kernel.org, geert+renesas@glider.be
In-Reply-To: <20230825091234.32713-5-quic_devipriy@quicinc.com>
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-5-quic_devipriy@quicinc.com>
Message-Id: <169295848663.2559800.3580053610150304724.robh@kernel.org>
Subject: Re: [PATCH V2 4/7] dt-bindings: clock: Add ipq9574 NSSCC clock and
 reset definitions
Date: Fri, 25 Aug 2023 05:14:46 -0500


On Fri, 25 Aug 2023 14:42:31 +0530, Devi Priya wrote:
> Add NSSCC clock and reset definitions for ipq9574.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:
> 	- Referenced gcc.yaml and dropped the duplicate properties from
> 	  the binding
> 	- Updated Uniphy clock names
> 	- Added nssnoc clocks and clock-names
> 
>  .../bindings/clock/qcom,ipq9574-nsscc.yaml    | 107 ++++++++++++
>  .../dt-bindings/clock/qcom,ipq9574-nsscc.h    | 152 ++++++++++++++++++
>  .../dt-bindings/reset/qcom,ipq9574-nsscc.h    | 134 +++++++++++++++
>  3 files changed, 393 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>  create mode 100644 include/dt-bindings/reset/qcom,ipq9574-nsscc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.example.dts:28.26-27 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230825091234.32713-5-quic_devipriy@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


