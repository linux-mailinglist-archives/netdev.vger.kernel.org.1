Return-Path: <netdev+bounces-61500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB668240AA
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9EC1F26D54
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B2A21113;
	Thu,  4 Jan 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaFigfQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078E2110E
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C56DCC433C9;
	Thu,  4 Jan 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704367827;
	bh=2p+8ZIhvXYTFcoDz7HsEOJIEOsZi5APmUyhrGHM6NIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WaFigfQxzVtk9bQd66Br/n7I14azEmHwDB8fLGs7xPOLfSYx7aHRWnNOWtBNtGXi5
	 qjCks+931CXbkIBEov4R5ERu93+4wKyBTuK4SjUkUeNcgxDa1vZbPtLwHvMavxGrTE
	 eOyRfDS+4/7nFy9VSwWbH1WBBXAJsKQmL8SsoZ8jpfg7dALpE8eNO8HqikAUPl7+Bt
	 4fk8dXMItztQaoi2QGhBUNeKcKqs5qqterZSGu7AbiNyZDMkvYVY/dJUDgJGcjWjay
	 hVBdv3roFowUTFcnLaHnwkrQSwwN44FvgcANDJHhYSwJKkUNARREl1T+ltR4AUBOZm
	 3eyec1zBYGyJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAE38C3959F;
	Thu,  4 Jan 2024 11:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phylink: move phylink_pcs_neg_mode() into
 phylink.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436782769.30686.11839254531862850049.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 11:30:27 +0000
References: <E1rLKK8-00EtVI-MV@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rLKK8-00EtVI-MV@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 04 Jan 2024 09:47:36 +0000 you wrote:
> Move phylink_pcs_neg_mode() from the header file into the .c file since
> nothing should be using it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> While it is true that there have been no users of this outside phylink.c
> since shortly after it was merged, leaving it in phylink.h provides a
> way to migrate code in e.g. OpenWRT. Since 6.6 was a LTS, let's now move
> the function for 6.8.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phylink: move phylink_pcs_neg_mode() into phylink.c
    https://git.kernel.org/netdev/net-next/c/5e5401d6612e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



