Return-Path: <netdev+bounces-83157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7768911A1
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C4628D346
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7F51E504;
	Fri, 29 Mar 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htAgectT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79B1BDD0
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678831; cv=none; b=gbD73Sb4aifMNIHT17ibkXQZq8XBsFSTkQ0yYT+PKOVN4NuOPwcSlLDCWyeuvk0tVguWnFOuK2Z+DnfQKGEuckBfqzf/Yik+4fuFYDbLR7YUTUw0kQYz9sX2iwnigqvgRtL4czkTFSOncsxHP6I0USOiTWs+CDKhUqh+O+ycJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678831; c=relaxed/simple;
	bh=85uFP2a3BdVx1gAmrA2nkJLkWO+0NlyjaUX8ffgQUQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kFS5XrQNqi+LTkS/gJGWoSCWiQpKalkKY8K75PtTUP/X83HWQgE7TQp0dLPaxnIHr7QuFdZEVtAnvfw9Mk+7zOHu7UAlMQG6sTbhk33tb9CuMM1Myj0r4roiDRfeCEHFZxMAh2/+fyk+wXVRGpWLwgvIndaPbMwTYRCsW2pdifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htAgectT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CF51C43390;
	Fri, 29 Mar 2024 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711678831;
	bh=85uFP2a3BdVx1gAmrA2nkJLkWO+0NlyjaUX8ffgQUQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=htAgectTao0i9o0kulDZqAxPqjui4b687Fs5iVWuM8LU8VczvL2czgspgkH+JEWZx
	 Dk5XUY5uvcz2rwKjUorUtn9rdqsnzfBuaNffF9+uCa/Fh2HaD0xuf6ncgege3aJj1t
	 YPf05HT5YpwcZXBBYWIQUHIUaVbGGsio2cTm4Yo9/c1UOKAJ5/V8Inze9J5NlT+eFo
	 V8k4jVFj3YzF/brnqYhHrU/LwX7UX4eHKDvfg8aKSaP2MbVEzwA2BebHkL4dlPgyTb
	 5s93G4sesJZKrnJf4lsW95A7tT1Zv5/d45QGMcMFL2cRR7uBBHVubvzWCjIAejfPmu
	 Kja4RLQ+61X7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0478CD8BCE9;
	Fri, 29 Mar 2024 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2024-03-27 (e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167883101.31897.8505429423587672038.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 02:20:31 +0000
References: <20240327185517.2587564-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240327185517.2587564-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, sasha.neftin@intel.com,
 vitaly.lifshits@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 27 Mar 2024 11:55:11 -0700 you wrote:
> This series contains updates to e1000e driver only.
> 
> Vitaly adds retry mechanism for some PHY operations to workaround MDI
> error and moves SMBus configuration to avoid possible PHY loss.
> 
> The following are changes since commit afbf75e8da8ce8a0698212953d350697bb4355a6:
>   selftests: netdevsim: set test timeout to 10 minutes
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE
> 
> [...]

Here is the summary with links:
  - [net,1/2] e1000e: Workaround for sporadic MDI error on Meteor Lake systems
    https://git.kernel.org/netdev/net/c/6dbdd4de0362
  - [net,2/2] e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue
    https://git.kernel.org/netdev/net/c/861e8086029e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



