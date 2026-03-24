Return-Path: <netdev+bounces-271292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGjRKwX4wmklngQAu9opvQ
	(envelope-from <netdev+bounces-271292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:45:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE2231C7BA
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E336314771C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE993596F8;
	Tue, 24 Mar 2026 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stRmgJE5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACF33B6DB;
	Tue, 24 Mar 2026 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384829; cv=none; b=qAI8GsZCGj5NSm/2i7MwKp5dYSQPNYCMBnr/Vz3/T1fjK5j9CS6eonbC6zQSdasbK/ETeDqxnk3KVEiGuGK8hy8FINX+6BdwMsQpyF+dIb5BAY84YuNuqr0G2uauLjaNmSRwHAX6brDDfTBArdlwBf9Cn/Yl2IjQ+Zqi+Vu1DVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384829; c=relaxed/simple;
	bh=AXVmjvVZyew8e8l10D950wEi1i5nQpWip8A+64k/G9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uo4OG2LdTKfRqT5A7KNyjjGpoNJ6NwpyT081Z4mJ5zwS2uZID6Bww6IGH8o5RC5tFbE5UjORETP22US7UHBAI3S9e9I6xKvC6EedbQFMIGNLBfSsbObe75lBGXhc/ZVPaQajlFc3VXW8JDuIDQV88BzYxZQ3hWmw24VkX4j9ncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stRmgJE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBAEC2BCB3;
	Tue, 24 Mar 2026 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774384828;
	bh=AXVmjvVZyew8e8l10D950wEi1i5nQpWip8A+64k/G9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=stRmgJE5SoE23iYwr7bw4Q0H9NfMhPXhIhobUv70NrDm8ErnF96ZjFh2BDJ5/3YD2
	 0hRHUAPuMsYAaBFzCrjD8mbyNgDc6dtdC8c3SjRoy5ovVeahOaMjH0ln71CERQ86zl
	 QGoi9WNx+f18drwn/IwXORIe3vW5+ulqfJyVUMCqT5O6+J0asaYlrCApvWyhG2k2jL
	 XW8Ilc47bGtmki6gMZj8HFtkH/elWUDaQCign5R8Bqnk8NgnKNwCUyaCXqeAHPfKbV
	 nBTrDRhp+IGoOEph7m9gLM/4dkqXRpPudX/ZjjPzUATHxakVP5dNe1kf4DpE+7msl1
	 k2g2AaTxxQmvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEA03808203;
	Tue, 24 Mar 2026 20:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add multi-level pointer parameter
 support for trampolines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177438481628.1297770.15710276152087682651.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 20:40:16 +0000
References: <20260314082127.7939-1-slava.imameev@crowdstrike.com>
In-Reply-To: <20260314082127.7939-1-slava.imameev@crowdstrike.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-open-source@crowdstrike.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271292-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CE2231C7BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 14 Mar 2026 19:21:25 +1100 you wrote:
> This is v6 of a series adding support for new pointer types for
> trampoline parameters.
> 
> Originally, only support for multi-level pointers was proposed.
> As suggested during review, it was extended to single-level pointers.
> During discussion, it was proposed to add support for any single or
> multi-level pointer type that is not a single-level pointer to a
> structure, with the condition if (!btf_type_is_struct(t)). The safety
> of this condition is based on BTF data verification performed for
> modules and programs, and vmlinux BTF being trusted to not contain
> invalid types, so it is not possible for invalid types, like
> PTR->DATASEC, PTR->FUNC, PTR->VAR and corresponding multi-level
> pointers, to reach btf_ctx_access.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/2] bpf: Support pointer param types via SCALAR_VALUE for trampolines
    https://git.kernel.org/bpf/bpf-next/c/4145203841ba
  - [bpf-next,v6,2/2] selftests/bpf: Add trampolines single and multi-level pointer params test coverage
    https://git.kernel.org/bpf/bpf-next/c/e8571de53445

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



