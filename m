Return-Path: <netdev+bounces-214646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9A7B2AB5F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E437B1638
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07035A2A6;
	Mon, 18 Aug 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+/OZpX3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201E35A281;
	Mon, 18 Aug 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528351; cv=none; b=L056EsCqFMfZy249LpCL5iRM4aqUaT2as/RHTELXaU3mNOlZbCvUXiUUk3/ErYl0KC1qgMB9O/NvMU0ZtwXDFiw174JQszhUjQzRPFcwTW1KG7U0s5Wy9JhQBQHnzu9gCEUpl+oBludK0gX5Ko7vDAEeeBQcNi24Xykw3+DGvDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528351; c=relaxed/simple;
	bh=X0oD6T+0KCeyvHa6EsuJf8DOYSfoCovDJsEwGreIgnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWwN3ys3Z1QrIx1bXuziDGa3bQPSJMXS6eyUN1ZkXHSidFzXLnBQT1n/e6S+R2ggccfli8Ll6zo1693ZoEyhnmOo0meCLip+le9D+FGD4ZvmF6gJUXd3x66ciLW0MTp4jfeU5EgPpXo8FPDHRl4L6r8wZy2jZ5VZkeDOqstybvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+/OZpX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE30C4CEEB;
	Mon, 18 Aug 2025 14:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755528351;
	bh=X0oD6T+0KCeyvHa6EsuJf8DOYSfoCovDJsEwGreIgnA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g+/OZpX3i3AWlAOFr4MPqwCQev5CfIXjLB2Keddvm2ql15Z/X1E8PZVlFBd3LCCbQ
	 5rdfTOsUvclgeSA2lPtuAxCIwibJci9EYWmu8UpR4BhgySWjb+FldU//zbVkaC7ham
	 gZFMxhKz1sRvOpMqpA97CKGl7tXkkR4WC72cxC38ysz/sVwt9NDShcEUWktD8eBlHO
	 PXiW9AXkMAT33P6C97oy7yo7l+zVxdNbnL02fhC/Za+pUd8Dns2mEjuy4D7aDNkpZ0
	 8Ms4nBqDl3qypFP+VY19+neK+1rdWL1x2T4Ig6UiFEet4OOh1/7zvdoUW/Xqbq7rJf
	 Rl+kgUJyfvE6Q==
Message-ID: <fa24dba2-8569-4564-83ef-08c5f8734e61@kernel.org>
Date: Mon, 18 Aug 2025 16:45:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: power: mediatek: Add new MT8189 power
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
 <20250818115754.1067154-3-irving-ch.lin@mediatek.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250818115754.1067154-3-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 13:57, irving.ch.lin wrote:
> From: Irving-ch Lin <irving-ch.lin@mediatek.com>
> 
> Add the new binding documentation for power controller
> on MediaTek MT8189.
> 
> Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
> ---
>  .../mediatek,mt8189-power-controller.yaml     | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
> new file mode 100644
> index 000000000000..1bf8f94858c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/mediatek,mt8189-power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Power Domains Controller for MT8189
> +
> +maintainers:
> +  - Qiqi Wang <qiqi.wang@mediatek.com>
> +
> +description: |
> +  MediaTek processors include support for multiple power domains which can be
> +  powered up/down by software based on different application scenes to save power.
> +
> +  IP cores belonging to a power domain should contain a 'power-domains'
> +  property that is a phandle for SCPSYS node representing the domain.
> +
> +properties:
> +  $nodename:
> +    pattern: '^power-controller(@[0-9a-f]+)?$'

Drop. Reg is not optional.

> +
> +  compatible:
> +    enum:
> +      - mediatek,mt8189-scpsys
> +

reg goes here.

> +  '#power-domain-cells':
> +    const: 1
> +
> +  reg:
> +    description: physical base address and size of the power-controller's register area.

No. Don't use AI tools... Look how this is written based on other bindings.

> +
> +  infra-infracfg-ao-reg-bus:

Follow established practice... You do not get common properties.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the device containing the infracfg register range.

Also do not say what is obvious from property name, but explain the purpose.


> +
> +  emicfg-ao-mem:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the device containing the emicfg register range.
> +
> +  vlpcfg-reg-bus:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the device containing the vlpcfg (very low power config) register range.
> +
> +  clocks:
> +    description: |
> +      A number of phandles to clocks that need to be enabled during domain
> +      power-up sequencing.
> +
> +  clock-names:
> +    description: |
> +      List of names of clocks, in order to match the power-up sequencing
> +      for each power domain we need to group the clocks by name. BASIC
> +      clocks need to be enabled before enabling the corresponding power
> +      domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> +      SUSBYS clocks need to be enabled before releasing the bus protection,
> +      and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> +
> +      In order to follow properly the power-up sequencing, the clocks must
> +      be specified by order, adding first the BASIC clocks followed by the
> +      SUSBSYS clocks.
> +
> +  domain-supply:
> +    description: domain regulator supply.
> +
> +required:
> +  - compatible
> +  - reg
Incomplete. Devices cannot work without power and many other things.

Sorry, but this binding is very poor and I feel like you did not put
enough of effort to write correct one. You are not independent
contributor, but do it as part of Mediatek, so I do not understand why
in Mediatek you cannot do basic in-house review.


Best regards,
Krzysztof

