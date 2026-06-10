Return-Path: <netdev+bounces-297400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gNN5IErEKGohJQMAu9opvQ
	(envelope-from <netdev+bounces-297400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:56:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C3A665599
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:56:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Uu63IO4H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297400-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297400-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47ABB318683B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A9B2EC086;
	Wed, 10 Jun 2026 01:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F531E82B
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:50:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056223; cv=none; b=FWtNCv+1V5nGuTLQKGf6K6W67RegscOZwpuWoR6cI/pmDzLJ03tX15hMxZaFUk75td2hc6MMxlc7j2FBh/BBOAUdUAD7Yd/i59BvTSfbJWfYVqqPEUr3CcU0xwlLA4gvFqe11pt0aRJTDUD8sgt0zrcmgBwiH5aY8gk4oVm5QNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056223; c=relaxed/simple;
	bh=LL1XWD12sOBB9Y8SkDuDfLUwLa7IsxXKcHT2Rqy4N54=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I7Hb9m6ag1J4aTeA0NPtebM6i9kG+puxN22lV6HQeD1947CadSEdO+WgcMvPpNgj1KCVBCm8vuIMjc4NH6uZkHSSOhS090XQkbByj0H8SGJu4SWEZTe/C6EQrgq38F/mNKfy5rRpqlEeSsnuIlVvoTODeRCByZn06FoUJSkcvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu63IO4H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13DA1F00893;
	Wed, 10 Jun 2026 01:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056218;
	bh=/5DxXNs10tNJRqyXjghLiRLXkHewE0be+FHWTe59cRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Uu63IO4HDG6/nde4ecgnii/s0FkAcCCjPQK5kdDX3Wpci2ZfHYpFBk1mzwyUV8yKW
	 NUp7MF5Nkc6tJAIkysrb5vafoSnRi9wdK3KuPSiXmm9z2BLcJJH/gfrxZx4w4B76GQ
	 ksEt1koZtfIN1fdaGfodTahYbCmUCiTLRFdixyibBdi02vR23tkn//mn74tKb4K0Mi
	 daXKUwUq4RI6TGx24dN6enE4Be9O6f0t/IH+1upi8LO2fAzyaDQQu7btNAeOkIEVj6
	 kHQH7+1YJCT6DRjewLchcspZf7nMCZx47wuv58uR9v8llya8mxihAw8y1d67qQVJu7
	 Si5K+MCKqnNfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568AB3930A1F;
	Wed, 10 Jun 2026 01:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: add getsockopt_iter binary to
 .gitignore
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105621588.2788910.10948549249505767466.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:50:15 +0000
References: <20260608112259.4022-1-fmancera@suse.de>
In-Reply-To: <20260608112259.4022-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, leitao@debian.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297400-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:leitao@debian.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1C3A665599

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 13:22:59 +0200 you wrote:
> The generated binary for getsockopt_iter.c shouldn't show up as an
> untracked git file after running:
> 
> make -C tools/testing/selftests TARGETS=net install
> 
> Let's just ignore it.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: add getsockopt_iter binary to .gitignore
    https://git.kernel.org/netdev/net-next/c/f511d2c4e074

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



