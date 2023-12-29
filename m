Return-Path: <netdev+bounces-60571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B581FE3D
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 09:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7631F21C77
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928527493;
	Fri, 29 Dec 2023 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI2SBy2m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFC748C;
	Fri, 29 Dec 2023 08:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1684C433C9;
	Fri, 29 Dec 2023 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703839825;
	bh=4ghh2Jjv3p7AV8U1XJ4fZ+jMCfHmDeSFHQIa+Z+i9uc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jI2SBy2mJqUhN5SOdC2lWVF2QnsNmbfYpsWv6U4A+HoaLD980MuM/H4+JY0AMa/Nu
	 tZ2R82PjXl2cA0s3PJTs+JkIJFfLDNHgpN1yznDFBSXOi/SGMMXm86ksuUZbv83mN9
	 VQw7Ffwcv+aB8pCNIfSNpCd20ZSHEkqtgJmqncyEBcKi7oIpl3JvgPNs4/MLfD78Bf
	 1BlbXKYRyy3cd+wYPyfXHwk/Nyia279cqguy6TgC8K3COMIE3nlU5xBPty3zSAsoUK
	 MZ9xMHSuLjDKlRa0jjBspPLrvDSll6IPCRs8rpGiRQJu6robHNCewTPHgPo5zfiCD9
	 qgrO6BASo2yXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC2ABE333D8;
	Fri, 29 Dec 2023 08:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] genetlink: Use internal flags for multicast
 groups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170383982483.30428.11615295808750503074.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 08:50:24 +0000
References: <20231220154358.2063280-1-idosch@nvidia.com>
In-Reply-To: <20231220154358.2063280-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 nhorman@tuxdriver.com, matttbe@kernel.org, martineau@kernel.org,
 yotam.gi@gmail.com, jiri@resnulli.us, jacob.e.keller@intel.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com, fw@strlen.de

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Dec 2023 17:43:58 +0200 you wrote:
> As explained in commit e03781879a0d ("drop_monitor: Require
> 'CAP_SYS_ADMIN' when joining "events" group"), the "flags" field in the
> multicast group structure reuses uAPI flags despite the field not being
> exposed to user space. This makes it impossible to extend its use
> without adding new uAPI flags, which is inappropriate for internal
> kernel checks.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] genetlink: Use internal flags for multicast groups
    https://git.kernel.org/netdev/net-next/c/cd4d7263d58a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



