Return-Path: <netdev+bounces-149893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9057D9E7F7C
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 11:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758F21883AD1
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC6137750;
	Sat,  7 Dec 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hkOlp2GT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDB126C0D;
	Sat,  7 Dec 2024 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733566413; cv=none; b=jer5JjlqAi4XPItMRwUKuv0mwzd0uA1XtBGdaBBvVvC76O47cMdoLmk1U5BNyuV7lzeCjjVDOQHatGM7sesTrvLojXuFKTgv3PTecsV+lkocEbIDWXIH2RQDeSBvSOLi27GK37t5o6leF1wevfG1ohFZimiJ0nrAbA9UVUaN4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733566413; c=relaxed/simple;
	bh=1iTUbXSWwCLDOdH7t33vQs0Dneg7nd5dct2F7dqwPhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp4Svwg8QxxogD45L2tnNm9w6jm9AAGd4JeT4ENqqgYsOpZ0uR8yFV763FLV5bFfKn+fVGOqHifRtWYxA47ryoBYEImsQrGQc5xU2EgcQPeyyfUphIJD6GVXtCLqi/E2vMaqS7ECwZJcuofuO1uKmo/Obm+3kf0tZ5hNAAKjGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hkOlp2GT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9m4W93mYJLzHPiDSNn2VKBwMS0KHXEKg2K2lKwcgsic=; b=hkOlp2GT+CFyuoN3LOa5axR6b/
	gUBV11fEHXr4WfIdXtN7VbNn+IVNk/YuLNGLLJtOSH06P+rGRFlNFa5ggxm0jwQhVxLa1D1O8uSuv
	nrU+Gvk5NwIDU+9H6XFBjCWxPSiFREzlNzKdPrwwQNsAPBP/VYskW7iZWIY9WcjGNyuCkls8GhliI
	f3eNXluxUoHGtGFZfrelPz99UeEZv3RTLN3lagIHt+eW78ZzhQ9yB8tmMGCwbPgS+b316AQWA7y7d
	DwMmgy1mzRt2Z0R2Bvc2EmecR2bTnBOuMLQ0sw6wsUhyI6zupSUTfV0F7hsmJv+KDt1hf3ceQV57g
	c0xrjZ7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45680)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJroO-0007FL-2B;
	Sat, 07 Dec 2024 10:13:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJroI-0008RP-2w;
	Sat, 07 Dec 2024 10:13:14 +0000
Date: Sat, 7 Dec 2024 10:13:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1] net: stmmac: Move extern declarations from
 common.h to hwif.h
Message-ID: <Z1QfupFfg07jTMUc@shell.armlinux.org.uk>
References: <20241207070248.4049877-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207070248.4049877-1-0x1207@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Dec 07, 2024 at 03:02:48PM +0800, Furong Xu wrote:
> These extern declarations are referenced in hwif.c only.
> Move them to hwif.h just like the other extern declarations.

We normally have declarations in a header file that corresponds to their
definition, rather than where they are used.

> Compile tested only.
> No functional change intended.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h | 14 --------------
>  drivers/net/ethernet/stmicro/stmmac/hwif.h   | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 1367fa5c9b8e..fbcf07d201cf 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -543,18 +543,8 @@ struct dma_features {
>  #define STMMAC_VLAN_INSERT	0x2
>  #define STMMAC_VLAN_REPLACE	0x3
>  
> -extern const struct stmmac_desc_ops enh_desc_ops;

Defined in enh_desc.c, but no header for it, so either common.h or
hwif.h seems sensible.

> -extern const struct stmmac_desc_ops ndesc_ops;

Defined in norm_desc.c, same situation as previous one.

> -
>  struct mac_device_info;
>  
> -extern const struct stmmac_hwtimestamp stmmac_ptp;

Defined in stmmac_hwtstamp.c, same as above.

> -extern const struct stmmac_hwtimestamp dwmac1000_ptp;

Ditto.

> -extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;

Defined in dwmac4_descs.c, maybe dwmac4_descs.h or dwmac4.h would make
more sense than hwif.c ?

> -
> -extern const struct ptp_clock_info stmmac_ptp_clock_ops;

Defined in stmmac_ptp.c, and there is stmmac_ptp.h which contains a
number of function declarations, so maybe moving that there would
make more sense?

> -extern const struct ptp_clock_info dwmac1000_ptp_clock_ops;

Same as stmmac_ptp_clock_ops.

> -
>  struct mac_link {
>  	u32 caps;
>  	u32 speed_mask;
> @@ -641,8 +631,4 @@ void stmmac_dwmac4_set_mac(void __iomem *ioaddr, bool enable);
>  
>  void dwmac_dma_flush_tx_fifo(void __iomem *ioaddr);
>  
> -extern const struct stmmac_mode_ops ring_mode_ops;

Defined in ring_mode.c, same as enh_desc_ops.

> -extern const struct stmmac_mode_ops chain_mode_ops;

Defined in chain_mode.c, same as enh_desc_ops.

> -extern const struct stmmac_desc_ops dwmac4_desc_ops;

Defined in dwmac4_descs.c, similar situation to dwmac4_ring_mode_ops
above.


So I think rather than bulk moving these to hwif.h, where some of them
remain out of place, maybe placing some in a more appropriate header
would be better.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

