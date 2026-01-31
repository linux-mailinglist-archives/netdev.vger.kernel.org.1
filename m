Return-Path: <netdev+bounces-255502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN8vI/lcfmnfXgIAu9opvQ
	(envelope-from <netdev+bounces-255502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 20:50:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0EC3B93
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 20:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38486300DDE9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E6D35E536;
	Sat, 31 Jan 2026 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4C8ELmJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCA2C0F81
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889014; cv=none; b=oE8UiF92BYWdgHQz6C0gdgSjB+CnBFZWL5lsqJdN8CMtPm58meI+hR32V5tT9dBAxCEFymqniFllOHLzHQ1G0iUR+lD6jplrAiFen2lOOgl5pC8lKClxPNei37Wvh+sWUqtmcMrXORDMKJs4AvPkl+tWt2NmlP+Ck7lf3qQEhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889014; c=relaxed/simple;
	bh=n/i8YbvvBVIYjFIE8pAiIV6lyzqV5egfdgrxbTsb+2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oiu6mskLbIjNSe26seIqjSxdCYYyGcblC1SqJaOpr/tlDFtykOxdSlvqYo9NVPGbJEL0I9kOI3OuTH2hkB05CrpZadvzIM7963lFkYhChOniCzLkAk5m9HiEG5jF2Ip9lhpjwlWtD4c9kpuVLKGUS3D3NI0qWyqRLYL0EPAAOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4C8ELmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459F8C4CEF1;
	Sat, 31 Jan 2026 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769889014;
	bh=n/i8YbvvBVIYjFIE8pAiIV6lyzqV5egfdgrxbTsb+2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q4C8ELmJnI/kcc4Z5a/XsU17uJdIkA0uFYM7LUum4XXoqpSmn5pMq1JHmQkA5d9Gy
	 bLxbocH4EOrhpJEBpQ101iIRMKqj5B/1lQjeXP6aJOcCknPNyPp67yCKjP7gpxN4KB
	 dkQght1eZRKcD0wZJemLi43ANquHbcffTSq06DUTMwo3Rq/6Th4xnQDfpYAu9dSyJT
	 LRJhglX9PVZAB9icikRdWI5HuSwRHQM3zU6Ct0aMBn79X+p67Yqb3LLEbmt2evqZkq
	 M2mDpcxazFnRQICVseFSr3I+FZXYY+Kx/4HlUbbxAh+C4LCGz8uhSCw+aTlztqCxbT
	 nfHA81671fKJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EAE7380DBD3;
	Sat, 31 Jan 2026 19:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] man: Fix spelling in tipc-link man page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176988900611.4174530.10079504144242944655.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 19:50:06 +0000
References: <20260131191741.32416-1-dsahern@kernel.org>
In-Reply-To: <20260131191741.32416-1-dsahern@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-255502-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDB0EC3B93
X-Rspamd-Action: no action

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 31 Jan 2026 12:17:40 -0700 you wrote:
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  man/man8/tipc-link.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2] man: Fix spelling in tipc-link man page
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=72f679c0d076

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



