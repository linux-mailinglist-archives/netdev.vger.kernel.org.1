Return-Path: <netdev+bounces-253225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBvNDiiQdmksSAEAu9opvQ
	(envelope-from <netdev+bounces-253225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:50:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC882929
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2471D300CE56
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783E30DEC6;
	Sun, 25 Jan 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDIi9dqf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512730DEB8;
	Sun, 25 Jan 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377811; cv=none; b=F7pFiLwYbMRY8cssitxEv8W/NKFDkIJrXP152qyOzCjlRGTeIhOww9chFmf/7Vvq17heGyabyUGftl8YIoBvnulGGkd7kPjC+COmCQX1fRWO4VDdNvE2+hpLyjyL39mqvrTZwzsBb2ZXHaxLh6In1C0xU9FeIrGZmt4rJQ5TdfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377811; c=relaxed/simple;
	bh=2jG1gq+PpXwjMDT/82fxWck9L3IIxPK0gQWT5K3Nfhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QghGW6CcGXbYptTFI9IutOSNaSXyuve2pv3HDp0cs8RkOavZ3mLl0QKF4YK8mr7aYsOp1zYgWHcX28EnEQjhHjOuHR9njGY+n1i6ZfN8NUuezzc8Uegs/EPzdIKtwvkpEV1wusnhVcVkVkXq2IMYHRImZPKw0i3hY4owLtcyr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDIi9dqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742A4C16AAE;
	Sun, 25 Jan 2026 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769377811;
	bh=2jG1gq+PpXwjMDT/82fxWck9L3IIxPK0gQWT5K3Nfhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XDIi9dqf14pJNpzxqDTp37L4kNMZmT1WiARJlYzp90Kvp74Peo04ZXhdhp3KBn7g5
	 f/Up5GgWnXvfUNM+aOjNJji8+ar/ZybQWx2ByRRYvN+0uWU2UEcwXe41elMU24jxP4
	 thzDEmj5Xj6A3jLD483K7L016U56uoEO4kY2nIt1SiPOH7alE0X16lFImOx5N6vUJY
	 n93I91UWTO2zh+/IIMg/dwXWijDgaB6EULVKZGVkOgzX3TT7iCE5ZRHe9qDeGDZRn/
	 ZDFEEZc5zH5mMRrb9mpMbVBHOmXKiNk7bkJXW59zAfCN5sYTX8n+s1wDuQiukb9WqJ
	 TJMybIY1XGMUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BD323809A15;
	Sun, 25 Jan 2026 21:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2 net-next v3] ipv6: use the right ifindex when replying
 to
 icmpv6 from localhost
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176937780636.3593758.11533069681163455532.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 21:50:06 +0000
References: <20260121194409.6749-1-fmancera@suse.de>
In-Reply-To: <20260121194409.6749-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, haleyb.dev@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-253225-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82CC882929
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 20:44:08 +0100 you wrote:
> When replying to a ICMPv6 echo request that comes from localhost address
> the right output ifindex is 1 (lo) and not rt6i_idev dev index. Use the
> skb device ifindex instead. This fixes pinging to a local address from
> localhost source address.
> 
> $ ping6 -I ::1 2001:1:1::2 -c 3
> PING 2001:1:1::2 (2001:1:1::2) from ::1 : 56 data bytes
> 64 bytes from 2001:1:1::2: icmp_seq=1 ttl=64 time=0.037 ms
> 64 bytes from 2001:1:1::2: icmp_seq=2 ttl=64 time=0.069 ms
> 64 bytes from 2001:1:1::2: icmp_seq=3 ttl=64 time=0.122 ms
> 
> [...]

Here is the summary with links:
  - [1/2,net-next,v3] ipv6: use the right ifindex when replying to icmpv6 from localhost
    https://git.kernel.org/netdev/net/c/03cbcdf93866
  - [2/2,net-next,v3] selftests: net: add ipv6 ping to local address from localhost
    https://git.kernel.org/netdev/net/c/1742272bd3fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



