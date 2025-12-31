Return-Path: <netdev+bounces-246416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD1CCEBA0D
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 10:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3839C30051B4
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168231578E;
	Wed, 31 Dec 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgfe1sg1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F9631197A;
	Wed, 31 Dec 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172032; cv=none; b=rR2nD5W4LfkipIU3302yympch+NO1jOAQwv1IBHDf8hnn3JWwdP7i1W318bP+Pe0/TM+TvCK7QP9bo72Dqw+lfasdqk6ZylKc7t8qNYrGVG4qVVObTHoVysNKsGks9996edwwC7taUp4Bld3r9NwxpGkvM6R2zHjoov2IiNwCQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172032; c=relaxed/simple;
	bh=lOgciEwbkpTKIdEU7yCJ/i6wLIBTiKqjiAAmIMfDmog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cgOtrzHeTEKwF8rzc0fOiRDuPIb36XC0ItjEcinTfMbwLeo9lLeOa45Oz1TUrAkII8hN/t2WAqKoUFreNWN9xZUP+0eUOY9i+rn/slTOSrzuSJofQuJKXQemvX6TyeBJ9S45QTDzqBcyl40FxB5hO+sDJi1xT8NvA1zyAEjGAC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgfe1sg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0BBC113D0;
	Wed, 31 Dec 2025 09:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767172029;
	bh=lOgciEwbkpTKIdEU7yCJ/i6wLIBTiKqjiAAmIMfDmog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tgfe1sg1YNRtcUhvLbNcu9dleIRCb8ph/MaeJdPfuarUBJAlzYRCaoRMS8GKlQCeG
	 /J+0PgY9rx5bvBi/NoXxtg9iAiROmFZKTFG6jQ+7oxX/wwp/8b6xuBRp/GMp4BvBIC
	 28T6JdyB+h1i2aYJm41DSVkK5JK2leQ88S7516kAi8q1VUOeQl8mVLf8awQuCsWlwK
	 L+DRSMTutUFY+34x9q0KOMCEI+SPkmDltK8jOuSWgaNkQ8hjRj2VHGxNFCxFlKxRVJ
	 /rVJs3/KR4pKei9PtgpAKXRZJSyt0nv84lUDEhRUY3X1ByRd8ICZHvzyaMaoWGwzbA
	 fyU4SMZssOXtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C55C3809A31;
	Wed, 31 Dec 2025 09:03:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.19-rc4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176717183104.3470564.12437833505978444609.git-patchwork-notify@kernel.org>
Date: Wed, 31 Dec 2025 09:03:51 +0000
References: <20251230143959.325961-1-pabeni@redhat.com>
In-Reply-To: <20251230143959.325961-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 30 Dec 2025 15:39:59 +0100 you wrote:
> Hi Linus!
> 
> The following changes since commit 7b8e9264f55a9c320f398e337d215e68cca50131:
> 
>   Merge tag 'net-6.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-12-19 07:55:35 +1200)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.19-rc4
    https://git.kernel.org/netdev/net/c/dbf8fe85a16a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



