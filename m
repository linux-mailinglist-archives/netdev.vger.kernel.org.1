Return-Path: <netdev+bounces-181468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A13A85187
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 04:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40AC8C36D7
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA0527CB0B;
	Fri, 11 Apr 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp3cQLCv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDEC27CB01
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338000; cv=none; b=SZfBYGS/FSm8DSlvLz69pMIMYe3uUaE7oCBj5utfg3IGl3/tEbK8BvAeMmfG4+D42Nu5L0Xdj9rOX9S3pvq6DKQEC0VjVfvGNSmyG9Z38QvuWlVWH0moxQWKrQgJOmx0JyvlSOpgDzyXHllKduGms1jYtBPcGHwlgeXOjy9xXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338000; c=relaxed/simple;
	bh=mfLaG2nxVxcGauw+VJq2eXijJjVtz88YySLM2xjfeZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n7fam9n2F+kvXPCTQ6izhzSJ6kJYSBnSrIRzKRnhewnF/zbHh+9GadBO0BOkWLfKk0fOgNn7sbAp0dYY8obwN+5AS/2a09GVuc0WkmoTTcXT9H2/6OYJBqUUAe74bY08wXpw5LdnmNVzs3Z4l1x9JleN/whfRStf7zU4Z0X50dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp3cQLCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53F0C4CEDD;
	Fri, 11 Apr 2025 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744338000;
	bh=mfLaG2nxVxcGauw+VJq2eXijJjVtz88YySLM2xjfeZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lp3cQLCv/cwNpt+DlYJTnDEjVyvk4bMg5uFILjjk2vsVKT+uwzQ/D/+ebmWEa5eW1
	 gOCvZidtslgc2XOF6WNUWoY7XXmUxUMu3WFXZlbvhDFl2Kffa2Gac5+AZBk6j5E+xp
	 UpR75r0UT5V/JZOyNY+m9ai163z1a7wZy2AEnxeidyFeo82s/qtU0PqnR/8wOfZV6S
	 kiLROQ+CgpB5e87hh6+6ewzA9BpOFpMqXSMvpsZ0GP34GLp+JtcIBYJ96fzCFRk5uo
	 D/r2BCuYFLUHZmXX79yD2XiyP1Skz8Eyyj3UKBUrvfoT4ARuENVjkaDwmSxb7KTbf5
	 J8ApWMWWKjYkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2A6380CEF4;
	Fri, 11 Apr 2025 02:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: stmmac_pltfr_find_clk()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174433803749.3928161.6701102977698674868.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 02:20:37 +0000
References: <Z_Yn3dJjzcOi32uU@shell.armlinux.org.uk>
In-Reply-To: <Z_Yn3dJjzcOi32uU@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, prabhakar.csengg@gmail.com,
 treding@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Apr 2025 08:55:09 +0100 you wrote:
> Hi,
> 
> The GBETH glue driver that is being proposed duplicates the clock
> finding from the bulk clock data in the stmmac platform data structure.
> iLet's provide a generic implementation that glue drivers can use, and
> convert dwc-qos-eth to use it.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: stmmac: provide stmmac_pltfr_find_clk()
    https://git.kernel.org/netdev/net-next/c/de6487201949
  - [net-next,v2,2/2] net: stmmac: dwc-qos: use stmmac_pltfr_find_clk()
    https://git.kernel.org/netdev/net-next/c/34e816acdb0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



