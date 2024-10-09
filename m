Return-Path: <netdev+bounces-133633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5087399693C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832DD1C20DB5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F1192B88;
	Wed,  9 Oct 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLy4gvC0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DB17CA0B;
	Wed,  9 Oct 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474628; cv=none; b=SVV9H50VOxjSIOwNRpOryVK/HRWvMWuBAhPq7zJZ/l+0LrL6SIoKJCpnKGU/6vQTBg9BUIWnJvHOXLoIuymVFTw/rmFk2XjJD/6nafiop+AdDw6LhYJv8wO87iRuHQqOi+BpaxFbN9nzY+QS5yueSCAYMIxP2xmPpSOfe0/H8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474628; c=relaxed/simple;
	bh=8SpSkAQXt8/Y0AoRKjq2t1EbQ2OqlDE5NLaKt+6o17w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sYARfnukFUtGQkz62eN6dYwO80s33N1XM5uIsgEN0dHlkuHXvI7G8Mvt7FyFMGPT6y8FSiozbxyrcJk3vq1lepMGOvnNbuRm5I5/o0kXUPJqf747JIceYbILWDa9EvhCK6ayXbhMRqmWvY44tk+wiixsqIQMnQJkyL/cAVm41B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLy4gvC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39299C4AF0B;
	Wed,  9 Oct 2024 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728474627;
	bh=8SpSkAQXt8/Y0AoRKjq2t1EbQ2OqlDE5NLaKt+6o17w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YLy4gvC029RBeDGFRJBM1/qUll9RELhA3qOb81JFmCVTFfvmxccCGJzO5vXjGwAki
	 Sxwlv9lwZ9yWn/AA5XerxwWeLhM90kbSZKDmIQa962xa3tvAmpYwQPfyNwhFC9+Y3S
	 TLPqKrL3u9LWvV8RCtwBFyx5rk3QPozuk/vYv2oCr6a2cv2UVzrXxq8TSBg4goI3Ub
	 J7P7D5srcZsJ1iohEJBseipuW9RUjsEy8/JCivWndNlTjMxQKkeHfAn9jzDUFRP6+H
	 H85FzAIh8HKsrrqXSnZivpUZeH5YEsm4wSgnHcyj9wb/emLdrDWQ2lUs/3HzI6WMv5
	 McScnuq7ESYhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0DD3806644;
	Wed,  9 Oct 2024 11:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: amd: mvme147: Fix probe banner message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172847463150.1238216.2545446450939320645.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 11:50:31 +0000
References: <20241007104317.3064428-1-daniel@0x0f.com>
In-Reply-To: <20241007104317.3064428-1-daniel@0x0f.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  7 Oct 2024 19:43:17 +0900 you wrote:
> Currently this driver prints this line with what looks like
> a rogue format specifier when the device is probed:
> [    2.840000] eth%d: MVME147 at 0xfffe1800, irq 12, Hardware Address xx:xx:xx:xx:xx:xx
> 
> Change the printk() for netdev_info() and move it after the
> registration has completed so it prints out the name of the
> interface properly.
> 
> [...]

Here is the summary with links:
  - net: amd: mvme147: Fix probe banner message
    https://git.kernel.org/netdev/net/c/82c5b53140fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



