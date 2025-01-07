Return-Path: <netdev+bounces-156066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBE8A04D3A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20A518886FF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525B1E3779;
	Tue,  7 Jan 2025 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpvIv3gv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9F1A83E1;
	Tue,  7 Jan 2025 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291593; cv=none; b=YiLFPCyM4h3axRzeyKU2bd0YTe0yblaQokX8pgc3T6ibcbXStEPPfOXQZa5o1ICJIvNCQcHES5QtCDazMwdwsyrPQWLIWtCAiELzJdjAGMSpKJzl5OmGQHUFyL90r+WGVVDLQS+GrEaVsGM87TCE/THe/626zFd94JrXEaKpSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291593; c=relaxed/simple;
	bh=Do/168fsFw6i80h2fR3YzMw5FE9OseaEDLt7XS3HU7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0g8ySFfbTiXWbv/tOGkpPa+TyQgE1lTyYVD7QspUVuXt1fW4TzTdObHq0A87qehjR1xPzQga+U+6/B3Xc8qvgAnlDvgnEvYe+3DwbbZLXFKvFEpYvcRy4cBrIO4NR6oHpeXIrcpx0Pu4raHnecNawgDBZiGPD3m6gCV39F7E9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpvIv3gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A1DC4CED6;
	Tue,  7 Jan 2025 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736291592;
	bh=Do/168fsFw6i80h2fR3YzMw5FE9OseaEDLt7XS3HU7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpvIv3gvmHkpEVhnNyN37lX3TxNiebJs1tHfvBdm0G1eeX0t4GC7nnRsRoB+jCF6U
	 8YjvgIye0yGn1ndJ+hDTT+RnJJZeNboOru3+3jHg7A+ierFyLCkCzgdRfjyqnuLdkX
	 drGMJ0FHxB/3GWIWzQ4Moj3LGfdg1JXVilAeJHIGjnEEhWDRP60H43Wt2wWWIrQLSs
	 BRuiPpRBy94Hn0tW6weXnf54+bcu5BfzwXLgzLaj49cvvyGvqAth642gSMS+JejS+j
	 hj4OdFu47n9KCunxQjIogQnds/pm1TmtgIL/6imDVnrlJ6cDzanK7j8Han8EJAU2NC
	 RIpHEzG19CDZw==
Date: Tue, 7 Jan 2025 17:13:11 -0600
From: Rob Herring <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com,
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] bindings: ipmi: Add binding for IPMB device intf
Message-ID: <20250107231311.GA1965288-robh@kernel.org>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
 <20250107162350.1281165-3-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107162350.1281165-3-ninad@linux.ibm.com>

On Tue, Jan 07, 2025 at 10:23:39AM -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface driver.

Please mention this is already is already in use both in a driver and 
.dts files.

> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> new file mode 100644
> index 000000000000..9136ac8004dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IPMB Device Driver

Bindings are for devices, not drivers. Drop 'Driver'. It's a stretch 
that IPMB is even a device, but since there are already a few users, I 
guess we're stuck with it.

> +
> +description: IPMB Device Driver bindings

No point in a description that just repeats the title. Please expand 
this. For example, AIUI, this is for the device end, not the BMC end.

> +
> +maintainers:
> +  - Ninad Palsule <ninad@linux.ibm.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ipmb-dev
> +
> +  reg:
> +    maxItems: 1

As this is the slave end, I2C_OWN_SLAVE_ADDRESS should be set. So:

minimum: 0x40000000
maximum: 0x4000007f

Maybe 10-bit addressing has to be supported too?

> +
> +  i2c-protocol:
> +    description:
> +      This property specifies that the I2C block transfer should be performed
> +      instead of SMBUS block transfer.

This can be more concisely said:

Use I2C block transfer instead of SMBUS block transfer.

> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        i2c@10 {

'i2c' node name is for i2c buses and this is not one. 'ipmb' is probably 
fine here.

> +            compatible = "ipmb-dev";
> +            reg = <0x10>;
> +            i2c-protocol;
> +        };
> +    };
> -- 
> 2.43.0
> 

