Return-Path: <netdev+bounces-160561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4CA1A2F6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 12:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16FA77A61BF
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915B620E32F;
	Thu, 23 Jan 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEdAyUYa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85D20E327
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737631811; cv=none; b=QBv4JXBoDIsSjKe3hWDgmI+Ok/YeTMe8y+Z+zZa3AlFxozuoAojBZDPCd/sinCVGQbybqEm3h4/P3GS+IlXPqz17ac3/Q/cYokaP7JPxH1FzcwqBFy5RbFNhO4oT327OQFbZy1tOiXfcNu6jYOLlYxWO/9O9L3CVAPRQgm3lYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737631811; c=relaxed/simple;
	bh=F9MLRbHRwVzWOz5AmzBPCQbo5ZMbaoLzYPaIutsF3bQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q9DqiG4yeZrbHbY97JVuHOXQn8ViJQNjJaXlcck6FXn1HQxqIjpdD3ULrLQTfgvAPn957WBT/yAX2Au/jcBNIUMPYwzk6NuXcytE7TK9BHeJiDkGig+EQwJnatGKl8s1VpOVLYjy9NIJi/z7QfOKw7X69RWHIXgncI9dW1e+0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEdAyUYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9FBC4CED3;
	Thu, 23 Jan 2025 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737631810;
	bh=F9MLRbHRwVzWOz5AmzBPCQbo5ZMbaoLzYPaIutsF3bQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eEdAyUYalKIiD9dmd9fBqWRaQqk9PNW9/FjLCzeh5WMSpvDOBxf4srGy9jqNxsAUg
	 l5DSSlBEXLsun6ErY9ErcKTTYgOdI9xpBhgrOKUbkjtcs5j8mFDJ9pzm7jfxPGp84W
	 6gWJbkekilA5xOpAQUpjZ+qCARny4sqOIopd4CmznQf9qr1tEdM08UxLGli7VpRUkj
	 Gqk1t5R1vo/aRHQmqTakj0nZoQr/V8vslzwZpBdU6R0ru2F3JLvSn269Rw6VbSfICf
	 f6YVhPPmMCdqPrjcbJpRnGJlBvR99ue8MFcQz7JgXp7JiePnOWTQoWoV0MtxobcWmU
	 sQMKDperqbdMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2F380AA79;
	Thu, 23 Jan 2025 11:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ethtool: Fix JSON output for IRQ coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173763183451.1329285.15759964653163040697.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 11:30:34 +0000
References: <20250122181153.2563289-1-mkedwards@meta.com>
In-Reply-To: <20250122181153.2563289-1-mkedwards@meta.com>
To: Michael Edwards <mkedwards@meta.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Wed, 22 Jan 2025 09:40:15 -0800 you wrote:
> Currently, for a NIC that supports CQE mode settings, the output of
> ethtool --json -c eth0 looks like this:
> 
> [ {
>         "ifname": "eth0",
>         "rx": false,
>         "tx": false,
>         "rx-usecs": 33,
>         "rx-frames": 88,
>         "tx-usecs": 158,
>         "tx-frames": 128,
>         "rx": true,
>         "tx": false
>     } ]
> 
> [...]

Here is the summary with links:
  - ethtool: Fix JSON output for IRQ coalescing
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=c62310eb2999

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



