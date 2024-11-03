Return-Path: <netdev+bounces-141340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B686B9BA81C
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611741F21635
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F531553AA;
	Sun,  3 Nov 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTICtkOI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D32582;
	Sun,  3 Nov 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667621; cv=none; b=ss3jaA0J8yH5FIZ6+K5Mjxf2hQA1e4ArHQsEJAdlJz05Zf1HCuZ4a0iWponlglzXaenM0sBQcnam5Ww8CzStSrLy8g+4QAEDKmjJ3IIylyf3RvkolG0kn50DMd6CLbMbTkpMeEvLP1i+qDTk+ttfECTy4xP7wJYQm2oTSpLVWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667621; c=relaxed/simple;
	bh=lQYtDDKON/MzTpBlCsO45Z/YVijax61h88SPsZIe2O0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RZcB/PuHyPKSUURTAMbErYkAqPke8RK7pDnVBW0ApBydHQISfypKd3W9SjZ/dDIFeJ6EaPQY2LxWFAtQEZrenKmzwpRCh+yvdqRaU/bfWOVzjPHOzV/QOMj8xSiecgjxeXD22GTP3oM5Vsn8y7eovIeA8lPSxkFKVihpArFsTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTICtkOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0331FC4CED3;
	Sun,  3 Nov 2024 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730667621;
	bh=lQYtDDKON/MzTpBlCsO45Z/YVijax61h88SPsZIe2O0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mTICtkOIuBXJLJmINXsxtm3ngbZ1xrZYWraDNy2CGmYiPp/0ZkXUTMioIQRneIUDE
	 f6PbuBCxGERYfxQOHjBPgqtdQs/26HSJzhaAwzo2m3VZe5luD8KMxDkw4ERG1TwQ2+
	 JlAyO5AImor9K6uBf59tw3XZB1LY9qKl9MCr77WNkd30fgZq+ls6mWBI85FGo2XOod
	 u9NxU/LGKcRwR/ASZV0cqWXMFlIOMZDciUhE36KWfB9DXSstJs8hANmgYrPSEyDexi
	 3NIU5hVlC8cSdDlkMlcU5kvIQ9C8J7Wuspwdu1tVbbWy5VV5jm0V33MXA2ii6YOpVf
	 m0W1/+UqDFvZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFF238363C3;
	Sun,  3 Nov 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Fix issues when PF sets MAC address for VF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173066762950.3253460.10123905926382934471.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 21:00:29 +0000
References: <20241031060247.1290941-1-wei.fang@nxp.com>
In-Reply-To: <20241031060247.1290941-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Oct 2024 14:02:45 +0800 you wrote:
> The ENETC PF driver provides enetc_pf_set_vf_mac() to configure the MAC
> address for the ENETC VF, but there are two issues when configuring the
> MAC address of the VF through this interface. For specific issues, please
> refer to the commit message of the following two patches. Therefore, this
> patch set is used to fix these two issues.
> 
> Wei Fang (2):
>   net: enetc: allocate vf_state during PF probes
>   net: enetc: prevent PF from configuring MAC address for an enabled VF
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: enetc: allocate vf_state during PF probes
    https://git.kernel.org/netdev/net/c/e15c5506dd39
  - [net,2/2] net: enetc: prevent PF from configuring MAC address for an enabled VF
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



