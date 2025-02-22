Return-Path: <netdev+bounces-168715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A7A40421
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C8C3B0AAD
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7C2B9AA;
	Sat, 22 Feb 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhDj7VHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376A171D2
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184205; cv=none; b=sH/hAVvsB8iyHBdcZFrVDHJmom6CggXPgcUn8z1cQ0uDFr66VH3PXv98xUqBnq/Cg36I17HccKl5dHxhc9tLpEZijk8z0TByWQ5x2OcEwPkA8W+7N6/x5eWPD5lCm+tDIiwMcqWkZZZuuA/HkA95pkDbmRK1Kt4zHR/zKKvjuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184205; c=relaxed/simple;
	bh=zGsbxc8kh3UsxTrMA7zanzStE9AmMOBmHW091m8Yli8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hCRSsEQsxlBpCRYoXxtZE6SKJng7y9PaSvcGp/Z0DUqZ0RYkNqqJpD5TXRwVbPGwgVh6mGtwvS60LytL7K/9ptG1ZOIjHOoFQt8JDltGiJTVBmInlMcACxP2PlG7hmJO6ce0rscBD5NrTxv9OH/nbKQ2qabfcWlvX1E+dNuTmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhDj7VHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42EFC4CEE6;
	Sat, 22 Feb 2025 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740184204;
	bh=zGsbxc8kh3UsxTrMA7zanzStE9AmMOBmHW091m8Yli8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hhDj7VHM4+5hj3rOhrL/KLW/vZn4Gyq55L3Y0gire9+z2MBCOcXLvl1lTZ/0zi3tf
	 bhZ+1GiWyQIrrgZ9vWvdDzaLtrKeh8AR0yxPzuAyNSK5fUhFLsLiMlcKXi6RxPfOao
	 koAqZqlky4vexM+Hu1l7r0foApZwP/XiUi5INrmDDYnmpUgo78c2s2di9jG1jVPN8B
	 RSwTbb2tHNBojDm8KZuLW7qD+W9YGvxGkEht+R3MnNcrOslBgD9ia3avLHfqSxb2ac
	 qMR7dRcxWxIr+tcVDjT3HMrkmB5BtOVexP05C23xiAuU9TleZcubAPRuXFHiuNiNMO
	 Jn0xDa+qbhN9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE40380CEF0;
	Sat, 22 Feb 2025 00:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: fib_rules: Add DSCP mask support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018423574.2248733.15301844378866036848.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:30:35 +0000
References: <20250220080525.831924-1-idosch@nvidia.com>
In-Reply-To: <20250220080525.831924-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 donald.hunter@gmail.com, dsahern@kernel.org, petrm@nvidia.com,
 gnault@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 10:05:19 +0200 you wrote:
> In some deployments users would like to encode path information into
> certain bits of the IPv6 flow label, the UDP source port and the DSCP
> field and use this information to route packets accordingly.
> 
> Redirecting traffic to a routing table based on specific bits in the
> DSCP field is not currently possible. Only exact match is currently
> supported by FIB rules.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: fib_rules: Add DSCP mask attribute
    https://git.kernel.org/netdev/net-next/c/ca4edd969a94
  - [net-next,2/6] ipv4: fib_rules: Add DSCP mask matching
    https://git.kernel.org/netdev/net-next/c/2ae00699b357
  - [net-next,3/6] ipv6: fib_rules: Add DSCP mask matching
    https://git.kernel.org/netdev/net-next/c/c29165c272b8
  - [net-next,4/6] net: fib_rules: Enable DSCP mask usage
    https://git.kernel.org/netdev/net-next/c/ea8af1affdc0
  - [net-next,5/6] netlink: specs: Add FIB rule DSCP mask attribute
    https://git.kernel.org/netdev/net-next/c/0df1328eaf04
  - [net-next,6/6] selftests: fib_rule_tests: Add DSCP mask match tests
    https://git.kernel.org/netdev/net-next/c/e818d1d1a6ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



