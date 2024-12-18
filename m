Return-Path: <netdev+bounces-152793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA709F5CA2
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F441188E17F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8025473C;
	Wed, 18 Dec 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv/dJYVN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5710279C4
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487817; cv=none; b=ccQOkgqKHO7bqPGLZBj7FAM3X5wB8IKitKELXXjyHpblO9wZkTxH+hfkN3RPSyAlJZSRBcAOLeCDgelvo9aLZOq6PWO7SCbBJoNZJXkE6q4m2mWa705ozUD9N+SyD1GgU8Qv5X6ed3PF3IJOUUNeiKj9iNgp0XvfsdMOEK0Ch2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487817; c=relaxed/simple;
	bh=YtFMW0/wK4sJfEiDPT6U0u0W3YC0CnV18VZ/3IqGeCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DlA8hIbtfpXciBHvcHh1/mufW+o/DL40MFFNwq9krG9iXPl5BakbJ1Vjo5SJiJe8B+rHQ0wfmYpc9ir4jZQP0NEwD7mAVV87vvR8c+XBfQeIgvCS9SKXJnwykStPnBFx/zlVzeC1dMvag6U/ZJob1P861kISDnGFuanVgnkjAg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv/dJYVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEE4C4CED3;
	Wed, 18 Dec 2024 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734487816;
	bh=YtFMW0/wK4sJfEiDPT6U0u0W3YC0CnV18VZ/3IqGeCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bv/dJYVNJLhPbaqflTR1eH4qalAyTKMPp+eRtVVMIvR3WUl12PLcDh6M+8eHNFbOf
	 5MmzSva40idY2qdcXgPM594vr9q5p0nqt4l+cCiYsM5CSkeb7dTIzcVbMBvOTm19+N
	 xbmqVsstPi9PZ+Oz2b6Ku7Fwkf0D2eq2Zrpri61gZP60SUGQrmgMOtPVI9y71rX7er
	 H/HS6zTsYPns+yroDG+p552wH73i0X76FcHv3uUTHytOkjakgxfj1COMP+k1xEBvwa
	 MBmZzFfvvEV+WsAWj9oshFpocD4liRnGB3pb6uwJf3f3EiQ20Lf5k8qT01wfqyadR1
	 R5bB7Fy660qnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2D3806657;
	Wed, 18 Dec 2024 02:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] rtnetlink: Try the outer netns attribute in
 rtnl_get_peer_net().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173448783406.1150742.9924553595674828094.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 02:10:34 +0000
References: <20241216110432.51488-1-kuniyu@amazon.com>
In-Reply-To: <20241216110432.51488-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, cong.wang@bytedance.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, shaw.leon@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 20:04:32 +0900 you wrote:
> Xiao Liang reported that the cited commit changed netns handling
> in newlink() of netkit, veth, and vxcan.
> 
> Before the patch, if we don't find a netns attribute in the peer
> device attributes, we tried to find another netns attribute in
> the outer netlink attributes by passing it to rtnl_link_get_net().
> 
> [...]

Here is the summary with links:
  - [v1,net] rtnetlink: Try the outer netns attribute in rtnl_get_peer_net().
    https://git.kernel.org/netdev/net/c/954a2b40719a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



