Return-Path: <netdev+bounces-70063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9BD84D7CF
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F352871D5
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85B81E;
	Thu,  8 Feb 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rroeZ7OH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DF25626
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359430; cv=none; b=N6GSWikbtBLpB2IfClzdZz+Y8aw/diZw6g1cXaSpwbk0M6PvtydkMOZGF1A4SkDT8O53ktK+DO5i4jH2cBgwCHtGWEVYOTnqf5eHWpo2Vyj5U/gQs3Ogrf87++JJOWuWKqV4Pa1VQdXBQQ76GN8bPxEk2nQeHksRApXliyzuyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359430; c=relaxed/simple;
	bh=2yca3N22QdqL9188dm9kQlavdSzKPe5NeETH7LpYHkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qK0ZlNBnTea9szQVvoVYClQPnqSWemSbfK09glsbP8P36GWmY/tKOhiLwrGuTDS8ttrSR+gizcah7PdIuJ891bNYy61h4ZsEs73bEhyyOt2KPqHieCjEK/uDh43mH6UxzfSOQpqsURAMlqH9AvJfhVxngNgdMypcfO9wT8O/r4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rroeZ7OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37DCFC43399;
	Thu,  8 Feb 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707359430;
	bh=2yca3N22QdqL9188dm9kQlavdSzKPe5NeETH7LpYHkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rroeZ7OHhVVLnHX0p4hf/TrOM+rtSrYSUYEwbi2yr8BZ6Kr2+AiORvh8oef0q73LI
	 VtqzUNZk+60XxwdfjXDs7OyrfxbzhN2JFJEyVZUOWZgel7O/BE/9PKFzCXEYBmtb8C
	 TTta8RSOwX8LqxboZJ1/LFqUaZEOL44G6X7PlTvK+Is6VjzekYrjY5NE8XdjRFj8Uo
	 Q2lIWHWw5eJ9iEsOR9RVxBtqNodHz5e7WoWgZz56xINMCJ+iM4/yh/XTiYB8YwsOjl
	 zMThYc0pAa/XiTLzfugwx9QTfGiWW/+82h3bPf9zJ9p9aCF37t8Fx3FEBr0E/28UsP
	 Uy5Tuodgd/WQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13E32D8C96E;
	Thu,  8 Feb 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: phy: realtek: complete 5Gbps support and
 replace private constants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170735943007.7438.1121662523853433523.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 02:30:30 +0000
References: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
In-Reply-To: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: kabel@kernel.org, andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 4 Feb 2024 15:15:00 +0100 you wrote:
> Realtek maps standard C45 registers to vendor-specific registers which
> can be accessed via C22 w/o MMD. For an unknown reason C22 MMD access
> to C45 registers isn't supported for integrated PHY's.
> However the vendor-specific registers preserve the format of the C45
> registers, so we can use standard constants. First two patches are
> cherry-picked from a series posted by Marek some time ago.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: mdio: add 2.5g and 5g related PMA speed constants
    https://git.kernel.org/netdev/net-next/c/6c06c88fa838
  - [net-next,2/3] net: phy: realtek: use generic MDIO constants
    https://git.kernel.org/netdev/net-next/c/2b9ec5dfb825
  - [net-next,3/3] net: phy: realtek: add 5Gbps support to rtl822x_config_aneg()
    https://git.kernel.org/netdev/net-next/c/db1bb7741ff2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



