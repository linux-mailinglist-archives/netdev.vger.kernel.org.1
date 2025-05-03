Return-Path: <netdev+bounces-187576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56291AA7DF7
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 03:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C451BA1E74
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 02:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60DB76025;
	Sat,  3 May 2025 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3jZxPYy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232170838
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746237589; cv=none; b=RlpIZH7PRKYScCCNrIbpfOkJ9uAAYWX8TlLjZdODKb8ijLsrKp+Muw0UShWhNNIJ7flD/nPybOR9vWogG+9SbI5z3ovwHkY7f/Fa/KpOkwupvSRHGeOPi0C4W/2XbqaGFRAK7SSKhc81BInnDxllkO1jfELRe6Gjy+EI8aHFiyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746237589; c=relaxed/simple;
	bh=lMjrlwQXtyy/E4duRbopRAL4nSfEtAcGB898KbDO9ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C7gB/iByJ8Ta7OHf0aZDwMVvomMB1SEyFUuOIwSKKui3alfDm/KmFy6Di5GFRwP3z4hZwtY/aXgaWAVObJl/7pK/ttWLCsZe59UqWrZh5TPBAq39Qt+LYK3NmC2Emg0tbvApToA0Vi9tL2+QFVTa76885hKwTu6DYriYTV3fM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3jZxPYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F92C4CEE4;
	Sat,  3 May 2025 01:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746237589;
	bh=lMjrlwQXtyy/E4duRbopRAL4nSfEtAcGB898KbDO9ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f3jZxPYyYbuYGf2DvawRYBJ7Q8wSRz0VMfxsaHzOGQfgXhuZNNzvIWAcbq5RhepUj
	 ZMZ7GliMs0ZWB9x4jE1wUA3GCXl7pB6UhpoTAL8EMBEUhkUUM8dlnhNt2rWKrQzGzO
	 X03uMGA5d5gN5p5d1vpFujN/rfCY8M5IYr4sgqkxeehaonw+FzfOko8+0bVPPDm2qQ
	 C6My9dxWbex4IWgUn4FRlpOMJtcXbtpuC12FpcDRV6ZaDAE6pnFIodIgfIN128hjgG
	 62CNYULJoeh6Ku9QidPe6VACHaT3VsWOf3z33knSB+9L/Yo3cf+rSCap1ld4uogw4J
	 pnz1iAAnZUQRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD2380DBE9;
	Sat,  3 May 2025 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv6: Restore fib6_config validation for
 SIOCADDRT.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174623762825.3776668.3030290038035668479.git-patchwork-notify@kernel.org>
Date: Sat, 03 May 2025 02:00:28 +0000
References: <20250501005335.53683-1-kuniyu@amazon.com>
In-Reply-To: <20250501005335.53683-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzkaller@googlegroups.com, yi1.lai@linux.intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 17:53:29 -0700 you wrote:
> syzkaller reported out-of-bounds read in ipv6_addr_prefix(),
> where the prefix length was over 128.
> 
> The cited commit accidentally removed some fib6_config
> validation from the ioctl path.
> 
> Let's restore the validation.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv6: Restore fib6_config validation for SIOCADDRT.
    https://git.kernel.org/netdev/net-next/c/586ceac9acb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



