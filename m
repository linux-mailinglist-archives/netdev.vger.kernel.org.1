Return-Path: <netdev+bounces-149949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB6B9E8310
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5902817DD
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6328E134BD;
	Sun,  8 Dec 2024 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9IMcpwU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD8A932
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733623215; cv=none; b=TkLoDFKhSYN36X25QwxVU8zaX1AK6MGEJ6nBDLW6axm79ytjSNlyHo2bzXsuFOmS+11K/zB0XQt1pZR6qw/G+gV84WaUat8qWjJk80U33Epm64jzovLYV5ZNH3PboBLvGziSeTknrhjWjOfQCb/Y07AnaTXroa3TqinJ3KcFS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733623215; c=relaxed/simple;
	bh=lcHjGI0wSbl/OvubkM9K4XBnl9dS/fr1AR6OjiSGuAo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qmZITt6gkhMxsr5GiQ56jR4nkbCqI3K7PxxBKm9n7ptqSx6gX7Xz7yPeZUCPXYr4pe/iOLJ39d8hMrQirYElv5+G/wpwZ7fGq0ywlzyCx7voLpmDk6SnKK0NByqNB1EK3M9hg7g6iDkT/UUjvbMZltJ5UbiCNv8ciSNKJLWo++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9IMcpwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E35C4CECD;
	Sun,  8 Dec 2024 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733623214;
	bh=lcHjGI0wSbl/OvubkM9K4XBnl9dS/fr1AR6OjiSGuAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d9IMcpwUgclKOcXiuDBPPZZAOYFKyQ4P5CZo4OP3Yr7O72D8gcTubQX6RProfSWcm
	 Y0IHBGsca3pIXNebfDjKp85Yb5s9arK4diXDZmHdzEdwQ4bIImHUhf3zveO7Mt+v6t
	 DTY/gGj2NA0nYgcOKerqkxZrAx23ZFXdhNGdvj9ZVYBJErbcpg7UtjlDv3ybbdcNTl
	 VEtrAshkHAhphxKPH1g5eMQGjiMJUxZicwmIg55wLtJroH5zBoi/1o3Eq/rr2rlo1z
	 bS/IR4Xbu8Z/aSx29cG7GrdfsL2L+cL7zqo735kgWZgLkiSvBOLVp7mRtQ1tMHtmJP
	 EX8Lh7fcRf4ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343D5380A95D;
	Sun,  8 Dec 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ip: Return drop reason if in_dev is NULL in
 ip_route_input_rcu().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173362323004.3131871.13941207091906015076.git-patchwork-notify@kernel.org>
Date: Sun, 08 Dec 2024 02:00:30 +0000
References: <20241206020715.80207-1-kuniyu@amazon.com>
In-Reply-To: <20241206020715.80207-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 menglong8.dong@gmail.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Dec 2024 11:07:15 +0900 you wrote:
> syzkaller reported a warning in __sk_skb_reason_drop().
> 
> Commit 61b95c70f344 ("net: ip: make ip_route_input_rcu() return
> drop reasons") missed a path where -EINVAL is returned.
> 
> Then, the cited commit started to trigger the warning with the
> invalid error.
> 
> [...]

Here is the summary with links:
  - [v1,net] ip: Return drop reason if in_dev is NULL in ip_route_input_rcu().
    https://git.kernel.org/netdev/net/c/cdd0b9132d71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



