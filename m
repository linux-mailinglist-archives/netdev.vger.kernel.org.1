Return-Path: <netdev+bounces-80580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B6987FDD0
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0171F2289D
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FED3F9EC;
	Tue, 19 Mar 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlhYNhdk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C5D3C06B;
	Tue, 19 Mar 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852629; cv=none; b=E5CDB2JXg/r8cCs51D92brhSjz3WVL52iR37aWjSbS6GGdPse3xqW2+5QS3R15brR7vrDhhBcqG6ATkZdwvLyRNdLUIjlmJi/QAtNUu+AxYtZzkbItEji4jq+VjD0xkvdDl/7Yw2F/SlTgNkDR/53SkTbhokzt2XJaeZSZQBJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852629; c=relaxed/simple;
	bh=PnKMo3jI0/DL80nOxjATy+elReu2G63BZ+c1UWaPKdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QFWSkmeHxXlOJRf5a2odP6ZmJhQvfu+ot9v+9Nos4SfiDxpziSmxP9VHZ4z2xaivy2vhV1TdUl0moDDg17sHtpobvTpA/iI5BG9K7YtAYtXsNejt4+pvz6dl3nqYE9Fn9IJBllyhjv+rQY6VVbCPurWlTCsxlOoh5vCnnB9aaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlhYNhdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2173C43609;
	Tue, 19 Mar 2024 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710852628;
	bh=PnKMo3jI0/DL80nOxjATy+elReu2G63BZ+c1UWaPKdc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nlhYNhdkA3O0DBGhgQXPEbQkIk8cOnQG4g8fB4jGAU8fauYVNRB8fTpN4RNzaKgV1
	 yss4TLsDEAu99TvzGFJ4b1OCPWKyi3bu6XU/AlD4yIjFg7QLlXx9mIc5PMy1Ivq5Vr
	 qTFMJAkKXBq2zCA+dL6y7IP1eWXOXJxJ8QCK+XMyjdu5xuy1C0NURILDp64/xNdLqO
	 uo6nD/OsJ3J+ehvkNwV6x2wML3a3exICM9TAYWMqTqdrccRZaUMcu2oY+tfUWe1LKa
	 buNNpzaC4XwQxYNwoS33JruU2aCvSnjuezxU88VNGhX9i1A+Iqyiqv0tmmbjicj/DY
	 Vm7LF4KBFddQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 987F8D982E0;
	Tue, 19 Mar 2024 12:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V2] bpf/lpm_trie: inline longest_prefix_match for
 fastpath
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171085262862.28386.4132852347769986084.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 12:50:28 +0000
References: <171076828575.2141737.18370644069389889027.stgit@firesoul>
In-Reply-To: <171076828575.2141737.18370644069389889027.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, borkmann@iogearbox.net, ast@kernel.org,
 martin.lau@kernel.org, netdev@vger.kernel.org, bp@alien8.de,
 kernel-team@cloudflare.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 18 Mar 2024 14:25:26 +0100 you wrote:
> The BPF map type LPM (Longest Prefix Match) is used heavily
> in production by multiple products that have BPF components.
> Perf data shows trie_lookup_elem() and longest_prefix_match()
> being part of kernels perf top.
> 
> For every level in the LPM tree trie_lookup_elem() calls out
> to longest_prefix_match().  The compiler is free to inline this
> call, but chooses not to inline, because other slowpath callers
> (that can be invoked via syscall) exists like trie_update_elem(),
> trie_delete_elem() or trie_get_next_key().
> 
> [...]

Here is the summary with links:
  - [bpf-next,V2] bpf/lpm_trie: inline longest_prefix_match for fastpath
    https://git.kernel.org/bpf/bpf-next/c/1a4a0cb7985f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



