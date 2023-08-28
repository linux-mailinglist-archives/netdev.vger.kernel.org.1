Return-Path: <netdev+bounces-31081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902D378B470
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3E81C20945
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4019B134B5;
	Mon, 28 Aug 2023 15:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F205846AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 15:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279ABC433C8;
	Mon, 28 Aug 2023 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693236572;
	bh=dhT/NBwMHiuduDbdnzNZlW5Q3qXsPNbsQZIelzXVMWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BG530VfhxgnihhbytfskWoXrhTi2MQzMTmq/d57QU13tr3eamljeLiF0YoBH2zq5C
	 aavWkg2o44ar0++FFqxCNWh5aR8e5YVvLSVK20N7XPlmTy8BgbIfy3hIzXIPpdRNlB
	 GDUCvCu/oWcbxhPTk0YYt76vjBc1iVEzsmYkX3kofUqpeLxkGv1WIhmXhJiAmwtiv2
	 2NRF17TC5rq85vyA9jAV+vdbxJz27qbwWMppsaG+UlPrGKtjeUVarjcBXxtjm0q2Gg
	 RiUzuLN36ijcYdO5w4j1/mF0Mgc5yVZCAPptIt3nsf5a4gh40MZCt3eP/tMetteKTC
	 TfG38aU1upUvA==
Date: Mon, 28 Aug 2023 23:17:36 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, Maxime@web.codeaurora.org,
	Coquelin@web.codeaurora.org,
	Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/3] dt-bindings: net: add T-HEAD dwmac
 support
Message-ID: <ZOy6kLGZ1lR0I2sC@xhacker>
References: <20230827091710.1483-1-jszhang@kernel.org>
 <20230827091710.1483-3-jszhang@kernel.org>
 <qc2nyqmuouig6qww2q7orlwzvcprjyruyeuyr5dqdpxysajjpv@6fzsgjgokry7>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qc2nyqmuouig6qww2q7orlwzvcprjyruyeuyr5dqdpxysajjpv@6fzsgjgokry7>

On Mon, Aug 28, 2023 at 04:13:00PM +0300, Serge Semin wrote:
> On Sun, Aug 27, 2023 at 05:17:09PM +0800, Jisheng Zhang wrote:
> > Add documentation to describe T-HEAD dwmac.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
> >  .../devicetree/bindings/net/thead,dwmac.yaml  | 77 +++++++++++++++++++
> >  2 files changed, 78 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index b196c5de2061..73821f86a609 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -96,6 +96,7 @@ properties:
> >          - snps,dwxgmac
> >          - snps,dwxgmac-2.10
> >          - starfive,jh7110-dwmac
> > +        - thead,th1520-dwmac
> >  
> >    reg:
> >      minItems: 1
> > diff --git a/Documentation/devicetree/bindings/net/thead,dwmac.yaml b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
> > new file mode 100644
> > index 000000000000..bf8ec8ca2753
> > --- /dev/null
> 
> > +++ b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
> 
> see further regarding using dwmac in the names here.
> 
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> 
> > +title: T-HEAD DWMAC Ethernet controller
> 
> Additionally would be nice to have a brief controller "description:"
> having the next info: the SoCs the controllers can be found on, the DW
> (G)MAC IP-core version the ethernet controller is based on and some
> data about the synthesize parameters: SMA (MDIO-bus), Tx/Rx COE, DMA
> FIFOs size, perfect and hash MAC-filters size, L3L4 frame filters
> availability, VLAN hash filter, SA/VLAN-tag insertion, ARP offload
> engine, PHY interfaces (MII, RMII, RGMII, etc), EEE support, IEEE
> 1588(-2008) Timestamping support, PMT and Wake-up frame support, MAC
> Management counters (MMC). In addition to that for DW QoS
> ETH/XGMAC/XLGMAC the next info would be useful: number of MTL Queues
> and DMA channels, MTL queues capabilities (QoS-related), TSO
> availability, SPO availability.
> 
> Note DMA FIFO sizes can be also constrained in the properties
> "rx-fifo-depth" and "tx-fifo-depth"; perfect and hash MAC-filter sizes -
> in "snps,perfect-filter-entries" and "snps,multicast-filter-bins".

Hi Serge,

Thank you for your code review. I have different views here: If we
only support the gmac controller in one specific SoC, these detailed
information is nice to have, but what about if the driver/dt-binding
supports the gmac controller in different SoCs? These detailed
information will be outdated.

what's more, I think the purpose of dt-binding is different from
the one of documentation.

So I prefer to put these GMAC IP related detailed information into
the SoC's dtsi commit msg rather than polluting the dt-binding.
> 
> > +
> > +maintainers:
> > +  - Jisheng Zhang <jszhang@kernel.org>
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> 
> > +          - thead,th1520-dwmac
> 
> Referring to the DW IP-core in the compatible string isn't very
> much useful especially seeing you have a generic fallback compatible.
> Name like "thead,th1520-gmac" looks more informative indicating its
> speed capability.

This is just to follow the common style as those dwmac-* does.
I'm not sure which is better, but personally, I'd like to keep current
common style.

