Return-Path: <netdev+bounces-292481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BbmN1qIF2oCIQgAu9opvQ
	(envelope-from <netdev+bounces-292481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:12:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 433025EB2F3
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD50230E66EC
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB78800;
	Thu, 28 May 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGg2/Lbo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E2343892;
	Thu, 28 May 2026 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927006; cv=none; b=dCflYxiD3UZDu0dP4FQpwAFJn0PCPXkwuGJM5WAz+JSFfirExDkNRgMCf+qThLMrMEBdV6EuJP1cM8oBEmdNU2aOIhATaYeQq6hQbflgCLAen+i6IiPWFEkZY0WmThHflx7/2ZWlJj6ZCCXKSMEPX+FWpldfBMnlx0ZUAslEgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927006; c=relaxed/simple;
	bh=JgDVrnxlGCc7g0ZIXcAMiSF5dAF/XyAFSYO6TVPbmqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ngCwvVkRIgt4+2Nilz5pdU0COGbI0swd9aIOmiVKmVCLCSGrpbrAYFDbsjOvwXwDmu3io2fnpJ5pMh22JMC5TKwAcYNMbd3Ez1Mue6kaiqB4+yFurcQB7ByyuDN5J3E8RH2570bSk/XjOqdKKl06MEW/jFRuga95tMJVptLpupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGg2/Lbo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E231F000E9;
	Thu, 28 May 2026 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779927005;
	bh=dznYSxQfwFPq6r4cE7d3bMfErOR2gMlBNVXrX83K+jI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DGg2/Lbo+A26H8OAIbNbBOChCQ8rLkx1YxPISYNPaLA4y1V5okVduGqJ4fPkUDFRa
	 1cBRaUs41D+Ingb0/7VoU6gsh22j/jdoxIP4/DvY0c+/Fduww50ZB/tIOQNCHFXXVm
	 q/9hyx41JiVZutZLf/p3kWPzwQ6Dq6aZx48E2Xlq9oUu4xW1UZLAiY1NsbDpJJ5wfG
	 bUHwWZU3dy+hQv+s5houy2G3/xV7/iPtxQKheyi3WOt1oKIb3jKxPPQrxDQI3QRFmd
	 FCWOPSBqr/YC66Pqj2OkSMjcM7MN/DTy/q3jszd80DYaZbZcHtzT+nKRNGjMcComNh
	 ObqJocTulnXUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93DAB380CFDE;
	Thu, 28 May 2026 00:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/dns_resolver: consolidate namelen checks in
 dns_query
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177992701014.690389.16407759758490531821.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 00:10:10 +0000
References: <20260525095400.821912-3-thorsten.blum@linux.dev>
In-Reply-To: <20260525095400.821912-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, amir73il@gmail.com, tim.bird@sony.com,
 brauner@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292481-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,sony.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 433025EB2F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 11:54:01 +0200 you wrote:
> Consolidate the namelen checks and return -EINVAL early if needed. Drop
> the namelen == 0 check since it is covered by namelen < 3.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/dns_resolver/dns_query.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net/dns_resolver: consolidate namelen checks in dns_query
    https://git.kernel.org/netdev/net-next/c/f289c0664f64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



