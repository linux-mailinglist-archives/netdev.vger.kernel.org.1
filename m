Return-Path: <netdev+bounces-301488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tq1gKqPxOmrpMQgAu9opvQ
	(envelope-from <netdev+bounces-301488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:50:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC466BA210
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:50:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lyc2n1mI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301488-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301488-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E08273013C53
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEE7331230;
	Tue, 23 Jun 2026 20:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D73ACA7C;
	Tue, 23 Jun 2026 20:50:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247827; cv=none; b=ASw1O/eOm0AduKgBW3JQ1NE79QFwOUc8v7jdS8GoFgDr23qXffRDIU38AWE6HqvqoJrV01EPDmCSFIX3dUavSk/Fv0SiI/Tb+l4z32yq7KdrS5yJ2xaitvgdCrewfRN4XfwYzLc7h9L4x6N0RWucxOikx5GCbxM3XEf2BwZYmsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247827; c=relaxed/simple;
	bh=YoVVfnYPkqa27FTalLHq5H/8TBBYIGuzOa3jGRIdYnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iUb7ixGl6hScGOxmi2PGULzEAP6QXeobqXcUPuSTpXt17rgU7HvA9k1sjNzPoXqvgRhrMXVIUdfNhyfUWrwWzXXveRKZAuY0pypzVTgGyzS3AIDeRhwwbvcZiUpSnUxyh8c4Ym/UhZjlBrYFcQvF3Hx0eSzd3OIr+Qf+FQeOxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyc2n1mI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ACB1F000E9;
	Tue, 23 Jun 2026 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782247825;
	bh=Xt6aIhrvbwFjJyQUiZfjpHAiIDxb++JS0psq4z5/buI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lyc2n1mIqwItRV+MkTULqbCSwygjPWblG26lSsLc8QVKOr8ZseHj3Qi2Xa1Ixs5Bu
	 K8+xpbI/eD+fmEw2Tz7MDTD02AiYTw5pa37Z8FFvPkLFq52JkkWgJVczS9EkhXdD28
	 nomGQz3XplpzKg+S5iYOA7Z5rxsQFBtJRXjAQSyIYclHK2CSSVvX/fuT3g/+ZKHEKt
	 rR7/eqFHCR8SRdIZMsUIdzpjFz6X1e3gLCyl1BSPa1wps1ow7b8T4f2ty9Bc/7yo38
	 NtMtKvuAB6xZz+uDw9VKdh0WzJZxbIEjRMsVhQVx6X2uEi165TI0NGOU/YN/DLgXhO
	 SzNr8HwbomqKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A193931005;
	Tue, 23 Jun 2026 20:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test
 behavior
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178224781523.2413852.13473008974792105464.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 20:50:15 +0000
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, tirthendu.sarkar@intel.com, bpf@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301488-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BC466BA210

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 21:19:51 +0530 you wrote:
> This series improves AF_XDP selftests by making timeout handling
> explicit and fixing sources of non-determinism in xsk timeout tests.
> 
> Patch 1 introduces test_spec::poll_tmout and removes implicit
> dependence on RX UMEM setup state for timeout behavior.
> 
> Patch 2 fixes thread harness sequencing by attaching XDP programs
> before worker startup, removing signal-based termination, and using
> barrier synchronization only for dual-thread runs.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] selftests/xsk: make poll timeout mode explicit
    https://git.kernel.org/netdev/net/c/b56cded13137
  - [net-next,2/3] selftests/xsk: fix timeout thread harness sequencing
    https://git.kernel.org/netdev/net/c/483c1405f817
  - [net-next,3/3] selftests/xsk: restore shared_umem after POLL_TXQ_FULL
    https://git.kernel.org/netdev/net/c/ea4e9c9d8b2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



