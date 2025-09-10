Return-Path: <netdev+bounces-221518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F81B50B2F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3971C259B1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4924676D;
	Wed, 10 Sep 2025 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nirCfCRB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF72459D9;
	Wed, 10 Sep 2025 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472014; cv=none; b=Y+l4b4lDaEd8ngc2pDejOsgODFQS/+BQTF3XGA5sv7FqGkLiBsN82zRpF7h99IAkY8uJx2jSFxn+1aDZdM1QUl/8vsp5GMRt0FhNX0ZpC5q/z8afm9QFxTPkgM5Nm8lkq27usX/u98UFleYebayiYbgNfEuPXNnZEh6v5KHnqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472014; c=relaxed/simple;
	bh=stQIs7HpZ+QXH2g22txXNUTDmA8/b+zGrOaDiZfefFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZD57cU+jVoJLZyFTg4xSoqbrukJzWTz39IB0a4CPS85fzIt4v6J6AiqfYfpzg+puOsgyuToqWOBBSB2sbmovKTmqxYThGWUUljhc0f0quq6CGWoqW4j8mFYTui2R5/4QPmSDa5qhVhmSLGpRsSMtyazTr13+9EFXIEpVVrsdWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nirCfCRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C113C4CEF4;
	Wed, 10 Sep 2025 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757472013;
	bh=stQIs7HpZ+QXH2g22txXNUTDmA8/b+zGrOaDiZfefFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nirCfCRB2qSMu/mYXbsftxi8LVUHrUjNb1r4YZQ4jJgAyLXKViHUrfGo0KtCARhCT
	 l0luxy5zSluOW/5sb0LQp5qcXNCzbia4tcXOV96F8AOi957kyOmZrkMJZYl6H3I+JX
	 KCKDc1RCsWPvJf6o2/jMmGM8wPBbNnVTGPrnHRmGyrjTAg6GR8oUzDocopAF/8JAVN
	 HEFSiduXcnoFwF+xG6f2n9O+jxrPHq8SZ1EymvOydShqa4s11zG1DiVF2pVMuT1SAf
	 XOqJGOVSzUUnpsHa0u4Pnvp2zTZ+FGpx3f9fhGHVP2kYKEJ289CQhwMvY3yfZFlmJ7
	 agnCP25cyFH4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE8383BF69;
	Wed, 10 Sep 2025 02:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: marvell: Fix 88e1510 downshift
 counter errata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175747201674.884239.10249854202492384045.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 02:40:16 +0000
References: <20250906-marvell_fix-v2-1-f6efb286937f@altera.com>
In-Reply-To: <20250906-marvell_fix-v2-1-f6efb286937f@altera.com>
To: Rohan G Thomas <rohan.g.thomas@altera.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 matthew.gerlach@altera.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 06 Sep 2025 10:33:31 +0800 you wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> The 88e1510 PHY has an erratum where the phy downshift counter is not
> cleared after phy being suspended(BMCR_PDOWN set) and then later
> resumed(BMCR_PDOWN cleared). This can cause the gigabit link to
> intermittently downshift to a lower speed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: marvell: Fix 88e1510 downshift counter errata
    https://git.kernel.org/netdev/net-next/c/deb105f49879

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



