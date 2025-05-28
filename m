Return-Path: <netdev+bounces-193782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34714AC5E81
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 02:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070F41BA5A4F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 00:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE4C1DF24F;
	Wed, 28 May 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLMZpANA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD91DE887;
	Wed, 28 May 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393401; cv=none; b=l7sscEic8LQPDkLZG0zXYXeOZe8POCyKCvYnTRHfc1oAyfhPI13Lhfe3qQIKevY7/UmCNMv3udtd4CG9DfjtyL4oWIn6QezbCSQ311O+Wd5xTgGF9rl7d5XpJd3Ru9BfDYv3xGZTLX5NmV+zlHP8mWooz9cetkxXagzo5yPr3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393401; c=relaxed/simple;
	bh=t4delPiixmZ++T3mI0O1jHs6Wq4kigSiB2VmH2BQ3Dc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RA82svTL0lrPm6QZV9O1Jm0PTc8A7GrvY5Qg2lwNJfJSZRQL3j1+CZmbVqgKCC9jhnuX+xj2Z6W8V0aT1nlHlYk3VE9bW3w/k0pZbb/rDtXSWzXLrkL1c0xHWQtOiLNm4Y30WKBjGIsl4OI1Zmbvpp+Yrj1tnSRZHvRxxnMv+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLMZpANA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B76FC4CEF1;
	Wed, 28 May 2025 00:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748393400;
	bh=t4delPiixmZ++T3mI0O1jHs6Wq4kigSiB2VmH2BQ3Dc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KLMZpANA+UIR50q5E/6ZGxfJOgc58RlIKwZP0C42LwricjnIhX3GSjwfEEsGkct9X
	 k5/k86aPyQp01IoIdLlwU2JQeTr9zNiMkTxk0/vZ5fJmrbvUvtqu414s22uOtthtRt
	 fBOZB0YWHC9XMBYL4OjC64dGbAYXRWvtDM/+DEqhdgtLt38tH/VfVlR0AqNPggvjKS
	 urJ4BFg+XVwg9AR8f75B43EJYDR3VVwuKeoLId3NjCJUpQu585oyE/k20X7G98hEJ7
	 btvbWtoHfUpVZS7AHulhy93dTsr7dSBHU748A9rMcEWVxzPY2wXAhL/IpVAop3WwPp
	 9Q1Odybu8ZECw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE2380AAE2;
	Wed, 28 May 2025 00:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: macb: Check return value of dma_set_mask_and_coherent()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839343450.1843884.3786813515342673012.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 00:50:34 +0000
References: <20250526032034.84900-1-sperezglz@gmail.com>
In-Reply-To: <20250526032034.84900-1-sperezglz@gmail.com>
To: Sergio Perez Gonzalez <sperezglz@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 May 2025 21:20:31 -0600 you wrote:
> Issue flagged by coverity. Add a safety check for the return value
> of dma_set_mask_and_coherent, go to a safe exit if it returns error.
> 
> Link: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1643754
> 
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: macb: Check return value of dma_set_mask_and_coherent()
    https://git.kernel.org/netdev/net/c/3920a7588007

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



