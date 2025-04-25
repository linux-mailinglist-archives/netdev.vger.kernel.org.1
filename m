Return-Path: <netdev+bounces-185887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA5A9BFE7
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C74189C907
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F022F169;
	Fri, 25 Apr 2025 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIqPnwAB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BAA29;
	Fri, 25 Apr 2025 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566759; cv=none; b=g2u5ibeMR/iCTeLSvtd89ds5p3/HCnyB2j9gp3DIYvPDA/fgwiWyJzLjmZHAcw9/6y9QcEsfg4PKCXyRxowNYTRmtP72UofmhkD7GOZGhRLJ/l3gP8AQaPBMuX2RdJ2lOfqXsO9f3q8oz83ihjbx78aGcNn/46XoXrXDJmfkxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566759; c=relaxed/simple;
	bh=365b8kbH3MeVvxk2IpLZYYDk1QJJ8xBLvr9s5A7tcMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZaJKd2coskRkf+8cA9LTxiKQm3uaaWeRmmcKKepQiIGm15Nv5zEgoVqcpARszH0PHVUp7LuPFpt+AS4bNZgjYdpVGY0E1EvttcvCwGkWIcm4Z692QpZo95Ilpj2m8tXkVVRzFnPNq5CA47ObvdA8eqFLQZeVdfuC41Fb6w6+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIqPnwAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899E6C4CEE4;
	Fri, 25 Apr 2025 07:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745566759;
	bh=365b8kbH3MeVvxk2IpLZYYDk1QJJ8xBLvr9s5A7tcMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIqPnwAB27l0ZmSsBK2JErBzaZS637ACmaawT7PMVMH6S9cayH0pxZvQuScRqS5wi
	 wfUikJCJ2UoLQsebs9nQTVZqdsiEJMsuZV5TAr+fHFL82+P9v8ac0yU9Z7+VrCQRLG
	 DJ60WgspGx8UFZo3Usdp1sKuaycrfb+d9MX2NrpBqeAyGFdLaKLq5YdwoMFtmLyBg6
	 scfz8g8aZAGYfrUqiIO9b7rF/wJCEUUQ8YZPTvtQPM9AfC9vhPcCOmpACCav20azes
	 huMXUllbjkbEtEvgI++CdTidCgUCwpQjpms8OhSK3SUNBcgD0v+WnUZd2zZYlOM4ow
	 DoAh/qyvil7Gw==
Date: Fri, 25 Apr 2025 09:39:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/8] dt-bindings: dpll: Add DPLL device and
 pin
Message-ID: <20250425-manul-of-undeniable-refinement-dc6cdc@kuoka>
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424154722.534284-2-ivecera@redhat.com>

On Thu, Apr 24, 2025 at 05:47:15PM GMT, Ivan Vecera wrote:
> Add a common DT schema for DPLL device and its associated pins.
> The DPLL (device phase-locked loop) is a device used for precise clock
> synchronization in networking and telecom hardware.
> 
> The device includes one or more DPLLs (channels) and one or more
> physical input/output pins.
> 
> Each DPLL channel is used either to provide a pulse-per-clock signal or
> to drive an Ethernet equipment clock.
> 
> The input and output pins have the following properties:
> * label: specifies board label
> * connection type: specifies its usage depending on wiring
> * list of supported or allowed frequencies: depending on how the pin
>   is connected and where)
> * embedded sync capability: indicates whether the pin supports this
> 
> Check:

This does not belong to commit msg. You do not add compile commands of C
files, do you?

Whatever you want to inform and is not relevant in the Git history
should be in changelog part.


> $ make dt_binding_check DT_SCHEMA_FILES=/dpll/
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /home/cera/devel/kernel/linux-2.6/Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
>   CHKDT   ./Documentation/devicetree/bindings
>   LINT    ./Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/dpll/dpll-pin.example.dts
>   DTC [C] Documentation/devicetree/bindings/dpll/dpll-pin.example.dtb
>   DTEX    Documentation/devicetree/bindings/dpll/dpll-device.example.dts
>   DTC [C] Documentation/devicetree/bindings/dpll/dpll-device.example.dtb
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v3->v4:
> * dropped $Ref from dpll-pin reg property
> * added maxItems to dpll-pin reg property
> * fixed paragraph in dpll-pin desc

...

> +
> +properties:
> +  $nodename:
> +    pattern: "^dpll(@.*)?$"
> +
> +  "#address-cells":
> +    const: 0
> +
> +  "#size-cells":
> +    const: 0
> +
> +  dpll-types:
> +    description: List of DPLL channel types, one per DPLL instance.
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    items:
> +      enum: [pps, eec]

Do channels have other properties as well in general?

> +
> +  input-pins:
> +    type: object
> +    description: DPLL input pins
> +    unevaluatedProperties: false

Best regards,
Krzysztof


