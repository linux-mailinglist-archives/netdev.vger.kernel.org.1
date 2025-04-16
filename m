Return-Path: <netdev+bounces-183112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90FA8AE5A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 05:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD9F3B0C3E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB12227E87;
	Wed, 16 Apr 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEW1GjdV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8F1A83E5
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744772996; cv=none; b=O//CDnT9J01LcAxq9HFwDxkszEWA2H8RXxOHPLP9bwgduFLX+3PBrOZQ/Rbmzgj0VNsT2PcobgGXB1qQDEBdci+jffoAAyHpCjogrLbZulxWMi6NGuBRLVolPlO2l0HnOUX70ttrduWQht+alGipXWKa8vC2kyyxUS525en8o+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744772996; c=relaxed/simple;
	bh=b/6w5CTcAwCbDukkXfoQ7swoGmg617cjp5MeSUWWOH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sBIH7/gHsc9NIHkEUMfULOQngKSUK1qMOON49Gc2uvAUZZNsUmYz4N+mqKVYYaVnXmzCkDI/AcQWVn1WZ6L0DuZtVPZLkoZWwdiEodcM+I2AXdkzWlSkyX5i5MaWw+sRc83MgZPYsEC4rI27XN3HYg8B8J2f2TqpYZpCB1O2gBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEW1GjdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF42C4CEE7;
	Wed, 16 Apr 2025 03:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744772994;
	bh=b/6w5CTcAwCbDukkXfoQ7swoGmg617cjp5MeSUWWOH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eEW1GjdVcFJNFZW7VWUQfiAnjy1xiVfCBSoBLegVuYeM7i83uEHl18OAmJlJ90YSv
	 B9lGSApIHvAsRc4u1thaucoztXDcy4PTL/mj8WmecXd9S0gk5YKlKz3wFczP6gPStK
	 nG6ddncTh0HRd/AJ9EGYTqi3HhYGyPMKe9wftK0N74fXVsSXOK+lKayUoPq4U7SehY
	 RbPtx31R47nLjE3dc7q/MJLIDX/ORNBxpzL9Wg2ZfvbE4abZoSbzA2WMpJFdn5qMdr
	 ue612qV6YvKygrkJBt4dkBog9CBBKz9+9IRwbX/V9wrzLJYyO81nVriwXRdh5g/6+n
	 7q8r9V+MzBQYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFAA3822D55;
	Wed, 16 Apr 2025 03:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] fib_rules: Fix iif / oif matching on L3 master device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174477303277.2860234.12893331216079385181.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 03:10:32 +0000
References: <20250414172022.242991-1-idosch@nvidia.com>
In-Reply-To: <20250414172022.242991-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 hanhuihui5@huawei.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 20:20:20 +0300 you wrote:
> Patch #1 fixes a recently reported regression regarding FIB rules that
> match on iif / oif being a VRF device.
> 
> Patch #2 adds test cases to the FIB rules selftest.
> 
> Ido Schimmel (2):
>   net: fib_rules: Fix iif / oif matching on L3 master device
>   selftests: fib_rule_tests: Add VRF match tests
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: fib_rules: Fix iif / oif matching on L3 master device
    https://git.kernel.org/netdev/net/c/2d300ce0b783
  - [net,2/2] selftests: fib_rule_tests: Add VRF match tests
    https://git.kernel.org/netdev/net/c/f9c87590ed6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



