Return-Path: <netdev+bounces-37070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4027B36E9
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 17:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 11E02285518
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5844B51BAC;
	Fri, 29 Sep 2023 15:35:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C35A521A1;
	Fri, 29 Sep 2023 15:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467DBC433C7;
	Fri, 29 Sep 2023 15:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696001741;
	bh=Vpxhihd/k1b+v8lMOi0CPh14iepxvm9nmqyMxT341uM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mUohr5GwY4KxfPp7cng5SPhzcshX8/sj0CmBdDbCz8fqwbhKPXDebLlBa2Juv057E
	 jwSqjrWGp45ntGSONnNvLIICDEOlNaQZuxa5tbSCqpjK4GCmOeRnm58jYtLj6nw3jl
	 T25k5mR5evmxPyINrndbG+XGppDAWCF8mGAse8m/bPkaUrWWVNCsSbTmAfL06eq1Yl
	 gFsVkRaE1AAZPC6kxxCv4bJr9S64GajiwxcHKtCyg4W5vVVQPet7IIDbNxNEuu6wl0
	 yx7/RWDX2kX7fIylD3+eFtTBZ7RvaZ2u2of9sypFtMiNvKuGKzDn5K8xZYwbyn9B7K
	 p+KEh+G5xjObw==
Received: (nullmailer pid 3601359 invoked by uid 1000);
	Fri, 29 Sep 2023 15:35:24 -0000
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
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net,
	lee@kernel.org, conor+dt@kernel.org, catalin.marinas@arm.com,
	peng.fan@oss.nxp.com, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
	alexandre.torgue@foss.st.com, will@kernel.org,
	arnaud.pouliquen@foss.st.com, olivier.moysan@foss.st.com,
	dmaengine@vger.kernel.org, mchehab@kernel.org, edumazet@google.com,
	linux-i2c@vger.kernel.org, kuba@kernel.org, jic23@kernel.org,
	andi.shyti@kernel.org, linux-iio@vger.kernel.org,
	linux-serial@vger.kernel.org, hugues.fruchet@foss.st.com,
	linux-media@vger.kernel.org, herbert@gondor.apana.org.au,
	linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	vkoul@kernel.org, gregkh@linuxfoundation.org,
	fabrice.gasnier@foss.st.com, linux-phy@lists.infradead.org,
	linux-crypto@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	richardcochran@gmail.com, linux-spi@vger.kernel.org, arnd@kernel.org,
	ulf.han@web.codeaurora.org, sson@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	devicetree@vger.kernel.org, Oleksii_Moisieiev@epam.com
In-Reply-To: <20230929142852.578394-4-gatien.chevallier@foss.st.com>
References: <20230929142852.578394-1-gatien.chevallier@foss.st.com>
 <20230929142852.578394-4-gatien.chevallier@foss.st.com>
Message-Id: <169600172403.3601303.9668793596131154383.robh@kernel.org>
Subject: Re: [PATCH v5 03/11] dt-bindings: bus: document RIFSC
Date: Fri, 29 Sep 2023 10:35:24 -0500


On Fri, 29 Sep 2023 16:28:44 +0200, Gatien Chevallier wrote:
> Document RIFSC (RIF security controller). RIFSC is a firewall controller
> composed of different kinds of hardware resources.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
> 
> Changes in V5:
> 	- Renamed feature-domain* to access-control*
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml: access-controller: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml: access-control-provider: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.example.dtb: serial@400e0000: Unevaluated properties are not allowed ('access-controller' was unexpected)
	from schema $id: http://devicetree.org/schemas/serial/st,stm32-uart.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230929142852.578394-4-gatien.chevallier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


