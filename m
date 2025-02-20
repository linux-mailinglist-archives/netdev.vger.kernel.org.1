Return-Path: <netdev+bounces-167979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9FDA3CFE4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1448F3BB7A1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C01DFD83;
	Thu, 20 Feb 2025 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwPHTaBS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1941DF98B;
	Thu, 20 Feb 2025 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021004; cv=none; b=QXBkB+ZHD/YTdZ8nPUL9qZp7CrVfQuGwKcg809yVXPC+KttjjIFfkDAw/roU0rjvAfpk54bNO3xxyb9idn4ILLIjGvR96lRoHHz7iKzwz0jtyum6l5HYZQrbuNAeQloz+mF9JzNUhDmImFkdQFUnWdx2t+afJLFYIFuaMvqohpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021004; c=relaxed/simple;
	bh=8Ek/lENxsqLvCr29S2YZBIuImLC7fMD7R8FfDhB2sms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wh1922Od7hMoEpwfozWH62cn2yVWyaK9MiFloBnhQsiCzEZG3XwD4lYO0jB6tHzGm/LeLJLWRCb/BwG83yaboLukxZKHnME90DD/kFeunHxw/3TVKwlXr1yVWwrtkNlWn3wckD+2qsi5gVS29kCLCzo6B0SadVt90HUX8tSuGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwPHTaBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189D2C4CED1;
	Thu, 20 Feb 2025 03:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740021004;
	bh=8Ek/lENxsqLvCr29S2YZBIuImLC7fMD7R8FfDhB2sms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cwPHTaBSnmwYn94lAFYw7o4xiNwt+r8RsgDNznb94TN90DPrc1WK8+FUmChuUUg9p
	 TMggAwVcYn7tlmaYekheiWU+KcTfbB16Ct/UbTadcuZXmf/C3Gf2hAHrNHWo/D0eFD
	 SeZrmR2uIR+pPoAKyToWho8c+iBgdrhxP+lQH0q7PeCQnwRMCXr33P9mmYdbiS/grI
	 vTbK2l0ei620HYx0QLzki4IutVZxepR13Mv85/iSHuX2okLTAWC13C1NC7M0iyjnKc
	 sONIsW/rDR24Oq0f9kxRwhpVXjXeo7pnCwj0nMdDsueYGVt5HDkvxf48J4oi+j9U7j
	 ZbTjmOrVlQj3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD1C380AAEC;
	Thu, 20 Feb 2025 03:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] net: core: improvements to device lookup by
 hardware address.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174002103449.825980.9357598791735948646.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 03:10:34 +0000
References: <20250218-arm_fix_selftest-v5-0-d3d6892db9e1@debian.org>
In-Reply-To: <20250218-arm_fix_selftest-v5-0-d3d6892db9e1@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 dsahern@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, kuniyu@amazon.com, ushankar@purestorage.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Feb 2025 05:49:29 -0800 you wrote:
> The first patch adds a new dev_getbyhwaddr() helper function for
> finding devices by hardware address when the rtnl lock is held. This
> prevents PROVE_LOCKING warnings that occurred when rtnl lock was held
> but the RCU read lock wasn't. The common address comparison logic is
> extracted into dev_comp_addr() to avoid code duplication.
> 
> The second coverts arp_req_set_public() to the new helper.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] net: Add non-RCU dev_getbyhwaddr() helper
    https://git.kernel.org/netdev/net/c/4b5a28b38c4a
  - [net,v5,2/2] arp: switch to dev_getbyhwaddr() in arp_req_set_public()
    https://git.kernel.org/netdev/net/c/4eae0ee0f1e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



