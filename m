Return-Path: <netdev+bounces-24705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB59771505
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 14:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9451C20956
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C3E3FF5;
	Sun,  6 Aug 2023 12:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057F28F7
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 12:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 966BFC433C8;
	Sun,  6 Aug 2023 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691325021;
	bh=JCo88XUpPrDX0t1UJnwcmyxzG7fs32AOEfvORD5NtNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lJRTkf48gKZEXzolGe0iqXqnMsDwDL3xscmKAslTk0n/UHmCjKKyzLCQwJfUzMQ8d
	 t33HPARUdrZTZnaFEGdd/UfTkK73ohxeWppy3mWS6OUy65tNFGQYwMo5zZ3LnwyYw6
	 2WxEeAaDDPFMWjdpRXe1NhUhVRGR74QAvk5f2ffPpid5iJcMNC/hJSOaUSCR3kdK8Z
	 JBon8DTe7WO5UpO+RoQysYZNcIERuI2INGmOsTHFQobOR7cDo0qN0Dt6W9f4r3ms0K
	 YVo9iH+w/1fHQ3Pk8RQ4PmDnlhC/+0TWezGbiGFDdWMJ/WJ1CL0b5FNAT9INotU4GC
	 m8K3IHV3RSbzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8179FC6445B;
	Sun,  6 Aug 2023 12:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: adi: adin1110: use
 eth_broadcast_addr() to assign broadcast address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169132502152.16904.6781924377719274144.git-patchwork-notify@kernel.org>
Date: Sun, 06 Aug 2023 12:30:21 +0000
References: <20230804093531.1428598-1-yangyingliang@huawei.com>
In-Reply-To: <20230804093531.1428598-1-yangyingliang@huawei.com>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexandru.tachici@analog.com,
 andrew@lunn.ch, amit.kumar-mahapatra@amd.com, weiyongjun1@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 4 Aug 2023 17:35:31 +0800 you wrote:
> Use eth_broadcast_addr() to assign broadcast address instead
> of memset().
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/ethernet/adi/adin1110.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: adi: adin1110: use eth_broadcast_addr() to assign broadcast address
    https://git.kernel.org/netdev/net-next/c/54024dbec955

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



