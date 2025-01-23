Return-Path: <netdev+bounces-160590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3921A1A6E3
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85671881CC3
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150E020F09D;
	Thu, 23 Jan 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPAaUvDF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226120B22
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645613; cv=none; b=XGmnSVDReJWltNdiABiUSSVG5E514sqWfHu3IqOuy8RrP1bEDdqbAhOuEYbc0CwJ6isnDEg6QfzvfDmwwe8URkhkjvjXW9rtIvNSObs2w1xS7ZXCdgq7sr0f5udUqRBnQTw1KgGxqZfyeBW5eUxkL9YAEEAVUZTJzyhh4JZB2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645613; c=relaxed/simple;
	bh=5i68P4F3So3JFucG5IgYY82zLa9Ic2C6Y/6iZhtu+3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=upY/4YvJJ4I03KLcgy4AK4vPaGm0XqfLKcEfVGpDBg6C2CnAsg52HJT77m3j2GS9868LbhWFIBCKfMD4PvfsL7brWKESJIQl7QDVq7CwINmvmzhoH95J0BSGWJHCtXrB8iTX0hif1wgMEdBmTuwsHhWDRW3HMoIzKCDb+vs/7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPAaUvDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587E2C4CED3;
	Thu, 23 Jan 2025 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737645612;
	bh=5i68P4F3So3JFucG5IgYY82zLa9Ic2C6Y/6iZhtu+3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dPAaUvDF0tLAKdQbYvLJnSasUY4wCy4xAgnbl8AXcwW1rrCmlRuMUgVr8E+iAO/XH
	 NHG75VvMLQqEkUL4EAOc4fN/Usi3h41zuMFlEpK1rT5SMBJoF1v8qdxEgVWOLnlhso
	 /ZbNMcX3Q4FUAGlJBEL+FgGgGpfyr9WYRO6dKNZecwlxu8ry2mklDEuTu5BdGZUxf0
	 i64SNi9mUCWoN14l0vyTOqsaeD/F/1RpWncBXxe3Xjwy5ohQIJ4b/JyvgW6edxfKFr
	 rfAxnqRrRc7x3/QWdauDFrrETel6Tp/m2SIQZJvx/BCJdXLOekVLSON5HX5dH5oLvD
	 or7arnZtTiEPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34904380AA79;
	Thu, 23 Jan 2025 15:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipmr: do not call mr_mfc_uses_dev() for unres entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173764563702.1390395.2669173969482212363.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 15:20:37 +0000
References: <20250121181241.841212-1-edumazet@google.com>
In-Reply-To: <20250121181241.841212-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, dsahern@kernel.org,
 eric.dumazet@gmail.com, syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jan 2025 18:12:41 +0000 you wrote:
> syzbot found that calling mr_mfc_uses_dev() for unres entries
> would crash [1], because c->mfc_un.res.minvif / c->mfc_un.res.maxvif
> alias to "struct sk_buff_head unresolved", which contain two pointers.
> 
> This code never worked, lets remove it.
> 
> [1]
> Unable to handle kernel paging request at virtual address ffff5fff2d536613
> KASAN: maybe wild-memory-access in range [0xfffefff96a9b3098-0xfffefff96a9b309f]
> Modules linked in:
> CPU: 1 UID: 0 PID: 7321 Comm: syz.0.16 Not tainted 6.13.0-rc7-syzkaller-g1950a0af2d55 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : mr_mfc_uses_dev net/ipv4/ipmr_base.c:290 [inline]
>  pc : mr_table_dump+0x5a4/0x8b0 net/ipv4/ipmr_base.c:334
>  lr : mr_mfc_uses_dev net/ipv4/ipmr_base.c:289 [inline]
>  lr : mr_table_dump+0x694/0x8b0 net/ipv4/ipmr_base.c:334
> Call trace:
>   mr_mfc_uses_dev net/ipv4/ipmr_base.c:290 [inline] (P)
>   mr_table_dump+0x5a4/0x8b0 net/ipv4/ipmr_base.c:334 (P)
>   mr_rtm_dumproute+0x254/0x454 net/ipv4/ipmr_base.c:382
>   ipmr_rtm_dumproute+0x248/0x4b4 net/ipv4/ipmr.c:2648
>   rtnl_dump_all+0x2e4/0x4e8 net/core/rtnetlink.c:4327
>   rtnl_dumpit+0x98/0x1d0 net/core/rtnetlink.c:6791
>   netlink_dump+0x4f0/0xbc0 net/netlink/af_netlink.c:2317
>   netlink_recvmsg+0x56c/0xe64 net/netlink/af_netlink.c:1973
>   sock_recvmsg_nosec net/socket.c:1033 [inline]
>   sock_recvmsg net/socket.c:1055 [inline]
>   sock_read_iter+0x2d8/0x40c net/socket.c:1125
>   new_sync_read fs/read_write.c:484 [inline]
>   vfs_read+0x740/0x970 fs/read_write.c:565
>   ksys_read+0x15c/0x26c fs/read_write.c:708
> 
> [...]

Here is the summary with links:
  - [net] ipmr: do not call mr_mfc_uses_dev() for unres entries
    https://git.kernel.org/netdev/net/c/15a901361ec3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



