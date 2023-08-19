Return-Path: <netdev+bounces-29029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C07816D3
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D631C20C6F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FEBA3F;
	Sat, 19 Aug 2023 02:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7063C
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2EC4C433CB;
	Sat, 19 Aug 2023 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692413425;
	bh=PhfRIEz1S0Jg3MoXhK7iolerhlMr6r0OudB70E+1gig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DWj0hq7bu3Ta8B8oZZlzC3xIGt+yDTvVP/8iknwRlf88URPk+8p3j7jM34IRUQsmF
	 3yZFzfzOzvrcwfl4C8utpNYOn/1HEyN9Dy0m5nhA7le4LR5xeqYYDgmym+Flruuek2
	 dnNPLBgoKVIcqyiXjAEjersY3SD/MOENM16YKX3CQePzt9nwWzxrIUgwZ+i1Rmu4BX
	 5Bq0/TfbueK/L/Kr4+EcXWY/0PbrK0MfLWpHXtV3iUreSQRCKztLVD9ErAxIU0fHcI
	 GTcAP57ZqvB4ptTJ0f0YO3YtW0mOZ47si2i+7k1EAD64acrcpl32qaFWJh+FsRgkmQ
	 ipakJx94WItJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8D00E26D34;
	Sat, 19 Aug 2023 02:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipvlan: Fix a reference count leak warning in
 ipvlan_ns_exit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169241342488.21912.14677082854350120327.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 02:50:24 +0000
References: <20230817145449.141827-1-luwei32@huawei.com>
In-Reply-To: <20230817145449.141827-1-luwei32@huawei.com>
To: Lu Wei <luwei32@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, wsa+renesas@sang-engineering.com, tglx@linutronix.de,
 peterz@infradead.org, maheshb@google.com, fw@strlen.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 22:54:49 +0800 you wrote:
> There are two network devices(veth1 and veth3) in ns1, and ipvlan1 with
> L3S mode and ipvlan2 with L2 mode are created based on them as
> figure (1). In this case, ipvlan_register_nf_hook() will be called to
> register nf hook which is needed by ipvlans in L3S mode in ns1 and value
> of ipvl_nf_hook_refcnt is set to 1.
> 
> (1)
>            ns1                           ns2
> 
> [...]

Here is the summary with links:
  - [net] ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()
    https://git.kernel.org/netdev/net/c/043d5f68d0cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



