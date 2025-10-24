Return-Path: <netdev+bounces-232522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7231C0636A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C24124EC018
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92273316199;
	Fri, 24 Oct 2025 12:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261B315D31
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308428; cv=none; b=AnVHET3+piNMTFQS1LCegZlx6sp7XIq2ayQaFDh7aeI1Gmsm0HvSyQtdVVgj3tc4mgDP3U+LaQ1KoK5AP0e9KlRuAMoih+x/SZkj3oOZPQ2agMcMjTsv2R/9OJGYpEbzK/9bhq1rDDAHL/nLBh1JK0wvaJVMNkEEC2KnCJpMHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308428; c=relaxed/simple;
	bh=f4nLSZUbHXPOAJMornZBUvE6cqRt+o4rLfXHVdki47Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UVAPXDidRvXb0E/97ZfPNadpjixhb5gk/ICoOaifKJg3KMsYKXXM6U2V8uIqJvmRLiXVGKqS1bBMvJqpNqXS3NYDtjaCEgBBdiHCUgvt6x6K4zCD7naRJZWpHlHUBzHJGxWd0FrM6CUp/n9e4sKQVc7OPXhCbHwe0xO0YRKIxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vCGmD-0000ek-3D; Fri, 24 Oct 2025 14:20:13 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Maxime Chevallier
 <maxime.chevallier@bootlin.com>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Matthew Gerlach
 <matthew.gerlach@altera.com>,  kernel@pengutronix.de,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 06/10] arm64: dts: socfpga: agilex5: add dwxgmac
 compatible
In-Reply-To: <b486bb52-7e95-44d3-ac65-1c28d4d0e40e@kernel.org> (Dinh Nguyen's
	message of "Fri, 24 Oct 2025 07:00:36 -0500")
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
	<20251024-v6-12-topic-socfpga-agilex5-v5-6-4c4a51159eeb@pengutronix.de>
	<b486bb52-7e95-44d3-ac65-1c28d4d0e40e@kernel.org>
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Fri, 24 Oct 2025 14:20:09 +0200
Message-ID: <87zf9g7apy.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


Hi Dinh,

On 2025-10-24 at 07:00 -05, Dinh Nguyen <dinguyen@kernel.org> wrote:

> Hi Steffen,
> 
> On 10/24/25 06:49, Steffen Trumtrar wrote:
> > The gmac0/1/2 are also compatible to the more generic "snps,dwxgmac"
> > compatible. The platform code checks this to decide if it is a GMAC or
> > GMAC4 compatible IP core.
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> > diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> > b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> > index 4ccfebfd9d322..d0c139f03541e 100644
> > --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> > +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> > @@ -536,7 +536,8 @@ qspi: spi@108d2000 {
> >     		gmac0: ethernet@10810000 {
> >   			compatible = "altr,socfpga-stmmac-agilex5",
> > -				     "snps,dwxgmac-2.10";
> > +				     "snps,dwxgmac-2.10",
> > +				     "snps,dwxgmac";
> >   			reg = <0x10810000 0x3500>;
> >   			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> >   			interrupt-names = "macirq";
> > @@ -649,7 +650,8 @@ queue7 {
> >     		gmac1: ethernet@10820000 {
> >   			compatible = "altr,socfpga-stmmac-agilex5",
> > -				     "snps,dwxgmac-2.10";
> > +				     "snps,dwxgmac-2.10",
> > +				     "snps,dwxgmac";
> >   			reg = <0x10820000 0x3500>;
> >   			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
> >   			interrupt-names = "macirq";
> > @@ -762,7 +764,8 @@ queue7 {
> >     		gmac2: ethernet@10830000 {
> >   			compatible = "altr,socfpga-stmmac-agilex5",
> > -				     "snps,dwxgmac-2.10";
> > +				     "snps,dwxgmac-2.10",
> > +				     "snps,dwxgmac";
> >   			reg = <0x10830000 0x3500>;
> >   			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> >   			interrupt-names = "macirq";
> > 
> 
> I just sent a patch for this yesterday:
> 
> https://lore.kernel.org/all/20251023214012.283600-1-dinguyen@kernel.org/
>

ah, I missed that, than this patch is unneccessary.

> I'll make sure to include you on future submissions.
> 
> I didn't add it to the bindings document though.
>

As I always get complains from dt-check bot, I remembered to add it ;)


Best regards,
Steffen

-- 
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

