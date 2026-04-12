Return-Path: <netdev+bounces-277884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK6PH/z122lTJgkAu9opvQ
	(envelope-from <netdev+bounces-277884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:43:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A03E5C45
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 387CA3032CE9
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7A2F1FC7;
	Sun, 12 Apr 2026 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALTJSPXS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9D37D12F
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022851; cv=none; b=UQCGM5G0W1fydmWGUIz3VsR2jd3SI9QDkYGznhLpAv7+2XHDrcJMNqor0Ad4AowxD+QDuWlCSMF0thL9u08NzWzCDs2tDdVDpj9OnoNCSGqHSWglcWfo+B79ZyP6l4KfboQoEVV5HpBcgoVHHdp7Db+s1Uw4K4d5hSAsCc//Gzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022851; c=relaxed/simple;
	bh=GkJUMaRFGnU7UUJ0UdjxaTVdsR/cbPKg6QwHAJlMsws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MpOh1yhRikDCk+9V7iwxaMJ/nwSV+j++3WoZZEBPWZ3MyYCXf97K1kRRfV5R1P7rVkQDpD2zydf3GBKSlaYi9doZ8brUeUSiOGzZAkHZkKRmuJ/fb+GwdaLHcFRe179BmrbHuqg91PNKsuOrxmfGJWBi/3U839qnsfIBgkhhDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALTJSPXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9901DC19424;
	Sun, 12 Apr 2026 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776022850;
	bh=GkJUMaRFGnU7UUJ0UdjxaTVdsR/cbPKg6QwHAJlMsws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ALTJSPXSfum0c/GqCZcNscQLwh1s6wJfmI8zkB6pG+X93PK/QFOPvps2hGSqU0DYC
	 HpLM6HaTRoPkgPoKd4/zzEvdCab2wee3CIUddPEs3VZi7cJ5fZL9dFULQ5hSwCdWFb
	 00KAI6rpo0msjZXnv6TBWKML8XNsltT0909qFd6RItf2LR1O4sktzEMayICXslzPLn
	 Stm2HuV1LKPoocc35whTPvngTOauD2+VUpdvH9DjUArXgugU4hf7pTTBOy2V47+A6W
	 Kt07jNOn/ZgkwK71FWhGBEKQEdDKZpofZzRSLdyvBc5O2Wqm1fuyqj5EwjxaIBNyZS
	 6lN1t8qATG8ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE0A3809A8C;
	Sun, 12 Apr 2026 19:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gre: Count GRE packet drops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602282279.3388150.14087985131336115294.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 19:40:22 +0000
References: <20260409090945.1542440-1-gal@nvidia.com>
In-Reply-To: <20260409090945.1542440-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 dsahern@kernel.org, horms@kernel.org, dtatulea@nvidia.com, noren@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277884-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: D46A03E5C45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Apr 2026 12:09:45 +0300 you wrote:
> GRE is silently dropping packets without updating statistics.
> 
> In case of drop, increment rx_dropped counter to provide visibility into
> packet loss. For the case where no GRE protocol handler is registered,
> use rx_nohandler.
> 
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] gre: Count GRE packet drops
    https://git.kernel.org/netdev/net-next/c/8632175ccb0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



