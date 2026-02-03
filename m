Return-Path: <netdev+bounces-256297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDKaA0f8gWk7NQMAu9opvQ
	(envelope-from <netdev+bounces-256297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:46:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DE4DA1C4
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50E2E30B0524
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3553A0B01;
	Tue,  3 Feb 2026 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S3cuj6+I"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23B39E162
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126253; cv=none; b=Y5hSCRyqwOu3fCr+0lqrVNG3OpFwUG+HahKiX4xdlUJYmKt1CO1TYzS3bVD74bpcgW4myiCcRKKSie78W63OGv3pv2XjljEph3HYtd+VOQb+nBuyDqo81PnLpTB+CYHKfFTdfkldKQa2UBGH37m5D8qLyi7G2UJhmetevrbYWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126253; c=relaxed/simple;
	bh=s8APr3WC0hHaLuLysEteTXrWWyCo+vGAm01v02hyxRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaXr1ABEG7CHNy2e/y0DzjFOKzS+wQ/zWoURiNZyitLWIGLlmE8npMXzYpNLzgZNlCEUn5rrOJh6e4CJK8P1p3PWhefTZ5p6Bpa/v2xFKrb4dTQdrVWFAbP7L3WS6HlQ697B0/AhFj53eaeDNSpcQsZfD1o75Z7jBmGYn2LmZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S3cuj6+I; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ACroZsqXMIQuB0o6/1PDTEWKLpRas3S4wshE/11BH74=; b=S3cuj6+IUGGz7JH99vQDmKZDwQ
	hmDuTS6+PmQeG/LKCVhnGJCxVERvugUKayj4rgPHPRv/ngKwo6Yv1zDD7AwmTNcLXiNWmAAh1otL6
	v6Sv7tbXkyt0v9ueQFJUcejs2eqjyTQx0V7/82pumEknpOZ+hzMpa+fSecpl/gqSv9SUzLoKbjrAU
	dk3/4vut5ZAQPOAGzQGDTckonZIt2Qjmp7PO8ROyGgDABf0k4IzfrZEfvPsNROEntktYSg4lrlJcq
	gRG+ROCg2aGf8fClskOvysa2J2EZq7ru2/0d5gZnD3+jMyzPu3+xhvoaV+JGaOxrlC3vyawBfK6ZB
	Zv3GxL9g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46718)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vnGhF-00000000585-2kI0;
	Tue, 03 Feb 2026 13:44:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vnGhC-000000004Qa-0ZFP;
	Tue, 03 Feb 2026 13:43:58 +0000
Date: Tue, 3 Feb 2026 13:43:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 09/10] net: stmmac: rk: remove need for
 ->set_speed() method
Message-ID: <aYH7nTGx474azyk-@shell.armlinux.org.uk>
References: <aYB2cKRu3DQh6yXK@shell.armlinux.org.uk>
 <E1vmqnM-00000007VD8-1xWo@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vmqnM-00000007VD8-1xWo@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256297-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:url,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 77DE4DA1C4
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 10:04:36AM +0000, Russell King (Oracle) wrote:
> As we can detect whether the SoC provides the parameters necessary for
> rk_set_reg_speed(), we don't need to have explicit calls to this.
> Instead, we can move the contents of this function to
> rk_set_clk_tx_rate().
> 
> This remsoves all the .set_speed() implementations that merely go on to
> invoke rk_set_reg_speed().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I notice that the AI review claims there is a problem with this patch,
where rk_set_clk_tx_rate() may return -EINVAL for id=1 on rk3328.

It claims:

  The new code in rk_set_clk_tx_rate() requires either
  gmii_clk_sel_mask for RGMII or rmii_clk_sel_mask/mac_speed_mask
  for RMII. For rk3328 id=1, rk3328_init() sets only clock_grf_reg
  without any clock masks, so the function falls through and returns
  -EINVAL.

It is correct that rk3328_init() doesn't set gmii_clk_sel_mask
nor rmii_clk_sel_mask/mac_speed_mask. However:

static const struct rk_gmac_ops rk3328_ops = {
...
        .clock.rmii_clk_sel_mask = BIT_U16(7),
        .clock.mac_speed_mask = BIT_U16(2),

which sets the default for these masks via:

static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
                                          struct plat_stmmacenet_data *plat,
                                          const struct rk_gmac_ops *ops)
...
        /* Set the default phy_intf_sel and RMII mode register parameters. */
        bsp_priv->gmac_grf_reg = ops->gmac_grf_reg;
        bsp_priv->gmac_phy_intf_sel_mask = ops->gmac_phy_intf_sel_mask;
        bsp_priv->gmac_rmii_mode_mask = ops->gmac_rmii_mode_mask;

        /* Set the default clock control register related parameters */
        bsp_priv->clock_grf_reg = ops->clock_grf_reg;
        bsp_priv->clock = ops->clock;

Thus the AI review is incorrect.

Not setting clock.gmii_clk_sel_mask is fine, because gmac2phy (id=1)
only supports RMII. That was documented in a later patch that, because
of the problem with AI reviews failing, is not part of this smaller
patch set:

	net: stmmac: rk: rk3328: gmac2phy only supports RMII

Given that there are sixteen Rockchip SoCs in this file, describing
in detail every change just in case AI spontaneously decides there's
a problem that doesn't exist doesn't scale.

Note that previous AI review of this very same patch but part of the
full patch series passed without issue:

https://patchwork.kernel.org/project/netdevbpf/patch/E1vkL2s-00000005uta-3W8V@rmk-PC.armlinux.org.uk/

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

