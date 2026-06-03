Return-Path: <netdev+bounces-294530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MmxtCGCWH2r7nQAAu9opvQ
	(envelope-from <netdev+bounces-294530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:50:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F773633B60
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:50:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RVIMr5GU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294530-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294530-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B33A301EB71
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2883D8117;
	Wed,  3 Jun 2026 02:50:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F5351C2F;
	Wed,  3 Jun 2026 02:50:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455005; cv=none; b=BPYjb3JQVJkNt2BcM7NFrDhUgQvoKOf/LKJmoWFjuEEAqImUJFUeVct+c3yDe6ny4elkfkmo9mvSGLGeUENTs4ls9Hu9o9MmgdRsv8D2v58J4pAYzIsTHyHbzwf3E0lrJTZjPZUVqiOJzYVWOPSZslImewGQ7XFyJFJwT65P/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455005; c=relaxed/simple;
	bh=He1Q7jufBic6VclbSfjYVqkg21Zw9y6mwNjq0c43fAo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e2f7H4za508J6QB+QqcyKQIQjMqg/2M7YUV5GKQdRz9kcUquLw+RYlOpEmx5/CgWevjvJweT+/pG5qOnVNLltikzzI37BiYL17Bp+Y5H2tawJRGZUX5CLCVgxrWo/ExmewlEFnGLTWucpB0Y7Lw2ipux92O/xn/9YG0LqqoZnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVIMr5GU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7683E1F00893;
	Wed,  3 Jun 2026 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780455004;
	bh=dPwv3kbr9oAOiRy1rCKbnYSPg/dqZtjZkAL3xmhkGz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RVIMr5GUpoWHQNEizkkFxyO2jPXWwWjP2HOPGC/9SLVgVLGMKkJKxi9sBL+RhUyMX
	 F+6xmS/g6YJAZUWBRsW24g8gbshy2XexRYamlg3DaA1s8rWvl2hgaA+ieqUegf4Z75
	 3rLt8mavDaEBIxivugy9dKYZmp7AcT+JADxuW0AcnoTwRXDLdkSUGPNw2ALSOWZyi4
	 ju5xm8IhzaA/CCo4BPlKR5CdAr7UzRtbzjU3p4ocv/opQVjyQ/VywP0wgWnproZB0V
	 TSR76liBr9yWFUQ9MBbNwBmNqCZ9JfxY/kazUDLdHqNvg5Ta9x7zLHuEINiv7lyVVJ
	 UPklQNbxMEAKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688B393003B;
	Wed,  3 Jun 2026 02:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: anycast: insert aca into global hash under
 idev->lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178045500615.1183919.5145496310272778664.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 02:50:06 +0000
References: <20260529152219.235475-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260529152219.235475-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org,
 syzbot+819eb928d120d2bdad0e@syzkaller.appspotmail.com, kuniyu@google.com,
 dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294530-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:syzbot+819eb928d120d2bdad0e@syzkaller.appspotmail.com,m:kuniyu@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,819eb928d120d2bdad0e];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F773633B60

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 23:22:18 +0800 you wrote:
> syzbot reported a splat [1]: a slab-use-after-free in
> ipv6_chk_acast_addr(), which walks the global inet6_acaddr_lst[] hash
> under RCU and dereferences a struct ifacaddr6 that has already been
> freed while still linked in the hash, so a later reader walks into a
> dangling node.
> 
> In __ipv6_dev_ac_inc() the aca is allocated with refcount 1, then
> aca_get() bumps it to 2 to keep it alive across the unlocked region.
> It is published to idev->ac_list under idev->lock, but
> ipv6_add_acaddr_hash() runs after write_unlock_bh(). A concurrent
> teardown (ipv6_ac_destroy_dev() from addrconf_ifdown(), under RTNL)
> can slip into that window:
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: anycast: insert aca into global hash under idev->lock
    https://git.kernel.org/netdev/net/c/f723ccaff2fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



