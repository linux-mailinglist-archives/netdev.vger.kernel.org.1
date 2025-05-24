Return-Path: <netdev+bounces-193229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B1AC312B
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C65B17CEE0
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 19:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A9823AE95;
	Sat, 24 May 2025 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HAt5yaoD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B138217F24;
	Sat, 24 May 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748115298; cv=none; b=aalLt9GP5A5CW7gO5tdeRLPORfabt7XIchuSPjhzJQSjOF+C6mB1wZvKttBOSIjYFYckR0ByYfBCqUHSLz3/rnnIVYzpdlap0U4TfDnHDjjSTReMcnXwb1a5/AY1RLhNDSZYPj7tWXKJtfxZ26QRJ7tJk9XHsWFkXB+8bV7pYuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748115298; c=relaxed/simple;
	bh=RcQpM8Qhq03nv1Nk9bPW2HtWKX67vf6WAJ14x+qCfDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYNELOjWbcDSPAjMF7zAM9V3M225rqRKC2s7vNBUIm65Kt7/+40+xdleK0ij/qbPCidSb7JoBDmFi2gN0jUYeLOPY4QFxg6v3bSWk6+/L4gQ245ocG3rSsqUrle9HVIJgkVioRQ65FpDLKVgWSe0EXsh49Iyi7vsKZAmhDQcnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HAt5yaoD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FDzdnEi5TtcfKfjBkwBIU4/mQNamhC7e6P0CVNdVIJw=; b=HAt5yaoD8r1RszUzBbuF8pC43r
	6oAm8q6za/9fBu8kLaJV/wfUo1mDL9YbJN24T8ehAhOcgv1KvAaRQq9qcls3V1pNhtZ72ypqO4huO
	T+JQFwB3s23BdF/KqtFLnIcdJhDEQaW72xPKwVhW9bzjbdBXXhj6+O9gLx3mhZhQssUdBJlPvvZS/
	xK+2bfiQ7CXjruJHi0FeyQqKd9ki4wveUOyeKQxlMug29Mdri9yyYxhwAgn+ri1g5FNf9H9oZeSt4
	2awXIc4zwtCH2Mt8RLAF6Sd+a134GkvAA/diZAqtSuBDgq65VDnu1BgJ3SjjO/IWyg3/LWvWJgIgE
	QekY3i3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59090)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uIudU-0005Al-17;
	Sat, 24 May 2025 20:34:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uIudJ-00075J-2Z;
	Sat, 24 May 2025 20:34:13 +0100
Date: Sat, 24 May 2025 20:34:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: lizhe <sensor1010@163.com>, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	jonas@kwiboo.se, david.wu@rock-chips.com, wens@csie.org,
	u.kleine-koenig@baylibre.com, an.petrous@oss.nxp.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] net: dwmac-rk: MAC clock should be truned off
Message-ID: <aDIfNZtSwZ1HwW2l@shell.armlinux.org.uk>
References: <20250523151521.3503-1-sensor1010@163.com>
 <d5325aba-507e-47b6-83fb-b9156c1f351e@lunn.ch>
 <2525c791.3415.197029d3705.Coremail.sensor1010@163.com>
 <112fa3c4-908d-4e31-9288-b3a2949555b0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <112fa3c4-908d-4e31-9288-b3a2949555b0@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, May 24, 2025 at 04:48:15PM +0200, Andrew Lunn wrote:
> On Sat, May 24, 2025 at 10:05:47PM +0800, lizhe wrote:
> > Hi， Anerdw
> > The following is the logic for calling this function： 
> > 
> > 
> > rk_gmac_powerup() {
> > 
> > ret = phy_power_on(bsp_priv, true);      // here.
> > 
> > if (ret) {
> > 
> > gmac_clk_enable(bsp_priv, false);
> > 
> > return ret;
> > 
> > }
> > 
> > }
> 
> Ah, there is something funny with your patch. Look at the diff:
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 700858ff6f7c..036e45be5828 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1648,7 +1648,7 @@  static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
> 
> This line tells you where in the file you are patching, and the
> function to be patched. This is what i looked at,
> gmac_clk_enable(). And gmac_clk_enable() has a similar structure, ret
> declared at the beginning, return 0 at the end. But the only way to
> that return 0 is without error.
> 
> But patch is actually for:
> 
>  static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)

Andrew, this is not a problem. This is how diffs work. If the function
hasn't actually started at the point the context starts, then the
previous function will appear in the comment after the line numbers.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

