Return-Path: <netdev+bounces-267283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMUSFqd7s2lmXAAAu9opvQ
	(envelope-from <netdev+bounces-267283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:51:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC36827CEC4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3ED0308930A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ABC34846E;
	Fri, 13 Mar 2026 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUB62Ei6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D721254B
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370224; cv=none; b=PFC3fr1QmT6I1KS9MIK09RncW7Yagt5QniH/nEzpQfmmLtGi2D8RgT4Ohu+lPwo7LPtLBIDyx7mvz1iuW3L3+Udg8zu6L0xCKUVvG9whiCUz7ZUWW2rG+dBJo512SJCY0e4Gl7iUkpcvXzEDnXuk/bRM8EMJNdUul9/4CyJQeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370224; c=relaxed/simple;
	bh=Q0hvCjp6JJ4AB1OeNuOK31izG1B7q2aMxuV4GOVPEGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ufmFiMSwBUtON6kTl2CdIzC60TGvJmHH2nosHrlqFsdgbolJJPFpU0goI+XyIbJI7WKNqpDk4Wa4N+SPqGZCu248Ab7O5T4ZcsSfh8kNQ8cxED/WnY9E9yzLS4HwSlwUZBqgBJd+eoCOAAwX+iHBzfRg1UF6EMoDatPb0L/TpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUB62Ei6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28D1C4CEF7;
	Fri, 13 Mar 2026 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773370223;
	bh=Q0hvCjp6JJ4AB1OeNuOK31izG1B7q2aMxuV4GOVPEGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mUB62Ei6xj4ZvpDx/Z5ZRPMJMvTQPFfSc0WEeSEVUze9n063pN0cdi/Zcbl84DcWw
	 t6BRexzpE8gWZN0Nnvz3bjX9w+yQL1jWSj+3cnjPVFDLBBAouqRhtrGEOYPPyTunm0
	 A6FejeoeB1f8z8TCA2aZWMLgsXE6qBbzAkWZsIJskrjEv0+0Xxg8eUR0xh47Di+Mk8
	 5GaSCMp0UUOf3OhUnOQGbM18ANFBjL0lJHw5hTThWpD6pKZi39xasUBIZuipgV2RXh
	 zgOjnQg3rC3wxleYP15snqdK2SXsC/66ITJkAt5rac6RM9qBE6XhWNq4HCCfIabhUv
	 Wuxm9IpEe2zBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FFD13808200;
	Fri, 13 Mar 2026 02:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add skb_defer_disable_key static key
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177337021879.648356.15343530566134180585.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 02:50:18 +0000
References: <20260311191340.1996888-1-edumazet@google.com>
In-Reply-To: <20260311191340.1996888-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267283-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC36827CEC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 19:13:40 +0000 you wrote:
> Add a static key to bypass skb_attempt_defer_free() steps
> if net.core.skb_defer_max is set to zero.
> 
> Main benefit is the atomic_long_inc_return() avoidance.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: add skb_defer_disable_key static key
    https://git.kernel.org/netdev/net-next/c/08dc30de1a40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



