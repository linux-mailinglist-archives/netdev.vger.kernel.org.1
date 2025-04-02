Return-Path: <netdev+bounces-178919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B1A7990C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CBC1892B17
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452691F8739;
	Wed,  2 Apr 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEhohI4N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C841F872F
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637198; cv=none; b=qWPbD54YBT4zOFlUAQoUDXbosVAH0rekX+UnJ7Fa7WAu86XA3c81j+Gsg5pRkLPpB8E6gPme2r+JFfiYpWevJqcJ0U5vam096O8ZEzMK4d0HI3kO/JiV4Jvgltdfnp249BHI3rfPGCq+Oa/+0GBPCZRQ9V9OJ8QtlAhviouFwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637198; c=relaxed/simple;
	bh=+Nb4FQDfzCefg/w5EFuRYBZQVkTRA9kBJ3/02WW3eKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qRmJzpMpmZZ2xQiWIuffZtSOqBsGYQRLrRqknXCkoAn5Rzq2Opbsy6UgD9pWrVZRy3Co6BBPTqRhklFT7AY74M23no/GSeROYkLQZ30hbJVgR3PQnUWLktkp4OABhtPzwqaPzumyqOSnKUyLyh6J7ssrBNfKsQ45iyen+JFAVOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEhohI4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962FCC4CEDD;
	Wed,  2 Apr 2025 23:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743637197;
	bh=+Nb4FQDfzCefg/w5EFuRYBZQVkTRA9kBJ3/02WW3eKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bEhohI4N8nTa6vnV5Z/grobeuDXuL6evzLX4VqK6ucWxluMDB67ZRGyUICg7UItml
	 3rCySYHzPKny/8yy3PFqlvvcsVY6tsZPVBDOazvDWrTWLkcV1CF+B7UEk4sy8bfJbl
	 aET0AB4BkX2CHaKIbtzBlIoXHDxqvDtIMQq9MLTADRuFakcmE4Ubvs/OUBBwxyG+Ba
	 fa6mru+9HT9Apgoco+vX4PJKcekYnLNNPI8onK6DIYOlu/gDrJnIzQMD++3eTLhwmS
	 Ukm2YUpCY1ab7oNLYc8byTv04fwyAT7aTJHDoo8k5jhsQ5wAK/bbKwHs1V1sjwtbSQ
	 AVYbWFVfprj+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0DE380CEE3;
	Wed,  2 Apr 2025 23:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net 0/2] net_sched: skbprio: Remove overly strict queue
 assertions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174363723449.1716091.6328585786628108958.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 23:40:34 +0000
References: <20250329222536.696204-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250329222536.696204-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Mar 2025 15:25:34 -0700 you wrote:
> This patchset contains a bug fix and its test case. Please see each
> patch description for more details.
> 
> ---
> Cong Wang (2):
>   net_sched: skbprio: Remove overly strict queue assertions
>   selftests: tc-testing: Add TBF with SKBPRIO queue length corner case
>     test
> 
> [...]

Here is the summary with links:
  - [net,1/2] net_sched: skbprio: Remove overly strict queue assertions
    https://git.kernel.org/netdev/net/c/ce8fe975fd99
  - [net,2/2] selftests: tc-testing: Add TBF with SKBPRIO queue length corner case test
    https://git.kernel.org/netdev/net/c/076c70098893

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



