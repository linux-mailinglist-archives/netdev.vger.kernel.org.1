Return-Path: <netdev+bounces-274604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGHqLbOOzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:43:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DE438B62E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E5A30641EB
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAE33E5EC2;
	Thu,  2 Apr 2026 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/e69tg4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D03E2742
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144428; cv=none; b=hzQeySxc9qolv+rgiy4HoOjPS0ljMkXj6xI6IouAiWkWT2njM8DMMOdqgnIf9f0icLXnfn/FeTsBU15Lec9lVQDFlnngJheGmdxEKV9SNe56IrPRbtv+rVKmqUkxqsfMdZ/iLVLKwz2lpaTyBcZDKGRL2amPFKRHKjWPhJ9PV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144428; c=relaxed/simple;
	bh=r0rEiWehRwphm/iSijPiu3+oSp9+1l+MebVCFoCJMvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JMpK99Gf+8CSOgO5zUMk+fhZXGL8NCV6oO5rWQVXaNCEmI1YLqeHziim1EccMXHfdZaVA0v66mWscuoFNn0uBXf4ULwMdTkxJdQAfzRuJ2/qDusIvMjyshT1mLHYqEFEZ8VrNatBkVPE9wvatlIEEWRzrUuMVDpn6syzfX1sJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/e69tg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBEBC116C6;
	Thu,  2 Apr 2026 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144428;
	bh=r0rEiWehRwphm/iSijPiu3+oSp9+1l+MebVCFoCJMvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q/e69tg49xSby2Pmr+oP05piLDjNiVCW4EVNo65MkkMnEdt3XHSKqn9nHjav0XbwT
	 ZQ/kn9m4BvkuNEy68AtnkuFdUKy9o3UwWhFjmAJ1TrEFesQFKqdO/GXN8e6FbW7yRg
	 Tdm6nvAZ2XU65b6XFPf6XjYOIBY5bcvySTwly2gTHyIuQc0kYFhxnFFyGOQow/krfU
	 U8OanVMzjhAyY2+FVlZmLGLbyUjNbV2+K65ne6vw/LX8eKS0O76Npf7l/KuVeCbvsb
	 Fw0F5fLglq5vtemVRWgncFWlfhkl//ZVXtVrJ5fSfZmB3tMtDLrwmPeTtVJwu1E4xH
	 9FyxQC4RrVXmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DAC3809A05;
	Thu,  2 Apr 2026 15:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net: hsr: fixes for PRP duplication and VLAN
 unwind
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177514441079.499423.6384595967284377573.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 15:40:10 +0000
References: <20260401092243.52121-1-luka.gejak@linux.dev>
In-Reply-To: <20260401092243.52121-1-luka.gejak@linux.dev>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, fmaurer@redhat.com,
 horms@kernel.org, bigeasy@linutronix.de, m-karicheri2@ti.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-274604-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0DE438B62E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 11:22:41 +0200 you wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> This series addresses two logic bugs in the HSR/PRP implementation
> identified during a protocol audit. These are targeted for the 'net'
> tree as they fix potential memory corruption and state inconsistency.
> 
> The primary change resolves a race condition in the node merging path by
> implementing address-based lock ordering. This ensures that concurrent
> mutations of sequence blocks do not lead to state corruption or
> deadlocks.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: hsr: serialize seq_blocks merge across nodes
    https://git.kernel.org/netdev/net/c/f5df2990c364
  - [net,v4,2/2] net: hsr: fix VLAN add unwind on slave errors
    https://git.kernel.org/netdev/net/c/2e3514e63bfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



