Return-Path: <netdev+bounces-21336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC9763504
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB11281D72
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EA88473;
	Wed, 26 Jul 2023 11:32:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05929CA68
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA78AC433C8;
	Wed, 26 Jul 2023 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690371165;
	bh=wq+kGX1o6azl/+AxJe/umF5svvBwne/PrZi7iuI++k0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e1hankn3CHxOhV5V7dL9xTWosq9z/AofiRirVkpOjA5iGzdOg2AqeCG/lPXcfSVuf
	 NLnHQ8xPlaS3pRI4KBAejMqJ/9BDmbpTNDdG4GGoJApzH9gUqgXlIXbAJMEuxctoIS
	 6TH+ublhNs4PXHTBz9tII/L0d5YdsiwqMQhhqqyOL6xfDC/m1t8m7XHlDAvW7/JeUA
	 Y7CJxKafOQrVbAqZyxMgeC6wgPtZF0Yp2f6Jx/Gi404YrKPKekJc1fm+VKNqhl8zF4
	 44iwHUskx7tCXskhYbfbD94aM0do3HAm8eFIcjFR2ae6oW991MwijW+S7cmTHLlyov
	 Y/YMdbOcLz5Dg==
Received: (nullmailer pid 1021823 invoked by uid 1000);
	Wed, 26 Jul 2023 11:32:41 -0000
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
Cc: olivier.moysan@foss.st.com, lee@kernel.org, netdev@vger.kernel.org, linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org, will@kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andi.shyti@kernel.org, vkoul@kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, richardcochran@gmail.com, catalin.marinas@arm.com, conor+dt@kernel.org, edumazet@google.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, fabrice.gasnier@foss.st.com, linux-spi@vger.kernel.org, davem@davemloft.net, mchehab@kernel.org, pabeni@redhat.com, herbert@gondor.apana.org.au, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, robh+dt@kernel.org, alexandre.torgue@foss.st.com, hugues.fruchet@foss.st.com, krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, Oleksii_Moisieiev@epam.com, linux-i2c@vger.kernel.org, kuba@kernel.org,
  linux-phy@lists.infradead.org, dmaengine@vger.kernel.org, arnaud.pouliquen@foss.st.com, arnd@kernel.org
In-Reply-To: <20230726090129.233316-1-gatien.chevallier@foss.st.com>
References: <20230726083810.232100-1-gatien.chevallier@foss.st.com>
 <20230726090129.233316-1-gatien.chevallier@foss.st.com>
Message-Id: <169037116156.1021724.12937477325696165938.robh@kernel.org>
Subject: Re: [PATCH v3 04/11] dt-bindings: bus: document ETZPC
Date: Wed, 26 Jul 2023 05:32:41 -0600


On Wed, 26 Jul 2023 11:01:22 +0200, Gatien Chevallier wrote:
> Document ETZPC (Extended TrustZone protection controller). ETZPC is a
> firewall controller.
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
> 	- Reorder the properties so it matches RIFSC
> 	- Add missing "feature-domain-controller" property
> 
>  .../bindings/bus/st,stm32-etzpc.yaml          | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/st,stm32-etzpc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,stm32-etzpc.example.dtb: serial@4c001000: Unevaluated properties are not allowed ('feature-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/serial/st,stm32-uart.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230726090129.233316-1-gatien.chevallier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


