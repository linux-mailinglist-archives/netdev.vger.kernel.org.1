Return-Path: <netdev+bounces-233749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C1C17F30
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 873F44E9369
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA11C2D7392;
	Wed, 29 Oct 2025 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne1cCEip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252823EA80;
	Wed, 29 Oct 2025 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702628; cv=none; b=jOkI0PgypnfsjBQDhDEX5F85QqEe2b1fLMTrctoiu6lcb0sUQgf8lT+6MWCeFf9fMLr/nTtorYyQQhnXdL86ujRUlPfbrYC3vROS3XfGltXyZgosfCxP38abdAmjPnCICFVxRXNIUyr5F/v7abx8dByryw3oKcEP1wN/kZGjLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702628; c=relaxed/simple;
	bh=PrFpem88thZ1FyySuV2SW8jpYJdU9Lr9HVBDbg1CIgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aWCHYubQ8vZIIKSr3jQbRcyjGbePIp1ciycrrO/AyfpCdNbf53yecI5z7RPspNo9rjxpfH49pCO9VjUsM03OAhOeJzB1SgJ6LFZV/fiTAfBYka+CO+MYh+24KDnYN/Gfm6dHPN41LPscfmNzgKnoPUFkzeQuJ+9TmBvpUqbamto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ne1cCEip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29225C4CEE7;
	Wed, 29 Oct 2025 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761702628;
	bh=PrFpem88thZ1FyySuV2SW8jpYJdU9Lr9HVBDbg1CIgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ne1cCEipfCdUez5VRONhZnYhk0+G65QYMnwF6bOUStn+eAMA0uhx/DkmianBFVonm
	 tGb+XM54RpbTVj+rnvM9FQhsAaPYdVCjMGSyJw2eXjk3NBPMlzNMrKmq0eespqZX/v
	 0kbmbvW4BhBo4ykpTjCnU/nhr3rzlRJzsbsbYaF+9r+hi7QmjQSjjkn0FiDcCoHrgG
	 NjxxmJYsg6M2oPFE95b1zjIhEqTOEkcflCVvF6fCaF+VdP999Qq/NhTEwsTj+aqrh9
	 hyCABCbkPYHHsuBlcXGFYxh/vKKlPyyvXYojsc8M8gp2U39UlYgXqoC3OWXY8frB8W
	 EHP3fKX9FGPbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEDA39FEB71;
	Wed, 29 Oct 2025 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: cxgb4/ch_ipsec: fix potential use-after-free
 in
 ch_ipsec_xfrm_add_state() callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170260575.2460121.12269249531898370369.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 01:50:05 +0000
References: <20251024161304.724436-1-Pavel.Zhigulin@kaspersky.com>
In-Reply-To: <20251024161304.724436-1-Pavel.Zhigulin@kaspersky.com>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: kuba@kernel.org, pabeni@redhat.com, yanjun.zhu@linux.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 leon@kernel.org, steffen.klassert@secunet.com, cratiu@nvidia.com,
 ayush.sawal@chelsio.com, harsh@chelsio.com, atul.gupta@chelsio.com,
 herbert@gondor.apana.org.au, ganeshgr@chelsio.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 19:13:02 +0300 you wrote:
> In ch_ipsec_xfrm_add_state() there is not check of try_module_get
> return value. It is very unlikely, but try_module_get() could return
> false value, which could cause use-after-free error.
> Conditions: The module count must be zero, and a module unload in
> progress. The thread doing the unload is blocked somewhere.
> Another thread makes a callback into the module for some request
> that (for instance) would need to create a kernel thread.
> It tries to get a reference for the thread.
> So try_module_get(THIS_MODULE) is the right call - and will fail here.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: cxgb4/ch_ipsec: fix potential use-after-free in ch_ipsec_xfrm_add_state() callback
    https://git.kernel.org/netdev/net/c/d8d2b1f81530

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



