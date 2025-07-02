Return-Path: <netdev+bounces-203531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3CAF64D4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0DD1C43E05
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6836123F421;
	Wed,  2 Jul 2025 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mceQ7nkU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230E1F76A5
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751494185; cv=none; b=kZQdq+dKOFY+sxSmg1FIHuCW11qIAtIPoplXVKsavbi1PeVzClLAegnHidJYXvLI9yzarbcvD7drPDQH6yHUQqFKZke2E3f0VqzJ/KFX3CzXLikWx6V3DcZVJRqurfe7Kzj5qizPF05palmgkLfnhbBgD85dQe6yFWY0xHMXeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751494185; c=relaxed/simple;
	bh=R9+nvk4tiX+/bXOUVHJjgftFr2UGbe5LW8Pqqkszad0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z7ySYOep279IPojgFlmnKd6dSvhVDA/6ye3U91PC9AVjh92wAVCdIoIIj9g6J/33YwicwqfsrWsKtq+Wi5zcw1K3hpB2LAWI3qkKJ2noFhhu92GYUn3y0JQNBS72Ga9tSm/AUyNOxRe6eIf7RGTIA+UFl3hdroMs+W70umCHmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mceQ7nkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32CCC4CEE7;
	Wed,  2 Jul 2025 22:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751494184;
	bh=R9+nvk4tiX+/bXOUVHJjgftFr2UGbe5LW8Pqqkszad0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mceQ7nkUkt6pbyUU8xCrew+evL81/3qHEx4rjgKjLfr+wPrgE5NYwseaaTlyL0ARj
	 2rHjeut7IcQhOvh5QS7WnJ+EtFBW7h9KpC1NvANuyBacy7kHXsU/9ZqneSOkkx/2dI
	 Jkygogi1eTmHxk47VxQJHbwFwGyJyBeP6QbMELvLCCPoJSybQsNmGGL7qiDzeQ08sm
	 mUrXunELgayLC4LagQ6gQN7pnX6WlgaX81CQNlZl5iTp9SiTZERtBKHksFmRgXTM+o
	 VaqeAlkYlpwLWU6/mbf+YgxL0sZdBNeDYJ5ufRDNimSB/nS2or6DkziCNKXphsMe0R
	 +g9kzZcETlibw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D0B383B273;
	Wed,  2 Jul 2025 22:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2025-07-01 (idpf, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149420930.880958.7971796066423025204.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 22:10:09 +0000
References: <20250701164317.2983952-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250701164317.2983952-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  1 Jul 2025 09:43:12 -0700 you wrote:
> For idpf:
> Michal returns 0 for key size when RSS is not supported.
> 
> Ahmed changes control queue to a spinlock due to sleeping calls.
> 
> For igc:
> Vitaly disables L1.2 PCI-E link substate on I226 devices to resolve
> performance issues.
> 
> [...]

Here is the summary with links:
  - [net,1/3] idpf: return 0 size for RSS key if not supported
    https://git.kernel.org/netdev/net/c/f77bf1ebf8ff
  - [net,2/3] idpf: convert control queue mutex to a spinlock
    https://git.kernel.org/netdev/net/c/b2beb5bb2cd9
  - [net,3/3] igc: disable L1.2 PCI-E link substate to avoid performance issue
    https://git.kernel.org/netdev/net/c/0325143b59c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



