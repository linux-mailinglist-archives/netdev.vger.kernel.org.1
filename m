Return-Path: <netdev+bounces-121982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E595F776
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124011F22D56
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F24198A33;
	Mon, 26 Aug 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHVBgMbo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474B198A2A
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692227; cv=none; b=QEwzSHZwTQW0JcVufkVMi/hPXvY9nZatPNl6FSGbtvLEcMwdtlUBHDbeUEuDsGEMOC5zlefV3ur6b39u2aU2BLODHn9RLWXueBaLi6iX8TWbIzUCOuf3KMOgBxcLA/QP9Bpqwx/JGp5otkpN8Yi5wNX8FoQed6MmBxuwVGfFjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692227; c=relaxed/simple;
	bh=y6Q+mCnEM3EvUOytnElnW+KefC2llvTTGKrfkmqbjAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aaRj7TesYmM/X/wZp4V7AsPFsxtfTYMAZXK9OkVGkhsbx6rmVKZPgtD31JkisamHBTECsb2NxUpOKpteYPpHHmpbu7Cjf2HIZ8oGM/+ZcEkRqPAKUohSLEtCg74Rgnlj/p4mrquzX5NsPBQGuMhbxJRKS2n2wEbvwOdSZ5A+D3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHVBgMbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366BDC582B6;
	Mon, 26 Aug 2024 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692227;
	bh=y6Q+mCnEM3EvUOytnElnW+KefC2llvTTGKrfkmqbjAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vHVBgMbol3V5XFaws9ZToKnKfbBOGm6JpC4Q8uS21yRBCfgG6HB6bqtfXflBd9eO6
	 a/DGR62Yrlh2G4Hm8foN8uFYBGiN4pJVZCugCWU13BfZz32y72hSpks8M98mDbMkVK
	 Lm24XkKMsX/eHu99Lxba5vH0FkelrxqYbqjN2CDyg6Xyyi3k2ndVNX71lgy9b6CZ2L
	 Gz7pZT1aF22aLHlBgC+7t6gq+JYF6my8djGVALbYY5J/SGQtEmSXpuFFmkhJuwD45m
	 0bd7KI7mYmzzZMpGXyBziBBMDATqsEJUX48OU7unREpN4LrZNfPTMhpLmNXtsdBYbh
	 M/GMU3oq7i5OA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E383822D6D;
	Mon, 26 Aug 2024 17:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net-next] l2tp: avoid overriding sk->sk_user_data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172469222724.73019.11923212302893793474.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 17:10:27 +0000
References: <20240822182544.378169-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20240822182544.378169-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, cong.wang@bytedance.com,
 syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com, jchapman@katalix.com,
 tparkin@katalix.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 11:25:44 -0700 you wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Although commit 4a4cd70369f1 ("l2tp: don't set sk_user_data in tunnel socket")
> removed sk->sk_user_data usage, setup_udp_tunnel_sock() still touches
> sk->sk_user_data, this conflicts with sockmap which also leverages
> sk->sk_user_data to save psock.
> 
> [...]

Here is the summary with links:
  - [net-next] l2tp: avoid overriding sk->sk_user_data
    https://git.kernel.org/netdev/net-next/c/1461f5a3d810

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



