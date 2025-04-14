Return-Path: <netdev+bounces-182524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F0A89008
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E21F3B1447
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FE21F417D;
	Mon, 14 Apr 2025 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG/XFhcj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544F1C861C;
	Mon, 14 Apr 2025 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672796; cv=none; b=h7pG+wAKZy4Gq3Wxlhz2+LbzJBLKqI6fO1hk/cqCIcJudhLzszku3MJ2X7uKpNppx4cnGuAH8LpjJwksa6nz5/sJXLBLifKyr6+m1ih1+F1o6nNaW9Uq10lWhnto/MAQDxKLXcjDo1lBK90C6b6s2kHanOCUvkaMKsZSuWytzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672796; c=relaxed/simple;
	bh=OSEmGzyyT72ND6kz32nxERjAhu0/+Xp55R2wLvZ6rmQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gxt3LVUMZvYona+DSuX8Mp5yUneT7TIY/RXTWkJ27mDZeBFgytsltzKEZS/xpLeX3JJJPaXgtt/OaVF0g2bhtpYu/Nfk34T/f4be34MRspdqZ/EKM4Ejb8H35JWZVAzhZ8v7jsreUKMv1BAgUHJMViSNSZqlzEDVy7ogN9KIf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG/XFhcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36FEC4CEE2;
	Mon, 14 Apr 2025 23:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744672795;
	bh=OSEmGzyyT72ND6kz32nxERjAhu0/+Xp55R2wLvZ6rmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iG/XFhcjcXZYecW8SODZDWlHMhdP8uQGrkd2qi/tw1f5TybiYWGlj9zj57MwOpjZI
	 W8Bz3PuHrQIbDZxCDK1apBVpwNZd3sWKFRUbn9B6PgT6jxU3jDRRP7bK3uVyuCeBHQ
	 twYtwQiU7KsOC/Ri91sHpeFNppiabi4e2uSh/Zm6E1NQpZDgccrAwtSy5A0X5tf8Dj
	 WkWgslAFcSJNjF6J+TpihV+nxu+C9RqhpoNVSTNefHdm4n5pTiPxIZTN8X/TDiwRa9
	 4/Hm8W8S6N8hVehN7KdclYOT5vFsdIjTfzHSP00WNI7ylijBR4SI3LQmXuvp8xZQkJ
	 p6cXIEdZJaTxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3783822D1A;
	Mon, 14 Apr 2025 23:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: fix nested key length validation in the
 set() action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467283350.2070846.15057533875740479075.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 23:20:33 +0000
References: <20250412104052.2073688-1-i.maximets@ovn.org>
In-Reply-To: <20250412104052.2073688-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, echaudro@redhat.com, aconole@redhat.com,
 syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Apr 2025 12:40:18 +0200 you wrote:
> It's not safe to access nla_len(ovs_key) if the data is smaller than
> the netlink header.  Check that the attribute is OK first.
> 
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Reported-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b07a9da40df1576b8048
> Tested-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: fix nested key length validation in the set() action
    https://git.kernel.org/netdev/net/c/65d91192aa66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



