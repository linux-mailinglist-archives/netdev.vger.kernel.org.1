Return-Path: <netdev+bounces-290983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGF1HcH3EGoxgAYAu9opvQ
	(envelope-from <netdev+bounces-290983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:41:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5E5BC1F3
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6AFB301DAFB
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03101218821;
	Sat, 23 May 2026 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzUY5v5W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18746215F42
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496822; cv=none; b=aMgRSljvWNFQsO0ixPRRu1a4hxlyqVfIk0gjpZ+/7AFWSXh1ZsGkXVHQO9QGFkyqMgigSKAdQ7X4hY85AjiBSJyKnxlGM+0eC4RjE1QgAx+nRaxHnuYhQcnud9r/tvlDMUNR3YucDs3///mLmBTzh6diHELG3jbhC4ShiBzdgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496822; c=relaxed/simple;
	bh=yanYS7C8kLtqVYKZMPt2gclRurlWIs8CX9WBJkj/JzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DgDEZwGiGqXdRS68vIahCIzQHLpkKV7uPq0k8arIhx64CG79d9XPMBjbM/DbO1/zR4oPX/2lUOYrP4A14too6eLkAXs17zNivsGgjgAASCxiW6K0o4VK71JJB/AR7E9cniUsNwk7eg56MHo6WwmE/Gs7k9TsH5wR3M9BkIv6I5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzUY5v5W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028C11F000E9;
	Sat, 23 May 2026 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496820;
	bh=sw/CQQRDAny356XfXOpc/NaO4Nwr9ZGfWgzjdjiDNRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OzUY5v5W6xN5qS43QX5eEpld8gwq0+n2L2hVHqZoaR/PEZg4d716iQBDCMKcwF3gp
	 w7avetFaI0tV1RMB2qiJL3Elxp7nYNaUXFKDU8tiKabo8j71ydU0gPvEc0imRAvodI
	 VB/ikfzo73ndvzipy3Z0zTY1Ey87K8mNr8gUfPPNJBHPszoOXiqtsAvV3Nir6Rmlhy
	 DVguwBoJSD+K24VFqyGQbqvYpL9imaSaW34HftXYUJTdajnuI75BpkQPrpOsuu+4Cc
	 yaqHzbPrp/xSbRXjqAML2bG2eSsFLa5ABGCZ4Fg9xg2EWg7TnsPw1l2RP5TA3AwQSa
	 /+wlf/J357QEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19785393100F;
	Sat, 23 May 2026 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dpll: change dpll_netdev_pin_handle_size() to
 assume
 DPLL_A_PIN_ID will be used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177949682863.1426243.2478472170496429722.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 00:40:28 +0000
References: <20260521171440.114956-1-edumazet@google.com>
In-Reply-To: <20260521171440.114956-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,linux.dev,intel.com,resnulli.us];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-290983-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D9B5E5BC1F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 17:14:39 +0000 you wrote:
> We plan to no longer hold RTNL in "ip link show", and use RCU instead.
> 
> Assume rtnl_fill_dpll_pin() will have to fill DPLL_A_PIN_ID.
> 
> It is fine to over-estimate skb size (by 8 bytes) in if_nlmsg_size().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] dpll: change dpll_netdev_pin_handle_size() to assume DPLL_A_PIN_ID will be used
    https://git.kernel.org/netdev/net-next/c/7409fad779e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



