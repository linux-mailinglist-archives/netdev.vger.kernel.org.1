Return-Path: <netdev+bounces-263043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAnAFqFopmljPQAAu9opvQ
	(envelope-from <netdev+bounces-263043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:50:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BEB1E9119
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB1FC3101DD6
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 04:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C112E541E;
	Tue,  3 Mar 2026 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixm2gBCA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2632DEA7B
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513226; cv=none; b=pU9+AeXR4uk8v+8rD3PAffzaDMwufzWSfaq5/8uOBdHUV7Tl9YfAvdGlLI8lUJYcmxU28Vvah91N1Au77x1+xD5913O03H/BivLdS/cmhLgU+U2iCGfZjDWmtgkpcqGl2oyKhLKhSHtusrbCr6wAr5pOGJqM0p0E3m6y5eh8NJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513226; c=relaxed/simple;
	bh=9UAcM0PnwplsMMTWj6SaZi0nTm/VBVk9KOgMZRW5uug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H9vxSJGriaLMXs8oIalGPLpwzH5qrp7QvixbP3G4+X+ruYmD+HKL3xcOaaV1oS9eBZarE2Uj9t/ZeuS+ro8ru837ud0ciWYN2bdszsq3g4T8YaHMcjLEk9tOp3EyU/YATRg0MgVAgu602BihqAGPs9xxyrIA30j02R/jtqKXbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixm2gBCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A541C116C6;
	Tue,  3 Mar 2026 04:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772513226;
	bh=9UAcM0PnwplsMMTWj6SaZi0nTm/VBVk9KOgMZRW5uug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ixm2gBCA+uMYEQOYvgDJwLEyjbzIhqhBXd74vtlwk1mJhuLXG1/E4uKpMLue0YhW1
	 dFg/1t0Mhn/Ue9S94CmbIWUIfW9LVbK35mJRvn6Kzxx7unA6SEIe3eUvLNUfCnCPwZ
	 YOMO6VsqCbK/EpDXuQumgK55vELRt21s9Yw/J8H19GfCEtnG/xFIciiFwQ8KmvY2Pm
	 u8RbbUU3P++iC50UCy2nfMgECetxlouqNqKogPeWQ8CJjzN1IxvGYkfEe2mZFfjXnX
	 b6NH0Ys6hgzwqAKHZqfjayyHqct9MCXIlcTw8tkO+6Ds81Jrz9r+zJoh9TLoOJIKVB
	 BjpOb3JEM6WuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD53809A80;
	Tue,  3 Mar 2026 04:47:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mpls: remove test against ipv6_stub
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177251322754.625663.4715533455698311741.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 04:47:07 +0000
References: <20260228175715.1195536-1-edumazet@google.com>
In-Reply-To: <20260228175715.1195536-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: B9BEB1E9119
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
	TAGGED_FROM(0.00)[bounces-263043-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Feb 2026 17:57:15 +0000 you wrote:
> ipv6_stub is never NULL, let's remove this test.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/mpls/af_mpls.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] mpls: remove test against ipv6_stub
    https://git.kernel.org/netdev/net-next/c/a0e8c9a5060f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



