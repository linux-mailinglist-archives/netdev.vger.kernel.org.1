Return-Path: <netdev+bounces-30843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F7789337
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0869C281A0D
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CEC37F;
	Sat, 26 Aug 2023 02:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850917FE
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04A8AC433CC;
	Sat, 26 Aug 2023 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693015228;
	bh=e1sEfa1lkdx0G+VBvkoozZhSD7w6XNtJpi0T25RvFc0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XLHRcUyES77qfBzviaaBqpGxDx1elwUPQ8GQeED8UrF/z0URP5+Ixt76nbHh4WKvs
	 8qT5kgZljeOT6T1/DMhRrP/c+1gYleUacEahHo+/wjfHeUqMxA0SLb4mW0lZops5QS
	 VLniSmN13J8za8a1IGD90cin19bbZoSHzLDuztzidMtDlPqb3sFUcauCafYl8QsNOF
	 gKu+GGRJolxsJjSyCRBe/AO1/Pzetl36BcL6rDTcYSz8GmagFC/T+vSySMB1o7+OUs
	 HRBwD9o0rRrvlxz81aFPZMt/3tOAAF55PoxbSYY4CMjPviJggs4RVDV3aqqRQW9Uf5
	 1mj+590Oc0eoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6DA1C595C5;
	Sat, 26 Aug 2023 02:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] veth: Avoid NAPI scheduling on failed SKB forwarding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301522787.10076.2067561261136639166.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 02:00:27 +0000
References: <20230824123131.7673-1-liangchen.linux@gmail.com>
In-Reply-To: <20230824123131.7673-1-liangchen.linux@gmail.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 20:31:31 +0800 you wrote:
> When an skb fails to be forwarded to the peer(e.g., skb data buffer
> length exceeds MTU), it will not be added to the peer's receive queue.
> Therefore, we should schedule the peer's NAPI poll function only when
> skb forwarding is successful to avoid unnecessary overhead.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] veth: Avoid NAPI scheduling on failed SKB forwarding
    https://git.kernel.org/netdev/net-next/c/215eb9f96209

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



