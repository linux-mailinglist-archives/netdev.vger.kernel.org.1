Return-Path: <netdev+bounces-244344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A253ECB54AB
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98F2B301BCE7
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CBB2F3C0F;
	Thu, 11 Dec 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+IKh1UB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2D2F361C
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765443801; cv=none; b=DDUOqeXRU9URgRCckvM/+Rbw9GV18x84IQ2bPq9wjJi1YlFfmuB+q+yJZciUxSDOU2Dcnei228HCXioJbAVLr8O4cAuIK1gWRnxACVvWHVuPOx3QkUU0IKdPGttmthUyzOF/Svg1njU4gjJtIyY+PTCWFe+8CkTb/2bneLEL59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765443801; c=relaxed/simple;
	bh=2ZzH3et/hGW/7CPcax9Y3VKFUQ6GCF27JJy4NKMZaM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W+2oCGmthDufWWk6Jv77JXZNuW6ciyvoFmUisJL/RTPFEXUSZLesghDHznFQh3OgwANeKaoX482jgvjv1XDKq/VHkzO15RJczJLKHLF8XXN70KTtzA2itVYWGJHKI4AGeRWbnHAm1Lyf9L7vIg9Vyygv7iRR9bkrLuVInY58zKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+IKh1UB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EC1C4CEF7;
	Thu, 11 Dec 2025 09:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765443800;
	bh=2ZzH3et/hGW/7CPcax9Y3VKFUQ6GCF27JJy4NKMZaM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e+IKh1UBigFd7zAopgEqqOxykmqpbmPtG3ek4IFeZUntDx4jBWpThe9bKsuMf8dRd
	 mBi59x8iB4cbGMg5wbIt+WfIZ8ZDf4Q+gFkvaORHCngRYrKJ5O2AVGIEkCxKnEmOrw
	 Fuy0Lhqdk66LbHlao4UrBvTYtx1wME6Mc+9t0DwZTopjN4NoCMMbl9VwPGtemHagnh
	 MhrXq3AJHC0vzis43oG/jSvoOJ5B/kyTnu1xnVqFtGZk/pfpiMGzf7+1EDU8Slv8hK
	 pXO65V1l9KY/9XWUcbhrN9Re8zBpnvDhhFxJNWr3W9L+bJ0sOjsjmiLfgxK3pWkQ4A
	 OCzhk5L7Ws0Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A4F3809A34;
	Thu, 11 Dec 2025 09:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: forwarding: vxlan_bridge_1q_mc_ul: Fix
 flakiness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176544361479.1297204.11717578974433918906.git-patchwork-notify@kernel.org>
Date: Thu, 11 Dec 2025 09:00:14 +0000
References: <cover.1765289566.git.petrm@nvidia.com>
In-Reply-To: <cover.1765289566.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 9 Dec 2025 16:29:00 +0100 you wrote:
> The net/forwarding/vxlan_bridge_1q_mc_ul selftest runs an overlay traffic,
> forwarded over a multicast-routed VXLAN underlay. In order to determine
> whether packets reach their intended destination, it uses a TC match. For
> convenience, it uses a flower match, which however does not allow matching
> on the encapsulated packet. So various service traffic ends up being
> indistinguishable from the test packets, and ends up confusing the test. To
> alleviate the problem, the test uses sleep to allow the necessary service
> traffic to run and clear the channel, before running the test traffic. This
> worked for a while, but lately we have nevertheless seen flakiness of the
> test in the CI.
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: net: lib: tc_rule_stats_get(): Don't hard-code array index
    https://git.kernel.org/netdev/net/c/0842e34849f6
  - [net,2/3] selftests: forwarding: vxlan_bridge_1q_mc_ul: Fix flakiness
    https://git.kernel.org/netdev/net/c/0c8b9a68b344
  - [net,3/3] selftests: forwarding: vxlan_bridge_1q_mc_ul: Drop useless sleeping
    https://git.kernel.org/netdev/net/c/514520b34ba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



