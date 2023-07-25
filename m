Return-Path: <netdev+bounces-20975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7CF76208D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9ED280D2B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537925924;
	Tue, 25 Jul 2023 17:49:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5509925140
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AB4C433CA;
	Tue, 25 Jul 2023 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690307375;
	bh=WJL53er2hn/3EEx4DOJfAbOjXZnKjKBtRagFrtg05jg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CPO6RMRPaMRtVah/1RA1wO5FXxmP2DhlHptZXjtjeJZn524snzFNmGkI4PM2ckIo6
	 7FXzBD4qXePRo3PzLIkOFhZGyDj+4aolBAs7lhubS+/sugRBmEv5uwY2APQucc4EIz
	 1nGGt64bGnlel2IpehCbvoOPhAXT8wnt5XPyu8AhkROpI7dA7thAncucJtelJljMnw
	 atiZpLOBvBZ0F/r5WTJZfurX5L65y1q7LeSvDTjmcEUXR6SWW06bn+O1CXh/QQgkcV
	 FpqLMVfkRM4VMT0UlbHKmPRIUz4d0EWFPpNeyuIHEERTM60aZDTVat5SY/xyjqL5hf
	 qQXqITOBkCDlA==
Received: (nullmailer pid 3497939 invoked by uid 1000);
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
Cc: kuba@kernel.org, lee@kernel.org, andi.shyti@kernel.org, alsa-devel@alsa-project.org, linux-i2c@vger.kernel.org, richardcochran@gmail.com, linux-mmc@vger.kernel.org, arnaud.pouliquen@foss.st.com, olivier.moysan@foss.st.com, vkoul@kernel.org, linux-serial@vger.kernel.org, robh+dt@kernel.org, alexandre.torgue@foss.st.com, krzysztof.kozlowski+dt@linaro.org, ulf.hansson@linaro.org, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hugues.fruchet@foss.st.com, mchehab@kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, pabeni@redhat.com, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, edumazet@google.com, linux-crypto@vger.kernel.org, jic23@kernel.org, Frank Rowand <frowand.list@gmail.com>, arnd@kernel.org, linux-usb@vger.kernel.org, catalin.marinas@arm.com, linux-iio@vger.kernel.org, davem@davemloft.net, Oleksii_Moisieiev@epam.com, will@kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, 
 fabrice.gasnier@foss.st.com, linux-spi@vger.kernel.org, conor+dt@kernel.org, herbert@gondor.apana.org.au
In-Reply-To: <20230725164104.273965-4-gatien.chevallier@foss.st.com>
References: <20230725164104.273965-1-gatien.chevallier@foss.st.com>
 <20230725164104.273965-4-gatien.chevallier@foss.st.com>
Message-Id: <169030736534.3497905.9507005013968358402.robh@kernel.org>
Subject: Re: [PATCH v2 03/11] dt-bindings: bus: document ETZPC
Date: Tue, 25 Jul 2023 11:49:25 -0600


On Tue, 25 Jul 2023 18:40:56 +0200, Gatien Chevallier wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230725164104.273965-4-gatien.chevallier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


