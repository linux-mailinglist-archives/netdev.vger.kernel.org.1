Return-Path: <netdev+bounces-213600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C47DB25C99
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2B51C26C8D
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2B25EF9C;
	Thu, 14 Aug 2025 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOlEDaW5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B553325A326;
	Thu, 14 Aug 2025 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155052; cv=none; b=qVaOdipGv9V4BWAN0FCQg8A+6nDna5chfEeA9BI9BoH6uG5o7/9zK8bXwUfw29fg0diSJlQfCIajiFvRngoPAhym6Pfet5yaPU9ny/XqeqBbmMmCSKez4AdIQ7uWGMExJ6YzRg07jiuurDqP7tTrxVbHqKDkgRUAnbrQj7eT0TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155052; c=relaxed/simple;
	bh=7pJ0Fl261mW06QcqNKqe/+yuvQAesZpRiKlzp/hYupk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jvp6WGAr32t5Kc8yXYPe0H98KJ2NJzhPxhUzQzgD9MvpLef5LKtDRKL5NAuip1EfWYHtEnZWKiTgEn9lbCpsD3biq6bmoLnRgXTZTpoyEZrcIAk8MEdXCAWgqAKfDsBsB9aSp2dOjeh0Qyfx+9ifkO7ZUKSMuQDuKM2UrRUeWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOlEDaW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBB6C4CEEF;
	Thu, 14 Aug 2025 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755155052;
	bh=7pJ0Fl261mW06QcqNKqe/+yuvQAesZpRiKlzp/hYupk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cOlEDaW5ECeXrzN6DPKXy+8yDJuFotlq5GGenZw4h+YwpzB27POapMjDf3zI2vNjr
	 7NGamYhZSAESN4SQsIT14gGugSgp+qc5VyanSZjUgRXYx0EiQ5hlNzuM82YktHn1SC
	 meXT1qphP5QpMiGzFMoBZHOkw6J7eCAHNu3buCi2dNwSVn4dR25j1/jqFCj5ZEzSzE
	 BcbDoXXDkkfc3RYyRXcaUemNEndurNv9zZQrDzBFkaHHZPSJXDXNMTj/W9zW3U4vu1
	 6OWOvaUk7zcckhKDF/u2VgIFRSlRKylp3gRiHycSNwAJK1zKdQlfobKZYwwDHXyE76
	 DBbgISTw3I/0w==
Message-ID: <ef95652d-eafd-45e1-9603-16c4edcb8e9e@kernel.org>
Date: Thu, 14 Aug 2025 09:04:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814065032.3766988-1-mmyangfl@gmail.com>
 <20250814065032.3766988-2-mmyangfl@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250814065032.3766988-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2025 08:50, David Yang wrote:
> The Motorcomm YT921x series is a family of Ethernet switches with up to
> 8 internal GbE PHYs and up to 2 GMACs.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../bindings/net/dsa/motorcomm,yt921x.yaml    | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
> new file mode 100644
> index 000000000000..2f0e4532e73e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/motorcomm,yt921x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Motorcomm YT921x Ethernet switch family
> +
> +maintainers:
> +  - David Yang <mmyangfl@gmail.com>
> +
> +description: |
> +  The Motorcomm YT921x series is a family of Ethernet switches with up to 8
> +  internal GbE PHYs and up to 2 GMACs, including YT9213NB, YT9214NB, YT9215RB,
> +  YT9215S, YT9215SC, YT9218N, YT9218MB.
> +
> +  For now, only YT9215 is supported.

Please describe complete hardware. Drivers are not relevant here and
binding cannot support anything, thus this feels like comment about drivers.

> +
> +properties:
> +  compatible:
> +    const: motorcomm,yt9215
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: Optional gpio specifier for a reset line

Drop comment, 100% redundant.

> +    maxItems: 1
> +
> +  motorcomm,switch-id:
> +    description: |
> +      When managed via mdio, hard-configured switch id to distinguish between
> +      multiple devices.

IDs are not allowed.

> +    enum: [0, 1, 2, 3]
> +    default: 0
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: MDIO bus for the internal GbE PHYs.
> +
> +  mdio-external:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: External MDIO bus.
> +
> +    properties:
> +      compatible:
> +        const: motorcomm,yt921x-mdio-external

Incomplete compatible... but also not needed in the first place.

> +
> +    required:
> +      - compatible
> +
> +allOf:
> +  - $ref: dsa.yaml#/$defs/ethernet-ports
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        switch@1d {
> +            compatible = "motorcomm,yt9215";
> +            reg = <0x1d>;
> +

Incomplete example. Where are all other properties?



Best regards,
Krzysztof

