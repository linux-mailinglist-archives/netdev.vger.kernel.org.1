Return-Path: <netdev+bounces-249622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2144FD1BAA0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 00:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1A513006463
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8327A350D79;
	Tue, 13 Jan 2026 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIsuq2Gy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8CB26B74A;
	Tue, 13 Jan 2026 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345943; cv=none; b=X7Azk9cwCVz4R5kAv00FWyRkNQGvWU+tO1Fy2PgrHkBYPpRIFj6mhE1YnHV8UCIJ+DVA9113SvO5t96PGvg37htvlI2jnnvmwsOyO8q7GgSbY95DRwNzgsU7+io5bkTBkGYDHngjTjueL2fU8oh1c59qC8Z2oWMJcj8TJipOh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345943; c=relaxed/simple;
	bh=KVvUjtgHP/EnKb5VOEjjBg5TqpHapWWCoF0IBZbv+IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqy+kam1a4p8bevaENxuiyzsFyFrP0VEkRSxUINVnplIqdoEtzlD75atbNbr6GITbcDJTMpGiaG6kWxpSe7CqrKqHGv40xFmXuhwAuJphp3sB7BwRMKtUibDk/07o0DjFSZF2JEnTBb7u9Hpwg1abohspXFiW51lTuzNsU9unPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIsuq2Gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7F5C116C6;
	Tue, 13 Jan 2026 23:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768345943;
	bh=KVvUjtgHP/EnKb5VOEjjBg5TqpHapWWCoF0IBZbv+IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIsuq2GykDPHWJFBN+4HvzBChNmyu1hHIMJc8+H4jvYmt6n43+njE75R+vlQRLYNN
	 uZ0BrIy8AWcVEC5/DIaiQkv+R/elVNvDWaalS/dQEeBnPIrqw9GWEVFCxBgIfZTtYI
	 oX+Z9IgWJ4pifJfQrKis+JiKRLmljeUw0wK5m2Y6/3K5UzzuX3RybFsJV0ewR3/8yX
	 2DCnCQvhGukGpnarWWhTu8cjDSS4riMOq0yYx+IEZttsqpSWaPQzfGCjHkrPR3vAGb
	 6vcEduOgLU0zPq1eCNnPwX6d17bIAYW/EItgbEpvZGEDrUjdhCQCH8BCC0G/4mb7aa
	 kWVwXKUYByr7w==
Date: Tue, 13 Jan 2026 17:12:22 -0600
From: Rob Herring <robh@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v1] dt-bindings: net: Convert icplus-ip101ag to
 yaml format
Message-ID: <20260113231222.GA421230-robh@kernel.org>
References: <20260110235544.1593197-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110235544.1593197-1-martin.blumenstingl@googlemail.com>

On Sun, Jan 11, 2026 at 12:55:44AM +0100, Martin Blumenstingl wrote:
> This allows for better validation of .dts.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/net/icplus,ip101ag.yaml          | 75 +++++++++++++++++++
>  .../bindings/net/icplus-ip101ag.txt           | 19 -----
>  2 files changed, 75 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/icplus,ip101ag.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/icplus-ip101ag.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/icplus,ip101ag.yaml b/Documentation/devicetree/bindings/net/icplus,ip101ag.yaml
> new file mode 100644
> index 000000000000..f245516103b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/icplus,ip101ag.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/icplus,ip101ag.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IC Plus Corp. IP101A / IP101G Ethernet PHYs
> +
> +maintainers:
> +  - Andrew Lunn <andrew@lunn.ch>
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +
> +description: |
> +  Bindings for IC Plus Corp. IP101A / IP101G Ethernet MII/RMII PHYs

Drop 'Bindings for'

> +
> +  There are different models of the IP101G Ethernet PHY:
> +  - IP101GR (32-pin QFN package)
> +  - IP101G (die only, no package)
> +  - IP101GA (48-pin LQFP package)
> +
> +  There are different models of the IP101A Ethernet PHY (which is the
> +  predecessor of the IP101G):
> +  - IP101A (48-pin LQFP package)
> +  - IP101AH (48-pin LQFP package)
> +
> +  All of them share the same PHY ID.
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +properties:
> +  compatible:
> +    contains:

Drop contains. The list(s) of allowed values should be exact.

> +      enum:
> +        - ethernet-phy-id0243.0c54
> +
> +  icplus,select-rx-error:
> +    type: boolean
> +    description: |
> +      Pin 21 ("RXER/INTR_32") will output the receive error status.
> +      Interrupts are not routed outside the PHY in this mode.
> +
> +      This is only supported for IP101GR (32-pin QFN package).
> +
> +  icplus,select-interrupt:
> +    type: boolean
> +    description: |
> +      Pin 21 ("RXER/INTR_32") will output the interrupt signal.
> +
> +      This is only supported for IP101GR (32-pin QFN package).
> +
> +# RXER and INTR_32 functions are mutually exclusive
> +dependentSchemas:
> +  icplus,select-rx-error:
> +    properties:
> +      icplus,select-interrupt: false
> +  icplus,select-interrupt:
> +    properties:
> +      icplus,select-rx-error: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethphy1: ethernet-phy@1 {
> +                compatible = "ethernet-phy-id0243.0c54";
> +                reg = <1>;
> +                icplus,select-interrupt;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/icplus-ip101ag.txt b/Documentation/devicetree/bindings/net/icplus-ip101ag.txt
> deleted file mode 100644
> index a784592bbb15..000000000000
> --- a/Documentation/devicetree/bindings/net/icplus-ip101ag.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -IC Plus Corp. IP101A / IP101G Ethernet PHYs
> -
> -There are different models of the IP101G Ethernet PHY:
> -- IP101GR (32-pin QFN package)
> -- IP101G (die only, no package)
> -- IP101GA (48-pin LQFP package)
> -
> -There are different models of the IP101A Ethernet PHY (which is the
> -predecessor of the IP101G):
> -- IP101A (48-pin LQFP package)
> -- IP101AH (48-pin LQFP package)
> -
> -Optional properties for the IP101GR (32-pin QFN package):
> -
> -- icplus,select-rx-error:
> -  pin 21 ("RXER/INTR_32") will output the receive error status.
> -  interrupts are not routed outside the PHY in this mode.
> -- icplus,select-interrupt:
> -  pin 21 ("RXER/INTR_32") will output the interrupt signal.
> -- 
> 2.52.0
> 

