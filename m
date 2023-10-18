Return-Path: <netdev+bounces-42087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4797CD18F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C01C209A6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D88138E;
	Wed, 18 Oct 2023 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieSaQVIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030CDA23
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82988C433C8;
	Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697590830;
	bh=K2deq/2Shw6UljQTvW98Mv2vAHt3FhdhO48jhYtDOe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ieSaQVIw+2LuuWrOLgLuT6P47pVmVQWtB8kbHsCga2zN1FQ/8Rl3JpJilDrPGIPqA
	 5NUO9MQ4dFBc5vNL2F6LMf75HlvClX9LqGCDaxVWOXtZKHZqonemfs7CKX3s55QLVw
	 J6DOPhXgp83P39Jkzj3QQRt6ny65alLAjPSP7MdCBRXoYkhSGp1YzGfXLDi7AXkJTT
	 /DVnVUXuAwJVL9gOwGF0wYqwUcwv3akELOxAum53WRBmSOA0Ndjc7mpSCCXAwbaXou
	 du4HVJ+vF++TDFWu6730dICpFCQ2ja/IUnyl2baBWDn7DMbWXLdL8+yH0WC7/R+Rs7
	 8iCA+NUI/quxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6ACB9E4E9DD;
	Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/5] bridge: Add a limit on learned FDB entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169759083043.18882.3734658950123094755.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 01:00:30 +0000
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
In-Reply-To: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: davem@davemloft.net, andrew@lunn.ch, dsahern@gmail.com,
 edumazet@google.com, f.fainelli@gmail.com, idosch@nvidia.com,
 kuba@kernel.org, razor@blackwall.org, linux@rempel-privat.de,
 pabeni@redhat.com, roopa@nvidia.com, shuah@kernel.org,
 vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Oct 2023 15:27:19 +0200 you wrote:
> Introduce a limit on the amount of learned FDB entries on a bridge,
> configured by netlink with a build time default on bridge creation in
> the kernel config.
> 
> For backwards compatibility the kernel config default is disabling the
> limit (0).
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/5] net: bridge: Set BR_FDB_ADDED_BY_USER early in fdb_add_entry
    https://git.kernel.org/netdev/net-next/c/cbf51acbc5d5
  - [net-next,v5,2/5] net: bridge: Track and limit dynamically learned FDB entries
    https://git.kernel.org/netdev/net-next/c/bdb4dfda3b41
  - [net-next,v5,3/5] net: bridge: Add netlink knobs for number / max learned FDB entries
    https://git.kernel.org/netdev/net-next/c/ddd1ad68826d
  - [net-next,v5,4/5] net: bridge: Set strict_start_type for br_policy
    https://git.kernel.org/netdev/net-next/c/19297c3ab23c
  - [net-next,v5,5/5] selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/6f84090333bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



