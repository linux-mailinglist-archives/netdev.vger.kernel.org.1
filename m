Return-Path: <netdev+bounces-262067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDtNIxJkomnI2gQAu9opvQ
	(envelope-from <netdev+bounces-262067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:42:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F23871C02DE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D642E310B41F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76242D781B;
	Sat, 28 Feb 2026 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FktuuvM2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F128641F
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250019; cv=none; b=GzxwIrQ3mfg2gDkN21WCtmLwsmVNkl5XEfE6nrBewPDlKDLOv+/QDAi4z7HXJy12dEZdnUvfQbdw6xnjGrSeoBE7sAorpEeHFMB7/z7fLBfiodNBN8COzbjd2CrnKwJEWwqOjMPteKIv0oy4KdZ1vXk2YK9cQtt8YLEb/Ab4ubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250019; c=relaxed/simple;
	bh=kAFcivBh/YmAnVrXVFS3ef2m8XFZfMsZha1H779+DI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g5atdE4aDs4gFcf6VWEOFzbyejTEtejaPfm0/GGCOWoDTNJBebIwCPcZNOljkCRus+2Cd6YV/7DuBHXpCqagPMbLlTzABfjCZfSWNQfj0AAFqEFPjLk5zyLeMpImOhLCabmRIPSTQY5xLOoVgKVk8XM0zYGjam49B8txEhTJcno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FktuuvM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802A5C19425;
	Sat, 28 Feb 2026 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772250019;
	bh=kAFcivBh/YmAnVrXVFS3ef2m8XFZfMsZha1H779+DI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FktuuvM2ZyXivmHRyuE/lpouTK4WujsY6Keox05+yxUxG0gxYqY0m83MPCk7RJLEW
	 WBzjdrsuXYqN01yD6c3GDThNlEkrYaiVn0FBHGh7vteU2Vm7aNLZwr6TWGvMp1WFUC
	 5CJVQVPAA1p6S/uaDAMRO8uUJ6GDQyxh+jovtpaEYxJR0pXWqYlR9NkCIYddc2sKHk
	 8B3mKSsyImhMXr3TLfFRn1MV1roJ7RGtLnekGjwoS6njJbRcLdA02R0ZC/S0ddg3my
	 jzsuZ8Q36kyBwUNoR56iIUYJc7uVnEIWNJyhoKUgo2gUjnuwuGloIWRIVYx4OeSq2E
	 UOvy9FDC7mTYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD7539EF96C;
	Sat, 28 Feb 2026 03:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: inline skb_add_rx_frag_netmem()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177225002278.2855218.14659701353404601343.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 03:40:22 +0000
References: <20260226041213.1892561-1-edumazet@google.com>
In-Reply-To: <20260226041213.1892561-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-262067-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F23871C02DE
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 04:12:13 +0000 you wrote:
> This critical helper (via skb_add_rx_frag()) is mostly used
> from drivers rx fast path.
> 
> It is time to inline it, this actually saves space in vmlinux:
> 
> size vmlinux.old vmlinux
>    text    data     bss     dec     hex filename
> 37350766        23092977        4846992 65290735        3e441ef vmlinux.old
> 37350600        23092977        4846992 65290569        3e44149 vmlinux
> 
> [...]

Here is the summary with links:
  - [net-next] net: inline skb_add_rx_frag_netmem()
    https://git.kernel.org/netdev/net-next/c/6466441a5ecd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



