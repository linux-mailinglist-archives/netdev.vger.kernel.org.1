Return-Path: <netdev+bounces-277655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Lw8H3PO2WnLtAgAu9opvQ
	(envelope-from <netdev+bounces-277655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 06:30:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 788913DE55C
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 06:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 234CD3008CB8
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 04:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F48219C546;
	Sat, 11 Apr 2026 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ3z7xEH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9228634C;
	Sat, 11 Apr 2026 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775881836; cv=none; b=mEQzFEUOWiJ/EP0XDb/E00mly2I9RFF0UGqPJLYLX6OC645zv1WD7OeT73Pv9W5VT5oPrBDu+Kd71EV9YZC3IStGzj2S5UBKQao9CExeB6YEnmaIpbiID0oFkRWQGKxrFI+GX8wOoeXrmtTjX0Dwyd00Ms5Kfd8BlBzZUkt6I+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775881836; c=relaxed/simple;
	bh=EfJvAHSqopgveL+8Zuy12MSflybmrNFNaX46qeVbOcE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fBrukKAQ6/pkuk0dnkeg8J+lDD32Xq1nhRgTWaKaG/9pdZ8/hJKnfsMQuFViK2D8EjG2Ps+K2lLXjXj4unsMe1uTusCN0WCVp5CMaIQkBObazqhYIejWTzTpD6H5SGt+wYHIoCV7luoudWKdjSm32UXFrU153Rxck/60rw4pRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ3z7xEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED43BC4CEF7;
	Sat, 11 Apr 2026 04:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775881836;
	bh=EfJvAHSqopgveL+8Zuy12MSflybmrNFNaX46qeVbOcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IZ3z7xEHrpdaCOnmYBHNz5V8bRy5Vca9+DSJddg0eEV5HsoomIvCN7V0/bcjxedel
	 uasPUc7cr8pqgqE61Ih4YwBhPRHgMdCI94svKdcq2ijZLc+mDalLUUK3i2Qzi8SHai
	 NnRr3wrhfmjvPfA569VpBuRYByDXsGRnYmi9xauu7F3LVdaqQHkIY6W48JveIp2Q4w
	 U0WZ9A1ug+fKUzTu54jrYa1pW3dFx/44Jy7IGdMy1qhgLvGQcNyDwHydjhFwd1ae/V
	 bTW1uFtEwHptgGP+1XY8awUU7ikI+AAgFBfJniBsY12dfV4YoPgtPEjelXEtnkxFLM
	 28VlOoz/2ksFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FECC3809A88;
	Sat, 11 Apr 2026 04:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] Use kmalloc_nolock() universally in BPF
 local
 storage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177588181004.2848829.17944955611291612928.git-patchwork-notify@kernel.org>
Date: Sat, 11 Apr 2026 04:30:10 +0000
References: <20260411015419.114016-1-ameryhung@gmail.com>
In-Reply-To: <20260411015419.114016-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 memxor@gmail.com, kernel-team@meta.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277655-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 788913DE55C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 Apr 2026 18:54:15 -0700 you wrote:
> Socket local storage did not convert to use kmalloc_nolock() since there
> were observable performance degredation due to kfree_nolock() hitting the
> slow path and the lack of kfree_rcu()-like batching freeing. Now that
> these concern were addressed in slub, convert all remaining local storage
> flavors to use kmalloc_nolock().
> 
> v1 -> v2:
>   - Fix build (CI, Alexei)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] selftests/bpf: Remove kmalloc tracing from local storage create bench
    https://git.kernel.org/bpf/bpf-next/c/78ee02a966ad
  - [bpf-next,v2,2/3] bpf: Use kmalloc_nolock() universally in local storage
    https://git.kernel.org/bpf/bpf-next/c/5063e7758899
  - [bpf-next,v2,3/3] bpf: Remove gfp_flags plumbing from bpf_local_storage_update()
    https://git.kernel.org/bpf/bpf-next/c/136deea435dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



