Return-Path: <netdev+bounces-49643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28297F2D34
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE25B20FE3
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DE510FB;
	Tue, 21 Nov 2023 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew/qoqOm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F64A9B3
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 12:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6559C433C9;
	Tue, 21 Nov 2023 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700569825;
	bh=dCBsQOEPe1YI7JdLAa5oxxxmhDn4Yab/WyL8gKZ6q2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ew/qoqOmh2EV/DAJL1GhgI1ZgimV3LUsgWRgsz+jo6BtjjH3jwtXw4J3Ne1rI7kKU
	 n8P1bOpZI+Sy5UyuHNIWbg20iX6CFOWpLsmbaLJWtRNz4s5naTqdXMEgy/xC2TlW6j
	 pTAVeD68H+shr9VbJKRIKE/cvJYMZrA8QSlLh57KdYULbSt+nLT4h/NFWow+dff1OX
	 679MfRNGC8Z0tl1XZKtdry5CjXCxbmWxCmUlo9IZ6B83ZsHAivbLgYzvQAyzUQXeoc
	 CeSUOG+1wXl1oSfx2NUhg0ikM5p/M30frqN7OadLTrebnr9KO7nt8Y/svwavgm/hLw
	 eVNJkNj8rIUvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C8D0EAA95F;
	Tue, 21 Nov 2023 12:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phylink: use for_each_set_bit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170056982557.22867.2738351955688379355.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 12:30:25 +0000
References: <E1r4p15-00Cpxe-C7@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1r4p15-00Cpxe-C7@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 19 Nov 2023 21:07:43 +0000 you wrote:
> Use for_each_set_bit() rather than open coding the for() test_bit()
> loop.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next,v2] net: phylink: use for_each_set_bit()
    https://git.kernel.org/netdev/net-next/c/335662889f5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



