Return-Path: <netdev+bounces-164205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A113EA2CECF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 22:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670C67A535B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA191ADC7B;
	Fri,  7 Feb 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ2UJDkF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C821ACEDF
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962607; cv=none; b=Jx2KclYR10ehBi1g6UwMdwdgSK/lexnfXadf6Hm4P/dDhoJEIL8mE6lfpw0+9Hw6Afc3gEiRpn7XuCQeROXAL+0QmX1vaOwTIgfofLU6HC3Q7zL0RHbZPMUu8ORyInzAI/MaZ/s6c4epdwaKw5F6/nsavBQcRoCYuvhBgCg5twU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962607; c=relaxed/simple;
	bh=Er8FdtrS9/hS9BLMow3pB/qGm4YSDCVZyoV9EoEuFFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cBCSw9hypCbyaeWC23XFUnorp6vprnrLLLGjdPjn8WjfPj93GLFziFfM2WdeeubRx/DKwucmnZScFsxU/IOeDEptiN6AAiqy3HxugCvE0+agOQBNgaOCkVWtpZNzohePHI8PEC2Il7QwGpfGPwokuEmYtXuq92W2oUE97fqyY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ2UJDkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECBCC4CED1;
	Fri,  7 Feb 2025 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738962607;
	bh=Er8FdtrS9/hS9BLMow3pB/qGm4YSDCVZyoV9EoEuFFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qQ2UJDkF/WM7dmrzjZXnfkL21Qt2UqgZxygIMxtP0mSzcu9XG1cb9mOgIcWBP5yUU
	 Ssk91Kv5qF04yDpp6gVOvmjKhJl01puQXBzEVbSDkett0vlvhzrHcuQRoFrcZzykOt
	 yXrsR3LCjdU3HHqkOjsyRdzAeUsS4mLvWpxkqMxqE5BW9No36eOKS7x/5SCm6LmyCy
	 8HDh5VbdrNgFz8yjP6h5g1Inf/MVM2UMHfgPuZpbVHCbswBLXPn84eLSl3vFvN8eCL
	 ylwe+xg4t9B5S1feAzylL4GMNjx5WlkCDfcnMtpd3YdSuP6H61D0F/UKUJOiJOw23Q
	 g3bJrofSpPnvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA4380AAF5;
	Fri,  7 Feb 2025 21:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] tc_util: Add support for 64-bit hardware
 packets counter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173896263528.2382953.12890804961821521297.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 21:10:35 +0000
References: <20250204123143.1146078-1-idosch@nvidia.com>
In-Reply-To: <20250204123143.1146078-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 petrm@nvidia.com, joe@atomic.ac

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 4 Feb 2025 14:31:43 +0200 you wrote:
> The netlink nest that carriers tc action statistics looks as follows:
> 
> [TCA_ACT_STATS]
> 	[TCA_STATS_BASIC]
> 	[TCA_STATS_BASIC_HW]
> 
> Where 'TCA_STATS_BASIC' carries the combined software and hardware
> packets (32-bits) and bytes (64-bit) counters and 'TCA_STATS_BASIC_HW'
> carries the hardware statistics.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] tc_util: Add support for 64-bit hardware packets counter
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e7638a027a05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



