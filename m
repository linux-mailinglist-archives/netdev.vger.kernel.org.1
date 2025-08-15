Return-Path: <netdev+bounces-213914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8F7B274BB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADF91CE0FD0
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196D1448E0;
	Fri, 15 Aug 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVRzB6Xw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFAA81ACA
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221397; cv=none; b=jKHkpvMoBGk1UIHwXX1FfcL7X2wmMh0sNYKJGmSMebiRuQV60++DOYd5QqOEfkZ99s1mTKGrwXIDEtCXxCTghp4dKtbkBPNUHb6M8NaswtdHEwFWGSkuxazna4PS7YvArKzNTBLGskzRz9uYaxdOmnRST/N8aHiXogRV1ILmRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221397; c=relaxed/simple;
	bh=4im6gS12rESCM9ktaUtVLtDJbxkkUSYNbw+Wep9wRdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iI/iq067vFlip4vXtI8Me9k7uMRQMZG0SICv5XrkeT0pCxKGKJsDLrjKI1CMS0CyOkGTDOmL/Rz4SURdVS3c0MKaAJzQ17NVJfelB0nHkvfSrJkqxzK2GHykPy6et+xUqIcVLM8kmdQejGmrUW5tveew7ElUrBw/9SzgqTzTQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVRzB6Xw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A49C4CEED;
	Fri, 15 Aug 2025 01:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755221397;
	bh=4im6gS12rESCM9ktaUtVLtDJbxkkUSYNbw+Wep9wRdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UVRzB6XwLyu/iY4Z0HL2hInRvi5X71KPBF6EElaKk4sIiHpRackpkJ/iW0w+GTMu+
	 r/qi+GFw8AtCpIQsW3nFpjGkUPOLHaV2t0Em+ZhRg7vjbYR72cW2vzH8eSlkRi9dxA
	 Me72MZmmv8o8yFTxX9DjGb/yulhE1TWQ+19PHmZJ4dFuoROoO2LP53GFagtLAFtcv+
	 G2vpO420MKW9cd357Z+z6LevVnJhj3baCpVZCGTLIIhpNS9MoxM5A0s4OsXn1U2/py
	 eschEA7rt5x5xmZp/4U8NUN8RIjQJX35UVvFS8ijbp46O1zqvx+sKKhXLZqjYvs7Nv
	 iJiffYmEa74Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BBE39D0C3E;
	Fri, 15 Aug 2025 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 1/2] net/sched: Fix backlog accounting in
 qdisc_dequeue_internal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175522140825.510661.16232160646168789853.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 01:30:08 +0000
References: <20250812235725.45243-1-will@willsroot.io>
In-Reply-To: <20250812235725.45243-1-will@willsroot.io>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io,
 victor@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 23:57:57 +0000 you wrote:
> This issue applies for the following qdiscs: hhf, fq, fq_codel, and
> fq_pie, and occurs in their change handlers when adjusting to the new
> limit. The problem is the following in the values passed to the
> subsequent qdisc_tree_reduce_backlog call given a tbf parent:
> 
>    When the tbf parent runs out of tokens, skbs of these qdiscs will
>    be placed in gso_skb. Their peek handlers are qdisc_peek_dequeued,
>    which accounts for both qlen and backlog. However, in the case of
>    qdisc_dequeue_internal, ONLY qlen is accounted for when pulling
>    from gso_skb. This means that these qdiscs are missing a
>    qdisc_qstats_backlog_dec when dropping packets to satisfy the
>    new limit in their change handlers.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] net/sched: Fix backlog accounting in qdisc_dequeue_internal
    https://git.kernel.org/netdev/net/c/52bf272636bd
  - [net,v5,2/2] selftests/tc-testing: Check backlog stats in gso_skb case
    https://git.kernel.org/netdev/net/c/8c06cbdcbaea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



