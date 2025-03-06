Return-Path: <netdev+bounces-172402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CBAA54794
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3596B7A2047
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D021DD543;
	Thu,  6 Mar 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0m5MbWQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16FD1A08A6
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256402; cv=none; b=r7zTizqFFkT94Qv6PNh5Egcx1/WdvMWYpWNjRbtslzDWCzr/CgB6RLLvLzLCWhHF3viYeTMHLV9f4MZmTgjTdukEXkIwS7o9ACaiyC0xfzQRKTTVK8IPMNKgoAp4ZTc3/NgAe/1HAsNWU4Odyc5FE6zb+BaQx1z3lM28fQUXEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256402; c=relaxed/simple;
	bh=5FlvuFRrCJRthN2/1J0kZ0i4JN8pdeIgjiINAaybr7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GVs9FVHuxQSju95uhotyYBWPA4iXAG2IHJwzhD2L9fg42mDu9mOJVb5pWYQQsatRbNCXUk9qXj7Bt3dMIXDJoazqS+AO1EdZfqfo0vQwjEcDAPkgaToAvSGu8RwVx9FTzpBgSUFHj6g0u0UzLLwMpt+s+zjtlNs7Wu1xn7cI8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0m5MbWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3D9C4CEE0;
	Thu,  6 Mar 2025 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741256402;
	bh=5FlvuFRrCJRthN2/1J0kZ0i4JN8pdeIgjiINAaybr7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U0m5MbWQ2R+4o00mdBAt2kxxYkPl2zdH6hYDhpC6TK2JKfbTsOQC6vrvdpBh25Krs
	 v3PaccIz8LDkGpM/kM2uvv839m9z/j1V5PhPSjbHxUwOENMX+OIOyAS0vi2Kd6sh73
	 7L09CHl8bZKpBs+v1h+yUV4TEj7+OeHdhk/YD9tzTAJZ0e0mc3SayQNYwAyaJG18nH
	 I1Fw9+mbJR6RThXN+lWeMtj5XCGVsbn0f8WO39g0O8j7gGn7wTcV/WYrLPmf/WG/Qb
	 Lk6B/RKtLq14QHFzD58VG9U0ljtzhiJweb3RbRNOHvja2Rcq5Yf8z6clzAklVsgZKX
	 30JFl+R1YbdAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE103380CFF3;
	Thu,  6 Mar 2025 10:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ipv6: fix dst ref loop in ila lwtunnel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174125643550.1536068.10594735150127153466.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 10:20:35 +0000
References: <20250304181039.35951-1-justin.iurman@uliege.be>
In-Reply-To: <20250304181039.35951-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tom@herbertland.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  4 Mar 2025 19:10:39 +0100 you wrote:
> This patch follows commit 92191dd10730 ("net: ipv6: fix dst ref loops in
> rpl, seg6 and ioam6 lwtunnels") and, on a second thought, the same patch
> is also needed for ila (even though the config that triggered the issue
> was pathological, but still, we don't want that to happen).
> 
> Fixes: 79ff2fc31e0f ("ila: Cache a route to translated address")
> Cc: Tom Herbert <tom@herbertland.com>
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> 
> [...]

Here is the summary with links:
  - [net] net: ipv6: fix dst ref loop in ila lwtunnel
    https://git.kernel.org/netdev/net/c/0e7633d7b95b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



