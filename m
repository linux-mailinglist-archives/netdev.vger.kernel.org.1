Return-Path: <netdev+bounces-111313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D33D9307FC
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 01:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F2E1F22A15
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874371448D8;
	Sat, 13 Jul 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U40vCgZX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECC3BBE1;
	Sat, 13 Jul 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911632; cv=none; b=bL0Po/lOsliLc/6VhQW3yra2gy8kZoFBVVlBR2dMc6mU6ro1emiAgUr/N2KhSrb/xFZ78yfo7TbrepA9624bt+56fWcxq1XBHWZ3dyv2JN3rSfn1ArKYzgIq720hpIWEqefTgZg5xHro4zIBUKD+2jRTzASWYIXBoJYaA4uLaM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911632; c=relaxed/simple;
	bh=osB3CwCTOjtl+uDkzfVBRJWU0lTh153PpcPXK13LFaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sgFD3tvRxsT96SptPgvtFk1her96YL7Ag07jofig1HzM15lufghZvsLWazEcs1QQDaE67k71BHHWtR8XCVQBX/VOQHpoktHP7w77q6wgGqwPnjQJQ2LLySFTnlvxNpMGj9nSHG2Z2YwmYRpX9Vqh72kd1SHtlEVGkMX+2OHMZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U40vCgZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4BFCC4AF0B;
	Sat, 13 Jul 2024 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720911630;
	bh=osB3CwCTOjtl+uDkzfVBRJWU0lTh153PpcPXK13LFaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U40vCgZXjDtXGJbGn2nCKolWHQwIBwYJe6qpRxQAmmjC7HiJuBE+XhxOISEcNZIVs
	 2U1cok17z1VfoOdxUhQOQLilP/xCF9XC2rChFWPDuUxzHmZLeA7lUMv/kXPFhXY3gv
	 bmhQd3FL8q8S2lYhuCPaNAuT/rDYkX95RE29pUsb6WFXYFHMLlmoCUNW1Yd7PKVaGa
	 kO3XhTyLRG38ia96ktxZmeX5Az8UX+4Bp75eBSkt1xT3s41iGDqO7aEsCYV0+8Q5q1
	 1C8QSj5SWTbnrR9XrtgPApfY1MAHf3FnqquKDL1lWIiuIGyJlnLfXPrTRf5peE7NSL
	 IKO7Os26m7YrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7248C43153;
	Sat, 13 Jul 2024 23:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dpaa: Fix compilation Warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172091163074.4696.14903730554043698396.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 23:00:30 +0000
References: <20240712134817.913756-1-leitao@debian.org>
In-Reply-To: <20240712134817.913756-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: madalin.bucur@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leit@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 06:48:16 -0700 you wrote:
> Remove variables that are defined and incremented but never read.
> This issue appeared in network tests[1] as:
> 
> 	drivers/net/ethernet/freescale/dpaa/dpaa_eth_sysfs.c:38:6: warning: variable 'i' set but not used [-Wunused-but-set-variable]
> 	38 |         int i = 0;
> 	   |             ^
> 
> [...]

Here is the summary with links:
  - [net-next] net: dpaa: Fix compilation Warning
    https://git.kernel.org/netdev/net-next/c/e7cdef626f1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



