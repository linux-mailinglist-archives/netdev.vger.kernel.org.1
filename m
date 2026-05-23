Return-Path: <netdev+bounces-290962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHcSFgruEGrtfgYAu9opvQ
	(envelope-from <netdev+bounces-290962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:00:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C288E5BBA3F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 508D3300C253
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79533386C3D;
	Sat, 23 May 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb3vHgy6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ACF25C6EE;
	Sat, 23 May 2026 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779494407; cv=none; b=ZmV4HdI7Vh/gCejMGFccBcqlxjrMhjiWPfmxSSaJt5Kfr2b59M0s+f/sc7EhHVJpEwMCLBd0UaoI/TnI80mtO25Men4jlzEJs3vaqaYOvuZ/wQgGoyNl2HKWoibIM0P7ClA3W0+bTqnKGkI93CsumjkuxUEIb9eKNCrKrmC1KDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779494407; c=relaxed/simple;
	bh=+3d6NnHf+JDzPKoTTk/N+qRiVqTG8EzBQD+nzDwP/+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mpAurWZyvdat48RF0S3X2apEVxcBCDWjCqiAgfzn/uqZDuIXv4Ok6dBJopJCvBfOL8hpuXY+ydA8NXRdXYwLlFUwdDhKFQx5QtNuLmD/NxutaYL/Fo6NBisTrK+q+HDKo6ko7Tvu6WlRNVySe30+jW0FIld9HzBgMLrp5fJMIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb3vHgy6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B441F000E9;
	Sat, 23 May 2026 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779494406;
	bh=bpmpAYczKBe9hq5fAkkEH6ceIN/fAUQBXb4meLPIXWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hb3vHgy6/0TpVEWO4fVhROLlZriM8hrglohvolibM1Sk9hx0OGc+Mq+FN222PeE9N
	 arOcktpkAiTkExuu6oS0UCcWTxbYJfXQRpvnAzPOBoiNPiLUdE/HOytq996m6MT2v+
	 K+l8ECldenMkGGCSXKRzagp/8zBQyFuksUM96+wIK/XA+lxEwVaWyfrWexJR0r3Lkh
	 vwMYr1TowfRcxzhrpPzpUhm69P4bIrgqL2hyJEgbUlB6Eeu5iLsMrPLhz6o8tbQf1c
	 RGRUwehUxp3CyefSB/N0NEcNDnKBAa6u1hJsH43lffwjSsBYvr13WXcOeKBF3T2nXc
	 tO2kXFw+HrzCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1973E393100F;
	Sat, 23 May 2026 00:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: tls: use ASSERT_GE in test_mutliproc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177949441473.1413978.6684869738388512890.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 00:00:14 +0000
References: 
 <0ee9f412b6bd1a260a547d19f979f73b396746ac.1779354585.git.tanggeliang@kylinos.cn>
In-Reply-To: 
 <0ee9f412b6bd1a260a547d19f979f73b396746ac.1779354585.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, tanggeliang@kylinos.cn,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290962-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,kylinos.cn,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C288E5BBA3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 17:11:53 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In test_mutliproc(), when send() or recv() returns an error (e.g.,
> -1), the test continues to execute the remaining code and fails
> repeatedly due to using EXPECT_GE.
> 
> For example, if a TLS connection is broken and recv() returns -1,
> EXPECT_GE(res, 0) records a failure but does not stop the test.
> The test then proceeds with left -= res (where res = -1), causing
> left to increase unexpectedly, and the loop continues indefinitely.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: tls: use ASSERT_GE in test_mutliproc
    https://git.kernel.org/netdev/net-next/c/6ec863c18481

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



