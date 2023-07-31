Return-Path: <netdev+bounces-22959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D4176A315
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D6A281659
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2421E50E;
	Mon, 31 Jul 2023 21:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEA657
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8EB1C433C9;
	Mon, 31 Jul 2023 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690839621;
	bh=PRrmWEyuHuopbF8hbPUb1/qL1aSJTHFeAByZIDqh4j8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X5O9OZQ2KI4zY4DrT4rCZBqTUfbfFKiU9CZLa+BjUYKDA+nasM3hJPIsao226FeMV
	 ZRFZTWpVNOhU0JywJg0Frfs8DPTesXYWjNL1njTX2cidGxEBf9QqHh6RtV7ZgVJx54
	 v4YUp2Y5JwNM0z8jGfigxMwCL7Bc310W4wZjWtTwgLs/5itu7U8QJjdXqUODCi6TCT
	 bDk+SQ5QxV1Qe6HHGCLo/ByIXp1k4fXYZLAWaUK5qQQEMYTZvbB0vuvl/3Fqd1nNvQ
	 pM4t3ZuwU2F6xZcNokMXMaZz/BMjnFYXzQTUKq/9hdenjP57wZtEAfVDP4DK6/1CVw
	 KgRuo6z/OUq0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE53DE96AC0;
	Mon, 31 Jul 2023 21:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeon_ep: initialize mbox mutexes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169083962082.7301.7945823712411125711.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:40:20 +0000
References: <20230729151516.24153-1-mschmidt@redhat.com>
In-Reply-To: <20230729151516.24153-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, aayarekar@marvell.com, vburru@marvell.com,
 vimleshk@marvell.com, srasheed@marvell.com, sedara@marvell.com,
 davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Jul 2023 17:15:16 +0200 you wrote:
> The two mbox-related mutexes are destroyed in octep_ctrl_mbox_uninit(),
> but the corresponding mutex_init calls were missing.
> A "DEBUG_LOCKS_WARN_ON(lock->magic != lock)" warning was emitted with
> CONFIG_DEBUG_MUTEXES on.
> 
> Initialize the two mutexes in octep_ctrl_mbox_init().
> 
> [...]

Here is the summary with links:
  - [net] octeon_ep: initialize mbox mutexes
    https://git.kernel.org/netdev/net/c/611e1b016c7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



