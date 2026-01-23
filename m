Return-Path: <netdev+bounces-252932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHuRLUnMc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:30:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A7B7A275
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFB35301454A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116CE22D7B9;
	Fri, 23 Jan 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn5JleeW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E101DC9B3;
	Fri, 23 Jan 2026 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196615; cv=none; b=B45Qyo+uH4WsNfrViezNG1o6ryt723g5XZWeHB77nbbwQA7ZYDIVs/ISik92QPX/Fqi7KwtP33wUycxN05zc8sO8+cnk2adWzYnNEd4vgCwvdMEuaRD+DmTqXMz3Llylna03tP12O4bIVTC4Hqkb0csdbLqdlvJD7IwoRdsLi5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196615; c=relaxed/simple;
	bh=xfEXE2AnAULfW4hnvD3/ovp+1hD4RRxgZ5foUg2C1qA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FqtyJbY9F8uMWIK2zO5vLgyP/bDxWBA0uyWv9oLC3BvaOZoZUgKKz6BvfcUvEAf8IN4gezymBEwBWfYTuCAomPLUkPWfaGoZeejDzWS/fbPlVMgHyUS44EZZewcAKMFBmAOShMS6KHLolPtyKaYZZdZmdJINsY+knpiZJ24elYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn5JleeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C501C4CEF1;
	Fri, 23 Jan 2026 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769196614;
	bh=xfEXE2AnAULfW4hnvD3/ovp+1hD4RRxgZ5foUg2C1qA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nn5JleeWFff5zKRN7TamPwmxyCeLn27G250ZLSMFstpOn3RIN2V8Wx5zZsLlOO4hY
	 xAR4oEku07H3yBhFpuv/uXpBOqUnLvJbghPiuMEE34IAiVtnd5FDihQjO3IVEkB1T7
	 wrZuhO5tRhwSvFziMSnYoDvdIx35GQ/HN7HdWuToKcNLTooUucQ6U+Xbe+4lv+xi4X
	 K6HiaD4KqnABcyuPmxVm/fMOcLpF+2FSAm9ghLjFCvE+ZoEeUcUZbzS8jJ5QHj8kws
	 QURVmDXFf5l1Nj+XDJq3Uv1jaNuyJSnZB4Hz0gK8vWJ+uAx8AeQxb9MvI7D8g1384g
	 SRm4RSSQxHc+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BD813808200;
	Fri, 23 Jan 2026 19:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] Switch from kfuncs to direct helper calls
 in prologue/epilogue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176919661035.2689746.16918451024463235457.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 19:30:10 +0000
References: 
 <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
In-Reply-To: 
 <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 ameryhung@gmail.com, netdev@vger.kernel.org, kernel-team@cloudflare.com,
 martin.lau@kernel.org
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
	TAGGED_FROM(0.00)[bounces-252932-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,cloudflare.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14A7B7A275
X-Rspamd-Action: no action

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 23 Jan 2026 18:05:17 +0100 you wrote:
> This series enables direct helper calls using BPF_EMIT_CALL from prologue
> and epilogue code generated by verifier ops. The goal is to simplify the
> calling convention and remove kfunc support from prologue/epilogue, as
> suggested by Alexei [1].
> 
> Patch 1 adds the infrastructure to mark direct helper calls as finalized
> (already resolved) so the verifier skips the imm fixup.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] bpf, verifier: Support direct helper calls from prologue/epilogue
    https://git.kernel.org/bpf/bpf-next/c/af46ae41da7c
  - [bpf-next,v2,2/4] bpf: net_sched: Use direct helper calls instead of kfuncs in pro/epilogue
    https://git.kernel.org/bpf/bpf-next/c/5c2106d44168
  - [bpf-next,v2,3/4] selftests/bpf: Remove tests for prologue/epilogue with kfuncs
    https://git.kernel.org/bpf/bpf-next/c/d3ddc749df28
  - [bpf-next,v2,4/4] bpf: Remove kfunc support in prologue and epilogue
    https://git.kernel.org/bpf/bpf-next/c/68d23a660c4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



