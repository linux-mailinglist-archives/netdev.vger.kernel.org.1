Return-Path: <netdev+bounces-183828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7568FA9227A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47593A1031
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBFC253944;
	Thu, 17 Apr 2025 16:16:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981C22371B;
	Thu, 17 Apr 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906618; cv=none; b=svbW/QcVDPrZemd3kZEETtY1t4RmjJrmoB0dCSZY3jwGmSQHH/mStYNX1gUJP2T0trxZ3AbKzQhkL6snpB/ILLVH50CaZz4a656HznyOq9sBN2dZyeOM7SzPkcFKVkJUWYvux+E1fTHVoa94e6v1HyiYlkNdeoJsk7GUfk1Lwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906618; c=relaxed/simple;
	bh=FgUEG+umn1PfV0jboJ5wL1UISyXSNMwvwys2ha0CKWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP3vqFrA7vpS/sYzgq+eizUKWZv8a0W7GnY0PBV6fV4VJA8FDN2Q+Au7jQfoQ4ipgflm07UUwlzkwRy0Kymv3Y0PlWcRzS9TMx7xh4xmCz7SD56U+Qm9pemuSw3dKVv5ThHzmu6pEoygMfBKcebQbm/j58nf6qoOt5NiMje5+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u5RsR-000000002Q4-0DCF;
	Thu, 17 Apr 2025 16:16:49 +0000
Date: Thu, 17 Apr 2025 17:16:45 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 4/5] net: ethernet: mtk_eth_soc: net: revise
 NETSYSv3 hardware configuration
Message-ID: <aAEpbV-IvbfaPwwL@makrotopia.org>
References: <8ab7381447e6cdcb317d5b5a6ddd90a1734efcb0.1744764277.git.daniel@makrotopia.org>
 <28929b5bb2bfd45e040a07c0efefb29e57a77513.1744764277.git.daniel@makrotopia.org>
 <20250417081055.1bda2ff6@kernel.org>
 <aAEiCjdJdsqH6EAU@makrotopia.org>
 <20250417085948.35b0ec5a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417085948.35b0ec5a@kernel.org>

On Thu, Apr 17, 2025 at 08:59:48AM -0700, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 16:45:14 +0100 Daniel Golle wrote:
> > On Thu, Apr 17, 2025 at 08:10:55AM -0700, Jakub Kicinski wrote:
> > > On Wed, 16 Apr 2025 01:51:42 +0100 Daniel Golle wrote:  
> > > > +		/* PSE should not drop port8, port9 and port13 packets from WDMA Tx */
> > > > +		mtk_w32(eth, 0x00002300, PSE_DROP_CFG);
> > > > +
> > > > +		/* PSE should drop packets to port8, port9 and port13 on WDMA Rx ring full */  
> > > 
> > > nit: please try to wrap at 80 chars. There's really no need to go over
> > > on comments. Some of us stick to 80 char terminals.   
> > 
> > Too late now to send another revision...
> 
> I only applied the first 3 :)

Perfect, so I'll roll up the remaining two with the changes suggested.

> 
> > > > [...]
> > > > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> > > > index 39709649ea8d1..eaa96c8483b70 100644
> > > > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> > > > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> > > > @@ -151,7 +151,12 @@
> > > >  #define PSE_FQFC_CFG1		0x100
> > > >  #define PSE_FQFC_CFG2		0x104
> > > >  #define PSE_DROP_CFG		0x108
> > > > -#define PSE_PPE0_DROP		0x110
> > > > +#define PSE_PPE_DROP(x)		(0x110 + ((x) * 0x4))
> > > > +
> > > > +/* PSE Last FreeQ Page Request Control */
> > > > +#define PSE_DUMY_REQ		0x10C  
> > > 
> > > This really looks like misspelling of DUMMY, is it really supposed 
> > > to have one 'M' ?  
> > 
> > I also thought that when I first saw that and have told MediaTek engineers
> > about it, they told me that the register is called like that also in their
> > datasheet and hence they want the name to be consistent in the driver.
> 
> Hm, maybe add a comment ? It confused both of us, probably going 
> to confuse most people later on

Ok, will do and send v3.

Thank you!

