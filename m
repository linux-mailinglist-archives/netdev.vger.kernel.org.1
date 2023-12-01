Return-Path: <netdev+bounces-52895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB44280096A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6D92813FC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD79210FD;
	Fri,  1 Dec 2023 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHpuoNkx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51669210F5
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 11:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1172C433C7;
	Fri,  1 Dec 2023 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701429023;
	bh=a16OAQT2aoHFf/rpgoy1OBrQ1J6SxYIu1qUavost96Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WHpuoNkxOfpQjiIjE+8wgR5se8dvPnG7Z00xbSGSsj1DWaPITMGjvO5PSuMDgKeQh
	 SPRRAe3AipZB7o5wbDV2aY94TQcYXWMFr23+3fP0S1+m+VEZczakNmpaX5HXqQGZGb
	 araWvemnbh4eJURNEs11Ks1K7+hK0pfFOyaO4KVVQ8CNUuVjFvSHMtP3cmzQG0f6hk
	 /leN4ZnmHAf/b/vacNWzS/DUPw1V1eSfk36BqqMmKxOSW8OBi1pvWxFblSsJVWn3Nw
	 zs4h+Yv7judjY/sBbjx0O9oB7iue9o8bsSK05g0sHg8wv6RKue3yMVzxiu0Bt9qLT5
	 7dSYxBrz4umHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B58EAC59A4C;
	Fri,  1 Dec 2023 11:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] octeontx2-pf: Add missing mutex lock in
 otx2_get_pauseparam
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170142902373.13641.10956556267132946776.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 11:10:23 +0000
References: <1701235422-22488-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1701235422-22488-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 lcherian@marvell.com, jerinj@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 29 Nov 2023 10:53:42 +0530 you wrote:
> All the mailbox messages sent to AF needs to be guarded
> by mutex lock. Add the missing lock in otx2_get_pauseparam
> function.
> 
> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam
    https://git.kernel.org/netdev/net/c/9572c949385a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



