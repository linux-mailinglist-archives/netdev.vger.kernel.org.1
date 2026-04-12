Return-Path: <netdev+bounces-277881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLjVI1H122lTJgkAu9opvQ
	(envelope-from <netdev+bounces-277881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:41:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BED23E5C08
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F25D93009CC5
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17F36A035;
	Sun, 12 Apr 2026 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzZUERMr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7E233704;
	Sun, 12 Apr 2026 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022836; cv=none; b=egbbKbAIxpEq0OgNdzdorHO7GhSOQZ0cQe4zMGpPUYzCaGqsxtZV1ifFOqKk2yVCV8+Bk+7hWnFnXWijkrHJViTOjLp/r2z9F+bpXtgsl9Blscg61u8N7uGi0YgS9OWEIEknlVjmwW9/i1bcTOh8ZW+GNI4aQ8pA1rQ1vfNYQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022836; c=relaxed/simple;
	bh=gh/bkYM96nJxGpANVa0EtYLT8J1Z8DIzURo/ioCEITg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WmkMGdYihE8aoUc/tIL0u9nLuMML2JeTQdrMTYU1f3j8hPQarfd4AG/CDV5Gctx0+HtShHFZqsrjsJTLh4EbFCtGWsSdOhPk+nzoKVWIDorm72cgsTQjg7c3kkexaOBwPfhxyOJ7aKbxUH2NNhQK9SuxfjH0vIYpZiikGIGpmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzZUERMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CCFC19424;
	Sun, 12 Apr 2026 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776022835;
	bh=gh/bkYM96nJxGpANVa0EtYLT8J1Z8DIzURo/ioCEITg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PzZUERMrDrfQrSqQv71usR6Ksv2CqP7uQfCFSNFsvJan2AFbkjOwzGS1fwMW8AJK9
	 O+QzrB5PyI7IlRPkKjv6na8bQapJI/7V1eYzusP3u5F9U2w2wAondzE8YKE52BpX8f
	 WH570wRKyFuoJrL55b9S+6OZlSaujar6MEB+EKZ99BzZv4OByxir+ek1Bh5ddCUl0A
	 XpFHYiWJbPvTWso9iabLVgD1+OQU0QdbbRZPEw1nhVYc6PHe1abQsp1BK/qMifrVqL
	 YEbf84xl7qYZRwm9MACPjeXB/C/Em0cI8IWbKMlhPSo1jKXW+qFwRiNZh5d3Yxna2c
	 MhLqgL8GX4Zug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCF13809A8C;
	Sun, 12 Apr 2026 19:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB
 read in
 sock_ops and add selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602280805.3388150.11022027756710396188.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 19:40:08 +0000
References: <20260407022720.162151-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260407022720.162151-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, werner@verivus.ai, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, sun.jian.kdev@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277881-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,verivus.ai,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BED23E5C08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 10:26:26 +0800 you wrote:
> When a BPF sock_ops program accesses ctx fields with dst_reg == src_reg,
> the SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD() macros fail to zero the
> destination register in the !fullsock / !locked_tcp_sock path, leading to
> OOB read (GET_SK) and kernel pointer leak (GET_FIELD).
> 
> Patch 1: Fix both macros by adding BPF_MOV64_IMM(si->dst_reg, 0) in the
> !fullsock landing pad.
> Patch 2: Add selftests covering same-register and different-register cases
> for both GET_SK and GET_FIELD.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
    https://git.kernel.org/netdev/net/c/10f86a2a5c91
  - [bpf,v3,2/2] selftests/bpf: Add tests for sock_ops ctx access with same src/dst register
    https://git.kernel.org/netdev/net/c/04013c3ca022

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



