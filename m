Return-Path: <netdev+bounces-95647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E698C2EC8
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20DF1F229C9
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82371B810;
	Sat, 11 May 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXn3mi28"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CB18EA1;
	Sat, 11 May 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392831; cv=none; b=nzVeEGNupQFv7AIkJYBYliOIM5998YErlLrNQFWBcAlqDHkhhl9O3HAfowl0XHJz2OQVdqd6EGG5qf/ijEAuG1yQGCunpClDj+VIaFPDOp2HlES9US7gQbOZdYGyR9dofIR+B9moummsQqvEfmxFo5SegF1V2Uar0bAtgqLOkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392831; c=relaxed/simple;
	bh=q8MUC9+F3FMKd16QZ8MNjsaak83xeCmivpsf/vZqHkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LmdO5kOVs6MWIey9TYY8oYpJ8Frrosj8KfXnN0cYqMiTnJhiEbvihA/Ga4mpBsNAeoZ8aJkc6zWdUgWUEXuqSaFykF2W8lvjSO0Zf/NlB7dMiGBkZrZ4DbVe1NIaXPMKDKLupblIGQ8LFnON6HHTquNdUHUWA8pyTBlQTu3gQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXn3mi28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28792C32786;
	Sat, 11 May 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715392830;
	bh=q8MUC9+F3FMKd16QZ8MNjsaak83xeCmivpsf/vZqHkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PXn3mi28b0OUS+AmxeXJ71jA6/uGWpBCySJ0w6NaeFLjVMKBthR1Zzt7++l3cZmWU
	 fjBqAm5agOulMM5Jj7msqRsHjgC1fmjXqHdpb9DdGPFGsj2ghl9zLp3PKGb+n5L6E1
	 FvZWy7sFM/hcmbBehyuHv+7SumCzMExTNuTn5zqU/+d6WoVn46tTINXgs9uhMG5SJ9
	 gbPid0g0cNkrsqfkIc7eVtHavLX/LfO0LDB/fzu+G+8nLsNxkgqkbBRJ8qAoaO7grT
	 2IMStQwm4eyNQWA0GK1BGmueMpc86ABpUWtA8LK5U7JCp8oWRaxSbkLXKN+QYE8UYO
	 gvcQSD5GGSbkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D800C54BA1;
	Sat, 11 May 2024 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] gve: Minor cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539283011.14416.2158436781698025205.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:00:30 +0000
References: <20240508-gve-comma-v2-0-1ac919225f13@kernel.org>
In-Reply-To: <20240508-gve-comma-v2-0-1ac919225f13@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, larysa.zaremba@intel.com,
 dan.carpenter@linaro.org, keescook@chromium.org, netdev@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 May 2024 09:32:18 +0100 you wrote:
> Hi,
> 
> This short patchset provides two minor cleanups for the gve driver.
> 
> These were found by tooling as mentioned in each patch,
> and otherwise by inspection.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] gve: Avoid unnecessary use of comma operator
    https://git.kernel.org/netdev/net-next/c/ebb8308eac84
  - [net-next,v2,2/2] gve: Use ethtool_sprintf/puts() to fill stats strings
    https://git.kernel.org/netdev/net-next/c/ba8bcb012b7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



