Return-Path: <netdev+bounces-215403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A798B2E740
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 23:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8194C7B09C0
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 21:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56298304BD5;
	Wed, 20 Aug 2025 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAuqXO8G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CB1C3306;
	Wed, 20 Aug 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724432; cv=none; b=iH2VtaOlCc/T5IrKwq6KOmOE21J5Xqvh61ded2U1B9/N0JYmG+NvbgzfXIpQchz11TLj+rQxzPsocmFM9goduti9mtD9wjliSp/0Wrz8jgzi4wkDJQWQbuCVGG7+6KPdS27UgP0UWbsb/t10+pMh/OR83npFbT7OALFT6MJR2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724432; c=relaxed/simple;
	bh=WV7VhBpXVnPGHMwCHb6sbkmgr2ObSQPssfODRH4+LN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm/DG/uNeRn1v4rZkS8YaUsn1uYoHdsJMEcnvSbRI4pnFW3MJRb4XJo9kuDOJ7iF4IIJe9JUA8tPaN5msW2UWEgDA6lhXmSRk2wV6FPfc7mLRHSe0bvrU0bmuYYpp6fCjiHTkATFjREdugd1q9S+h4FmrEM65BYkHjtXkBoivX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAuqXO8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939A7C4CEE7;
	Wed, 20 Aug 2025 21:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755724431;
	bh=WV7VhBpXVnPGHMwCHb6sbkmgr2ObSQPssfODRH4+LN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAuqXO8GXBeANo9jz7yeTT6uuCkttWIlDQgua/WZD4ycp2oEW97roCewQJYSQyBno
	 DVlq2xisIwlRpo9bSLZtg9RMGtsuqlXesSl5tgB626tXaC3KEuUn/TtFxU19Uuvwaf
	 eHaTi2bAJqa0Hq+sToJxdSpsIjrGyT1717GguUtgSI8Fkm55Gq0gKIV8QfxB4k+FON
	 QcERc0ZkcxC229nyWXERKW9XcG7HUsYCtp9c4L+L9PTyNBYoxZOfV932eke6hs3tKr
	 pyLCH3BPG0fbegsubnKrL4I8TeHKlW7cWaf53KZi29HGw+DbcgTZGDb7oEhkjhZ+Na
	 pq7s66A7OQAIQ==
Date: Wed, 20 Aug 2025 16:13:50 -0500
From: Rob Herring <robh@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, mschmidt@redhat.com, poros@redhat.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next] dt-bindings: dpll: Add per-channel Ethernet
 reference property
Message-ID: <20250820211350.GA1072343-robh@kernel.org>
References: <20250815144736.1438060-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815144736.1438060-1-ivecera@redhat.com>

On Fri, Aug 15, 2025 at 04:47:35PM +0200, Ivan Vecera wrote:
> In case of SyncE scenario a DPLL channels generates a clean frequency
> synchronous Ethernet clock (SyncE) and feeds it into the NIC transmit
> path. The DPLL channel can be locked either to the recovered clock
> from the NIC's PHY (Loop timing scenario) or to some external signal
> source (e.g. GNSS) (Externally timed scenario).
> 
> The example shows both situations. NIC1 recovers the input SyncE signal
> that is used as an input reference for DPLL channel 1. The channel locks
> to this signal, filters jitter/wander and provides holdover. On output
> the channel feeds a stable, phase-aligned clock back into the NIC1.
> In the 2nd case the DPLL channel 2 locks to a master clock from GNSS and
> feeds a clean SyncE signal into the NIC2.
> 
> 		   +-----------+
> 		+--|   NIC 1   |<-+
> 		|  +-----------+  |
> 		|                 |
> 		| RxCLK     TxCLK |
> 		|                 |
> 		|  +-----------+  |
> 		+->| channel 1 |--+
> +------+	   |-- DPLL ---|
> | GNSS |---------->| channel 2 |--+
> +------+  RefCLK   +-----------+  |
> 				  |
> 			    TxCLK |
> 				  |
> 		   +-----------+  |
> 		   |   NIC 2   |<-+
> 		   +-----------+
> 
> In the situations above the DPLL channels should be registered into
> the DPLL sub-system with the same Clock Identity as PHCs present
> in the NICs (for the example above DPLL channel 1 uses the same
> Clock ID as NIC1's PHC and the channel 2 as NIC2's PHC).
> 
> Because a NIC PHC's Clock ID is derived from the NIC's MAC address,
> add a per-channel property 'ethernet-handle' that specifies a reference
> to a node representing an Ethernet device that uses this channel
> to synchronize its hardware clock. Additionally convert existing
> 'dpll-types' list property to 'dpll-type' per-channel property.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  .../devicetree/bindings/dpll/dpll-device.yaml | 40 ++++++++++++++++---
>  .../bindings/dpll/microchip,zl30731.yaml      | 29 +++++++++++++-
>  2 files changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
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

Dropping this is an ABI change. You can't do that unless you are 
confident there are no users both in existing DTs and OSs.

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
> +              Specifies a reference to a node representing an Ethernet device
> +              that uses this channel to synchronize its hardware clock.
> +            $ref: /schemas/types.yaml#/definitions/phandle

Seems a bit odd to me that the ethernet controller doesn't have a link 
to this node instead. 

Rob

