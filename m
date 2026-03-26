Return-Path: <netdev+bounces-272129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ5FAl1YxWkk9gQAu9opvQ
	(envelope-from <netdev+bounces-272129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:01:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3FE33807C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97CFE300B180
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC05F3C944F;
	Thu, 26 Mar 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="joWP8ZbJ"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB83EC2CF
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540406; cv=none; b=Ra4H+3NGhO725H5yF8oG3WB68xZSnx/Hh1jtssBOHp/0bHVk8NMDsXqdeNsJRkH1M7mTNNePKvITcn2IEq0IQymWUhOwn/NcT/sxGSYNkXID+s7PZ3AaBFkKvYThIV3w6y5NKbrw4b8E9mRe8TX0XWL94C8qhlVNyuQlGnbzJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540406; c=relaxed/simple;
	bh=jWCzCO8aMHEZUZ7DQtZDmmJccLhh6PSRxwep9L4gXII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn2aI669SDo9QnN0yg17GRzJR+f3jhhUbgXwVbA7rW+S0819oB2Yr6OiKRE9F6ahWaeg5tnvcjNefV2Kwh7tHYKGGb7I2DGVXj2pQE7bEsPHjhhYWMCR26QJ35Pt8Yz6DwdK+1lDkMT4NFRqpT2toPoKJxGk4yg6YWqHF8R9Viw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=joWP8ZbJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 312F39A9;
	Thu, 26 Mar 2026 16:52:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1774540323;
	bh=jWCzCO8aMHEZUZ7DQtZDmmJccLhh6PSRxwep9L4gXII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joWP8ZbJ4pAXm4DFioLVh0FvhCYCPI2Jv1TfsVBxaf1l2Z7EREDeQUXU3WOu87FSy
	 aQW9zeIZcL2jeCdbhgOk5CT/RA1qzlqrJbeWcPitiNxIHwOlZ5rJYp63cHL83p0Qds
	 pazg0Vl/Jic2PmKa5/02oasm+6KHQh/MY/7KceCQ=
Date: Thu, 26 Mar 2026 17:53:20 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: netdev@vger.kernel.org, imx@lists.linux.dev
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
	Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: provide flag to disable EEE
Message-ID: <20260326155320.GA2929106@killaraus.ideasonboard.com>
References: <20260325210003.2752013-1-laurent.pinchart@ideasonboard.com>
 <20260325210003.2752013-2-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325210003.2752013-2-laurent.pinchart@ideasonboard.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272129-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,gmail.com,toradex.com,nxp.com,kernel.org,ideasonboard.com,pengutronix.de,redhat.com,armlinux.org.uk,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email,armlinux.org.uk:email,ideasonboard.com:dkim,ideasonboard.com:email]
X-Rspamd-Queue-Id: DF3FE33807C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 11:00:02PM +0200, Laurent Pinchart wrote:
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> Some platforms have problems when EEE is enabled, and thus need a way
> to disable stmmac EEE support. Add a flag before the other LPI related
> flags which tells stmmac to avoid populating the phylink LPI
> capabilities, which causes phylink to call phy_disable_eee() for any
> PHY that is attached to the affected phylink instance.
> 
> iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
> along with the main dwmac interrupts. Since lpi_intr_o is synchronous
> to the receive clock domain, and takes four clock cycles to clear, this
> leads to interrupt storms as the interrupt remains asserted for some
> time after the LPI control and status register is read.
> 
> This problem becomes worse when the receive clock from the PHY stops
> when the receive path enters LPI state - which means that lpi_intr_o
> can not deassert until the clock restarts. Since the LPI state of the
> receive path depends on the link partner, this is out of our control.
> We could disable RX clock stop at the PHY, but that doesn't get around
> the slow-to-deassert lpi_intr_o mentioned in the above paragraph.
> 
> Previously, iMX8MP worked around this by disabling gigabit EEE, but
> this is insufficient - the problem is also visible at 100M speeds,
> where the receive clock is slower.
> 
> There is extensive discussion and investigation in the thread linked
> below, the result of which is summarised in this commit message.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Closes: https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart@ideasonboard.com
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Tested-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

And I just realized I haven't sent an R-b tag, despite having reviewed
the patch.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  7 ++++++-
>  include/linux/stmmac.h                            | 13 +++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9b6b49331639..ce51b9c22129 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1438,7 +1438,12 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
>  				 config->supported_interfaces,
>  				 pcs->supported_interfaces);
>  
> -	if (priv->dma_cap.eee) {
> +	/* Some platforms, e.g. iMX8MP, wire lpi_intr_o to the same interrupt
> +	 * used for stmmac's main interrupts, which leads to interrupt storms.
> +	 * STMMAC_FLAG_EEE_DISABLE allows EEE to be disabled on such platforms.
> +	 */
> +	if (priv->dma_cap.eee &&
> +	    !(priv->plat->flags & STMMAC_FLAG_EEE_DISABLE)) {
>  		/* The GMAC 3.74a databook states that EEE is only supported
>  		 * in MII, GMII, and RGMII interfaces.
>  		 */
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 5b2bece81448..e62d21afd56d 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -207,12 +207,13 @@ enum dwmac_core_type {
>  #define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
>  #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
>  #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
> -#define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
> -#define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
> -#define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP	BIT(12)
> -#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(13)
> -#define STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD	BIT(14)
> -#define STMMAC_FLAG_SERDES_SUPPORTS_2500M	BIT(15)
> +#define STMMAC_FLAG_EEE_DISABLE			BIT(10)
> +#define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(11)
> +#define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(12)
> +#define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP	BIT(13)
> +#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(14)
> +#define STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD	BIT(15)
> +#define STMMAC_FLAG_SERDES_SUPPORTS_2500M	BIT(16)
>  
>  struct mac_device_info;
>  

-- 
Regards,

Laurent Pinchart

