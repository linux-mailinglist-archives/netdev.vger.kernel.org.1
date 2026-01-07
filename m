Return-Path: <netdev+bounces-247561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C27F9CFBB2F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 03:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A61FE300753D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 02:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E4D23AB9D;
	Wed,  7 Jan 2026 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0E+glV2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04722256F;
	Wed,  7 Jan 2026 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752010; cv=none; b=jdMuQR7tjoyKrjcy6obljQWFjsbEJytM03Hk/Wghdu2Pl+eGflw5e9HecseFGpSqKCGTx9GGr+kT2xy5WDkcPEWxIjxOQUxuYcdQfS2ASauPhfYPPq6gIZFIqNNiemR+Sqm+oZjPkajrSbCXbzOF5cAOOuOFXUgaBOIB4jUNC3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752010; c=relaxed/simple;
	bh=FKYAyh2FGoM8Qb/Fg+jE63Hbf6E1A8DKrGYeNCaLc2E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f14I/JcVMzVryqj9053hYaZ4UTeDFowyxs65QWU0IfXe+MS05eA1PFRTaK2CmwEV/ez5ChUuJuk8ItTQrlcakMF6Nt5vezh5mvMCGdssBBGEYT5oSJx+9ufsoq/zoCHU8GJ/dDIhCkafdL3zkggGSknb5j//K0wqZOJYwHjnWgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0E+glV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4CDC116C6;
	Wed,  7 Jan 2026 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767752009;
	bh=FKYAyh2FGoM8Qb/Fg+jE63Hbf6E1A8DKrGYeNCaLc2E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N0E+glV29StV0hF+DLu0sSgVu8l+DzNBx97OrsLWESqDofI84pNBUCfjou+Ng3p5H
	 mzk3WHvEO2KZxJWzN9BDF/8t7uP6t8OWkhe7/tjNiYs+otSXE3EijOgTF67gDL+j4e
	 UieXjRqJUpH16logypWk0VJP89enXEe30ak+BBV5c2bDxN/t4wiWqGkTp1Nvzw2Wwa
	 vql5vW2kTvOe5dqugEJyg9+J1qaFBAEctaoXoiKC2p/m5VxagjB5FGOkGd6fVVzo5S
	 HiKxOEdfXvcMIGcq8Y5KgriijhHokqaxFH7pcwAR9UtcRGEHkt6cuYeWJGRh7l19Nh
	 5xVs0ZOiVbRrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78761380CEF5;
	Wed,  7 Jan 2026 02:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v2] atm: idt77252: Use sb_pool_remove()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176775180695.2201758.13304026927560608457.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 02:10:06 +0000
References: <20260105212916.26678-2-fourier.thomas@gmail.com>
In-Reply-To: <20260105212916.26678-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 22:29:15 +0100 you wrote:
> Replacing the manual pool remove with the dedicated function.  This is
> safer and more consistent with the rest of the code[1].
> 
> [1]; https://lore.kernel.org/all/20250625094013.GL1562@horms.kernel.org/
> 
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] atm: idt77252: Use sb_pool_remove()
    https://git.kernel.org/netdev/net-next/c/8e7148b56023

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



