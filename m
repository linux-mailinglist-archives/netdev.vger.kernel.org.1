Return-Path: <netdev+bounces-20893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C683E761D49
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F4F281710
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C372E23BCD;
	Tue, 25 Jul 2023 15:24:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A1200BA
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 15:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF6FC433C8;
	Tue, 25 Jul 2023 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690298655;
	bh=+MfVjB/wjdps2ovrI3oDMNYk7WQRpUGIc0K5gkQDUIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPq8eVoFZT6gk5cJ4o3gDvI8uBvnJ6TORQWk/GOfQzPjuE9rZvceL+zOQYNP7fUh2
	 fNDsDS/AaOFWe1KSsuQQcW39LJyqTn240qTgogqgJNy6jkTj/jdc1o+gVHiOwqkANA
	 oDc6Eabr7/YJw5+lNZA4pDAO/S/bI4VYTouqQBJ2d209+JwGdpicCKYueCP2ykjzMK
	 zPTnnFqMHLVkXymEQNIu/9MjJCK09GEpowCDOMtrIxDAYGpqqz+hp6rwa7VoK0Ycul
	 7ZImFTWJ3mCi329bhEx2C9ALC9ntpS47htqEfnmNa3U4GjX1v9rq0JEA7QGb4e//9T
	 E44CiymAS7qMw==
Date: Tue, 25 Jul 2023 23:12:38 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 07/10] dt-bindings: net: snps,dwmac: add safety
 irq support
Message-ID: <ZL/mZiLQFLv1rpib@xhacker>
References: <20230723161029.1345-1-jszhang@kernel.org>
 <20230723161029.1345-8-jszhang@kernel.org>
 <20230724-cleat-tricolor-e455afa60b14@spud>
 <20230724232624.GA1112850-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724232624.GA1112850-robh@kernel.org>

On Mon, Jul 24, 2023 at 05:26:24PM -0600, Rob Herring wrote:
> On Mon, Jul 24, 2023 at 06:23:13PM +0100, Conor Dooley wrote:
> > On Mon, Jul 24, 2023 at 12:10:26AM +0800, Jisheng Zhang wrote:
> > > The snps dwmac IP support safety features, and those Safety Feature
> > > Correctible Error and Uncorrectible Error irqs may be separate irqs.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > index ddf9522a5dc2..bb80ca205d26 100644
> > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > @@ -107,6 +107,8 @@ properties:
> > >        - description: Combined signal for various interrupt events
> > >        - description: The interrupt to manage the remote wake-up packet detection
> > >        - description: The interrupt that occurs when Rx exits the LPI state
> > > +      - description: The interrupt that occurs when Safety Feature Correctible Errors happen
> > > +      - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
> > >  
> > >    interrupt-names:
> > >      minItems: 1
> > > @@ -114,6 +116,8 @@ properties:
> > >        - const: macirq
> > >        - enum: [eth_wake_irq, eth_lpi]
> > >        - const: eth_lpi
> > > +      - const: sfty_ce_irq
> > > +      - const: sfty_ue_irq
> > 
> > Putting _irq in an interrupt name seems rather redundant to me although,
> > clearly not the first time for it here.
> 
> It's already inconsistent, so don't follow that pattern. Drop '_irq'.

Thanks for the suggestion, will wait a bit to get more feedbacks before
sending out v2.
> 
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Thanks,
> > Conor.
> 
> 

