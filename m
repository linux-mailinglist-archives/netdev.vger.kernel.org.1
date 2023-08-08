Return-Path: <netdev+bounces-25264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618F7739BC
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 12:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03F8281684
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0069E57E;
	Tue,  8 Aug 2023 10:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226520FF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A410EC433C7;
	Tue,  8 Aug 2023 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691491356;
	bh=JGo7EBuRfvMkPe2azYS3kN7ld2w91JHGAUkojy0rktE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kS/Q6i3nQ9+WnKOSFTu7PB+OQVPot1K2wUD0sTEvdRrNj4jVLKU4NG5mGsGwk2VSY
	 UhUjaaUoswvJqZ/6VjJddcyrwNLSBfB2qmxYgFHInd1f1a4dKiHcyoYRUaq3ht1620
	 yk0aYI6UI+bxzZCd7NPIZVIaDk9UrXOQ0xzx51ZO7Kwn1n4Ui3PFnRWslmawb4ZlnD
	 6noMzGM+9rOUK1DtPdUAAsZ7JOlfDkdkIgapoyzNv3uO8KmpQ9bFArym8hwrLS6ynr
	 T7FFaP8Jg7BJUfNQNa3fc0TS5qoKowHVWTP7c+b1Hw6IEZXXI5F3mpL1x/H4Y4nP/e
	 KZXCcq5rUNuXQ==
Message-ID: <e98f134a-a57a-3cbc-3cb1-378d6b411406@kernel.org>
Date: Tue, 8 Aug 2023 13:42:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/5] dt-bindings: net: Add iep property in ICSSG dt
 binding
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap
 <rdunlap@infradead.org>, Simon Horman <simon.horman@corigine.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230807110048.2611456-3-danishanwar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230807110048.2611456-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/08/2023 14:00, MD Danish Anwar wrote:
> Add iep node in ICSSG driver dt binding document.

s/iep/IEP here and in subject
s/dt/DT here and in subject

> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 8ec30b3eb760..36870238f92f 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -52,6 +52,12 @@ properties:
>      description:
>        phandle to MII_RT module's syscon regmap
>  
> +  ti,iep:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 2
> +    description:
> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSSG driver
> +
>    interrupts:
>      maxItems: 2
>      description:
> @@ -155,6 +161,7 @@ examples:
>                      "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>                      "rx0", "rx1";
>          ti,mii-g-rt = <&icssg2_mii_g_rt>;
> +        ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
>          interrupt-parent = <&icssg2_intc>;
>          interrupts = <24 0 2>, <25 1 3>;
>          interrupt-names = "tx_ts0", "tx_ts1";

-- 
cheers,
-roger

