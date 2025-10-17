Return-Path: <netdev+bounces-230480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F316CBE89EB
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600F41AA0723
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5914C32ABCD;
	Fri, 17 Oct 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W/2CuL+h"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592432DC328;
	Fri, 17 Oct 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704950; cv=none; b=VxhzRjHI6Ta+zb/va30/ss7ID8GYAfd45nxjzpk/5YBojNlbdcLsdhc+kd+1iMEAb7Eugnxr52UqDUsgAIMeUWL9bsQcgNl4Erx0XpvIfb0mRLYYSsX2D7PfaW0e1mH2SaAu6tIMTXLaKCp985NELEj8YrQliYFL11LBaAtz9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704950; c=relaxed/simple;
	bh=TNbJPunpNwSCjOy6mxPDMjZw0tWIv7D9t4z0kM4Ese8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIaMqGKwyM32x+/U9lUYrSNmd2xqTl2SX9+KRIx1V128feg3YEoNvhyL/oqzF8nZ4i/8ezcWuwBa656rI1y4AxpReXnNVwNG5dHiFVafNvgyX4x7F/Bpk73IIgVl4pGBmdV/HGTxVIgY5yMmFYdXB8YGwuiW7DWziXdF+CiyzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=W/2CuL+h; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IGyYcC+d3YKTIer3CKrB01eeg5KvZEEyEjcSchgym/I=; b=W/2CuL+hGNToi9Z5Ya9VSH3ZG5
	WXVDOEvDRj1FSTKN61nZaKm5ZqpQcULX9Rlh5dVV1ggi4dYw4MJWDeoC777XmSJTFF599UZfuatXs
	M7bv9lYTfOo3uU+7M0R3YywZwdYEixlTiwaN080t7d22vLUv+nIk9uLoeiv0OIPbFnFVFMgdJDNOl
	/3QSlONY2oqkPNc63j4RAvUFifA2YC/Ey0yBO4X5NksD4hgiFDRXO7gnQb7becUfjqtEduVUI8JhG
	rfwNt9ohYZxv/MEpKWS36L2TfV4KLZlYSUsEZzea4G55cBQW5tD+kqSq8F4vHiLXBCEn32jx1OZgd
	U+bUqVqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43812)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v9jmi-000000007sy-3bmI;
	Fri, 17 Oct 2025 13:42:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v9jme-000000004Jn-4AHz;
	Fri, 17 Oct 2025 13:42:13 +0100
Date: Fri, 17 Oct 2025 13:42:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] net: stmmac: vlan: Disable 802.1AD tag
 insertion offload
Message-ID: <aPI5pBXnh5X7OXtG@shell.armlinux.org.uk>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-1-d3a42e32646a@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-qbv-fixes-v3-1-d3a42e32646a@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 17, 2025 at 02:11:19PM +0800, Rohan G Thomas via B4 Relay wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 650d75b73e0b0ecd02d35dd5d6a8742d45188c47..dedaaef3208bfadc105961029f79d0d26c3289d8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4089,18 +4089,11 @@ static int stmmac_release(struct net_device *dev)
>  static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
>  			       struct stmmac_tx_queue *tx_q)
>  {
> -	u16 tag = 0x0, inner_tag = 0x0;
> -	u32 inner_type = 0x0;
> +	u16 tag = 0x0;
>  	struct dma_desc *p;

#include <stdnetdevcodeformat.h> - Please maintain reverse christmas-
tree order.

I haven't yet referred to the databook, so there may be more comments
coming next week.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

