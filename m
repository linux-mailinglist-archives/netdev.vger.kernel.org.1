Return-Path: <netdev+bounces-138141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B26E9AC21E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E38D1C26D3E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CBE15B0EC;
	Wed, 23 Oct 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCa7dn6p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7DA15886D;
	Wed, 23 Oct 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673355; cv=none; b=jCMG0QuXyXflRPRAiOUoP5Zt/jDWhE0tkmMi8l9pQshC75QRCpRAa5tC6Y6dQnSf6Flvvfp3qhvXRRIA65rhlz6TOxx2mnrMJ9pieQyMU+BxfKAqmWwLs24Qq3BdoHO2FyPlCXvpcfPuK+XTuX3KZ4rYrWMw+htA3c/WllJuhIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673355; c=relaxed/simple;
	bh=7NhjULpJR19EvTFu6kukQjms/KFY1lUVI61YeGXteK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQqB4kH020Bodtlbwdt5AlzX+9bRhPETERWQnYMv/WrhkUOlRQjKXASUEHd2Ns5urTu5/ESsRySYz4DnQYVRZ1E8c3AIL8eQw6B8y9N9hUjvyWDuDGrjbbJ9EilsdYH5FGWTB8WlJ4yO/u9qt+x9/I96RYDb44MtbYRqAgAaE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCa7dn6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC8DC4CEC6;
	Wed, 23 Oct 2024 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729673355;
	bh=7NhjULpJR19EvTFu6kukQjms/KFY1lUVI61YeGXteK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCa7dn6prblg2R6KnQjb+AXq101pO4zTQ6kdNO0cGMRoSxe4p8mcSY11kut/o4ARa
	 VIb3+v0Ulxo4NjOxCI69dz3NnHfyMuLr5lUiqauOKBRGtmpjo85QQfoOkC/cvvbOq/
	 nNafENibQaC0pa/HBqLQku9SGDNagfPnOFHMa28Dm+8nzXTSZQEwRZTdCnHMd7sfLx
	 Vn04n7/iJ0IeP/lcMgNlGbsEUsvemJANyJVFPQrp5+D8yNtayXxm9X7ilTIqRotpLs
	 bB1EuQxYmNO/KtQ9wtLYYD/uAmHQD5WePX+P/GW2Ogbm1QTbREYOVHB+XoPZWvhBWH
	 oLU+MCJztxvCQ==
Date: Wed, 23 Oct 2024 09:49:10 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: 2694439648@qq.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	hailong.fan@siengine.com
Subject: Re: [PATCH v1] net: stmmac: enable MAC after MTL configuring
Message-ID: <20241023084910.GL402847@kernel.org>
References: <tencent_CCC29C4F562F2DEFE48289DB52F4D91BDE05@qq.com>
 <20241021130554.00005cf5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021130554.00005cf5@gmail.com>

On Mon, Oct 21, 2024 at 01:05:54PM +0800, Furong Xu wrote:
> On Mon, 21 Oct 2024 09:03:05 +0800, 2694439648@qq.com wrote:
> 
> > From: "hailong.fan" <hailong.fan@siengine.com>
> > 
> > DMA maybe block while ETH is opening,
> > Adjust the enable sequence, put the MAC enable last
> > 
> > For example, ETH is directly connected to the switch,
> > which never power down and sends broadcast packets at regular intervals.
> > During the process of opening ETH, data may flow into the MTL FIFO,
> > once MAC RX is enabled. and then, MTL will be set, such as FIFO size.
> > Once enable DMA, There is a certain probability that DMA will read
> > incorrect data from MTL FIFO, causing DMA to hang up.
> > By read DMA_Debug_Status, you can be observed that the RPS remains at
> > a certain value forever. The correct process should be to configure
> > MAC/MTL/DMA before enabling DMA/MAC
> > 
> > Signed-off-by: hailong.fan <hailong.fan@siengine.com>
> > 
> 
> A Fixes: tag should be added.

Also, as this patch is a fix for net, that target should be noted in the
subject.

  Subject: [PATCH v2 net] ...

Please address this and the issues raised by Furong Xu and post a v3.

> >  static void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index e21404822..c19ca62a4 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3437,9 +3437,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
> >  		priv->hw->rx_csum = 0;
> >  	}
> >  
> > -	/* Enable the MAC Rx/Tx */
> > -	stmmac_mac_set(priv, priv->ioaddr, true);
> > -
> >  	/* Set the HW DMA mode and the COE */
> >  	stmmac_dma_operation_mode(priv);
> >  
> > @@ -3523,6 +3520,9 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
> >  	/* Start the ball rolling... */
> >  	stmmac_start_all_dma(priv);
> >  
> > +	/* Enable the MAC Rx/Tx */
> > +	stmmac_mac_set(priv, priv->ioaddr, true);
> > +
> 
> This sequence fix should be applied to stmmac_xdp_open() too.
> 
> >  	stmmac_set_hw_vlan_mode(priv, priv->hw);
> >  
> >  	return 0;
> 
> It is better to split this patch into individual patches, since you are
> trying to fix an issue related to several previous commits:
> dwmac4, dwxgmac2, stmmac_hw_setup() and stmmac_xdp_open()

And each patch should have an appropriate Fixes tag.

-- 
pw-bot: changes-requested

