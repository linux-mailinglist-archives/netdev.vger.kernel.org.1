Return-Path: <netdev+bounces-265877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DaIKrSJr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:02:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 022FD2448F2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6D4F30AB8EE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716B35B626;
	Tue, 10 Mar 2026 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afNv6VXX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2A34C130
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111641; cv=none; b=i5SVTCU//7vo3KDrXqsi3OtThxZY1XKsY1B0lnJe0a1Hksd/tq0cu/fCU4OVIwOK7H/PRtgx3CdyqqJObq1vQ0VDaZa/UokaCiAKFtDgFvvTiEKPUWPinll/VXGW60TKGMCbvKxUwtXfwi/O5XfBvjLQUo85fE5Ur3JcisrrYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111641; c=relaxed/simple;
	bh=N/JiFdSwUaICuL4Zyo1wmFyfpvqXhiLaSHJ9GLSVwtE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AzGp6aKsHNQ7Tz4h6dpEfDiJ34AwWqrzLKpSfTfiby97tWzQ9vMY0As5eIOtfhMAqPburGDFkaJc4CV3bT6HO9M8rdBICnR48c/36sX04sMsBcYRnky2JKZzBjBgEzXrNkTG0TJl0qkzuWsx4+jUOvkAnf/5B7qHR8bXtMLLB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afNv6VXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4836C19423;
	Tue, 10 Mar 2026 03:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111640;
	bh=N/JiFdSwUaICuL4Zyo1wmFyfpvqXhiLaSHJ9GLSVwtE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=afNv6VXXPq4Nx4IHg2ofMk2xfDA2zm16GZeYAAjXlKPlaB4zPomlse+93kc+6mntq
	 182TN0/qMaXJEQHAQyD4hAVjO8bsv8M91p8RoeWITkhUSMvSBFus/RweDj5CSA7jE4
	 Kd/bhLkgi3swjz7+eZjbTm6B0DNqLUo1bNQGZXEw5iyzrTdPy7usuU0LB+X+2zLx2H
	 7ndtmYE5cVDvo2pXd0o47khqJrNBHlFPz95sjRza9Zbkr5/OvEpbW1JOn608MYMpOa
	 BIvj4G7L7stNK+OjgNFJ5YbIDag0uL6dexA+KHc2jBcKQWzKFK4Vnbh+g6xHCqAngN
	 hWVZx5FEEoO6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE073808200;
	Tue, 10 Mar 2026 03:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: refine indirect call mitigation in
 tc_wrapper.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311163779.2039470.9221132616218172490.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:37 +0000
References: <20260307133601.3863071-1-edumazet@google.com>
In-Reply-To: <20260307133601.3863071-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, victor@mojatatu.com, pctammela@mojatatu.ai
X-Rspamd-Queue-Id: 022FD2448F2
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,mojatatu.ai];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-265877-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 13:36:01 +0000 you wrote:
> Some modern cpus disable X86_FEATURE_RETPOLINE feature,
> even if a direct call can still be beneficial.
> 
> Even when IBRS is present, an indirect call is more expensive
> than a direct one:
> 
> Direct Calls:
>   Compilers can perform powerful optimizations like inlining,
>   where the function body is directly inserted at the call site,
>   eliminating call overhead entirely.
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: refine indirect call mitigation in tc_wrapper.h
    https://git.kernel.org/netdev/net-next/c/f2db7b80b03f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



