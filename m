Return-Path: <netdev+bounces-258223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DC3GSBFjGlxkQAAu9opvQ
	(envelope-from <netdev+bounces-258223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:00:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCEC1227CB
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CBC0300E609
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CD3542D6;
	Wed, 11 Feb 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbgGugeD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAE353EDD;
	Wed, 11 Feb 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800410; cv=none; b=FXJEvOX3pWy8uYdrQGhrd50AWgC7X0ZUmQ/HpeKgd5UywWM1Ve3LMYubPraT953uBHXxYIbfIWOU0Thg/6QA4SfCX3ZiVlgNbfQiPbAj+TWFM9JaEcKA0AcrLH+fep6nDvRgpFpYxFF3eOZq4QGNhIPExcvi5bs0kbCBAJEEWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800410; c=relaxed/simple;
	bh=gA1b9e4jX7Y4bARntJUC7WwMJTFcoSE2le9h6BMg2bw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZOpmPbcg1teDn16M44k9rKJvu5qbSSKXntEqxvFEdQSR/lJTcRMXLeajucHqw9Z1Ey22XEg3kVJy1I9r5W96hyZXkNY1Z4l5tBPJUg5aBQE8r0SeE4B6d8rW6MtaCDfyRWsAgl3objXFkY02ZsM9AblmmYEpqeoHmit3u/CFkT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbgGugeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E641C4CEF7;
	Wed, 11 Feb 2026 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770800410;
	bh=gA1b9e4jX7Y4bARntJUC7WwMJTFcoSE2le9h6BMg2bw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbgGugeDuaMSjMMFZ4lvgN2BKW6T1vpMHYtVVI1+X2s/duy1n/1Oa3nQzYv0r4GjV
	 ou/RhS2/5F2u7H1/pyfTZCUIoyqhscApHzOKLONvrHBdicR0GqxX7d2s+rUdcDYen1
	 SgUhf7tbBRXBf865cJra0hVGxIcuGXrQKr2IV8SclJjZfY21Gcz1QfVCpjKKAxBBZ2
	 Wn4Nqzs+lla1eFV9VCCPxvUbup+7eo/v4oiXY8wDX7LHQidUn8rNkgPP6U7Lg7V+MO
	 RgVuQJ6Dj4BcTRZSdyIz+6IB/gqY7BXzSJ5iLrQ/mKeFg8wq1F5IPGYDGRkmPg0Exl
	 /6IoJCpbb7dhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8532A39E9603;
	Wed, 11 Feb 2026 09:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch] octeontx2-pf: Unregister devlink on probe failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177080040508.82572.13506849484849947975.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 09:00:05 +0000
References: <20260206182645.4032737-1-hkelam@marvell.com>
In-Reply-To: <20260206182645.4032737-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258223-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 8FCEC1227CB
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 6 Feb 2026 23:56:45 +0530 you wrote:
> When probe fails after devlink registration, the missing devlink unregister
> call causing a memory leak.
> 
> Fixes: 2da489432747 ("octeontx2-pf: devlink params support to set mcam entry count")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] octeontx2-pf: Unregister devlink on probe failure
    https://git.kernel.org/netdev/net/c/943f3b8bfbf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



