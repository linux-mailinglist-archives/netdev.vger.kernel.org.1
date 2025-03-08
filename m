Return-Path: <netdev+bounces-173135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE3A577F4
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEBE17768F
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FEE17A301;
	Sat,  8 Mar 2025 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFzPh/hd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AE17A2FB
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405211; cv=none; b=fmbNFhT719nM+TiLFFDj58PZ7MBVtE4RYPOP70renbEat3mZxXXarC4ByO9Ap69aqZQtMXVqok/9zad7QnPAnXKxo9icGCGKENlAvvDkjBrmfYlWutL4htAV4xqYrAtznQlAf70+PyKpvFoL6Ai8/V6RUCNMchwPcTeI+yFQtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405211; c=relaxed/simple;
	bh=GRIZZtSO6JUc9DDm+l9ealkBM7IJ4qsd/ilYYoi1yGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lbfSN20VKtWQUgYpQGAHZjtXghgXd8UARS5Qqjr5GH5lIOFednmyd+cWXdV0qpF/L8mC1R8kB2/Ch+QdF1X27XkYDqJElG+XWqvp1re8E0h9Rjajdj95k95BpPlZ2UpCyR6sgQaBpn8lTEPRt/qy9o0rJj2b/TpccV1XWVKlDJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFzPh/hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309A6C4CEE8;
	Sat,  8 Mar 2025 03:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405210;
	bh=GRIZZtSO6JUc9DDm+l9ealkBM7IJ4qsd/ilYYoi1yGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MFzPh/hdCH2QzmwDokrCDxFOm3yHGImML+17PNQfltxo2RJJQ+9KuI1H4wTpNTtvW
	 qUbYlKW4r3j24tsypJGD1ycajldMWisihsSalJbIjYdasQjbxWJuS5o7TQdkDthtax
	 rKSLJnE2SI/ph3Zy37gOvpohu9zmF2WhE8M1Y9NTjhviZMIqvDOdZRJFUsXPP0umT8
	 ccJbtnvmPLYlMOFI7ZR3BC4azdSQ6cHO70wRcmxDQ9CklVYOcqleNbmIFndxCRTUMy
	 y5qdu5T4WkgM+cMM6sjMQaZjUIIVOmUn6u9/51EjpCWXqwScXJkDxuH9tyjyL61hPU
	 NsYwJ8OdKRYGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACEB380CFFB;
	Sat,  8 Mar 2025 03:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: use correct device pointer in
 ethnl_default_dump_one()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140524355.2565853.9173025389821987118.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:40:43 +0000
References: <20250307083544.1659135-1-edumazet@google.com>
In-Reply-To: <20250307083544.1659135-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 horms@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+3da2442641f0c6a705a2@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 08:35:44 +0000 you wrote:
> ethnl_default_dump_one() operates on the device provided in its @dev
> parameter, not from ctx->req_info->dev.
> 
> syzbot reported:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000197: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000cb8-0x0000000000000cbf]
>  RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
>  RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
>  RIP: 0010:ethnl_default_dump_one net/ethtool/netlink.c:557 [inline]
>  RIP: 0010:ethnl_default_dumpit+0x447/0xd40 net/ethtool/netlink.c:593
> Call Trace:
>  <TASK>
>   genl_dumpit+0x10d/0x1b0 net/netlink/genetlink.c:1027
>   netlink_dump+0x64d/0xe10 net/netlink/af_netlink.c:2309
>   __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2424
>   genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
>   genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
>   genl_rcv_msg+0x894/0xec0 net/netlink/genetlink.c:1210
>   netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
>   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>   netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>   sock_sendmsg_nosec net/socket.c:709 [inline]
>   __sock_sendmsg+0x221/0x270 net/socket.c:724
>   ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>   ___sys_sendmsg net/socket.c:2618 [inline]
>   __sys_sendmsg+0x269/0x350 net/socket.c:2650
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: use correct device pointer in ethnl_default_dump_one()
    https://git.kernel.org/netdev/net-next/c/f36a9285828c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



