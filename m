Return-Path: <netdev+bounces-22493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA316767B58
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 03:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769B51C21940
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16365A50;
	Sat, 29 Jul 2023 01:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1277C
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 01:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38B02C433C8;
	Sat, 29 Jul 2023 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690595420;
	bh=zHRAX00K8JGJW6dPGn+b56RgcIdMCopEEB6OpFLjofY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SVOJVsRo+HAth4PzRQAYGD6N1akStIDGe+gEYlXS5EzSxf3Ynz3gVOGPWhWNcjiVT
	 LQgfBSNeiMkuaH15IYZPw3LR7xJ0jjSaUGE6XKyK/JBPMWl5JyeT+euJYbg0yCBrux
	 8lPASg9hB9U0gixiNQ+q5ZmmD2lM/4IK+ByDQTaBloV410UBDt1nCzAS7GrQQzoapG
	 z0ZEoLs0GlMSXPgJ+H4Af7hqRqIP8PNsC3YhNLNGpZOyWFcWxOK2Z6VRKn5UV6hq/k
	 Hqc2BV27Gy4bSfPMUKomHgGoEPtu3R43mmny94056rq6VjOqyvmo+9GieQ1iuapJkT
	 6zf0uF4Hklt+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BEBCE1CF31;
	Sat, 29 Jul 2023 01:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] mISDN: hfcpci: Fix potential deadlock on &hc->lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169059542010.13127.16700262507413576636.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 01:50:20 +0000
References: <20230727085619.7419-1-dg573847474@gmail.com>
In-Reply-To: <20230727085619.7419-1-dg573847474@gmail.com>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: isdn@linux-pingi.de, alexanderduyck@fb.com, duoming@zju.edu.cn,
 yangyingliang@huawei.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 08:56:19 +0000 you wrote:
> As &hc->lock is acquired by both timer _hfcpci_softirq() and hardirq
> hfcpci_int(), the timer should disable irq before lock acquisition
> otherwise deadlock could happen if the timmer is preemtped by the hadr irq.
> 
> Possible deadlock scenario:
> hfcpci_softirq() (timer)
>     -> _hfcpci_softirq()
>     -> spin_lock(&hc->lock);
>         <irq interruption>
>         -> hfcpci_int()
>         -> spin_lock(&hc->lock); (deadlock here)
> 
> [...]

Here is the summary with links:
  - [v2] mISDN: hfcpci: Fix potential deadlock on &hc->lock
    https://git.kernel.org/netdev/net/c/56c6be35fcbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



