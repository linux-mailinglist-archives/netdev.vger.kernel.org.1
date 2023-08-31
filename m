Return-Path: <netdev+bounces-31482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346678E478
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 03:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2691C203BD
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 01:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEF4110A;
	Thu, 31 Aug 2023 01:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5E110F
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B727C433C7;
	Thu, 31 Aug 2023 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693446024;
	bh=CfO8wrM4aM6M3RP9MbA+9BROze+UyQ1O3OHXFA3gX+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rl1CP6RbGd2Xa+qYNKI1SDCaSC6qzCWZSG8lqCy3Om69Im2JTTTHljTWt0OccxsK3
	 pH+EDI9vTEhpHPBQhcJS7YFiBR87Ws3r/6Ju3nj1fTchxcShm81SeKLmRfJw5Xk+xp
	 2QF9pWnfJsrpqxgMZsKbfRH8QyPdPftuAvA/gyzS4bO/IDcqV6y2HJfNJxrUq4TeaP
	 pghI+Nk+dP5gtUMMxyMHIe23UJFhv53W2EahCoai9Iuzejz2rctoLl0zelVrhvp3S3
	 rjVA5CxLBiKdbZb6QZd29CCAbuostuJaVndL5XEfRUMfzK8lsD9oQVGlWyauY/omBE
	 KORkOxKG54aoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D989E29F34;
	Thu, 31 Aug 2023 01:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: failure to probe without MAC interface
 specified
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169344602424.11127.17956246580456140435.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 01:40:24 +0000
References: <E1qayn0-006Q8J-GE@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qayn0-006Q8J-GE@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Aug 2023 14:29:50 +0100 you wrote:
> Alexander Stein reports that commit a014c35556b9 ("net: stmmac: clarify
> difference between "interface" and "phy_interface"") caused breakage,
> because plat->mac_interface will never be negative. Fix this by using
> the "rc" temporary variable in stmmac_probe_config_dt().
> 
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: failure to probe without MAC interface specified
    https://git.kernel.org/netdev/net/c/b5947239bfa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



