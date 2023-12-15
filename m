Return-Path: <netdev+bounces-57875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44669814622
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3916285789
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41E524B23;
	Fri, 15 Dec 2023 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHO841ds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797524A14
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 640D5C433C9;
	Fri, 15 Dec 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702638023;
	bh=YDFeBAJY7LbdrsvGV7ddjDzYM11pfdQzgbL78AcDiMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DHO841ds2lB8yYoUfsZB/QYhzg2GTRwJwSixHInMGIrMXllESSNSOpqpZNrNx+s+A
	 HX741bgc61gqG1+ank5DkbEQvwf5hsTAGc3xWuEx7KvLK8PFsiWfFg9U5HXU+aRZET
	 uRH7Drjon8+Jl2LllNXC2CrVIapSYoHwLjWsKucX3fcIYqWga20un9ShfegXU6CXY4
	 /MYgbuwytplGhoJ0diBLzJBqfJOrdwu3fCRm11U/M5YoP2eSpU8O+HvN0McBMWdMWp
	 KktmkiIJeGkacyimyZB7+yT61/KKqMeMZ22Swy2fAH0sMX5Wl3tNb43XEz64tY4ViK
	 XEeqk0FDpTrAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47202DD4EFD;
	Fri, 15 Dec 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sched: ife: fix potential use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263802328.14267.8746591210986155914.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 11:00:23 +0000
References: <20231214113038.1470494-1-edumazet@google.com>
In-Reply-To: <20231214113038.1470494-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com, aahringo@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 11:30:38 +0000 you wrote:
> ife_decode() calls pskb_may_pull() two times, we need to reload
> ifehdr after the second one, or risk use-after-free as reported
> by syzbot:
> 
> BUG: KASAN: slab-use-after-free in __ife_tlv_meta_valid net/ife/ife.c:108 [inline]
> BUG: KASAN: slab-use-after-free in ife_tlv_meta_decode+0x1d1/0x210 net/ife/ife.c:131
> Read of size 2 at addr ffff88802d7300a4 by task syz-executor.5/22323
> 
> [...]

Here is the summary with links:
  - [net] net: sched: ife: fix potential use-after-free
    https://git.kernel.org/netdev/net/c/19391a2ca98b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



