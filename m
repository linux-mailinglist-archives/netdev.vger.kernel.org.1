Return-Path: <netdev+bounces-98291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 326A58D08B7
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 18:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC76C1F22601
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 16:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA161FF8;
	Mon, 27 May 2024 16:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E861FE1;
	Mon, 27 May 2024 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827681; cv=none; b=RnH2PesfDUpGQuaTfl/c/WCgWnOmoYnZ+PSJu3cLRDn4rwuasOmo/uLf555+A2fmFVzm7xZyeUK7mq/aaGImtWNA/cTYsfAZMhtZ9Hc6AtQX/Xd5v5Vi67Eg+9vlCbKCthvlNZmObjMdvtbIUjVoH131NdkPCnSCT0FqtcLgrz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827681; c=relaxed/simple;
	bh=YnPCfmPlSjFb9s0kuzVRNjS5wB0T6GQWiLt+H7w4WXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq8nqOJb8hL7ffbkeuhfUrEmKxuJ976E13DxmU5Z0ALJ7penz2ZC//rB4bRE1fy3UYwY5jt6kTdZp2ihzI7bU2S2b//fD+/w2rZGqiQO6h8Iw79u60SaE0JOMEqrW643hPLrcvjKuKGEYOphGTqv2rfqaoqRuDTXD2JMShSx44M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sBcyu-000000007MD-3VgY;
	Mon, 27 May 2024 16:13:52 +0000
Date: Mon, 27 May 2024 17:13:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: Sam Shih <Sam.Shih@mediatek.com>, 
	SkyLake Huang <SkyLake.Huang@mediatek.com>, Steven Liu <steven.liu@mediatek.com>, 
	Frank Wunderlich <linux@fw-web.de>, Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank Wunderlich <frank-w@public-files.de>, 
	John Crispin <john@phrozen.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Message-ID: <kbzsne4rm4232w44ph3a3hbpgr3th4xvnxazdq3fblnbamrloo@uvs3jyftecma>
References: <20240527142142.126796-1-linux@fw-web.de>
 <BY3PR18MB4737D0ED774B14833353D202C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB4737D0ED774B14833353D202C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>

On Mon, May 27, 2024 at 03:55:55PM GMT, Sunil Kovvuri Goutham wrote:
> 
> 
> > -----Original Message-----
> > From: Frank Wunderlich <linux@fw-web.de>
> > Sent: Monday, May 27, 2024 7:52 PM
> > To: Felix Fietkau <nbd@nbd.name>; Sean Wang <sean.wang@mediatek.com>;
> > Mark Lee <Mark-MC.Lee@mediatek.com>; Lorenzo Bianconi
> > <lorenzo@kernel.org>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Matthias Brugger <matthias.bgg@gmail.com>;
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Cc: Frank Wunderlich <frank-w@public-files.de>; John Crispin
> > <john@phrozen.org>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-mediatek@lists.infradead.org;
> > Daniel Golle <daniel@makrotopia.org>
> > Subject: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc specific
> > 
> > From: Frank Wunderlich <frank-w@public-files.de>
> > 
> > The mainline MTK ethernet driver suffers long time from rarly but annoying tx
> > queue timeouts. We think that this is caused by fixed dma sizes hardcoded for
> > all SoCs.
> > 
> > Use the dma-size implementation from SDK in a per SoC manner.
> > 
> > Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623
> > ethernet")
> > Suggested-by: Daniel Golle <daniel@makrotopia.org>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> ..............
> > 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > index cae46290a7ae..f1ff1be73926 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> 
> .............
> > @@ -1142,40 +1142,46 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
> >  						       cnt * soc->tx.desc_size,
> >  						       &eth->phy_scratch_ring,
> >  						       GFP_KERNEL);
> 
> ..............
> > -	for (i = 0; i < cnt; i++) {
> > -		dma_addr_t addr = dma_addr + i * MTK_QDMA_PAGE_SIZE;
> > -		struct mtk_tx_dma_v2 *txd;
> > +		dma_addr = dma_map_single(eth->dma_dev,
> > +					  eth->scratch_head[j], len *
> > MTK_QDMA_PAGE_SIZE,
> > +					  DMA_FROM_DEVICE);
> > 
> 
> As per commit msg, the fix is for transmit queue timeouts.
> But the DMA buffer changes seems for receive pkts.
> Can you please elaborate the connection here.

*I guess* the memory window used for both, TX and RX DMA descriptors
needs to be wisely split to not risk TX queue overruns, depending on the
SoC speed and without hurting RX performance...

Maybe someone inside MediaTek (I've added to Cc now) and more familiar
with the design can elaborate in more detail.

