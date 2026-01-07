Return-Path: <netdev+bounces-247559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91388CFBA73
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 03:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A3C7306058D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 02:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF31FBEA8;
	Wed,  7 Jan 2026 02:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joqTmRLx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2421F4168
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751410; cv=none; b=U8ntdDex21dHh2uKYOB7asW85ZoX//K7w9jZWe9gUSxJYpMtpjt/BypZ2Uo7KSEE4rO0nJyDFC903HsIlljmDH2Ao+u4eEQzV/VgBsBtBbEvY64T6nxyAM+9jEZNTW44JJCToO/ZcOFI76gs5rkiNHH87SyldSbQy47SNfNd7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751410; c=relaxed/simple;
	bh=4/9waImsqUbwDblhMyHlU4oeoZRvgSf8Iy0+adhkq3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VXapU/rWCPTAkYr+NyHbOrcoGi3eKHqgjpuhULMs3oB77TULIIX3mjfWYVJCCBwxUq+r5rllSDGF0j/Lw0i9SOzclWdD3SV0NhM7LCfRLBzY2/ExEfH3yEP1P6eU3MA8mbKykyMgG74rPZW21uEBlg3xtWc2eoQ65dZRk95xp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joqTmRLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91877C116C6;
	Wed,  7 Jan 2026 02:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767751409;
	bh=4/9waImsqUbwDblhMyHlU4oeoZRvgSf8Iy0+adhkq3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=joqTmRLx0CyX5x2VcNSybpi8IM8KmuuIXNhAp/G9C16laKZxJNi0qmkczmQv4iFq5
	 HeNE/lyX/7mwSzJ7vQV089c8NgkY73m0Bcl9D3OcVSJm+RiKdnCUqbkKOtxMkFkGyG
	 pMd+21INn1fGAL77aRDrMGVsbeOv0E8duRxNucnXz93WyvMLmjWS4Qhz+F2NivsL0x
	 2bBkyuslwe576iGjeB/vMI6saMDmZ0+b0aeEkCby6tcCCLB8QALhgy2abOZDc2Lv6K
	 FUZKHV0sHTGliBxGXrC2xJaPFZgEngKV3pmABaYexPOMbiFlh2IBhn+54bUblL/fEZ
	 N+aud7DhaASFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8DB380CEF7;
	Wed,  7 Jan 2026 02:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: Bring back tool() to driver
 __init__s
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176775120705.2198750.9585025981630694055.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 02:00:07 +0000
References: <20260105163319.47619-1-gal@nvidia.com>
In-Reply-To: <20260105163319.47619-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org, sdf@fomichev.me,
 linux-kselftest@vger.kernel, noren@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 Jan 2026 18:33:19 +0200 you wrote:
> The pp_alloc_fail.py test (which doesn't run in NIPA CI?) uses tool, add
> back the import.
> 
> Resolves:
>   ImportError: cannot import name 'tool' from 'lib.py'
> 
> Fixes: 68a052239fc4 ("selftests: drv-net: update remaining Python init files")
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: Bring back tool() to driver __init__s
    https://git.kernel.org/netdev/net/c/353cfc0ef3f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



