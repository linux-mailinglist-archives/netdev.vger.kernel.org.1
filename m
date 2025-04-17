Return-Path: <netdev+bounces-183820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DD0A92220
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A733B254B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE22253F28;
	Thu, 17 Apr 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKKDzDFa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224031B6D08;
	Thu, 17 Apr 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905591; cv=none; b=ONvkZRsLvZe1mAnxqpjwAos2z15/dEdngoiAm4k/FStsztKabf9xRt2+jiNvPdxUqOVwelaP9PnnEqA61T1RTzvQ/O4Eh0edQ5WAwfOxlParcDd+j5rWpCKMIBrnllTYaaxZlcittUCtj4TdhTRV4Kzl6nk2RGhLB92TOPL8j6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905591; c=relaxed/simple;
	bh=hHSlbiPaRGPDFDdALuBGMJLctXSjXushS0Thr9FD/Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKF5Es71np4m3xl6yXTkkhodIhz9bsEqscAA/byOuG3alBvQu7uQRMl3/SkuKWU8Ca8JV86oHfaRy7Cg2shNq6UKFW1fKAETJWXdsK0JwCWE1MZBBPxGW7n5ZqCYso6dzSB9s3aYZyyCa/4s6OVfxAskODZ7b+RVxLOmWDVjbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKKDzDFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DC8C4CEE4;
	Thu, 17 Apr 2025 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744905590;
	bh=hHSlbiPaRGPDFDdALuBGMJLctXSjXushS0Thr9FD/Zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SKKDzDFa8yz//vN87vlFbNealPS3RLJ8/IeYYoE/jxcPJqA9v7cTkd7J6AxzsO/Nv
	 SK3KnF6MDlGl2yM8TXsAF+hB8FfzOIL1ncZnOmTEuoTiYVF/l4Lezbcre9F8MvCsge
	 8CIKfGV1Y3zG7kyfSCfQYFt/tTYAQhSjZ3N+BH4HDcdAybxH6d3i/N1Oqpm3LgizXe
	 94+0ObpQDBGx0z1z34t9XGYj5YTpiguRIS94Xs/EtMwMkC0NqgPXGrn3NcBI/Y1bR9
	 0+0OtUSjhS8HwdDxZ8+Gt9dnfQ+1sv0L9E5aQgqyOStp2KaWMFejEUuLMR9GdV0O+p
	 gP+zNb10VHHSw==
Date: Thu, 17 Apr 2025 08:59:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Florian Fainelli
 <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 4/5] net: ethernet: mtk_eth_soc: net: revise
 NETSYSv3 hardware configuration
Message-ID: <20250417085948.35b0ec5a@kernel.org>
In-Reply-To: <aAEiCjdJdsqH6EAU@makrotopia.org>
References: <8ab7381447e6cdcb317d5b5a6ddd90a1734efcb0.1744764277.git.daniel@makrotopia.org>
	<28929b5bb2bfd45e040a07c0efefb29e57a77513.1744764277.git.daniel@makrotopia.org>
	<20250417081055.1bda2ff6@kernel.org>
	<aAEiCjdJdsqH6EAU@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 16:45:14 +0100 Daniel Golle wrote:
> On Thu, Apr 17, 2025 at 08:10:55AM -0700, Jakub Kicinski wrote:
> > On Wed, 16 Apr 2025 01:51:42 +0100 Daniel Golle wrote:  
> > > +		/* PSE should not drop port8, port9 and port13 packets from WDMA Tx */
> > > +		mtk_w32(eth, 0x00002300, PSE_DROP_CFG);
> > > +
> > > +		/* PSE should drop packets to port8, port9 and port13 on WDMA Rx ring full */  
> > 
> > nit: please try to wrap at 80 chars. There's really no need to go over
> > on comments. Some of us stick to 80 char terminals.   
> 
> Too late now to send another revision...

I only applied the first 3 :)

> > > [...]
> > > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> > > index 39709649ea8d1..eaa96c8483b70 100644
> > > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> > > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> > > @@ -151,7 +151,12 @@
> > >  #define PSE_FQFC_CFG1		0x100
> > >  #define PSE_FQFC_CFG2		0x104
> > >  #define PSE_DROP_CFG		0x108
> > > -#define PSE_PPE0_DROP		0x110
> > > +#define PSE_PPE_DROP(x)		(0x110 + ((x) * 0x4))
> > > +
> > > +/* PSE Last FreeQ Page Request Control */
> > > +#define PSE_DUMY_REQ		0x10C  
> > 
> > This really looks like misspelling of DUMMY, is it really supposed 
> > to have one 'M' ?  
> 
> I also thought that when I first saw that and have told MediaTek engineers
> about it, they told me that the register is called like that also in their
> datasheet and hence they want the name to be consistent in the driver.

Hm, maybe add a comment ? It confused both of us, probably going 
to confuse most people later on

