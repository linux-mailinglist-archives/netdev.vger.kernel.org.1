Return-Path: <netdev+bounces-37485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432727B58C3
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 619ED283D19
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7C01E514;
	Mon,  2 Oct 2023 17:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB85199B2;
	Mon,  2 Oct 2023 17:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B79C433C7;
	Mon,  2 Oct 2023 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696267825;
	bh=OdlZ5THuUArLfRy0wPc5UG7mfiwyH1fEuvpKiBXwcrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WLDvTlVrxZp+ubgMERGBLIgHk6VMW4gyrqvh6mAAY+mHvtfSK005LoanH0gVddMIF
	 dv6MrJ8iXIX8S5kE74NfsNKvWsSgPX0bl4B/psz3ESsD5XzS7o4s96vlCPREA25czC
	 tijyU5A+aReBkq0z80oyP9APXu6XkA7ib7irSiLHoPG9kzDlpUYeOMLna/gyLBZz8Q
	 tcAgkYfXWtiFK93iad2cRXQY12s76l3zqk3dF2u2o8+S58OpoSymvEwH5IRF1I4g2t
	 PUu/LV3ItEkvomp2fk/sFlrkgrkeKKqHFuyIkMgWKp3SENERPcMqNcLi2GvRCK8K2E
	 q4ZQpq6SN+/+A==
Received: (nullmailer pid 2046960 invoked by uid 1000);
	Mon, 02 Oct 2023 17:30:19 -0000
Date: Mon, 2 Oct 2023 12:30:19 -0500
From: Rob Herring <robh@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Oleksii_Moisieiev@epam.com, gregkh@linuxfoundation.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	alexandre.torgue@foss.st.com, vkoul@kernel.org, jic23@kernel.org,
	olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com,
	mchehab@kernel.org, fabrice.gasnier@foss.st.com,
	andi.shyti@kernel.org, ulf.hansson@linaro.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hugues.fruchet@foss.st.com,
	lee@kernel.org, will@kernel.org, catalin.marinas@arm.com,
	arnd@kernel.org, richardcochran@gmail.com,
	Frank Rowand <frowand.list@gmail.com>, peng.fan@oss.nxp.com,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-p@web.codeaurora.org,
	hy@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 01/11] dt-bindings: document generic access controller
Message-ID: <20231002173019.GA2037244-robh@kernel.org>
References: <20230929142852.578394-1-gatien.chevallier@foss.st.com>
 <20230929142852.578394-2-gatien.chevallier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929142852.578394-2-gatien.chevallier@foss.st.com>

On Fri, Sep 29, 2023 at 04:28:42PM +0200, Gatien Chevallier wrote:
> From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
> 
> Introducing of the generic access controller bindings for the
> access controller provider and consumer devices. Those bindings are
> intended to allow a better handling of accesses to resources in a
> hardware architecture supporting several compartments.
> 
> This patch is based on [1]. It is integrated in this patchset as it
> provides a use-case for it.
> 
> Diffs with [1]:
> 	- Rename feature-domain* properties to access-control* to narrow
> 	  down the scope of the binding
> 	- YAML errors and typos corrected.
> 	- Example updated
> 	- Some rephrasing in the binding description
> 
> [1]: https://lore.kernel.org/lkml/0c0a82bb-18ae-d057-562b
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> 
> ---
> Changes in V5:
> 	- Diffs with [1]
> 	- Discarded the [IGNORE] tag as the patch is now part of the
> 	  patchset
> 
>  .../access-controllers/access-controller.yaml | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/access-controllers/access-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/access-controllers/access-controller.yaml b/Documentation/devicetree/bindings/access-controllers/access-controller.yaml
> new file mode 100644
> index 000000000000..9d305fccc333
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/access-controllers/access-controller.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/access-controllers/access-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic Domain Access Controller
> +
> +maintainers:
> +  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> +
> +description: |+
> +  Common access controllers properties
> +
> +  Access controllers are in charge of stating which of the hardware blocks under
> +  their responsibility (their domain) can be accesssed by which compartment. A
> +  compartment can be a cluster of CPUs (or coprocessors), a range of addresses
> +  or a group of hardware blocks. An access controller's domain is the set of
> +  resources covered by the access controller.
> +
> +  This device tree bindings can be used to bind devices to their access
> +  controller provided by access-controller property. In this case, the device is
> +  a consumer and the access controller is the provider.
> +
> +  An access controller can be represented by any node in the device tree and
> +  can provide one or more configuration parameters, needed to control parameters
> +  of the consumer device. A consumer node can refer to the provider by phandle
> +  and a set of phandle arguments, specified by '#access-controller-cells'
> +  property in the access controller node.
> +
> +  Access controllers are typically used to set/read the permissions of a
> +  hardware block and grant access to it. Any of which depends on the access
> +  controller. The capabilities of each access controller are defined by the
> +  binding of the access controller device.
> +
> +  Each node can be a consumer for the several access controllers.
> +
> +# always select the core schema
> +select: true
> +
> +properties:
> +  "#access-controller-cells":
> +    $ref: /schemas/types.yaml#/definitions/uint32

Drop. "#.*-cells" already defines the type.

> +    description:
> +      Number of cells in a access-controller specifier;
> +      Can be any value as specified by device tree binding documentation
> +      of a particular provider.
> +
> +  access-control-provider:
> +    description:
> +      Indicates that the node is an access controller.

Drop. The presence of "#access-controller-cells" is enough to do that.

> +
> +  access-controller-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      A list of access-controller names, sorted in the same order as
> +      access-controller entries. Consumer drivers will use
> +      access-controller-names to match with existing access-controller entries.
> +
> +  access-controller:

For consistency with other provider bindings: access-controllers

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A list of access controller specifiers, as defined by the
> +      bindings of the access-controller provider.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    uart_controller: access-controller@50000 {
> +        reg = <0x50000 0x10>;
> +        access-control-provider;
> +        #access-controller-cells = <2>;
> +    };
> +
> +    bus_controller: bus@60000 {
> +        reg = <0x60000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        access-control-provider;
> +        #access-controller-cells = <3>;
> +
> +        uart4: serial@60100 {
> +            reg = <0x60100 0x400>;
> +            access-controller = <&uart_controller 1 2>,
> +                                <&bus_controller 1 3 5>;
> +            access-controller-names = "controller", "bus-controller";

Not great names. It should indicate what access is being controlled 
locally. Perhaps "reg" for register access, "dma" or "bus" for bus 
master access. (Not sure what your uart_controller is controlling access 
to.)

Rob

