Return-Path: <netdev+bounces-126463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D406A9713BC
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC15281175
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F08C1B5EAF;
	Mon,  9 Sep 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc0GFiJ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF331B5EAA
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874230; cv=none; b=pc0FzKn3lZR7NUoBR2Z7nIuL2dsTq3kH8g+xv2hQ53UnbYD3h83bHNr3cVw/Ylty8WMpTveFYSER1bMv/Hat936PSXV64MYWUR94ehiWfK2ldC+1g6IBXtsWPTh+lF10aBsAicsRoxgQuppEOOV4csLLFGxOjBDwSq8TBOutCnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874230; c=relaxed/simple;
	bh=DX7JN+DYwB5WonQmhjg2d9b9SZYAydzj6pgh5kohPA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=urRBo4DtchYbdO+6P7V+1bUe5XUZqtauqX0iXnvl0blAdq79EaH5ua6gu9OzvAlUpJ1PLHBDmoDI5KUuj0c4681cDr4E//PDxJFvX84lVsg/Pbxz9stMxh/2aFDDQ8U+HcigvUtyJi7BnBLbmF6vhhln4DguM7r4b8C/RybIvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc0GFiJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734AAC4CEC5;
	Mon,  9 Sep 2024 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725874230;
	bh=DX7JN+DYwB5WonQmhjg2d9b9SZYAydzj6pgh5kohPA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oc0GFiJ9fDjWyVrFH8BbeHIDJgq0OgHXgxcVi5TM8lzLi+H91xmPQ/gIwemLKezoz
	 Nf1VqnPBau1aQTudLSczpzmBh0My4dbJsR4PWbZ3BB4N40Op1f1ZeR46IIddJEoazc
	 kfGVG3zZaHpKqoinxSP48eU8dEzB9jYlDlCfvoMSEwNH/UwE649Zn12ovoVF1NgXrE
	 O54DVcRbbratSs9PtM0EilHXUF0BsnTKIcF5U0wSdEx6JwwFF3b2EKGHz7J+VFm6O0
	 r4C3tkJvo1cmZB+kdvge0I27IVMUNjm0c4vGwXwYfPdWTmvcXm+CVP6/Xkm6sI2pHc
	 +Hj0IdwHozdIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2C43804CAB;
	Mon,  9 Sep 2024 09:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: remove seqnr_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172587423152.3396102.11022055395407789320.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 09:30:31 +0000
References: <20240904133725.1073963-1-edumazet@google.com>
In-Reply-To: <20240904133725.1073963-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 bigeasy@linutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  4 Sep 2024 13:37:25 +0000 you wrote:
> syzbot found a new splat [1].
> 
> Instead of adding yet another spin_lock_bh(&hsr->seqnr_lock) /
> spin_unlock_bh(&hsr->seqnr_lock) pair, remove seqnr_lock
> and use atomic_t for hsr->sequence_nr and hsr->sup_sequence_nr.
> 
> This also avoid a race in hsr_fill_info().
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: remove seqnr_lock
    https://git.kernel.org/netdev/net/c/b3c9e65eb227

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



