Return-Path: <netdev+bounces-160106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4202A182E4
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91ECF169E37
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940C1F5433;
	Tue, 21 Jan 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jLn+HGnF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6EB1F5411;
	Tue, 21 Jan 2025 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480606; cv=none; b=FUvU8bfzBxddemOEafKc9FJEPUt+ZdvISCT4P+50vaiM1AKhRdvR5048A6zZYMIo15l8Rq1+oHHVbTrYa925G00hESPs8SzzKWWGVY+NC7cP5854dEOsY5SuKsD4ltWkFPkfg83acRI2a45oWXuQwlhFFaTSyKnzflkgDmLd5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480606; c=relaxed/simple;
	bh=LTljEXG7HV+F1j0/+qVpxcKSu+3UmSk7Yk+/E0stsSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT8hjRtfbZLDAKTjtxayP2dCziG7HzkBtDj0r6aqQrrJRrVIOWhhkHIHHdwdiHMWQhmmHZ1rnIlj0/Qb5ajiSB3937ghkE00F/QAhyswN4Rbwk8OoGraICFQ/TqcI9sfbk2dxLs07JD1p8GCboCtymiYccXIH3DouisDYhVdOzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jLn+HGnF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6SMmn399DijCiUX3gBxnE2kLGfAWmnOcjzp7FDIMbN8=; b=jLn+HGnFMAjk83/mc/4RxYs8zb
	T728HVItldev866KXmTyPmjhdKDYiKz53jfW6MDTu7K3ooq1gEBbLrb7eKgHZZNd3kkKlabsk6tpG
	EWFGNz/sKFLndPKFTLjLP64aiXG7BGoUE/lX8vUcVfU8PusaRt5GGhBndBZ//68XJaSbDAT/JIaje
	/CJUZD4FsCV6JlGTzcGIFZiVonZPR0hDmU2X49NKOcWvtk7YrBd9K6YKuzfI59XssGUN7EuHIEdGY
	A9tHCfB3DtcbS3mKASK/vNGEMV+skTCQU++Esupmc1FBsCziycMdb5kzN7oiOqAMpwLT8mEmO6wS/
	f5m3YE6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46698)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1taI4U-0007Wc-2x;
	Tue, 21 Jan 2025 17:29:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1taI4Q-00044e-31;
	Tue, 21 Jan 2025 17:29:46 +0000
Date: Tue, 21 Jan 2025 17:29:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Furong Xu <0x1207@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
	Vince Bridgers <vbridger@opensource.altera.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] net: stmmac: Limit FIFO size by hardware
 capability
Message-ID: <Z4_ZilVFKacuAUE8@shell.armlinux.org.uk>
References: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
 <20250121044138.2883912-3-hayashi.kunihiko@socionext.com>
 <07f2f6d0-e025-4b21-ac41-caaf71bb6fff@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07f2f6d0-e025-4b21-ac41-caaf71bb6fff@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 22, 2025 at 01:14:25AM +0800, Yanteng Si wrote:
> 在 1/21/25 12:41, Kunihiko Hayashi 写道:
> > Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
> > stmmac_platform layer.
> > 
> > However, these values are constrained by upper limits determined by the
> > capabilities of each hardware feature. There is a risk that the upper
> > bits will be truncated due to the calculation, so it's appropriate to
> > limit them to the upper limit values and display a warning message.
> > 
> > Fixes: e7877f52fd4a ("stmmac: Read tx-fifo-depth and rx-fifo-depth from the devicetree")
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 251a8c15637f..da3316e3e93b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -7245,6 +7245,19 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
> >   		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
> >   	}
> 
> > +	if (priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
> 
> > +		dev_warn(priv->device,
> > +			 "Rx FIFO size exceeds dma capability (%d)\n",
> > +			 priv->plat->rx_fifo_size);
> > +		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
> I executed grep and found that only dwmac4 and dwxgmac2 have initialized
> dma_cap.rx_fifo_size. Can this code still work properly on hardware other
> than these two?

Looking at drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:

        /* Compute minimum number of packets to make FIFO full */
        pkt_count = priv->plat->rx_fifo_size;
        if (!pkt_count)
                pkt_count = priv->dma_cap.rx_fifo_size;

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:

        int rxfifosz = priv->plat->rx_fifo_size;
        int txfifosz = priv->plat->tx_fifo_size;

        if (rxfifosz == 0)
                rxfifosz = priv->dma_cap.rx_fifo_size;
        if (txfifosz == 0)
                txfifosz = priv->dma_cap.tx_fifo_size;

(in two locations)

It looks to me like the intention is that priv->plat->rx_fifo_size is
supposed to _override_ whatever is in priv->dma_cap.rx_fifo_size.

Now looking at the defintions:

drivers/net/ethernet/stmicro/stmmac/dwmac4.h:#define GMAC_HW_RXFIFOSIZE        GENMASK(4, 0)
drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h:#define XGMAC_HWFEAT_RXFIFOSIZE GENMASK(4, 0)

So there's a 5-bit bitfield that describes the receive FIFO size for
these two MACs. Then we have:

drivers/net/ethernet/stmicro/stmmac/common.h:#define DMA_HW_FEAT_RXFIFOSIZE    0x00080000       /* Rx FIFO > 2048 Bytes */

which is used here:

drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c:    dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;

which is only used to print a Y/N value in a debugfs file, otherwise
having no bearing on driver behaviour.

So, I suspect MACs other than xgmac2 or dwmac4 do not have the ability
to describe the hardware FIFO sizes in hardware, thus why there's the
override and no checking of what the platform provided - and doing so
would break the driver. This is my interpretation from the code alone.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

