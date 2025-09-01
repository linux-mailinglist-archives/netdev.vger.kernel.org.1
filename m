Return-Path: <netdev+bounces-218605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA10B3D876
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D481788C1
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 05:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86F236A8B;
	Mon,  1 Sep 2025 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd1Sd3oz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C823645D;
	Mon,  1 Sep 2025 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756702744; cv=none; b=EBiZ+Wwb8TdtcO2qo+jf1/se09r5zWdBCY2lbom+eZGmbI/EZIXOzhdeuVeUpW6AM2iF467fpqFdBEBJnod+hXhHQwePuwiullXYwGvW+HUqAmSvVmWcrLqfUTNHJj7YKfEHsF1VZCcvA3geiIjBSJJZzrQahihsvZQ4kvyND3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756702744; c=relaxed/simple;
	bh=P7G5UCKpW+MVGMwc64YN+JA2HPWMGZIxe/ZkNO3SR9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Roqvz0egs+AoolD1IcJ02sXrvrTKBuHCdng1pcrWeMCfPv1YjsdbRtXZf928UZM1GuIasE9XR8uts6EypJYcqEKv9FWL7/HH6hmOIzLeS3VVQr0wWLqnu9sCQVltfbePyPlBDrBCwG77b7HtDVsFhZCGAjf/Aoev6d7eIjKmAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd1Sd3oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89886C4CEF0;
	Mon,  1 Sep 2025 04:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756702744;
	bh=P7G5UCKpW+MVGMwc64YN+JA2HPWMGZIxe/ZkNO3SR9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nd1Sd3ozF3wB7WEC2fpWV8tWK9Siog8St1/gB/fOPMDzfwNDGyCiDf8pVSEKVaW/y
	 L5cTNJfOgsa7aaBT8650oCfYN++HxjJ+8q+aoyugBe9wO8MEMSe/bM3mqr1LH0ftWL
	 D7J7eY2Z1M67YSp6Dc2wAkkNukk2f/cvC7jgjOz6q1fk9PrlDwYAf4bqlBYDJyAkHZ
	 V8Uur5CvJcIsxIv/ZGazpfleCxWyiE8JLrSGwAigYk7w2/N/SggetKHPohodxjoWBZ
	 iZWoViZM53MBtHqFlzYexQvxXwOLs7Cuyvglf1T3nEa2r684hu/vM32brfTYnckW7o
	 exPOGFMKUyPUA==
Date: Mon, 1 Sep 2025 06:59:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	yzhu@maxlinear.com, sureshnagaraj@maxlinear.com
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: mxl: Add MxL LGM
 Network Processor SoC
Message-ID: <20250901-angelic-righteous-chipmunk-843fac@kuoka>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-2-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829124843.881786-2-jchng@maxlinear.com>

On Fri, Aug 29, 2025 at 08:48:42PM +0800, Jack Ping CHNG wrote:
> +title: MaxLinear LGM Ethernet Controller
> +
> +maintainers:
> +  - Jack Ping Chng <jchng@maxlinear.com>
> +
> +description:
> +  Binding for MaxLinear LGM Ethernet controller

Drop "Binding for" and write proper description of hardware, not what
binding is for.

What is LGM? What is LGM SoC? Why there is nowhere anything about that
LGM SoC?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxlinear,lgm-eth
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: port
> +      - const: ctrl
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ethif
> +
> +  resets:
> +    maxItems: 1
> +
> +  ethernet-ports:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^port@[0-3]$":
> +        type: object
> +        $ref: ethernet-controller.yaml#
> +        additionalProperties: false
> +
> +        properties:
> +          reg:
> +            description: port id
> +            maxItems: 1
> +
> +          phy-handle:
> +            maxItems: 1
> +
> +        required:
> +          - reg
> +          - phy-handle
> +
> +  mdio:
> +    $ref: mdio.yaml#
> +    unevaluatedProperties: false
> +
> +additionalProperties: false

Why did you move this? Previous position was correct, after required:.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - mdio
> +
> +examples:
> +  - |
> +    ethernet@e7140000 {
> +        compatible = "maxlinear,lgm-eth";
> +        reg = <0xe7140000 0x1200>,<0xe7150000 0x4000>;

Missing space after ,

> +        reg-names = "port", "ctrl";
> +        clocks = <&cgu0 32>;
> +        clock-names = "ethif";
> +        resets = <&rcu0 0x70 8>;

Best regards,
Krzysztof


