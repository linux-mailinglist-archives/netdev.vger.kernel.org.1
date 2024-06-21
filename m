Return-Path: <netdev+bounces-105716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CBE9126B8
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985851C25C69
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3A15BB;
	Fri, 21 Jun 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVvC5KnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD057E8
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976632; cv=none; b=hElo0xU34ekRU9ABnub2eMJu913LYrf9IGKRjRwEInR+ZXUMdlFKNncKuOUzuspASCnH+e+XP/YyUuuatFPVZwdaaUTQ2xOUtcnx/fyZ3RngDATIiEK3trz1aqcleGib3HJ0iJEwg5VogxTdX+EMftdFJISeEqAj+82B7lO7UVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976632; c=relaxed/simple;
	bh=kg+9JK/vkgG3/A+SORg8QftL3nPMwNlVjUiPmtyMuj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MKanRYf1FMCwZ+TiQaWr0h1iSi4F5ytLhNvZj9bT9gbs4UjeeHgBNZCHpkHa/m3cuoPznqcQSmzP8KTSxfikq/QMg0/y9W/Je1H42vsIf/A6O68JTeypvaQpf5VEq4qu4cSf53rfEYB3O2smuQrWO1Ve9sOWfGwsGvHUjgroiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVvC5KnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2B6BC4AF08;
	Fri, 21 Jun 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718976631;
	bh=kg+9JK/vkgG3/A+SORg8QftL3nPMwNlVjUiPmtyMuj0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gVvC5KnNyb674T5JY1q60FCYM2aB8B0tVuVc9AjDhgur83cDPqGSquW8HbdRy13M6
	 2q7S3uDcjucJzmQ5Lhu5veJ1KBbDxfkVC4im/AxnfLBa5fJ5JRQBxR6ii1BVYft+UH
	 SFtenamkL3FG7pfKRfrqH2HsgrEOffddLoCgGgzKp6+LrUitO9D0l/67eH4hBCTDRB
	 CXeb3aLYHj5J0cOi42kpuFlYRxGKFxyYxCnF3zjx0heSR7ypSiU/5CDVyal04S+z4+
	 U4rz/v7og6qlcEcrAizwT8zhmbMulEaJ2emC+/KQWzHJXhEl9bDKV/WQgckQXKl3Cz
	 wCRC4nrs5S63w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C05FCE7C4C5;
	Fri, 21 Jun 2024 13:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] selftest: af_unix: Add Kconfig file.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171897663177.12212.16201811914121991414.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 13:30:31 +0000
References: <20240621021051.85197-1-kuniyu@amazon.com>
In-Reply-To: <20240621021051.85197-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 19:10:51 -0700 you wrote:
> diag_uid selftest failed on NIPA where the received nlmsg_type is
> NLMSG_ERROR [0] because CONFIG_UNIX_DIAG is not set [1] by default
> and sock_diag_lock_handler() failed to load the module.
> 
>   # # Starting 2 tests from 2 test cases.
>   # #  RUN           diag_uid.uid.1 ...
>   # # diag_uid.c:159:1:Expected nlh->nlmsg_type (2) == SOCK_DIAG_BY_FAMILY (20)
>   # # 1: Test terminated by assertion
>   # #          FAIL  diag_uid.uid.1
>   # not ok 1 diag_uid.uid.1
> 
> [...]

Here is the summary with links:
  - [v1,net] selftest: af_unix: Add Kconfig file.
    https://git.kernel.org/netdev/net/c/11b006d6896c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



