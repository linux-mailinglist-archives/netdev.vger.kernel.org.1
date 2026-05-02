Return-Path: <netdev+bounces-283320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFSeCIpB9WluJwIAu9opvQ
	(envelope-from <netdev+bounces-283320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:12:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 928CD4B072C
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F5D303CC21
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48BD1A3166;
	Sat,  2 May 2026 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYv2uUsM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6B19E992
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680673; cv=none; b=ULFm4ry55WtI7MrCJ8+rOAyYBtWDWtAk+nTmqnqWJJSCQ1549KmjpPPkh1PiSxPj+giwhzwxcH9gyl5E8Qs9YrByqEXqB97e7AKL9tiW7zw1LsUoNOMMazwa3c2nfOBgyZ3FJjyvjWj+tfMNCfkIX354URsKOpm4a25c4J9rKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680673; c=relaxed/simple;
	bh=SilxGWJkKPQ3Z6XrfejYY+YB0Ppl8Jl7xsduoEQH53g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pD/6am9J3DHKqTthbMU45zb2BLKAcO4Yxgbhgbu7+GYPwvNyPgjLG4QgHRonKlbkUNAfnks+/F3PvrDBLINbsd65WV9e9Kl/x1BPWDvzs2PzNT5Jq7bWpADxPr5ONDG6VFPUf6ptmWcGn5g5RN/HvE6SlVdk2X2EM93XLIRc6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYv2uUsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD88C2BCB8;
	Sat,  2 May 2026 00:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777680673;
	bh=SilxGWJkKPQ3Z6XrfejYY+YB0Ppl8Jl7xsduoEQH53g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HYv2uUsMa2BksGniN7J/6cuYASKuHGcGyA4gnS3dCs/8zN2MHUVbrTDLxmIsg0X/y
	 ODaCcHzPt+mEVboZwugOQ9VF8JXmD2pYaZNAaBLJdQfK5DSaXwWHTZUeFAPcZQogBf
	 DYIrIx+F/lm0+mxOuObF0r8nJUs0llHN/TRSx5KxsJ2bgJWXkY2L8+ywHfHIlX7a42
	 qKsqxgvmaIQU1Ef3UozvTQvTRvM/0kiHq3brnn0LXF6OkfVsOyoJwkht0/OdcaNKLX
	 m/4ALnjwtfS0R0A/V2hM8/EvWe3w2oYYcPu6WYBDXorwznnACXgow43oZBcgPIGWcY
	 H+jN5n+h63O3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D58380CEF5;
	Sat,  2 May 2026 00:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: tls: reshuffle the device ops check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768062629.3667015.4621102122350844999.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 00:10:26 +0000
References: <20260429213001.1908235-1-kuba@kernel.org>
In-Reply-To: <20260429213001.1908235-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net
X-Rspamd-Queue-Id: 928CD4B072C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-283320-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 14:30:01 -0700 you wrote:
> We try to validate during registration that the netdev
> has ops if it has features. This is currently somewhat sillily
> written because we have a dereference before a NULL check
> on the ops struct. Straighten this out.
> 
> No functional change intended other than saving ourselves
> the very theoretical crash with a bad driver.
> 
> [...]

Here is the summary with links:
  - [net-next] net: tls: reshuffle the device ops check
    https://git.kernel.org/netdev/net-next/c/fa11b4048013

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



