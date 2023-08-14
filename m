Return-Path: <netdev+bounces-27242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F577B23B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468441C20967
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB618467;
	Mon, 14 Aug 2023 07:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42D79FA
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 703C5C433CA;
	Mon, 14 Aug 2023 07:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691997620;
	bh=y0sm6oEEJDDkK39UR0ihXRW20FuTzAANSxaDy4JIzok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U5yxli/EYVOVgGEaCrxliaDrPn+TuxNaVTMAI5i82zWr7LYUoreohgQpjAG2G9JI7
	 PyOQeS+2+5FKEFxJYhV5ijxOEW1F1ydKnNzDXYI/7fSJHYHomStTgdW2P5yqy7yaRe
	 NfmuHkDO+PWe+RyNCjFJzrCJhCL+o4tnsONwtw0AW2iD0vc/Sbgkh4kI3I0S/IycvB
	 PxMRu+zGnBEoID5QFKTkHPS1kG//1KlgR4Om0IaH1AaqAx8Jha5QfYwQqm71f7b9Nk
	 fE74MVpiXYtT1COJvwuR5F/qU8vw6UV7FzdgL8/9CjdMcQznrXBhyVpa8YZSkIXApw
	 RsyunkilUHYdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56F46C395C5;
	Mon, 14 Aug 2023 07:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "vlan: Fix VLAN 0 memory leak"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169199762035.17065.9006238015326937146.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 07:20:20 +0000
References: <20230811154523.1877590-1-vladbu@nvidia.com>
In-Reply-To: <20230811154523.1877590-1-vladbu@nvidia.com>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, amir.hanania@intel.com,
 jeffrey.t.kirsher@intel.com, john.fastabend@gmail.com, idosch@idosch.org,
 horms@kernel.org, syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com,
 syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com,
 syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 17:45:23 +0200 you wrote:
> This reverts commit 718cb09aaa6fa78cc8124e9517efbc6c92665384.
> 
> The commit triggers multiple syzbot issues, probably due to possibility of
> manually creating VLAN 0 on netdevice which will cause the code to delete
> it since it can't distinguish such VLAN from implicit VLAN 0 automatically
> created for devices with NETIF_F_HW_VLAN_CTAG_FILTER feature.
> 
> [...]

Here is the summary with links:
  - [net] Revert "vlan: Fix VLAN 0 memory leak"
    https://git.kernel.org/netdev/net/c/ace0ab3a4b54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



