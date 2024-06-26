Return-Path: <netdev+bounces-107032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD2918DA0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235E7283184
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72120190469;
	Wed, 26 Jun 2024 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd95CG1f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5D190461;
	Wed, 26 Jun 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424559; cv=none; b=QslqlSdGUGFtuI7Z/W20XG6AS2WYEdzhzsTwoyYSX46B/APRpJQXP7g1Y2RXNAIRMS2K5KwJPxZiR28nvYIGHb7vGWqCvB4t7ncDkcagVvnTq5mx+oKgGdogPelduH/Pr6O5FGeayT8fevkd6UUQiHuRj7Cf+nvpKuBoeKt2BSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424559; c=relaxed/simple;
	bh=/nn9cXzOLqdpmvpMkRXeiT4dOqNiKFz+DhAQVxCofeA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=fJvZC4R0TZk0OGAky/jN+ljabcNowOcM7hjvexRr+qx98fmc9+Gaoc6s0qVySmLmREGpauO2TFONTYJuxq6S0FkA+neqFWTtZ7UOtxfBzIItmkYFh89EPZGSPzwEzs27J2pNlxAzfPdOHrZMzH8tVfJLG7wlhLxSYkjuRwOZoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd95CG1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98507C116B1;
	Wed, 26 Jun 2024 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719424558;
	bh=/nn9cXzOLqdpmvpMkRXeiT4dOqNiKFz+DhAQVxCofeA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fd95CG1fxVYNa+qAXFNsD6e8Nr9YO9Tqe/f5xGi4hvJIBewDKCPFbpZzID5W4p0qQ
	 vgT3iR2c16aU7u+6e9p7eA9tUj9T3/osuDUTewfXw8BQr8Ci5NdT6baVbzknnKNRKk
	 4xsKCHWxcF01jIw9NIJ70jSne1fdXHIsEiNHRnOLdfABvrE2At9FcrxAu/hLzs8Zr+
	 uimtaFqGIcVFzwKTBuUW6uBZr1fdHvotEtV2/xf6zlgrDgS7kyRPgtKrlc99hjz05N
	 6yM9dQZRtnRDoIZKzVFPZX8fJdPY/9znKVkOj2/QpvJzdnWVM4aQyWLPlcIau9XRtw
	 V89A5qUWYfHHA==
Date: Wed, 26 Jun 2024 11:55:57 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, pabeni@redhat.com, krzk@kernel.org, 
 krzk+dt@kernel.org, kuba@kernel.org, edumazet@google.com, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, davem@davemloft.net
In-Reply-To: <20240626162307.1748759-1-Frank.Li@nxp.com>
References: <20240626162307.1748759-1-Frank.Li@nxp.com>
Message-Id: <171942455738.3889614.10016713539480187733.robh@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml


On Wed, 26 Jun 2024 12:23:07 -0400, Frank Li wrote:
> Convert enetc device binding file to yaml. Split to 3 yaml files,
> 'fsl,enetc.yaml', 'fsl,enetc-mdio.yaml', 'fsl,enetc-ierb.yaml'.
> 
> Additional Changes:
> - Add pci<vendor id>,<production id> in compatible string.
> - Ref to common ethernet-controller.yaml and mdio.yaml.
> - Remove fixed-link part.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - renamee file as fsl,enetc-mdio.yaml, fsl,enetc-ierb.yaml, fsl,enetc.yaml
> - example include pcie node
> ---
>  .../bindings/net/fsl,enetc-ierb.yaml          |  35 ++++++
>  .../bindings/net/fsl,enetc-mdio.yaml          |  53 ++++++++
>  .../devicetree/bindings/net/fsl,enetc.yaml    |  50 ++++++++
>  .../devicetree/bindings/net/fsl-enetc.txt     | 119 ------------------
>  4 files changed, 138 insertions(+), 119 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc-mdio.example.dtb: pcie@1f0000000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc-mdio.example.dtb: pcie@1f0000000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc-mdio.example.dtb: pcie@1f0000000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc-mdio.example.dtb: pcie@1f0000000: reg: [[1, 4026531840], [0, 1048576]] is too long
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc-mdio.example.dtb: pcie@1f0000000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'mdio@0,3' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc-mdio.example.dtb: pcie@1f0000000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc-mdio.example.dtb: pcie@1f0000000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc.example.dtb: pcie@1f0000000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc.example.dtb: pcie@1f0000000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc.example.dtb: pcie@1f0000000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc.example.dtb: pcie@1f0000000: reg: [[1, 4026531840], [0, 1048576]] is too long
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc.example.dtb: pcie@1f0000000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'ethernet@0,0' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc.example.dtb: pcie@1f0000000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,enetc.example.dtb: pcie@1f0000000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240626162307.1748759-1-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


