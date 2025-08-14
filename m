Return-Path: <netdev+bounces-213624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FB3B25EB9
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FA09E4E22
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B40C2E7F18;
	Thu, 14 Aug 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcjcHZsA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0B25B2E3;
	Thu, 14 Aug 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159918; cv=none; b=gFWp9R1ZJZmXfFKfzMD/Lbs9R1bSQVrszgLNrJ0r9zCfivIHBjNaF9qQfobhxsGo5N/uSu0m5qa5cXr8EUZcnNpoiHBSpjmNVoPtk0xuBmdfctvTBULkPFvFDY1WYG/tZa/k+jjpZhC3NZkY4dLhywFj4WvHI+KSXo02oZVSODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159918; c=relaxed/simple;
	bh=dYIA7UOSbS43SOyG7AKwv7s6w9he9lCrJcBrQ8/YkyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAeoUWsw2BuT5lO/JwrpJchwCA7dv/bKXyDNUqeudC6emwJ86se9tNc5bdhGQnXrVzs5FrD8BiwiTrGD8ONxYZU3OQXhrQEmI9T8xYSo2bdX5tp2mN4CHDqpRJ6ClW8rb2che1YMnJAP4EXPUo1PcQsMGaah8+PXx3ViU36mwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcjcHZsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9B7C4CEEF;
	Thu, 14 Aug 2025 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755159916;
	bh=dYIA7UOSbS43SOyG7AKwv7s6w9he9lCrJcBrQ8/YkyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcjcHZsADqs+sJkzu1Gy0PLfHNkyWqX5C1yiQZT6Ji8Y3UIHwyg1VW9Yk3Lbou9z2
	 BBQU9UpGiecRCltFBSP3//i7bBxsjPJdo/D0nOKb9CIU3siKvO4OOYHY5KnN1hrmNI
	 i/wH74GN9f8VbEdv174T/xKjoDLhZyHVmt9L/ZbcqXflZ3O7Lev1n8udGv7UAhn68P
	 C70orfCyHjDRw6S/GFhJF74mcL8Mt7bV9y+zEbJ8Go2aiErMmXDT1NzFWpRZUFoIFM
	 MUgWi3HWNJ45jJSQWS7Hs9vDi62A0V4J19MuKZeBbOv+uOUbw6WFJ+OLB3m6pImxvN
	 X/LTl4OHH2FfA==
Date: Thu, 14 Aug 2025 10:25:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	richardcochran@gmail.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, 
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev, Frank.Li@nxp.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, fushi.peng@nxp.com, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <20250814-hospitable-hyrax-of-health-21eef3@kuoka>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-2-wei.fang@nxp.com>

On Tue, Aug 12, 2025 at 05:46:20PM +0800, Wei Fang wrote:
> NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
> Integrated Endpoint (RCiEP), the Timer is one of its functions which
> provides current time with nanosecond resolution, precise periodic
> pulse, pulse on timeout (alarm), and time capture on external pulse
> support. And also supports time synchronization as required for IEEE
> 1588 and IEEE 802.1AS-2020. So add device tree binding doc for the
> PTP clock based on NETC Timer.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> ---
> v2 changes:
> 1. Refine the subject and the commit message
> 2. Remove "nxp,pps-channel"
> 3. Add description to "clocks" and "clock-names"
> v3 changes:
> 1. Remove the "system" clock from clock-names
> ---
>  .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> new file mode 100644
> index 000000000000..60fb2513fd76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP NETC V4 Timer PTP clock
> +
> +description:
> +  NETC V4 Timer provides current time with nanosecond resolution, precise
> +  periodic pulse, pulse on timeout (alarm), and time capture on external
> +  pulse support. And it supports time synchronization as required for
> +  IEEE 1588 and IEEE 802.1AS-2020.
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +  - Clark Wang <xiaoning.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1131,ee02
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      The reference clock of NETC Timer, if not present, indicates that
> +      the system clock of NETC IP is selected as the reference clock.
> +
> +  clock-names:
> +    description:
> +      The "ccm_timer" means the reference clock comes from CCM of SoC.
> +      The "ext_1588" means the reference clock comes from external IO
> +      pins.
> +    enum:
> +      - ccm_timer

You should name here how the input pin is called, not the source. Pin is
"ref"?

> +      - ext_1588

This should be just "ext"? We probably talked about this, but this feels
like you describe one input in different ways.

You will get the same questions in the future, if commit msg does not
reflect previous talks.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-device.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        ethernet@18,0 {

That's rather timer or ptp-timer or your binding is incorrect. Please
describe COMPLETE device in your binding.

> +            compatible = "pci1131,ee02";
> +            reg = <0x00c000 0 0 0 0>;

Best regards,
Krzysztof


