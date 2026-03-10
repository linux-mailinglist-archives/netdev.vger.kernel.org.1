Return-Path: <netdev+bounces-265874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PPuJYyJr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:01:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E999C2448C5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D38030EEDEF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B22512FF;
	Tue, 10 Mar 2026 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1/DRLvJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C118AE3
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111637; cv=none; b=ljoh4e3KZZE+8rSTbBLqZKxrgoGKPsL6BEaWlN2IU3VHt/Umok4PRujBQFQi1eDdM4EK57QloF8mFeS1IAeLgdR4zveMRTi7nxVTPywHoaRbLDihg5p0nNHUJRziIXn1qWZGD3itygLUffBSYf+xHkCq6A4n3/Clq4JG4NkDYUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111637; c=relaxed/simple;
	bh=SJCZn77p59ni0n3KfO/wQ85ZNr0Ptm8j/Dj7VIdNef8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qST6DHeNa9EoHnBpWMK0v3N/7OG/6rL+TBLGUmuOE2ImUplwGUbVkKMbMJBkDVkyU+dGgzvqgRoMiBV0cAherJlZeB+YL3UcBNtQs71LG7I51P/xyAPQwg4Tq3ZwCZgeVvFdTCJ437xJqaSkEEfXLm4ZHu/VUXe+ldCElxmf7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1/DRLvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7208C2BCB0;
	Tue, 10 Mar 2026 03:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111636;
	bh=SJCZn77p59ni0n3KfO/wQ85ZNr0Ptm8j/Dj7VIdNef8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h1/DRLvJmmDeMOQeJzQzxvU4LKX1yGooddF2t+ibuH0u2cZFWkx4e998R2dcQvGLY
	 X4kFWPG4VOAsnUc5ji7qRoYMA+aR7UQDWWth0dCCBKVVpe/bOqzhpgG35QtEU5wp3y
	 ya8h9oFSOCM9nmcDyn/SqyOrTZ7KDEwm0P50IG9FwfxRszHkpdxlRslBvzjopRSy5q
	 B7HqrmqfLiuUIoxDKzN5LPMR+LzDp6eAJDa1HxTw1Kw/DrvzpiNubrFqTHLX+onZNO
	 MageDnQT+iCsWQdIw6c25CrhVmdrlhJiZ08W1QiYnJqXtOY5aMKEL29pAVfg3kghHm
	 MZvI48Thpte2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BF53808200;
	Tue, 10 Mar 2026 03:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move sysctl_tcp_shrink_window to
 netns_ipv4_read_txrx group
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311163355.2039470.2125643117412064333.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:33 +0000
References: <20260307092214.2433548-1-edumazet@google.com>
In-Reply-To: <20260307092214.2433548-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: E999C2448C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-265874-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 09:22:14 +0000 you wrote:
> Commit 18fd64d25422 ("netns-ipv4: reorganize netns_ipv4 fast path
> variables") missed that __tcp_select_window() is reading
> net->ipv4.sysctl_tcp_shrink_window.
> 
> Move this field to netns_ipv4_read_txrx group, as __tcp_select_window()
> is used both in tx and rx paths.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move sysctl_tcp_shrink_window to netns_ipv4_read_txrx group
    https://git.kernel.org/netdev/net-next/c/e8eb33d650cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



