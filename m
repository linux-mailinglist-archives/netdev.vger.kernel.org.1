Return-Path: <netdev+bounces-290263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HrvNfe0DmosBQYAu9opvQ
	(envelope-from <netdev+bounces-290263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:32:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE15A0278
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3A01304A6C3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7794F39A800;
	Thu, 21 May 2026 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVV1TIFv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271D3955C5;
	Thu, 21 May 2026 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348377; cv=none; b=OSSflHZ5BALPaJv1titicqSEFS18yyxbySYssdyo43a4sjErFw96IDnolz4DDybvevwoIuy1HmirewMWA7r+Y5fYkFofeIdZ3Zt+Hn6/DaHq09/K+FQUiMtP1WVfFuHHkVKOIZ7BiNWfvUZFjmAK5RsjirTvec9u9D7JQgR+MFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348377; c=relaxed/simple;
	bh=OFrMN6zDaqSIP5FGJvYTyqZ2WeD27ThPOdSlDMTVUZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8IoRa5HFGWrCN/a4jWNCocTIU/7y5aHO2KJVBk4EqwvXLS1Uep3Hyc39x5VwwgLwznSauKNHyA6LW6uDjcTjrKD+YPjuIsXDiV+69baU1Qfx26l7le/GHES6XfpJ9Ms3iT8F9ZnUCPgR4ZcSSwPjTn/zHfp5Es7hdL9VPIjlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVV1TIFv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C0B1F000E9;
	Thu, 21 May 2026 07:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779348373;
	bh=o9bC+9cpiCSB3nTnXAJVVDIec3sZpcV7549Ot/IF0lE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EVV1TIFvEJnrYVqmXZjyV294rD5EgD5Eqsc6y/zsG5mumVzK46O2m/xpL+eZ+GG66
	 58J71kmpPTCrP2hazDM2va/SoQcGIT7hkn+QYvnQgpXGq6SBXcax8CPHH0E0OMZfxi
	 ZXSIYXRlBLCi6nFHImYL27aQQHDIMTeKVfuaih/gD2uJl3EEH760rq+ipMuNOPOxCr
	 HLFF1SOEvYXCPNu3BpaqBsjBaUwmJ1x0HCP4uhPyi7P7MoOklbVzDYoY8o9uKOKOtK
	 b/y+7tR8vIkugCR4KJf7GULb/pbnS3Mej7U9xKyQaT6P17c7mCloQgyX5Jmpp0SVGx
	 gWV6NZyBMWeaQ==
Message-ID: <48cc27ed-48e8-41db-8351-166774466a69@kernel.org>
Date: Thu, 21 May 2026 09:26:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/3] dt-bindings: dpll: add SiTime SiT9531x
 clock generator
To: Ali Rouhi <rouhi.ali@gmail.com>, jiri@resnulli.us
Cc: vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ali Rouhi <arouhi@sitime.com>
References: <20260520191943.73938-1-arouhi@sitime.com>
 <20260520191943.73938-3-arouhi@sitime.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20260520191943.73938-3-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290263-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.68:email,devicetree.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sitime.com:email]
X-Rspamd-Queue-Id: 3EBE15A0278
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20/05/2026 21:19, Ali Rouhi wrote:
> Add device tree binding documentation for the SiTime SiT95316
> and SiT95317 DPLL clock generators.
> 
> Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>

Mismatched DCO. Use consistent identity or fix your commits.

> ---
>  .../bindings/dpll/sitime,sit9531x.yaml        | 145 ++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
> new file mode 100644
> index 000000000000..ac88f2f0b2ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dpll/sitime,sit9531x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiTime SiT9531x DPLL Clock Generator
> +
> +maintainers:
> +  - Ali Rouhi <arouhi@sitime.com>
> +
> +description: |
> +  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock
> +  generators with integrated DPLL for synchronization applications.  Both
> +  variants contain four PLLs with automatic/manual reference selection,
> +  DCO frequency adjustment, and phase offset measurement via an on-chip
> +  TDC (Time-to-Digital Converter).
> +
> +  SiT95317 provides 4 inputs and 8 outputs; SiT95316 provides
> +  4 inputs and 12 outputs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sitime,sit95316
> +      - sitime,sit95317
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      External crystal/oscillator feeding the chip's XIN/XO_CLK input.
> +      The chip's PLL Fvco is computed relative to this reference, so the
> +      driver requires a non-zero rate at probe time.

Same as last time. Why are you describing drivers?

> +
> +  clock-names:
> +    items:
> +      - const: xtal
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the chip's active-low reset pin (RESETB).
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt from the chip's active-low INTRB output.  Asserted when
> +      the device detects a status change such as lock acquisition or loss.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: /schemas/dpll/dpll-device.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    xo: xo {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <48000000>;
> +    };

Drop node. Wasn't here before, so why did you add it?


> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dpll@68 {
> +            compatible = "sitime,sit95317";
> +            reg = <0x68>;
> +            clocks = <&xo>;
> +            clock-names = "xtal";
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    xo2: xo2 {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <48000000>;
> +    };

Drop.

> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +



Best regards,
Krzysztof

