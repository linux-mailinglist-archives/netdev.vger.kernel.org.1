Return-Path: <netdev+bounces-58338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9041815E8F
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 11:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269131C20CD0
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C04610E;
	Sun, 17 Dec 2023 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nBntoIt3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC163AA
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8FEFuZmOlngVDg6qoilxmXUd7IRbeTKYJQFRLwiL5e4=; b=nBntoIt3pt77FyfoVzLv9n2t+b
	7DIZQyXrxwaxb07A76HuUq0HYPnA2KLoyF53coZ4ftAvBZzOIfr9/g+sUtxq4NsJFmvhg1k3fTo7+
	EnjzsRWcoX7o5g/avD6fxkuWZf/JsisjWbHWhfzv2pa9rAr94Nr10NYxNnT0L0xthPksCntYF79lZ
	HK5lprAN5B+Mkr0koad7BF0PCJf9zDfmD6tBOkx5gSnoXCkJKYaxAzSyAEGduhAIdE3s0sZQ8VtGA
	6nqdSJN6hSLgnuP1F7SZ/idnqN887KzFfQX96ZQbjtgDnhO0wM/LRnAJLESmKatPubiYfWMoQc6s9
	lNhyhpFw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51914)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rEoYU-0004KW-08;
	Sun, 17 Dec 2023 10:39:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rEoYV-0005dg-3b; Sun, 17 Dec 2023 10:39:31 +0000
Date: Sun, 17 Dec 2023 10:39:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com
Subject: Re: [PATCH net-next] net: phylink: reimplement population of
 pl->supported for in-band
Message-ID: <ZX7P4+NwK9fl0M8z@shell.armlinux.org.uk>
References: <20231213155142.380779-1-vladimir.oltean@nxp.com>
 <170277551252.21831.11174233431443095768.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170277551252.21831.11174233431443095768.git-patchwork-notify@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

I haven't reviewed this yet, and I said that I probably wouldn't have
time. Do I need to spend time stating this on every email I receive?
Do I have time to do that? No.

On Sun, Dec 17, 2023 at 01:11:52AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
> 
> On Wed, 13 Dec 2023 17:51:42 +0200 you wrote:
> > phylink_parse_mode() populates all possible supported link modes for a
> > given phy_interface_t, for the case where a phylib phy may be absent and
> > we can't retrieve the supported link modes from that.
> > 
> > Russell points out that since the introduction of the generic validation
> > helpers phylink_get_capabilities() and phylink_caps_to_linkmodes(), we
> > can rewrite this procedure to populate the pl->supported mask, so that
> > instead of spelling out the link modes, we derive an intermediary
> > mac_capabilities bit field, and we convert that to the equivalent link
> > modes.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net-next] net: phylink: reimplement population of pl->supported for in-band
>     https://git.kernel.org/netdev/net-next/c/37a8997fc5a5
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

