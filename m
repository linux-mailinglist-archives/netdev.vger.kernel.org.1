Return-Path: <netdev+bounces-211746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6535B1B77E
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09ED189269B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AE612F5A5;
	Tue,  5 Aug 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tmvcjC22"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49894A28;
	Tue,  5 Aug 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407926; cv=none; b=N9NfjerYqm+Vxo10tTQc6A5Wnu+v35vDCd0e8Xw+7mpTtzHBGGze3ff2g/F686SslRrGJyFV390f5SggkfLIMKav6Zn9/QftKQzNuTjsQzWF0lQKpl9woTk12RF+GzEPw7M3iIgEx11L8LKKHkxzoabciChsPlY4a/MXnqVxnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407926; c=relaxed/simple;
	bh=zYc7c7d/i8Ql+qF+dnrBKCxeKxXeIyUFSPFcsCvQc5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzlcUh0Z7oqsiQFuK8AqL0x0jMfi8MNdNwtDAHT5e2DpZsrKmTo9Vb/30U7XT3tbLJtqPAZnZ8ZT6iWS+ZqzT4+BwRa4muc0eH5RsfCk+MxDxvQYSFqP4PY7m9SsXIdkf7Ss8iKoM8xVKiMJMOv10p66i9KXrt+IIv3XMDxMDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tmvcjC22; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PXyobKWbJw7huI969vcAU8isGv2OVX47I8Rs8Gm3eDk=; b=tmvcjC22yhmD1AcNl4Rky/fc1P
	kdPOdRT5B63v65VBnB6TEWLW8omk7NhxEwmXzsjEQtA0hu4nnwQV74b8I7YNfUFQ8cXGU9iuPTG+m
	qptmPQaAac2kOXRwe6Uov+9vnKU0ViY6rYcfMrLHrUtt/AjPHe+hUAoEdw9zl6mqjdJ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujJdp-003nnS-7I; Tue, 05 Aug 2025 17:31:53 +0200
Date: Tue, 5 Aug 2025 17:31:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: dpll: Add clock ID property
Message-ID: <47cf42a2-bc8e-4ed8-8619-79975b95230f@lunn.ch>
References: <5ff2bb3e-789e-4543-a951-e7f2c0cde80d@kernel.org>
 <6937b833-4f3b-46cc-84a6-d259c5dc842a@redhat.com>
 <20250721-lean-strong-sponge-7ab0be@kuoka>
 <804b4a5f-06bc-4943-8801-2582463c28ef@redhat.com>
 <9220f776-8c82-474b-93fc-ad6b84faf5cc@kernel.org>
 <466e293c-122f-4e11-97d2-6f2611a5178e@redhat.com>
 <db39e1ff-8f83-468c-a8cb-0dd7c5a98b85@kernel.org>
 <f96b3236-f8e6-40c1-afb2-7e76894462f9@redhat.com>
 <1419bca0-b85a-4d4b-af1a-b0540c25933a@lunn.ch>
 <b33c76da-8ce1-402f-b252-f6d439ec39c7@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b33c76da-8ce1-402f-b252-f6d439ec39c7@redhat.com>

> Like this?
> 
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> index fb8d7a9a3693f..798c5484657cf 100644
> --- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> @@ -27,11 +27,41 @@ properties:
>    "#size-cells":
>      const: 0
> 
> -  dpll-types:
> -    description: List of DPLL channel types, one per DPLL instance.
> -    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> -    items:
> -      enum: [pps, eec]
> +  channels:
> +    type: object
> +    description: DPLL channels
> +    unevaluatedProperties: false
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^channel@[0-9a-f]+$":
> +        type: object
> +        description: DPLL channel
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            description: Hardware index of the DPLL channel
> +            maxItems: 1
> +
> +          dpll-type:
> +            description: DPLL channel type
> +            $ref: /schemas/types.yaml#/definitions/string
> +            enum: [pps, eec]
> +
> +          ethernet-handle:
> +            description:
> +              Specifies a reference to a node representing an Ethernet
> device
> +              that uses this channel to synchronize its hardware clock.
> +            $ref: /schemas/types.yaml#/definitions/phandle
> +
> +        required:
> +          - reg

Yes, but i will leave the DT Maintainers to give it a deeper review,
but this what i meant. And it makes your dpll-type much easier to
handle.

	Andrew

