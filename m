Return-Path: <netdev+bounces-20976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF3076208E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDAE2819B8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4325926;
	Tue, 25 Jul 2023 17:49:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7437525140
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89EBC433C9;
	Tue, 25 Jul 2023 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690307380;
	bh=RU1yt+0Cu3kvPsoECxJVmwUh0wZQeJo4rj4qI+5pd+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=luJ/sojL/eju59UKvv7KPRUv5zpARMbC8f1KoW1mcTCaBI95NpBwjsFS+jjMlnEra
	 UwRBdCUoOpeQ+PRT23Y9eKuLemPcL8WAUCKUwypqaKayAms4+JmGoK7UpHX8glvsqL
	 WcsQ5CafV2BdB6y5os43l4smEcGY8FPjbW0ZYz7uYTYdwzTmoReIhsKN7y/IaCuWHd
	 8qSOXqN6EeKAJ8r6RE1UO/5CxmHKtnm4hVP4txEBXkBTttne30yHuWBkHkKp6A9S5q
	 HMCvrugtwMy1R9TziQ8J6Ie10YG/5nmHIJBy++pNRTbOPeVG/gsG31kFEfY1eZUmIN
	 uGJVoAGjxh2PQ==
Received: (nullmailer pid 3497937 invoked by uid 1000);
	Tue, 25 Jul 2023 17:49:25 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Oleksii_Moisieiev@epam.com, linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org, hugues.fruchet@foss.st.com,
	herbert@gondor.apana.org.au, devicetree@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, lee@kernel.org, will@kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kuba@kernel.org,
	olivier.moysan@foss.st.com, arnd@kernel.org,
	dmaengine@vger.kernel.org, alexandre.torgue@foss.st.com,
	linux-iio@vger.kernel.org, ulf.hansson@linaro.org,
	edumazet@google.com, linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org, andi.shyti@kernel.org,
	arnaud.pouliquen@foss.st.com, fabrice.gasnier@foss.st.com,
	vkoul@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	jic23@kernel.org, linux-i2c@v.smtp.subspace.kernel.org,
	ger.kernel.org@web.codeaurora.org, linux-serial@vger.kernel.org,
	catalin.marinas@arm.com, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230725164104.273965-3-gatien.chevallier@foss.st.com>
References: <20230725164104.273965-1-gatien.chevallier@foss.st.com>
 <20230725164104.273965-3-gatien.chevallier@foss.st.com>
Message-Id: <169030736432.3497864.4682647411146090051.robh@kernel.org>
Subject: Re: [PATCH v2 02/11] dt-bindings: bus: document RIFSC
Date: Tue, 25 Jul 2023 11:49:25 -0600


On Tue, 25 Jul 2023 18:40:55 +0200, Gatien Chevallier wrote:
> Document RIFSC (RIF security controller). RIFSC is a firewall controller
> composed of different kinds of hardware resources.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
> 
> Changes in V2:
> 	- Corrected errors highlighted by Rob's robot
> 	- No longer define the maxItems for the "feature-domains"
> 	  property
> 	- Fix example (node name, status)
> 	- Declare "feature-domain-names" as an optional
> 	  property for child nodes
> 	- Fix description of "feature-domains" property
> 
>  .../bindings/bus/st,stm32mp25-rifsc.yaml      | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.example.dtb: serial@400e0000: Unevaluated properties are not allowed ('feature-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/serial/st,stm32-uart.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230725164104.273965-3-gatien.chevallier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


