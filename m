Return-Path: <netdev+bounces-192623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF3BAC08B2
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB851BA827C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02E2882B3;
	Thu, 22 May 2025 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9GiZgYK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1776287509;
	Thu, 22 May 2025 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906202; cv=none; b=Ts8ywTPfZ8BhT+FNE2l2Z4YkvoFFx/Q2IxGlYQj3r1xrUoH+fWnTYAehzCZz7zWmHF/Ihqjnei2a7kbzhMcnptDVf6R4ZL6TDdUYXjy/od/aNThXZZMJ1RjfkxjnJNNU+SZlSPA04Q1DkllfAsPILTfsr8oWjfuLD7nJL8HreH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906202; c=relaxed/simple;
	bh=LrhHBtCAj/5rfvAU6Fbhhc46QRBAOG5iW0o66arOxSA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DHeL9KKBJm326dL1xaBTuV8SkcW5pq1luE3U3ZLc5GwKVj+uvLxkHCSAVI5ym8tdxDATzCqfKrD4YQKVCX+p+GkV+67ybEHNwQHL2OIapX13VwlaAiIWmMIMlImqOCsT1Kzi5cDDTDeP+2J7ngdg/YmJ4ovyCK6seNEhpAW8M5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9GiZgYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1EEC4CEE4;
	Thu, 22 May 2025 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747906202;
	bh=LrhHBtCAj/5rfvAU6Fbhhc46QRBAOG5iW0o66arOxSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N9GiZgYKeDy7G+8i4LVBVfN7QIjlWCRGEY6UDWzR2KmXMG1Boe4gOCKVQ4W+Z84eN
	 ibg9KA58HkfVZIw0u5lWjkIeV9rwQuZ4k3S4EElQTIBpWBtXRcJkRuGSYGEGBrBGcW
	 v0jE66SegD0wJvCVSRLfaT+7FJssFLiY7xNRIURrzOrz6lCN8rLn0Je5o/DVcU8h/u
	 fxKM1Ls2KhA9XQeuNsULS9Zm/xrl4xekf6IPnOCGm64L1dkNlB/eF2+a+2m0IElMTr
	 dydRWwK/JTdiqnO6VKJJopoFoX1pHanQUaBghZC4TU7dPAuZimELZTNTor6IMgDpzn
	 VHYgkalemZy3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1E7380AA7C;
	Thu, 22 May 2025 09:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-pf: Avoid adding dcbnl_ops for LBK and SDP vf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174790623774.2464246.16312456507750189389.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 09:30:37 +0000
References: <20250519072658.2960851-1-sumang@marvell.com>
In-Reply-To: <20250519072658.2960851-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 19 May 2025 12:56:58 +0530 you wrote:
> Priority flow control is not supported for LBK and SDP vf. This patch
> adds support to not add dcbnl_ops for LBK and SDP vf.
> 
> Fixes: 8e67558177f8 ("octeontx2-pf: PFC config support with DCBx")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net] octeontx2-pf: Avoid adding dcbnl_ops for LBK and SDP vf
    https://git.kernel.org/netdev/net/c/184fb40f731b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



