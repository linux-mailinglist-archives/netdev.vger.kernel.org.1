Return-Path: <netdev+bounces-234990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3A9C2ABFA
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 10:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 258064E9C7F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0735B2EAB82;
	Mon,  3 Nov 2025 09:31:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509492900A8;
	Mon,  3 Nov 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162312; cv=none; b=VS+keelEyvl5zqUo2h38byjccH2BHqxkju3v3ggT54C0WF5EjsBfOzEl3SCFXB95BKbk1ifdgfZMMF2WYa/N590G2jFxyRgWF8SCQEa9RZXGxZvR9KVPLjKeE8LzCNhHN3c10zLCSYUkMuIEoBLhNh1wcBVJXhzNPIrcyxBhCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162312; c=relaxed/simple;
	bh=0piNTjqMqLSPlnZT3sc9MLP3lPKcz0P1+szvFPCquaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIP3tr+BUN/dqfxrqlxQKEWy8z2SYwySVoXUQFawxnivbd8VFw3bEbY5GD2/ztyVwogUIFYWUKT9dG3QUqPObGqPOVtg31/7RGx54mkMxfkRYXdSaZJnzd3aAMej1TPlvL/fO3xZygmJcMMXvpd9i9gn6Y9Ts0GeMeSQ904appE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E617B1A1C9E;
	Mon,  3 Nov 2025 10:22:36 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D946C1A1C6E;
	Mon,  3 Nov 2025 10:22:36 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A68D62025C;
	Mon,  3 Nov 2025 10:22:36 +0100 (CET)
Date: Mon, 3 Nov 2025 10:22:36 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Enric Balletbo i Serra <eballetb@redhat.com>
Subject: Re: [PATCH v2] arm64: dts: freescale: Add GMAC Ethernet for S32G2
 EVB and RDB2 and S32G3 RDB3
Message-ID: <aQh0XFu+crFwmVeB@lsv051416.swis.nl-cdc01.nxp.com>
References: <20251031-nxp-s32g-boards-v2-1-6e214f247f4e@oss.nxp.com>
 <aQTlPgDLRwOhzD/V@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQTlPgDLRwOhzD/V@lizhi-Precision-Tower-5810>
X-Virus-Scanned: ClamAV using ClamSMTP

On Fri, Oct 31, 2025 at 12:35:10PM -0400, Frank Li wrote:
> On Fri, Oct 31, 2025 at 03:06:17PM +0100, Jan Petrous via B4 Relay wrote:
> > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> >
> > Add support for the Ethernet connection over GMAC controller connected to
> > the Micrel KSZ9031 Ethernet RGMII PHY located on the boards.
> >
> > The mentioned GMAC controller is one of two network controllers
> > embedded on the NXP Automotive SoCs S32G2 and S32G3.
> >
> > The supported boards:
> >  * EVB:  S32G-VNP-EVB with S32G2 SoC
> >  * RDB2: S32G-VNP-RDB2
> >  * RDB3: S32G-VNP-RDB3
> >
> > Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
> > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > ---
> > Changes in v2:
> >  - fixed correct instance orders, include blank lines
> >  - Link to v1: https://lore.kernel.org/r/20251006-nxp-s32g-boards-v1-1-f70a57b8087f@oss.nxp.com
> > ---
> ...
> > +
> > +			gmac0mdio: mdio {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "snps,dwmac-mdio";
> 
> compatible should be first property,  Move address(size)-cells after it.
> 

Moved compatible up.

> 
> > +			};
> > +		};
> > +
> >  		gic: interrupt-controller@50800000 {
> >  			compatible = "arm,gic-v3";
> >  			reg = <0x50800000 0x10000>,
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > index c4a195dd67bf..fb4002a2aa67 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> ...
> > +
> > +&gmac0mdio {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> 
> needn't it here because your dtsi already set it.
> 

Removed.

> Frank
>

Sent v3.
Thanks for review.
/Jan



