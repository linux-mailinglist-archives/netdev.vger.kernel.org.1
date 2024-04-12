Return-Path: <netdev+bounces-87248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CD78A242F
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA901C2196B
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352E134CC;
	Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+jFEcLB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53713FF5
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891429; cv=none; b=L1dLX3jx6/+QKON0X/PK1RhLvmv2Y+6npw6SilzWclQ05vi1X/dNjfEyFG0yghDofTYYaFR0hmlW6V7hzi8lzTTaEhR8toJadyxySKkIs/dFG1TgvK2j/QFlEziFNaZzyUX8ubIDAVUxjTLl4yZ2M/55b5Qhh/RHXyde1RKFwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891429; c=relaxed/simple;
	bh=NyJq/f6SAKuj+n6D9H9hY2vkfoyVoKw5WTzYOdBCcnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pcrt5CrJWx0cS9fLWgzM73d7e9siEpW6AJ0wG/CYnjb31ZkprBeq27th8rJtthSYbpddcT+McRAFSYdcfM/mCOdThfNcrjAzMj2XcbgPd0+oYh4RxA0kjqCbREKw2e6+M7QyXazY80HBMBilWZgmW8+p9p25h+WN3LikcX8lIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+jFEcLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BC62C2BD11;
	Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712891429;
	bh=NyJq/f6SAKuj+n6D9H9hY2vkfoyVoKw5WTzYOdBCcnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q+jFEcLB8CD7EDuX3MOaF8HZ/81yFvftBMwR+uIgoVIjfjQHeu33BEiIig7iWeVAF
	 TrH0XYpbNcHnEVqsVIZaOYFCSPq2efpgSbAclcY772xPTCNqXFOxzNyJ4jYkqRSeeT
	 L3HZJLqZeDYQFtoTaZDdmbBTPkO+Da8s87h40yDxXhSIbfJOo3XOqBMvKskGpQRiCp
	 10j9iMJ2Yrl8YL0lhByBZxvHSn0e19GYaFJqQ4c4Zgk4JRBQLkiO7aLFeE1VEewUvY
	 qKZOqkIWzHQCaqnacMT7YyQnSzrMDIH2EhP2TccpbnlNOfhKuKpOJkM2Mtgt7hKIZi
	 TY+GLRKVKVm3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33347C433F2;
	Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: dsa: allow phylink_mac_ops in DSA
 drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171289142920.25647.8150577898591001539.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 03:10:29 +0000
References: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
In-Reply-To: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 20:41:32 +0100 you wrote:
> Hi,
> 
> This series showcases my idea of moving the phylink_mac_ops into DSA
> drivers, using mv88e6xxx as an example. Since I'm only changing one
> driver, providing the mac_ops has to be optional and the existing shims
> need to be kept for unconverted drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: dsa: introduce dsa_phylink_to_port()
    https://git.kernel.org/netdev/net-next/c/dd0c9855b413
  - [net-next,v2,2/3] net: dsa: allow DSA switch drivers to provide their own phylink mac ops
    https://git.kernel.org/netdev/net-next/c/cae425cb43fe
  - [net-next,v2,3/3] net: dsa: mv88e6xxx: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/0cb6da0c487d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



