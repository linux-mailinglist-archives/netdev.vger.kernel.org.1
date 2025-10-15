Return-Path: <netdev+bounces-229704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4612BE002B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D37AA4E5B81
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5732FFFBC;
	Wed, 15 Oct 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEqRMm2l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B7134BA42
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551839; cv=none; b=pUT7DF4L08NaxHLrYj+CPVJW46ABjqZVEoeA8hRSnhRjwj+44Y3EhN0O8xxK9u1k4i3YCxaNEwAdyz5fYdCruj9jG0p9Q3v9Mz3fB2Fby0ye+BL/HkQ8neezrXF0PIS8tn8NA/9N1nsuNqkd2TeA+Ll0FK9TPyVga0/eBGYauok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551839; c=relaxed/simple;
	bh=1Wdy9Qt4hWnAI2AzZ0DcrulgpkR2r+U0eDCC+Z0eKyU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sRY0Eyz8+HC62rQud7ODKZEdhRTDz6KCIYIP5j/lmkIxpBGlZBE0HEpDIGUAalWIXpvsfCDc2xQ7S79J2PbSintlCetBHuYfe6grQOsXKBXqDpzn8mDTbCPNBmvJU8s63tN2JmCdNkR+YsU+5jDAsGJYkpf8HJXDMiTAn86oaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEqRMm2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95D4C4CEF8;
	Wed, 15 Oct 2025 18:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760551838;
	bh=1Wdy9Qt4hWnAI2AzZ0DcrulgpkR2r+U0eDCC+Z0eKyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fEqRMm2lPBxZMBJVYzFG9nMxxIlQZkKiAvWJ46f7GkE0L8rk0Gwaebzv+tmaa9Zmr
	 dX0kmaAvbuYpiGj2PmjNUT28Lc0x06/Uxv8dwUOK748/uzhbCpe2aNbQjlIt/3YMFs
	 ydG5Y/vZMIQiJDEq3b9k6Ud8s77q2ghTh597WJi3r3wUjE+5JBvF8rfTnF+PO8Ipr2
	 vASbfbdNk6530w5aPg00zM974qunU1wipl2vQp8XL8GjL3vd/Fg8WxOoRBeupbrJvJ
	 Xxt0dh/W4dIzd05eLzwm657sc8Zd/S+0YHV3M664tPLmm1Vshdh+dv3uu23JZFndp3
	 VCiMIFIBXm/Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF5E380DBCC;
	Wed, 15 Oct 2025 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] lib: bridge: avoid redefinition of in6_addr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176055182350.985157.9961100375996902766.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 18:10:23 +0000
References: <20251012124002.296018-1-yureka@cyberchaos.dev>
In-Reply-To: <20251012124002.296018-1-yureka@cyberchaos.dev>
To: Yureka <yureka@cyberchaos.dev>
Cc: dsahern@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 12 Oct 2025 14:39:47 +0200 you wrote:
> On musl libc, which does not use the kernel definitions of in6_addr, including
> the libc headers after the kernel (UAPI) headers would cause a redefinition
> error. The opposite order avoids the redefinition.
> 
> Fixes: 9e89d5b94d749f37525cd8778311e1c9f28f172a
> Signed-off-by: Yureka <yureka@cyberchaos.dev>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] lib: bridge: avoid redefinition of in6_addr
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=7119f3736f68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



