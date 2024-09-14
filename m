Return-Path: <netdev+bounces-128288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6CC978D55
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D59287727
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910BC3C485;
	Sat, 14 Sep 2024 04:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDbkdmcW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C52030A;
	Sat, 14 Sep 2024 04:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726288240; cv=none; b=s/R7JsAfsj8GedrW5fpGPIUapKnedRGiVOvhj0LFJqaDOjJoixBVKh3YN8xofJvsil1YsORSCGEYvHNldxJZovz4+5AMd980U9UgBHKe0F+dBys4UH1apBP3OOLEjG+FcLRRK7ngFBPpgs9lAbZtSZgnM/b+pprx7PeSBLKZyGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726288240; c=relaxed/simple;
	bh=0VAJUlyyOl//hCHp1YA51Ng2zstRM71mbjnKyr5lvc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N9QImi1xiElwLh+QjrffsP2kA503jhqRrCFSM6PzvHpCrsqW1XmErv/kAVyI1B+PRQ5eK3WdWB/Gr019q29wrS9mjzCdBxmwY9IfdOJ2evV7q8uj7Lgx3N+p9GXxn/WTvAsxV36Lb3bbYDBtItBQl0iiV5ecNMi1eOXYp9cMo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDbkdmcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F2BC4CECC;
	Sat, 14 Sep 2024 04:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726288239;
	bh=0VAJUlyyOl//hCHp1YA51Ng2zstRM71mbjnKyr5lvc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rDbkdmcWu8VnJDOm8kM7223PCtVm2o58dfh37MLzB89qYUYBHR1ARkU5lnnQXVjaD
	 AXFTmQmeqjEXPwX0ExnUYO/vFbxtvJPLNKbMvlUg/JuBfKQAzVmgKGaTsYJlOq5jN4
	 NuD/02WSl/4gjzEEnSs7CbuSG0T5EHMmXRo2Zw5u1MtkpGjxLYXbyY+AgBXvh8iKS8
	 5Qob6PC1F5OOuSFEt8KLv8JUrLfj87mBYC7gv2Q80YO86Qh/4KXFgtXnWdQMdeRsx7
	 rLO/Wb2YqCqlPKdyN2MO6hFs2E2M0bJR+MFxOdE2ChjWNN0kTXXVO7t6EA4/Jvqjit
	 lSKwNFGA6nuyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF33806655;
	Sat, 14 Sep 2024 04:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: Enhance error messages sent to user
 space
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628824101.2458848.15881827170447348187.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:30:41 +0000
References: <20240910091044.3044568-1-danieller@nvidia.com>
In-Reply-To: <20240910091044.3044568-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 12:10:44 +0300 you wrote:
> During the firmware flashing process, notifications are sent to user
> space to provide progress updates. When an error occurs, an error
> message is sent to indicate what went wrong.
> 
> In some cases, appropriate error messages are missing.
> 
> Add relevant error messages where applicable, allowing user space to better
> understand the issues encountered.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: Enhance error messages sent to user space
    https://git.kernel.org/netdev/net-next/c/716425d6f3fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



