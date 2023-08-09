Return-Path: <netdev+bounces-26032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56CD776997
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9C71C20EBA
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64EE24533;
	Wed,  9 Aug 2023 20:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227824531
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA2D1C43397;
	Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691611825;
	bh=QINh95U2Kl45k1btT11BRAJOevH/HbMTSWCO+IBYigU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fQVzmc3QNrS+oYNKRH6ShWmBNBYPrA09XdgwsnbqHnNbKxcx+trTsHRynL8N/j2VY
	 QlvQUmSNXByekV7VnDslyTjeohRPiXkvk7/PgIB+EHJ4naF8zAHEHJVGY3ywdLUIWV
	 4n1vjMScJdg2dfMDgmuVp7CcsxmkER1cvBk7XY042LaBS5GwDebkOIEX7tNgDHaOsh
	 omfXh7v2G1kREevJyJBfbv4L+QOkrgdYbq/2LO+9iciNYV6CVUgJEExq4029SgJGPE
	 3FMCanxvct9qe4R8xSpY1sBe8XA3ER/wmcYzGxInx3SF2bqKpG9fjrGBgmYwaEZUFr
	 n772lHgxKI7Iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C231DE330A1;
	Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tipc: Remove unused declaration
 tipc_link_build_bc_sync_msg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161182579.10541.8463792126455750311.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:10:25 +0000
References: <20230807142926.45752-1-yuehaibing@huawei.com>
In-Reply-To: <20230807142926.45752-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Aug 2023 22:29:26 +0800 you wrote:
> Commit 526669866140 ("tipc: let broadcast packet reception use new link receive function")
> declared but never implemented this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/tipc/link.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] tipc: Remove unused declaration tipc_link_build_bc_sync_msg()
    https://git.kernel.org/netdev/net-next/c/ca76b386d46f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



