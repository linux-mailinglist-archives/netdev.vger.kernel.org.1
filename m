Return-Path: <netdev+bounces-29111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F6F781A36
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71811C209E6
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CCE6FAF;
	Sat, 19 Aug 2023 14:46:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FDF5667
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 14:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51FB4C433C7;
	Sat, 19 Aug 2023 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692456375;
	bh=pFMNSh+oham7YlCm9hgU6C0Fijw4+NjfjaXvuFhyAfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JgZJM8IklNl3LAYf1/3iVimv4tWqtCC/0q5NzflHtZZpe4EWew7r8e5sP/OrgTQ/l
	 QZuFHDmuekU5AlZGoNucsLNvJZJyrew9v20FBXQ12a61MI0+TDUU9ZVXG84gAtSuAU
	 +Gbt2xtx97/SiB/WQ28sNHJbLzBtbCvbx3k3O5IfXbrtDTZfTItCmgprqWOw2prKaY
	 iy6RFxhRiE6vE7UVURXPKxlySgF50fT9gu6vYpRDd64qmBsBeEHxS2GtBdqCQK0gsE
	 NX/bampViTTe+32TK3i3v8FffolvU89FFbNSG5Mzrmo02EV3rZeQSJkvZH/EJhDtch
	 spuHn0fMjsJoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 350D8E1F65A;
	Sat, 19 Aug 2023 14:46:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add skb_queue_purge_reason and
 __skb_queue_purge_reason
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169245637521.6706.1674595017775095618.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 14:46:15 +0000
References: <20230818094039.3630187-1-edumazet@google.com>
In-Reply-To: <20230818094039.3630187-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 09:40:39 +0000 you wrote:
> skb_queue_purge() and __skb_queue_purge() become wrappers
> around the new generic functions.
> 
> New SKB_DROP_REASON_QUEUE_PURGE drop reason is added,
> but users can start adding more specific reasons.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: add skb_queue_purge_reason and __skb_queue_purge_reason
    https://git.kernel.org/netdev/net-next/c/4025d3e73abd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



