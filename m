Return-Path: <netdev+bounces-188210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88607AAB979
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260093AABBB
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC331FC0EA;
	Tue,  6 May 2025 03:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfpgYj0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7A290D96
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494397; cv=none; b=dIDeESdrLWsplw84nlskaM9zTeQALkQSW88oV6YtGQAdFfg1bVafrOMDVVUUXsWqG6vhcl8Guyxa+UXfMPppTHMWTl+DMIZEp7N5/P0vSefVFbyUz/Aj6lwKdYP9btxX8jfFL1WEQT0ltR8GX4Of638rMQy26Iy7hrIAMeBhKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494397; c=relaxed/simple;
	bh=6XZK1OnC0dygQh4aTwccUhfkiJCcDUYfIRNcqtiihZ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FhfmQHtxoz7Iy7yT9uxm7nnhmUR5ace9VKpPUjPDmefURDQouOANxMB/YPSYlsZMUPiY//zzwD6zuLjN29UHRXZtM/jDGJSK72qQcad7QWYxfnb8nhSujBQjrsZORKIabLzbf4ylYWlAswQ8uzYGNlm7hhyLc1c8UX6ipadmf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfpgYj0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD3FC4CEE4;
	Tue,  6 May 2025 01:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746494396;
	bh=6XZK1OnC0dygQh4aTwccUhfkiJCcDUYfIRNcqtiihZ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rfpgYj0o07s5vpjYTrmq1ghuFQ0KGCIzOUGfdwmlPVOKXF6MRcUgG3wp0W7bHc79C
	 7dR2S0AURFQsH2884GMM8bsxszLxJ9viD6ocXtU6Kpi+l2y4Ro2MeZx3WSAIrIYbch
	 wg5dmoMvMnggGg3eYcQ/q5x+DqaV+c1PpPH3RxFnlYXtRmJRyQw+WhNkXmx/VjcMpZ
	 0+X1Ah0FLcWvjWpW5yMjvXunDZc6F2XwuETlxfZliy0ReQ5K2+HVF3F8zQ88y5aEU5
	 Z/GTletC7q/Djalybh8dR3djrRJRTK5/UkyTzIkcmwDeuPGaXdwrCaqfmjg5U0LJvc
	 JIdpKNycZAdAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA6380CFD9;
	Tue,  6 May 2025 01:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] gre: Reapply IPv6 link-local address generation fix.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174649443600.1003512.18228865547921881169.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 01:20:36 +0000
References: <cover.1746225213.git.gnault@redhat.com>
In-Reply-To: <cover.1746225213.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, antonio@mandelbit.com, idosch@idosch.org,
 stfomichev@gmail.com, petrm@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 3 May 2025 00:57:45 +0200 you wrote:
> Reintroduce the IPv6 link-local address generation fix for GRE and its
> kernel selftest. These patches were introduced by merge commit
> b3fc5927de4b ("Merge branch
> 'gre-fix-regressions-in-ipv6-link-local-address-generation'") but have
> been reverted by commit 8417db0be5bb ("Merge branch
> 'gre-revert-ipv6-link-local-address-fix'"), because it uncovered
> another bug in multipath routing. Now that this bug has been
> investigated and fixed, we can apply the GRE link-local address fix
> and its kernel selftest again.
> 
> [...]

Here is the summary with links:
  - [net,1/2] gre: Fix again IPv6 link-local address generation.
    https://git.kernel.org/netdev/net/c/3e6a0243ff00
  - [net,2/2] selftests: Add IPv6 link-local address generation tests for GRE devices.
    https://git.kernel.org/netdev/net/c/b6a6006b0e3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



