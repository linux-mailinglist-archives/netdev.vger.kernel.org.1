Return-Path: <netdev+bounces-264479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPF2F/+qqWlSBwEAu9opvQ
	(envelope-from <netdev+bounces-264479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:10:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F442152D0
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BC9F302F161
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3C3CD8D9;
	Thu,  5 Mar 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urVghGpy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82B3CD8B9;
	Thu,  5 Mar 2026 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727031; cv=none; b=HWakIWTKHn7vl0FOHahYrXvemZ8mrGXABs46qtOXFTC0p59UemjNdzGB+dqGkscZu0yFYC+w0SAyMlAY5Hhxkn4cJ9II0o6U4rnF1p5WlVBtQ21GdD029v1jBSWRzmG5QhJqYHU4Qi0mfgWxzFBvDiUD+QnuQvfJNm2FtufRRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727031; c=relaxed/simple;
	bh=tycp5Wmt2PwmO071xa6900jmB4t73QUD2rRxZZNmfO4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ruNIInXznAmrOKpqMWxWA8X85+Fp+/Rjch/XrugOmX9+p+ukpzxqlaMJLtDZHNffbpUe6FUkftA7M8uHoMtGSeT0DwgYlBDGP+czZkij2J0Gq0GRaECIHcafn8dTTpsNJuMGSguD16YHoyV9dQYzPS4C19w+rCTuJJGwt+AaKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urVghGpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC0BC116C6;
	Thu,  5 Mar 2026 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772727030;
	bh=tycp5Wmt2PwmO071xa6900jmB4t73QUD2rRxZZNmfO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=urVghGpy++UlJ7r1vG51Ri2bpxk9iXyoVvZ/JC/0JPFO9UKSNyOa7aZcFhGmH2arE
	 Aykx7MSviOaak+J2uRdZd/ZKLKe5IFmzO7+3hkjzH9KXU0lI2veTo/BN0S+7ZhWWuX
	 +TMGbF800AypgqIp5l9IY8s1GbZs5rSKdy+ZgQooTq0LahFun1EEcPglR4licABm/N
	 ULSI9b/rBovvzLhru0qJg0a6q3EMutUEmmfzhSq8sdxWbUzwxzEhLuNWeC1vYN0c5b
	 gy1EDiz9GC54Pr0ZJRHWf3uNoxs22QW+rLzxFw3wRiljSXvdyKp2nMAnwFG6pnKG2F
	 5l8W3UAQ+1gig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D903808200;
	Thu,  5 Mar 2026 16:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net: ipv6: fix panic when IPv4 route
 references
 loopback IPv6 nexthop and add selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177272703078.3188128.539055376981723879.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 16:10:30 +0000
References: <20260304113817.294966-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260304113817.294966-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, jiayuan.chen@shopee.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: 01F442152D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264479-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 19:38:12 +0800 you wrote:
> syzbot reported a kernel panic [1] when an IPv4 route references
> a loopback IPv6 nexthop object:
> 
> BUG: unable to handle page fault for address: ffff8d069e7aa000
> PF: supervisor read access in kernel mode
> PF: error_code(0x0000) - not-present page
> PGD 6aa01067 P4D 6aa01067 PUD 0
> Oops: Oops: 0000 [#1] SMP PTI
> CPU: 2 UID: 0 PID: 530 Comm: ping Not tainted 6.19.0+ #193 PREEMPT
> RIP: 0010:ip_route_output_key_hash_rcu+0x578/0x9e0
> RSP: 0018:ffffd2ffc1573918 EFLAGS: 00010286
> RAX: ffff8d069e7aa000 RBX: ffffd2ffc1573988 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffd2ffc1573978 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8d060d496000
> R13: 0000000000000000 R14: ffff8d060399a600 R15: ffff8d06019a6ab8
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8d069e7aa000 CR3: 0000000106eb0001 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ip_route_output_key_hash+0x86/0x1a0
>  __ip4_datagram_connect+0x2b5/0x4e0
>  udp_connect+0x2c/0x60
>  inet_dgram_connect+0x88/0xd0
>  __sys_connect_file+0x56/0x90
>  __sys_connect+0xa8/0xe0
>  __x64_sys_connect+0x18/0x30
>  x64_sys_call+0xfb9/0x26e0
>  do_syscall_64+0xd3/0x1510
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop
    https://git.kernel.org/netdev/net/c/21ec92774d15
  - [net,v4,2/2] selftests: net: add test for IPv4 route with loopback IPv6 nexthop
    https://git.kernel.org/netdev/net/c/46c1ef0cfcea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



