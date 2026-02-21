Return-Path: <netdev+bounces-259799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lMjQDej+mGmIOwMAu9opvQ
	(envelope-from <netdev+bounces-259799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:40:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B67716B943
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC4E53003BEA
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8E2BD01B;
	Sat, 21 Feb 2026 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSjcu77c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF41C8E6
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634402; cv=none; b=fuVFfS1FcPOuf7WZfxXHMEIErjEM86uCJ6fHigrxTsWgdvEb8tWj0ibEW5s02RkyfOcZ4Dua4vR9lv1m0qDjYECMTcdgsVLMbybe1Fa+62jSx6YdutiNjAktha6sf4H7nl+gUu2tUy8VBREnI8+f8DZyXnDaXhtAzBTddCu4v+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634402; c=relaxed/simple;
	bh=jILuCOAO5tkXqH/6Ikt0exRNAhyZLnvj4ExEh4aN0OM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CogGmq3RtZUUo1jw6XnZgHTmKDnFszID0CoWUnE0D+pf0ChpPUBJIMChxRLUR4PZTUNflDEQYz2Ze57OiAPOLYz/iG4Yk+fWqBCadoq6BizIuXMojefhpacXJTljL7VYkvJ5GqAi+1/TFbiwQk32ce4LvNRVcbBO00qdvIu14yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSjcu77c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B94C116C6;
	Sat, 21 Feb 2026 00:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634402;
	bh=jILuCOAO5tkXqH/6Ikt0exRNAhyZLnvj4ExEh4aN0OM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kSjcu77cm18e3t8zHv98Bf/9FejKetgGolLOSusMRpALRxNqnnyhBeiAHLsLztyyO
	 rraUwUxN6jPHtWa4CyhmyBi4c6KjKpKgyWoVN8vRFJrWce0an94raBBV6WA9f6WS9a
	 zT2ZpN1BvsGmzAFbA/3lqxRt9oPe7R65MozVtgJZiB+AYaS5oYzRI62tv74wzSAqZE
	 hojmkUg6Q9CFRc12hRDkhBfXZ7X6njCeIPi7Q2tJzS8xvrZARrs10NcIlNH5upjuXa
	 9VL696a1FbJDYkVYpC/GrWkh4Q3MTeV6Rn8gjhXLhBYD7fNV9iGo6BdrFNftn8Kk4I
	 WqMfMREmNuCpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0F93808200;
	Sat, 21 Feb 2026 00:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] bnxt_en: Fix RSS context and ntuple filter
 issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177163441054.959452.15880291688247282292.git-patchwork-notify@kernel.org>
Date: Sat, 21 Feb 2026 00:40:10 +0000
References: <20260219185313.2682148-1-michael.chan@broadcom.com>
In-Reply-To: <20260219185313.2682148-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, horms@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259799-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B67716B943
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Feb 2026 10:53:10 -0800 you wrote:
> The first patch fixes the problem of ifup failing if one or more RSS
> contexts were previously created.  The 2nd patch fixes ntuple filter
> deletion errors in ifdown state.  The last patch adds self tests to
> cover these failure cases.
> 
> v4: Elimianted the original cleanup patch #2 from earlier versions.
> Simplified and improved the ntuple filter deletion fix (new patch #2).
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] bnxt_en: Fix RSS context delete logic
    https://git.kernel.org/netdev/net/c/e123d9302d22
  - [net,v4,2/3] bnxt_en: Fix deleting of Ntuple filters
    https://git.kernel.org/netdev/net/c/c1bbd9900d65
  - [net,v4,3/3] selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up
    https://git.kernel.org/netdev/net/c/ce5a0f4612db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



