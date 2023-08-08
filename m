Return-Path: <netdev+bounces-25233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C6477366D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 04:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537DA1C20B85
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183457FD;
	Tue,  8 Aug 2023 02:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121DC37E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 02:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 886B7C433C9;
	Tue,  8 Aug 2023 02:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691461221;
	bh=kIyAQMukGXX9hkfOIlUbx01Y94cwkm21Uaczx4ozoPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R4+Ff2oWweI6Pxzul5oURhFvP7LdJM1JFZBYoGuJL+we1MR4sM+t+WlNoG+wW2ZPw
	 9SLsUtp4Jj+ZnHDT1LNtt3nud3r5ifP8IcUaHQwODJSzb0qIY9tFMSXmU4ZFmgyI5g
	 ke2yztGbfb2aJglQPCwUB71T1bbUcO5PN05NZVX98wykp/Ovkx39SyKhdNCQSWJlga
	 E1JOrcuBeMZjwmfFaPKxhLcY4dCTGrHTHMxArIY6PqE1+QKs1WA6RqIocVEiAZCS9T
	 rZPlqmkaUEZRJ9eMI4nA+jblkgXqCTyoHGcL3uYb0MNB2gab1M4Sz4+3IYwJ2Ys1t/
	 x1f4XgwtO8WJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DBA3E505D4;
	Tue,  8 Aug 2023 02:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 1/2] drivers: net: prevent tun_build_skb() to
 exceed the packet size limit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169146122144.9822.6352423513613934358.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 02:20:21 +0000
References: <20230803185947.2379988-1-andrew.kanner@gmail.com>
In-Reply-To: <20230803185947.2379988-1-andrew.kanner@gmail.com>
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org,
 hawk@kernel.org, jbrouer@redhat.com, dsahern@gmail.com,
 john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 20:59:48 +0200 you wrote:
> Using the syzkaller repro with reduced packet size it was discovered
> that XDP_PACKET_HEADROOM is not checked in tun_can_build_skb(),
> although pad may be incremented in tun_build_skb(). This may end up
> with exceeding the PAGE_SIZE limit in tun_build_skb().
> 
> Jason Wang <jasowang@redhat.com> proposed to count XDP_PACKET_HEADROOM
> always (e.g. without rcu_access_pointer(tun->xdp_prog)) in
> tun_can_build_skb() since there's a window during which XDP program
> might be attached between tun_can_build_skb() and tun_build_skb().
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] drivers: net: prevent tun_build_skb() to exceed the packet size limit
    https://git.kernel.org/netdev/net/c/59eeb2329405
  - [net-next,v5,2/2] net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()
    https://git.kernel.org/netdev/net/c/d14eea09edf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



