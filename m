Return-Path: <netdev+bounces-205217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05817AFDD14
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1851BC389D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197D13E41A;
	Wed,  9 Jul 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugom3s6m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB5182
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025803; cv=none; b=qDL/i1D/NT8dvaSRf+rcCu36Jnil7Exx5SROyQX0lMtLHsXmUZ7rQRRC3gxm+CmdyVxLv0JV6nK3JlHahQ2wr79znLmFXBcHWD5htogM/Fj3LWZ+AVP4hc21rmu27bnwTN1Xy+z1QygHHPQbuvKCNqrWfd0aPNqbCNxSWDLCOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025803; c=relaxed/simple;
	bh=/8rLoStZhvqu9gfJIHVC/rTXCjqRU9KsqOs8twI+oaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ARXgmnKw9G9aOJuiltqhGXnZeLJxFY5NOuGXuL4nYxYZv7VhYEX3Uryz9Y/oz1E54LDl1c+R9rGdMYMpRutWUXfCN6NBau5CW+yXJiZpeJk2WveViklz5ZHbzzXLPA8YinKFwWGuxlPxQN+aOpTfYDcG8sy6GJkFMgA1gjrgUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugom3s6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A2AC4CEED;
	Wed,  9 Jul 2025 01:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752025803;
	bh=/8rLoStZhvqu9gfJIHVC/rTXCjqRU9KsqOs8twI+oaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ugom3s6m8TGcNjuiKPegQcXqOdCMX/wmWCLT7QEp68q+qmisiBIcgUHoriIoZQUyX
	 sfDpL9ai5otzyW/dtdv4UGonVQMtsIVXKQ3ntwa9xJWWpo5uLrGwMGGXeINYc7E6Mw
	 Cv2We5iLjsdm3yX9jkRswlOxlC+aQBZBsyH7fMoxK0IsIyLPuan0SWo5lBDq6J1h7d
	 qihnirZp1t+BJAy3r6CnMrF43Uj8Dt4+PbECS3XNfCCP6vPN9wAqQJHO2L0RAKqakH
	 ZCjeOf/NFvwg5ZzZFbty4gt95npkRraj9jC6rOLgZ3iSnQ/9Ekyli1PXf+3jXWzwv9
	 UmUUH5HzGEfzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB2380DBEE;
	Wed,  9 Jul 2025 01:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 00/15] ipv6: Drop RTNL from mcast.c and
 anycast.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175202582576.190635.16190055003928339339.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 01:50:25 +0000
References: <20250702230210.3115355-1-kuni1840@gmail.com>
In-Reply-To: <20250702230210.3115355-1-kuni1840@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Jul 2025 16:01:17 -0700 you wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> This is a prep series for RCU conversion of RTM_NEWNEIGH, which needs
> RTNL during neigh_table.{pconstructor,pdestructor}() touching IPv6
> multicast code.
> 
> Currently, IPv6 multicast code is protected by lock_sock() and
> inet6_dev->mc_lock, and RTNL is not actually needed.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,01/15] ipv6: ndisc: Remove __in6_dev_get() in pndisc_{constructor,destructor}().
    https://git.kernel.org/netdev/net-next/c/fb60b74e4e5b
  - [v3,net-next,02/15] ipv6: mcast: Replace locking comments with lockdep annotations.
    https://git.kernel.org/netdev/net-next/c/818ae1a5ecb4
  - [v3,net-next,03/15] ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in __ipv6_dev_mc_inc().
    https://git.kernel.org/netdev/net-next/c/dbd40f318cf2
  - [v3,net-next,04/15] ipv6: mcast: Remove mca_get().
    https://git.kernel.org/netdev/net-next/c/d22faae8c555
  - [v3,net-next,05/15] ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
    https://git.kernel.org/netdev/net-next/c/e01b193e0b50
  - [v3,net-next,06/15] ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
    https://git.kernel.org/netdev/net-next/c/1767bb2d47b7
  - [v3,net-next,07/15] ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
    https://git.kernel.org/netdev/net-next/c/2ceb71ce7d34
  - [v3,net-next,08/15] ipv6: mcast: Don't hold RTNL in ipv6_sock_mc_close().
    https://git.kernel.org/netdev/net-next/c/1e589db3892e
  - [v3,net-next,09/15] ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
    https://git.kernel.org/netdev/net-next/c/e6e14d582dd2
  - [v3,net-next,10/15] ipv6: mcast: Remove unnecessary ASSERT_RTNL and comment.
    https://git.kernel.org/netdev/net-next/c/49b8223fa9c1
  - [v3,net-next,11/15] ipv6: anycast: Don't use rtnl_dereference().
    https://git.kernel.org/netdev/net-next/c/7b6b53a76fcc
  - [v3,net-next,12/15] ipv6: anycast: Don't hold RTNL for IPV6_LEAVE_ANYCAST and IPV6_ADDRFORM.
    https://git.kernel.org/netdev/net-next/c/f7fdf13bf103
  - [v3,net-next,13/15] ipv6: anycast: Unify two error paths in ipv6_sock_ac_join().
    https://git.kernel.org/netdev/net-next/c/976fa9b2054f
  - [v3,net-next,14/15] ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.
    https://git.kernel.org/netdev/net-next/c/eb1ac9ff6c4a
  - [v3,net-next,15/15] ipv6: Remove setsockopt_needs_rtnl().
    https://git.kernel.org/netdev/net-next/c/db38443dcd9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



