Return-Path: <netdev+bounces-259198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H+8DCVU5lWnXNQIAu9opvQ
	(envelope-from <netdev+bounces-259198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:00:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6353A152E7C
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3243032674
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 04:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E21280327;
	Wed, 18 Feb 2026 04:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPPD1VKq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FF199920;
	Wed, 18 Feb 2026 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771387216; cv=none; b=t8t/yWkyNW9i4Q4/90nv4zIbVe+/Rh3WaFrMgr2B2Qf477OetbzHJdwLshjOJNkeJvGNXuiGr9ctle9Y1NAliQEB8BlnENeq6lSTYl34cSwKzPSnaeoTwPA2a6/Ox59ZoEZNVxRAu1XiEc37/6KOVIIJLYTfveVSyXA7n1tzwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771387216; c=relaxed/simple;
	bh=jCDFTWj8B28n15p634bpYjKVmP/NY91tKfteMX7riKs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XEA/B6Zc2a5ePvEiNpEYRgl3THoMHn3G/Ju9v6qvGYSQULvbEAcKxMa90KzKn5T2TUK6mkH21tcER+FWblnNmdt7ZZtYR9tFl3afY3iD1/f6Ue2ARBHpC+iQW34U24Y2OkC8j7hAx2qmKNPwQBjAOA3qQaty3nzwvFY2FDkKoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPPD1VKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611AFC19422;
	Wed, 18 Feb 2026 04:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771387216;
	bh=jCDFTWj8B28n15p634bpYjKVmP/NY91tKfteMX7riKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MPPD1VKqklEdHzX05FVGx7RPhgd9EGe98buqzaU3cvMERLEJXfZ7vqFUkchLnZl20
	 gdXu3dsKVx84ijB90LBx8D8YdbPw9g+U01yHlGfW1oZbjQD/bj1vkJxteuApbz6VjP
	 VjuTObt2b0nmPdcTYLU0pLmhcJAIhjHCFDFAE49ZIsEjf21YNk8D/75jig+fOgklKU
	 hDt+o9XfM8Jp4xDIelqUmISp43DbOd6MDZWf/zCwtW4K6HkivGKgZdwj677j+BSpMp
	 NWJc0N6dvcAcboICzPeHh/1M+sUjwr+yXOhxRPjQs9MgeUOAgwBAZ8vmfvp80h9V27
	 JACE3kq+lWDNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 481383806667;
	Wed, 18 Feb 2026 04:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/2] mptcp: support colors & display iface name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177138720782.803761.5504004597190844411.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 04:00:07 +0000
References: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
In-Reply-To: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259198-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6353A152E7C
X-Rspamd-Action: no action

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 11 Feb 2026 13:03:16 +0100 you wrote:
> Here are two small patches to support colors in "ip mptcp endpoint show"
> and "ip mptcp monitor" commands.
> 
> Now the IP addresses and interface names are printed in the
> corresponding colors. "ip mptcp monitor" will also print the interface
> name if any.
> 
> [...]

Here is the summary with links:
  - [iproute2,1/2] mptcp: monitor: also show iface name
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=ff8a8423f613
  - [iproute2,2/2] mptcp: display addr & ifname in color
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=55600ddd9b6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



