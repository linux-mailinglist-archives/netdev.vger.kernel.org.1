Return-Path: <netdev+bounces-80547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2099987FBD3
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C504B1F22CD8
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA7E257D;
	Tue, 19 Mar 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjqdA+n/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676323B0
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844247; cv=none; b=GZV1WCZ/yGcw2bNjnscphiHkrqW8ZzVReTD08CzFlFa+lqQZVJripHYkKVw7UZVksu2+KUGBw35uzX9D3PJvOwkdr/5820ncAUa6C15TYk3tXSX/KdzqEHXAF47VwSv7/91Q0qD5vcoplxUVrjMBvQHohselSlTSjytOKjkdpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844247; c=relaxed/simple;
	bh=sCntC7+ZxHqXdJppT4siz4o8DCnf0Joz3Ia0Jb8cKHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bO5TiS2xot7NOJw8+lzAvt2wlaG8YC+eiK4h/xxv79DRmFTMw33f9El2zAk0grxjfJiv2PKLOmZwT3wNehOvMEQimQDNkjrnhNry9NQ1dzSuzDi1lhe9QjBLx6LG4ewwT3Zw3PmJwpq+jAl2QcyeWk8ehM5wXdlSrNJaWkwN8/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjqdA+n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34615C433C7;
	Tue, 19 Mar 2024 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710844247;
	bh=sCntC7+ZxHqXdJppT4siz4o8DCnf0Joz3Ia0Jb8cKHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jjqdA+n/qNzjYOMI9QGXlE8IE+RI4TrDeVlMoO79/pOGN5OqYF8PNt4mMFzk9nWIj
	 pSyCvp3WSGWNTwp84g4mk1UX00a8jFoCI5kDMDV9DlXXPvDkUPluJq/aVL64maZafK
	 BAuP1AEY8hOZ6FWuKJac5NwqdFvvaBpJsF9BdcackE8JfBviODwXmy0ri55Dniin1R
	 Yqfxsn3ganiAUGcCgE764a0SjK2fxDbHkSQ8vMqsuWCAQoYwU9bjBWxa0v78U6UQbE
	 WZrRC/Gm7/ElrIQ57ZleUEvg+Al8dW5czSsoP0cOmcS93gky1SUgViiPhH0UCvVS2r
	 YCSNUejkhwnow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26767D982E0;
	Tue, 19 Mar 2024 10:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] wireguard fixes for 6.9-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171084424715.5485.8366428857096365734.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 10:30:47 +0000
References: <20240314224911.6653-1-Jason@zx2c4.com>
In-Reply-To: <20240314224911.6653-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Mar 2024 16:49:05 -0600 you wrote:
> Hey netdev,
> 
> This series has four WireGuard fixes:
> 
> 1) Annotate a data race that KCSAN found by using READ_ONCE/WRITE_ONCE,
>    which has been causing syzkaller noise.
> 
> [...]

Here is the summary with links:
  - [net,1/6] wireguard: receive: annotate data-race around receiving_counter.counter
    https://git.kernel.org/netdev/net/c/bba045dc4d99
  - [net,2/6] wireguard: device: leverage core stats allocator
    https://git.kernel.org/netdev/net/c/db2952dfbdf1
  - [net,3/6] wireguard: device: remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net/c/df9bbb5e776a
  - [net,4/6] wireguard: netlink: check for dangling peer via is_dead instead of empty list
    https://git.kernel.org/netdev/net/c/55b6c7386738
  - [net,5/6] wireguard: netlink: access device through ctx instead of peer
    https://git.kernel.org/netdev/net/c/71cbd32e3db8
  - [net,6/6] wireguard: selftests: set RISCV_ISA_FALLBACK on riscv{32,64}
    https://git.kernel.org/netdev/net/c/e995f5dd9a9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



