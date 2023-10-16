Return-Path: <netdev+bounces-41432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE87CAEF0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47114281449
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4630CF7;
	Mon, 16 Oct 2023 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEuOzUJU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D45F27EFB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 16:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A1EFC433BA;
	Mon, 16 Oct 2023 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697473226;
	bh=prmnzMjJoC3orAuRSRPrA1N41eUMpXymOOpoOSxbUKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UEuOzUJUytkjp3iOzEL0miyZ1udizh26dejpJNZtnKTs0b/4dDLAtC4Q46gek/YJ/
	 jQIXUFqQk6q1rHD1OuhZys+ugAGOprFeLwOG3ovTZK6Ouj3xxgdgfihRjRrl+ay23V
	 zGd+4JPsrs1FbkGn1EagnpEqznUjWqI+XnWy93K+zDOOQFTHyicixcQHyHwrUrdJa3
	 2LOun3M+SNcG4MsjY0I66Uy1m/vMR6nTLlSsFPO5fWk96gNj4o5rLIRsw/qke1YRgy
	 j4vole2UXQ0M/lBw90GekyR86oVzXaRgWcSOUm2N+/CMGDYfVBdkPvoysB+55rFmic
	 Ayrp8jJnGCskA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E118CC4316B;
	Mon, 16 Oct 2023 16:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] ip: fix memory leak in 'ip maddr show'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169747322590.5359.6865545494483517385.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 16:20:25 +0000
References: <7be84294-b02e-4280-89fb-cf222fbf0239@gmail.com>
In-Reply-To: <7be84294-b02e-4280-89fb-cf222fbf0239@gmail.com>
To: Maxim Petrov <mmrmaximuzz@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 15 Oct 2023 16:32:12 +0200 you wrote:
> In `read_dev_mcast`, the list of ma_info is allocated, but not cleared
> after use. Free the list in the end to make valgrind happy.
> 
> Detected by valgrind: "valgrind ./ip/ip maddr show"
> 
> Signed-off-by: Maxim Petrov <mmrmaximuzz@gmail.com>
> 
> [...]

Here is the summary with links:
  - [iproute] ip: fix memory leak in 'ip maddr show'
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=575322b09c3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



