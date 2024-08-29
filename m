Return-Path: <netdev+bounces-123475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7F396504F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE021C20357
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3B91BFE02;
	Thu, 29 Aug 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKWjiTc7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88751BFDF1
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961029; cv=none; b=EhvSK3jKv/ZBWwE7NZms+n00VGv5weqRoy269T6im+zRPDqO2MVe3/2Bd0O1Epcz9Pzq+/tx0hyX41YdhRUOfi3HVwywDIHWHhNgWpc97pPfNerZzGpmCemsbpULED50UTo/Xtym9EeqB/NdcT088at/vHg0CyAw8LDOC28fYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961029; c=relaxed/simple;
	bh=c8SNHMs0M5Xcf9EieWwYQ/XhT9wOPEV9LSSDN4nsUPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=agJAipGQpN0tFNIzMAMmHim/lJ8GOdkN3+VFYBTc7bnTRaLNTAXvEmsAXzjoxB0VdtKqRU2o8ojTrEBWPWrhU5cdlXOIdgef7kIoZ3CUIDCXV/eeElM33nbkb5CfrCrQHNgUjlfV/Br+ma/G3pDRI1rl0WFActJP5OUpY5HdQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKWjiTc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C07C4CEC5;
	Thu, 29 Aug 2024 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724961029;
	bh=c8SNHMs0M5Xcf9EieWwYQ/XhT9wOPEV9LSSDN4nsUPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XKWjiTc7KxREOM/45ih5tD9fWZoIZWRjPU8BL88c1FRcNRHDnuZ5xu6WKEVex2Fyy
	 pUy5U3KA76dnlH36q1qVtOdAQwsXPIcIV9AIv6N9MMDegtY0DlJCScJBJP/BKQ109v
	 uYTTVx1pk57te6wZL/Lb9aZrCrcYjI626k84Z1eZJEp5g/lePFfOwY4NBe2kDWc2K3
	 xYxJ4W2v1BaSrY2RWyKXpR89An6ZKQ4VA/ggx3YA7QkCC1HVOFOxwdJj0/HFlT6irq
	 Qa5G9T36Um7MOFJCbIquCg/8gP3D4MRqRK/RkUYXSoyNH4HInh1EnerN6I9rTvKEfs
	 VY8YShqyNM7bg==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CB0363822D6B;
	Thu, 29 Aug 2024 19:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: error check scanf() in a sample
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172496103082.2069528.9106536777628253727.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 19:50:30 +0000
References: <20240828173609.2951335-1-kuba@kernel.org>
In-Reply-To: <20240828173609.2951335-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, sdf@fomichev.me,
 martin.lau@kernel.org, ast@kernel.org, nicolas.dichtel@6wind.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Aug 2024 10:36:09 -0700 you wrote:
> Someone reported on GitHub that the YNL NIPA test is failing
> when run locally. The test builds the tools, and it hits:
> 
>   netdev.c:82:9: warning: ignoring return value of ‘scanf’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   82 | scanf("%d", &ifindex);
> 
> I can't repro this on my setups but error seems clear enough.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: error check scanf() in a sample
    https://git.kernel.org/netdev/net-next/c/3d8806f37d31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



