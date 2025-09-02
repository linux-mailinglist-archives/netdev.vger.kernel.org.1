Return-Path: <netdev+bounces-219345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6007CB4106F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB841B61F4F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F124E4BD;
	Tue,  2 Sep 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFDTDrik"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBC1547C9
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854020; cv=none; b=qeis7z53QLLFAe3NqAgogGy+QuqnH6aWb2NzlctsY3OCudXCNS7CEtCXb/ODRSb00pAvnYNj1q4wgx/UJpoSkTt+Eysjg7MYLeQIEENBybK+2bGHugbYfROfapWAM0E9g7NI2ft/hmeOfSsrZY+Jl1KoLfgFzE4WxxGNGzzo9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854020; c=relaxed/simple;
	bh=5IAURzDiqU9vaEApJwXs9+54UWV3lGRgHfD0IzHGwDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P5/OHfQgPnX8jWqMog9ku2EcCVlbDk64AZ61TdAFGI3fwGq6eBHTSxdsJz1R8SM+LPyXzXBl3prHe5hf0hJ14sN9MjGhrm5DxscVElHg+EfOk4XpE3C0KL0MAyHQyOoh+lOGN9ynr9Rb3RL2P7uIC46N9jomCtYsToXLR1+Tn0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFDTDrik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CDFC4CEED;
	Tue,  2 Sep 2025 23:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854019;
	bh=5IAURzDiqU9vaEApJwXs9+54UWV3lGRgHfD0IzHGwDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WFDTDrikYCeNgXkc6FoRUxqylq4o19vDDqvUEAkAY9z/a8UtwdeOEIUYb/fF9e2Tu
	 fgOzJgA56bJU21SDNI30hW1ogKQnLhswl2c8O477wmFkzR/Upv4mMmrAtsXVdBtNrI
	 KQbaKHUQ7Kpi8bqgLKBQobOaQvP/6XgGails0xc3Wx87BFDLA9z7kSXEdwpBRbt2YT
	 ifn5goluJKxcVxe0QewLig4YcT2oivvo7OlfKKm9qHfgfxW998WqVPRAfCPlFoYCuL
	 Wq1WkkBe2Gl8AFeInuX/m5yWY4+nEFAzr/DgpEcEVcalri4ZMk+xj8Zx0HVbxWA60Z
	 0ax6u78S0xq3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB192383BF64;
	Tue,  2 Sep 2025 23:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net_sched: act: remove tcfa_qstats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685402449.461360.3598166251805827403.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:00:24 +0000
References: <20250901093141.2093176-1-edumazet@google.com>
In-Reply-To: <20250901093141.2093176-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 09:31:41 +0000 you wrote:
> tcfa_qstats is currently only used to hold drops and overlimits counters.
> 
> tcf_action_inc_drop_qstats() and tcf_action_inc_overlimit_qstats()
> currently acquire a->tcfa_lock to increment these counters.
> 
> Switch to two atomic_t to get lock-free accounting.
> 
> [...]

Here is the summary with links:
  - [net-next] net_sched: act: remove tcfa_qstats
    https://git.kernel.org/netdev/net-next/c/5d14bbf9d1d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



