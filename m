Return-Path: <netdev+bounces-138194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B859AC8EA
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0608D1C20E18
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5CC153BED;
	Wed, 23 Oct 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7eB5tiE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE4145B1B
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683026; cv=none; b=P0zDfnjQNdPuPjVLiisDTJiaAQXJwDJ3fYCusHNa5u6sG2hWyPvwMNgwZgCZQG4zPW2Gmvud0hOKRQJSIzbYIwyQdx5DzmuCghvC10mNW//UYWINAA7ghAqsHOfYR2bn3kGqzdPHaMe25HTAgaBpWJXlduPmQ1zAk9Ze+fG0RxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683026; c=relaxed/simple;
	bh=UWYQtsGXQ3wXqod9NtE+wklQ1SE8ZkD/j1RNvWI18TM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XO8MEu10o7uUnwZfUdd4SVp4c4Ckv5/M8I9R68WODikq3zrRLmGSOO3GFNHWX+WcrtJjvNfE9gBIGft2YTBt0hgrbI77jTlhqCyDWyhS+JPxc6r0AkPwNxQ4s5CpvhqPOzGJPtJ4EpJVoQBCMNVwGPrlwj7Yjs69v5RQR7U9VE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7eB5tiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B9DC4CEC6;
	Wed, 23 Oct 2024 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729683026;
	bh=UWYQtsGXQ3wXqod9NtE+wklQ1SE8ZkD/j1RNvWI18TM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K7eB5tiEQJHxR8AAOZnw7MiaEewVPztSzxEqnZ/gIJ66RObVEDwv4l5aYPnVdlVIN
	 zzwYvAiQYovMo7Q7YM3nrqa5c29kmPZy+i6NlYu0akZWaAeTW6FL/GVXKNmZoRGVvW
	 P/2InYPc8ZJm5aXsCt1LasPFhXBkAOUQgb05IaSw0OCU8MQHiCUBYkua8KxXNJD3tF
	 MQMs/auIIIOdtTEoYGzqK9iaYJ/k2XB4IIM4YoQr0DenkgF9jGd6IlgdwjpYqZB8uZ
	 egAxXoyduD0bl4fhmkpFdqd3qRBv/7MpCfR3eEL7aBOr8fg87Y9DjNaCxjeO5buwzj
	 tmF7heJwoF2/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0D3809A8A;
	Wed, 23 Oct 2024 11:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7 1/2] net: sched: fix use-after-free in taprio_change()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172968303276.1569665.8161855259469227544.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 11:30:32 +0000
References: <20241018051339.418890-1-dmantipov@yandex.ru>
In-Reply-To: <20241018051339.418890-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Oct 2024 08:13:38 +0300 you wrote:
> In 'taprio_change()', 'admin' pointer may become dangling due to sched
> switch / removal caused by 'advance_sched()', and critical section
> protected by 'q->current_entry_lock' is too small to prevent from such
> a scenario (which causes use-after-free detected by KASAN). Fix this
> by prefer 'rcu_replace_pointer()' over 'rcu_assign_pointer()' to update
> 'admin' immediately before an attempt to schedule freeing.
> 
> [...]

Here is the summary with links:
  - [net,v7,1/2] net: sched: fix use-after-free in taprio_change()
    https://git.kernel.org/netdev/net/c/f504465970ae
  - [net,v7,2/2] net: sched: use RCU read-side critical section in taprio_dump()
    https://git.kernel.org/netdev/net/c/b22db8b8befe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



