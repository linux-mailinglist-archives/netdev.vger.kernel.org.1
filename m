Return-Path: <netdev+bounces-107387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496D91ABFB
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475311C22497
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD5A199249;
	Thu, 27 Jun 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya9uCh3t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D0199380;
	Thu, 27 Jun 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503749; cv=none; b=bvZIPiMSZMxNXT2PdAvwc4o9GMHUnhKuhVtgEA9m/xt1z1tI7wD4KJOQi4+ob4fzp4JKmSO3mUJe+RWYyHkPusjTz5IBvDRVSPM/29WQ2FqDyfkxL0N98oxvVnYhJUxqcWfEyO5022X2g12AMYco7a7lMJGoQd9x1drdSkHfxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503749; c=relaxed/simple;
	bh=vjjBMHjej31enUTmvqptyhQfKR/B9MM98Qv4lFn4Kkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTY0gRgpQELGh7LDccN8v8ruzU9pmSsBlt34jhLV0xx+A1fAGPUNPF/y0WjEBBVtWcXraGBzvENraBYrkvVBb65riTjeMUNvpGEPH/feVaO0cU9a/2sgx4hhNcBwUPpglsd+U3ptgyDGXA+mKX74DD6JO5TPJ6nCnO9taAwh0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya9uCh3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D006C2BBFC;
	Thu, 27 Jun 2024 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719503748;
	bh=vjjBMHjej31enUTmvqptyhQfKR/B9MM98Qv4lFn4Kkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ya9uCh3t88u6Pn7B+3OBfK9PEvcnwpVi+2Yltf5ff4KnMJAQRjcrYRAHcpkSXwGMA
	 AUErY2d24yUd1NFR8XNbnN6RjoNqiPyvPvsWQc+wLKlbzBJM16qo6a5zTKFehMJXG9
	 JnqRGnYyVtaBRlXMQ3wccTXKeHKvF6+iMR30yQNc5aeEe33/EudP1hICmfalhbpaZm
	 y27kQEvRzFOdi4nGu7kc9xSbPpScfdDY+vzoWnYUsrK2meXwgp9WdJmK7VLAGcYXgq
	 /hhtCmlLfVcWuNAfHlC/7jL0JhTpLAH8QtYAz147hzDWLYjRy6o9t0hJb+wYSqH30t
	 AuGfM9d8v5kBQ==
Date: Thu, 27 Jun 2024 09:55:47 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzk@kernel.org, conor+dt@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, edumazet@google.com,
	imx@lists.linux.dev, krzk+dt@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml
Message-ID: <20240627155547.GB3480309-robh@kernel.org>
References: <20240626162307.1748759-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626162307.1748759-1-Frank.Li@nxp.com>

On Wed, Jun 26, 2024 at 12:23:07PM -0400, Frank Li wrote:
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
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
> new file mode 100644
> index 0000000000000..ce88d7ce07a5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl,enetc-ierb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Integrated Endpoint Register Block
> +
> +description:
> +  The fsl_enetc driver can probe on the Integrated Endpoint Register
> +  Block, which preconfigures the FIFO limits for the ENETC ports.

Wrap at 80 chars

> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,ls1028a-enetc-ierb
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ierb@1f0800000 {

unit-address doesn't match

> +        compatible = "fsl,ls1028a-enetc-ierb";
> +        reg = <0xf0800000 0x10000>;
> +    };
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> new file mode 100644
> index 0000000000000..60740ea56cb08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl,enetc-mdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ENETC the central MDIO PCIe endpoint device
> +
> +description:
> +  In this case, the mdio node should be defined as another PCIe
> +  endpoint node, at the same level with the ENETC port nodes
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>.

stray '.'                         ^

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - pci1957,ee01
> +      - const: fsl,enetc-mdio
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: mdio.yaml

As a PCI device, also needs pci-device.yaml.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie@1f0000000 {
> +        compatible = "pci-host-ecam-generic";
> +        reg = <0x01 0xf0000000 0x0 0x100000>;

Drop compatible and reg. Just need the minimum to define a PCI bus node.

> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        mdio@0,3 {
> +            compatible = "pci1957,ee01", "fsl,enetc-mdio";
> +            reg = <0x000300 0 0 0 0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ethernet-phy@2 {
> +                reg = <0x2>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> new file mode 100644
> index 0000000000000..843c27e357f2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl,enetc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ENETC ethernet
> +
> +description:
> +  Depending on board design and ENETC port type (internal or
> +  external) there are two supported link modes specified by
> +  below device tree bindings.
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - pci1957,e100
> +      - const: fsl,enetc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml

As a PCI device, also needs pci-device.yaml.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie@1f0000000 {
> +        compatible = "pci-host-ecam-generic";
> +        reg = <0x01 0xf0000000 0x0 0x100000>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        ethernet@0,0 {
> +            compatible = "pci1957,e100", "fsl,enetc";
> +            reg = <0x000000 0 0 0 0>;
> +            phy-handle = <&sgmii_phy0>;
> +            phy-connection-type = "sgmii";
> +        };
> +    };

