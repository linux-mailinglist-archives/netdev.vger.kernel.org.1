Return-Path: <netdev+bounces-164812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8827A2F38B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0643A7069
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5043324FC16;
	Mon, 10 Feb 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvxSY/wv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE091F4609
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205012; cv=none; b=tpCdOTcEsz+m+iR2/Vysm7n6MJucYvKVckOadKmNabQKbRNTf1wItro97q3QsP95AuOcRnatztdMMC3M7rdynY5Pqwzzsb/mATaFU7SASN93dNWofFu0cs//nMHo/tsV9kumYcz9ilz0HUDInpuUj0N0HVqIoDZkOq0Z2FOcd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205012; c=relaxed/simple;
	bh=wOYJXJ/igv9fksm1Sxmz0rOUQJwvsuzkWePvRHobmZg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PeUw1RT58Tg5dpTMw53DyMI6ec+0ZJpzm6ySvsoJkPJmijQK8WPNFEjrrhnpslSBJdRSXt9jOMDKU5Y0RvJ855ZTpplMcrRg9206mB1fZnxbS2Ras7P3xRPRNWOSYYDQ2OqDdpXHo/CmPy28dfSlibeGwJWO2NDDdW5QtbXDdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvxSY/wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFCBC4CED1;
	Mon, 10 Feb 2025 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205012;
	bh=wOYJXJ/igv9fksm1Sxmz0rOUQJwvsuzkWePvRHobmZg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MvxSY/wvA1UqI6DuNONBSAZo2MYuxIZmo1vxtIZYWg4hStMfocBVvk2LCY/PNubLs
	 qSjtjrF3pyh8hfsRIgvfJexc6BoSb0WZOvO+8iJyodQEuJfALXv43cVqtuLyusJoSX
	 kh3UaMTsSdhIU3V2FlVIhWsdsU65FeGMG091pS115mcRwFxFofzOCr58f+JkaDNRnl
	 uOiXWmtGB53ziKRYeln5Y/T1uJ3A/76/ZyhS5XiCD+2peEqItz/PyO+Ps5tliUzv8L
	 /vkTioPOyoQZPGu0WJtCCHppAqBPFARA7hx9Zqrrt0zCmGHUAb5/aCXW32yZy1iM81
	 IV4mzlCQh36Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF67380AA66;
	Mon, 10 Feb 2025 16:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] eth: fbnic: support RSS contexts and ntuple
 filters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173920504025.3817523.12316203538556886634.git-patchwork-notify@kernel.org>
Date: Mon, 10 Feb 2025 16:30:40 +0000
References: <20250206235334.1425329-1-kuba@kernel.org>
In-Reply-To: <20250206235334.1425329-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Feb 2025 15:53:27 -0800 you wrote:
> Add support for RSS contexts and ntuple filters in fbnic.
> The device has only one context, intended for use by TCP zero-copy Rx.
> 
> First two patches add a check we seem to be missing in the core,
> to avoid having to copy it to all drivers.
> 
>   $ ./drivers/net/hw/rss_ctx.py
>   KTAP version 1
>   1..16
>   ok 1 rss_ctx.test_rss_key_indir
>   ok 2 rss_ctx.test_rss_queue_reconfigure
>   ok 3 rss_ctx.test_rss_resize
>   ok 4 rss_ctx.test_hitless_key_update
>   ok 5 rss_ctx.test_rss_context
>   # Failed to create context 2, trying to test what we got
>   ok 6 rss_ctx.test_rss_context4 # SKIP Tested only 1 contexts, wanted 4
>   # Increasing queue count 44 -> 66
>   # Failed to create context 2, trying to test what we got
>   ok 7 rss_ctx.test_rss_context32 # SKIP Tested only 1 contexts, wanted 32
>   # Added only 1 out of 3 contexts
>   ok 8 rss_ctx.test_rss_context_dump
>   # Driver does not support rss + queue offset
>   ok 9 rss_ctx.test_rss_context_queue_reconfigure
>   ok 10 rss_ctx.test_rss_context_overlap
>   ok 11 rss_ctx.test_rss_context_overlap2 # SKIP Test requires at least 2 contexts, but device only has 1
>   ok 12 rss_ctx.test_rss_context_out_of_order # SKIP Test requires at least 4 contexts, but device only has 1
>   # Failed to create context 2, trying to test what we got
>   ok 13 rss_ctx.test_rss_context4_create_with_cfg # SKIP Tested only 1 contexts, wanted 4
>   ok 14 rss_ctx.test_flow_add_context_missing
>   ok 15 rss_ctx.test_delete_rss_context_busy
>   ok 16 rss_ctx.test_rss_ntuple_addition # SKIP Ntuple filter with RSS and nonzero action not supported
>   # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:6 error:0
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] net: ethtool: prevent flow steering to RSS contexts which don't exist
    https://git.kernel.org/netdev/net-next/c/de7f7582dff2
  - [net-next,2/7] selftests: net-drv: test adding flow rule to invalid RSS context
    https://git.kernel.org/netdev/net-next/c/23bac399104c
  - [net-next,3/7] eth: fbnic: support an additional RSS context
    https://git.kernel.org/netdev/net-next/c/260676ebb1f3
  - [net-next,4/7] eth: fbnic: add IP TCAM programming
    (no matching commit)
  - [net-next,5/7] eth: fbnic: support n-tuple filters
    (no matching commit)
  - [net-next,6/7] selftests: drv-net: rss_ctx: skip tests which need multiple contexts cleanly
    https://git.kernel.org/netdev/net-next/c/d2348b4bf748
  - [net-next,7/7] eth: fbnic: support listing tcam content via debugfs
    https://git.kernel.org/netdev/net-next/c/5797d3c62db8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



