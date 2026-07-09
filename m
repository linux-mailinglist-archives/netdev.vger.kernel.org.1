Return-Path: <netdev+bounces-306178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y4iUNvB7T2qnhwIAu9opvQ
	(envelope-from <netdev+bounces-306178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:46:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C972FD13
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:46:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="IE7eG/o9";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306178-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306178-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA7713093A59
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEF740B37B;
	Thu,  9 Jul 2026 10:40:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299140628C;
	Thu,  9 Jul 2026 10:40:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593632; cv=none; b=q4pS0W6MaoXcWqmL9dBwdT40fFXC1fIEvAGwGW04oIMssjvx8xxx9H8STt1iMMgWcA2RsFtDVDKelsVnBFs+ROy2ZUd9/BeqxzsBXGVUK5rfhkbTsGV66hcV+P1GKSxdgq8PtZOvuZ60Mi3qx/1Vjz6L5zjAR1RPmjdDfks6VWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593632; c=relaxed/simple;
	bh=GWwclCBpeV2Cq6fJVK1v3rRfOVXzB7wH2YAo3pnIoZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kV+Wv7q6qgPv1T+uEP2HtVlg+jaE9em1JhWQLp7bVXCTD8GSjslfanyMP/3VU5z3+QDMHk+K0rbVEar8p33/ASjxcG9avNccxi5sp6HUWzumm+SaJOXf6du+2VoyCESwMPLYNlyMPhjy/FUuqN1P4yNIrQmfUHDeBQbGjbkKROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE7eG/o9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4201F00A3A;
	Thu,  9 Jul 2026 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783593630;
	bh=C9FKNrNA8q+iO/rANodd+gADIq21KYWiq+7C8UVnt8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IE7eG/o9iazHUZwIumf5va/7XaPY+bKGEtYvYGhgvjjwYC+gXBpZm/Ik3Vff9egwt
	 aQI4O4ayn8emEW/NUWxWmHRze9l9y8MxjajcjJnfb60sFpCpfDyQmlFRQ0ktdWt/vX
	 NaKbdO8rs7t3DQ4DUeFlS0vJDm00jBPsk9Qv5dT2iadNEgv2cxSPxktFywWjfmMdt9
	 +w6Yx5tgy+1l4cv+pumoprHlXlD/w7CyaS/Wv3oo9uck5P0ApJUBDZmHc4T2LnGsre
	 RxFm7SitJ2sr5pjA1+KPO+7SBzTrrYJdFw2OIWp+v83TyZjZnflJneDmTUx6DfWu1T
	 Gg46Sdc0W5pBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1996639D609B;
	Thu,  9 Jul 2026 10:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: rss_ctx: Add retries to
 test_rss_context_overlap to reduce flakes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178359360864.3403147.1744210090391033845.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 10:40:08 +0000
References: <20260702164932.2832916-1-limzhineng2@gmail.com>
In-Reply-To: <20260702164932.2832916-1-limzhineng2@gmail.com>
To: Zinc Lim <limzhineng2@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, zinclim@meta.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306178-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:limzhineng2@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:zinclim@meta.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 351C972FD13

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 09:49:31 -0700 you wrote:
> Similar to commit 690043b95c18 ("selftests: drv-net: rss: Add
> retries to test_rss_key_indir to reduce flakes"), implement the
> retry mechanism for test_rss_context_overlap. This gives the test
> more attempts to distribute the flow evenly, as the chance of
> flow skewing to one queue is high.
> 
> Example failures:
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: rss_ctx: Add retries to test_rss_context_overlap to reduce flakes
    https://git.kernel.org/netdev/net-next/c/fe3e786ef4eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



