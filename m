Return-Path: <netdev+bounces-110007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED592AAC0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554D21F2208B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6C40849;
	Mon,  8 Jul 2024 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AWIAbczp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BD1E522;
	Mon,  8 Jul 2024 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471702; cv=none; b=OXaIeKUGeGQCm1I+dMHu1sMxcrDJM4J7ZGxQbqkX4WgHGCxwvdK5byM4whzE8465PDYWnLwh/bhaLxFhKU4pebaSGF2XSr3quUfYXZlY24F6RuULWt3Dy847m631L9dx3EA1ykbU1vMBLsIm3nH4zQAgecAHxHhav2OgSzL8+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471702; c=relaxed/simple;
	bh=2GkQsCCPDTrqvfuEafdWglVgLfi+67h0EEETS2zDisg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgWP4AmNR5pGFF3lXlbtrR1xd72RLX7r83TD4hN4DfIYQJeeOdCZeHD53pqvqladZDqbZWARJCdYLPSfIbCqT96hA1fn7iHb+xyzmQAocEKENw8kvlPmDoAVywOilamxhmplWqRNw0H0L03MM50Mzx8jJABCkAA2mK/qVdymUwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AWIAbczp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3hgADx49+dWBMpzr3NECvdFeri8qwK2tYtwt9hplSU8=; b=AWIAbczpxE+iyVV3FSvTJjZ1/l
	GVDr99Ml4qiOU427sMzeMZFUQZZ3uAWm2ezGR1UPDoQDsEI8PmFbirOXlXNmjcAigHOB4fNX/d6wc
	6ljXeP6arOFKM4Ql88fs7kclsO6djZxkzQUSazJlWYixCVrUnRCrJ5StazYd7HxpueOM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sQvHJ-0024dh-Cj; Mon, 08 Jul 2024 22:48:05 +0200
Date: Mon, 8 Jul 2024 22:48:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	nbd@nbd.name, lorenzo.bianconi83@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor@kernel.org, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, arnd@arndb.de, horms@kernel.org
Subject: Re: [PATCH v5 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller
Message-ID: <8f8a1ee1-8c6c-48d6-a794-286464c38712@lunn.ch>
References: <cover.1720079772.git.lorenzo@kernel.org>
 <48dde2595c6ff497a846183b117ac9704537b78c.1720079772.git.lorenzo@kernel.org>
 <20240708163708.GA3371750-robh@kernel.org>
 <Zowb18jXTOw5L2aT@lore-desk>
 <CAL_JsqJPe1=K7VimSWz+AH2h4fu_2WEud_rUw1dV=SE7pY3C6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJPe1=K7VimSWz+AH2h4fu_2WEud_rUw1dV=SE7pY3C6w@mail.gmail.com>

> > eth0: ethernet@1fb50000 {
> >         compatible = "airoha,en7581-eth";
> >         reg = <0 0x1fb50000 0 0x2600>,
> >               <0 0x1fb54000 0 0x2000>,
> >               <0 0x1fb56000 0 0x2000>;
> >         reg-names = "fe", "qdma0", "qdma1";
> >
> >         resets = <&scuclk EN7581_FE_RST>,
> >                  <&scuclk EN7581_FE_PDMA_RST>,
> >                  <&scuclk EN7581_FE_QDMA_RST>,
> >                  <&scuclk EN7581_XSI_MAC_RST>,
> >                  <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
> >                  <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
> >                  <&scuclk EN7581_HSI_MAC_RST>,
> >                  <&scuclk EN7581_XFP_MAC_RST>;
> >         reset-names = "fe", "pdma", "qdma", "xsi-mac",
> >                       "hsi0-mac", "hsi1-mac", "hsi-mac",
> >                       "xfp-mac";
> >
> >         interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> >
> >         status = "disabled";
> >
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >
> >         gdm1: mac@1 {
> >                 compatible = "airoha,eth-mac";
> >                 reg = <1>;
> >                 phy-mode = "internal";
> >                 status = "disabled";
> >
> >                 fixed-link {
> >                         speed = <1000>;
> >                         full-duplex;
> >                         pause;
> >                 };
> >         };
> > };
> >
> > I am using phy related binding for gdm1:mac@1 node.

Hi Lorenzo

phy-mode is a MAC property, not a PHY property. Same for
fixed-link. These are in ethernet-controller.yaml.

You sometimes have an network controller IP which has multiple MACs
and some shared infrastructure. You would typically describe the
shared infrastructure at the top level. The MACs are then listed as
children, and they make use of ethernet-controller.yaml, and that is
where all the network specific properties are placed. Is that what you
are trying to do here?

    Andrew

