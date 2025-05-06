Return-Path: <netdev+bounces-188190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35927AAB83D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44801C40C39
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897B32BFC85;
	Tue,  6 May 2025 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsjK95in"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE528E5EA;
	Tue,  6 May 2025 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489616; cv=none; b=Zng4mAQ4mFrMwB8BVA9hRHr7C0B8jmJXFvNonpyAi0BLPJv+fgTkAXb8MPwP9v640KjxOdvse3cWRZFKwPH5/gGTWXCGHqm3De/MxKXzFzvSTLLn1F7btKuw9fwNMMegpAPuxzJvF9vCdxW9g8/KTxnbKqAVHrRFs7plXalXKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489616; c=relaxed/simple;
	bh=3lecJIvyOGCCrSvIcGyC2kk0pySXGmhU7C5ZZttibf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lkJfTwk2joLB+bJNdrbkRKdA8f8u2K3oB6EB8jilVJHYbs9MhIiYR4fcwmFEmcqcN162mNuRR/XzEHHTYWQAU5Wr/WRt4p4pkPO5OARArg44oUtoDh320qSLHXJUTQqN44BWL/8TjhDXVwwnMuQ8KcAgaKq1rDs9p8f8W+ug974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsjK95in; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A065C4CEE4;
	Tue,  6 May 2025 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746489615;
	bh=3lecJIvyOGCCrSvIcGyC2kk0pySXGmhU7C5ZZttibf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SsjK95inAZPEbStocI6LWdu5zCDmnBQyJ0BzZK+up48i9cMTGTuLCWgZ4yG1foAc4
	 Zd/AdbXjp9Ba54qmeXUqyY/3srgLbqE/I2361jrP1G5oAZtZeFBenFWdkGwueqgGeh
	 BOSsPhROFuJ/t4Tg3mTnjBTbs/ROMy4cNfjumZRIBzUtLkDj4+0LWT7gPGpQrJuY7M
	 +2iZ+p6Lsyg+pnsOB2mBtnwsL2xr3JQC24VhdTbqp2/fFBwM3YZBfVGd5sLHcnkTR3
	 IPJ/a3YdXKifvrV+N02wGHe6NxtULmfJiYz3LC/0A7KYoUWmSfMe/hmnkhNcm9lrCk
	 Jp53lUkw8qvTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BFE380CFD9;
	Tue,  6 May 2025 00:00:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648965399.970984.1804246664107675712.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 00:00:53 +0000
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
In-Reply-To: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: robh@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, chaoyi.chen@rock-chips.com,
 matthias.schiffer@ew.tq-group.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 11:21:35 -0500 you wrote:
> Device Tree and Ethernet MAC driver writers often misunderstand RGMII
> delays. Rewrite the Normative section in terms of the PCB, is the PCB
> adding the 2ns delay. This meaning was previous implied by the
> definition, but often wrongly interpreted due to the ambiguous wording
> and looking at the definition from the wrong perspective. The new
> definition concentrates clearly on the hardware, and should be less
> ambiguous.
> 
> [...]

Here is the summary with links:
  - [net,v2] dt-bindings: net: ethernet-controller: Add informative text about RGMII delays
    https://git.kernel.org/netdev/net/c/c360eb0c3ccb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



