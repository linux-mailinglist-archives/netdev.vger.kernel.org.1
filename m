Return-Path: <netdev+bounces-49895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D675E7F3C7B
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5961C20823
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 03:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211FA8BE6;
	Wed, 22 Nov 2023 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2U6oUFpf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38DFD1
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 19:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=E1IYrOk2/0lcmIdJNinsgjAdw9J4MaPGjPYOhConAww=; b=2U
	6oUFpfkITjG1Y8KyWRfgRHkN6tZS/BQat8YcXd6sVIo6rI7UiLUNRwd3iXfNinbC43cIMBrosqXzV
	aWyJ8RSG8X+KV/22CDEb820I8+RBSPe9xivLPX8sFHrh4GHNL/t9iEV7G/OR9MvAVJjBkMpc7B5Gm
	4I8o38tnV1ANzcM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5e5A-000orX-IC; Wed, 22 Nov 2023 04:39:20 +0100
Date: Wed, 22 Nov 2023 04:39:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 3/9] net: stmmac: Add Loongson DWGMAC definitions
Message-ID: <9c2806c7-daaa-4a2d-b69b-245d202d9870@lunn.ch>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>
 <2e1197f9-22f6-4189-8c16-f9bff897d567@lunn.ch>
 <df17d5e9-2c61-47e3-ba04-64b7110a7ba6@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df17d5e9-2c61-47e3-ba04-64b7110a7ba6@loongson.cn>

On Tue, Nov 21, 2023 at 05:55:24PM +0800, Yanteng Si wrote:
> Hi Andrew,
> 
> 在 2023/11/12 04:07, Andrew Lunn 写道:
> > > +#ifdef	CONFIG_DWMAC_LOONGSON
> > > +#define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE_LOONGSON | DMA_INTR_ENA_AIE | \
> > > +				DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE)
> > > +#else
> > >   #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
> > >   				DMA_INTR_ENA_UNE)
> > > +#endif
> > The aim is to produce one kernel which runs on all possible
> > variants. So we don't like to see this sort of #ifdef. Please try to
> > remove them.
> 
> We now run into a tricky problem: we only have a few register
> definitions(DMA_XXX_LOONGSON)
> 
> that are not the same as the dwmac1000 register definition.

What does DMA_INTR_ENA_AIE_LOONGSON do? This seems like an interrupt
mask, and this is enabling an interrupt source? However, i don't see
this bit being tested in any interrupt status register? Or is it
hiding in one of the other patches?

This is where lots of small patches, with good descriptions helps.

     Andrew

