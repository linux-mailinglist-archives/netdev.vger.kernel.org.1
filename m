Return-Path: <netdev+bounces-157210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D59A096BE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55D7188E63A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815C7212B29;
	Fri, 10 Jan 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+9hpbaI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7E620551F;
	Fri, 10 Jan 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525235; cv=none; b=b5TlWG7Vq9p4m69/lUoKsS8forc5tYXi2xETrdxyu0nH+Ss4BKSQhz5HvKO7JPnrH4W4Dzifyx2XCSkEvUIzglOg3QXqtyIye3tLDEGm+DkJpMlK28GTEUQ/6dmTRWdI7M2OGLKhayeGayfiVqoF93sLi5WLKbDgguzXsZiffLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525235; c=relaxed/simple;
	bh=8ic0fmAFCingqmiYWExc1+9H7U4At02apc1uatdqHJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZb4tKdBOg832IsuGT5aTN4kueppmfpq73M7AaPLIGKzLHbKZCiUv5jVQHuVgSn/pxPXbTNyZ0/xYk/x5fgJCgDmT3zC7YgegxXM4HM7ub3TMu0Od+abI893WJ+UgR117A1JVskigfpOytoF//WjnucyuQGFD9xBjOl6YLGOtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+9hpbaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7E1C4CED6;
	Fri, 10 Jan 2025 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736525234;
	bh=8ic0fmAFCingqmiYWExc1+9H7U4At02apc1uatdqHJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+9hpbaIVj0FizWLBTAWdFSqcU/ByW3qkTkX6aDezSm2lBVzZd/sn0qs/9PXrA8Q4
	 idGoskoWOfDiMrR28hTdGd4EP4GR7tky/OOW0c2RmkLyfK0p4nEdSPYzJw5pUm7Jgs
	 6+BxOrKW86Yu76GQ+CkNNz9YIaoq7HDmT+0mT/1jrhlUPtZuImUsGli2KVgZDX6GrI
	 waLjYb0D5kB4O9yeG7i5fZOaHxy5BakYKOaVVr/ibq+qLFIMYwfLPVXfZ9OLLvWq0J
	 TjlUtV5r97UcbuTVykcU/CeIZKNX9FaGjzHpFrcxhWuLoBzIvHEoYuB7nKsmUZ+wr1
	 H3pRIN9+Xdmzw==
Date: Fri, 10 Jan 2025 10:07:13 -0600
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
Subject: Re: [PATCH v3 02/10] bindings: ipmi: Add binding for IPMB device intf
Message-ID: <20250110160713.GA2952341-robh@kernel.org>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-3-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108163640.1374680-3-ninad@linux.ibm.com>

On Wed, Jan 08, 2025 at 10:36:30AM -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface.
> This device is already in use in both driver and .dts files.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> new file mode 100644
> index 000000000000..a8f46f1b883e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IPMB Device
> +
> +description: IPMB Device interface to receive request and send response

IPMB is not defined anywhere.

Which side of the interface does this apply to? How do I know if I have 
an ipmb-dev?

This document needs to stand on its own. Bindings exist in a standalone 
tree without kernel drivers or docs.

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
> +
> +  i2c-protocol:
> +    description:
> +      Use I2C block transfer instead of SMBUS block transfer.
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
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ipmb-dev@10 {
> +            compatible = "ipmb-dev";
> +            reg = <0x10>;
> +            i2c-protocol;
> +        };
> +    };
> -- 
> 2.43.0
> 

