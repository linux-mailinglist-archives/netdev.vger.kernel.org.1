Return-Path: <netdev+bounces-20595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F229B76031A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341011C20CA9
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9F212B96;
	Mon, 24 Jul 2023 23:26:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F5A12B6D
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DCFC433C8;
	Mon, 24 Jul 2023 23:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690241187;
	bh=4KSq1+MwOBFiXF30dhtmS7Fj1Uen43j4cbGhaxzDkQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVl0guQBTKgPU625eTtTiJ730ZEWk7Y7+8PLfxgxYRhJk9+ktGWz3b306R3LK8Heg
	 L5g6xPDWJyM0EB7e0GlDoGR9kmlt5H3dE6q81sx4C7Ju1thz0PdaKdYfwP7xOLXA6Y
	 RGrBj5+Iz8N0rNN8SyvwvWDsgnsKdBLI5s8XmcCnvDXmuHh+9udH0VRpm+28ZFoZYG
	 baB2Vv3XExVU2KQUsO9vFNMpwiiNzyQrXJRP6uuSukARjfty/1k1YEjsuc6BpVsh6p
	 dnArt6BOWuU3gl6Glu2BW0Nm+nHiHAZhldyqu+m5InAVFou0GdIXNqethlH29s389V
	 onJqHwhLpZzSw==
Received: (nullmailer pid 1114814 invoked by uid 1000);
	Mon, 24 Jul 2023 23:26:24 -0000
Date: Mon, 24 Jul 2023 17:26:24 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 07/10] dt-bindings: net: snps,dwmac: add safety
 irq support
Message-ID: <20230724232624.GA1112850-robh@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
 <20230723161029.1345-8-jszhang@kernel.org>
 <20230724-cleat-tricolor-e455afa60b14@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724-cleat-tricolor-e455afa60b14@spud>

On Mon, Jul 24, 2023 at 06:23:13PM +0100, Conor Dooley wrote:
> On Mon, Jul 24, 2023 at 12:10:26AM +0800, Jisheng Zhang wrote:
> > The snps dwmac IP support safety features, and those Safety Feature
> > Correctible Error and Uncorrectible Error irqs may be separate irqs.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index ddf9522a5dc2..bb80ca205d26 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -107,6 +107,8 @@ properties:
> >        - description: Combined signal for various interrupt events
> >        - description: The interrupt to manage the remote wake-up packet detection
> >        - description: The interrupt that occurs when Rx exits the LPI state
> > +      - description: The interrupt that occurs when Safety Feature Correctible Errors happen
> > +      - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
> >  
> >    interrupt-names:
> >      minItems: 1
> > @@ -114,6 +116,8 @@ properties:
> >        - const: macirq
> >        - enum: [eth_wake_irq, eth_lpi]
> >        - const: eth_lpi
> > +      - const: sfty_ce_irq
> > +      - const: sfty_ue_irq
> 
> Putting _irq in an interrupt name seems rather redundant to me although,
> clearly not the first time for it here.

It's already inconsistent, so don't follow that pattern. Drop '_irq'.

> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.



