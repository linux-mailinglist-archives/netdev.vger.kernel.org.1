Return-Path: <netdev+bounces-185889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A35CA9BFED
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78C73B9724
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F6D22FAC3;
	Fri, 25 Apr 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCZRZp+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D61FDD;
	Fri, 25 Apr 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566894; cv=none; b=kznXZXKxwI+dumyQmYoXFcZSpgQt1Uh8ZoC17AKha2dhVO9fKPCqItR4gldhg8oNyWQSZZgNzbAgSaPWUNtW0yDGT9zuxLQs7+yL0qJVWsLNBKxAWpAP0q79rKAAod91PrtFgUfKuUL+XYkerXQby2Vp+37FhOczVXo/CMxpDaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566894; c=relaxed/simple;
	bh=aHtu+q8+v/+vHM2z9zRmM6zCmE4vzWRuotmMIXEjo2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iarYge0Ky8qwWCu2Clkk971vpB7DMz2a0DcwZHZziAc2dnUgQ09GdExco2lLYs/OHHLc4PWmn9Jmi6jiacQnJ6b08m6RKbhNj/U+uO4eGNLTNsg5dpUiuqZ1oaYqgwRJkRY2Cy//ObDDJc5gpl49jL8yR8HztI9ZpoDbgJz+vhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCZRZp+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5F1C4CEE4;
	Fri, 25 Apr 2025 07:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745566894;
	bh=aHtu+q8+v/+vHM2z9zRmM6zCmE4vzWRuotmMIXEjo2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCZRZp+A7DLJxpcSDgE2c5OY4mlXLvD7//yCsaBlqjAL/X2fLqpxgaUs1mFKxua2F
	 iNHDbQ4bC+KhffqmppK+mlPCNGMCPWmIFf/q/nYc5yrMzxV31XaGoLO8lT9lYPNfUy
	 jq2PhWtRfS8bnsEo8XVR/4u3Es1aeOSYFdBgzllWYHF8MZ1U+Uizr0DaculkXtycIk
	 Xyj30tGA83kyWU644a9RFvWcsT5rDRlWYuqnefdycayCmv89gMjEr4D8NUWjWsdkB0
	 PYApJhZlBQTMWJVSnNHKdx29XkTZ3F4Z3Ei2Z1NaWwqMESHc5pGaL1ehdZJBdorRkS
	 T6SdePECjOPRA==
Date: Fri, 25 Apr 2025 09:41:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/8] dt-bindings: dpll: Add support for
 Microchip Azurite chip family
Message-ID: <20250425-hopeful-dexterous-ibex-b9adce@kuoka>
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424154722.534284-3-ivecera@redhat.com>

On Thu, Apr 24, 2025 at 05:47:16PM GMT, Ivan Vecera wrote:
> Add DT bindings for Microchip Azurite DPLL chip family. These chips
> provide up to 5 independent DPLL channels, 10 differential or
> single-ended inputs and 10 differential or 20 single-ended outputs.
> They can be connected via I2C or SPI busses.
> 
> Check:
> $ make dt_binding_check DT_SCHEMA_FILES=/dpll/

None of these commands belong to the commit msg. Look at all other
commits: do you see it anywhere?

>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /home/cera/devel/kernel/linux-2.6/Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
>   CHKDT   ./Documentation/devicetree/bindings
>   LINT    ./Documentation/devicetree/bindings
>   DTC [C] Documentation/devicetree/bindings/dpll/dpll-pin.example.dtb
>   DTEX    Documentation/devicetree/bindings/dpll/microchip,zl30731.example.dts
>   DTC [C] Documentation/devicetree/bindings/dpll/microchip,zl30731.example.dtb
>   DTC [C] Documentation/devicetree/bindings/dpll/dpll-device.example.dtb
> 

With above fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

<form letter>
This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
</form letter>

Best regards,
Krzysztof


