Return-Path: <netdev+bounces-271141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGdQMeu1wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:03:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0EB3189FB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4239830596C8
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F503815D6;
	Tue, 24 Mar 2026 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta++6kia"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477037C107;
	Tue, 24 Mar 2026 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367427; cv=none; b=eydVxNznpwjGLxOL/Inu/mxD7CwS074BNmgK3haUw6RGG9cEWLa3i7Ns09kH35Zeld3ysfKok6AkbBuWcDjYfoi5IntcB0DImrM2BxlkbBuny5cCT/ZuxlNQEf+mX+GqVPElRpH18buOu6QgBjBqTFVau9vv0w0V7Rr128xrVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367427; c=relaxed/simple;
	bh=lUzpgOaZSUB8/OjHlDFH7uXL5wuh44/GpRoR8BJ2VOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VczeXVwITfEPMYQ5FCQP2rOXC+zRyesAYXLOvLGBzx0NJPSPj/T7GA5lJW/AZ/tt43U0XyIVCEQvyPU1nEuuxCgt2wx9fsg04PuQnqPtEbHVf5wB0qUp4xv3oi6nj70DbH2a+BBb/CYXoA45NFLxkHCTDMpZlHNOSWLhd30SdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta++6kia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25610C2BCB3;
	Tue, 24 Mar 2026 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774367427;
	bh=lUzpgOaZSUB8/OjHlDFH7uXL5wuh44/GpRoR8BJ2VOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ta++6kiaTtoL6bH9lfVxskE3axSC9qMCYiu/jZT4bPK0YscvuivxPN4ygUwvappRf
	 x+rA0LXgybwV/HPfuTYWqpYXVIwUKfo1xshEfq16+tWsx0xdKP08tAMnpKPrywnjrk
	 DfuSc4IKIDHp3V70kN3D1Di8VMqFSNRMWN/Bc/YBwPfLI0RJHEQ1ytHEFK7Nq/4b4Z
	 IiHQ0wpc1OOHgFbRLROtRLLnyGGS3S6/+ISFp64pMeC1ce68xyBHX+wpTwq36bp+ad
	 UauhP1EbHjxCo0Hmtf7FLdnlENMn9ithYFUCdFqZRuV6xq6mSDZU0Z0a70rP1PVSWj
	 oOGsxTSDq6RKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCB53808203;
	Tue, 24 Mar 2026 15:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: test_run: Remove ipv6_bpf_stub usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177436741504.1084685.17277728254539064211.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 15:50:15 +0000
References: <20260323225250.1623542-1-martin.lau@linux.dev>
In-Reply-To: <20260323225250.1623542-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, kuba@kernel.org,
 fmancera@suse.de
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-271141-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED0EB3189FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Mar 2026 15:52:50 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> bpf_prog_test_run_skb() uses net->ipv6.ip6_null_entry for
> BPF_PROG_TYPE_LWT_XMIT test runs.
> 
> It currently checks ipv6_bpf_stub before using ip6_null_entry.
> ipv6_bpf_stub will be removed by the CONFIG_IPV6=m support removal
> series posted at [1], so switch this check to ipv6_mod_enabled()
> instead.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: test_run: Remove ipv6_bpf_stub usage
    https://git.kernel.org/bpf/bpf-next/c/280de43e88c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



