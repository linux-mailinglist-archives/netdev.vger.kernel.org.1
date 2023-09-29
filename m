Return-Path: <netdev+bounces-37071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CB7B36ED
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 17:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 5CA5BB20E97
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5760D51BB3;
	Fri, 29 Sep 2023 15:35:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0451BAD;
	Fri, 29 Sep 2023 15:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC3FC433CA;
	Fri, 29 Sep 2023 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696001746;
	bh=z3KUEsqazjbR1hDsMbBF2Knw4QB51OgWhHZ20c5Nmfo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KnBqDsMNpmcMIqEz/7+dh2UUN3J/d+OfDIq97LxcXVxhClMZ54ula6pe1MF6LNqLW
	 m81aNDtRYLY5tTyXmqV6rZlMqrwroJ/R5Gm7DKG7aEHP26pzXzK3+LXKagVeAOtpe/
	 lU1mvNae3UvvAHYh74dUSDWQ6E36sViTAXyiVES950SI+GGVHX+L4ki1+j4kxhIF64
	 A/4er6VQTIMNPA86m3Qk1nEBkgpzemHoIIYNjU0gSVggG0jtqREsZ81ma4k2LloVwy
	 +b/fQpOilec8Il3sFMiwgY8fVjSlYYKWEihyh2PZHMSq8vw5yl5vr9f+BA1PNwY1N1
	 0nTnsc5JBHm7Q==
Received: (nullmailer pid 3601361 invoked by uid 1000);
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
Cc: linux-crypto@vger.kernel.org, olivier.moysan@foss.st.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	hugues.fruchet@foss.st.com, linux-media@vger.kernel.org,
	ulf.hansson@linaro.org, edumazet@google.com, lee@kernel.org,
	arnd@kernel.org, richardcochran@gmail.com,
	Frank Rowand <frowand.list@gmail.com>, peng.fan@oss.nxp.com,
	linux-i2c@vger.kernel.org, Oleksii_Moisieiev@epam.com,
	krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
	arnaud.pouliquen@foss.st.com, netdev@vger.kernel.org,
	linux-mmc@vger.kernel.org, vkoul@kernel.org, andi.shyti@kernel.org,
	jic23@kernel.org, linux-iio@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	conor+dt@kernel.org, mchehab@kernel.org, robh+dt@kernel.org,
	dmaengine@vger.kernel.org, alexandre.torgue@foss.st.com,
	catalin.marinas@arm.com, gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org, fabrice.gasnier@foss.st.com,
	linux-ser@web.codeaurora.org, ial@vger.kernel.org,
	linux-phy@lists.infradead.org, herbert@gondor.apana.org.au,
	will@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230929142852.578394-5-gatien.chevallier@foss.st.com>
References: <20230929142852.578394-1-gatien.chevallier@foss.st.com>
 <20230929142852.578394-5-gatien.chevallier@foss.st.com>
Message-Id: <169600172458.3601338.4448633630933066320.robh@kernel.org>
Subject: Re: [PATCH v5 04/11] dt-bindings: bus: document ETZPC
Date: Fri, 29 Sep 2023 10:35:24 -0500


On Fri, 29 Sep 2023 16:28:45 +0200, Gatien Chevallier wrote:
> Document ETZPC (Extended TrustZone protection controller). ETZPC is a
> firewall controller.
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
> 	- Reordered the properties so it matches ETZPC
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,stm32-etzpc.yaml: access-controller: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,stm32-etzpc.yaml: access-control-provider: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,stm32-etzpc.example.dtb: serial@4c001000: Unevaluated properties are not allowed ('access-controller' was unexpected)
	from schema $id: http://devicetree.org/schemas/serial/st,stm32-uart.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230929142852.578394-5-gatien.chevallier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


