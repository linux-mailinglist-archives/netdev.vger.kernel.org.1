Return-Path: <netdev+bounces-29429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40ED7833A8
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55BB1C209EB
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D768C1C;
	Mon, 21 Aug 2023 20:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF08C0F
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2339C433C7;
	Mon, 21 Aug 2023 20:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692650011;
	bh=5vlYrHkhc7cFmjCTrb/meqorIzW1oUWzABr2g9dGJ2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCpkAnjeAAqTR93vSTyj3v30/3TC6Ft0XUih2pb9KE9QgRHMG6ZHIO1TGu178JiqN
	 KvSHLj7h2+xI1pmeEMV+k1i8kNrrcwRIswS4QKQ+moy23SqowM/KxhTxJZfMuwbivD
	 Oa0y/Jwesoi1lwav8V7D6H2mc7FK2cbjHmnrEt2X37K7nD/JjbaoofMBSiIFtpYQHF
	 9jcwxcfTxuY/QDMQhZdMK4cG4ZTNN9HKqBZW6oWMD4XMCanrlaF2xjRvsK2yDAP6xC
	 WQc7aeTnGi7jLbLIkjTzwEmcZeCi8sbA3GEm4+gjb+kDsKDWzhaJepNYbQ4cS1yDkV
	 0TGi0DXNqTXzA==
Received: (nullmailer pid 2247465 invoked by uid 1000);
	Mon, 21 Aug 2023 20:33:28 -0000
Date: Mon, 21 Aug 2023 15:33:28 -0500
From: Rob Herring <robh@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v5 6/9] dt-bindings: net: snps,dwmac: add safety
 irq support
Message-ID: <20230821203328.GA2197059-robh@kernel.org>
References: <20230817165749.672-1-jszhang@kernel.org>
 <20230817165749.672-7-jszhang@kernel.org>
 <wkzy3v272ia237pfhlvtrwbij7qeswb2zmkxhnsir5xtroezr7@frow2mvqeq35>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wkzy3v272ia237pfhlvtrwbij7qeswb2zmkxhnsir5xtroezr7@frow2mvqeq35>

On Fri, Aug 18, 2023 at 08:39:56PM +0300, Serge Semin wrote:
> On Fri, Aug 18, 2023 at 12:57:46AM +0800, Jisheng Zhang wrote:
> > The snps dwmac IP support safety features, and those Safety Feature
> > Correctible Error and Uncorrectible Error irqs may be separate irqs.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml         | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index ddf9522a5dc2..ee9174f77d97 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -103,17 +103,26 @@ properties:
> >  
> >    interrupts:
> >      minItems: 1
> > +    maxItems: 5
> > +    additionalItems: true
> >      items:
> >        - description: Combined signal for various interrupt events
> >        - description: The interrupt to manage the remote wake-up packet detection
> >        - description: The interrupt that occurs when Rx exits the LPI state
> > +      - description: The interrupt that occurs when Safety Feature Correctible Errors happen
> > +      - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
> >  
> >    interrupt-names:
> >      minItems: 1
> > +    maxItems: 5
> > +    additionalItems: true
> >      items:
> >        - const: macirq
> > -      - enum: [eth_wake_irq, eth_lpi]
> > -      - const: eth_lpi
> > +      - enum:
> > +          - eth_wake_irq
> > +          - eth_lpi
> > +          - sfty_ce
> > +          - sfty_ue
> 
> IIUC this would mean the next constraints:
> Item    0: must be macirq,
> Item    1: any of eth_wake_irq, eth_lpi, sfty_ce, sfty_ue
> Items 2:4: any bla-bla-bla.

Indeed.

> 
> After adding the per-DMA-channel IRQs in the next patches the array
> will be extended to up to 37 any names. It doesn't look correct. What
> about converting it to the position independent arrays constraint:
> 
>   interrupts:
>     minItems: 1
>     maxItems: 34
> 
>     
>   interrupt-names:
>     minItems: 1
>     maxItems: 34
>     items:
>       oneOf:
>         - description: Combined signal for various interrupt events
>           const: macirq
>         - description: The interrupt to manage the remote wake-up packet detection
>           const: eth_wake_irq
>         - description: The interrupt that occurs when Rx exits the LPI state
>           const: eth_lpi
>         - description: Safety Feature Correctible Errors interrupt
>           const: sfty_ce
>         - description: Safety Feature Uncorrectible Errors interrupt
>           const: sfty_ue
>         - description: DMA Tx per-channel interrupt
>           pattern: '^dma_tx([0-9]|1[0-5])?$'
>         - description: DMA Rx per-channel interrupt
>           pattern: '^dma_rx([0-9]|1[0-1])?$'
> 
>     allOf:
>       - contains:
>           const: macirq

This would keep macirq being first:

allOf:
  - maxItems: 34
    items:
      - const: macirq

In newer json-schema the schema and list versions were split into 
"prefixItems" and "items", so we could avoid the "allOf" with that. 
Unfortunately, the former is the list version which we use everywhere. I 
don't really want to do a treewide change of that and also I find the 
'prefixItems' name kind of awkward.


> Hope neither Krzysztof nor Rob will be against such modification
> especially seeing it's the only way to resolve the very much possible
> case of a device having macirq and per-DMA-channel IRQs but lacking
> the LPI, PMT or Safety IRQs.

Don't love it, but I give up on these licensed IPs. :(

Rob

