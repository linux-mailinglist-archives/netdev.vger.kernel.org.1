Return-Path: <netdev+bounces-204779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7310CAFC0BF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E81AA1B17
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0A21A23B0;
	Tue,  8 Jul 2025 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeoRX2xs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C0189905;
	Tue,  8 Jul 2025 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941186; cv=none; b=K27tHRCZMJdeFW/Oj7YwkKhNvz4siEQX1ZZSuZ2FHstcZG2uD2lmyu2vp/NRjFx/9rXZQFOP1pY0nJA9R2cUQI15Id6dVdxQBnTLoXn+Rt811WzpQ7DisrVoY0dq3L0kJtNJFKvhlopimYy/7tLHnyxqKKsy9J2wQrqWV9x8Qvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941186; c=relaxed/simple;
	bh=9+HnSal8N1zuW58HzfxZ9LaUaA6ca/JNqrtYdhLSsRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=REwCWo1W5V+QyoylAMF/ChHDIdZMyNuq3Qaa/MgSJ33PpNIyEGpKGwGBraNjjheNxIsDaAF+BENLyAuCR0zSD7Ldlmmc3qw9+Y0ITW/1rtGDbDEd57i3T2n1sseyrzlvVPctSooxfGyxHs1U7eu0A6f8DhvzJb3Nb4GQkEhd2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeoRX2xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E911AC4CEE3;
	Tue,  8 Jul 2025 02:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751941186;
	bh=9+HnSal8N1zuW58HzfxZ9LaUaA6ca/JNqrtYdhLSsRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YeoRX2xsNEECylaei1LV7isMXmddySbXm7mLr1+39ScoHccrigZzt4wFnTrJaZvaD
	 Gcl7uWhSbEH8uO16w2KfxhwVifhJBsUuRIzpOyV8bX2kkq15NjoOOO7SMXtSk7ujDD
	 FxP7clE7Plh3sNThDiehPng3dEqTKAD/LFMfYnWfp1ghEZJNGttejekEt4tos3EEVT
	 TZ7F29Fs1fW66HRByhyagpSp6+FcWXk081CGYoqCfrYny0RyuZo4Ayj7NpJriTOS4+
	 1FfxA75SGos1tUHOBbslr+1HHdOFU8jp1FYFllALhIMhnbpJqP0n7x6RDzDBJkA9hs
	 7DXdlN90cA8Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3452338111DD;
	Tue,  8 Jul 2025 02:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-07-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194120901.3546943.11525804926747263104.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:20:09 +0000
References: <20250703160409.1791514-1-luiz.dentz@gmail.com>
In-Reply-To: <20250703160409.1791514-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Jul 2025 12:04:09 -0400 you wrote:
> The following changes since commit 223e2288f4b8c262a864e2c03964ffac91744cd5:
> 
>   vsock/vmci: Clear the vmci transport packet properly when initializing it (2025-07-03 12:52:52 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-07-03
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-07-03
    https://git.kernel.org/netdev/net/c/80852774ba0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



