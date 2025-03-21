Return-Path: <netdev+bounces-176834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FEBA6C503
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 22:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C54825FF
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0B8231A24;
	Fri, 21 Mar 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JolPQkvl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345421E9B34;
	Fri, 21 Mar 2025 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592104; cv=none; b=LHWimVzy9ivrDwLojhF7PM9e7xklVRiDPj4jfDlVJ5wbX2wSIcykUSfYUMN329L5b/DPdbiA/opCZhaOrLUaPkNmlh9XPlKs69iMmWkkmrE3SjOMrrL36DCLJumttU/YE6uJ2VpM68nNIjYLpoz5YhddyuWcZOOZvDa+KR8zJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592104; c=relaxed/simple;
	bh=zqK3TJ1qeq7m01Nky2ep9+l1h8be9dxtswR9/vVTKUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L6ggBnxtml1N5D9A4rjPRxcXG0RPJqqZ854E7MzgOA+J20cbwvmlzjwbPAtFPiOCAusCkJuQ0nRfwEvlx7HDegKe1m5O25gkDyJUDkhVCG3Z85rPnE0Fxutu5ozeFcx0gkydbxiAJhBx5yMX2NNyliTLz2MExu1DQ27tkjQ35Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JolPQkvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB213C4CEE3;
	Fri, 21 Mar 2025 21:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742592102;
	bh=zqK3TJ1qeq7m01Nky2ep9+l1h8be9dxtswR9/vVTKUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JolPQkvlWSyP2HrT8QFSIfqfGJNgHSfviTlUhi9/tgFcsOC5rIoMpaoox+ZKgDCtS
	 kBqrtaTiDemPIVBb4dYOpHNvW+GQSsnBo6eaxR4m/ErDCOjWa8enDmhug8NYlG5tQ3
	 tuLULqyz6In/SAtdaR2ztDeZ8p0w1pskJv8+dNy+Bu5SwheoE6i1MN3ZAZ7neeptDZ
	 5XfEbR8JzVmbZnECxHjPjCQYPZUonq8DTUCmZYkG6dMiqV7iBLN2st0KqMr1D+OXHa
	 j07dy+5T243I5yaDWu9w9fpz40IVybGnL4UXwhzVGTsLMHcg9F/U3hm4KYAnqpvvXz
	 notZR/4qdNOGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD083806659;
	Fri, 21 Mar 2025 21:22:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: Remove RTNL dance for SIOCBRADDIF and
 SIOCBRDELIF.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174259213876.2627311.3307708570431277417.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 21:22:18 +0000
References: <20250316192851.19781-1-kuniyu@amazon.com>
In-Reply-To: <20250316192851.19781-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, roopa@nvidia.com, razor@blackwall.org,
 willemb@google.com, horms@kernel.org, idosch@idosch.org, sdf@fomichev.me,
 kuni1840@gmail.com, netdev@vger.kernel.org, bridge@lists.linux.dev,
 syzkaller@googlegroups.com, kangyan91@outlook.com, samsun1006219@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Mar 2025 12:28:37 -0700 you wrote:
> SIOCBRDELIF is passed to dev_ioctl() first and later forwarded to
> br_ioctl_call(), which causes unnecessary RTNL dance and the splat
> below [0] under RTNL pressure.
> 
> Let's say Thread A is trying to detach a device from a bridge and
> Thread B is trying to remove the bridge.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.
    https://git.kernel.org/netdev/net/c/ed3ba9b6e280

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



