Return-Path: <netdev+bounces-63427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8982CD99
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 16:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6118E1C2135F
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C423A3;
	Sat, 13 Jan 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfJSHNKM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733601FC1
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 15:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5068C43390;
	Sat, 13 Jan 2024 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705161025;
	bh=lYM4ypGXfWyePnUpFpW7OWPzmL6Re7pISPr3BglFZRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nfJSHNKMfMLVjulQfPgv/mCMzEl9c17vVhbP2Q2lT6Y1O3ngfhS4IQJ4T3O1us5W4
	 fVJvxVMvHPRQMkQGv4SlypAx6pT5MBrCnWZKUgZypZs9DI/PtvYIq5HoPbmRgueagB
	 S8Un2oa9D4xLy09A+z5EUWgBvJ6U560ttsYzsQNW9oQB5rZpBjgRtkhP+LDfTELKCQ
	 1iwFdDH9k3B6zvSEBNDTZcng3HwnWCKW777L5cBhr7nFDkxiU/B5fYnr8W+jItJQxQ
	 uXXvPdEFYTtL5I/Olsz8IA5dJCQnxc05tCZlh8ViHhl/zIa4pc73NR+Mn+i+lDE6sI
	 QUtWuI0EY8gvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBBEADFC697;
	Sat, 13 Jan 2024 15:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] udp: annotate data-races around up->pending
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170516102576.25764.9862128502156926078.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jan 2024 15:50:25 +0000
References: <20240112104427.324983-1-edumazet@google.com>
In-Reply-To: <20240112104427.324983-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Jan 2024 10:44:27 +0000 you wrote:
> up->pending can be read without holding the socket lock,
> as pointed out by syzbot [1]
> 
> Add READ_ONCE() in lockless contexts, and WRITE_ONCE()
> on write side.
> 
> [1]
> BUG: KCSAN: data-race in udpv6_sendmsg / udpv6_sendmsg
> 
> [...]

Here is the summary with links:
  - [net] udp: annotate data-races around up->pending
    https://git.kernel.org/netdev/net/c/482521d8e0c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



