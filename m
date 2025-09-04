Return-Path: <netdev+bounces-219883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFEB4393B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B17AE030
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBF42FB992;
	Thu,  4 Sep 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Lx3+0R+d"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F502FB60E;
	Thu,  4 Sep 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982991; cv=none; b=n9akfqgcrh4LcXZSkzgsrcISw39KIlIrzm8Yva2jtmor8lX69JgS7Ge5UD3lluvAIF9pzJ4Z9M53SUKCkUWy8ckoYvCQumK7k7sQRv19D5NtD8HZ2KXmILTPvHcPTiwNu6i8GZsFfwS1WpGMeF8IA3v/L10coDrmalCBOISqMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982991; c=relaxed/simple;
	bh=t3q1DeERXng+EebmSWqjOah8n4JU98TARGoDM8gC9Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzubDmSnlXn9+JlcUqUZW9VAlxF8A795o3S/ntZaXGafm2IdBTWXjT3x+zOK86sJaxWAzzAgHyAZAB33cxzyTl3qx5wxnzU7OtZ7ld5giQlp7jU4AkWAEjkaOV7mGNFjree1V6ys7oOgI/1JHdV3y/eNiH7LZgameMh8vjFQNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Lx3+0R+d; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bj32BBEvUFT2bJkkrxWT0RFZIhU2FlKAOhIlf8DSq2w=; b=Lx3+0R+dpb/wJElSmqaV0NtkZz
	eTTNZctX6+i+m9OQ22cwkZZ3TayAC92JyDE9QjiiVa0ezKrm2f85j0udld84+A1Bq18CpP3KIo6gS
	n/8UI99jE0BpF9yNxgIuJRorHPjvbqwzKJ+M2JLYJi8za4yz/fkXnkLjB6u50owuAIfiFwvMvL14k
	CK6jG6j96MktoCUm0+ZYmravCe76zJlYEpzuaTZ8CWYBuIecQVweB/jcGh8rF4/5FBvNETF/Lryai
	KeYc71O2fJxnJKTCPGxJW/YOCAFjPdizfyeyNm55mDOH+MzP/GwwgV39BK1SSiaED6bgRdIt+qvZX
	M1T2GIHg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56074)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uu7X7-000000001qG-0LDt;
	Thu, 04 Sep 2025 11:49:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uu7X3-000000001Rs-38vh;
	Thu, 04 Sep 2025 11:49:33 +0100
Date: Thu, 4 Sep 2025 11:49:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <aLluvYQ-i-Z9vyp7@shell.armlinux.org.uk>
References: <20250904031222.40953-3-ziyao@disroot.org>
 <20250904103443.GH372207@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904103443.GH372207@horms.kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 04, 2025 at 11:34:43AM +0100, Simon Horman wrote:
> Thanks, and sorry for my early confusion about applying this patch.
> 
> I agree that the bug you point out is addressed by this patch.
> Although I wonder if it is cleaner not to set bsp_priv->clk_phy
> unless there is no error, rather than setting it then resetting
> it if there is an error.

+1 !

> More importantly, I wonder if there is another bug: does clk_set_rate need
> to be called in the case where there is no error and bsp_priv->integrated_phy
> is false?

I think there's another issue:

static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
{
...
        if (plat->phy_node) {
                bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
...

static void rk_gmac_remove(struct platform_device *pdev)
{
...
        if (priv->plat->phy_node && bsp_priv->integrated_phy)
                clk_put(bsp_priv->clk_phy);

So if bsp_priv->integrated_phy is false, then we get the clock but
don't put it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

