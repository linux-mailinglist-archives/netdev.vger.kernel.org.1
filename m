Return-Path: <netdev+bounces-257661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFT6HrdyhmlINQQAu9opvQ
	(envelope-from <netdev+bounces-257661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 00:01:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C8104031
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 00:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2DF7302D5C0
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 23:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB4630DD3C;
	Fri,  6 Feb 2026 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjO/7W1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A849659;
	Fri,  6 Feb 2026 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418831; cv=none; b=fNsN1JohnMaUf0ac91B10wGs+gs0sFp4k9xVmMx5V9CfwOh15akzIbiYXYH6k0RcOmqKv73WwpXoVk16jq+DIfaezhaM1GmGOZQ9XeVw1TKZ7clyuJekn/7YTdRdhvp+NcXGUXDXgHzrf2KKxyn8G3grKGSI1gpOaLbHO5sMgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418831; c=relaxed/simple;
	bh=mLy9KV0aGwWO2bQW20k9G/fysd3HLWDbfIqP1sPn//Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FOFOEZTSkGR0LMegZtIJhz/Qn/5aYhXrGJgcCR+kLMnkqcpiDnqPO87us51yoZ1a59Tbg9heMI2W+sP5x0sjuB7PgAi6VAQsE1tQgnloWzTSlCkHREM4kXQGl008WyKhEZEP+PWSa4KoF5fveg0vGjtIFBEooSOcotncJSsRnQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjO/7W1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C368C116C6;
	Fri,  6 Feb 2026 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770418831;
	bh=mLy9KV0aGwWO2bQW20k9G/fysd3HLWDbfIqP1sPn//Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hjO/7W1Q8QwBMWtluaR7g68piPHJ1vhcOkXtYKpDYn+FwFMrH4wRdnrsiEijYKCk5
	 QyBNS6BT1UCVthj+vt9z7HJ5ZmkA+tbV1daRiM4wDU0za6ZgR1kCVHw+IyyOAf1Kcw
	 hoXYDsxHsSgg6mYi97QpmEfsRAOQe+xX842MCTYiB5c8WKJTBiPAWOsUNsktiyKy1B
	 IsijJ9+U7yu0PonfeH95CXfQLxxJs1Jo4oC//J6eH0TMhcXNHrInBMqTg88d/g6zCi
	 mx2qqxnRV0oH2EdizD57hhdj5Wobkod33pFb7p+GRpRQLlo6L++9vpnf11TO9TWfLS
	 S/w+nyTB37cwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 855783809A17;
	Fri,  6 Feb 2026 23:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 00/17] Remove task and cgroup local storage
 percpu
 counters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177041882833.1106743.17316630593839442939.git-patchwork-notify@kernel.org>
Date: Fri, 06 Feb 2026 23:00:28 +0000
References: <20260205222916.1788211-1-ameryhung@gmail.com>
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
 martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev,
 song@kernel.org, haoluo@google.com, kernel-team@meta.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257661-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D04C8104031
X-Rspamd-Action: no action

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  5 Feb 2026 14:28:58 -0800 you wrote:
> * Motivation *
> 
> The goal of this patchset is to make bpf syscalls and helpers updating
> task and cgroup local storage more robust by removing percpu counters
> in them. Task local storage and cgroup storage each employs a percpu
> counter to prevent deadlock caused by recursion. Since the underlying
> bpf local storage takes spinlocks in various operations, bpf programs
> running recursively may try to take a spinlock which is already taken.
> For example, when a tracing bpf program called recursively during
> bpf_task_storage_get(..., F_CREATE) tries to call
> bpf_task_storage_get(..., F_CREATE) again, it will cause AA deadlock
> if the percpu variable is not in place.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,01/17] bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
    https://git.kernel.org/bpf/bpf-next/c/0ccef7079ea8
  - [bpf-next,v7,02/17] bpf: Convert bpf_selem_unlink_map to failable
    https://git.kernel.org/bpf/bpf-next/c/1b7e0cae85ac
  - [bpf-next,v7,03/17] bpf: Convert bpf_selem_link_map to failable
    https://git.kernel.org/bpf/bpf-next/c/fd103ffc57c9
  - [bpf-next,v7,04/17] bpf: Convert bpf_selem_unlink to failable
    https://git.kernel.org/bpf/bpf-next/c/403e935f9158
  - [bpf-next,v7,05/17] bpf: Change local_storage->lock and b->lock to rqspinlock
    https://git.kernel.org/bpf/bpf-next/c/8dabe34b9d5b
  - [bpf-next,v7,06/17] bpf: Remove task local storage percpu counter
    https://git.kernel.org/bpf/bpf-next/c/4a98c2efa613
  - [bpf-next,v7,07/17] bpf: Remove cgroup local storage percpu counter
    https://git.kernel.org/bpf/bpf-next/c/5254de7b9607
  - [bpf-next,v7,08/17] bpf: Remove unused percpu counter from bpf_local_storage_map_free
    https://git.kernel.org/bpf/bpf-next/c/3417dffb5833
  - [bpf-next,v7,09/17] bpf: Prepare for bpf_selem_unlink_nofail()
    https://git.kernel.org/bpf/bpf-next/c/c8be3da14718
  - [bpf-next,v7,10/17] bpf: Support lockless unlink when freeing map or local storage
    https://git.kernel.org/bpf/bpf-next/c/5d800f87d0a5
  - [bpf-next,v7,11/17] bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}
    https://git.kernel.org/bpf/bpf-next/c/0be08389c7f2
  - [bpf-next,v7,12/17] selftests/bpf: Update sk_storage_omem_uncharge test
    https://git.kernel.org/bpf/bpf-next/c/d652f425d5e3
  - [bpf-next,v7,13/17] selftests/bpf: Update task_local_storage/recursion test
    https://git.kernel.org/bpf/bpf-next/c/e4772031d105
  - [bpf-next,v7,14/17] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
    https://git.kernel.org/bpf/bpf-next/c/902a79b6389f
  - [bpf-next,v7,15/17] selftests/bpf: Remove test_task_storage_map_stress_lookup
    https://git.kernel.org/bpf/bpf-next/c/e02cf06b85f8
  - [bpf-next,v7,16/17] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
    https://git.kernel.org/bpf/bpf-next/c/cdce7b0848f6
  - [bpf-next,v7,17/17] selftests/bpf: Fix outdated test on storage->smap
    https://git.kernel.org/bpf/bpf-next/c/97b859b5ed04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



